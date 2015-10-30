#include "stdafx.h"
#include "ALSbaseClass.h"
#include "detectionModeControl.h"

using namespace alsEc;

CdetectionModeControl::CdetectionModeControl(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\detectionModeControl.cpp"
