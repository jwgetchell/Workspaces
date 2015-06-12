Attribute VB_Name = "Module1"

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Type LMShortCommand
    STX As Byte
    Receptor(0 To 1) As Byte
    Command(0 To 1) As Byte
    DATA4(0 To 3) As Byte
    ETX As Byte
    BCC As String
    CR As Byte
    LF As Byte
End Type

Public LuxMeterCom As LMShortCommand
Public Buffer As String

Public Function CalcBCC()
    Dim TempBCC As String
    TempBCC = Hex(LuxMeterCom.Receptor(0) Xor LuxMeterCom.Receptor(1) Xor LuxMeterCom.Command(0) Xor LuxMeterCom.Command(1) Xor _
        LuxMeterCom.DATA4(0) Xor LuxMeterCom.DATA4(1) Xor LuxMeterCom.DATA4(2) Xor LuxMeterCom.DATA4(3) Xor LuxMeterCom.ETX)
    If Len(TempBCC) = 1 Then
        LuxMeterCom.BCC = "0" + TempBCC
    Else
        LuxMeterCom.BCC = TempBCC
    End If
    
End Function


