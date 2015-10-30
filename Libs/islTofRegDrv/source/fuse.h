#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class Cfuse
{
public:
	Cfuse(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\fuse.h"
	
};

