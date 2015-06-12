Attribute VB_Name = "usJungoUsb"
Option Explicit

Dim i2cAddr As Long, dwError As Long, i As Long
Private m_hDriver As Long, m_dwDevAddr As Long

Public gNoUsb As Boolean
Public gHwnd As Long

'Private Type t_flag
'    DeviceOpened As Boolean
'    DeviceAttached As Boolean
'End Type

Public Type WDU_TransferParams
    hDevice As Long
    dwPipeNum As Long
    fRead As Long
    dwOptions As Long
    pBuffer(5) As Byte
    dwBufferSize As Long
    pdwBytesTransferred As Long
    pSetupPacket(7) As Byte
    dwTimeout As Long
End Type

Public Type deviceContext_t
    dwInterfaceNum As Long
    dwAlternateSetting As Long
    hDev As Long
    hEvent As Long
    dwAttachError As Long
End Type

Private gDeviceInfo As WDU_DEVICE
'Private gUserData As deviceContext_t
Private m_pUserData As deviceContext_t

Private m_i2c_byteWriteParams As WDU_TransferParams
Private m_i2c_wordWriteParams As WDU_TransferParams
Private m_i2c_byteReadParams(3) As WDU_TransferParams

Const DEFAULT_VENDOR_ID As Long = &H9AA&
Const DEFAULT_PRODUCT_ID As Long = &H2005& ''ALS 2005  dcp update 2009
Const DEFAULT_INTERFACE_NUM As Long = 0
Const DEFAULT_ALTERNATE_SETTING As Long = 0
Const DEFAULT_LICENSE_STRING As String = "6f1ea7e369bc928352c09870801b16975637b4386efab2.Intersil"

Public Function udCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long
    If gNoUsb = False Then
        Select Case (RW)
            Case 0: Call i2cWrite(addr, data)
            Case 1: data = i2cRead(addr)
            Case 2: Call i2cWriteWord(addr, data)
            Case 3: data = i2cReadWord(addr)
            Case 4: i2cAddr = addr
        End Select
        udCallBack = 71077345
    Else: udCallBack = 4
    End If
End Function

Sub i2cWrite(ByVal address As Byte, ByVal data As Integer)

    If (m_flag.DeviceOpened = False) Then openDevice
    
    m_i2c_byteWriteParams.pBuffer(1) = i2cAddr + 0
    m_i2c_byteWriteParams.pBuffer(2) = address
    m_i2c_byteWriteParams.pBuffer(3) = (data And 255)
    
    dwError = getError(WDU_Transfer(m_i2c_byteWriteParams.hDevice, _
                           m_i2c_byteWriteParams.dwPipeNum, _
                           m_i2c_byteWriteParams.fRead, _
                           m_i2c_byteWriteParams.dwOptions, VarPtr( _
                           m_i2c_byteWriteParams.pBuffer(0)), _
                           m_i2c_byteWriteParams.dwBufferSize, _
                           m_i2c_byteWriteParams.pdwBytesTransferred, VarPtr( _
                           m_i2c_byteWriteParams.pSetupPacket(0)), _
                           m_i2c_byteWriteParams.dwTimeout))
    Sleep (2)

End Sub

Sub i2cWriteWord(ByVal address As Byte, ByVal data As Long)

    If (m_flag.DeviceOpened = False) Then openDevice
    
    m_i2c_wordWriteParams.pBuffer(1) = i2cAddr
    m_i2c_wordWriteParams.pBuffer(2) = address
    m_i2c_wordWriteParams.pBuffer(3) = data And 255
    data = (data And &HFF00) / 256
    m_i2c_wordWriteParams.pBuffer(4) = data And 255
    
    dwError = getError(WDU_Transfer(m_i2c_wordWriteParams.hDevice, _
                           m_i2c_wordWriteParams.dwPipeNum, _
                           m_i2c_wordWriteParams.fRead, _
                           m_i2c_wordWriteParams.dwOptions, VarPtr( _
                           m_i2c_wordWriteParams.pBuffer(0)), _
                           m_i2c_wordWriteParams.dwBufferSize, _
                           m_i2c_wordWriteParams.pdwBytesTransferred, VarPtr( _
                           m_i2c_wordWriteParams.pSetupPacket(0)), _
                           m_i2c_wordWriteParams.dwTimeout))
    Sleep (2)

End Sub


Function i2cReadWord(ByVal address As Byte) As Long

    If (m_flag.DeviceOpened = False) Then openDevice
    
    m_i2c_byteReadParams(2).pBuffer(1) = i2cAddr + 1
    m_i2c_byteReadParams(2).pBuffer(2) = address
    
    For i = 2 To 3
    
        dwError = getError(WDU_Transfer(m_i2c_byteReadParams(i).hDevice, _
                                        m_i2c_byteReadParams(i).dwPipeNum, _
                                        m_i2c_byteReadParams(i).fRead, _
                                        m_i2c_byteReadParams(i).dwOptions, VarPtr( _
                                        m_i2c_byteReadParams(i).pBuffer(0)), _
                                        m_i2c_byteReadParams(i).dwBufferSize, _
                                        m_i2c_byteReadParams(i).pdwBytesTransferred, VarPtr( _
                                        m_i2c_byteReadParams(i).pSetupPacket(0)), _
                                        m_i2c_byteReadParams(i).dwTimeout))
                                        
        Sleep (2)
        
    Next i
    
    i2cReadWord = m_i2c_byteReadParams(3).pBuffer(2)
    i2cReadWord = i2cReadWord * 256
    i2cReadWord = i2cReadWord + m_i2c_byteReadParams(3).pBuffer(1)
   
End Function

Function i2cRead(ByVal address As Byte) As Byte

    If (m_flag.DeviceOpened = False) Then openDevice
    
    m_i2c_byteReadParams(0).pBuffer(1) = i2cAddr + 1
    m_i2c_byteReadParams(0).pBuffer(2) = address
    
    For i = 0 To 1
    
        dwError = getError(WDU_Transfer(m_i2c_byteReadParams(i).hDevice, _
                                        m_i2c_byteReadParams(i).dwPipeNum, _
                                        m_i2c_byteReadParams(i).fRead, _
                                        m_i2c_byteReadParams(i).dwOptions, VarPtr( _
                                        m_i2c_byteReadParams(i).pBuffer(0)), _
                                        m_i2c_byteReadParams(i).dwBufferSize, _
                                        m_i2c_byteReadParams(i).pdwBytesTransferred, VarPtr( _
                                        m_i2c_byteReadParams(i).pSetupPacket(0)), _
                                        m_i2c_byteReadParams(i).dwTimeout))
                                        
        Sleep (2)
        
    Next i

    i2cRead = m_i2c_byteReadParams(1).pBuffer(1)
    
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
        error = Stat2Str(ErrorCode) ' JWG Breakpoint: USB transfer errors
        setError (error)
    End If
    getError = ErrorCode
End Function

Private Sub SetEventTable(eventTable As WDU_EVENT_TABLE, attachCb As Long, detachCb As Long)
    eventTable.pfDeviceAttach = attachCb
    eventTable.pfDeviceDetach = detachCb
End Sub

Private Sub waitForCallBack(Optional noMsg As Boolean = False)
    '
    ' wait for call back from USB driver, set in "attachCallback"
    '
    Dim TimeOut As Integer
    TimeOut = 3000
    
    For i = 0 To TimeOut
        If (m_flag.DeviceAttached) Then
            Exit For
        Else
            DoEvents: Sleep (1)
        End If
    Next i
    
    If (i > TimeOut) Then If noMsg = False Then setError ("callback timeout")
    
End Sub

Private Sub openDevice()
    
    Dim matchTable As WDU_MATCH_TABLE
    Dim eventTable As WDU_EVENT_TABLE

    matchTable.wVendorId = (DEFAULT_VENDOR_ID And &H7FFF&) - (DEFAULT_VENDOR_ID And &H8000&)
    matchTable.wProductId = (DEFAULT_PRODUCT_ID And &H7FFF&) - (DEFAULT_PRODUCT_ID And &H8000&)

    m_pUserData.dwInterfaceNum = DEFAULT_INTERFACE_NUM
    m_pUserData.dwAlternateSetting = DEFAULT_ALTERNATE_SETTING

    Call SetEventTable(eventTable, AddressOf USBattachCallback, AddressOf USBdetachCallback)
    eventTable.pUserData = VarPtr(m_pUserData)
    
    dwError = getError(WDU_Init(m_hDriver, matchTable, 1, eventTable, _
                DEFAULT_LICENSE_STRING, WD_ACKNOWLEDGE, gHwnd))
    ' JWG true added to supress msgbox
    waitForCallBack (True) ' note do not break between WDU_init & callback
                    ' This will prevent callback from being made

    ' JWG issue m_dwDevAddr parameter wants to be a pointer to pointer **
    dwError = getError(WDU_GetDeviceInfo(m_pUserData.hDev, VarPtr(m_dwDevAddr)))
    
    If (dwError = 0) Then
        m_flag.DeviceOpened = True
    End If
    
    ' _______________________________________________________
    m_i2c_byteWriteParams.hDevice = m_pUserData.hDev ' byteWriteParams
    m_i2c_byteWriteParams.dwPipeNum = 2
    m_i2c_byteWriteParams.fRead = 0 ' R/W
    m_i2c_byteWriteParams.dwOptions = 0
    m_i2c_byteWriteParams.pBuffer(0) = 0 ' read count (bytes)
    m_i2c_byteWriteParams.pBuffer(1) = i2cAddr + 0 ' I2C address (set in function)
    m_i2c_byteWriteParams.pBuffer(2) = 0 ' Index ???
    m_i2c_byteWriteParams.pBuffer(3) = 0
    m_i2c_byteWriteParams.pBuffer(4) = 0
    m_i2c_byteWriteParams.pBuffer(5) = 0
    m_i2c_byteWriteParams.dwBufferSize = 4
    m_i2c_byteWriteParams.pdwBytesTransferred = 4
    m_i2c_byteWriteParams.pSetupPacket(0) = 0
    m_i2c_byteWriteParams.pSetupPacket(1) = 0
    m_i2c_byteWriteParams.pSetupPacket(2) = 0
    m_i2c_byteWriteParams.pSetupPacket(3) = 0
    m_i2c_byteWriteParams.pSetupPacket(4) = 0
    m_i2c_byteWriteParams.pSetupPacket(5) = 0
    m_i2c_byteWriteParams.pSetupPacket(6) = 0
    m_i2c_byteWriteParams.pSetupPacket(7) = 0
    m_i2c_byteWriteParams.dwTimeout = 1000 'TRANSFER_TIMEOUT
    
    ' _______________________________________________________
    m_i2c_wordWriteParams.hDevice = m_pUserData.hDev ' wordWriteParams
    m_i2c_wordWriteParams.dwPipeNum = 2
    m_i2c_wordWriteParams.fRead = 0 ' R/W
    m_i2c_wordWriteParams.dwOptions = 0
    m_i2c_wordWriteParams.pBuffer(0) = 0 ' read count (words)
    m_i2c_wordWriteParams.pBuffer(1) = i2cAddr + 0 ' I2C address (set in function)
    m_i2c_wordWriteParams.pBuffer(2) = 0 ' Index ???
    m_i2c_wordWriteParams.pBuffer(3) = 0
    m_i2c_wordWriteParams.pBuffer(4) = 0
    m_i2c_wordWriteParams.pBuffer(5) = 0
    m_i2c_wordWriteParams.dwBufferSize = 5
    m_i2c_wordWriteParams.pdwBytesTransferred = 5
    m_i2c_wordWriteParams.pSetupPacket(0) = 0
    m_i2c_wordWriteParams.pSetupPacket(1) = 0
    m_i2c_wordWriteParams.pSetupPacket(2) = 0
    m_i2c_wordWriteParams.pSetupPacket(3) = 0
    m_i2c_wordWriteParams.pSetupPacket(4) = 0
    m_i2c_wordWriteParams.pSetupPacket(5) = 0
    m_i2c_wordWriteParams.pSetupPacket(6) = 0
    m_i2c_wordWriteParams.pSetupPacket(7) = 0
    m_i2c_wordWriteParams.dwTimeout = 1000 'TRANSFER_TIMEOUT
    
    ' _____________________________________________________
    m_i2c_byteReadParams(0).hDevice = m_pUserData.hDev ' byteReadParams
    m_i2c_byteReadParams(0).dwPipeNum = 2
    m_i2c_byteReadParams(0).fRead = 0 ' R/W, 1st write command
    m_i2c_byteReadParams(0).dwOptions = 0
    m_i2c_byteReadParams(0).pBuffer(0) = 1 ' #/bytes 2 read
    m_i2c_byteReadParams(0).pBuffer(1) = i2cAddr + 1 ' ic2 addr
    m_i2c_byteReadParams(0).pBuffer(2) = 0 ' Index ??
    m_i2c_byteReadParams(0).pBuffer(3) = 0
    m_i2c_byteReadParams(0).pBuffer(4) = 0
    m_i2c_byteReadParams(0).pBuffer(5) = 0
    m_i2c_byteReadParams(0).dwBufferSize = 3
    m_i2c_byteReadParams(0).pdwBytesTransferred = 3 ' return value
    m_i2c_byteReadParams(0).pSetupPacket(0) = 0
    m_i2c_byteReadParams(0).pSetupPacket(1) = 0
    m_i2c_byteReadParams(0).pSetupPacket(2) = 0
    m_i2c_byteReadParams(0).pSetupPacket(3) = 0
    m_i2c_byteReadParams(0).pSetupPacket(4) = 0
    m_i2c_byteReadParams(0).pSetupPacket(5) = 0
    m_i2c_byteReadParams(0).pSetupPacket(6) = 0
    m_i2c_byteReadParams(0).pSetupPacket(7) = 0
    m_i2c_byteReadParams(0).dwTimeout = 1000 'TRANSFER_TIMEOUT
    ' _____________________________________________________
    m_i2c_byteReadParams(1).hDevice = m_pUserData.hDev ' byteReadParams
    m_i2c_byteReadParams(1).dwPipeNum = m_i2c_byteReadParams(0).dwPipeNum + &H80
    m_i2c_byteReadParams(1).fRead = 1
    m_i2c_byteReadParams(1).dwOptions = 0
    m_i2c_byteReadParams(1).pBuffer(0) = 0 ' #/bytes 2 read
    m_i2c_byteReadParams(1).pBuffer(1) = 0 ' ic2 addr ???
    m_i2c_byteReadParams(1).pBuffer(2) = 0 ' Index ??
    m_i2c_byteReadParams(1).pBuffer(3) = 0
    m_i2c_byteReadParams(1).pBuffer(4) = 0
    m_i2c_byteReadParams(1).pBuffer(5) = 0
    m_i2c_byteReadParams(1).dwBufferSize = m_i2c_byteReadParams(0).pBuffer(0) + 5
    m_i2c_byteReadParams(1).pdwBytesTransferred = 2
    m_i2c_byteReadParams(1).pSetupPacket(0) = 0
    m_i2c_byteReadParams(1).pSetupPacket(1) = 0
    m_i2c_byteReadParams(1).pSetupPacket(2) = 0
    m_i2c_byteReadParams(1).pSetupPacket(3) = 0
    m_i2c_byteReadParams(1).pSetupPacket(4) = 0
    m_i2c_byteReadParams(1).pSetupPacket(5) = 0
    m_i2c_byteReadParams(1).pSetupPacket(6) = 0
    m_i2c_byteReadParams(1).pSetupPacket(7) = 0
    m_i2c_byteReadParams(1).dwTimeout = 1000 'TRANSFER_TIMEOUT
    
    ' _____________________________________________________
    m_i2c_byteReadParams(2).hDevice = m_pUserData.hDev ' wordReadParams
    m_i2c_byteReadParams(2).dwPipeNum = 2
    m_i2c_byteReadParams(2).fRead = 0 ' R/W, 1st write command
    m_i2c_byteReadParams(2).dwOptions = 0
    m_i2c_byteReadParams(2).pBuffer(0) = 2 ' #/bytes 2 read
    m_i2c_byteReadParams(2).pBuffer(1) = i2cAddr + 1 ' ic2 addr
    m_i2c_byteReadParams(2).pBuffer(2) = 0 ' Index ??
    m_i2c_byteReadParams(2).pBuffer(3) = 0
    m_i2c_byteReadParams(2).pBuffer(4) = 0
    m_i2c_byteReadParams(2).pBuffer(5) = 0
    m_i2c_byteReadParams(2).dwBufferSize = 3
    m_i2c_byteReadParams(2).pdwBytesTransferred = 3 ' return value
    m_i2c_byteReadParams(2).pSetupPacket(0) = 0
    m_i2c_byteReadParams(2).pSetupPacket(1) = 0
    m_i2c_byteReadParams(2).pSetupPacket(2) = 0
    m_i2c_byteReadParams(2).pSetupPacket(3) = 0
    m_i2c_byteReadParams(2).pSetupPacket(4) = 0
    m_i2c_byteReadParams(2).pSetupPacket(5) = 0
    m_i2c_byteReadParams(2).pSetupPacket(6) = 0
    m_i2c_byteReadParams(2).pSetupPacket(7) = 0
    m_i2c_byteReadParams(2).dwTimeout = 1000 'TRANSFER_TIMEOUT
    ' _____________________________________________________
    m_i2c_byteReadParams(3).hDevice = m_pUserData.hDev ' wordReadParams
    m_i2c_byteReadParams(3).dwPipeNum = m_i2c_byteReadParams(0).dwPipeNum + &H80
    m_i2c_byteReadParams(3).fRead = 1
    m_i2c_byteReadParams(3).dwOptions = 0
    m_i2c_byteReadParams(3).pBuffer(0) = 0 ' #/bytes 2 read
    m_i2c_byteReadParams(3).pBuffer(1) = 0 ' ic2 addr ???
    m_i2c_byteReadParams(3).pBuffer(2) = 0 ' Index ??
    m_i2c_byteReadParams(3).pBuffer(3) = 0
    m_i2c_byteReadParams(3).pBuffer(4) = 0
    m_i2c_byteReadParams(3).pBuffer(5) = 0
    m_i2c_byteReadParams(3).dwBufferSize = m_i2c_byteReadParams(2).pBuffer(0) + 5
    m_i2c_byteReadParams(3).pdwBytesTransferred = 2
    m_i2c_byteReadParams(3).pSetupPacket(0) = 0
    m_i2c_byteReadParams(3).pSetupPacket(1) = 0
    m_i2c_byteReadParams(3).pSetupPacket(2) = 0
    m_i2c_byteReadParams(3).pSetupPacket(3) = 0
    m_i2c_byteReadParams(3).pSetupPacket(4) = 0
    m_i2c_byteReadParams(3).pSetupPacket(5) = 0
    m_i2c_byteReadParams(3).pSetupPacket(6) = 0
    m_i2c_byteReadParams(3).pSetupPacket(7) = 0
    m_i2c_byteReadParams(3).dwTimeout = 1000 'TRANSFER_TIMEOUT

End Sub

Public Sub closeDevice()
    
    If (m_flag.DeviceOpened = True) Then
    
        getError (WDU_ResetDevice(m_pUserData.hDev, 0))
        WDU_Uninit (m_hDriver)
        WD_Close (m_hDriver)
        
        m_flag.DeviceOpened = False
    End If
    m_flag.DeviceAttached = False

End Sub



