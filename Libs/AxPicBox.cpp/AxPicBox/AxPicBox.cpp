// AxPicBox.cpp : Implementation of CAxPicBoxApp and DLL registration.

#include "stdafx.h"
#include "AxPicBox.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


CAxPicBoxApp theApp;

const GUID CDECL _tlid = { 0x22D47DFB, 0x88A4, 0x433E, { 0x99, 0x86, 0xBC, 0x56, 0x76, 0xDA, 0xD6, 0xD5 } };
const WORD _wVerMajor = 1;
const WORD _wVerMinor = 0;



// CAxPicBoxApp::InitInstance - DLL initialization

BOOL CAxPicBoxApp::InitInstance()
{
	BOOL bInit = COleControlModule::InitInstance();

	if (bInit)
	{
		// TODO: Add your own module initialization code here.
	}

	return bInit;
}



// CAxPicBoxApp::ExitInstance - DLL termination

int CAxPicBoxApp::ExitInstance()
{
	// TODO: Add your own module termination code here.

	return COleControlModule::ExitInstance();
}



// DllRegisterServer - Adds entries to the system registry

STDAPI DllRegisterServer(void)
{
	AFX_MANAGE_STATE(_afxModuleAddrThis);

	if (!AfxOleRegisterTypeLib(AfxGetInstanceHandle(), _tlid))
		return ResultFromScode(SELFREG_E_TYPELIB);

	if (!COleObjectFactoryEx::UpdateRegistryAll(TRUE))
		return ResultFromScode(SELFREG_E_CLASS);

	return NOERROR;
}



// DllUnregisterServer - Removes entries from the system registry

STDAPI DllUnregisterServer(void)
{
	AFX_MANAGE_STATE(_afxModuleAddrThis);

	if (!AfxOleUnregisterTypeLib(_tlid, _wVerMajor, _wVerMinor))
		return ResultFromScode(SELFREG_E_TYPELIB);

	if (!COleObjectFactoryEx::UpdateRegistryAll(FALSE))
		return ResultFromScode(SELFREG_E_CLASS);

	return NOERROR;
}
