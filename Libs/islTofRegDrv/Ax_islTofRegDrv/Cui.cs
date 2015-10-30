using System;

namespace Ax_islTofRegDrv
{

    unsafe public partial class Cui : Iui
    {
        // constants
        private const double irdrFSR    =                250; // ma
        private const double periodLSB =                0.45; // ms
        private const double oscFreq =                  57.6; // MHz
        private const double intTimeLSB = 4096.0 / oscFreq / 1000.0; // ms
        private const double cmMHzPerLSB = 100 * 3e8 / 1e6 / 2 / 65535; // cm*MHz/LSB
        private const double magRegLSB = 200.0 / 65536.0/65536.0; // uA/LSB

        private enum refFreq // values from bf_sel (0xAB)
        {
            _3_3=3,
            _3_6=2,
            _4_1=1,
            _4_5=0,
        }

        private Cprim prim;
        private double rfFreq;
        private int refFreqIdx;
        private double qAdcGainAdjPer;
        private double iAdcOffset;
        private double qAdcOffset;
        private int[] refFreqPhaseCode;
        private int afeGain;


        public Cui(Iprim _prim)
        {
            prim = (Cprim)_prim;
            rfFreq = 4.5;
            refFreqIdx = 0;
            qAdcGainAdjPer = 0;
            iAdcOffset = 0;
            qAdcOffset = 0;
            refFreqPhaseCode = new int[4];
            refFreqPhaseCode[0] = 63; //4.5
            refFreqPhaseCode[1] = 12; //4.1
            refFreqPhaseCode[2] =  9; //3.6
            refFreqPhaseCode[3] = 13; //3.3
            afeGain = 1;
        }

        private double sgnBin2dbl(int word,int msb)
        {
            double retVal = (word >> msb) & 1;
            int mask = ((1 << msb) - 1);

            word &= ((1 << msb) - 1);

            if (retVal == 1) // msb=1
            {
                retVal = -(double) word / mask;
            }
            else
            {
                retVal = (double) word / mask;
            }

            return retVal;
        }
        private int dbl2sgnBin(double value, int msb)
        {
            int retVal = 0;
            int mask = ((1 << msb) - 1);

            if (value > 1)// limit to +/- 1
            {
                value = 1;
            }
            else
            {
                if (value < -1)
                    value = -1;
            }

            if (value >= 0)
                retVal = (int)(value * mask);
            else
                retVal = (int)(-value * mask) | (1 << msb);

            return retVal;
        }

        public void setIRDR(double irdr)
        {
            // irdr: ma
            int range = 0, dac = 0;

            range = (int)(15 * irdr / irdrFSR);
            if (range > 15) range = 15;

            dac = (int)(255 * irdr / (irdrFSR*range/15));
            if (range > 255) range = 255;

            prim.analogControl.setDriver_s(range);
            prim.analogControl.setEmitter_current(dac);
        }
        public double getIRDR()
        {
            int range = 0, dac = 0;
            double irdr = 0;

            range = prim.analogControl.getDriver_s();
            dac = prim.analogControl.getEmitter_current();

            irdr = irdrFSR * range/15 * dac/255;

            return irdr;
        }

        public void calibrateMagnitude()
        {
            //      R0x[F6:F8]  --> R0x[2C:2E]
            //calibrationStatus --> closedLoopCalibration

            int exp = 0, mantisa = 0,i=0,j=0;
            double magnitude = 0,aMag=0,absMag=0;

            prim.samplingControl.setLight_en(0);
            prim.samplingControl.setDc_cal_en(1);
            prim.samplingControl.setZp_cal_en(1);

            prim.interrupt.setInterrupt_ctrl(1);// interrupt when dataReady

            for (i=0;i<10;i++)
            {
                for (j = 0; j < 10; j++)
                {
                    if (1 == prim.interrupt.getData_ready())
                        break;
                }

                exp = prim.calibrationStatus.getZp_mag_exp();
                mantisa = prim.calibrationStatus.getZp_mag();

                //magnitude = Math.Pow(2.0,exp-16) * mantisa;
                magnitude = mantisa/65535.0 * (1 << exp);
                aMag+=magnitude;
            }
            aMag/=i;

            absMag = aMag; if (absMag < 1) absMag *= -1;// absolute value

            exp = 0;
            if (absMag > 1)
            {
                do
                {
                    exp += 1; absMag /= 2;
                } while (absMag > 1);
            }
            else
            {
                do
                {
                    exp -= 1; absMag *= 2;
                } while (absMag < 1);
                exp += 1; absMag /= 2;
            }
            if (aMag < 1)
                aMag = -absMag;
            else
                aMag = absMag;

            mantisa = (int)(65535.0*aMag);

            //exp=(int)(Math.Log(aMag)/Math.Log(2.0)+.5);
            //mantisa=(int)(65536*aMag/Math.Pow(2.0,exp)+.5);

            prim.closedLoopCalibration.setMag_ref_exp(exp);
            prim.closedLoopCalibration.setMag_ref(mantisa);

            prim.samplingControl.setLight_en(1);
        }
        public void calibrateXtalk()
        {
            //  R0x[DA:DF,E6:E7] --> R0x[24:2B]
            // lightSampleStatus --> closedLoopCalibration

            int[] exp;                exp = new int[2];
            int[] mantisa;        mantisa = new int[3];
            double[] magnitude; magnitude = new double[3];
            double[] aMag; ;         aMag = new double[3];
            int i = 0, j = 0;

            // zero values.
            prim.closedLoopCalibration.setGain_xtalk(0);
            prim.closedLoopCalibration.setI_xtalk_exp(0);
            prim.closedLoopCalibration.setI_xtalk(0);
            prim.closedLoopCalibration.setQ_xtalk_exp(0);
            prim.closedLoopCalibration.setQ_xtalk(0);

            prim.interrupt.setInterrupt_ctrl(1);// interrupt when dataReady

            for (i = 0; i < 100; i++) // measure/sum results
            {
                for (j = 0; j < 10; j++)
                {
                    if (1 == prim.interrupt.getData_ready())
                        break;
                }
                exp[0] = prim.lightSampleStatus.getI_raw_exp();
                mantisa[0] = prim.lightSampleStatus.getI_raw();

                exp[1] = prim.lightSampleStatus.getQ_raw_exp();
                mantisa[1] = prim.lightSampleStatus.getQ_raw();

                mantisa[2] = prim.lightSampleStatus.getGain();

                magnitude[0] = (mantisa[0] << exp[0]) / 65535.0;
                aMag[0] += magnitude[0];

                magnitude[1] = (mantisa[1] << exp[1]) / 65535.0;
                aMag[1] += magnitude[1];

                aMag[2] += mantisa[2];
            }
            for (j=0;j<3;j++) // sum --> average
                aMag[j] /= i;

            for (j = 0; j < 2; j++) // real --> integer
            {
                exp[j] = (int)(Math.Log(aMag[j]) / Math.Log(2.0) + .5);
                mantisa[j] = (int)(65536 * aMag[j] / Math.Pow(2.0, exp[j]) + .5);
            }
            mantisa[2] = (int)aMag[2];

            // write results
            prim.closedLoopCalibration.setI_xtalk_exp(exp[0]);
            prim.closedLoopCalibration.setI_xtalk(mantisa[0]);
            prim.closedLoopCalibration.setQ_xtalk_exp(exp[1]);
            prim.closedLoopCalibration.setQ_xtalk(mantisa[1]);
            prim.closedLoopCalibration.setGain_xtalk(mantisa[2]);
        }
        public void calibrate20cm()
        {
            //  R0x[D8:D9] --> R0x[2F:30]
            // lightSampleStatus --> closedLoopCalibration

            int i = 0, j = 0, iPhase = 0;
            double phase=0;

            prim.closedLoopCalibration.setPhase_offset(0); // zero 1st


            prim.interrupt.setInterrupt_ctrl(1);// interrupt when dataReady

            for (i = 0; i < 100; i++) // measure/sum results
            {
                for (j = 0; j < 10; j++)
                {
                    if (1 == prim.interrupt.getData_ready())
                        break;
                }
                iPhase = prim.lightSampleStatus.getPhase();
                if (iPhase > 0x8000)
                    iPhase = iPhase - 0xFFFF;
                phase += iPhase;
            }
            phase /= i;
            phase -= 20.0 * rfFreq / cmMHzPerLSB;
            //phase -= 20.0 * 4.5 / cmMHzPerLSB;
            if (phase < 0)
                phase += 65535.0;
            iPhase = (int)phase;
            prim.closedLoopCalibration.setPhase_offset(iPhase);


            for (i = 0; i < 500; i++) // servo
            {
                for (j = 0; j < 10; j++)
                {
                    if (1 == prim.interrupt.getData_ready())
                        break;
                }
                phase=getDistance();
                if (phase > 20)
                {
                    iPhase += 1;
                }
                else
                {
                    iPhase -= 1;
                }
                prim.closedLoopCalibration.setPhase_offset(iPhase);
                prim.interrupt.getData_ready();// clear ready
            }
        }

        public int getAFEgain()
        {
            int tia = prim.analogControl.getLna_gain();// is tia
            int lna = prim.analogControl.getAfe_gain();// is lna
            afeGain = (1 << lna) * (1 + 2 * tia);
            return afeGain;
        }
        public void setAFEgain(int gain)
        {
            if (gain >= 12)
            {
                prim.analogControl.setAfe_gain(2);// is lna
                prim.analogControl.setLna_gain(1);// is tia
                afeGain = 12;
            }
            else
            {
                if (gain >= 6)
                {
                    prim.analogControl.setAfe_gain(1);
                    prim.analogControl.setLna_gain(1);
                    afeGain = 6;
                }
                else
                {
                    if (gain >= 3)
                    {
                        prim.analogControl.setAfe_gain(0);
                        prim.analogControl.setLna_gain(1);
                        afeGain = 3;
                    }
                    else
                    {
                        prim.analogControl.setAfe_gain(0);
                        prim.analogControl.setLna_gain(0);
                        afeGain = 1;
                    }
                }
            }
        }

        public void setAdcIQcalVals(double qGainPer, double iOffset, double qOffset)
        {
            qAdcGainAdjPer = qGainPer;
            iAdcOffset = iOffset;
            qAdcOffset = qOffset;
        }

        public void setPeriodDutyCycle(double period, double dutyCycle)
        {
            // period:    ms
            // dutyCycle: percent
            // periodLSB <= period <= 2048*periodLSB
            if (period > 2048 * periodLSB)
            {
                period = 2048 * periodLSB;
            }
            else
            {
                if (period < periodLSB)
                    period = periodLSB;
            }

            // dutyCycle <= 100%
            if (dutyCycle > 100)
                dutyCycle = 100;

            double intTime = period * dutyCycle / 100.0; // convert to integration time

            // intTimeLSB <= intTime  <= 2048 * intTimeLSB
            if (intTime > 2048 * intTimeLSB)
            {
                intTime = 2048 * intTimeLSB;
            }
            else
            {
                if (intTime < intTimeLSB)
                    intTime = intTimeLSB;
            }

            int sample_len = 0;
            for (sample_len = 11; sample_len > 0; sample_len--)
            {
                if ( intTime > intTimeLSB * ( 1 << sample_len ) )
                    break;
            }

            // 1 <= sample_period  <= 2048
            int sample_period = (int)(period / periodLSB), sample_skip;
            for (sample_skip=0;sample_skip<4;sample_skip++)
            {
                if (sample_period <= 2048)
                {
                    break;
                }
                else
                {
                    sample_period >>= 1;
                }
            }
            sample_period -= 1;

            prim.samplingControl.setSample_skip(sample_skip);
            prim.samplingControl.setSample_period(sample_period);
            prim.samplingControl.setSample_len(sample_len);
        }
        public double getPeriod()
        {
            int sample_period, sample_skip;

            sample_skip=prim.samplingControl.getSample_skip();
            sample_period=prim.samplingControl.getSample_period();

            sample_period += 1;

            double period = periodLSB*(sample_period << sample_skip);

            return period;
        }
        public double getDutyCycle()
        {
            double period = getPeriod();
            int sample_len=prim.samplingControl.getSample_len();
            double dutyCycle = 100.0 * (1 << sample_len) * intTimeLSB / period;

            return dutyCycle;
        }
        public void setReferencePhaseOffset(double degrees)
        {
            int nco_phase_id = 0;

            degrees *= -1.0;

            while (degrees < 0.0)
                degrees += 360.0;

            nco_phase_id = (int)(64.0 * degrees / 360.0);

            nco_phase_id += refFreqPhaseCode[refFreqIdx];

            while (nco_phase_id > 63)
                nco_phase_id -= 64;

            prim.dft.setNco_phase_id(nco_phase_id << 0);
        }
        public void setReferenceFrequency(int freqIndex)
        {
            // default = 4.5 (0)
            // ideal =   3.6 (2)
            int nco_phase_in; // nco frequency

            switch(freqIndex)
            {
                case (int)refFreq._3_3: rfFreq = 3.3; break;
                case (int)refFreq._3_6: rfFreq = 3.6; break; // ideal (divider is 128)
                case (int)refFreq._4_1: rfFreq = 4.1; break; 
                case (int)refFreq._4_5: rfFreq = 4.5; break; // default
                default: return; // exit on illegal value
            }
            refFreqIdx = freqIndex;
            prim.analogControl.setBf_sel(refFreqIdx);
            nco_phase_in = (int)(rfFreq / oscFreq * 2048.0);
            prim.dft.setNco_phase_id(nco_phase_in);
        }

        public void getAdcIQ(double* Iadc, double* Qadc)
        {
            int iAdc, qAdc;

            iAdc = prim.lightSampleStatus.getI_adc();
            qAdc = prim.lightSampleStatus.getQ_adc();

            // IQ ADCs are offset binary
            *Iadc = (2.0 * (iAdc) / 32767.0 - 1.0);
            *Qadc = (2.0 * (qAdc) / 32767.0 - 1.0);

            // calibration correction
            *Iadc -= iAdcOffset;
            *Qadc = *Qadc * (1.0 + qAdcGainAdjPer) - qAdcOffset;
        }
        public void getXtalkIQ(double* IxTalk, double* QxTalk)
        {
            int exp, mantissa;

            exp = prim.closedLoopCalibration.getI_xtalk_exp();
            mantissa = prim.closedLoopCalibration.getI_xtalk();

            *IxTalk = mantissa * Math.Pow(2,exp);

            exp = prim.closedLoopCalibration.getQ_xtalk_exp();
            mantissa = prim.closedLoopCalibration.getQ_xtalk();

            *QxTalk = mantissa * Math.Pow(2, exp);
        }

        public double getDistance()
        {
            double distance=0;

            distance = prim.lightSampleStatus.getDistance();
            //distance *= (cmMHzPerLSB / rfFreq);
            distance *= (cmMHzPerLSB / 4.5);
            return distance;
        }
        public double getMagnitude()
        {
            double magnitude=0;
            int exp, mant;

            exp = prim.lightSampleStatus.getMag_exp();
            mant = prim.lightSampleStatus.getMag();

            magnitude = magRegLSB * mant * (1 << exp);

            return magnitude;

        }
    }

}
