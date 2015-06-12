Option Strict Off
Option Explicit On
Friend Class ADBUsb
	Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Integer)
	
	Private connected As Boolean
	Private i2cAddr As Byte
	Private gNoUsb As Boolean
	Private gHwnd As Integer
	Private wsh As New IWshRuntimeLibrary.WshShell
	Private exec As IWshRuntimeLibrary.WshExec
	Private cmdOut As String
	Private intMBError As Short
	
	Public Function noUsb() As Boolean
		noUsb = gNoUsb
	End Function
	
	Public Sub getUcCodeCaption(ByRef caption As String)
		caption = caption & "ADB"
	End Sub
	
	Public Sub setHwnd(ByRef hWnd As Integer)
		gHwnd = hWnd
	End Sub
	
	'Public Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long
	'    DllCallBack = ucHidDllCallBack(RW, addr, data)
	'End Function
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		gNoUsb = False
		connected = False
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	'UPGRADE_NOTE: Class_Terminate was upgraded to Class_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Terminate_Renamed()
		If connected Then
			Call exec.StdIn.WriteLine("exit")
			connected = False
		End If
	End Sub
	Protected Overrides Sub Finalize()
		Class_Terminate_Renamed()
		MyBase.Finalize()
	End Sub
	
	
	
	Public Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		
		Dim baddr As Byte : baddr = &HFF And addr
		
		If connected = False Then openDevice()
		If connected = False Then
			gNoUsb = True
		Else
			gNoUsb = False
		End If
		
		If gNoUsb = False Then
			Select Case (RW)
				Case 0 : Call usJungoUsb.i2cWrite(baddr, data)
				Case 1 : data = usJungoUsb.i2cRead(baddr)
				Case 2 : Call usJungoUsb.i2cWriteWord(baddr, data)
				Case 3 : data = usJungoUsb.i2cReadWord(baddr)
				Case 4 : i2cAddr = addr
				Case 5 : data = i2cAddr
			End Select
			DllCallBack = 71077345
		Else : DllCallBack = 4
		End If
	End Function
	
	Sub i2cWrite(ByVal addr As Byte, ByVal data As Short)
		Call exec.StdIn.WriteLine("./data/i2cset -y 4 0x44 " & addr & " " & data & " b")
		Call flushStdOut("./data/i2cset -y 4 0x44 " & addr & " " & data & " b")
		'exec.StdOut.SkipLine
	End Sub
	
	Sub i2cWriteWord(ByVal addr As Byte, ByVal data As Integer)
		Call exec.StdIn.WriteLine("./data/i2cset -y 4 0x44 " & addr & " " & data & " w")
		Call flushStdOut("./data/i2cset -y 4 0x44 " & addr & " " & data & " w")
		'exec.StdOut.SkipLine
	End Sub
	
	
	Function i2cReadWord(ByVal addr As Byte) As Integer
		Dim reg_data As String
		
		Call exec.StdIn.WriteLine("./data/i2cget -y 4 0x44 " & addr & " w")
		Call flushStdOut("./data/i2cget -y 4 0x44 " & addr & " w")
		'exec.StdOut.SkipLine
		'exec.StdOut.SkipLine
		reg_data = exec.StdOut.ReadLine
		While InStr(reg_data, "i2c") <> 0
			reg_data = exec.StdOut.ReadLine
		End While
		reg_data = "&H" & Mid(reg_data, 3, 2) & Mid(reg_data, 5, 2) 'Replace(reg_data, "0x", "&H")
		i2cReadWord = CShort(reg_data)
		
	End Function
	
	Function i2cRead(ByVal addr As Byte) As Byte
		Dim reg_data As String
		
		Call exec.StdIn.WriteLine("./data/i2cget -y 4 0x44 " & addr & " b")
		Call flushStdOut("./data/i2cget -y 4 0x44 " & addr & " b")
		'exec.StdOut.SkipLine
		
		reg_data = exec.StdOut.ReadLine
		While InStr(reg_data, "i2c") <> 0
			reg_data = exec.StdOut.ReadLine
		End While
		reg_data = Replace(reg_data, "0x", "&H")
		i2cRead = CByte(reg_data)
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
		intMBError = MsgBoxResult.OK
		On Error GoTo noAndroid
		While (Not connected And Not (intMBError = MsgBoxResult.Cancel))
			exec = wsh.exec("C:\Program Files\Android\android-sdk\platform-tools\adb.exe shell")
			dllCallBackFunction.Sleep((5))
			connected = Not exec.StdOut.AtEndOfStream
			
			If Not connected Then
				intMBError = MsgBox("Phone not detected. Make sure it\nis connected and debug enabled.", MsgBoxStyle.RetryCancel)
			End If
		End While
		openDevice = connected
		
noAndroid: 
		
		If connected Then
			'Disable Driver to allow I2C comm
			Call exec.StdIn.WriteLine("echo 4-0044> /sys/bus/i2c/drivers/isl29044/unbind")
			'Enable I2Ctools
			Call exec.StdIn.WriteLine("busybox cp /mnt/sdcard/i2ctools/i2cget /data/i2cget")
			Call exec.StdIn.WriteLine("chmod 777 /data/i2cget")
			Call exec.StdIn.WriteLine("busybox cp /mnt/sdcard/i2ctools/i2cset /data/i2cset")
			Call exec.StdIn.WriteLine("chmod 777 /data/i2cset")
			Call flushStdOut("chmod 777 /data/i2cset")
		End If
		
	End Function
	
	Private Sub flushStdOut(ByRef last_cmd As String)
		Dim Shell_out As String
		Shell_out = "None"
		
		While InStr(Shell_out, last_cmd) = 0
			Shell_out = exec.StdOut.ReadLine
		End While
		
	End Sub
End Class