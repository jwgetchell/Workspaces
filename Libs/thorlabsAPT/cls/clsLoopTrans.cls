VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLoopTrans"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pAPT As ucThorlabsAPT

Dim enableError As Boolean
Const sId As String = "clsLoopTrans"
Dim ucIdx As Integer

'Dim start As Single, stop_ As Single, step As Single, nInc As Integer, inc As Integer

Public Sub init(Optional idx As Integer = 0)
    ucIdx = idx
    Set pAPT = frmThorlabsAPT.ucThorlabsAPT1(idx)
End Sub

Sub setErrorOn(enabled As Boolean)
    enableError = enabled
End Sub

Sub errorMsg(error As String)
    If enableError Then MsgBox "Error in " & sId & error
End Sub

Private Sub Class_Initialize()
    enableError = True
    ucIdx = -1
End Sub

' +______________________+
' | Standard Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub arm(Optional idx As Integer = -1)
    On Error GoTo error
    
    'start = pAPT.getStart
    'stop_ = pAPT.getStop
    'step = pAPT.getStep
    
    'nInc = (stop_ - start) / step + 1
    
    If idx > -1 Then
        pAPT.arm
    Else
        pAPT.arm
    End If
    
    GoTo end_
error:
    errorMsg ".arm"
end_:
End Sub

Public Function next_(Optional idx As Integer = -1) As Single
    On Error GoTo error
    
    If idx > -1 Then
        pAPT.next_
    Else
        pAPT.next_
    End If
    
    GoTo end_
error:
    errorMsg ":_next"
end_:
End Function

Public Function done() As Boolean
    On Error GoTo error
    
    done = pAPT.done
    
    GoTo end_
error:
    errorMsg ":done"
end_:

End Function

' +________________________+
' | Additional Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Function getStart() As Single
    getStart = pAPT.getStart
End Function

Public Function getStop() As Single
    getStop = pAPT.getStop
End Function

Public Function getStep() As Single
    getStep = pAPT.getStep
End Function


