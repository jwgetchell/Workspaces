Option Strict Off
Option Explicit On
Module dllCallBackFunction
	
	Public gUsb As Object
	Public uc As ucJungoUsb
	Private gDeviceInfo As WDU_DEVICE
	Private gUserData As deviceContext_t
	Private m_pDeviceInfo As WDU_DEVICE
	Private m_pUserData As deviceContext_t
	
	Public Structure t_flag
		Dim DeviceOpened As Boolean
		Dim DeviceAttached As Boolean
	End Structure
	
	Public m_flag As t_flag
	
	Enum status
		ok
		notImplemented
		illegalChannel
		illegalValue
		usbError
		driverError
	End Enum
	
	Public data() As Double
	Public index, gSize, decimation As Integer
	
	Public Declare Function GetTickCount Lib "kernel32" () As Integer
	Public Declare Sub Sleep Lib "kernel32" (ByVal t As Integer)
	
	
	Public Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef dataIn As Integer) As Integer
		Static data As Integer : data = dataIn
		If RW = ucALSusb.cmd.WA Then ' write address
			'UPGRADE_WARNING: Couldn't resolve default property of object gUsb.DllCallBack. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			DllCallBack = gUsb.DllCallBack(RW, addr, data)
		Else
			'UPGRADE_WARNING: Couldn't resolve default property of object gUsb.DllCallBack. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
			DllCallBack = gUsb.DllCallBack(RW, addr, data)
		End If
		dataIn = data
	End Function
	
	Public Function ucmDllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		ucmDllCallBack = udCallBack(RW, addr, data)
	End Function
	
	Function USBattachCallback(ByVal hDev As Integer, ByRef pDeviceInfo As WDU_DEVICE, ByRef pUserData As deviceContext_t) As Boolean
		Dim hDevice As Integer
		pUserData.hDev = hDev
		Call setUSB_CallbackParams(pDeviceInfo, pUserData)
		USBattachCallback = attachCallback(hDevice)
		
	End Function
	
	Sub USBdetachCallback(ByVal hDev As Integer, ByRef pDeviceInfo As WDU_DEVICE, ByRef pUserData As deviceContext_t)
		Dim hDevice As Integer
		Call setUSB_CallbackParams(pDeviceInfo, pUserData)
		detachCallback((hDevice))
		
	End Sub
	
	Public Sub getUSB_CallbackParams(ByRef pDeviceInfo As WDU_DEVICE, ByRef pUserData As deviceContext_t)
		'UPGRADE_WARNING: Couldn't resolve default property of object pDeviceInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		pDeviceInfo = gDeviceInfo
		'UPGRADE_WARNING: Couldn't resolve default property of object pUserData. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		pUserData = gUserData
	End Sub
	Public Sub setUSB_CallbackParams(ByRef pDeviceInfo As WDU_DEVICE, ByRef pUserData As deviceContext_t)
		'UPGRADE_WARNING: Couldn't resolve default property of object gDeviceInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		gDeviceInfo = pDeviceInfo
		'UPGRADE_WARNING: Couldn't resolve default property of object gUserData. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		gUserData = pUserData
	End Sub
	
	Public Function attachCallback(ByVal hDevice As Integer) As Boolean
		'
		' This routine should only called from the USB Driver
		' JWG Breakpoint: USB attach callback
		'
		Call getUSB_CallbackParams(m_pDeviceInfo, m_pUserData)
		
		m_pUserData.dwAttachError = WDU_SetInterface(m_pUserData.hDev, m_pUserData.dwInterfaceNum, m_pUserData.dwAlternateSetting)
		
		If (m_pUserData.dwAttachError) Then
			'uc.getError (m_pUserData.dwAttachError)
		Else
			m_flag.DeviceAttached = True
		End If
		
		attachCallback = m_flag.DeviceAttached
		
	End Function
	
	Public Sub detachCallback(ByVal hDevice As Integer)
		'
		' This routine should only called from the USB Driver
		' JWG Breakpoint: USB detach callback
		'
		Call getUSB_CallbackParams(m_pDeviceInfo, m_pUserData)
		
		m_flag.DeviceAttached = False
		
	End Sub
End Module