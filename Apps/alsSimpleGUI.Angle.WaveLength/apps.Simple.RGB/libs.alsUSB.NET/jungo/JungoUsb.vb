Option Strict Off
Option Explicit On
Friend Class ucJungoUsb
	
    Inherits cUsb2I2c

    Public Function noUsb() As Boolean
        noUsb = gNoUsb
    End Function
	
	Public Sub getUcCodeCaption(ByRef caption As String)
		caption = caption & "Jungo"
	End Sub
	
	Public Sub setHwnd(ByRef hWnd As Integer)
		gHwnd = hWnd
	End Sub
	
	Public Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
		DllCallBack = udCallBack(RW, addr, data)
	End Function
	
	'UPGRADE_NOTE: Class_Terminate was upgraded to Class_Terminate_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Private Sub Class_Terminate_Renamed()
		Call closeDevice()
	End Sub
	Protected Overrides Sub Finalize()
		Class_Terminate_Renamed()
		MyBase.Finalize()
	End Sub
End Class