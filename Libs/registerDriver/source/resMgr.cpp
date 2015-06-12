/*
 *  resMgr.cpp - Linux kernel module for
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
#include "resMgr.h"
#include "ALSbaseClass.h"
#include "ISL29011.h"
#include "ISL29020.h"
#include "ISL29023.h"
#include "ISL29025.h"
#include "ISL29028.h"
#include "ISL29028.jdsu.h"
#include "ISL29030.h"
#include "ISL29032.h"
#include "ISL29033.h"
#include "ISL29035.h"
#include "ISL29036.h"
#include "ISL29038.h"
#include "ISL29120.h"
#include "ISL29125.h"
#include "ISL29147.h"
#include "ISL29177.h"
#include "ISL29200.h"
#include "ISL58334.h"
#include "TSL2771.h"

#ifdef _WINDOWS
#pragma warning (disable:4996) // allow strcpy
#endif

extern CalsBase* pCalsBase;

using namespace alsEc;

CresourceManager::CresourceManager()
{										 // _______________________
	static const char* dev[]={"ISL29011" // Define device list here
							 ,"ISL29020" // =======================
							 ,"ISL29023"
							 ,"ISL29025"
							 ,"ISL29028"
							 ,"JDSU_028"
							 ,"ISL29030"
							 ,"ISL29032"
							 ,"ISL29033"
							 ,"ISL29035"
							 ,"ISL29036"
							 ,"ISL29038"
							 ,"ISL29120"
							 ,"ISL29125"
							 ,"ISL29147"
							 ,"ISL29177"
							 ,"ISL29200"
							 ,"ISL58334"
							 ,"TSL2771"
							 };
	m_deviceN=m_Ndevice=sizeof(dev)/sizeof(dev[0]);
	m_deviceList=(char**)dev;
	pCalsBase=new CalsBase;
};

t_status
CresourceManager::setDevice(const ul v)
{
	if (v<m_Ndevice)
	{
		if (pCalsBase)
			delete pCalsBase;

		m_deviceN=v;

		switch(v)
		{
		case  0: pCalsBase=new Cisl29011;return pCalsBase->initDriver();
		case  1: pCalsBase=new Cisl29020;return pCalsBase->initDriver();
		case  2: pCalsBase=new Cisl29023;return pCalsBase->initDriver();
		case  3: pCalsBase=new Cisl29025;return pCalsBase->initDriver();
		case  4: pCalsBase=new Cisl29028;return pCalsBase->initDriver();
		case  5: pCalsBase=new Cjdsu_028;return pCalsBase->initDriver();
		case  6: pCalsBase=new Cisl29030;return pCalsBase->initDriver();
		case  7: pCalsBase=new Cisl29032;return pCalsBase->initDriver();
		case  8: pCalsBase=new Cisl29033;return pCalsBase->initDriver();
		case  9: pCalsBase=new Cisl29035;return pCalsBase->initDriver();
		case 10: pCalsBase=new Cisl29036;return pCalsBase->initDriver();
		case 11: pCalsBase=new Cisl29038;return pCalsBase->initDriver();
		case 12: pCalsBase=new Cisl29120;return pCalsBase->initDriver();
		case 13: pCalsBase=new Cisl29125;return pCalsBase->initDriver();
		case 14: pCalsBase=new Cisl29147;return pCalsBase->initDriver();
		case 15: pCalsBase=new Cisl29177;return pCalsBase->initDriver();
		case 16: pCalsBase=new Cisl29200;return pCalsBase->initDriver();
		case 17: pCalsBase=new Cisl58334;return pCalsBase->initDriver();
		case 18: pCalsBase=new Ctsl2771; return pCalsBase->initDriver();
		default: pCalsBase=new CalsBase; return driverError;
		}
	}
	else return illegalValue;
}

CresourceManager::~CresourceManager()
{
	if (pCalsBase)
	{
		delete pCalsBase;
		pCalsBase=NULL;
	}
}

t_status
CresourceManager::getNdevice(ul& n){ n=m_Ndevice; return ok;};

t_status
CresourceManager::getDeviceList(char* d)
{
	unsigned int i,j=0;
	for (i=0;i<m_Ndevice;i++)
	{
		strcpy((d+j),m_deviceList[i]);
		j+=(strlen(m_deviceList[i])+1);
	}
	return ok;
};

t_status
CresourceManager::getDevice(ul& v)
{
	v=m_deviceN;
	return ok;
};

CalsBase*
getDriver()
{
	return pCalsBase;
}

t_status
getDriver(CalsBase** v)
{
	if (pCalsBase)
	{
		v=&pCalsBase;
		return ok;
	}
	else return driverError;
}

t_status
CresourceManager::detectDevice()
{
#pragma message (">>>>>>>>>>> JWG: CresourceManager::detectDevice <<<<<<<<<<<<<<")
	t_status status;
	ul i=m_Ndevice;
i=5;//JWG 28 1st
	do
	{
		setDevice(--i);
		status=pCalsBase->detectDevice();
		if (i==3) i=1;//JWG jump to 11
	}while ( (status!=ok) && (i) );

	return status;
}


