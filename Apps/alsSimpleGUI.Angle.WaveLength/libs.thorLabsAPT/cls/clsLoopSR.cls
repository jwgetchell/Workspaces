VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLoopSR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pAPT As frmThorlabsAPT

Dim enableError As Boolean
Const sId As String = "clsSrLoop"

Public Sub init()

End Sub

Sub setErrorOn(enabled As Boolean)
    enableError = enabled
End Sub

Sub errorMsg(error As String)
    If enableError Then MsgBox error
End Sub

Private Sub Class_Initialize()
    enableError = True
    Set pAPT = frmThorlabsAPT
End Sub

' +______________________+
' | Standard Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub arm(Optional idx As Integer = -1)
    On Error GoTo error
    
    If idx > -1 Then
        pAPT.armSR
    Else
        pAPT.armSR
    End If
    
    GoTo end_
error:
    errorMsg "Error in " & sId & ":arm"
end_:
End Sub

Public Function next_(Optional idx As Integer = -1) As Single
    On Error GoTo error
    
    If idx > -1 Then
        next_ = pAPT.nextSR(idx)
    Else
        next_ = pAPT.nextSR
    End If
    
    GoTo end_
error:
    errorMsg "Error in " & sId & ":_next"
end_:
End Function

Public Function done() As Boolean
    On Error GoTo error
    
    done = pAPT.done
    
    GoTo end_
error:
    errorMsg "Error in " & sId & ":done"
end_:

End Function

