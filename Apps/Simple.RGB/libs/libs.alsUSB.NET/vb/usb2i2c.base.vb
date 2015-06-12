Public Class cUsb2I2c

    ' =====================
    ' >>>>> OVERRIDES <<<<<
    ' =====================

    Public Sub getUcCodeCaption(ByRef caption As String)
        caption = caption & "Base Class"
    End Sub

    Public Overridable Function DllCallBack(ByVal RW As Integer, ByVal addr As Integer, ByRef data As Integer) As Integer
        DllCallBack = udCallBack(RW, addr, data)
    End Function






    ' ====================
    ' >>>>>> COMMON <<<<<<
    ' ====================

    Public Function noUsb() As Boolean
        noUsb = gNoUsb
    End Function

    Public Sub setHwnd(ByRef hWnd As Integer)
        gHwnd = hWnd
    End Sub

    Public Sub New()
        MyBase.New()
        gNoUsb = True
    End Sub

    Protected Overrides Sub Finalize()
        Call closeDevice()
        MyBase.Finalize()
    End Sub

End Class
