Attribute VB_Name = "ChromaMeter"
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
    Init As Boolean
End Type

Public ChromaMeterCom As LMShortCommand
Public Buffer As String
Public SimMode As Boolean

Public Function CalcBCC()
    Dim TempBCC As String
    TempBCC = Hex(ChromaMeterCom.Receptor(0) Xor ChromaMeterCom.Receptor(1) Xor ChromaMeterCom.Command(0) Xor ChromaMeterCom.Command(1) Xor _
        ChromaMeterCom.DATA4(0) Xor ChromaMeterCom.DATA4(1) Xor ChromaMeterCom.DATA4(2) Xor ChromaMeterCom.DATA4(3) Xor ChromaMeterCom.ETX)
    If Len(TempBCC) = 1 Then
        ChromaMeterCom.BCC = "0" + TempBCC
    Else
        ChromaMeterCom.BCC = TempBCC
    End If
    
End Function


