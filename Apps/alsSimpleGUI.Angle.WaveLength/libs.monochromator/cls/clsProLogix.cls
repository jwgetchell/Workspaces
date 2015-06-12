VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsProLogix"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim m_devs(32) As String

Dim comPtr As MSComm
Dim term As String

Function GPIBopen(Dev As Integer, ins As instr, Optional ByRef cp As MSComm) As Boolean
    On Error GoTo subExit
    Set comPtr = cp
    m_devs(ins) = "++addr " & Dev
    If (Not comPtr.PortOpen) Then
        comPtr.PortOpen = True
        comPtr.Output = "++mode 1" & term ' controller
        comPtr.Output = "++auto 0" & term ' don't read after write
    End If
    GPIBopen = True
subExit:
End Function

Sub GPIBclose(ins As instr)
    On Error GoTo subExit
    comPtr.PortOpen = False
subExit:
End Sub

Sub GPIBwrite(msg As String, ins As instr)
    On Error GoTo subExit
    comPtr.Output = m_devs(ins) & term
    comPtr.Output = msg & term
subExit:
End Sub

Function GPIBread(msg As String, ins As instr) As String
    Dim i As Integer
    On Error GoTo subExit
    If msg <> "" Then
        Call GPIBwrite(msg, ins)
        comPtr.Output = "++read eoi" & term
        For i = 1 To 10
            Sleep 20
            'DoEvents
        Next i
    End If
    GPIBread = comPtr.Input
subExit:
End Function

Private Sub Class_Initialize()
    term = Chr$(10) & Chr$(13)
End Sub
