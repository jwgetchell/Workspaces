#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class CclosedLoopCalibration
{
public:
	CclosedLoopCalibration(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\closedLoopCalibration.h"
	
};

