#pragma once

#include "alsPrxTypes.h"
#include "registers.h"

class CalsBase;
class Creg;

class Cstatus
{
public:
	Cstatus(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	virtual t_status getChip_id(uw&);
	virtual t_status getC_en(uw&);
	virtual t_status setC_en(uw);

	#include "..\autoGen.cpp\status.h"
	
};

