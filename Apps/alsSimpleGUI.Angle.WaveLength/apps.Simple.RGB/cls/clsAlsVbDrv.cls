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

Dim reg(rNbitFields - 1) As BitField

Dim image(255) As Integer

Dim ranges(2) As Double
Dim resolutions(2) As Long
Dim rangeN As Integer
Dim resolutionN As Integer
Dim mode As Integer

Dim data As Long

Dim alsPtr As ucALSusb
'Dim hidPtr As modHIDusb

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
    Dim data(0) As Long
    data(0) = &H89: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, eAddr.rTM, data
    data(0) = &HC9: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, eAddr.rTM, data
End Sub

Private Sub exitTestMode()
    Dim data(0) As Long: data(0) = &H0
    modHIDusb.ucHidDllCallBack CBcmds.eWbyte, eAddr.rTM, data
End Sub

Public Sub setAlsDll(ByRef dll As ucALSusb)
    Set alsPtr = dll
End Sub

Public Sub setI2cAddr(addr As Long)
    Dim data(0) As Long: data(0) = addr
    modHIDusb.ucHidDllCallBack CBcmds.eWaddr, addr, data
End Sub

Public Sub dGetRed(value As Double)
    Dim data(0) As Long
    modHIDusb.ucHidDllCallBack CBcmds.eRword, eAddr.rRed, data
    data(0) = data(0) And resolutions(resolutionN)
    value = ranges(rangeN) * data(0) / resolutions(resolutionN)
End Sub

Public Sub dGetGreen(value As Double)
    Dim data(0) As Long
    modHIDusb.ucHidDllCallBack CBcmds.eRword, eAddr.rGreen, data
    data(0) = data(0) And resolutions(resolutionN)
    value = ranges(rangeN) * data(0) / resolutions(resolutionN)
End Sub

Public Sub dGetBlue(value As Double)
    Dim data(0) As Long
    modHIDusb.ucHidDllCallBack CBcmds.eRword, eAddr.rBlue, data
    data(0) = data(0) And resolutions(resolutionN)
    value = ranges(rangeN) * data(0) / resolutions(resolutionN)
End Sub

Private Sub rmwConfig(regIn As BitField, value As Long)
    Dim Config(0) As Long: Config(0) = image(regIn.addr)
    Config(0) = Config(0) And (255 - regIn.mask * 2 ^ regIn.shift)
    value = value And regIn.mask
    Config(0) = Config(0) Or (value * 2 ^ regIn.shift)
    modHIDusb.ucHidDllCallBack CBcmds.eWbyte, regIn.addr, Config
    image(regIn.addr) = Config(0)
End Sub

Public Sub dSetInputSelect(ByVal chan As Long, ByVal value As Long)
    Dim val As Long
    'value={OFF,ALS,RGB}
    val = value: If value = 2 Then val = 5
    rmwConfig reg(eAddr.rMode), val
End Sub

Public Sub dSetIRcomp(ByVal value As Long)
    Dim data(0) As Long: data(0) = (value And 255)
    modHIDusb.ucHidDllCallBack CBcmds.eWbyte, eAddr.rComp, data
End Sub
Public Sub dGetIRcomp(value As Long)
    Dim data(0) As Long
    modHIDusb.ucHidDllCallBack CBcmds.eRbyte, eAddr.rComp, data
    value = data(0)
End Sub

Public Sub dSetRange(ByVal chan As Long, ByVal value As Long)
    Dim data(0) As Long
    
    If value < 2 Then
        rmwConfig reg(eAddr.rRange), value
        enterTestMode
        data(0) = &H0: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, &H1C, data ' reset gain to 1
        data(0) = &H0: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, &H19, data ' return to fuse mode
        exitTestMode
    Else
        ' |||| Test Mode ||||
        value = 2
        rmwConfig reg(eAddr.rRange), 0
        enterTestMode
        data(0) = &H40: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, &H19, data ' switch to register mode
        data(0) = &H2: modHIDusb.ucHidDllCallBack CBcmds.eWbyte, &H1C, data ' set gain to Max (2.3)
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
    alsPtr.dGetNrange 0, value
End Function
Public Sub dGetRangeList(ByVal chan As Long, list As Long)
    alsPtr.dGetRangeList 0, list
End Sub

Public Function dGetNresolution(ByVal chan As Long, value As Long) As Long
    alsPtr.dGetNresolution 0, value
End Function
Public Sub dGetResolutionList(ByVal chan As Long, list As Long)
    alsPtr.dGetResolutionList 0, list
End Sub



Public Function getEEpromObj() As clsEEprom
    Set getEEpromObj = alsPtr.getEEpromObj
End Function

Public Sub dWriteField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByVal d As Byte)
    Dim bVal As BitField, data As Long: data = d
    bVal.addr = a: bVal.shift = s: bVal.mask = m
    rmwConfig bVal, data
    d = data And 255
End Sub

Public Sub dReadField(ByVal a As Byte, ByVal s As Byte, ByVal m As Byte, ByRef d As Byte)
    Dim data(0) As Long: data(0) = d
    modHIDusb.ucHidDllCallBack CBcmds.eRbyte, a, data
    d = (data(0) * 2 ^ -s) And m
End Sub


