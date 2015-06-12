/*
 *  alsPrxI2cIo.h - Linux kernel module for
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
 
#ifndef _ALSPRXI2CIO_H
#define _ALSPRXI2CIO_H

#include <stdio.h>
#include "ALSbaseClass.h"

namespace callBackCmd {
	const ul wByte=0;
	const ul rByte=1;
	const ul wWord=2;
	const ul rWord=3;
	const ul wI2cAddr=4;
	const ul rI2cAddr=5;
	const ul wPageBaddr=6;
	const ul rPageBaddr=7;
	const ul wPageWaddr=8;
	const ul rPAgeWaddr=9;
};

class CalsPrxI2cIo
{
public:
	CalsPrxI2cIo(CalsBase* base);
	~CalsPrxI2cIo();

	t_status read     (const uw addr,const uc shift,const uc mask,uc& data);
	t_status write    (const uw addr,const uc shift,const uc mask,const uc data);

	t_status read     (const CalsBase::Cfunction* f,uw& b);
	t_status write    (const CalsBase::Cfunction* f,const uw  b);

	t_status read     (const uw addr,uw& data);
	t_status write    (const uw addr,const uw data);

	t_status read     (const uw addr,uc& data);
    t_status write    (const uw addr,const uc data);

	t_status readHW   (const uw addr,uc& data);//read non-volatile
	t_status readHW   (const uw addr,uw& data);

	t_status write    (const uw  b);//cmd word
	t_status write    (const uc  b);//cmd byte

	t_status writeI2c(const uw,const uw,const uc);
	t_status writeI2c(const uw,const uw,const uw);
	t_status readI2c(const uw,const uw,uc&);
	t_status readI2c(const uw,const uw,uw&);

	t_status printTrace(const char*);
	t_status disableIO();
	t_status enableIO();

	t_status drvApi(const uw,const uw,uw&);

private:
	CalsBase* m_pBase;
	uw        m_isVolatile;
	FILE*     m_file;
	ul debugMap[defaultRegMapSize];
	bool m_disableIO;
	bool m_skipDebugMap;

	t_status emuApi(const uw,const uw,uw&);
	t_status trace(const char*,const uw,const uw,const uw);
};	

#endif
