#include "stdafx.h"
#include "ALSbaseClass.h"
#include "debugging.h"

using namespace alsEc;

Cdebugging::Cdebugging(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\debugging.cpp"
