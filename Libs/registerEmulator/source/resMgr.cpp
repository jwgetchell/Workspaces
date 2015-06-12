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
#include "ISL29033.h"
#include "ISL29200.h"

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
							 ,"ISL29033"
							 ,"ISL29200"
							 };
	m_Ndevice=sizeof(dev)/sizeof(dev[0]);
	m_deviceList=(char**)dev;
	pCalsBase=new CalsBase;//Cisl29011;
};

t_status
CresourceManager::setDevice(const ul v)
{
	if (pCalsBase)
		delete pCalsBase;

	m_deviceN=v;

	switch(v)
	{
	case 29011: pCalsBase=new Cisl29011;return ok;
	case 29020: pCalsBase=new Cisl29020;return ok;
	case 29023: pCalsBase=new Cisl29023;return ok;
	case 29025: pCalsBase=new Cisl29025;return ok;
	case 29028: pCalsBase=new Cisl29028;return ok;
	case 29033: pCalsBase=new Cisl29033;return ok;
	case 29200: pCalsBase=new Cisl29200;return ok;
	default:pCalsBase=new CalsBase; return driverError;
	}
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

