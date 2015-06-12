Option Strict Off
Option Explicit On
Module wdutils_dll
	'
	' ----------------------------------------------------------------
	' File - wd_utils.bas
	' Copyright (c) 2003 - 2005 Jungo Ltd.  http://www.jungo.com
	' ----------------------------------------------------------------
	'
	
	
	Public Structure DEVICE_CTX
		Dim pDriverCtx As Integer
		Dim pDevice As Integer
		Dim dwUniqueID As Integer
	End Structure
	
	Public Structure WDU_Transfer
		Dim dwUniqueID As Integer
		Dim dwPipeNum As Integer
		Dim fRead As Integer
		Dim dwOptions As Integer
		Dim pBuffer As Integer
		Dim dwBufferSize As Integer
		Dim dwBytesTransferred As Integer
		<VBFixedArray(8)> Dim SetupPacket() As Byte
		Dim dwTimeout As Integer
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			'UPGRADE_WARNING: Lower bound of array SetupPacket was changed from 1 to 0. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="0F1C9BE1-AF9D-476E-83B1-17D43BECFF20"'
			ReDim SetupPacket(8)
		End Sub
	End Structure
	
	' From winbase.h '
	Public Const INFINITE As Double = 2 ^ 31 - 1 '&HFFFFFFFF in winbase.h -> -1 in VB
	
	' From status_strings.h '
	Declare Function VB_Stat2Str Lib "WD_UTILS.DLL" (ByVal dwStatus As Integer) As String
	'[NOTE: Do not use this function directly from
	' a VB application. Use Stat2Str() instead.]
	
	' From windrvr_events.h '
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function EventRegister Lib "WD_UTILS.DLL"  Alias "VB_EventRegister"(ByRef phEvent As Integer, ByVal hWD As Integer, ByRef pEvent As Any, ByVal pFunc As Integer, ByRef pData As Any, ByVal hWnd As Integer) As Integer
	Declare Function EventUnregister Lib "WD_UTILS.DLL"  Alias "VB_EventUnregister"(ByVal hEvent As Integer) As Integer
	Declare Function EventAlloc Lib "WD_UTILS.DLL" (ByVal dwNumMatchTables As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Sub EventFree Lib "WD_UTILS.DLL" (ByRef pe As Any)
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function EventDup Lib "WD_UTILS.DLL" (ByRef peSrc As Any) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function UsbEventCreate Lib "WD_UTILS.DLL" (ByRef pMatchTables As Any, ByVal dwNumMatchTables As Integer, ByVal dwOptions As Integer, ByVal dwAction As Integer) As Integer
	'UPGRADE_WARNING: Structure WD_PCI_SLOT may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	'UPGRADE_WARNING: Structure WD_PCI_ID may require marshalling attributes to be passed as an argument in this Declare statement. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="C429C3A5-5D47-4CD9-8F51-74A1616405DC"'
	Declare Function PciEventCreate Lib "WD_UTILS.DLL" (ByRef cardId As WD_PCI_ID, ByRef pciSlot As WD_PCI_SLOT, ByRef dwOptions As Integer, ByRef dwAction As Integer) As Integer
	
	' From windrvr_int_thread.h
	' OLD prototypes for backward compatibility
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function InterruptThreadEnable Lib "WD_UTILS.DLL"  Alias "WD_VB_InterruptThreadEnable"(ByRef phThread As Any, ByVal hWD As Integer, ByRef pInt As Any, ByVal IntHandler As Integer, ByVal pData As Integer, ByVal hWnd As Integer) As Integer
	Declare Sub InterruptThreadDisable Lib "WD_UTILS.DLL"  Alias "WD_VB_InterruptThreadDisable"(ByVal hThread As Integer)
	
	' New prototypes. Functions return status.
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function InterruptEnable Lib "WD_UTILS.DLL"  Alias "VB_InterruptEnable"(ByRef phThread As Any, ByVal hWD As Integer, ByRef pInt As Any, ByVal IntHandler As Integer, ByVal pData As Integer, ByVal hWnd As Integer) As Integer
	Declare Function InterruptDisable Lib "WD_UTILS.DLL"  Alias "VB_InterruptDisable"(ByVal hThread As Integer) As Integer
	
	' From wdu_lib.h
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_Init Lib "WD_UTILS.DLL"  Alias "WDU_VB_Init"(ByRef phDriver As Any, ByRef pMatchTables As Any, ByVal dwNumMatchTables As Integer, ByRef pEventTable As Any, ByVal sLicense As String, ByVal dwOptions As Integer, ByVal hWnd As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Sub WDU_Uninit Lib "WD_UTILS.DLL"  Alias "WDU_VB_Uninit"(ByVal hDriver As Any)
	
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_GetDeviceInfo Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByRef ppDeviceInfo As Any) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Sub WDU_PutDeviceInfo Lib "WD_UTILS.DLL" (ByVal pDeviceInfo As Any)
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_SetInterface Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwInterfaceNum As Integer, ByVal dwAlternateSetting As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_SetConfig Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwConfigNum As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_ResetPipe Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_ResetDevice Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwOptions As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_Wakeup Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwOptions As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_Transfer_Renamed Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer, ByVal fRead As Integer, ByVal dwOptions As Integer, ByVal pBuffer As Integer, ByVal dwBufferSize As Integer, ByRef pdwBytesTransferred As Integer, ByVal pSetupPacket As Integer, ByVal dwTimeout As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_HaltTransfer Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_TransferDefaultPipe Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal fRead As Integer, ByVal dwOptions As Integer, ByVal pBuffer As Integer, ByVal dwBufferSize As Integer, ByRef pdwBytesTransferred As Integer, ByVal pSetupPacket As Integer, ByVal dwTimeout As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_TransferBulk Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer, ByVal fRead As Integer, ByVal dwOptions As Integer, ByVal pBuffer As Integer, ByVal dwBufferSize As Integer, ByRef pdwBytesTransferred As Integer, ByVal dwTimeout As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_TransferIsoch Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer, ByVal fRead As Integer, ByVal dwOptions As Integer, ByVal pBuffer As Integer, ByVal dwBufferSize As Integer, ByRef pdwBytesTransferred As Integer, ByVal dwTimeout As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_TransferInterrupt Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal dwPipeNum As Integer, ByVal fRead As Integer, ByVal dwOptions As Integer, ByVal pBuffer As Integer, ByVal dwBufferSize As Integer, ByRef pdwBytesTransferred As Integer, ByVal dwTimeout As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_GetLangIDs Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByRef pbNumSupportedLangIDs As Byte, ByRef pLangIDs As Short, ByVal bNumLangIDs As Byte) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WDU_GetStringDesc Lib "WD_UTILS.DLL" (ByVal hDevice As Any, ByVal bStrIndex As Byte, ByRef pbBuf As Byte, ByVal dwBufSize As Integer, ByVal langID As Short, ByRef pdwDescSize As Integer) As Integer
	
	'win32 API:
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function CreateThread Lib "kernel32" (ByRef psa As Any, ByVal cbStack As Integer, ByVal pfnStartAddr As Integer, ByVal pvParam As Integer, ByVal fdwCreate As Integer, ByRef pdwThreadID As Integer) As Integer
	'Declare Function WaitForSingleObject Lib "kernel32" (ByRef hHandle As Long, _
	''    ByVal dwMilliseconds As Long) As Long
	
	'From utils.h:
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function OsEventCreate Lib "WD_UTILS.DLL" (ByRef phOsEvent As Any) As Integer
	Declare Sub OsEventClose Lib "WD_UTILS.DLL" (ByVal hOsEvent As Integer)
	Declare Function OsEventWait Lib "WD_UTILS.DLL" (ByVal hOsEvent As Integer, ByVal dwSecTimeout As Integer) As Integer
	Declare Function OsEventSignal Lib "WD_UTILS.DLL" (ByVal hOsEvent As Integer) As Integer
	'From utils.c:
	Declare Sub FreeDllPtr Lib "WD_UTILS.DLL" (ByRef ptr As Integer)
	
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
	Declare Function ThreadLoopStart Lib "WD_UTILS.DLL"  Alias "VB_ThreadLoopStart"(ByRef phThread As Integer, ByVal pFunc As Integer, ByVal pData As Integer, ByVal hWnd As Integer) As Integer
	
	' Sub: ThreadLoopStop (Alias to VB_ThreadLoopStop)
	' Parameters:
	'   hThread [in] contains a handle to the thread to be stopped (should be
	'      the handle returned from ThreadLoopStart() in the phThread parameter).
	Declare Sub ThreadLoopStop Lib "WD_UTILS.DLL"  Alias "VB_ThreadLoopStop"(ByVal hThread As Integer)
	
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	'The following definitions are left for backwards compatibility with
	'versions 6.00 - 6.02. However, we recommend that you do NOT use these
	'functions, in order to avoid problems related to multiple threading in
	'Visual Basic. Instead, use ThreadLoopStart() and ThreadLoopStop() (above):
	Public Function ThreadStart(ByRef phThread As Integer, ByVal pFunc As Integer, ByVal pData As Integer) As Integer
		Dim ret As Integer
		Dim dwThreadID As Integer
		'UPGRADE_WARNING: Use of Null/IsNull() detected. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="2EED02CB-5C0E-4DC1-AE94-4FAA3A30F51A"'
		ret = CreateThread(System.DBNull.Value, 0, pFunc, pData, 0, dwThreadID)
		
		If (ret = 0) Then
			ThreadStart = WD_INSUFFICIENT_RESOURCES
		Else
			phThread = ret
			ThreadStart = WD_STATUS_SUCCESS
		End If
	End Function
	Public Sub ThreadStop(ByVal hThread As Integer)
		Call WaitForSingleObject(hThread, INFINITE)
		Call windrvr.CloseHandle(hThread)
	End Sub
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	
	' VB wrapper function for status_string.c C DLL function:
	Public Function Stat2Str(ByVal dwStatus As Integer) As String
		Dim iNullCharLoc As Short
		
		Stat2Str = VB_Stat2Str(dwStatus)
		iNullCharLoc = InStr(Stat2Str, Chr(0))
		
		If iNullCharLoc Then
			Stat2Str = Left(Stat2Str, iNullCharLoc - 1)
		End If
	End Function
End Module