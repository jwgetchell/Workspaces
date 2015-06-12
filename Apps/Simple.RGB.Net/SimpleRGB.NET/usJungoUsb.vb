Option Strict Off
Option Explicit On
Module usJungoUsb
	
	Dim dwError, i2cAddr, i As Integer
	Private m_hDriver, m_dwDevAddr As Integer
	
	Public gNoUsb As Boolean
	Public gHwnd As Integer
	
	'Private Type t_flag
	'    DeviceOpened As Boolean
	'    DeviceAttached As Boolean
	'End Type
	
	Public Structure WDU_TransferParams
		Dim hDevice As Integer
		Dim dwPipeNum As Integer
		Dim fRead As Integer
		Dim dwOptions As Integer
		<VBFixedArray(5)> Dim pBuffer() As Byte
		Dim dwBufferSize As Integer
		Dim pdwBytesTransferred As Integer
		<VBFixedArray(7)> Dim pSetupPacket() As Byte
		Dim dwTimeout As Integer
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim pBuffer(5)
			ReDim pSetupPacket(7)
		End Sub
	End Structure
	
	Public Structure deviceContext_t
		Dim dwInterfaceNum As Integer
		Dim dwAlternateSetting As Integer
		Dim hDev As Integer
		Dim hEvent As Integer
		Dim dwAttachError As Integer
	End Structure
	
	Private gDeviceInfo As WDU_DEVICE
	'Private gUserData As deviceContext_t
	Private m_pUserData As deviceContext_t
	
	'UPGRADE_WARNING: Arrays in structure m_i2c_byteWriteParams may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
	Private m_i2c_byteWriteParams As WDU_TransferParams
	'UPGRADE_WARNING: Arrays in structure m_i2c_wordWriteParams may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
	Private m_i2c_wordWriteParams As WDU_TransferParams
	'UPGRADE_WARNING: Array m_i2c_byteReadParams may need to have individual elements initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B97B714D-9338-48AC-B03F-345B617E2B02"'
	Private m_i2c_byteReadParams(3) As WDU_TransferParams
	
	Const DEFAULT_VENDOR_ID As Integer = &H9AA
	Const DEFAULT_PRODUCT_ID As Integer = &H2005 ''ALS 2005  dcp update 2009
	Const DEFAULT_INTERFACE_NUM As Integer = 0
	Const DEFAULT_ALTERNATE_SETTING As Integer = 0
	Const DEFAULT_LICENSE_STRING As String = "6f1ea7e369bc928352c09870801b16975637b4386efab2.Intersil"
	
	Public Function udCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		If gNoUsb = False Then
			Select Case (RW)
				Case 0 : Call i2cWrite(addr, data)
				Case 1 : data = i2cRead(addr)
				Case 2 : Call i2cWriteWord(addr, data)
				Case 3 : data = i2cReadWord(addr)
				Case 4 : i2cAddr = addr
			End Select
			udCallBack = 71077345
		Else : udCallBack = 4
		End If
	End Function
	
	Sub i2cWrite(ByVal address As Byte, ByVal data As Short)
		
		If (m_flag.DeviceOpened = False) Then openDevice()
		
		m_i2c_byteWriteParams.pBuffer(1) = i2cAddr + 0
		m_i2c_byteWriteParams.pBuffer(2) = address
		m_i2c_byteWriteParams.pBuffer(3) = (data And 255)
		
		'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		dwError = getError(WDU_Transfer_Renamed(m_i2c_byteWriteParams.hDevice, m_i2c_byteWriteParams.dwPipeNum, m_i2c_byteWriteParams.fRead, m_i2c_byteWriteParams.dwOptions, VarPtr(m_i2c_byteWriteParams.pBuffer(0)), m_i2c_byteWriteParams.dwBufferSize, m_i2c_byteWriteParams.pdwBytesTransferred, VarPtr(m_i2c_byteWriteParams.pSetupPacket(0)), m_i2c_byteWriteParams.dwTimeout))
		dllCallBackFunction.Sleep((2))
		
	End Sub
	
	Sub i2cWriteWord(ByVal address As Byte, ByVal data As Integer)
		
		If (m_flag.DeviceOpened = False) Then openDevice()
		
		m_i2c_wordWriteParams.pBuffer(1) = i2cAddr
		m_i2c_wordWriteParams.pBuffer(2) = address
		m_i2c_wordWriteParams.pBuffer(3) = data And 255
		data = CShort(data And &HFF00) / 256
		m_i2c_wordWriteParams.pBuffer(4) = data And 255
		
		'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		dwError = getError(WDU_Transfer_Renamed(m_i2c_wordWriteParams.hDevice, m_i2c_wordWriteParams.dwPipeNum, m_i2c_wordWriteParams.fRead, m_i2c_wordWriteParams.dwOptions, VarPtr(m_i2c_wordWriteParams.pBuffer(0)), m_i2c_wordWriteParams.dwBufferSize, m_i2c_wordWriteParams.pdwBytesTransferred, VarPtr(m_i2c_wordWriteParams.pSetupPacket(0)), m_i2c_wordWriteParams.dwTimeout))
		dllCallBackFunction.Sleep((2))
		
	End Sub
	
	
	Function i2cReadWord(ByVal address As Byte) As Integer
		
		If (m_flag.DeviceOpened = False) Then openDevice()
		
		m_i2c_byteReadParams(2).pBuffer(1) = i2cAddr + 1
		m_i2c_byteReadParams(2).pBuffer(2) = address
		
		For i = 2 To 3
			
			'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
			dwError = getError(WDU_Transfer_Renamed(m_i2c_byteReadParams(i).hDevice, m_i2c_byteReadParams(i).dwPipeNum, m_i2c_byteReadParams(i).fRead, m_i2c_byteReadParams(i).dwOptions, VarPtr(m_i2c_byteReadParams(i).pBuffer(0)), m_i2c_byteReadParams(i).dwBufferSize, m_i2c_byteReadParams(i).pdwBytesTransferred, VarPtr(m_i2c_byteReadParams(i).pSetupPacket(0)), m_i2c_byteReadParams(i).dwTimeout))
			
			dllCallBackFunction.Sleep((2))
			
		Next i
		
		i2cReadWord = m_i2c_byteReadParams(3).pBuffer(2)
		i2cReadWord = i2cReadWord * 256
		i2cReadWord = i2cReadWord + m_i2c_byteReadParams(3).pBuffer(1)
		
	End Function
	
	Function i2cRead(ByVal address As Byte) As Byte
		
		If (m_flag.DeviceOpened = False) Then openDevice()
		
		m_i2c_byteReadParams(0).pBuffer(1) = i2cAddr + 1
		m_i2c_byteReadParams(0).pBuffer(2) = address
		
		For i = 0 To 1
			
			'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
			dwError = getError(WDU_Transfer_Renamed(m_i2c_byteReadParams(i).hDevice, m_i2c_byteReadParams(i).dwPipeNum, m_i2c_byteReadParams(i).fRead, m_i2c_byteReadParams(i).dwOptions, VarPtr(m_i2c_byteReadParams(i).pBuffer(0)), m_i2c_byteReadParams(i).dwBufferSize, m_i2c_byteReadParams(i).pdwBytesTransferred, VarPtr(m_i2c_byteReadParams(i).pSetupPacket(0)), m_i2c_byteReadParams(i).dwTimeout))
			
			dllCallBackFunction.Sleep((2))
			
		Next i
		
		i2cRead = m_i2c_byteReadParams(1).pBuffer(1)
		
	End Function
	
	'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub setError(ByRef error_Renamed As String)
		'debugWrite error
		MsgBox(error_Renamed)
		If error_Renamed = "Device not found" Then gNoUsb = True
		If error_Renamed = "Timeout expired" Then gNoUsb = True
	End Sub
	
	Public Function getError(ByRef ErrorCode As Integer) As Integer
		
		'UPGRADE_NOTE: error was upgraded to error_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim error_Renamed As String
		
		If (ErrorCode) Then
			error_Renamed = Stat2Str(ErrorCode) ' JWG Breakpoint: USB transfer errors
			setError((error_Renamed))
		End If
		getError = ErrorCode
	End Function
	
	Private Sub SetEventTable(ByRef eventTable As WDU_EVENT_TABLE, ByRef attachCb As Integer, ByRef detachCb As Integer)
		eventTable.pfDeviceAttach = attachCb
		eventTable.pfDeviceDetach = detachCb
	End Sub
	
	Private Sub waitForCallBack(Optional ByRef noMsg As Boolean = False)
		'
		' wait for call back from USB driver, set in "attachCallback"
		'
		Dim TimeOut As Short
		TimeOut = 3000
		
		For i = 0 To TimeOut
			If (m_flag.DeviceAttached) Then
				Exit For
			Else
				System.Windows.Forms.Application.DoEvents() : dllCallBackFunction.Sleep((1))
			End If
		Next i
		
		If (i > TimeOut) Then If noMsg = False Then setError(("callback timeout"))
		
	End Sub
	
	Private Sub openDevice()
		
		Dim matchTable As WDU_MATCH_TABLE
		Dim eventTable As WDU_EVENT_TABLE
		
		matchTable.wVendorId = CShort(DEFAULT_VENDOR_ID And &H7FFF) - CShort(DEFAULT_VENDOR_ID And &H8000)
		matchTable.wProductId = CShort(DEFAULT_PRODUCT_ID And &H7FFF) - CShort(DEFAULT_PRODUCT_ID And &H8000)
		
		m_pUserData.dwInterfaceNum = DEFAULT_INTERFACE_NUM
		m_pUserData.dwAlternateSetting = DEFAULT_ALTERNATE_SETTING
		
		'UPGRADE_WARNING: Add a delegate for AddressOf USBdetachCallback Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="E9E157F7-EF0C-4016-87B7-7D7FBBC6EE08"'
		'UPGRADE_WARNING: Add a delegate for AddressOf USBattachCallback Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="E9E157F7-EF0C-4016-87B7-7D7FBBC6EE08"'
		Call SetEventTable(eventTable, AddressOf USBattachCallback, AddressOf USBdetachCallback)
		'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		eventTable.pUserData = VarPtr(m_pUserData)
		
		'UPGRADE_WARNING: Couldn't resolve default property of object eventTable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object matchTable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		dwError = getError(WDU_Init(m_hDriver, matchTable, 1, eventTable, DEFAULT_LICENSE_STRING, WD_ACKNOWLEDGE, gHwnd))
		' JWG true added to supress msgbox
		waitForCallBack((True)) ' note do not break between WDU_init & callback
		' This will prevent callback from being made
		
		' JWG issue m_dwDevAddr parameter wants to be a pointer to pointer **
		'UPGRADE_ISSUE: VarPtr function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		dwError = getError(WDU_GetDeviceInfo(m_pUserData.hDev, VarPtr(m_dwDevAddr)))
		
		If (dwError = 0) Then
			m_flag.DeviceOpened = True
		End If
		
		' _______________________________________________________
		m_i2c_byteWriteParams.hDevice = m_pUserData.hDev ' byteWriteParams
		m_i2c_byteWriteParams.dwPipeNum = 2
		m_i2c_byteWriteParams.fRead = 0 ' R/W
		m_i2c_byteWriteParams.dwOptions = 0
		m_i2c_byteWriteParams.pBuffer(0) = 0 ' read count (bytes)
		m_i2c_byteWriteParams.pBuffer(1) = i2cAddr + 0 ' I2C address (set in function)
		m_i2c_byteWriteParams.pBuffer(2) = 0 ' Index ???
		m_i2c_byteWriteParams.pBuffer(3) = 0
		m_i2c_byteWriteParams.pBuffer(4) = 0
		m_i2c_byteWriteParams.pBuffer(5) = 0
		m_i2c_byteWriteParams.dwBufferSize = 4
		m_i2c_byteWriteParams.pdwBytesTransferred = 4
		m_i2c_byteWriteParams.pSetupPacket(0) = 0
		m_i2c_byteWriteParams.pSetupPacket(1) = 0
		m_i2c_byteWriteParams.pSetupPacket(2) = 0
		m_i2c_byteWriteParams.pSetupPacket(3) = 0
		m_i2c_byteWriteParams.pSetupPacket(4) = 0
		m_i2c_byteWriteParams.pSetupPacket(5) = 0
		m_i2c_byteWriteParams.pSetupPacket(6) = 0
		m_i2c_byteWriteParams.pSetupPacket(7) = 0
		m_i2c_byteWriteParams.dwTimeout = 1000 'TRANSFER_TIMEOUT
		
		' _______________________________________________________
		m_i2c_wordWriteParams.hDevice = m_pUserData.hDev ' wordWriteParams
		m_i2c_wordWriteParams.dwPipeNum = 2
		m_i2c_wordWriteParams.fRead = 0 ' R/W
		m_i2c_wordWriteParams.dwOptions = 0
		m_i2c_wordWriteParams.pBuffer(0) = 0 ' read count (words)
		m_i2c_wordWriteParams.pBuffer(1) = i2cAddr + 0 ' I2C address (set in function)
		m_i2c_wordWriteParams.pBuffer(2) = 0 ' Index ???
		m_i2c_wordWriteParams.pBuffer(3) = 0
		m_i2c_wordWriteParams.pBuffer(4) = 0
		m_i2c_wordWriteParams.pBuffer(5) = 0
		m_i2c_wordWriteParams.dwBufferSize = 5
		m_i2c_wordWriteParams.pdwBytesTransferred = 5
		m_i2c_wordWriteParams.pSetupPacket(0) = 0
		m_i2c_wordWriteParams.pSetupPacket(1) = 0
		m_i2c_wordWriteParams.pSetupPacket(2) = 0
		m_i2c_wordWriteParams.pSetupPacket(3) = 0
		m_i2c_wordWriteParams.pSetupPacket(4) = 0
		m_i2c_wordWriteParams.pSetupPacket(5) = 0
		m_i2c_wordWriteParams.pSetupPacket(6) = 0
		m_i2c_wordWriteParams.pSetupPacket(7) = 0
		m_i2c_wordWriteParams.dwTimeout = 1000 'TRANSFER_TIMEOUT
		
		' _____________________________________________________
		m_i2c_byteReadParams(0).hDevice = m_pUserData.hDev ' byteReadParams
		m_i2c_byteReadParams(0).dwPipeNum = 2
		m_i2c_byteReadParams(0).fRead = 0 ' R/W, 1st write command
		m_i2c_byteReadParams(0).dwOptions = 0
		m_i2c_byteReadParams(0).pBuffer(0) = 1 ' #/bytes 2 read
		m_i2c_byteReadParams(0).pBuffer(1) = i2cAddr + 1 ' ic2 addr
		m_i2c_byteReadParams(0).pBuffer(2) = 0 ' Index ??
		m_i2c_byteReadParams(0).pBuffer(3) = 0
		m_i2c_byteReadParams(0).pBuffer(4) = 0
		m_i2c_byteReadParams(0).pBuffer(5) = 0
		m_i2c_byteReadParams(0).dwBufferSize = 3
		m_i2c_byteReadParams(0).pdwBytesTransferred = 3 ' return value
		m_i2c_byteReadParams(0).pSetupPacket(0) = 0
		m_i2c_byteReadParams(0).pSetupPacket(1) = 0
		m_i2c_byteReadParams(0).pSetupPacket(2) = 0
		m_i2c_byteReadParams(0).pSetupPacket(3) = 0
		m_i2c_byteReadParams(0).pSetupPacket(4) = 0
		m_i2c_byteReadParams(0).pSetupPacket(5) = 0
		m_i2c_byteReadParams(0).pSetupPacket(6) = 0
		m_i2c_byteReadParams(0).pSetupPacket(7) = 0
		m_i2c_byteReadParams(0).dwTimeout = 1000 'TRANSFER_TIMEOUT
		' _____________________________________________________
		m_i2c_byteReadParams(1).hDevice = m_pUserData.hDev ' byteReadParams
		m_i2c_byteReadParams(1).dwPipeNum = m_i2c_byteReadParams(0).dwPipeNum + &H80
		m_i2c_byteReadParams(1).fRead = 1
		m_i2c_byteReadParams(1).dwOptions = 0
		m_i2c_byteReadParams(1).pBuffer(0) = 0 ' #/bytes 2 read
		m_i2c_byteReadParams(1).pBuffer(1) = 0 ' ic2 addr ???
		m_i2c_byteReadParams(1).pBuffer(2) = 0 ' Index ??
		m_i2c_byteReadParams(1).pBuffer(3) = 0
		m_i2c_byteReadParams(1).pBuffer(4) = 0
		m_i2c_byteReadParams(1).pBuffer(5) = 0
		m_i2c_byteReadParams(1).dwBufferSize = m_i2c_byteReadParams(0).pBuffer(0) + 5
		m_i2c_byteReadParams(1).pdwBytesTransferred = 2
		m_i2c_byteReadParams(1).pSetupPacket(0) = 0
		m_i2c_byteReadParams(1).pSetupPacket(1) = 0
		m_i2c_byteReadParams(1).pSetupPacket(2) = 0
		m_i2c_byteReadParams(1).pSetupPacket(3) = 0
		m_i2c_byteReadParams(1).pSetupPacket(4) = 0
		m_i2c_byteReadParams(1).pSetupPacket(5) = 0
		m_i2c_byteReadParams(1).pSetupPacket(6) = 0
		m_i2c_byteReadParams(1).pSetupPacket(7) = 0
		m_i2c_byteReadParams(1).dwTimeout = 1000 'TRANSFER_TIMEOUT
		
		' _____________________________________________________
		m_i2c_byteReadParams(2).hDevice = m_pUserData.hDev ' wordReadParams
		m_i2c_byteReadParams(2).dwPipeNum = 2
		m_i2c_byteReadParams(2).fRead = 0 ' R/W, 1st write command
		m_i2c_byteReadParams(2).dwOptions = 0
		m_i2c_byteReadParams(2).pBuffer(0) = 2 ' #/bytes 2 read
		m_i2c_byteReadParams(2).pBuffer(1) = i2cAddr + 1 ' ic2 addr
		m_i2c_byteReadParams(2).pBuffer(2) = 0 ' Index ??
		m_i2c_byteReadParams(2).pBuffer(3) = 0
		m_i2c_byteReadParams(2).pBuffer(4) = 0
		m_i2c_byteReadParams(2).pBuffer(5) = 0
		m_i2c_byteReadParams(2).dwBufferSize = 3
		m_i2c_byteReadParams(2).pdwBytesTransferred = 3 ' return value
		m_i2c_byteReadParams(2).pSetupPacket(0) = 0
		m_i2c_byteReadParams(2).pSetupPacket(1) = 0
		m_i2c_byteReadParams(2).pSetupPacket(2) = 0
		m_i2c_byteReadParams(2).pSetupPacket(3) = 0
		m_i2c_byteReadParams(2).pSetupPacket(4) = 0
		m_i2c_byteReadParams(2).pSetupPacket(5) = 0
		m_i2c_byteReadParams(2).pSetupPacket(6) = 0
		m_i2c_byteReadParams(2).pSetupPacket(7) = 0
		m_i2c_byteReadParams(2).dwTimeout = 1000 'TRANSFER_TIMEOUT
		' _____________________________________________________
		m_i2c_byteReadParams(3).hDevice = m_pUserData.hDev ' wordReadParams
		m_i2c_byteReadParams(3).dwPipeNum = m_i2c_byteReadParams(0).dwPipeNum + &H80
		m_i2c_byteReadParams(3).fRead = 1
		m_i2c_byteReadParams(3).dwOptions = 0
		m_i2c_byteReadParams(3).pBuffer(0) = 0 ' #/bytes 2 read
		m_i2c_byteReadParams(3).pBuffer(1) = 0 ' ic2 addr ???
		m_i2c_byteReadParams(3).pBuffer(2) = 0 ' Index ??
		m_i2c_byteReadParams(3).pBuffer(3) = 0
		m_i2c_byteReadParams(3).pBuffer(4) = 0
		m_i2c_byteReadParams(3).pBuffer(5) = 0
		m_i2c_byteReadParams(3).dwBufferSize = m_i2c_byteReadParams(2).pBuffer(0) + 5
		m_i2c_byteReadParams(3).pdwBytesTransferred = 2
		m_i2c_byteReadParams(3).pSetupPacket(0) = 0
		m_i2c_byteReadParams(3).pSetupPacket(1) = 0
		m_i2c_byteReadParams(3).pSetupPacket(2) = 0
		m_i2c_byteReadParams(3).pSetupPacket(3) = 0
		m_i2c_byteReadParams(3).pSetupPacket(4) = 0
		m_i2c_byteReadParams(3).pSetupPacket(5) = 0
		m_i2c_byteReadParams(3).pSetupPacket(6) = 0
		m_i2c_byteReadParams(3).pSetupPacket(7) = 0
		m_i2c_byteReadParams(3).dwTimeout = 1000 'TRANSFER_TIMEOUT
		
	End Sub
	
	Public Sub closeDevice()
		
		If (m_flag.DeviceOpened = True) Then
			
			getError(WDU_ResetDevice(m_pUserData.hDev, 0))
			WDU_Uninit(m_hDriver)
			WD_Close((m_hDriver))
			
			m_flag.DeviceOpened = False
		End If
		m_flag.DeviceAttached = False
		
	End Sub
End Module