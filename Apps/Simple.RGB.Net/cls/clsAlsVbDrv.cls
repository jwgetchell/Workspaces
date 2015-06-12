VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAlsVbDrv"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Private Type BitField
    addr As Integer
    mask As Integer
    shift As Integer
End Type

Private Enum eAddr

    rConfig = &H1
    rRange = 0      ' bit fields (addr 0x01)
    rResolution = 1
    rMode = 2
    
    rTmodes = &H1A
    r4xMode = rMode + 1   ' bit fields (addr 0x1A)
    r8bitMode
    
    rNbitFields
     
    rComp = &H2  ' full byte
    rTM = &H0  ' full byte
    
    rGreen = &H9 ' full words
    rRed = &HB
    rBlue = &HD

End Enum

Private Enum RW
    eWbyte
    eRbyte
    eWword
    eRword
    eWaddr
    eRaddr
End Enum

Dim reg(rNbitFields - 1) As BitField

Dim image(255) As Integer

Dim ranges(2) As Double
Dim resolutions(2) As Long
Dim rangeN As Integer
Dim resolutionN As Integer
Dim mode As Integer

Dim data As Long

Dim als As ucALSusb

Private Sub Class_Initialize()

    reg(eAddr.rMode).addr = eAddr.rConfig: reg(eAddr.rMode).mask = 7: reg(eAddr.rMode).shift = 0
    reg(eAddr.rRange).addr = eAddr.rConfig: reg(eAddr.rRange).mask = 1: reg(eAddr.rRange).shift = 3
    reg(eAddr.rResolution).addr = eAddr.rConfig: reg(eAddr.rResolution).mask = 1: reg(eAddr.rResolution).shift = 4
    
    reg(eAddr.r4xMode).addr = eAddr.rTmodes: reg(eAddr.r4xMode).mask = 1: reg(eAddr.r4xMode).shift = 2
    reg(eAddr.r8bitMode).addr = eAddr.rTmodes: reg(eAddr.r8bitMode).mask = 1: reg(eAddr.r8bitMode).shift = 1
    
    ranges(0) = 375: ranges(1) = 10250: ranges(2) = 155
    resolutions(0) = 65535: resolutions(1) = 4095: resolutions(2) = 255
    
End Sub

Private Sub enterTestMode()
    als.ucHidDllCallBack RW.eWbyte, eAddr.rTM, &H89
    als.ucHidDllCallBack RW.eWbyte, eAddr.rTM, &HC9
End Sub

Private Sub exitTestMode()
    als.ucHidDllCallBack RW.eWbyte, eAddr.rTM, &H0
End Sub

Public Sub setAlsDll(dll As ucALSusb)
    Set als = dll
End Sub

Public Sub setI2cAddr(addr As Long)
    als.ucHidDllCallBack RW.eWaddr, addr, addr
End Sub

Public Sub dGetRed(value As Double)
    als.ucHidDllCallBack RW.eRword, eAddr.rRed, data
    data = data And resolutions(resolutionN)
    value = ranges(rangeN) * data / resolutions(resolutionN)
End Sub

Public Sub dGetGreen(value As Double)
    als.ucHidDllCallBack RW.eRword, eAddr.rGreen, data
    data = data And resolutions(resolutionN)
    value = ranges(rangeN) * data / resolutions(resolutionN)
End Sub

Public Sub dGetBlue(value As Double)
    als.ucHidDllCallBack RW.eRword, eAddr.rBlue, data
    data = data And resolutions(resolutionN)
    value = ranges(rangeN) * data / resolutions(resolutionN)
End Sub

Private Sub rmwConfig(regIn As BitField, value As Long)
    Dim Config As Long: Config = image(regIn.addr)
    Config = Config And (255 - regIn.mask * 2 ^ regIn.shift)
    value = value And regIn.mask
    Config = Config Or (value * 2 ^ regIn.shift)
    als.ucHidDllCallBack RW.eWbyte, regIn.addr, Config
    image(regIn.addr) = Config
End Sub

Public Sub dSetInputSelect(ByVal chan As Long, ByVal value As Long)
    Dim val As Long
    'value={OFF,ALS,RGB}
    val = value: If value = 2 Then val = 5
    rmwConfig reg(eAddr.rMode), val
End Sub

Public Sub dSetIRcomp(ByVal value As Long)
    als.ucHidDllCallBack RW.eWbyte, eAddr.rComp, (value And 255)
End Sub
Public Sub dGetIRcomp(value As Long)
    als.ucHidDllCallBack RW.eRbyte, eAddr.rComp, value
End Sub

Public Sub dSetRange(ByVal chan As Long, ByVal value As Long)

    If value < 2 Then
        rmwConfig reg(eAddr.rRange), value
        enterTestMode
        als.ucHidDllCallBack RW.eWbyte, &H1C, &H0  ' reset gain to 1
        als.ucHidDllCallBack RW.eWbyte, &H19, &H0 ' return to fuse mode
        exitTestMode
    Else
        ' |||| Test Mode ||||
        value = 2
        rmwConfig reg(eAddr.rRange), 0
        enterTestMode
        als.ucHidDllCallBack RW.eWbyte, &H19, &H40 ' switch to register mode
        als.ucHidDllCallBack RW.eWbyte, &H1C, &H2  ' set gain to Max (2.3)
        exitTestMode
    End If
    
    rangeN = value
    
End Sub

Public Function dGetRange(ByVal chan As Long, ByRef value As Long) As Long
    value = rangeN
End Function

Public Sub dSetResolution(ByVal chan As Long, ByVal value As Long)

    Static lastValue As Long

    If value < 2 Then
        If lastValue = 2 Then
            enterTestMode
            rmwConfig reg(eAddr.r8bitMode), 0
            exitTestMode
        End If
        
        rmwConfig reg(eAddr.rResolution), value
    
    Else
        enterTestMode
        rmwConfig reg(eAddr.r8bitMode), 1
        exitTestMode
        value = 2
    End If
    
    resolutionN = value
    lastValue = value
    
End Sub

Public Function dGetResolution(ByVal chan As Long, ByRef value As Long) As Long
    value = resolutionN
End Function

Public Sub dEnable4x(value As Long)
    enterTestMode
    rmwConfig reg(eAddr.r4xMode), value
    exitTestMode
End Sub
Public Sub dEnable8bit(value As Long)
    enterTestMode
    rmwConfig reg(eAddr.r4xMode), 0
    exitTestMode
End Sub




Public Function dGetNrange(ByVal chan As Long, value As Long) As Long
    Debug.Print "h"
    als.dGetNrange 0, value
End Function
Public Sub dGetRangeList(ByVal chan As Long, list As Long)
    als.dGetRangeList 0, list
End Sub

Public Function dGetNresolution(ByVal chan As Long, value As Long) As Long
    als.dGetNresolution 0, value
End Function
Public Sub dGetResolutionList(ByVal chan As Long, list As Long)
    als.dGetResolutionList 0, list
End Sub



Public Function getEEpromObj() As clsEEprom
    Set getEEpromObj = als.getEEpromObj
End Function

Public Sub dWriteField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal D As Byte)
    Dim bVal As BitField, data As Long: data = D
    bVal.addr = a: bVal.shift = s: bVal.mask = m
    rmwConfig bVal, data
    D = data And 255
End Sub

Public Sub dReadField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByRef D As Byte)
    Dim data As Long: data = D
    als.ucHidDllCallBack RW.eRbyte, a, data
    D = (data * 2 ^ -s) And m
End Sub


