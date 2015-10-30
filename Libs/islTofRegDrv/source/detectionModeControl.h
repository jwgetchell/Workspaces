#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class CdetectionModeControl
{
public:
	CdetectionModeControl(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	#include "..\autoGen.cpp\detectionModeControl.h"
	
};

