VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsGPIB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Enum enumGpibSelect
    unSelected
    NIGPIBselected
    HPIBselected
    PrologicSelected
End Enum

Dim hw As Object
Dim ni As clsNIGPIB
Dim hp As clsHPIB
Dim pl As clsProLogix
Dim comPort As MSComm

Dim GpibSelect As enumGpibSelect

Sub GPIBinitSelect(Optional dev As Integer = 1, Optional cp As MSComm)
    GpibSelect = dev
    Select Case GpibSelect
        Case NIGPIBselected: Set hw = ni
        Case HPIBselected: Set hw = hp
        Case PrologicSelected: Set hw = pl: Set comPort = cp
    Case Else
    End Select
End Sub

Function GPIBopen(dev As Integer, ins As instr, Optional cp As MSComm) As Boolean
    If GpibSelect = unSelected Then GoTo subExit
    GPIBopen = hw.GPIBopen(dev, ins, comPort)
    On Error GoTo subExit
subExit:
End Function

Sub GPIBclose(ins As instr)
    If GpibSelect = unSelected Then GoTo subExit
    On Error GoTo subExit
subExit:
End Sub

Sub GPIBwrite(msg As String, ins As instr)
    If GpibSelect = unSelected Then GoTo subExit
    Call hw.GPIBwrite(msg, ins)
    On Error GoTo subExit
subExit:
End Sub

Function GPIBread(msg As String, ins As instr) As String
    If GpibSelect = unSelected Then GoTo subExit
    GPIBread = hw.GPIBread(msg, ins)
    On Error GoTo subExit
subExit:
End Function

Private Sub Class_Initialize()
    Set ni = New clsNIGPIB
    Set hp = New clsHPIB
    Set pl = New clsProLogix
End Sub
