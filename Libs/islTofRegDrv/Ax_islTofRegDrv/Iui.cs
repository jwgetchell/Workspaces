namespace Ax_islTofRegDrv
{
    unsafe public partial interface Iui
    {
        void setIRDR(double irdr);
        double getIRDR();

        void calibrateMagnitude();
        void calibrateXtalk();
        void calibrate20cm();

        int getAFEgain();
        void setAFEgain(int gain);

        void setPeriodDutyCycle(double period, double dutyCycle);
        double getPeriod();
        double getDutyCycle();
        void setReferencePhaseOffset(double degrees);
        void setReferenceFrequency(int freqIndex);
        void setAdcIQcalVals(double qGainPer, double iOffset, double qOffset);
        void getAdcIQ(double* Iadc, double* Qadc);
        void getXtalkIQ(double* IxTalk, double* QxTalk);
        double getDistance();
        double getMagnitude();
    }
}
