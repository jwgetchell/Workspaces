Option Strict Off
Option Explicit On
Friend Class ucEmuUsb
	
    Inherits cUsb2I2c

    Private Declare Function cSetDevice Lib "registerEmulator" (ByVal c As Integer) As Integer
	Private Declare Function cSetData Lib "registerEmulator" (ByVal c As Integer, ByRef d As Double) As Integer
	
	Private data() As Double
	Private decimation As Integer
	
	Public Function noUsb() As Boolean
        noUsb = gNoUsb
	End Function
	
	Public Sub getUcCodeCaption(ByRef caption As String)
		caption = caption & "Emulation"
	End Sub
	
	Public Sub setHwnd(ByRef hWnd As Integer)
		gHwnd = hWnd
	End Sub
	
	Public Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		DllCallBack = udCallBack(RW, addr, data)
	End Function
	
	'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Initialize_Renamed()
		gNoUsb = True
	End Sub
	Public Sub New()
		MyBase.New()
		Class_Initialize_Renamed()
	End Sub
	
	'UPGRADE_NOTE: Class_Terminate was upgraded to Class_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Terminate_Renamed()
		Call closeDevice()
	End Sub
	Protected Overrides Sub Finalize()
		Class_Terminate_Renamed()
		MyBase.Finalize()
	End Sub
	
	Public Sub setDecimation(ByVal v As Integer)
		If (v) Then
			If (v < gSize) Then decimation = v
		End If
	End Sub
	
	Public Sub setDevice(ByVal d As Integer)
		Call cSetDevice(d)
	End Sub
	
	Public Sub setDataFile(ByVal file As String)
		Dim buf As Double
		Index = 0 : gSize = 0
		
		FileOpen(1, file, OpenMode.Input)
		Do Until EOF(1)
			Input(1, buf) : gSize = gSize + 1
		Loop 
		FileClose()
		
		ReDim data(gSize - 1)
		FileOpen(2, file, OpenMode.Input)
		For Index = 0 To gSize - 1
			Input(2, data(Index))
		Next Index
		Index = 0 : FileClose()
		Call cSetData(gSize, data(0))
	End Sub
End Class