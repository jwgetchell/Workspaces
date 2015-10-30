#include "stdafx.h"
#include "ALSbaseClass.h"
#include "closedLoopCalibration.h"

using namespace alsEc;

CclosedLoopCalibration::CclosedLoopCalibration(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\closedLoopCalibration.cpp"
