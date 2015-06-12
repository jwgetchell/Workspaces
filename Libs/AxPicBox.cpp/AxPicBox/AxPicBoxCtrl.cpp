// AxPicBoxCtrl.cpp : Implementation of the CAxPicBoxCtrl ActiveX Control class.

#include "stdafx.h"
#include "AxPicBox.h"
#include "AxPicBoxCtrl.h"
#include "AxPicBoxPropPage.h"
#include "afxdialogex.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

IMPLEMENT_DYNCREATE(CAxPicBoxCtrl, COleControl)

// Message map

BEGIN_MESSAGE_MAP(CAxPicBoxCtrl, COleControl)
	ON_OLEVERB(AFX_IDS_VERB_PROPERTIES, OnProperties)
END_MESSAGE_MAP()

// Dispatch map

BEGIN_DISPATCH_MAP(CAxPicBoxCtrl, COleControl)
END_DISPATCH_MAP()

// Event map

BEGIN_EVENT_MAP(CAxPicBoxCtrl, COleControl)
END_EVENT_MAP()

// Property pages

// TODO: Add more property pages as needed.  Remember to increase the count!
BEGIN_PROPPAGEIDS(CAxPicBoxCtrl, 1)
	PROPPAGEID(CAxPicBoxPropPage::guid)
END_PROPPAGEIDS(CAxPicBoxCtrl)

// Initialize class factory and guid

IMPLEMENT_OLECREATE_EX(CAxPicBoxCtrl, "AXPICBOX.AxPicBoxCtrl.1",
	0x4cd52a19, 0xd4a8, 0x4431, 0x8c, 0xab, 0xc, 0x27, 0x99, 0x82, 0x78, 0x74)

// Type library ID and version

IMPLEMENT_OLETYPELIB(CAxPicBoxCtrl, _tlid, _wVerMajor, _wVerMinor)

// Interface IDs

const IID IID_DAxPicBox = { 0x8F304C5, 0x9192, 0x4E5A, { 0xB0, 0xC0, 0x50, 0x7E, 0xDE, 0xDD, 0x15, 0xD0 } };
const IID IID_DAxPicBoxEvents = { 0x68EBBACB, 0xDACE, 0x494E, { 0x9D, 0xC9, 0x26, 0xE1, 0xFB, 0x51, 0x11, 0x78 } };

// Control type information

static const DWORD _dwAxPicBoxOleMisc =
	OLEMISC_ACTIVATEWHENVISIBLE |
	OLEMISC_SETCLIENTSITEFIRST |
	OLEMISC_INSIDEOUT |
	OLEMISC_CANTLINKINSIDE |
	OLEMISC_RECOMPOSEONRESIZE;

IMPLEMENT_OLECTLTYPE(CAxPicBoxCtrl, IDS_AXPICBOX, _dwAxPicBoxOleMisc)

// CAxPicBoxCtrl::CAxPicBoxCtrlFactory::UpdateRegistry -
// Adds or removes system registry entries for CAxPicBoxCtrl

BOOL CAxPicBoxCtrl::CAxPicBoxCtrlFactory::UpdateRegistry(BOOL bRegister)
{
	// TODO: Verify that your control follows apartment-model threading rules.
	// Refer to MFC TechNote 64 for more information.
	// If your control does not conform to the apartment-model rules, then
	// you must modify the code below, changing the 6th parameter from
	// afxRegApartmentThreading to 0.

	if (bRegister)
		return AfxOleRegisterControlClass(
			AfxGetInstanceHandle(),
			m_clsid,
			m_lpszProgID,
			IDS_AXPICBOX,
			IDB_AXPICBOX,
			afxRegApartmentThreading,
			_dwAxPicBoxOleMisc,
			_tlid,
			_wVerMajor,
			_wVerMinor);
	else
		return AfxOleUnregisterClass(m_clsid, m_lpszProgID);
}


// CAxPicBoxCtrl::CAxPicBoxCtrl - Constructor

CAxPicBoxCtrl::CAxPicBoxCtrl()
{
	InitializeIIDs(&IID_DAxPicBox, &IID_DAxPicBoxEvents);
	// TODO: Initialize your control's instance data here.
}

// CAxPicBoxCtrl::~CAxPicBoxCtrl - Destructor

CAxPicBoxCtrl::~CAxPicBoxCtrl()
{
	// TODO: Cleanup your control's instance data here.
}

// CAxPicBoxCtrl::OnDraw - Drawing function

void CAxPicBoxCtrl::OnDraw(
			CDC* pdc, const CRect& rcBounds, const CRect& rcInvalid)
{
	if (!pdc)
		return;

	// TODO: Replace the following code with your own drawing code.
	pdc->FillRect(rcBounds, CBrush::FromHandle((HBRUSH)GetStockObject(WHITE_BRUSH)));
	pdc->Ellipse(rcBounds);
}

// CAxPicBoxCtrl::DoPropExchange - Persistence support

void CAxPicBoxCtrl::DoPropExchange(CPropExchange* pPX)
{
	ExchangeVersion(pPX, MAKELONG(_wVerMinor, _wVerMajor));
	COleControl::DoPropExchange(pPX);

	// TODO: Call PX_ functions for each persistent custom property.
}


// CAxPicBoxCtrl::OnResetState - Reset control to default state

void CAxPicBoxCtrl::OnResetState()
{
	COleControl::OnResetState();  // Resets defaults found in DoPropExchange

	// TODO: Reset any other control state here.
}


// CAxPicBoxCtrl message handlers
