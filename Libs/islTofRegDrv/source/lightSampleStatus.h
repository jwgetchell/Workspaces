#pragma once

#include "alsPrxTypes.h"
#include "registers.h"
#include <time.h>

class CalsBase;
class Creg;

class ClightSampleStatus
{
public:
	ClightSampleStatus(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;
	virtual t_status getDistance(dbl&);

	#include "..\autoGen.cpp\lightSampleStatus.h"
};
