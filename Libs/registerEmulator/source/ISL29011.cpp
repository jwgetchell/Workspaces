/*
 *  ISL29011.cpp - Linux kernel module for
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
#include <time.h>
#include "ISL29011.h"

#ifdef _WINDOWS
	#pragma warning (disable:4100) // unreferenced formal parameter
	#pragma warning (disable:4706) // assignment within conditional expression
	#pragma warning (disable:4996) // allow strcpy
#endif

using namespace alsEc;

Cisl29011::Cisl29011()
{
	m_partNumber=29011;
}

Cisl29011::~Cisl29011()
{
}
