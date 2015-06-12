Attribute VB_Name = "modDefinitions"
Option Explicit

Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Declare Function GetTickCount Lib "kernel32" () As Long

Public MG17Enabled As Boolean

Type srPath
    x As Integer
    y As Integer
End Type

'Public Function enterText(ByRef text As String) As Integer
'    ' strip [cr] & [lf], return > 0
'    enterText = InStr(text, Chr(13))
'    If (enterText) Then
'        text = Mid(text, 1, enterText - 1)
'    End If
'End Function


