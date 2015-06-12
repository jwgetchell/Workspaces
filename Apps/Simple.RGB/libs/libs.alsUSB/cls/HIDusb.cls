VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ucHIDUsb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Public Function noUsb() As Boolean
    noUsb = gNoUsb
End Function

Public Sub getUcCodeCaption(ByRef caption As String)
    caption = caption & "HID"
End Sub

Public Sub setHwnd(hWnd As Long)
    gHwnd = hWnd
End Sub

Public Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data() As Long) As Long
    DllCallBack = ucHidDllCallBack(RW, addr, data)
End Function

Private Sub Class_Initialize()
    gNoUsb = False
End Sub

Private Sub Class_Terminate()
    Call closeDevice
End Sub

