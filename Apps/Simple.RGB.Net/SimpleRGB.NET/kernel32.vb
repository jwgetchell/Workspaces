Option Strict Off
Option Explicit On
Module modKernel32
	
	Structure reg
		Dim a As Integer
		Dim s As Byte
		Dim m As Byte
	End Structure
	
	Private Structure OSVERSIONINFO
		Dim OSVSize As Integer
		Dim dwVerMajor As Integer
		Dim dwVerMinor As Integer
		Dim dwBuildNumber As Integer
		Dim PlatformID As Integer
		'UPGRADE_WARNING: Fixed-length string size must fit in the buffer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="3C1E4426-0B80-443E-B943-0627CD55D48B"'
		<VBFixedString(128),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=128)> Public szCSDVersion() As Char
	End Structure
	
	
	Public Declare Sub Sleep Lib "kernel32" (ByVal t As Integer)
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Public Declare Sub MemCpy Lib "kernel32.dll"  Alias "RtlMoveMemory"(ByRef Destination As Any, ByRef Source As Any, ByVal Length As Integer)
	Public Declare Function Win32GetTickCounter Lib "kernel32"  Alias "GetTickCount"() As Integer
	'UPGRADE_WARNING: Structure OSVERSIONINFO may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Public Declare Function GetVersionEx Lib "kernel32"  Alias "GetVersionExA"(ByRef lpVersionInformation As OSVERSIONINFO) As Integer
	
	
	Public Function setOSintSize() As Short
		Dim osv As OSVERSIONINFO
		osv.OSVSize = Len(osv)
		
		If GetVersionEx(osv) = 1 Then
			If osv.dwVerMajor > 5 Then
				setOSintSize = 64
			Else
				setOSintSize = 32
			End If
		End If
		
	End Function
End Module