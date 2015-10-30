#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class Cdebugging
{
public:
	Cdebugging(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\debugging.h"
	
};

