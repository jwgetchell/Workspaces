VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsDVM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pObj As Object
Dim enableError As Boolean
Const sId As String = "ucMonochromator::clsDVM"

Sub setErrorOn(enabled As Boolean)
    enableError = enabled
End Sub

Sub errorMsg(error As String)
    If enableError Then MsgBox error
End Sub

Private Sub Class_Initialize()
    enableError = True
End Sub

' +______________________+
' | Standard Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Function getValue(value() As Single, ByVal id As Integer) As Boolean
    On Error GoTo error
    
    getValue = True
    
    value(0) = frmMonochromator.ucMonochromator1.getVolts
    
    GoTo end_
error:
    errorMsg "Error in " & sId & ":getValue"
end_:
End Function

