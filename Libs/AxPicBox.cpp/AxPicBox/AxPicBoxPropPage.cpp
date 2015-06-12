// AxPicBoxPropPage.cpp : Implementation of the CAxPicBoxPropPage property page class.

#include "stdafx.h"
#include "AxPicBox.h"
#include "AxPicBoxPropPage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

IMPLEMENT_DYNCREATE(CAxPicBoxPropPage, COlePropertyPage)

// Message map

BEGIN_MESSAGE_MAP(CAxPicBoxPropPage, COlePropertyPage)
END_MESSAGE_MAP()

// Initialize class factory and guid

IMPLEMENT_OLECREATE_EX(CAxPicBoxPropPage, "AXPICBOX.AxPicBoxPropPage.1",
	0x66eeba1b, 0xb90c, 0x4e23, 0xaa, 0xc7, 0xdf, 0x64, 0x25, 0x38, 0x98, 0x7a)

// CAxPicBoxPropPage::CAxPicBoxPropPageFactory::UpdateRegistry -
// Adds or removes system registry entries for CAxPicBoxPropPage

BOOL CAxPicBoxPropPage::CAxPicBoxPropPageFactory::UpdateRegistry(BOOL bRegister)
{
	if (bRegister)
		return AfxOleRegisterPropertyPageClass(AfxGetInstanceHandle(),
			m_clsid, IDS_AXPICBOX_PPG);
	else
		return AfxOleUnregisterClass(m_clsid, NULL);
}

// CAxPicBoxPropPage::CAxPicBoxPropPage - Constructor

CAxPicBoxPropPage::CAxPicBoxPropPage() :
	COlePropertyPage(IDD, IDS_AXPICBOX_PPG_CAPTION)
{
}

// CAxPicBoxPropPage::DoDataExchange - Moves data between page and properties

void CAxPicBoxPropPage::DoDataExchange(CDataExchange* pDX)
{
	DDP_PostProcessing(pDX);
}

// CAxPicBoxPropPage message handlers
