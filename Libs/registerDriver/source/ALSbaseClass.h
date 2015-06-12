/*
 *  ALSbaseClass.h - Linux kernel module for
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

#include "alsPrxTypes.h"
#include "stateMachine.h"
#include <time.h>

#if 0
#ifdef _DEBUG
	#define _CRTDBG_MAP_ALLOC
	#include <stdlib.h>
	#include <crtdbg.h>
	#define TEST_NEW new(_NORMAL_BLOCK, __FILE__, __LINE__)
	#define new TEST_NEW
#endif
#endif

class CalsPrxI2cIo;
class Cstats;

        // __________
        // Bit Fields
        // ==========
namespace regIdx{
		const uw enable=      1;
        const uw intFlag=     2;
        const uw intPersist=  3;
        const uw data=        4;
        const uw threshHi=    5;
        const uw threshLo=    6;
        const uw inputSelect= 7;
        const uw range=       8;
        const uw resolution=  9;
        const uw irdr=       10;

        const uw runMode=    11;// 29011
        const uw proxAmbRej= 12;
        const uw irdrFreq=   13;

        const uw sleep=      14;// 29028
        const uw intLogic=   15;
        const uw test1=      16;
        const uw test2=      17;

        const uw proxIntEnable=18;// 29038
        const uw proxOffset=   19;
        const uw irComp=       20;
        const uw proxIR=       21;
        const uw proxAlrm=     22;
        const uw vddAlrm=      23;

        const uw proxOffsetTick0= 24;// 29177
        const uw proxOffsetTick1= 25;
        const uw testEnable=      26;
        const uw regOtp=          27;
        const uw fuseReg=         28;

#if ( _DEBUG || _INCTRIM ) // trim
		const uw proxTrim=     29;// FUSE_REG 0x13
		const uw irdrTrim=     30;
		const uw alsTrim=      31;

		const uw regOtpSel=    32;// FUSE_CTRL 0x14
		const uw otpData=      33;
		const uw fuseWrEn=     34;
		const uw fuseAddr=     35;

		const uw otpDone=      36;// TEST_MODES 0x12
		const uw irdrDcPulse=  37;
		const uw golden=       38;
		const uw optRes=       39;
		const uw intTest=      40;
#endif
}

        // ___________
        // Error Codes
        // ___________

namespace alsEc{
	const uw ok=0;
	const uw notImplemented=1; // base class default stub
	const uw illegalChannel=2; // c > m_Nchannels
	const uw illegalValue=  3; // v > m_reg->pFunc->m_mask
	const uw usbError=      4; // bus failure 
	const uw driverError=   5; // everything else
}

namespace alsType{
	const uw als=0;
	const uw ir= 1;
	const uw prx=2;
}

class CalsBase
{
public:
        CalsBase();
        virtual ~CalsBase();

		//t_typedef uw status;
		
		// device description
        uw m_Nreg;     
        uw m_Nchannels;
		uw m_partNumber;
		uw m_partFamily;
		uw m_ic2Addr;
		uw m_deviceBaseAddr;
		
		// device current state
		uw m_inputSelectN;
		uw m_rangeN;
		uw m_resolutionN;
		uw m_runMode;
		uw m_intFlag[2];
		uw m_proxOffsetValue;
		bool    m_hwEnabled;
		bool    m_stateMachineEnabled;
		bool    m_byteIoOnly;
		double  m_OSVer;

        // register tables
        uw *m_regTable; // function(addr,shift,mask)
        uw *m_regmap;   // value of addr
		uw m_cmdBase;	// base address of command register (word)

        // ___________________________________________________
        // Cfunction: Mapping from function to addr,shift,mask
        // ___________________________________________________
        class Cfunction{
        public:
                Cfunction();
                uw m_addr;
                uw m_shift;
                uw m_imask;// pre  shift (calculated)
                uw m_mask; // post shift
                uw m_isVolatile;// int & data
        };

        class CfunctionList{
        public:
                CfunctionList(uw*);
                ~CfunctionList();
                // per channel 
                Cfunction *m_enable;
                Cfunction *m_intFlag;
                Cfunction *m_intPersist;
                Cfunction *m_data;
                Cfunction *m_threshLo;
                Cfunction *m_threshHi;
                Cfunction *m_inputSelect;
                Cfunction *m_range;
                Cfunction *m_resolution;
                Cfunction *m_irdr;
                Cfunction *m_runMode;
                Cfunction *m_irdrFreq;
                Cfunction *m_proxAmbRej;
                Cfunction *m_sleep;
                Cfunction *m_intLogic;
                Cfunction *m_test1;
                Cfunction *m_test2;
				// 29038
                Cfunction *m_proxIntEnable;                                            
                Cfunction *m_proxOffset;
                Cfunction *m_irComp;
                Cfunction *m_proxIR;
                Cfunction *m_proxAlrm;
                Cfunction *m_vddAlrm;
				// 29177
                Cfunction *m_proxOffsetTick0;
                Cfunction *m_proxOffsetTick1;
                Cfunction *m_testEnable;
                Cfunction *m_regOtp;
                Cfunction *m_fuseReg;
#if ( _DEBUG || _INCTRIM ) // 29038 trim
                Cfunction *m_proxTrim;
                Cfunction *m_irdrTrim;
                Cfunction *m_alsTrim;

                Cfunction *m_regOtpSel;
                Cfunction *m_otpData;
                Cfunction *m_fuseWrEn;
                Cfunction *m_fuseAddr;

                Cfunction *m_otpDone;
                Cfunction *m_irdrDcPulse;
                Cfunction *m_golden;
                Cfunction *m_optRes;
                Cfunction *m_intTest;
#endif
		}*m_reg;

		Cstats *m_pDataStats[2];
		virtual t_status setPdataStats(const uw);

		class CmeasValues{
		public:
			CmeasValues():value(0),mean(0),stdDev(0),logicalState(0){};
			dbl value;
			dbl mean;
			dbl stdDev;
			uw logicalState;
		};

		class CrgbCoeff{
		public:
			CrgbCoeff();
			dbl alpha,beta,gamma;
			dbl Krg,Krb, Kgr,Kgb, Kbr,Kbg;
			dbl red,green,blue;// corrected
			dbl lux; // uncorrected green
			clock_t lastTime;
		}*m_rgbCoeff;
		bool m_useRgbCoeff;

		// _____________
		// state machine
		uw m_alsConversionTime;
		clock_t m_lastTime;
		clock_t m_setTime;
		virtual t_status checkTimer(const uw);

		CmeasValues m_alsValue;
		CstateMachine* m_alsState;

		CmeasValues m_prxValue;
		CstateMachine* m_prxState;

		CmeasValues m_irValue;
		CstateMachine* m_irState;

		CstateMachine** m_activeState[2];

		virtual t_status preStateIntMask(const uw,CstateMachine*);

		// IO
        t_status getError(uw e,char* msg);

		virtual t_status setDrvApi(ul (fpApi *pDrvApi)(ul,ul,uw*,ul));
		virtual t_status setIOinterceptEnable(bool);
		bool m_IOinterceptEnabled;

		CalsPrxI2cIo* m_pIO;

		virtual t_status checkOSVer();

		virtual t_status initDriver();// registers, calibration, state machine
		virtual t_status initRegisters();
		virtual t_status initCalibration();
		virtual t_status initStateMachine();// Als, Proximity, Ir
		virtual t_status initAlsStateMachine();
		virtual t_status initProximityStateMachine();
		virtual t_status initIrStateMachine();

		virtual t_status detectDevice();

		virtual t_status initDevice();// reset, conversion time, lux, reset
		virtual t_status resetDevice();
		virtual t_status measureConversionTime(uw&);
		virtual t_status alignLuxRanges();

		t_status printTrace(const char*);
		
		virtual t_status getNchannel(uw& v);

        // Lists: note all lists are size=1 for 2nd channel
		virtual t_status initInputSelect();
        uw m_NinputSelect;char **m_inputSelectList;
        virtual t_status getNinputSelect(const uw,uw&);
        virtual t_status getInputSelectList(const uw,char*);
        
		virtual t_status initRange();
        uw m_Nrange,*m_rangeList;  
        virtual t_status getNrange(const uw,uw&);
        virtual t_status getRangeList(const uw,uw*);
        
		virtual t_status initResolution();
        uw m_Nresolution,*m_resolutionList;     
        virtual t_status getNresolution(const uw,uw&);
        virtual t_status getResolutionList(const uw,uw*);

		virtual t_status initIrdr();
        uw m_Nirdr,*m_irdrList;     
        virtual t_status getNirdr(uw&);
        virtual t_status getIrdrList(uw*);

		virtual t_status initIntPersist();
        uw m_NintPersist,*m_intPersistList;  
        virtual t_status getNintPersist(const uw,uw&);
        virtual t_status getIntPersistList(const uw,uw*);
        
		virtual t_status initSleep();
        uw m_Nsleep;uw *m_sleepList;
        virtual t_status getNsleep(uw&);
        virtual t_status getSleepList(uw*);

        #define Get(x)     virtual t_status x (         uw&     );
        #define Set(x)     virtual t_status x (         const uw);
        #define chanGet(x) virtual t_status x (const uw,uw&     );Get(x)
        #define chanSet(x) virtual t_status x (const uw,const uw);Set(x)

        chanGet(getInputSelect)  chanSet(setInputSelect)
        chanGet(getEnable)       chanSet(setEnable)
        chanGet(getIntPersist)   chanSet(setIntPersist)
        chanGet(getIntFlag)      chanGet(getIntFlagMem)
        chanGet(getData)
        //chanGet(getThreshHi)     chanSet(setThreshHi)
        //chanGet(getThreshLo)     chanSet(setThreshLo)
        chanGet(getRange)        chanSet(setRange)
        chanGet(getResolution)   chanSet(setResolution)
        
        Get(getIrdr)             Set(setIrdr)
        Get(getRunMode)          Set(setRunMode)
        Get(getProxAmbRej)       Set(setProxAmbRej)
        Get(getIrdrFreq)         Set(setIrdrFreq)
        Get(getSleep)            Set(setSleep)
        Get(getIntLogic)         Set(setIntLogic)

        #undef chanGet
        #undef chanSet
        #undef Get
        #undef Set

		virtual t_status getThreshLo(const uw,     uw& );
				t_status getThreshLo(              uw& );
		        t_status getThreshLo(const uw,     dbl&);
		        t_status getThreshLo(              dbl&);
		virtual t_status setThreshLo(const uw,const uw );
		        t_status setThreshLo(         const uw );
		        t_status setThreshLo(const uw,const dbl);
		        t_status setThreshLo(         const dbl);
		virtual t_status getThreshHi(const uw,     uw& );
		        t_status getThreshHi(              uw& );
		        t_status getThreshHi(const uw,     dbl&);
		        t_status getThreshHi(              dbl&);
		virtual t_status setThreshHi(const uw,const uw );
		        t_status setThreshHi(         const uw );
		        t_status setThreshHi(const uw,const dbl);
		        t_status setThreshHi(         const dbl);

		virtual t_status getConversionTime(const uw,uw&);
		virtual t_status setConversionTime(const uw,const uw);

		virtual t_status getPartNumber(uw&);
		virtual t_status getPartFamily(uw&);

		virtual t_status getProxIR(dbl&,uw&);

		// New 29038 Functions
		virtual t_status setProxIntEnable(const uw );
		virtual t_status getProxIntEnable(      uw&);
		virtual t_status setProxOffset   (      uw&);
		virtual t_status getProxOffset   (      uw&);
		virtual t_status setIRcomp       (const uw );
		virtual t_status getIRcomp       (      uw&);
		virtual t_status getProxAlrm     (      uw&);
		virtual t_status setVddAlrm      (const uw );
		virtual t_status getVddAlrm      (      uw&);

		// New 29036 Functions
		virtual t_status setProxGain38(const uw );
		virtual t_status getProxGain38(      uw&);

		// New 177 Functions
		virtual t_status setPrxRngOffCmpEn(const uw );
		virtual t_status getPrxRngOffCmpEn(      uw&);
		virtual t_status setIrdrMode(const uw );
		virtual t_status getIrdrMode(      uw&);

#if ( _DEBUG || _INCTRIM ) // 29038 trim
		virtual t_status setProxTrim      (const uw );
		virtual t_status getProxTrim      (      uw&);
		virtual t_status setIrdrTrim      (const uw );
		virtual t_status getIrdrTrim      (      uw&);
		virtual t_status setAlsTrim       (const uw );
		virtual t_status getAlsTrim       (      uw&);

		virtual t_status setRegOtpSel     (const  uw );
		virtual t_status getRegOtpSel     (       uw&);
		virtual t_status setOtpData       (const  uw );
		virtual t_status getOtpData       (       uw&);
		virtual t_status setFuseWrEn      (const  uw );
		virtual t_status getFuseWrEn      (       uw&);
		virtual t_status setFuseWrAddr    (const  uw );
		virtual t_status getFuseWrAddr    (       uw&);

		virtual t_status getOptDone       (       uw&);
		virtual t_status setIrdrDcPulse   (const  uw );
		virtual t_status getIrdrDcPulse   (       uw&);
		virtual t_status getGolden        (       uw&);
		virtual t_status setOtpRes        (const  uw );
		virtual t_status getOtpRes        (       uw&);
		virtual t_status setIntTest       (const  uw );
		virtual t_status getIntTest       (       uw&);
#endif
		// stats
		virtual t_status getStats(const uw,dbl&,dbl&);
		virtual t_status getStats(         dbl&,dbl&);

		virtual t_status setMPAsize(const uw,const uw);
		virtual t_status setMPAsize(         const uw);

		virtual t_status getMPAprimed(const uw,uw&);
		virtual t_status getMPAprimed(         uw&);


		// UI
		virtual t_status getLux(dbl&);
		virtual t_status getLuxState(uw&);
		virtual t_status setLux(const uw);
		virtual t_status getProximity(dbl&);
		        t_status getProximityState(uw&);
		virtual t_status setProximity(const uw);
		virtual t_status getIR(dbl&);
		        t_status getIRState(uw&);
		virtual t_status setIR(const uw);

		// RGB
		virtual t_status getRed(dbl&);
		virtual t_status getGreen(dbl&);
		virtual t_status getBlue(dbl&);
		virtual t_status getCCT(dbl&);
		virtual t_status setRgbCoeffEnable(const uw);
		virtual t_status getRgbCoeffEnable(uw&);
		virtual t_status loadRgbCoeff(dbl*);
		virtual t_status clearRgbCoeff();
		virtual t_status enable4x(const uw);  // test modes
		virtual t_status enable8bit(const uw);

		// New
		virtual t_status setStateMachineEnable(const uw);
		virtual t_status getStateMachineEnable(uw&);
		virtual t_status setByteIoOnly(const uw);
		virtual t_status getByteIoOnly(uw&);


		//__________________________
        // regression test functions
		virtual t_status test (uw t);
		t_status test0();

		t_status testRegression();
		t_status testNotImplemented();
		t_status testErrorChecking(uw,uw*);
		t_status testGetTableIndex(const uw rti,uw& v);
		t_status testSetTableIndex(const uw rti,const uw v);
		t_status testRegisterXtalk();
};
