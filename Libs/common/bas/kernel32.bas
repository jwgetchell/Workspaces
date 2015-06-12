Attribute VB_Name = "modKernel32"
Option Explicit

Type reg
    a As Long
    s As Byte
    m As Byte
End Type

Private Type OSVERSIONINFO
  OSVSize         As Long
  dwVerMajor      As Long
  dwVerMinor      As Long
  dwBuildNumber   As Long
  PlatformID      As Long
  szCSDVersion    As String * 128
End Type

Type POINTAPI ' This holds the logical cursor information
      x As Long
      y As Long
End Type

Declare Sub GetCursorPos Lib "User32" (lpPoint As POINTAPI)

Public Declare Sub Sleep Lib "kernel32" (ByVal t As Long)
Public Declare Sub MemCpy Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)
Public Declare Function Win32GetTickCounter Lib "kernel32" Alias "GetTickCount" () As Long
Public Declare Function GetVersionEx Lib "kernel32" Alias "GetVersionExA" _
    (lpVersionInformation As OSVERSIONINFO) As Long


Public Function getOSintSize() As Integer
    Dim osv As OSVERSIONINFO
    osv.OSVSize = Len(osv)
    
    If GetVersionEx(osv) = 1 Then
        If osv.dwVerMajor > 5 Then
            getOSintSize = 64 ' > XP (64)
        Else
            getOSintSize = 32 ' XP (32)
        End If
    End If
    
End Function
