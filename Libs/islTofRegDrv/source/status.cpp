#include "stdafx.h"
#include "ALSbaseClass.h"
#include "status.h"

using namespace alsEc;

Cstatus::Cstatus(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

t_status Cstatus::getChip_id(uw& chip_id)
{
	t_status ret=alsEc::ok;
	chip_id=m_pReg->statusRegisters->chip_id->read();
	return ret;
}

t_status Cstatus::getC_en(uw& c_en)
{
	t_status ret=alsEc::ok;
	c_en=m_pReg->statusRegisters->c_en->read();
	return ret;
}

t_status Cstatus::setC_en(uw c_en)
{
	t_status ret=alsEc::ok;
	m_pReg->statusRegisters->c_en->write(c_en);
	return ret;
}


#include "..\autoGen.cpp\status.cpp"
