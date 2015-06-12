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
Attribute VB_Exposed = False
Private fileNum As Integer
Private port As Integer
Dim toggleOpen As Boolean

'Private Enum cmPorts
'    cpFW0 = 3 ' filter wheels
'    cpFW1 = 2
'    cpLM = 4 ' Lux meter
'    cpPL = 6 ' Prologix GPIB
'    cpCM = 7 ' Chroma meter
'End Enum


Public Sub setPort(ByVal value As Integer)
    On Error GoTo error
    toggleOpen = False
    port = value
    If Not toggleOpen Then
        fileNum = FreeFile
        Open "COM" & port & ":9600,E,7,1" For Binary Access Read Write As #fileNum
    End If
    
    GoTo exitsub
error:     MsgBox "error reading: " & Err.Description
exitsub: End Sub

Public Function readComm(Optional ByVal term As String = vbCr) As String
    Dim char As String: char = String(10, " ")
    
    On Error GoTo error
    If toggleOpen Then
        fileNum = FreeFile: Open "COM" & port & ":9600,E,7,1" For Binary Access Read Write As #fileNum
    End If
    Do
        Get #fileNum, , char
        readComm = readComm & char
    Loop Until char = term
    
    If toggleOpen Then
        Close #fileNum
    End If
    
    GoTo exitsub
error:     MsgBox "error reading: " & Err.Description
exitsub: End Function

Public Sub writeComm(ByVal str As String)
    Dim char As String
    On Error GoTo error
        
    If toggleOpen Then
        fileNum = FreeFile: Open "COM" & port & ":9600,E,7,1" For Binary Access Write As #fileNum
    End If
    
    'Put #fileNum, Len(str) + 1, str & Chr$(13)
    Put #fileNum, , str
    
    If toggleOpen Then Close #fileNum
    
    Debug.Print fileNum, port, str
    GoTo exitsub
error:     MsgBox "error writing: " & Err.Description
exitsub: End Sub

Private Sub Class_Terminate()
    If fileNum <> 0 Then
        If Not toggleOpen Then Close #fileNum
        fileNum = 0
    End If
End Sub


