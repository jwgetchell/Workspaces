VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDutMeasure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pObj As Object
Dim enableError As Boolean
Const sId As String = "clsDutMeasure"

Dim dut As ucALSusb

Sub init(obj As Object, id As String)
    Set pObj = obj
End Sub

Sub setErrorOn(enabled As Boolean)
    enableError = enabled
End Sub

Sub errorMsg(error As String)
    If enableError Then MsgBox error
End Sub

Private Sub Class_Initialize()
    enableError = True
    Set dut = frmMain.ucALSusb1
End Sub

' +___________________________+
' | Standard Public Loop APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub arm(Optional idx As Integer = -1)
    On Error GoTo error
    
    If idx > -1 Then
        pObj.arm (idx)
    Else
        pObj.arm
    End If
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::arm"
end_:
End Sub

Public Function next_(Optional idx As Integer = -1) As Single
    On Error GoTo error
    
    If idx > -1 Then
        next_ = pObj.next_(idx)
    Else
        next_ = pObj.next_
    End If
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::_next"
end_:
End Function

Public Function done() As Boolean
    On Error GoTo error
    
    done = pObj.done
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::done"
end_:
End Function

Public Function getStart() As Single
    On Error GoTo error
    
    getStart = pObj.getStart
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::getStart"
end_:
End Function

Public Function getStop() As Single
    On Error GoTo error
    
    getStop = pObj.getStop
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::getStop"
end_:
End Function

Public Function getStep() As Single
    On Error GoTo error
    
    getStep = pObj.getStep
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::getStep"
end_:
End Function


Public Function getValue(value() As Single, Optional id As Integer = 0) As Boolean
    Dim dval As Double, errNum As Long
    On Error GoTo error
    
    getValue = True
    
    Select Case id
        Case eMeasure.mALS: errNum = dut.dGetLux(dval)
        Case eMeasure.mIR: errNum = dut.dGetIR(dval)
        Case eMeasure.mProx: errNum = dut.dGetProximity(dval)
        Case measIn.prox30_: errNum = dut.dGetProxIR(dval)
    End Select
    
    If errNum Then GoTo error
    
    value(0) = dval
    
    GoTo end_
error:
    errorMsg "Error in " & pObj.sId & "::getValue"
end_:
End Function

' +________________+
' | TestClass APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
Public Function getInterval() As Integer
    
    On Error GoTo error
    
    getInterval = pObj.Interval
    
    GoTo end_
error:
    errorMsg "Error in " & sId & "::getInterval"
end_:
End Function


