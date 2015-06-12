Option Strict Off
Option Explicit On
Module modFunctions
	
	Dim noCr As Boolean
	
	Public Sub dpNoCr()
		noCr = True
	End Sub
	
	Public Sub debugPrint(Optional ByVal s0 As String = "", Optional ByVal s1 As String = "", Optional ByVal s2 As String = "", Optional ByVal s3 As String = "", Optional ByVal s4 As String = "", Optional ByVal s5 As String = "")
		If s5 <> "" Then
			System.Diagnostics.Debug.Write(VB6.TabLayout(s0, s1, s2, s3, s4, s5, TAB))
		Else
			If s4 <> "" Then
				System.Diagnostics.Debug.Write(VB6.TabLayout(s0, s1, s2, s3, s4, TAB))
			Else
				If s3 <> "" Then
					System.Diagnostics.Debug.Write(VB6.TabLayout(s0, s1, s2, s3, TAB))
				Else
					If s2 <> "" Then
						System.Diagnostics.Debug.Write(VB6.TabLayout(s0, s1, s2, TAB))
					Else
						If s1 <> "" Then
							System.Diagnostics.Debug.Write(VB6.TabLayout(s0, s1, TAB))
						Else
							System.Diagnostics.Debug.Write(VB6.TabLayout(s0, TAB))
						End If
					End If
				End If
			End If
		End If
		
		If Not noCr Then
			Debug.Print("")
		Else
			noCr = False
		End If
		
	End Sub
End Module