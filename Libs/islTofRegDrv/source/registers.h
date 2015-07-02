#ifndef _REGISTERS_H
#define _REGISTERS_H

#include <stdio.h>
#include "ALSbaseClass.h"

class CalsBase;

#pragma warning(disable: 4512)//assignment operator could not be generated

class bitField
{
public: 

	bitField(uw a,uc s,uw m)
		:addr(a)
		,shift(s)
		,mask(m)
	{
	};
	long read();
	void write(const uw);

	long byteSwap(uw);
	const uw addr;
	const uc shift;
	const uw mask;
};

#pragma warning(default: 4512)

class Creg
{
public:
	Creg(CalsBase* base);
	~Creg();

#if 0

	//class CstatusRegisters	                {	}statusRegisters;

	class CsamplingControlRegisters
	{
	public:
		bitField *sample_len;
		bitField *sample_num;

		CsamplingControlRegisters();
		~CsamplingControlRegisters();
	}*samplingControlRegisters;

	//};
	//CsamplingControlRegisters *samplingControlRegisters;

	//class CalgorithmControlRegisters	    {	}algorithmControlRegisters;
	//class CsignalIntegrityRegisters  	    {	}signalIntegrityRegisters;
	//class CclosedLoopCalibrationRegisters  	{	}closedLoopCalibrationRegisters;

	class CopenLoopCorrectionRegisters
	{
	public:
		bitField *ol_phase_co_exp;
		bitField *ol_phase_amb_co1;
		bitField *ol_phase_amb_co2;

		CopenLoopCorrectionRegisters();
		~CopenLoopCorrectionRegisters();
	};
	CopenLoopCorrectionRegisters *openLoopCorrectionRegisters;

	//class CinterruptRegisters  	            {	}interruptRegisters;
	//class CdetectionModeControlRegisters  	{	}detectionModeControlRegisters;
	//class CanalogControlRegisters       	{	}analogControlRegisters;
	//class CDFTRegisters       	            {	}DFTregisters;
	//class CfuseRegisters       	            {	}fuseRegisters;
	//class CdigitalTestReg       	        {	}digitalTestReg;
	//class ClightSampleStatusRegisters       {	}lightSampleStatusRegisters;
	//class CcalibrationStatusRegisters       {	}calibrationStatusRegisters;
	//class CdebuggingRegisters               {	}debuggingRegisters;
#else

#include "..\excelVBA\autoGen\registers.h"

#endif

};

#endif
