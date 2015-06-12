Attribute VB_Name = "modGpibComDefs"
Enum instr
    mc
    OM
    vi
    VI3631
    pg
End Enum

Enum comDev
    FW0
    FW1
    LuxMeter
    Prologix
    ChromaMeter
End Enum

' Lux Meter
Type LMShortCommand
    STX As Byte
    Receptor(0 To 1) As Byte
    Command(0 To 1) As Byte
    Data4(0 To 3) As Byte
    ETX As Byte
    BCC As String
    CR As Byte
    LF As Byte
    init As Boolean
End Type

Public LuxMeterCom As LMShortCommand
Public ChromaMeterCom As LMShortCommand
Public Buffer As String
Public SimMode As Boolean

Public Declare Function GetTickCount Lib "kernel32" () As Long

Function CalcBCC(meter As LMShortCommand)
    Dim TempBCC As String
    TempBCC = Hex(meter.Receptor(0) Xor meter.Receptor(1) Xor meter.Command(0) Xor meter.Command(1) Xor _
        meter.Data4(0) Xor meter.Data4(1) Xor meter.Data4(2) Xor meter.Data4(3) Xor meter.ETX)
    If Len(TempBCC) = 1 Then
        meter.BCC = "0" + TempBCC
    Else
        meter.BCC = TempBCC
    End If
    
End Function

Function LMSendCom(meter As LMShortCommand) As String
    LMSendCom = Chr(meter.STX) + Chr(meter.Receptor(0)) + Chr(meter.Receptor(1)) + Chr(meter.Command(0)) + _
        Chr(meter.Command(1)) + Chr(meter.Data4(0)) + Chr(meter.Data4(1)) + Chr(meter.Data4(2)) + Chr(meter.Data4(3)) + _
        Chr(meter.ETX) + meter.BCC + Chr(meter.CR) + Chr(meter.LF)
    
End Function

'Function enterText(ByRef text As String) As Integer
'    ' strip [cr] & [lf], return > 0
'    enterText = InStr(text, Chr(13))
'    If (enterText) Then
'        text = Mid(text, 1, enterText - 1)
'    End If
'End Function

