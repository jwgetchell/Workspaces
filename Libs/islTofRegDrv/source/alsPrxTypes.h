/*
 *  alsPrxTypes.h - Linux kernel module for
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
 
#ifndef _ALSPRXTYPES_H
#define _ALSPRXTYPES_H

typedef unsigned char  uc;
typedef unsigned short us;
typedef unsigned long  ul;
typedef double dbl;

typedef dbl t_stat;
typedef dbl t_dStat;

typedef ul uw;

typedef uw t_status;


// define test to enable I/O trace to file 'trace.txt'
#define _TEST "trace.txt"

#define NOEMUTRACE

#ifdef _TEST
#define PrintTrace(x)  printTrace(x)
#else
#define PrintTrace(x)  //printTrace(x)
#endif

#if (_WINDOWS || WIN32 )
	#ifdef _USRDLL  
		#define DLLAPI __declspec(dllexport)
		#define CAPI extern "C" __declspec(dllexport) t_status __stdcall
	#else                     
		#define DLLAPI __declspec(dllimport)
		#ifdef _CPP
			#define CAPI extern "C" __declspec(dllimport) ul               __stdcall
		#else
			#define CAPI extern     __declspec(dllimport) ul               __stdcall
		#endif
	#endif
	#define fpApi __stdcall

	#pragma warning (disable: 4100) // unreferenced formal parameter
	#pragma warning (disable: 4996) // allow strcpy usage
	#pragma warning (disable: 4706) // assignment within conditional expression

#else
	#define DLLAPI
	#define fpApi
	#ifdef _CPP
		#define CAPI extern "C" ul
	#else
		#define CAPI extern     ul
	#endif
#endif

#define callBackOk 71077345
const uw defaultRegMapSize=0x100;

extern ul (fpApi *pDrvApi)(ul,ul,uw*,ul);
extern ul (fpApi *pDrvApi2)(ul,ul,uw*,ul);

#endif
