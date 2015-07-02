#include "stdafx.h"
#include "ALSbaseClass.h"
#include "analogControlRegisters.h"
#include "avgStats.h"

using namespace alsEc;

CanalogControlRegisters::CanalogControlRegisters(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

t_status CanalogControlRegisters::getIRDR(dbl& irdr)
{
	t_status ret=alsEc::ok;
	uw msb=0,lsb=0;

	msb=m_pReg->analogControlRegisters->driver_s->read();
	lsb=m_pReg->analogControlRegisters->emitter_current->read();

	irdr=100.0*msb/15.0*lsb/255.0;

	return ret;
}

t_status CanalogControlRegisters::setIRDR(const dbl irdrIn)
{
	t_status ret=alsEc::ok;
	uw msb=0,lsb=0;
	dbl irdr=irdrIn;

	if (irdr>100) irdr=100;
	if (irdr<0) irdr=0;

	if (irdr>0)
	{
		msb=(uw)(15.0*irdr/100.0+0.5);
		if (msb==0) msb=1;
		lsb=(uw)(255.0*irdr/(100.0*msb/15.0));
		if (lsb==0) lsb=1;
	}
	m_pReg->analogControlRegisters->driver_s->write(msb);
	m_pReg->analogControlRegisters->emitter_current->write(lsb);

	return ret;
}

t_status CanalogControlRegisters::getAFEgain(uw& gain)
{
	t_status ret=alsEc::ok;
	uw lna,tia;

	// lna on the bit map is labeled afe_gain
	// the tia on the bit map is labeled lna_gain
	lna=m_pReg->analogControlRegisters->afe_gain->read();
	tia=m_pReg->analogControlRegisters->lna_gain->read();

	gain=1.0;
	gain <<= lna;
	gain*=(2*tia+1);

	return ret;
}

t_status CanalogControlRegisters::setAFEgain(const uw gain)
{
	t_status ret=alsEc::ok;

	// afe & lna labels on the bitmap are incorrect

	switch(gain)
	{
	case 1: m_pReg->analogControlRegisters->lna_gain->write(0);
		    m_pReg->analogControlRegisters->afe_gain->write(0);
		    break;
	case 3: m_pReg->analogControlRegisters->lna_gain->write(1);
		    m_pReg->analogControlRegisters->afe_gain->write(0);
		    break;
	case 6: m_pReg->analogControlRegisters->lna_gain->write(1);
		    m_pReg->analogControlRegisters->afe_gain->write(1);
		    break;
	case 12:m_pReg->analogControlRegisters->lna_gain->write(1);
		    m_pReg->analogControlRegisters->afe_gain->write(2);
		    break;
	}
	return ret;
}
