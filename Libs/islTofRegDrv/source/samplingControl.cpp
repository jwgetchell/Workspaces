#include "stdafx.h"
#include "ALSbaseClass.h"
#include "samplingControl.h"

using namespace alsEc;

CsamplingControl::CsamplingControl(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\samplingControl.cpp"
