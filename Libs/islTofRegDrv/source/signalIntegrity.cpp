#include "stdafx.h"
#include "ALSbaseClass.h"
#include "signalIntegrity.h"

using namespace alsEc;

CsignalIntegrity::CsignalIntegrity(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\signalIntegrity.cpp"
