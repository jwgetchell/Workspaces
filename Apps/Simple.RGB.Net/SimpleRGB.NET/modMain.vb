Option Strict Off
Option Explicit On
Imports VB = Microsoft.VisualBasic
Module modMain
	
	' +______+
	' | Main |
	' +¯¯¯¯¯¯+
	'UPGRADE_WARNING: Application will terminate when Sub Main() finishes. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="E08DDC71-66BA-424F-A612-80AF11498FF8"'
	Public Sub Main()
		Dim frmSimpleRGB As Object
		Dim a_strArgs() As String
		Dim blnDebug As Boolean
		
		Dim i As Short
		
		a_strArgs = Split(VB.Command(), " ")
		For i = LBound(a_strArgs) To UBound(a_strArgs)
			Select Case LCase(a_strArgs(i))
				Case "-d", "/d" ' device
					
					If i = UBound(a_strArgs) Then
						MsgBox("Filename not specified.")
					Else
						i = i + 1
					End If
					If Left(a_strArgs(i), 1) = "-" Or Left(a_strArgs(i), 1) = "/" Then
						MsgBox("Invalid filename.")
					Else
						gRGBdev = a_strArgs(i)
					End If
					
				Case "-wa", "/wa" ' device
					frmAlsDrv.enableInvert = 1
				Case Else
					MsgBox("Invalid argument: " & a_strArgs(i))
			End Select
			
		Next i
		
		'UPGRADE_ISSUE: Load statement is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B530EFF2-3132-48F8-B8BC-D88AF543D321"'
		Load(frmAlsDrv)
		'UPGRADE_WARNING: Couldn't resolve default property of object frmSimpleRGB.Show. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		frmSimpleRGB.Show()
		
	End Sub
End Module