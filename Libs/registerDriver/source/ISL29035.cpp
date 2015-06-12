/*
 *  ISL29035.cpp - Linux kernel module for
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
#include "ISL29035.h"
#include "alsPrxI2cIo.h"

#ifdef _WINDOWS
#pragma warning (disable:4100) // unreferenced formal parameter
#endif

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

using namespace alsEc;

uc compSet=0;

Cisl29035::Cisl29035()
{
	m_partNumber=29035;
}

Cisl29035::~Cisl29035()
{
}

t_status Cisl29035::setIRcomp       (const uw  x)
{

	m_pIO->write(0x0e,(uc)0x89); // enter test mode

	compSet=0x80*(x==0);

	m_pIO->write(0x08,compSet); // comp off

	m_pIO->write(0x0e,(uc)0x00); // exit test mode

	return ok;
}

t_status Cisl29035::getIRcomp       (      uw& x)
{
	x=(compSet!=0);
	return ok;
}
