#include "stdafx.h"
#include "ALSbaseClass.h"
#include "algorithmControl.h"

using namespace alsEc;

CalgorithmControl::CalgorithmControl(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\algorithmControl.cpp"
