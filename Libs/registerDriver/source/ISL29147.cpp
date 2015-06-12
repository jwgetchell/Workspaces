/*
 *  ISL29147.cpp - Linux kernel module for
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
#include "ISL29147.h"
#include "alsPrxI2cIo.h"
#include "stateMachine.h"

#ifdef _WINDOWS
#pragma warning (disable:4706) // assignment within conditional expression
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

Cisl29147::Cisl29147()
{
	m_partNumber=29147;
}

Cisl29147::~Cisl29147()
{
}

t_status
Cisl29147::initRange()
{
	t_status result=ok;

	static uw rng[]={56  // Define range list here
			        ,112 // ======================
			        ,900
			        ,1800
			        };
	m_Nrange=sizeof(rng)/sizeof(rng[0]);
	m_rangeList=rng;

	return result;
}
