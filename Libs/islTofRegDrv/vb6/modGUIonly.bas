Attribute VB_Name = "modGUIonly"
Public Function enterText(ByRef text As String) As Integer
    ' strip [cr] & [lf], return > 0
    enterText = InStr(text, Chr(13))
    If (enterText) Then
        text = Mid(text, 1, enterText - 1)
    End If
End Function

