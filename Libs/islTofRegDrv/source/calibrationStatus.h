#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class CcalibrationStatus
{
public:
	CcalibrationStatus(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\calibrationStatus.h"
	
};

