#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

#include "status.h"
#include "samplingControl.h"
#include "algorithmControl.h"
#include "signalIntegrity.h"
#include "closedLoopCalibration.h"
#include "openLoopCorrection.h"
#include "interrupt.h"
#include "detectionModeControl.h"
#include "analogControl.h"
#include "dft.h"
#include "fuse.h"
#include "digitalTest.h"
#include "lightSampleStatus.h"
#include "calibrationStatus.h"
#include "debugging.h"

#include <time.h>

class CalsPrxI2cIo;
class Creg;
class Cstats;

namespace alsEc{
	const uw ok=0;
	const uw notImplemented=1; // base class default stub
	const uw illegalChannel=2; // c > m_Nchannels
	const uw illegalValue=  3; // v > m_reg->pFunc->m_mask
	const uw usbError=      4; // bus failure 
	const uw driverError=   5; // everything else
}

class CalsBase
{
public:
        CalsBase();
        virtual ~CalsBase();

		t_status setAmbientCoeffs(const uw,const dbl,const dbl);

        uw m_Nreg;     
		uw m_partNumber;
		uw m_partFamily;
		bool m_byteIoOnly;
        uw *m_regmap;   // value of addr

		Cstats *m_pDataStats[2];
		virtual t_status setPdataStats(const uw);

		class CmeasValues{
		public:
			CmeasValues():value(0),mean(0),stdDev(0),logicalState(0){};
			dbl value;
			dbl mean;
			dbl stdDev;
			uw logicalState;
		};

        t_status getError(uw e,char* msg);

		virtual t_status setDrvApi(ul (fpApi *pDrvApi)(ul,ul,uw*,ul));
		virtual t_status setIOinterceptEnable(bool);
		bool m_IOinterceptEnabled;

		CalsPrxI2cIo* m_pIO;
		Creg* m_pReg;

		virtual t_status initDriver();// registers, calibration, state machine
		virtual t_status initRegisters();
		virtual t_status initCalibration();
		virtual t_status detectDevice();

		virtual t_status initDevice();// reset, conversion time, lux, reset
		virtual t_status resetDevice();

		t_status printTrace(const char*);

		virtual t_status getPartNumber(uw&);
		virtual t_status getPartFamily(uw&);

		virtual t_status getStats(const uw,dbl&,dbl&);
		virtual t_status getStats(         dbl&,dbl&);

		virtual t_status setMPAsize(const uw,const uw);
		virtual t_status setMPAsize(         const uw);

		virtual t_status getMPAprimed(const uw,uw&);
		virtual t_status getMPAprimed(         uw&);

		virtual t_status setByteIoOnly(const uw);
		virtual t_status getByteIoOnly(uw&);

		Cstatus*                               status;
		CsamplingControl*             samplingControl;
		CalgorithmControl*           algorithmControl;
		CsignalIntegrity*             signalIntegrity;
		CclosedLoopCalibration* closedLoopCalibration;
		CopenLoopCorrection*       openLoopCorrection;
		Cinterrupt*                         interrupt;
		CdetectionModeControl*   detectionModeControl;
		CanalogControl*                 analogControl;
		Cdft*                                     dft;
		Cfuse*                                   fuse;
		CdigitalTest*                     digitalTest;
		ClightSampleStatus*         lightSampleStatus;
		CcalibrationStatus*         calibrationStatus;
		Cdebugging*                         debugging;

		//// analogControlRegisters
		//virtual t_status getIRDR(dbl&);
		//virtual t_status setIRDR(const dbl);		
		//virtual t_status getAFEgain(uw&);
		//virtual t_status setAFEgain(const uw);
		//openLoopCorrectionRegisters 
		virtual t_status getPhaseOffsetAmbientCoef(dbl&,dbl&);
		virtual t_status setPhaseOffsetAmbientCoef(const dbl,const dbl);
		virtual t_status getPhaseOffsetVGAcoef(const uw,dbl&,dbl&);
		virtual t_status setPhaseOffsetVGAcoef(const uw,const dbl,const dbl);

};
