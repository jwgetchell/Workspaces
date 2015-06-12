VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsIslTofRegDrv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim hid As ucALSusb
Dim tof As islTofRegDrv
Const i2cAddr As Long = &HAE

Private Declare Function cSetDrvApi Lib "islTofRegDrv" (ByVal n As Long) As Long
Private Declare Function cReadField Lib "islTofRegDrv" (ByVal a As Long, ByVal s As Byte, ByVal m As Byte, d As Byte) As Long

Private Declare Function cSetAmbientCoeffs Lib "islTofRegDrv" (ByVal e As Long, ByVal c1 As Double, ByVal c2 As Double) As Long

Private Sub Class_Initialize()

    If hid Is Nothing Then Set hid = New ucALSusb: setI2cAddr i2cAddr
    cSetDrvApi AddressOf cb.Callback
    If tof Is Nothing Then Set tof = New islTofRegDrv: tof.setDrvApi AddressOf cb.Callback
    
End Sub

'===========
'||| DLL |||
'===========
Sub setDrvApi(ByVal n As Long): cSetDrvApi n: End Sub
Public Function readField_(ByVal a As Long, ByVal s As Byte, ByVal m As Byte) As Long
    Dim b As Byte
    cReadField a, s, m, b
    'tof.readField a, s, m, b
    readField_ = b
End Function
Public Sub setAmbientCoeffs(ByVal e As Long, ByVal c1 As Double, ByVal c2 As Double)
    cSetAmbientCoeffs e, c1, c2
End Sub

'===========
'||| HID |||
'===========

Sub setI2cAddr(ByVal addr As Long): hid.setI2cAddr addr: End Sub
Function getI2cAddr() As Long: getI2cAddr = hid.getI2cAddr: End Function


Sub writeByte(ByVal addr As Long, ByVal data As Long)
    hid.writeByte addr, data
End Sub

Function readByte(ByVal addr As Long) As Long
    readByte = hid.readByte(addr)
End Function

Sub writeWord(ByVal addr As Long, ByVal data As Long)
    hid.writeWord addr, data
End Sub

Function readWord(ByVal addr As Long) As Long
    readWord = hid.readWord(addr)
End Function

