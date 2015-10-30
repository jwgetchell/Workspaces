#include "stdafx.h"
#include "ALSbaseClass.h"
#include "interrupt.h"

using namespace alsEc;

Cinterrupt::Cinterrupt(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\interrupt.cpp"
