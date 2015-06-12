#include "registers.h"
#include "alsPrxI2cIo.h"

class CregDef
{
public:
	static const long DeviceID                       =0x00;// statusRegisters
	static const long MasterControl                  =0x01;
	static const long StatusRegisters                =0x02;
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
                                                             
	static const long IntegrationTime                =0x10;// samplingControlRegisters
	static const long SamplePeriod                   =0x11;
	static const long SamplePeriodRange              =0x12;
	static const long SampleControl                  =0x13;
	static const long DCCalIntegrationTime           =0x14;
	static const long ZPCalIntegrationTime           =0x15;
	static const long CollisionIntegrationTime       =0x16;
	static const long AGCControl1                    =0x17;// algorithmControlRegisters
	static const long AGCControl2                    =0x18;
	static const long AGCControl3                    =0x19;
	static const long DSPEnable                      =0x1A;
	static const long DCSaturationThreshold          =0x1B;// signalIntegrityRegisters
	static const long NoiseThresholdOffset           =0x1C;
	static const long NoiseThresholdSlope            =0x1D;
	static const long MagnitudeSquelchExponent       =0x1E;
	static const long MagnitudeSquelch               =0x1F;
	static const long CircuitNoise                   =0x20;
	static const long NoiseGain                      =0x21;
	static const long FixedError                     =0x22;
	static const long CollisionPeakSelect            =0x23;
	static const long CrosstalkIExponent             =0x24;// closedLoopCalibrationRegisters
	static const long CrosstalkIMSB                  =0x25;
	static const long CrosstalkILSB                  =0x26;
	static const long CrosstalkQExponent             =0x27;
	static const long CrosstalkQMSB                  =0x28;
	static const long CrosstalkQLSB                  =0x29;
	static const long CrosstalkGainMSB               =0x2A;
	static const long CrosstalkGainLSB               =0x2B;
	static const long MagnitudeReferenceExp          =0x2C;
	static const long MagnitudeReferenceMSB          =0x2D;
	static const long MagnitudeReferenceLSB          =0x2E;
	static const long PhaseOffsetMSB                 =0x2F;
	static const long PhaseOffsetLSB                 =0x30;
	static const long TemperatureReference           =0x31;// openLoopCorrectionRegisters
	static const long EmitterReference               =0x32;
	static const long PhaseExponent                  =0x33;//
	static const long PhaseOffsetTempCo1             =0x34;
	static const long PhaseOffsetEmitterCo1          =0x35;
	static const long PhaseOffsetAmbientCo1          =0x36;//
	static const long PhaseOffsetVGA1Co1             =0x37;
	static const long PhaseOffsetVGA2Co1             =0x38;
	static const long PhaseOffsetTempCo2             =0x39;
	static const long PhaseOffsetEmitterCo2          =0x3A;
	static const long PhaseOffsetAmbientCo2          =0x3B;//
	static const long PhaseOffsetVGA1Co2             =0x3C;
	static const long PhaseOffsetVGA2Co2             =0x3D;
	static const long CrosstalkITempCo1              =0x3E;
	static const long CrosstalkIEmitterCo1           =0x3F;
	
	// ====================================================
	
	static const long CrosstalkIAmbientCo1           =0x40;
	static const long CrosstalkIVGA1Co1              =0x41;
	static const long CrosstalkIVGA2Co1              =0x42;
    static const long CrosstalkITempCo2              =0x43;
    static const long CrosstalkIEmitterCo2           =0x44;
    static const long CrosstalkIAmbientCo2           =0x45;
    static const long CrosstalkIVGA1Co2              =0x46;
    static const long CrosstalkIVGA2Co2              =0x47;
    static const long CrosstalkQTempCo1              =0x48;
    static const long CrosstalkQEmitterCo1           =0x49;
    static const long CrosstalkQAmbientCo1           =0x4A;
    static const long CrosstalkQVGA1Co1              =0x4B;
    static const long CrosstalkQVGA2Co1              =0x4C;
    static const long CrosstalkQTempCo2              =0x4D;
    static const long CrosstalkQEmitterCo2           =0x4E;
    static const long CrosstalkQAmbientCo2           =0x4F;
	static const long CrosstalkQVGA1Co2              =0x50;
	static const long CrosstalkQVGA2Co2              =0x51;
	static const long EmitterSelectforOpenLoop       =0x52;
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	static const long InterruptControl               =0x60;// interruptRegisters
	static const long DataInvalidMask                =0x61;
	static const long DetectionControl               =0x62;
	static const long DetectionCondition1            =0x63;
	static const long DetectionCondition2            =0x64;
	static const long ReferenceDistanceforMotionMSB  =0x65;
	static const long ReferenceDistanceforMotionLSB  =0x66;
	static const long ReferenceMagnitudeExponent     =0x67;
	static const long ReferenceMagnitudeSignificand  =0x68;
	static const long InterruptFlag                  =0x69;
	static const long DetectionFlag                  =0x6A;
	static const long DetectionFlagReference         =0x6B;
	                                                      
	                                                      
	                                                      
	                                                      
	static const long Zone1ThresholdHighMSB          =0x70;// detectionModeControlRegisters
	static const long Zone1ThresholdHighLSB          =0x71;
	static const long Zone1ThresholdLowMSB           =0x72;
	static const long Zone1ThresholdLowLSB           =0x73;
	static const long Zone2ThresholdHighMSB          =0x74;
	static const long Zone2ThresholdHighLSB          =0x75;
	static const long Zone2ThresholdLowMSB           =0x76;
	static const long Zone2ThresholdLowLSB           =0x77;
	static const long Znee3ThresholdHighMSB          =0x78;
	static const long Zone3ThresholdHighLSB          =0x79;
	static const long Zone3ThresholdLowMSB           =0x7A;
	static const long Zone3ThresholdLowLSB           =0x7B;
	static const long MagnitudeThreshold1HighExponent=0x7C;
	static const long MagnitudeThreshold1High        =0x7D;
	static const long MagnitudeThreshold2LowExponent =0x7E;
	static const long MagnitudeThreshold2Low         =0x7F;
	
	// ====================================================
	
	static const long MagnitudeThreshold2HighExponent=0x80;
	static const long MagnitudeThreshold2High        =0x81;
	static const long MagnitudeThreshold3LowExponent =0x82;
    static const long MagnitudeThreshold3Low         =0x83;
    static const long MotionDistanceThresholdMSB     =0x84;
    static const long MotionDistanceThresholdLSB     =0x85;
    static const long MotionMagnitudeThreshold       =0x86;
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
                                                              
	static const long DriverRange                    =0x90;// analogControlRegisters
	static const long EmitterCurrentDAC              =0x91;
	static const long DriverControl                  =0x92;
	static const long ThresholdCurrentDAC            =0x93;
	static const long DriverBoost                    =0x94;
	static const long DriverBoostDuration            =0x95;
	static const long DriverChargeBalancingDAC       =0x96;
	static const long FrontendControl                =0x97;
	static const long AFEControlRegisters            =0x98;
	static const long AmbientADCTestFeatures         =0x99;
	static const long VGAOffsetCode                  =0x9A;
	static const long VGA1ManualforLight             =0x9B;
	static const long VGA2ManualforLight             =0x9C;
	static const long VGA1ManualforZP                =0x9D;
	static const long VGA2ManualforZP                =0x9E;
	static const long VGA1ControlforCollision        =0x9F;
	static const long VGA2ControlforCollision        =0xA0;
	static const long ADCVrefCode                    =0xA1;
	static const long PeakDetectorThresholdsA        =0xA2;
	static const long PeakDetectorThresholdsB        =0xA3;
	static const long PeakDetectorThresholdsC        =0xA4;
	static const long EmitterVoltageADCOffset        =0xA5;
	static const long EmitterVoltageADCMuxSelect     =0xA6;
	static const long TempSensorRegA                 =0xA7;
	static const long TempSensorRegB                 =0xA8;
	static const long TempSensorRegC                 =0xA9;
	static const long TempSensorADCMode              =0xAA;
	static const long BPFSelect                      =0xAB;
	static const long OscillatorAAFOffset            =0xAC;
	static const long OscillatorSelect               =0xAD;
	static const long InternalRSET                   =0xAE;
	static const long Spares                         =0xAF;
	static const long Command                        =0xB0;// DFTregisters
	static const long I2CFast                        =0xB1;
	static const long RivisionID                     =0xB2;
	static const long BlockOverrideA                 =0xB3;
	static const long BlockOverrideB                 =0xB4;
	static const long StateMachineControl            =0xB5;
	static const long StateMachineOverride           =0xB6;
	static const long StateMachineOverride1          =0xB7;
	static const long AnalogMonitorControl           =0xB8;
	static const long NCOControl1                    =0xB9;
	static const long NCOControl2                    =0xBA;
	static const long NCOControl3                    =0xBB;
	                                                      
	                                                      
	                                                      
	                                                      
	                                                      
	// ====================================================
	                                                      
	static const long FuseOperation                  =0xC0;// fuseRegisters
	static const long Fusereg1                       =0xC1;
	static const long Fuse_reg2                      =0xC2;
    static const long Fusereg3                       =0xC3;
    static const long Fusereg4                       =0xC4;
    static const long testreg1                       =0xC5;// digitalTestReg
    static const long testreg2                       =0xC6;
    static const long testreg3                       =0xC7;
    static const long testreg4                       =0xC8;
    static const long testmux                        =0xC9;
    static const long testsample                     =0xCA;
    static const long testreadsanple                 =0xCB;
    static const long testtrim1                      =0xCC;
    static const long testtrim2                      =0xCD;
    static const long testtrim3                      =0xCE;
    static const long testtrim4                      =0xCF;
	static const long DataInvalid                    =0xD0;// lightSampleStatusRegisters
	static const long DistanceReadoutMSB             =0xD1;
	static const long DistanceReadoutLSB             =0xD2;
	static const long PrecisionMSB                   =0xD3;
	static const long PercisionLSB                   =0xD4;
	static const long MagnitudeExponent              =0xD5;
	static const long MagnitudeSignificandMSB        =0xD6;
	static const long MagnitudeSignificandLSB        =0xD7;
	static const long PhaseReadoutMSB                =0xD8;
	static const long PhaseReadoutLSB                =0xD9;
	static const long IRawExponent                   =0xDA;
	static const long IRawMSB                        =0xDB;
	static const long IRawLSB                        =0xDC;
	static const long QRawExponent                   =0xDD;
	static const long QRawMSB                        =0xDE;
	static const long QRawLSB                        =0xDF;
	static const long EmitterVoltageBefore           =0xE0;
	static const long EmitterVoltageAfter            =0xE1;
	static const long AFETemperature                 =0xE2;
	static const long AmbientADC                     =0xE3;
	static const long VGA1                           =0xE4;
	static const long VGA2                           =0xE5;
	static const long GainMSB                        =0xE6;
	static const long GainLSB                        =0xE7;
	static const long IADCMSB                        =0xE8;
	static const long IADCLSB                        =0xE9;
	static const long QADCMSB                        =0xEA;
	static const long QADCLSB                        =0xEB;
	static const long DCCalibrationIMSB              =0xEC;// calibrationStatusRegisters
	static const long DCCalibrationILSB              =0xED;
	static const long DCCalibrationQMSB              =0xEE;
	static const long DCCalibrationQLSB              =0xEF;
	static const long ZPCalibrationIMSB              =0xF0;
	static const long ZPCalibrationILSB              =0xF1;
	static const long ZPCalibrationQMSB              =0xF2;
	static const long ZPCalibrationQLSB              =0xF3;
	static const long ZeroPhaseMSB                   =0xF4;
	static const long ZeroPhaseLSB                   =0xF5;
	static const long ZPMagnitudeExp                 =0xF6;
	static const long ZPMagnitudeMSB                 =0xF7;
	static const long ZPMagnitudeLSB                 =0xF8;
	static const long VGA1ZP                         =0xF9;
	static const long VGA2ZP                         =0xFA;
	static const long TempSensorRawMSB               =0xFB;// debuggingRegisters
	static const long TempSensorRawLSB               =0xFC;
	static const long AGCState                       =0xFD;
	static const long AGCStateZP                     =0xFE;
	
}regDef;

static CalsPrxI2cIo *i2cIO=NULL;

long bitField::byteSwap(uw dIn)
{
	return (dIn & 0x00ff) << 8 |
		   (dIn & 0xff00) >> 8;
}

long bitField::read()
{
	uc bData;
	uw wData;

	if (mask>0xff)
	{
		i2cIO->read(addr,wData);
		wData=byteSwap(wData);
		return (wData >> shift) & mask;	
	}
	else
	{
		i2cIO->read(addr,shift,mask,bData);
		return bData;	
	}
}

void bitField::write(const uw data)
{
	if (mask>0xff)
	{
		i2cIO->write(addr,((byteSwap(data) & mask) << shift));
	}
	else
	{
		i2cIO->write(addr,shift,mask,(uc)data);
	}
	return;
}

Creg::Creg(CalsBase *base)
{
	i2cIO=new CalsPrxI2cIo(base);
	samplingControlRegisters=   new CsamplingControlRegisters;
	openLoopCorrectionRegisters=new CopenLoopCorrectionRegisters;
};
Creg::~Creg()
{
	delete i2cIO;
	delete samplingControlRegisters;
	delete openLoopCorrectionRegisters;
}

Creg::CsamplingControlRegisters::CsamplingControlRegisters()
	{
		sample_len=new bitField(regDef.IntegrationTime,0,0x0F);
		sample_num=new bitField(regDef.IntegrationTime,4,0x0F);
	};
Creg::CsamplingControlRegisters::~CsamplingControlRegisters()
	{
		delete sample_len;
		delete sample_num;
	};

Creg::CopenLoopCorrectionRegisters::CopenLoopCorrectionRegisters()
	{
		ol_phase_co_exp= new bitField(regDef.PhaseExponent,        0,0x0f);
		ol_phase_amb_co1=new bitField(regDef.PhaseOffsetAmbientCo1,0,0xff);
		ol_phase_amb_co2=new bitField(regDef.PhaseOffsetAmbientCo2,0,0xff);
	};
Creg::CopenLoopCorrectionRegisters::~CopenLoopCorrectionRegisters()
	{
		delete ol_phase_co_exp;
		delete ol_phase_amb_co1;
		delete ol_phase_amb_co2;
	};
