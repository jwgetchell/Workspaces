Option Strict Off
Option Explicit On
Module modDefinitions
	
	Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Integer)
	Declare Function GetTickCount Lib "kernel32" () As Integer
	
	Public MG17Enabled As Boolean
	
	Structure srPath
		Dim x As Short
		Dim y As Short
	End Structure
	
	'Public Function enterText(ByRef text As String) As Integer
	'    ' strip [cr] & [lf], return > 0
	'    enterText = InStr(text, Chr(13))
	'    If (enterText) Then
	'        text = Mid(text, 1, enterText - 1)
	'    End If
	'End Function
End Module