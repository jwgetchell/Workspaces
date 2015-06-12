#pragma once

// AxPicBoxPropPage.h : Declaration of the CAxPicBoxPropPage property page class.


// CAxPicBoxPropPage : See AxPicBoxPropPage.cpp for implementation.

class CAxPicBoxPropPage : public COlePropertyPage
{
	DECLARE_DYNCREATE(CAxPicBoxPropPage)
	DECLARE_OLECREATE_EX(CAxPicBoxPropPage)

// Constructor
public:
	CAxPicBoxPropPage();

// Dialog Data
	enum { IDD = IDD_PROPPAGE_AXPICBOX };

// Implementation
protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

// Message maps
protected:
	DECLARE_MESSAGE_MAP()
};

