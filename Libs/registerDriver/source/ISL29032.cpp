/*
 *  ISL29032.cpp - Linux kernel module for
 * 	Intersil ambient light & proximity sensors
 *
 *  Copyright (c) 2010 Jim Getchell <Jim.Getchell@yahoo.com>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include "stdafx.h"
#include "ISL29032.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29032::Cisl29032()
:m_prox30Ratio(0.08)
{
	m_partNumber=29032;
}

Cisl29032::~Cisl29032()
{
}

t_status
Cisl29032::initSleep()
{
	static uw res[]={400 // __________
	                ,100 // Sleep list
					,50  // ==========
					,25
					,12
					,6
					,3
					,0};
	m_Nsleep=sizeof(res)/sizeof(res[0]);
	m_sleepList=res;
	return ok;
}

t_status
Cisl29032::getProxIR(dbl& c,uw& iFlag){
	t_status status=ok;
	uw byte,sleep,tl,th;

	// ___________________________
	// Switch to prox30 measurment
	if ((status=m_pIO->write(&m_reg->m_enable[1],0)))// disable proximity
		return status;

	if ((status=m_pIO->write(m_reg->m_test2,0x29)))// unlock test
		return status;

	if ((status=m_pIO->write(m_reg->m_test1,0x30)))// select prox30
		return status;

	if ((status=m_pIO->read(m_reg->m_sleep,sleep)))// get current sleep
		return status;

	if ((status=m_pIO->read(&m_reg->m_threshLo[1],tl)))// get current Tl
		return status;

	if ((status=m_pIO->read(&m_reg->m_threshHi[1],th)))// get current Th
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshLo[1],0x55)))// set prox30 Tl
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshHi[1],0xAA)))// set prox30 Th
		return status;

	if ((status=m_pIO->write(m_reg->m_sleep,7)))// turn sleep off
		return status;

	if ((status=m_pIO->write(&m_reg->m_enable[1],1)))// enable proximity
		return status;

	// ___________
	// measurement
	Sleep(2);

	if ((status=m_pIO->read(&m_reg->m_data[1],byte)))// read "prox30"
		return status;

	c=byte/255.0;// normalize to 1

	if ((status=m_pIO->read(&m_reg->m_intFlag[1],iFlag)))// read INT flag
		return status;

	if (iFlag)
	{
		if ((status=m_pIO->write(&m_reg->m_intFlag[1],0)))// clear INT flag
			return status;
	}

	// ________________________
	// switch back to proximity
	if ((status=m_pIO->write(&m_reg->m_enable[1],0)))// disable proximity
		return status;

	if ((status=m_pIO->write(m_reg->m_sleep,sleep)))// sleep on
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshLo[1],tl)))// reset Tl
		return status;

	if ((status=m_pIO->write(&m_reg->m_threshHi[1],th)))// reset Th
		return status;

	if ((status=m_pIO->write(m_reg->m_test1,0x0)))// deselect prox30
		return status;

	if ((status=m_pIO->write(m_reg->m_test2,0x0)))// lock test
		return status;

	if ((status=m_pIO->write(&m_reg->m_enable[1],1)))// enable proximity
		return status;

	Sleep(2);

	return ok;
}

t_status
Cisl29032::getProximity(dbl& c)
{
	t_status status;
	dbl irdetect=0.0;
	uw iFlag;

	if ((status=checkTimer(m_Nchannels-1)))
		return status;

	getProxIR(irdetect,iFlag);
	c=m_prxValue.value*(1.0-irdetect*m_prox30Ratio)+irdetect*m_prox30Ratio;
	return ok;
}

