#include "stdafx.h"
#include "ALSbaseClass.h"
#include "digitalTest.h"

using namespace alsEc;

CdigitalTest::CdigitalTest(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\digitalTest.cpp"
