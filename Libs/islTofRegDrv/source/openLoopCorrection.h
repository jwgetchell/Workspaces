#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class CopenLoopCorrection
{
public:
	CopenLoopCorrection(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\openLoopCorrection.h"
	
};

