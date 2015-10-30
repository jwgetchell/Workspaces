#pragma once

#include "alsPrxTypes.h"
#include "algorithmControl.h"

class CalsBase;
class Creg;

class CalgorithmControl
{
public:
	CalgorithmControl(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\algorithmControl.h"
	
};

