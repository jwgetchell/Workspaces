Attribute VB_Name = "dllCallBackFunction"
Option Explicit

Public gUsb As Object
Public uc As ucJungoUsb
Private gDeviceInfo As WDU_DEVICE
Private gUserData As deviceContext_t
Private m_pDeviceInfo As WDU_DEVICE
Private m_pUserData As deviceContext_t

Public Type t_flag
    DeviceOpened As Boolean
    DeviceAttached As Boolean
End Type

Public m_flag As t_flag

Enum Status
    ok
    notImplemented
    illegalChannel
    illegalValue
    usbError
    driverError
End Enum

Enum CBcmds
    eWbyte
    eRbyte
    eWword
    eRword
    eWaddr
    eRaddr
    eWpageBaddr
    eRpageBaddr
    eWpageWaddr
    eRpageWaddr
End Enum

Public data() As Double, gSize As Long, Index As Long, decimation As Long

Public Declare Function GetTickCount Lib "kernel32" () As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal t As Long)


Public Static Function DllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long, ByVal dSize As Long) As Long

    Static lSize As Long
    Static ptr, ldata() As Long
    
    
    If dSize > 1 Then
        If ptr = 0 Then ReDim ldata(dSize - 1)
        ldata(ptr) = data
        ptr = ptr + 1
    Else
        If dSize = 1 Then
            ReDim ldata(0)
            ldata(0) = data
        Else
            If dSize = 0 Then
                ldata(ptr) = data
                ptr = 0
            End If
        End If
    End If
    
    If ptr = 0 Then
    
        Select Case RW
            Case CBcmds.eWbyte To CBcmds.eRaddr:
                DllCallBack = gUsb.DllCallBack(RW, addr, ldata)
            Case CBcmds.eWpageBaddr To CBcmds.eRpageWaddr:
                DllCallBack = gUsb.DllCallBack(RW, addr, ldata)
        End Select
        
        data = ldata(0)
    
    End If
    
End Function

Public Function ucmDllCallBack(ByVal RW As Long, ByVal addr As Long, data As Long) As Long
    ucmDllCallBack = udCallBack(RW, addr, data)
End Function

Function USBattachCallback(ByVal hDev As Long, _
                                  pDeviceInfo As WDU_DEVICE, _
                                  pUserData As deviceContext_t _
                                 ) As Boolean
    Dim hDevice As Long
    pUserData.hDev = hDev
    Call setUSB_CallbackParams(pDeviceInfo, pUserData)
    USBattachCallback = attachCallback(hDevice)
    
End Function

Sub USBdetachCallback(ByVal hDev As Long, _
                                  pDeviceInfo As WDU_DEVICE, _
                                  pUserData As deviceContext_t _
                                 )
    Dim hDevice As Long
    Call setUSB_CallbackParams(pDeviceInfo, pUserData)
    detachCallback (hDevice)
    
End Sub

Public Sub getUSB_CallbackParams(pDeviceInfo As WDU_DEVICE, pUserData As deviceContext_t)
    pDeviceInfo = gDeviceInfo
    pUserData = gUserData
End Sub
Public Sub setUSB_CallbackParams(pDeviceInfo As WDU_DEVICE, pUserData As deviceContext_t)
    gDeviceInfo = pDeviceInfo
    gUserData = pUserData
End Sub

Public Function attachCallback(ByVal hDevice As Long) As Boolean
    '
    ' This routine should only called from the USB Driver
    ' JWG Breakpoint: USB attach callback
    '
    Call getUSB_CallbackParams(m_pDeviceInfo, m_pUserData)
    
    m_pUserData.dwAttachError = WDU_SetInterface(m_pUserData.hDev, m_pUserData.dwInterfaceNum, _
        m_pUserData.dwAlternateSetting)
    
    If (m_pUserData.dwAttachError) Then
        'uc.getError (m_pUserData.dwAttachError)
    Else
        m_flag.DeviceAttached = True
    End If
    
    attachCallback = m_flag.DeviceAttached
    
End Function

Public Sub detachCallback(ByVal hDevice As Long)
    '
    ' This routine should only called from the USB Driver
    ' JWG Breakpoint: USB detach callback
    '
    Call getUSB_CallbackParams(m_pDeviceInfo, m_pUserData)
        
    m_flag.DeviceAttached = False

End Sub


