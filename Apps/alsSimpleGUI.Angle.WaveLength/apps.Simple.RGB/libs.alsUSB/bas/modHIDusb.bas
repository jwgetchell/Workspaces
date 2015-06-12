Attribute VB_Name = "modHIDusb"
Option Explicit

'Public gNoUsb As Boolean
'Public gHwnd As Long
Private connected As Boolean
Private i2cAddr As Byte
Private fragmentPageAddr As Boolean

Public Sub setPageFragmentAddr(enable As Boolean)
    fragmentPageAddr = enable
End Sub

Public Function ucHidDllCallBack(ByVal RW As Long, ByVal addr As Long, data() As Long) As Long

    Dim baddr As Byte: baddr = &HFF And addr
    
    Dim dSize As Long: dSize = UBound(data) + 1
    
    Dim bData() As Byte, i As Integer
    If dSize > 1 Then
        ReDim bData(dSize - 1)
    Else
        ReDim bData(0)
    End If
    
    If connected = False Then openDevice
    If connected = False Then
        gNoUsb = True
    Else
        gNoUsb = False
    End If

    If gNoUsb = False Then
    
        Select Case (RW)
            Case CBcmds.eWpageBaddr, CBcmds.eWpageWaddr:
            For i = 0 To dSize - 1
                bData(i) = data(i)
            Next i
        End Select
        
        Select Case (RW)
            Case CBcmds.eWbyte: i2cWrite baddr, data(0)
            Case CBcmds.eRbyte: data(0) = i2cRead(baddr)
            Case CBcmds.eWword: i2cWriteWord baddr, data(0)
            Case CBcmds.eRword: data(0) = i2cReadWord(baddr)
            Case CBcmds.eWaddr: i2cAddr = addr
            Case CBcmds.eRaddr: data(0) = i2cAddr
            Case CBcmds.eWpageBaddr: writeI2cPage baddr, bData
            Case CBcmds.eRpageBaddr: readI2cPage baddr, bData
            Case CBcmds.eWpageWaddr: writeI2cPage baddr, bData, False
            Case CBcmds.eRpageWaddr: readI2cPage baddr, bData, False
        End Select
    
        Select Case (RW)
            Case CBcmds.eRpageBaddr, CBcmds.eRpageWaddr:
            For i = 0 To dSize - 1
                data(i) = bData(i)
            Next i
        End Select
        
        ucHidDllCallBack = 71077345
        
    Else: ucHidDllCallBack = 4
    End If
End Function

Sub i2cWrite(ByVal addr As Byte, ByVal data As Integer)
    Dim bData(1) As Byte: bData(0) = data And &HFF: bData(1) = (data / 256) And &HFF
    Dim baddr(1) As Byte: baddr(0) = addr And &HFF: baddr(1) = 0
    Call writeI2C(i2cAddr, 1, 1, bData, baddr)
End Sub

Sub i2cWriteWord(ByVal addr As Byte, ByVal data As Long)
    Dim bData(1) As Byte: bData(0) = data And &HFF: data = (data And &HFF00) / 256: bData(1) = data
    Dim baddr(1) As Byte: baddr(0) = addr And &HFF: baddr(1) = 0
    Call writeI2C(i2cAddr, 2, 1, bData, baddr)
End Sub

Public Function writeI2cPage(ByVal intAddr As Long, data() As Byte, Optional byteMode As Boolean = True, Optional size As Integer = -1) As Long

    Dim i As Integer, addr As Byte: addr = i2cAddr
    Dim numDataBytes As Byte, numberSent As Integer, buf(15) As Byte, maxBufsz As Integer: maxBufsz = UBound(buf) + 1
    
    Dim regAddr(1) As Byte
    If size < 0 Then size = UBound(data) + 1
    
    If size > 256 And byteMode Then Exit Function ' byte mode is only good for 256 bytes
    
    While (numberSent < size)
        If (size - numberSent) > maxBufsz Then
            numDataBytes = maxBufsz
        Else
            numDataBytes = size - numberSent
        End If
        
        For i = 0 To numDataBytes - 1: buf(i) = data(numberSent + i): Next i
        
        If byteMode Then
            regAddr(0) = (intAddr And &HFF)
            writeI2C addr, numDataBytes, 1, buf, regAddr
            Debug.Print "ByteWrite", addr, numDataBytes, 1, buf(0), buf(1), regAddr(0)
        Else
            regAddr(0) = (intAddr And &HFF00) / 256: regAddr(1) = (addr And &HFF) ' MSB 1st
            writeI2C addr, numDataBytes, 2, buf, regAddr
        End If
        numberSent = numberSent + numDataBytes
        
        If fragmentPageAddr Then
            intAddr = intAddr + numberSent ' original addressing
        Else
            intAddr = intAddr + numDataBytes
        End If
    
    Wend
    
    For i = 0 To size - 1
        If i Mod 8 = 0 Then Debug.Print
        Debug.Print data(i),
    Next i
    
    Debug.Print

End Function


Function i2cRead(ByVal addr As Byte) As Byte
    Dim bData(1) As Byte
    Dim baddr(1) As Byte: baddr(0) = addr And &HFF: baddr(1) = 0
    Call readI2C(i2cAddr, 1, 1, bData, baddr)
    i2cRead = bData(0) And &HFF
End Function

Function i2cReadWord(ByVal addr As Byte) As Long
    Dim bData(1) As Byte
    Dim baddr(1) As Byte: baddr(0) = addr And &HFF: baddr(1) = 0
    Call readI2C(i2cAddr, 2, 1, bData, baddr)
    i2cReadWord = bData(1): i2cReadWord = i2cReadWord * 256
    i2cReadWord = bData(0) + i2cReadWord
End Function

Public Function readI2cPage(ByVal intAddr As Long, data() As Byte, Optional byteMode As Boolean = True, Optional size As Integer = -1) As Long

    Dim i As Integer, addr As Byte: addr = i2cAddr
    Dim numDataBytes As Byte, numberReceived As Integer, buf(15) As Byte, maxBufsz As Integer: maxBufsz = UBound(buf) + 1
    
    Dim regAddr(1) As Byte
    
    If size < 0 Then size = UBound(data) + 1
    
    If size > 256 And byteMode Then Exit Function ' byte mode is only good for 256 bytes
    
    While (numberReceived < size)
        If (size - numberReceived) > maxBufsz Then
            numDataBytes = maxBufsz
        Else
            numDataBytes = size - numberReceived
        End If
        
        If byteMode Then
            regAddr(0) = (intAddr And &HFF)
            readI2C addr, numDataBytes, 1, buf, regAddr
            Debug.Print "ByteRead", addr, numDataBytes, 1, buf(0), buf(1), regAddr(0)
        Else
            regAddr(0) = (intAddr And &HFF00) / 256: regAddr(1) = (intAddr And &HFF) ' MSB 1st
            readI2C addr, numDataBytes, 2, buf, regAddr
        End If
        For i = 0 To numDataBytes - 1: data(numberReceived + i) = buf(i): Next i
        numberReceived = numberReceived + numDataBytes
        
        If fragmentPageAddr Then
            intAddr = intAddr + numberReceived ' original addressing
        Else
            intAddr = intAddr + numDataBytes
        End If
        
    Wend

    For i = 0 To size - 1
        If i Mod 8 = 0 Then Debug.Print
        Debug.Print data(i),
    Next i
    
    Debug.Print

End Function

Private Sub setError(error As String)
    'debugWrite error
    MsgBox (error)
    If error = "Device not found" Then gNoUsb = True
    If error = "Timeout expired" Then gNoUsb = True
End Sub

Public Function getError(ErrorCode As Long) As Long

    Dim error As String
    
    If (ErrorCode) Then
        error = 99 'Stat2Str(errorCode) ' JWG Breakpoint: USB transfer errors
        setError (error)
    End If
    getError = ErrorCode
End Function

Private Function openDevice() As Boolean
    openDevice = connect
    connected = openDevice
End Function

Public Sub HIDcloseDevice()
    closeHandles
End Sub



