#include "stdafx.h"
#include "ALSbaseClass.h"
#include "dft.h"

using namespace alsEc;

Cdft::Cdft(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\dft.cpp"
