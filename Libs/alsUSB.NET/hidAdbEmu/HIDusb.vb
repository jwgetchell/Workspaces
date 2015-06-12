Option Strict Off
Option Explicit On
Friend Class ucHIDUsb

    Inherits cUsb2I2c

    Public Function noUsb() As Boolean
        noUsb = gNoUsb
    End Function

    Public Sub getUcCodeCaption(ByRef caption As String)
        caption = caption & "HID"
    End Sub

    Public Sub setHwnd(ByRef hWnd As Integer)
        gHwnd = hWnd
    End Sub

    Public Overrides Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
        DllCallBack = ucHidDllCallBack(RW, addr, data)
    End Function

    'UPGRADE_NOTE: Class_Initialize was upgraded to Class_Initialize_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
    Private Sub Class_Initialize_Renamed()
        gNoUsb = False
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
End Class