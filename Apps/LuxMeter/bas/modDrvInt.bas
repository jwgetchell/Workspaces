Attribute VB_Name = "als"
'Option Explicit

Dim als As ucALSusb
Dim EEprom As clsEEprom

Public Sub init()

On Error GoTo tryAgain
    Set als = frmMain.ucALSusb1
    GoTo success
tryAgain:
    Set als = frmMain.ucALSusb1
success:
    als.setI2cAddr &H88
    als.setDevice "ISL29035"
    
End Sub

Public Function dGetLux() As Double
    als.dGetLux dGetLux
End Function

Public Sub dSetRange(ByVal value As Long)
    als.dSetRange 0, value
End Sub

Public Sub dSetIRcomp(ByVal value As Long)
    als.dSetIRcomp value
End Sub

Public Function dGetIRcomp() As Long
    Dim value As Long
    als.dGetIRcomp value
    dGetIRcomp = value
End Function

Public Sub dSetResolution(value As Long)
    als.dSetResolution 0, value
End Sub

Public Function dGetRange(Optional retFSlux As Boolean = False) As Long

    ' original driver returns range #
    ' if retFSlux is set Full Scale Lux is returned instead
    
    Dim rngList() As Long, nRng As Long
    als.dGetRange 0, dGetRange
        
    If retFSlux Then
        als.dGetNrange 0, nRng
        ReDim rngList(nRng - 1)
        als.dGetRangeList 0, rngList(0)
        dGetRange = rngList(dGetRange)
    End If
    
End Function

Public Function dGetResolution(Optional retFScode As Boolean = False) As Long

    ' original driver returns resolution #
    ' if retFScode is set Full Scale code is returned instead
    
    Dim resList() As Long, nRes As Long
    
    als.dGetResolution 0, dGetResolution
    
    If retFScode Then
        als.dGetNresolution 0, nRes
        ReDim resList(nRes - 1)
        als.dGetResolutionList 0, resList(0)
        dGetResolution = resList(dGetResolution)
    End If
    
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

Public Sub writeField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte)
    als.dWriteField a, s, m, D
End Sub

Public Function readField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte) As Byte
    als.dReadField a, s, m, readField
End Function

