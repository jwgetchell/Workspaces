/*
 *  ISL29036.cpp - Linux kernel module for
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
#include "ISL29036.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29036::Cisl29036()
{
	m_partNumber=29036;
}

Cisl29036::~Cisl29036()
{
}

t_status
Cisl29036::initRange()
{
	t_status result=ok;

	static uw rng[]={67  // Define range list here
			        ,125 // ======================
			        ,1000
			        ,2500
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}

t_status
Cisl29036::setProxGain38(uw value)
{
	t_status result=ok;
	uc data;

	if (value>0){
		data=0x40;
	}
	else
		data=0;

	m_pIO->write(0x0e,(uc)0x89);// enable test mode
	m_pIO->write(0x14,(uc)0x40);// register mode
	m_pIO->write(0x13,data);// register mode

	return result;
}

t_status
Cisl29036::getProxGain38(uw& value)
{
	t_status result=ok;

	m_pIO->write(0x0e,(uc)0x89);// enable test mode
	m_pIO->write(0x14,(uc)0x40);// register mode
	//m_pIO->write(0x13,0x40*(value>0));// register mode

	return result;
}
