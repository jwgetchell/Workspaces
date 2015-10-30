#pragma once

#include "alsPrxTypes.h"
#include "signalIntegrity.h"

class CalsBase;
class Creg;

class CsignalIntegrity
{
public:
	CsignalIntegrity(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\signalIntegrity.h"
	
};

