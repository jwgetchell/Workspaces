#pragma once

#include "alsPrxTypes.h"
#include "registers.h"
#include <time.h>

class CalsBase;
class Creg;

class CanalogControl
{
public:
	CanalogControl(CalsBase*);

	CalsBase* m_pBase;
	Creg* m_pReg;

	// analogControlRegisters
	virtual t_status getIRDR(dbl&);
	virtual t_status setIRDR(const dbl);		
	virtual t_status getAFEgain(uw&);
	virtual t_status setAFEgain(const uw);
	//openLoopCorrectionRegisters 
	//virtual t_status getPhaseOffsetAmbientCoef(dbl&,dbl&);
	//virtual t_status setPhaseOffsetAmbientCoef(const dbl,const dbl);
	//virtual t_status getPhaseOffsetVGAcoef(const uw,dbl&,dbl&);
	//virtual t_status setPhaseOffsetVGAcoef(const uw,const dbl,const dbl);

	#include "..\autoGen.cpp\analogControl.h"

};
