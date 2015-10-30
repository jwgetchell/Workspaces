#include "stdafx.h"
#include "ALSbaseClass.h"
#include "alsPrxI2cIo.h"
#include "avgStats.h"
#include "openLoopCorrection.h"

using namespace alsEc;

CopenLoopCorrection::CopenLoopCorrection(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

t_status CalsBase::getPhaseOffsetAmbientCoef(dbl& c1,dbl& c2)
{
	t_status ret=alsEc::ok;
	return ret;
}

t_status CalsBase::setPhaseOffsetAmbientCoef(const dbl c1,const dbl c2)
{
	t_status ret=alsEc::ok;
	return ret;
}

t_status CalsBase::getPhaseOffsetVGAcoef(const uw vga,dbl& c1,dbl& c2)
{
	t_status ret=alsEc::ok;
	return ret;
}

t_status CalsBase::setPhaseOffsetVGAcoef(const uw vga,const dbl c1,const dbl c2)
{
	t_status ret=alsEc::ok;
	return ret;
}

#include "..\autoGen.cpp\openLoopCorrection.cpp"
