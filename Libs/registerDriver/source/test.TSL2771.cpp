/*
 *  test.cpp - Linux kernel module for
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
#include "ALSbaseClass.h"

#pragma warning (disable: 4482) // nonstandard extension used: enum 'CalsBase::status' used in qualified name
#pragma warning (disable: 4706) // assignment within conditional expression

using namespace alsEc;

//#ifndef oneBased
//	#define testEnabled(t) (testEnableTable[(t+1)*(testEnableTable[0]+1)+devN+1])
//#else
//	#define testEnabled(t) (testEnableTable[(t+0)*(testEnableTable[0]+1)+devN+1])
//#endif

#define testEnabled(t) (testEnableTable[t*(testEnableTable[0]+1)+devN+1])

CalsBase::status CalsBase::test(ul t)
{
	switch(t)
	{
	case 0:return test0();
	case 1:return testRegression();
	default:return driverError;
	}
}
#if (_WINDOWS || WIN32 )
ul getTickTransition()
	// exits on tick transition
	// returns time in ms since boot
{
	ul t0=GetTickCount(),t=t0;
	while (t==t0)
		t=GetTickCount();
	return t;
}
#else
ul getTickTransition(){return 0;}
#endif
ul tf(ul s)
{
	return s;// break here to debug failures
}

#define testGetError(get)                                                        \
	if (ok             !=(status=p-> get (lv)))    return tf(driverError);   \
	if (ok             !=(status=p-> get (lc,lv))) return tf(driverError);   \
	if (illegalChannel !=(status=p-> get (ic,iv))) return tf(illegalChannel);
                                                                 
#define testError(get,set)                                                       \
	if (ok             !=(status=p-> get (lv)))    return tf(driverError);   \
	if (illegalValue   !=(status=p-> set (iv)))    return tf(illegalValue);  \
	if (ok             !=(status=p-> set (iv-1)))  return tf(driverError);   \
	if (ok             !=(status=p-> set (lv)))    return tf(driverError);   \
	if (ok             !=(status=p-> get (lc,lv))) return tf(driverError);   \
	if (illegalChannel !=(status=p-> get (ic,iv))) return tf(illegalChannel);\
	if (illegalChannel !=(status=p-> set (ic,lv))) return tf(illegalChannel);\
	if (illegalValue   !=(status=p-> set (lc,iv))) return tf(illegalValue);  \
	if (illegalChannel !=(status=p-> set (ic,iv))) return tf(illegalChannel);\
	if (ok             !=(status=p-> set (lc,lv))) return tf(driverError);
                                                                 
#define testErrorNc(get,set)                                                     \
	if (ok             !=(status=p-> get (lv)))    return tf(driverError);   \
	if (illegalValue   !=(status=p-> set (iv)))    return tf(illegalValue);  \
	if (ok             !=(status=p-> set (iv-1)))  return tf(driverError);   \
	if (ok             !=(status=p-> set (lv)))    return tf(driverError);

CalsBase::status CalsBase::testNotImplemented()
{
	CalsBase* p=this;
	ul nChan=p->m_Nchannels;
	CalsBase::status status;
	ul lv=0;

	// ______________
	// notImplemented
	// ¯¯¯¯¯¯¯¯¯¯¯¯¯¯      // _____  
	if (nChan==1)          // 29011
	{                      // ¯¯¯¯¯
		if (notImplemented !=(status=p->getIntLogic(lv))) return tf(notImplemented);
		if (notImplemented !=(status=p->getSleep(lv)))    return tf(notImplemented);
		if (notImplemented !=(status=p->setSleep(lv)))    return tf(notImplemented);
	}                      // _____
	else                   // 29028
	{                      // ¯¯¯¯¯
		if (notImplemented !=(status=p->getIrdrFreq(lv)))   return tf(notImplemented);
		if (notImplemented !=(status=p->getRunMode(lv)))    return tf(notImplemented);
		if (notImplemented !=(status=p->getProxAmbRej(lv))) return tf(notImplemented);
	}

	return status=ok;
}

CalsBase::status CalsBase::testRegression()
{	// this table must be sync'd with devices defined in CresourceManager
	// the regIdx values must be contiguous
	// disabled tests should return 'notImplemented'
#ifdef _DEBUG
	ul testEnableTable[]={6,29011,29023,29025,29028,29033,2771
	   ,regIdx::enable     ,    1,    1,    1,    1,    1,   1
	   ,regIdx::intFlag    ,    1,    1,    1,    1,    1,   1
	   ,regIdx::intPersist ,    1,    1,    1,    1,    1,   1
	   ,regIdx::data       ,    1,    1,    1,    1,    1,   1
	   ,regIdx::threshHi   ,    1,    1,    1,    1,    1,   1
	   ,regIdx::threshLo   ,    1,    1,    1,    1,    1,   1
	   ,regIdx::inputSelect,    1,    1,    1,    1,    1,   1
	   ,regIdx::range      ,    1,    1,    1,    1,    1,   1
	   ,regIdx::resolution ,    1,    1,    1,    1,    1,   1
	   ,regIdx::irdr       ,    1,    0,    0,    1,    0,   1
	   ,regIdx::runMode    ,    1,    1,    1,    0,    1,   0
	   ,regIdx::proxAmbRej ,    1,    0,    0,    0,    0,   0
	   ,regIdx::irdrFreq   ,    1,    0,    0,    0,    0,   0
	   ,regIdx::sleep      ,    0,    0,    0,    1,    0,   1
	   ,regIdx::intLogic   ,    0,    0,    0,    1,    0,   1
	}
#else
	ul testEnableTable[]={5,29011,29023,29025,29028,29033
	   ,regIdx::enable     ,    1,    1,    1,    1,    1
	   ,regIdx::intFlag    ,    1,    1,    1,    1,    1
	   ,regIdx::intPersist ,    1,    1,    1,    1,    1
	   ,regIdx::data       ,    1,    1,    1,    1,    1
	   ,regIdx::threshHi   ,    1,    1,    1,    1,    1
	   ,regIdx::threshLo   ,    1,    1,    1,    1,    1
	   ,regIdx::inputSelect,    1,    1,    1,    1,    1
	   ,regIdx::range      ,    1,    1,    1,    1,    1
	   ,regIdx::resolution ,    1,    1,    1,    1,    1
	   ,regIdx::irdr       ,    1,    0,    0,    1,    0
	   ,regIdx::runMode    ,    1,    1,    1,    0,    1
	   ,regIdx::proxAmbRej ,    1,    0,    0,    0,    0
	   ,regIdx::irdrFreq   ,    1,    0,    0,    0,    0
	   ,regIdx::sleep      ,    0,    0,    0,    1,    0
	   ,regIdx::intLogic   ,    0,    0,    0,    1,    0
	}
#endif
	,nDevices=testEnableTable[0]
	;//,nFunc=(sizeof(testEnableTable)/sizeof(testEnableTable[0]))/nDevices-1;

	status status;
	ul devN;

	for (devN=0;devN<nDevices;devN++)
		if (m_partNumber==testEnableTable[devN+1])
			break;

	if (devN==nDevices)
		return driverError;// device not found

	if (status=testErrorChecking(devN,testEnableTable))
		return status;
	if (status=testRegisterXtalk())
		return status;
	return testNotImplemented();
}

CalsBase::status CalsBase::testSetTableIndex(const ul rti,const ul v0)
{
	CalsBase* p=this;
	status s=driverError;
	ul c=m_regTable[2+rti*5],v=0;

	if (v0) v=m_regTable[5+rti*5];// set to mask value

	if (m_regTable[1+rti*5]==regIdx::inputSelect)// set to passed value
	{
		switch (m_partNumber)
		{
		case 29011:
		case 29023:
		case 29025:
		case 29033:v=v0;
		default:;
		}
	}

	switch (m_regTable[1+rti*5])
	{
	case regIdx::enable:	 s=p->setEnable(c,v);break;
	case regIdx::intFlag:	 s=p->write(&m_reg->m_intFlag[c],v);break;
	case regIdx::intPersist: s=p->setIntPersist(c,v);break;
	case regIdx::data:
		if (c)
			s=p->write(&m_reg->m_data[c],v);
		else
			s=p->writeWord(&m_reg->m_data[c],v);
		break;
	case regIdx::threshHi:	 s=p->setThreshHi(c,v);break;
	case regIdx::threshLo:	 s=p->setThreshLo(c,v);break;
	case regIdx::inputSelect:s=p->setInputSelect(c,v);break;
	case regIdx::range:      s=p->setRange(c,v);break;
	case regIdx::resolution: s=p->setResolution(c,v);break;
	case regIdx::irdr:       s=p->setIrdr(v);break;
	case regIdx::runMode:    s=p->setRunMode(v);break;
	case regIdx::proxAmbRej: s=p->setProxAmbRej(v);break;
	case regIdx::irdrFreq:   s=p->setIrdrFreq(v);break;
	case regIdx::sleep:      s=p->setSleep(v);break;
	case regIdx::intLogic:   s=p->setIntLogic(v);break;
	}

	return s;
}

CalsBase::status CalsBase::testGetTableIndex(const ul rti,ul& v)
{
	CalsBase* p=this;
	status s=driverError;
	ul c=m_regTable[2+rti*5];

	switch (m_regTable[1+rti*5])
	{
	case regIdx::enable:	 s=p->getEnable(c,v);break;
	case regIdx::intFlag:	 s=p->getIntFlag(c,v);break;
	case regIdx::intPersist: s=p->getIntPersist(c,v);break;
	case regIdx::data:	     s=p->getData(c,v);break;
	case regIdx::threshHi:	 s=p->getThreshHi(c,v);break;
	case regIdx::threshLo:	 s=p->getThreshLo(c,v);break;
	case regIdx::inputSelect:s=p->getInputSelect(c,v);break;
	case regIdx::range:      s=p->getRange(c,v);break;
	case regIdx::resolution: s=p->getResolution(c,v);break;
	case regIdx::irdr:       s=p->getIrdr(v);break;
	case regIdx::runMode:    s=p->getRunMode(v);break;
	case regIdx::proxAmbRej: s=p->getProxAmbRej(v);break;
	case regIdx::irdrFreq:   s=p->getIrdrFreq(v);break;
	case regIdx::sleep:      s=p->getSleep(v);break;
	case regIdx::intLogic:   s=p->getIntLogic(v);break;
	}

	return s;
}

CalsBase::status CalsBase::testRegisterXtalk()
{
	status s=ok;
	ul i,j,nReg=(m_regTable[0]-1)/5,v;

	for (i=0;i<nReg;i++)// set to all 0's
		if (s=testSetTableIndex(i,0))
		{
			return tf(s);
		}

	for (j=0;j<nReg;j++)
	{	
		// write mask
		v=m_regTable[5+j*5];
		if (m_regTable[1+j*5]==regIdx::inputSelect)
		{
			switch (m_partNumber)
			{
			case 29011:
			case 29023:
			case 29025:
			case 29033:v=m_NinputSelect-1;
			default:;
			}
		}
		if (s=testSetTableIndex(j,v))
			return tf(s);

		for (i=0;i<nReg;i++)// read
		{
			if (s=testGetTableIndex(i,v))
			{
				return tf(s);
			}

			if (i==j)
			{
				ul compare=m_regTable[5+j*5];

				switch(m_partNumber)
				{
				case 29011:
				case 29023:
				case 29025:
				case 29033:
					//switch (i)
					switch (m_regTable[1+i*5])
					{
					case regIdx::enable:       compare=1;break;
					case regIdx::inputSelect : compare=m_NinputSelect-1; break;
					}
				default:;
				}

				if (v!=compare)
				{
					return tf(driverError);
				}
			}
			else
			{
				if (v)
				{
					switch (m_partNumber)
					{
					case 29011:
					case 29023:
					case 29025:
					case 29033:
						if (m_regTable[1+i*5]!=regIdx::enable)
							if (m_regTable[1+j*5]!=regIdx::inputSelect)
								return driverError;
					default:;
					}

				}
			}
		}
		if (s=testSetTableIndex(j,0))
		{
			return tf(s);
		}
	}

	return s;
}

CalsBase::status CalsBase::testErrorChecking(ul devN,ul* testEnableTable)
{
	CalsBase* p=this;
	status status=ok;

	ul iv,lv,ic=p->m_Nchannels,lc=ic-1;// illegal/legal - value/channel

	if testEnabled(regIdx::intPersist)        // IntPersist
	{
		iv=m_reg->m_intPersist[0].m_mask+1;
		testError(getIntPersist,setIntPersist);
	}

	if testEnabled(regIdx::intPersist)         // IntFlag
		testGetError(getIntFlag);

	if testEnabled(regIdx::enable)             // Enable
	{
		iv=m_reg->m_enable[0].m_mask+1;
		testError(getEnable,setEnable);
	}

	if testEnabled(regIdx::data)               // Data
		testGetError(getData);

	if testEnabled(regIdx::inputSelect)        // InputSelect
	{
		iv=p->m_NinputSelect;
		testError(getInputSelect,setInputSelect);
	}

	if testEnabled(regIdx::threshHi)           // ThreshHi
	{
		iv=m_reg->m_threshHi[0].m_mask+1;
		testError(getThreshHi,setThreshHi);
	}

	if testEnabled(regIdx::threshLo)           // ThreshLo
	{
		iv=m_reg->m_threshLo[0].m_mask+1;
		testError(getThreshLo,setThreshLo);
	}
	if testEnabled(regIdx::irdr)               // Irdr
	{
		iv=m_reg->m_irdr->m_mask+1;
		testErrorNc(getIrdr,setIrdr);
	}

											   // _____
											   // 29011
                                               // ¯¯¯¯¯
	if testEnabled(regIdx::runMode)            // RunMode
	{
		iv=m_reg->m_runMode->m_mask+1;
		testErrorNc(getRunMode,setRunMode);
	}
	if testEnabled(regIdx::proxAmbRej)         // ProxAmbRej
	{
		iv=m_reg->m_proxAmbRej->m_mask+1;
		testErrorNc(getProxAmbRej,setProxAmbRej);
	}
	if testEnabled(regIdx::irdrFreq)           // IrdrFreq
	{
		iv=m_reg->m_irdrFreq->m_mask+1;
		testErrorNc(getIrdrFreq,setIrdrFreq);
	}

											   // _____
											   // 29028
                                               // ¯¯¯¯¯
	if testEnabled(regIdx::sleep)              // Sleep
	{
		iv=m_reg->m_sleep->m_mask+1;
		testErrorNc(getSleep,setSleep);
	}
	if testEnabled(regIdx::intLogic)           // IntLogic
	{
		iv=m_reg->m_intLogic->m_mask+1;
		testErrorNc(getIntLogic,setIntLogic);
	}

	if (p->m_Nchannels-1)                      // 29028
	{
		iv=m_reg->m_resolution[0].m_mask+1;    // Resolution
		testGetError(getResolution);
		if (notImplemented !=(status=p->setResolution(0)))   return notImplemented;
		if (notImplemented !=(status=p->setResolution(0,0))) return notImplemented;
		iv=m_Nrange;                           // Range
		if (ok             !=(status=p->getRange(lv)))    return driverError;
		if (illegalValue   !=(status=p->setRange(iv)))    return illegalValue;
		if (ok             !=(status=p->setRange(iv-1)))  return driverError;
		if (ok             !=(status=p->setRange(lv)))    return driverError;
		if (ok             !=(status=p->getRange(lc,lv))) return driverError;
		if (illegalChannel !=(status=p->getRange(ic,iv))) return illegalChannel;
		if (illegalChannel !=(status=p->setRange(ic,lv))) return illegalChannel;
		if (illegalValue   !=(status=p->setRange(lc,iv))) return illegalValue;
		if (illegalChannel !=(status=p->setRange(ic,iv))) return illegalChannel;
		if (notImplemented !=(status=p->setRange(lc,lv))) return notImplemented;
	}
	else                                       // 29011
	{
		iv=m_reg->m_resolution[0].m_mask+1;    // Resolution
		testError(getResolution,setResolution);
		iv=m_Nrange;                           // Range
		testError(getRange,setRange);
	}

	return status=ok;
}

CalsBase::status CalsBase::test0()
{
	CalsBase* p=this;
	status status=ok;
	ul e,i,j,m=0,t,t0,t1,meas[3][50];

	if (status==ok) status=p->getRunMode(m);    // 0:single; 1:continuous

	//// Byte 0
	//if (status==ok) status=p->setIntPersist(0); // {1,4,8,16}
	//if (status==ok) status=p->setInputSelect(0);// {ALS,IR,Prox}
	//if (status==ok) status=p->setRunMode(1);    // 0:single; 1:continuous
	//// Byte 1
	//if (status==ok) status=p->setRange(0);      // {1k,4k,16k,64k}
	//if (status==ok) status=p->setResolution(0); // {16,12,8,4}
	//if (status==ok) status=p->setIrdr(0);       // {12.5,25,50,100}
	//if (status==ok) status=p->setIrdrFreq(1);   // 0:DC;     1:360k
	//if (status==ok) status=p->setProxAmbRej(1); // 0:off;    1:enable

	ul ip=0,r=0,w=100;
	if (status==ok) status=p->getIntPersist(ip); // {1,4,8,16}
	if (status==ok) status=p->getResolution(r); // {16,12,8,4}
	w*= (ul)( (1 << (ip +1)) * (1 << (15-4*r)) / 65535.0 );

	if (status==ok) status=p->setThreshHi(0);   // force interrupt
	if (status==ok) status=p->setEnable(0);    // 0:off; 1:on
	//Sleep(500);
	if (status==ok) status=p->setEnable(1);    // 0:off; 1:on

	t0=t1=getTickTransition();
	if (!m) status=p->setRunMode(m);    // 0:single; 1:continuous

	for (i=0;i<sizeof(meas)/sizeof(meas[0][0])/3;i++)
	{
		for (j=0;j<1024;j++)
		{
			p->getIntFlag(e);
			if (e)
				break;
			else
				if (!m)
				{
					t=getTickTransition();
					if ((t-t1)>w)
					{
						p->setRunMode(m);
						t1=t;
					}
				}
			//Sleep(1);
		}
		p->getData(meas[1][i]);
		//if (!m) status=p->setRunMode(m);    // 0:single; 1:continuous
		t=getTickTransition();
		meas[0][i]=(t-t0);t0=t;
		if (i) meas[0][i]+=meas[0][i-1];
		meas[2][i]=j;
	}

	return status;
}