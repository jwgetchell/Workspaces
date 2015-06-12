Attribute VB_Name = "cb"
Public islTofRegDrv As clsIslTofRegDrv

Public Function Callback(ByVal cmd As Long, ByVal addr As Long, ByRef data As Long, ByVal dSize As Long) As Long

    Callback = 71077345
    
    If islTofRegDrv Is Nothing Then
    Else

        Select Case cmd
            Case alsUSB.cmd_R:  data = islTofRegDrv.readByte(addr)
            Case alsUSB.cmd_RW: data = islTofRegDrv.readWord(addr)
            Case alsUSB.cmd_w:  islTofRegDrv.writeByte addr, data
            Case alsUSB.cmd_WW: islTofRegDrv.writeWord addr, data
'            Case alsUSB.cmd_RA: addr = islTofRegDrv.getI2cAddr
'            Case alsUSB.cmd_WA: islTofRegDrv.setI2cAddr addr
        End Select
    
    End If

End Function

'Public Function newIslTofRegDrv() As clsIslTofRegDrv
'    Set islTofRegDrv = New clsIslTofRegDrv
'    islTofRegDrv.init
'End Function
