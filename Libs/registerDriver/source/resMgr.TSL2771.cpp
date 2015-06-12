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
#include "ISL29023.h"
#include "ISL29025.h"
#include "ISL29028.h"
#include "ISL29033.h"
#include "TSL2771.h"

#pragma warning (disable:4996) // allow strcpy

extern CalsBase* pCalsBase;
extern ul (__stdcall *pDrvApi)(ul,ul,ul*);

using namespace alsEc;

CresourceManager::CresourceManager()
{                                  // _______________________
	static const char* dev[]={"ISL29011" // Define device list here
		               ,"ISL29023" // ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
		               ,"ISL29025"
		               ,"ISL29028"
		               ,"ISL29033"
#ifdef _DEBUG
		               ,"TSL2771"
#endif
		               };
	m_Ndevice=sizeof(dev)/sizeof(dev[0]);
	m_deviceList=(char**)dev;
	pCalsBase=new CalsBase;//Cisl29011;
};

CalsBase::status
CresourceManager::setDevice(const ul v)
{
	if (v<m_Ndevice)
	{
		if (pCalsBase)
			delete pCalsBase;

		m_deviceN=v;

		switch(v)
		{
		case 0: pCalsBase=new Cisl29011;return pCalsBase->initDriver();
		case 1: pCalsBase=new Cisl29023;return pCalsBase->initDriver();
		case 2: pCalsBase=new Cisl29025;return pCalsBase->initDriver();
		case 3: pCalsBase=new Cisl29028;return pCalsBase->initDriver();
		case 4: pCalsBase=new Cisl29033;return pCalsBase->initDriver();
#ifdef _DEBUG
		case 5: pCalsBase=new Ctsl2771; return pCalsBase->initDriver();
#endif
		default:pCalsBase=new CalsBase; return driverError;
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

CalsBase::status
CresourceManager::getNdevice(ul& n){ n=m_Ndevice; return ok;};

CalsBase::status
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

CalsBase::status
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

CalsBase::status
getDriver(CalsBase** v)
{
	if (pCalsBase)
	{
		v=&pCalsBase;
		return ok;
	}
	else return driverError;
}

CalsBase::status
CresourceManager::detectDevice()
{
	CalsBase::status status;
	ul i=m_Ndevice;

	do
	{
		setDevice(--i);
		status=pCalsBase->detectDevice();
	}while ( (status!=ok) && (i) );

	return status;
}


