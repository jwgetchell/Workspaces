/*
 *  resMgr.h - Linux kernel module for
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
#pragma once

#include "ALSbaseClass.h"

class DLLAPI CresourceManager
{
public:
	CresourceManager();
	~CresourceManager();

	t_status getNdevice(ul& v);
	t_status getDeviceList(char* v);
	t_status detectDevice();

	t_status setDevice(const ul  v);
	t_status getDriver(CalsBase** v);
	CalsBase* getDriver();
	t_status getDevice(      ul& v);
private:
	char** m_deviceList;
	ul     m_Ndevice;
	ul     m_deviceN;

};

