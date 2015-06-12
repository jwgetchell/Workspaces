Attribute VB_Name = "wdutils_dll"
'
' ----------------------------------------------------------------
' File - wd_utils.bas
' Copyright (c) 2003 - 2005 Jungo Ltd.  http://www.jungo.com
' ----------------------------------------------------------------
'

Option Explicit

Public Type DEVICE_CTX
    pDriverCtx As Long
    pDevice As Long
    dwUniqueID As Long
End Type

Public Type WDU_Transfer
    dwUniqueID As Long
    dwPipeNum As Long
    fRead As Long
    dwOptions As Long
    pBuffer As Long
    dwBufferSize As Long
    dwBytesTransferred As Long
    SetupPacket(1 To 8) As Byte
    dwTimeout As Long
End Type

' From winbase.h '
Public Const INFINITE = 2 ^ 31 - 1 '&HFFFFFFFF in winbase.h -> -1 in VB

' From status_strings.h '
Declare Function VB_Stat2Str Lib "WD_UTILS.DLL" ( _
    ByVal dwStatus As Long) As String
'[NOTE: Do not use this function directly from
' a VB application. Use Stat2Str() instead.]

' From windrvr_events.h '
Declare Function EventRegister Lib "WD_UTILS.DLL" Alias "VB_EventRegister" ( _
    ByRef phEvent As Long, ByVal hWD As Long, ByRef pEvent As Any, _
    ByVal pFunc As Long, ByRef pData As Any, ByVal hWnd As Long) As Long
Declare Function EventUnregister Lib "WD_UTILS.DLL" Alias "VB_EventUnregister" ( _
    ByVal hEvent As Long) As Long
Declare Function EventAlloc Lib "WD_UTILS.DLL" (ByVal dwNumMatchTables As Long) As Long
Declare Sub EventFree Lib "WD_UTILS.DLL" (ByRef pe As Any)
Declare Function EventDup Lib "WD_UTILS.DLL" (ByRef peSrc As Any) As Long
Declare Function UsbEventCreate Lib "WD_UTILS.DLL" (ByRef pMatchTables As Any, _
    ByVal dwNumMatchTables As Long, ByVal dwOptions As Long, _
    ByVal dwAction As Long) As Long
Declare Function PciEventCreate Lib "WD_UTILS.DLL" (cardId As WD_PCI_ID, _
    pciSlot As WD_PCI_SLOT, dwOptions As Long, dwAction As Long) As Long
    
' From windrvr_int_thread.h
' OLD prototypes for backward compatibility
Declare Function InterruptThreadEnable Lib "WD_UTILS.DLL" _
    Alias "WD_VB_InterruptThreadEnable" ( _
    ByRef phThread As Any, _
    ByVal hWD As Long, _
    ByRef pInt As Any, _
    ByVal IntHandler As Long, _
    ByVal pData As Long, _
    ByVal hWnd As Long) As Long
Declare Sub InterruptThreadDisable Lib "WD_UTILS.DLL" _
    Alias "WD_VB_InterruptThreadDisable" (ByVal hThread As Long)

' New prototypes. Functions return status.
Declare Function InterruptEnable Lib "WD_UTILS.DLL" _
    Alias "VB_InterruptEnable" ( _
    ByRef phThread As Any, _
    ByVal hWD As Long, _
    ByRef pInt As Any, _
    ByVal IntHandler As Long, _
    ByVal pData As Long, _
    ByVal hWnd As Long) As Long
Declare Function InterruptDisable Lib "WD_UTILS.DLL" _
    Alias "VB_InterruptDisable" (ByVal hThread As Long) As Long

' From wdu_lib.h
Declare Function WDU_Init Lib "WD_UTILS.DLL" Alias "WDU_VB_Init" ( _
    ByRef phDriver As Any, ByRef pMatchTables As Any, _
    ByVal dwNumMatchTables As Long, ByRef pEventTable As Any, _
    ByVal sLicense As String, ByVal dwOptions As Long, ByVal hWnd As Long) _
    As Long
Declare Sub WDU_Uninit Lib "WD_UTILS.DLL" Alias "WDU_VB_Uninit" ( _
    ByVal hDriver As Any)
    
Declare Function WDU_GetDeviceInfo Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByRef ppDeviceInfo As Any) As Long
Declare Sub WDU_PutDeviceInfo Lib "WD_UTILS.DLL" ( _
    ByVal pDeviceInfo As Any)
Declare Function WDU_SetInterface Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwInterfaceNum As Long, ByVal dwAlternateSetting As Long) As Long
Declare Function WDU_SetConfig Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwConfigNum As Long) As Long
Declare Function WDU_ResetPipe Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwPipeNum As Long) As Long
Declare Function WDU_ResetDevice Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwOptions As Long) As Long
Declare Function WDU_Wakeup Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwOptions As Long) As Long
Declare Function WDU_Transfer Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwPipeNum As Long, ByVal fRead As Long, ByVal dwOptions As Long, _
    ByVal pBuffer As Long, ByVal dwBufferSize As Long, _
    ByRef pdwBytesTransferred As Long, ByVal pSetupPacket As Long, _
    ByVal dwTimeout As Long) As Long
Declare Function WDU_HaltTransfer Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwPipeNum As Long) As Long
Declare Function WDU_TransferDefaultPipe Lib "WD_UTILS.DLL" ( _
    ByVal hDevice As Any, ByVal fRead As Long, ByVal dwOptions As Long, _
    ByVal pBuffer As Long, ByVal dwBufferSize As Long, _
    ByRef pdwBytesTransferred As Long, ByVal pSetupPacket As Long, _
    ByVal dwTimeout As Long) As Long
Declare Function WDU_TransferBulk Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwPipeNum As Long, ByVal fRead As Long, ByVal dwOptions As Long, _
    ByVal pBuffer As Long, ByVal dwBufferSize As Long, _
    ByRef pdwBytesTransferred As Long, ByVal dwTimeout As Long) As Long
Declare Function WDU_TransferIsoch Lib "WD_UTILS.DLL" (ByVal hDevice As Any, _
    ByVal dwPipeNum As Long, ByVal fRead As Long, ByVal dwOptions As Long, _
    ByVal pBuffer As Long, ByVal dwBufferSize As Long, _
    ByRef pdwBytesTransferred As Long, ByVal dwTimeout As Long) As Long
Declare Function WDU_TransferInterrupt Lib "WD_UTILS.DLL" ( _
    ByVal hDevice As Any, ByVal dwPipeNum As Long, ByVal fRead As Long, _
    ByVal dwOptions As Long, ByVal pBuffer As Long, ByVal dwBufferSize As Long, _
    ByRef pdwBytesTransferred As Long, ByVal dwTimeout As Long) As Long
Declare Function WDU_GetLangIDs Lib "WD_UTILS.DLL" ( _
    ByVal hDevice As Any, ByRef pbNumSupportedLangIDs As Byte, _
    ByRef pLangIDs As Integer, ByVal bNumLangIDs As Byte) As Long
Declare Function WDU_GetStringDesc Lib "WD_UTILS.DLL" ( _
    ByVal hDevice As Any, ByVal bStrIndex As Byte, _
    ByRef pbBuf As Byte, ByVal dwBufSize As Long, _
    ByVal langID As Integer, ByRef pdwDescSize As Long) As Long

'win32 API:
Declare Function CreateThread Lib "kernel32" ( _
    ByRef psa As Any, ByVal cbStack As Long, _
    ByVal pfnStartAddr As Long, ByVal pvParam As Long, _
    ByVal fdwCreate As Long, ByRef pdwThreadID As Long) As Long
'Declare Function WaitForSingleObject Lib "kernel32" (ByRef hHandle As Long, _
'    ByVal dwMilliseconds As Long) As Long

'From utils.h:
Declare Function OsEventCreate Lib "WD_UTILS.DLL" (ByRef phOsEvent As Any) As Long
Declare Sub OsEventClose Lib "WD_UTILS.DLL" (ByVal hOsEvent As Long)
Declare Function OsEventWait Lib "WD_UTILS.DLL" (ByVal hOsEvent As Long, _
    ByVal dwSecTimeout As Long) As Long
Declare Function OsEventSignal Lib "WD_UTILS.DLL" (ByVal hOsEvent As Long) As Long
'From utils.c:
Declare Sub FreeDllPtr Lib "WD_UTILS.DLL" (ByRef ptr As Long)

' Function: ThreadLoopStart (Alias to VB_ThreadLoopStart)
'   Spawns a thread in the wd_utils DLL, which executes the user's callback
'   function - pFunc - in a loop, until the function returns an error (other
'   than WD_TIMEOUT_EXPIRED) or ThreadLoopStop() has been called.
' Parameters:
'   phThread [out] will contain the handle to the thread that has been created
'      [This handle should later be passed to ThreadLoopStop()].
'   pFunc [in] contains the address of the function to be executed in a loop
'      by the DLL thread. pFunc takes one parameter (PVOID) and returns Long.
'   pData [in] contains that data to be passed to pFunc.
'   hWnd [in] contains that handle to the form to which pFunc relates.
' Return Value:
'   WinDriver status code (WD_STATUS_SUCCESS on success)
Declare Function ThreadLoopStart Lib "WD_UTILS.DLL" Alias "VB_ThreadLoopStart" ( _
    ByRef phThread As Long, ByVal pFunc As Long, ByVal pData As Long, _
    ByVal hWnd As Long) As Long

' Sub: ThreadLoopStop (Alias to VB_ThreadLoopStop)
' Parameters:
'   hThread [in] contains a handle to the thread to be stopped (should be
'      the handle returned from ThreadLoopStart() in the phThread parameter).
Declare Sub ThreadLoopStop Lib "WD_UTILS.DLL" Alias "VB_ThreadLoopStop" ( _
    ByVal hThread As Long)

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'The following definitions are left for backwards compatibility with
'versions 6.00 - 6.02. However, we recommend that you do NOT use these
'functions, in order to avoid problems related to multiple threading in
'Visual Basic. Instead, use ThreadLoopStart() and ThreadLoopStop() (above):
Public Function ThreadStart(ByRef phThread As Long, ByVal pFunc As Long, _
    ByVal pData As Long) As Long
    Dim ret As Long
    Dim dwThreadID As Long
    ret = CreateThread(Null, 0, pFunc, pData, 0, dwThreadID)

    If (ret = 0) Then
        ThreadStart = WD_INSUFFICIENT_RESOURCES
    Else
        phThread = ret
        ThreadStart = WD_STATUS_SUCCESS
    End If
End Function
Public Sub ThreadStop(ByVal hThread As Long)
    Call WaitForSingleObject(hThread, INFINITE)
    Call CloseHandle(hThread)
End Sub
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' VB wrapper function for status_string.c C DLL function:
Public Function Stat2Str(ByVal dwStatus As Long) As String
    Dim iNullCharLoc As Integer

    Stat2Str = VB_Stat2Str(dwStatus)
    iNullCharLoc = InStr(Stat2Str, Chr(0))

    If iNullCharLoc Then
        Stat2Str = Left(Stat2Str, iNullCharLoc - 1)
    End If
End Function
