Attribute VB_Name = "als"
'Option Explicit

Dim als As Object 'ucALSusb
Public gRGBdev As String

Public invertCompMSB As Integer

Dim EEprom As clsEEprom

Const dllLimit As Integer = 32
Const devAddr As Long = &H88

Public Sub resetAddr()
    als.setI2cAddr devAddr
End Sub

Public Sub init()

On Error GoTo tryAgain
    Set als = frmAlsDrv.ucALSusb1
    frmSimpleRGB.hideDebug = True
    GoTo success
tryAgain:
    Set als = frmMain.ucALSusb1
success:

    als.setI2cAddr devAddr
    als.setDevice "ISL29125"
    
    If getOSintSize > dllLimit Then
        Set als = New clsAlsVbDrv
        als.setAlsDll frmAlsDrv.ucALSusb1
        als.setI2cAddr devAddr ' 125 driver is embedded
    Else
        als.setI2cAddr devAddr
        als.setDevice "ISL29125"
    End If
    
End Sub

Public Sub dGetRed(value As Double)
    als.dGetRed value
End Sub

Public Sub dGetGreen(value As Double)
    als.dGetGreen value
End Sub

Public Sub dGetBlue(value As Double)
    als.dGetBlue value
End Sub

Public Sub dSetRange(ByVal value As Long)
    als.dSetRange 0, value
End Sub

Public Sub dSetInputSelect(ByVal value As Long)
    'value={OFF,ALS,RGB}
    als.dSetInputSelect 0, value
End Sub

Public Sub dSetIRcomp(ByVal value As Long)
    als.dSetIRcomp (value Xor invertCompMSB)
End Sub

Public Sub dGetIRcomp(value As Long)
    als.dGetIRcomp value
End Sub
Public Sub dEnable4x(value As Long)
    als.dEnable4x value
End Sub
Public Sub dEnable8bit(value As Long)
    als.dEnable8bit value
End Sub
Public Sub dSetResolution(value As Long)
    als.dSetResolution 0, value
End Sub



Public Function dGetRange() As Long
    als.dGetRange 0, dGetRange
End Function
Public Function dGetResolution() As Long
    als.dGetResolution 0, dGetResolution
End Function



Public Function dGetNrange() As Long
    als.dGetNrange 0, dGetNrange
End Function
Public Sub dGetRangeList(list As Long)
    als.dGetRangeList 0, list
End Sub

Public Function dGetNresolution() As Long
    als.dGetNresolution 0, dGetNresolution
End Function
Public Sub dGetResolutionList(list As Long)
    als.dGetResolutionList 0, list
End Sub



Public Function getEEpromObj() As clsEEprom
    Set getEEpromObj = als.getEEpromObj
End Function

Public Sub writeField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal d As Byte)
    als.dWriteField a, s, m, d
End Sub

Public Function readField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte) As Byte
    als.dReadField a, s, m, readField
End Function

