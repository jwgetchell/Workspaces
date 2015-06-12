VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ucEmuUsb"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Declare Function cSetDevice Lib "registerEmulator" (ByVal c As Long) As Long
Private Declare Function cSetData Lib "registerEmulator" (ByVal c As Long, d As Double) As Long

Private data() As Double
Private decimation As Long

Public Function noUsb() As Boolean
    noUsb = gNoUsb
End Function

Public Sub getUcCodeCaption(ByRef caption As String)
    caption = caption & "Emulation"
End Sub

Public Sub setHwnd(hWnd As Long)
    gHwnd = hWnd
End Sub

Public Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long
    DllCallBack = udCallBack(RW, addr, data)
End Function

Private Sub Class_Initialize()
    gNoUsb = True
End Sub

Private Sub Class_Terminate()
    Call closeDevice
End Sub

Public Sub setDecimation(ByVal v As Long)
    If (v) Then
        If (v < gSize) Then decimation = v
    End If
End Sub

Public Sub setDevice(ByVal d As Long)
    Call cSetDevice(d)
End Sub

Public Sub setDataFile(ByVal file As String)
    Dim buf As Double
    Index = 0: gSize = 0
    
    Open file For Input As #1
    Do Until EOF(1)
        Input #1, buf: gSize = gSize + 1
    Loop
    Close
    
    ReDim data(gSize - 1)
    Open file For Input As #2
    For Index = 0 To gSize - 1
        Input #2, data(Index)
    Next Index
    Index = 0: Close
    Call cSetData(gSize, data(0))
End Sub

