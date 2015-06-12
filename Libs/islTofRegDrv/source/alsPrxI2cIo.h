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

	t_status read     (const uw addr,const uc shift,const uw mask,uc& data);
	t_status write    (const uw addr,const uc shift,const uw mask,const uc data);

	t_status read     (const bitField* f,uw& b);
	t_status write    (const bitField* f,const uw  b);

	t_status read     (const uw addr,uw& data);
	t_status write    (const uw addr,const uw data);

	t_status read     (const uw addr,uc& data);
    t_status write    (const uw addr,const uc data);

	t_status readHW   (const uw addr,uc& data);//read non-volatile
	t_status readHW   (const uw addr,uw& data);

	t_status write    (const uw  b);//cmd word
	t_status write    (const uc  b);//cmd byte

	//t_status writeI2c(const uw,const uw,const uc);
	//t_status writeI2c(const uw,const uw,const uw);
	//t_status readI2c(const uw,const uw,uc&);
	//t_status readI2c(const uw,const uw,uw&);

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
