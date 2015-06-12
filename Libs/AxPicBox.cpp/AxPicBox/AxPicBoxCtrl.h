#pragma once

// AxPicBoxCtrl.h : Declaration of the CAxPicBoxCtrl ActiveX Control class.


// CAxPicBoxCtrl : See AxPicBoxCtrl.cpp for implementation.

class CAxPicBoxCtrl : public COleControl
{
	DECLARE_DYNCREATE(CAxPicBoxCtrl)

// Constructor
public:
	CAxPicBoxCtrl();

// Overrides
public:
	virtual void OnDraw(CDC* pdc, const CRect& rcBounds, const CRect& rcInvalid);
	virtual void DoPropExchange(CPropExchange* pPX);
	virtual void OnResetState();

// Implementation
protected:
	~CAxPicBoxCtrl();

	DECLARE_OLECREATE_EX(CAxPicBoxCtrl)    // Class factory and guid
	DECLARE_OLETYPELIB(CAxPicBoxCtrl)      // GetTypeInfo
	DECLARE_PROPPAGEIDS(CAxPicBoxCtrl)     // Property page IDs
	DECLARE_OLECTLTYPE(CAxPicBoxCtrl)		// Type name and misc status

// Message maps
	DECLARE_MESSAGE_MAP()

// Dispatch maps
	DECLARE_DISPATCH_MAP()

// Event maps
	DECLARE_EVENT_MAP()

// Dispatch and event IDs
public:
	enum {
	};
};

