/*
 *  cApi.cpp - Linux kernel module for
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

#ifndef _CPP
	#define _CPP
#endif

#include "ALSbaseClass.h"
#include "alsPrxI2cIo.h"
#include "cApi.h"

DLLAPI CresourceManager resMgr;
DLLAPI CalsBase* pCalsBase=NULL;

#define Get(x,y)      CAPI x (uw*       v){return pCalsBase-> y ( *v);}
#define Set(x,y)      CAPI x (uw        v){return pCalsBase-> y (  v);}
#define chanGet(x,y)  CAPI x (uw c,uw*  v){return pCalsBase-> y (c,*v);}
#define chanSet(x,y)  CAPI x (uw c,uw   v){return pCalsBase-> y (c,v);}
#define chanDget(x,y) CAPI x (uw c,dbl* v){return pCalsBase-> y (c,*v);}
#define chanDset(x,y) CAPI x (uw c,dbl  v){return pCalsBase-> y (c,v);}

chanGet (cGetData       ,getData       )                                       
chanGet (cGetEnable     ,getEnable     ) chanSet(cSetEnable     ,setEnable     )
                                                                                
chanDget(cGetThreshHi   ,getThreshHi   ) chanDset(cSetThreshHi  ,setThreshHi   )
chanDget(cGetThreshLo   ,getThreshLo   ) chanDset(cSetThreshLo  ,setThreshLo   )

Get    (cGetRunMode    ,getRunMode    ) Set    (cSetRunMode    ,setRunMode    )
Get    (cGetProxAmbRej ,getProxAmbRej ) Set    (cSetProxAmbRej ,setProxAmbRej )
Get    (cGetIrdrFreq   ,getIrdrFreq   ) Set    (cSetIrdrFreq   ,setIrdrFreq   )
Get    (cGetIntLogic   ,getIntLogic   ) Set    (cSetIntLogic   ,setIntLogic   )

#undef chanGet
#undef chanSet
#undef Get
#undef Set

CAPI cGetDevice(ul *n)    {return resMgr.getDevice(*n);}
CAPI cGetDeviceList(char* n)  {return resMgr.getDeviceList(n);}
CAPI cGetError(ul e,char* m)  {return pCalsBase->getError(e,m);}
CAPI cGetInputSelect(uw c,uw* v){return pCalsBase->getInputSelect(c,*v);}
CAPI cGetInputSelectList(ul c,char* v) {return pCalsBase->getInputSelectList(c,v);}

CAPI cGetIntFlag(uw c,uw* v){return pCalsBase->getIntFlagMem(c,*v);}

CAPI cGetIntPersist(uw c,uw* v){return pCalsBase->getIntPersist(c,*v);}
CAPI cGetIntPersistList(uw c,uw* v){return pCalsBase->getIntPersistList(c,v);}
CAPI cGetIR(dbl *v) {return pCalsBase->getIR(*v);}
CAPI cGetIrdr(uw* v){return pCalsBase->getIrdr(*v);}
CAPI cGetIrdrList(uw *v) {return pCalsBase->getIrdrList(v);}
CAPI cGetIRState(uw *v) {return pCalsBase->getIRState(*v);}
CAPI cGetLux(dbl *v) {return pCalsBase->getLux(*v);}
CAPI cGetLuxState(uw *v) {return pCalsBase->getLuxState(*v);}
CAPI cGetMPAprimed(uw c,uw* v) {return pCalsBase->getMPAprimed(c,*v);}
CAPI cGetNchannel(uw *v){return pCalsBase->getNchannel(*v);}
CAPI cGetNdevice(ul* n)    {return resMgr.getNdevice(*n);}
CAPI cGetNinputSelect(ul c,uw *v)    {return pCalsBase->getNinputSelect(c,*v);}
CAPI cGetNintPersist(ul c,uw *v)    {return pCalsBase->getNintPersist(c,*v);}
CAPI cGetNirdr(uw *v)  {return pCalsBase->getNirdr  (*v);}
CAPI cGetNrange(ul c,uw *v)  {return pCalsBase->getNrange   (c,*v);}
CAPI cGetNresolution(ul c,uw *v)  {return pCalsBase->getNresolution   (c,*v);}
CAPI cGetNsleep(uw *v) {return pCalsBase->getNsleep   (*v);}
CAPI cGetProximity(dbl *v) {return pCalsBase->getProximity(*v);}
CAPI cGetProximityState(uw *v) {return pCalsBase->getProximityState(*v);}
CAPI cGetRange(uw c,uw* v){return pCalsBase->getRange(c,*v);}
CAPI cGetRangeList(ul c,uw *v) {return pCalsBase->getRangeList(c,v);}
CAPI cGetResolution(uw c,uw* v){return pCalsBase->getResolution(c,*v);}
CAPI cGetResolutionList(ul c,uw *v) {return pCalsBase->getResolutionList(c,v);}
CAPI cGetSleep(uw* v){return pCalsBase->getSleep(*v);}
CAPI cGetSleepList(uw *v) {return pCalsBase->getSleepList(v);}
CAPI cGetStats(uw c,double *m, double *s) {return pCalsBase->getStats(c,*m,*s);}
CAPI cInitDriver()  {return pCalsBase->initDriver() ;}
CAPI cPoll(uw* time) {return pCalsBase->m_alsState->call(*time);}
CAPI cPrintTrace(char* msg) {return pCalsBase->printTrace(msg);}
CAPI cResetDevice() {return pCalsBase->resetDevice();}
CAPI cSetDevice(ul n)     {return resMgr.setDevice(n);}
CAPI cSetDrvApi(ul (fpApi *pF)(ul,ul,uw*,ul))  {return pCalsBase->setDrvApi(pF);}
CAPI cSetInputSelect(uw c,uw v){return pCalsBase->setInputSelect(c,v);}
CAPI cSetIntPersist(uw c,uw v){return pCalsBase->setIntPersist(c,v);}
CAPI cSetIrdr(uw v){return pCalsBase->setIrdr(v);}
CAPI cSetMPAsize(uw c,uw v) {return pCalsBase->setMPAsize(c,v);}
CAPI cSetRange(uw c,uw v){return pCalsBase->setRange(c,v);}
CAPI cSetResolution(uw c,uw v){return pCalsBase->setResolution(c,v);}
CAPI cSetSleep(uw v){return pCalsBase->setSleep(v);}
CAPI cTest(ul t) {return pCalsBase->test(t);}

CAPI cGetConversionTime(uw c,uw* v){return pCalsBase->getConversionTime(c,*v);}
CAPI cSetConversionTime(uw c,uw v){return pCalsBase->setConversionTime(c,v);}

CAPI cMeasureConversionTime(uw* v){return pCalsBase->measureConversionTime(*v);}
CAPI cGetPartNumber(uw* v){return pCalsBase->getPartNumber(*v);}
CAPI cGetPartFamily(uw* v){return pCalsBase->getPartFamily(*v);}

CAPI cIO(uw cmd,uw addr,uw* data) {return pCalsBase->m_pIO->drvApi(cmd,addr,*data);}
CAPI cWriteField(uw addr,uc shift,uc mask,uc data) {return pCalsBase->m_pIO->write(addr,shift,mask,data);}
CAPI cReadField(uw addr,uc shift,uc mask,uc* data) {return pCalsBase->m_pIO->read(addr,shift,mask,*data);}

CAPI cWriteI2c(uw ia,uw a,uc d)    {return pCalsBase->m_pIO->writeI2c(ia,a,d);}
CAPI cWriteI2cWord(uw ia,uw a,uw d){return pCalsBase->m_pIO->writeI2c(ia,a,d);}
CAPI cReadI2c(uw ia,uw a,uc* d)    {return pCalsBase->m_pIO->readI2c(ia,a,*d);}
CAPI cReadI2cWord(uw ia,uw a,uw* d){return pCalsBase->m_pIO->readI2c(ia,a,*d);}

CAPI cSetProxIntEnable(uw  x){	return pCalsBase->setProxIntEnable( x);}
CAPI cGetProxIntEnable(uw* x){	return pCalsBase->getProxIntEnable(*x);}
CAPI cGetProxIR       (dbl* x,uw* f){	return pCalsBase->getProxIR   (*x,*f);}
CAPI cSetProxOffset   (uw* x){	return pCalsBase->setProxOffset   (*x);}
CAPI cGetProxOffset   (uw* x){	return pCalsBase->getProxOffset   (*x);}
CAPI cSetIRcomp       (uw  x){	return pCalsBase->setIRcomp       ( x);}
CAPI cGetIRcomp       (uw* x){	return pCalsBase->getIRcomp       (*x);}
CAPI cGetProxAlrm     (uw *x){  return pCalsBase->getProxAlrm     (*x);}
CAPI cSetVddAlrm      (uw  x){	return pCalsBase->setVddAlrm      ( x);}
CAPI cGetVddAlrm      (uw* x){	return pCalsBase->getVddAlrm      (*x);}

CAPI cSetStateMachineEnable (uw  x){return pCalsBase->setStateMachineEnable( x);}
CAPI cGetStateMachineEnable (uw* x){return pCalsBase->getStateMachineEnable(*x);}

CAPI cSetProxGain38 (uw  x){return pCalsBase->setProxGain38( x);}
CAPI cGetProxGain38 (uw* x){return pCalsBase->getProxGain38(*x);}

CAPI cSetByteIoOnly (uw  x){return pCalsBase->setByteIoOnly( x);}
CAPI cGetByteIoOnly (uw* x){return pCalsBase->getByteIoOnly(*x);}

// RGB
CAPI cGetRed        (dbl* x){return pCalsBase->getRed(*x);}
CAPI cGetGreen      (dbl* x){return pCalsBase->getGreen(*x);}
CAPI cGetBlue       (dbl* x){return pCalsBase->getBlue(*x);}
CAPI cGetCCT        (dbl* x){return pCalsBase->getCCT(*x);}
CAPI cSetRgbCoeffEnable(uw x){return pCalsBase->setRgbCoeffEnable(x);}
CAPI cGetRgbCoeffEnable(uw* x){return pCalsBase->getRgbCoeffEnable(*x);}
CAPI cLoadRgbCoeff  (dbl* x){return pCalsBase->loadRgbCoeff(x);}
CAPI cClearRgbCoeff (){return pCalsBase->clearRgbCoeff();}
CAPI cEnable4x(uw x){return pCalsBase->enable4x(x);}
CAPI cEnable8bit(uw x){return pCalsBase->enable8bit(x);}

#if ( _DEBUG || _INCTRIM ) // 29038 trim
CAPI cSetProxTrim     (uw  x){	return pCalsBase->setProxTrim     ( x);}
CAPI cGetProxTrim     (uw* x){	return pCalsBase->getProxTrim     (*x);}
CAPI cSetIrdrTrim     (uw  x){	return pCalsBase->setIrdrTrim     ( x);}
CAPI cGetIrdrTrim     (uw* x){	return pCalsBase->getIrdrTrim     (*x);}
CAPI cSetAlsTrim      (uw  x){	return pCalsBase->setAlsTrim      ( x);}
CAPI cGetAlsTrim      (uw* x){	return pCalsBase->getAlsTrim      (*x);}

CAPI cSetRegOtpSel    (uw  x){  return pCalsBase->setRegOtpSel     ( x);}
CAPI cGetRegOtpSel    (uw* x){  return pCalsBase->getRegOtpSel     (*x);}
CAPI cSetOtpData      (uw  x){  return pCalsBase->setOtpData       ( x);}
CAPI cGetOtpData      (uw* x){  return pCalsBase->getOtpData       (*x);}
CAPI cSetFuseWrEn     (uw  x){  return pCalsBase->setFuseWrEn      ( x);}
CAPI cGetFuseWrEn     (uw* x){  return pCalsBase->getFuseWrEn      (*x);}
CAPI cSetFuseWrAddr   (uw  x){  return pCalsBase->setFuseWrAddr    ( x);}
CAPI cGetFuseWrAddr   (uw* x){  return pCalsBase->getFuseWrAddr    (*x);}
                                                                        
CAPI cGetOptDone      (uw* x){  return pCalsBase->getOptDone       (*x);}
CAPI cSetIrdrDcPulse  (uw  x){  return pCalsBase->setIrdrDcPulse   ( x);}
CAPI cGetIrdrDcPulse  (uw* x){  return pCalsBase->getIrdrDcPulse   (*x);}
CAPI cGetGolden       (uw* x){  return pCalsBase->getGolden        (*x);}
CAPI cSetOtpRes       (uw  x){  return pCalsBase->setOtpRes        ( x);}
CAPI cGetOtpRes       (uw* x){  return pCalsBase->getOtpRes        (*x);}
CAPI cSetIntTest      (uw  x){  return pCalsBase->setIntTest       ( x);}
CAPI cGetIntTest      (uw* x){  return pCalsBase->getIntTest       (*x);}

// 177
CAPI cSetPrxRngOffCmpEn(uw  x){  return pCalsBase->setPrxRngOffCmpEn( x);}
CAPI cGetPrxRngOffCmpEn(uw* x){  return pCalsBase->getPrxRngOffCmpEn(*x);}
CAPI cSetIrdrMode(uw  x)      {  return pCalsBase->setIrdrMode( x);}
CAPI cGetIrdrMode(uw* x)      {  return pCalsBase->getIrdrMode(*x);}

CAPI cSetIOintEn      (uw x)
{  
	if (x==0) 
	{
		return pCalsBase->setIOinterceptEnable(false);
	}
	else
	{
		return pCalsBase->setIOinterceptEnable(true);
	}
}

// 
// VB6 Function replacements
//

CAPI VarPtr_(uw* x)
{
	return (t_status)x;
}

CAPI memcpy_(char oVarPtr[],char iVarAddr[],uw nBytes)
{
	uw i;
	for (i=0;i<nBytes;i++)
		oVarPtr[i]=iVarAddr[i];

	return (t_status)0;
}

CAPI cpyAddr2byte_(char* o,uw i)
{
	*o=(char&)i;
	return (t_status)0;
}

CAPI strcpy_(char oVarPtr[],char iVarPtr[])
{
	int i;

	for (i=0;i<80;i++)
	{
		oVarPtr[i]=iVarPtr[i];
		if (iVarPtr[i]==0) break;
	}
	if (i==80) oVarPtr[i-1]=0;
	//strcpy(oVarPtr,iVarPtr);

	return (t_status)0;
}

#endif