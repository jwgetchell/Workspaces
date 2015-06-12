Option Strict Off
Option Explicit On
Module modHIDusb
	
	'Public gNoUsb As Boolean
	'Public gHwnd As Long
	Private connected As Boolean
	
	Private i2cAddr As Byte
	
	Public Function ucHidDllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		
		Dim baddr As Byte : baddr = &HFF And addr
		
		If connected = False Then openDevice()
		If connected = False Then
			gNoUsb = True
		Else
			gNoUsb = False
		End If
		
		If gNoUsb = False Then
			Select Case (RW)
				Case 0 : Call i2cWrite(baddr, data)
				Case 1 : data = i2cRead(baddr)
				Case 2 : Call i2cWriteWord(baddr, data)
				Case 3 : data = i2cReadWord(baddr)
				Case 4 : i2cAddr = addr
				Case 5 : data = i2cAddr
			End Select
			ucHidDllCallBack = 71077345
		Else : ucHidDllCallBack = 4
		End If
	End Function
	
	Sub i2cWrite(ByVal addr As Byte, ByVal data As Short)
		Dim bData(1) As Byte : bData(0) = data And &HFF : bData(1) = (data / 256) And &HFF
		Dim baddr(1) As Byte : baddr(0) = addr And &HFF : baddr(1) = 0
		Call writeI2C(i2cAddr, 1, 1, bData, baddr)
	End Sub
	
	Sub i2cWriteWord(ByVal addr As Byte, ByVal data As Integer)
		Dim bData(1) As Byte : bData(0) = data And &HFF : data = CShort(data And &HFF00) / 256 : bData(1) = data
		Dim baddr(1) As Byte : baddr(0) = addr And &HFF : baddr(1) = 0
		Call writeI2C(i2cAddr, 2, 1, bData, baddr)
	End Sub
	
	
	Function i2cReadWord(ByVal addr As Byte) As Integer
		Dim bData(1) As Byte
		Dim baddr(1) As Byte : baddr(0) = addr And &HFF : baddr(1) = 0
		Call readI2C(i2cAddr, 2, 1, bData, baddr)
		i2cReadWord = bData(1) : i2cReadWord = i2cReadWord * 256
		i2cReadWord = bData(0) + i2cReadWord
	End Function
	
	Function i2cRead(ByVal addr As Byte) As Byte
		Dim bData(1) As Byte
		Dim baddr(1) As Byte : baddr(0) = addr And &HFF : baddr(1) = 0
		Call readI2C(i2cAddr, 1, 1, bData, baddr)
		i2cRead = bData(0) And &HFF
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
			error_Renamed = CStr(99) 'Stat2Str(errorCode) ' JWG Breakpoint: USB transfer errors
			setError((error_Renamed))
		End If
		getError = ErrorCode
	End Function
	
	Private Function openDevice() As Boolean
		openDevice = connect
		connected = openDevice
	End Function
	
	Public Sub HIDcloseDevice()
		closeHandles()
	End Sub
End Module