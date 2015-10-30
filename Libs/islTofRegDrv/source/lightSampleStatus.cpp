#include "stdafx.h"
#include "ALSbaseClass.h"
#include "lightSampleStatus.h"
#include "avgStats.h"

using namespace alsEc;

ClightSampleStatus::ClightSampleStatus(CalsBase* pBase)
{
	m_pBase=pBase;
	m_pReg=m_pBase->m_pReg;
}

t_status ClightSampleStatus::getDistance(dbl& distance)
{
	// return value is in cm
	t_status ret=alsEc::ok;

	// currently hardcoded for a 4.5Mhz reference (dependent on NCO control1 = 0xA0)
	// nominal resolution is 508.6um
	const dbl cmPerLsb=100*3.0*10e8/(4.5*10e6)/65535.0/2.0; // (cm/m)(m/sec)/(cycles/sec)/(codes/cycle)

	distance=m_pReg->lightSampleStatusRegisters->distance->read();
	distance*=cmPerLsb; // mm/LSB

	return ret;
}

#include "..\autoGen.cpp\lightSampleStatus.cpp"
