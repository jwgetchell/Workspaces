#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class Cinterrupt
{
public:
	Cinterrupt(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\interrupt.h"
	
};

