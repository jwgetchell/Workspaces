VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsMSComm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Dim fileNum As Integer

Public Sub init(port As Integer)
    fileNum = FreeFile
    Open "COM" & port For Random As #fileNum
End Sub

Public Function readComm() As String
    Input #fileNum, readComm
End Function

Public Sub writeComm(str As String)
    Print #fileNum, str & Chr$(13)
End Sub

Private Sub Class_Terminate()
    If fileNum <> 0 Then Close #fileNum
End Sub
