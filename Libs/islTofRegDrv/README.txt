_________
Versions:
registerDriver.zip	1.3	WinXP 11,23,25,28,33 - C/C++

Next Rev Target Features
	add:resetDevice()
		<get/set>Lux(dbl); setLux is used for Calibration
	cygwin make		
_____________________
Project Installation:
Create Directory tree: ..\Workspace\Libs\registerDriver
Such that <registerDriver> is this directory (which contains README.txt)
Use registerDrive.bat to start the solution
It sets the enviroment such that the compiled files appear in the 'output' directory shown below.
	
C:\PROGRAM FILES\INTERSIL\WORKSPACE
+---apps
+---libs
|   \---registerDriver
|       |   README.txt
|       |   registerDriver.bat
|       |   registerDriver.devel.iss
|       |   registerDriver.sln
|       |   registerDriver.vcproj
|       |   unins000.dat
|       |   unins000.exe
|       |   
|       +---driverTest
|       |       driverTest.c
|       |       driverTest.cpp
|       |       driverTest.cpp.vcproj
|       |       driverTest.vcproj
|       |       stdafx.cpp
|       |       stdafx.h
|       |       targetver.h
|       |       
|       +---Linux
|       |       driverTest.c
|       |       Makefile
|       |       mk
|       |       mkLinks
|       |       README.txt
|       |       rmLinks
|       |       
|       \---source
|               ALSbaseClass.cpp
|               ALSbaseClass.h
|               avgStats.cpp
|               cApi.cpp
|               cApi.h
|               ISL29011.cpp
|               ISL29011.h
|               ISL29023.cpp
|               ISL29023.h
|               ISL29025.cpp
|               ISL29025.h
|               ISL29028.cpp
|               ISL29028.h
|               ISL29033.cpp
|               ISL29033.h
|               registerDriver.def
|               resMgr.cpp
|               resMgr.h
|               stdafx.cpp
|               stdafx.h
|               targetver.h
|               test.cpp
|               
\---output
    \---Debug
        +---bin
        |       driverTest.cpp.exe
        |       driverTest.exe
        |       registerDriver.dll
        |       
        +---driverTest
        |       :
        +---driverTest.cpp
        |       :
        +---lib
        |       registerDriver.lib
        |       
        \---registerDriver
                :

The bin & lib directories are common to all Apps & Libs
____
APIs
		CresourceManager();
			Initializes device list
		t_status getNdevices(size_t &n)
			Get #/devices in list
		t_status getDevices(char** d)
			Get ASCII list of devices
		t_status setDevice(char* device)
			Set to specific device
		t_status getDevice(CalsBase** Cdriver)
			Get pointer to driver for selected device
		
	Usage Example (~pseudo code)
	
		CresourceManager resMgr;
		CalsBase* driver;
		t_status result;// returns CalsBase::ok (0) on success
		unsigned int data;
		double lux;
	
		result |= resMgr.setDevice("ISL29011"); // 29011
		result |= resMgr.getDevice(&driver);
		
		result |= driver->setInputSelect(0);    // select ALS sensor
		result |= driver->setRange(2);          // 16000 Lux
		result |= driver->setResolution(0);     // 16 bit
		result |= driver->setRunMode(1);        // continuous
		sleep(100);                             // wait 100ms for conversion
		result |= driver->getData(data);        // read ALS data
		lux = 16000 * data/65535;               // calculate lux
______________
class CalsBase

	Driver Base Class. Contains:
		Definition and default stubs for all register I/O
	
	Register Control APIs:
		General format: status {get/set}{Function}(channel,value)
			Example: InputSelect - selects one of ALS/IR/Proximity
				status setInputSelect(const ul c,const ul  v);
				status getInputSelect(const ul c,const ul& v);
				  // single channel overloads call multichan with c=0
				status setInputSelect(           const ul  v);
				status getInputSelect(           const ul& v);
				
				c: channel #
				v: value
		Channel Based with overload for single channel
			Note: x11 types only have c=0 
			{get/set}
			Enable(c,v):        v=0: off
					    v=1: on or set to last known on value (x11)
			IntPersist(c,v):    v={0..3} where persist={1,4,8,16}
			ThreshHi(c,v):      v={0..2^resolution-1} interrupt high set point
			ThreshLo(c,v):      v={0..2^resolution-1} interrupt low set point
			InputSelect(c,v):   x11: v={0..2} selects one of ALS/IR/Proximity
			                    x28: c=0, v={0..1} selects one of ALS/IR
			                         c=1, get only: Proximity
			Range(c,v):         x11: v={0..3} range={1k,4k,16k,64k}
			                    x28: c=0, v={0..1} range={250,2k}
			                         c=1, get only: 8 Bit
			Resolution(c,v):    x11: v={0..3} resolution={16,12,8,4} bit
			                    x28: c=0, get only: 12 bit
			                         c=1, get only: 8 bit
			{get} only
			Data(c,v):          v={0..2^resolution-1} sensor measured value
			IntFlag(c,v):       v=0  ThreshLo < Data value < ThreshHi
			                    v=1  detected either Data value < ThreshLo
			                                      OR ThreshHi < Data value
		Shared (one/device)
			Irdr:               x11: v={0..3} driver current={12.5,25,50,100} ma
			                    x28: v={0..1} driver current={110,220} ma

		29011 Family Specific
			RunMode:            v=0 single conversion
			                    v=1 continuous conversion
			ProxAmbRej:         v=0 none
			                    v=1 subtract ambient from proximity
			ProxIrdrFreq:       v=0 DC
			                    v=1 360kHz
		29028 Family Specific
			Sleep:              v={0..7} sleep={800,400,200,100,75,25,12.5,off} ms
			IntLogic:           v=0 interrupt output = OR of ALS & Proximity flags
					    v=1 AND of interrupt flags
	List support APIs:
	
		getNInputSelect(c,v)
		getInputSelectList(c,v)
		getNRange(c,v)
		getRangeList(c,v)
		getNResolution(c,v)
		getResolutionList(c,v)
		getNsleep(v)
		getSleepList(v)

	I/O connection:
		Register I/O is directed through a single function pointer whose
		address is passed to the driver.
	
		typedef unsigned long ul;
		extern ul (*pDrvApi)(ul cmd,ul addr,ul* data);
		
		Controls device I/O & I2C addressing
		
		where:
		cmd={0..3} 0: write byte
		           1: read byte
		           2: write word (16 bit)
		           3: read word (16 bit)
		addr: device internal register address
		data: 16/8bit read/write data
		
		returns: 71077345 on success		
