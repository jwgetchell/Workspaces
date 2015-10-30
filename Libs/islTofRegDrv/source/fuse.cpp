#include "stdafx.h"
#include "ALSbaseClass.h"
#include "fuse.h"

using namespace alsEc;

Cfuse::Cfuse(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

#include "..\autoGen.cpp\fuse.cpp"
