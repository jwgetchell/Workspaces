#include "stdafx.h"
#include "ALSbaseClass.h"
#include "calibrationStatus.h"

using namespace alsEc;

CcalibrationStatus::CcalibrationStatus(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\calibrationStatus.cpp"
