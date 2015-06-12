Option Strict Off
Option Explicit On
Module windrvr
	'
	' ----------------------------------------------------------------
	'
	'  W i n D r i v e r
	'
	'  This file may not be distributed, it is only for evaluation & development purposes.
	'
	'  Web site: http://www.jungo.com
	'  Email:    support@jungo.com
	'
	' Copyright (c) 2003 - 2005 Jungo Ltd.
	' ----------------------------------------------------------------
	'
	
	Public WD_Opened As Boolean
	Public Const WD_VER As Short = 700
	
	Public Const WD_VER_STR As String = "WinDriver V7.00 Jungo (c) 1999 - 2005"
	Public Const WD_VER_MODULE As String = WD_VER_STR
	
	Public Const CMD_NONE As Short = 0 ' No command
	Public Const CMD_END As Short = 1 ' End command
	
	Public Const RP_BYTE As Short = 10 ' Read port byte
	Public Const RP_WORD As Short = 11 ' Read port word
	Public Const RP_DWORD As Short = 12 ' Read port dword
	Public Const WP_BYTE As Short = 13 ' Write port byte
	Public Const WP_WORD As Short = 14 ' Write port word
	Public Const WP_DWORD As Short = 15 ' Write port dword
	Public Const RP_QWORD As Short = 16 ' Read port qword
	Public Const WP_QWORD As Short = 17 ' Write port qword
	
	Public Const RP_SBYTE As Short = 20 ' Read port string byte
	Public Const RP_SWORD As Short = 21 ' Read port string word
	Public Const RP_SDWORD As Short = 22 ' Read port string dword
	Public Const WP_SBYTE As Short = 23 ' Write port string byte
	Public Const WP_SWORD As Short = 24 ' Write port string word
	Public Const WP_SDWORD As Short = 25 ' Write port string dword
	
	Public Const RM_BYTE As Short = 30 ' Read memory byte
	Public Const RM_WORD As Short = 31 ' Read memory word
	Public Const RM_DWORD As Short = 32 ' Read memory dword
	Public Const WM_BYTE As Short = 33 ' Write memory byte
	Public Const WM_WORD As Short = 34 ' Write memory word
	Public Const WM_DWORD As Short = 35 ' Write memory dword
	Public Const RM_QWORD As Short = 36 ' Read memory qword
	Public Const WM_QWORD As Short = 37 ' Write memory qword
	
	Public Const RM_SBYTE As Short = 40 ' Read memory string byte
	Public Const RM_SWORD As Short = 41 ' Read memory string word
	Public Const RM_SDWORD As Short = 42 ' Read memory string dword
	Public Const WM_SBYTE As Short = 43 ' Write memory string byte
	Public Const WM_SWORD As Short = 44 ' Write memory string word
	Public Const WM_SDWORD As Short = 45 ' Write memory string dword
	Public Const RM_SQWORD As Short = 46 ' Read memory string quad word
	Public Const WM_SQWORD As Short = 47 ' Write memory string quad word
	
	Public Const WM_APP As Integer = &H8000 ' Platform SDK constant
	
	Public Const WD_DMA_PAGES As Short = 256
	
	Public Const DMA_KERNEL_BUFFER_ALLOC As Short = 1 ' the system allocates a contiguous buffer
	' the user does not need to supply linear_address
	Public Const DMA_KBUF_BELOW_16M As Short = 2 ' if DMA_KERNEL_BUFFER_ALLOC if used,
	' this will make sure it is under 16M
	Public Const DMA_LARGE_BUFFER As Short = 4 ' if DMA_LARGE_BUFFER if used,
	' the maximum number of pages are dwPages, and not
	' WD_DMA_PAGES. if you lock a user buffer (not a kernel
	' allocated buffer) that is larger than 1MB, then use this
	' option, and allocate memory for pages.
	
	
	Structure PVOID
		Dim ptr As Integer
	End Structure
	
	
	
	Structure WD_DMA_PAGE
		Dim pPhysicalAddr As PVOID ' physical address of page
		Dim dwBytes As Integer ' size of page
	End Structure
	
	
	Structure WD_DMA
		Dim hDMA As Integer ' handle of DMA buffer
		Dim pUserAddr As PVOID ' beginning of buffer
		Dim pKernelAddr As Integer ' Kernel mapping of kernel allocated buffer
		Dim dwBytes As Integer ' size of buffer
		Dim dwOptions As Integer ' allocation options
		Dim dwPages As Integer ' number of pages in buffer
		Dim dwPad1 As Integer ' Reserved for internal use
		<VBFixedArray(WD_DMA_PAGES - 1)> Dim Page() As WD_DMA_PAGE
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim Page(WD_DMA_PAGES - 1)
		End Sub
	End Structure
	
	Structure WD_Transfer
		Dim dwPort As Integer ' IO port for transfer or user memory address
		Dim cmdTrans As Integer ' Transfer command WD_TRANSFER_CMD
		Dim dwBytes As Integer ' For string transfer
		Dim fAutoInc As Integer ' Transfer from one port/address or
		' use incremental range of addresses
		Dim dwOptions As Integer ' Must be 0
		Dim dwPad1 As Integer ' Padding for internal uses
		Dim dwLowDataTransfer As Integer
		Dim dwHighDataTransfer As Integer 'Must be zero for data size smaller then 64 bits
	End Structure
	
	Structure PWD_TRANSFER ' pointer to WD_TRANSFER
		'UPGRADE_NOTE: cmd was upgraded to cmd_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim cmd_Renamed As Integer
	End Structure
	
	Public Structure WDU_INTERFACE_DESCRIPTOR
		Dim bLength As Byte
		Dim bDescriptorType As Byte
		Dim bInterfaceNumber As Byte
		Dim bAlternateSetting As Byte
		Dim bNumEndpoints As Byte
		Dim bInterfaceClass As Byte
		Dim bInterfaceSubClass As Byte
		Dim bInterfaceProtocol As Byte
		Dim iInterface As Byte
	End Structure
	
	Public Structure WDU_ENDPOINT_DESCRIPTOR
		Dim bLength As Byte
		Dim bDescriptorType As Byte
		Dim bEndpointAddress As Byte
		Dim bmAttributes As Byte
		Dim wMaxPacketSize As Short
		Dim bInterval As Byte
	End Structure
	
	Public Structure WDU_CONFIGURATION_DESCRIPTOR
		Dim bLength As Byte
		Dim bDescriptorType As Byte
		Dim wTotalLength As Short
		Dim bNumInterfaces As Byte
		Dim bConfigurationValue As Byte
		Dim iConfiguration As Byte
		Dim bmAttributes As Byte
		Dim MaxPower As Byte
	End Structure
	
	Public Structure WDU_DEVICE_DESCRIPTOR
		Dim bLength As Byte
		Dim bDescriptorType As Byte
		Dim bcdUSB As Short
		Dim bDeviceClass As Byte
		Dim bDeviceSubClass As Byte
		Dim bDeviceProtocol As Byte
		Dim bMaxPacketSize0 As Byte
		Dim idVendor As Short
		Dim idProduct As Short
		Dim bcdDevice As Short
		Dim iManufacturer As Byte
		Dim iProduct As Byte
		Dim iSerialNumber As Byte
		Dim bNumConfigurations As Byte
	End Structure
	
	Public Structure WDU_PIPE_INFO
		Dim dwNumber As Integer
		Dim dwMaximumPacketSize As Integer
		Dim type As Integer
		Dim direction As Integer
		Dim dwInterval As Integer
	End Structure
	
	Public Structure WDU_ALTERNATE_SETTING
		Dim Descriptor As WDU_INTERFACE_DESCRIPTOR
		Dim pEndpointDescriptors As Integer
		Dim pPipes As Integer
	End Structure
	
	Public Structure WDU_INTERFACE
		Dim pAlternateSettings As Integer
		Dim dwNumAltSettings As Integer
		Dim pActiveAltSetting As Integer
	End Structure
	
	Public Structure WDU_CONFIGURATION
		Dim Descriptor As WDU_CONFIGURATION_DESCRIPTOR
		Dim dwNumInterfaces As Integer
		Dim pInterfaces As Integer
	End Structure
	
	Public Structure WDU_DEVICE
		Dim Descriptor As WDU_DEVICE_DESCRIPTOR
		Dim Pipe0 As WDU_PIPE_INFO
		Dim pConfigs As Integer
		Dim pActiveConfig As Integer
		Dim pActiveInterface As Integer
	End Structure
	
	Public Structure WDU_MATCH_TABLE
		Dim wVendorId As Short
		Dim wProductId As Short
		Dim bDeviceClass As Byte
		Dim bDeviceSubClass As Byte
		Dim bInterfaceClass As Byte
		Dim bInterfaceSubClass As Byte
		Dim bInterfaceProtocol As Byte
	End Structure
	
	Public Structure WDU_EVENT_TABLE
		Dim pfDeviceAttach As Integer
		Dim pfDeviceDetach As Integer
		Dim pfPowerChange As Integer
		Dim pUserData As Integer
	End Structure
	
	Public Structure WDU_GET_DEVICE_DATA
		Dim dwUniqueID As Integer
		Dim pBuf As Integer
		Dim dwBytes As Integer
		Dim dwOptions As Integer
	End Structure
	
	Public Structure WDU_SET_INTERFACE
		Dim dwUniqueID As Integer
		Dim dwInterfaceNum As Integer
		Dim dwAlternateSetting As Integer
		Dim dwOptions As Integer
	End Structure
	
	Public Structure WDU_RESET_PIPE
		Dim dwUniqueID As Integer
		Dim dwPipeNum As Integer
		Dim dwOptions As Integer
	End Structure
	
	Public Const WDU_WAKEUP_ENABLE As Integer = &H1
	Public Const WDU_WAKEUP_DISABLE As Integer = &H2
	
	Public Structure WDU_HALT_TRANSFER
		Dim dwUniqueID As Integer
		Dim dwPipeNum As Integer
		Dim dwOptions As Integer
	End Structure
	
	Public Structure WDU_GET_DESCRIPTOR
		Dim dwUniqueID As Integer
		Dim bType As Byte
		Dim bIndex As Byte
		Dim wLength As Short
		Dim pBuffer As Integer
		Dim wLanguage As Short
	End Structure
	
	Private IOCTL_WD_DMA_LOCK As Integer
	Private IOCTL_WD_DMA_UNLOCK As Integer
	Private IOCTL_WD_TRANSFER As Integer
	Private IOCTL_WD_MULTI_TRANSFER As Integer
	Private IOCTL_WD_PCI_SCAN_CARDS As Integer
	Private IOCTL_WD_PCI_GET_CARD_INFO As Integer
	Private IOCTL_WD_VERSION As Integer
	Private IOCTL_WD_LICENSE As Integer
	Private IOCTL_WD_PCI_CONFIG_DUMP As Integer
	Private IOCTL_WD_KERNEL_PLUGIN_OPEN As Integer
	Private IOCTL_WD_KERNEL_PLUGIN_CLOSE As Integer
	Private IOCTL_WD_KERNEL_PLUGIN_CALL As Integer
	Private IOCTL_WD_INT_ENABLE As Integer
	Private IOCTL_WD_INT_DISABLE As Integer
	Private IOCTL_WD_INT_COUNT As Integer
	Private IOCTL_WD_INT_WAIT As Integer
	Private IOCTL_WD_ISAPNP_SCAN_CARDS As Integer
	Private IOCTL_WD_ISAPNP_GET_CARD_INFO As Integer
	Private IOCTL_WD_ISAPNP_CONFIG_DUMP As Integer
	Private IOCTL_WD_PCMCIA_SCAN_CARDS As Integer
	Private IOCTL_WD_PCMCIA_GET_CARD_INFO As Integer
	Private IOCTL_WD_PCMCIA_CONFIG_DUMP As Integer
	Private IOCTL_WD_SLEEP As Integer
	Private IOCTL_WD_DEBUG As Integer
	Private IOCTL_WD_DEBUG_DUMP As Integer
	Private IOCTL_WD_CARD_UNREGISTER As Integer
	Private IOCTL_WD_CARD_REGISTER As Integer
	Private IOCTL_WD_EVENT_REGISTER As Integer
	Private IOCTL_WD_EVENT_UNREGISTER As Integer
	Private IOCTL_WD_EVENT_PULL As Integer
	Private IOCTL_WD_EVENT_SEND As Integer
	Private IOCTL_WD_DEBUG_ADD As Integer
	
	
	Public Const INTERRUPT_LEVEL_SENSITIVE As Short = 1
	Public Const INTERRUPT_CMD_COPY As Short = 2
	
	Structure WD_KERNEL_PLUGIN_CALL
		Dim hKernelPlugIn As Integer
		Dim dwMessage As Integer
		Dim pData As PVOID
		Dim dwResult As Integer
	End Structure
	
	Structure WD_INTERRUPT
		Dim hInterrupt As Integer ' handle of interrupt
		Dim dwOptions As Integer ' interrupt options as INTERRUPT_CMD_COPY
		'UPGRADE_NOTE: cmd was upgraded to cmd_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim cmd_Renamed As PWD_TRANSFER ' commands to do on interrupt
		Dim dwCmds As Integer ' number of commands for WD_IntEnable()
		Dim kpCall As WD_KERNEL_PLUGIN_CALL ' kernel plugin call
		Dim fEnableOk As Integer ' did WD_IntEnable() succeed
		' For WD_IntWait() and WD_IntCount()
		Dim dwCounter As Integer ' number of interrupts received
		Dim dwLost As Integer ' number of interrupts not yet dealt with
		Dim fStopped As Integer ' was interrupt disabled during wait
	End Structure
	
	Structure WD_Version
		Dim dwVer As Integer
		'UPGRADE_WARNING: Fixed-length string size must fit in the buffer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="3C1E4426-0B80-443E-B943-0627CD55D48B"'
		<VBFixedString(128),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=128)> Public cVer() As Char
	End Structure
	
	Public Const LICENSE_DEMO As Integer = &H1
	Public Const LICENSE_WD As Integer = &H4
	Public Const LICENSE_KD As Integer = &H400000
	Public Const LICENSE_IO As Integer = &H8
	Public Const LICENSE_MEM As Integer = &H10
	Public Const LICENSE_INT As Integer = &H20
	Public Const LICENSE_PCI As Integer = &H40
	Public Const LICENSE_DMA As Integer = &H80
	Public Const LICENSE_NT As Integer = &H100
	Public Const LICENSE_95 As Integer = &H200
	Public Const LICENSE_ISAPNP As Integer = &H400
	Public Const LICENSE_PCMCIA As Integer = &H800
	Public Const LICENSE_PCI_DUMP As Integer = &H1000
	Public Const LICENSE_MSG_GEN As Integer = &H2000
	Public Const LICENSE_MSG_EDU As Integer = &H4000
	Public Const LICENSE_MSG_INT As Integer = &H8000
	Public Const LICENSE_KER_PLUG As Integer = &H10000
	Public Const LICENSE_LINUX As Integer = &H20000
	Public Const LICENSE_CE As Integer = &H80000
	Public Const LICENSE_VXWORKS As Integer = &H10000000
	Public Const LICENSE_THIS_PC As Integer = &H100000
	Public Const LICENSE_WIZARD As Integer = &H200000
	Public Const LICENSE_SOLARIS As Integer = &H800000
	Public Const LICENSE_CPU0 As Integer = &H40000
	Public Const LICENSE_CPU1 As Integer = &H1000000
	Public Const LICENSE_CPU2 As Integer = &H2000000
	Public Const LICENSE_CPU3 As Integer = &H4000000
	Public Const LICENSE_USB As Integer = &H8000000
	
	Public Const LICENSE2_EVENT As Integer = &H8
	Public Const LICENSE2_WDLIB As Integer = &H10
	Public Const LICENSE2_WDF As Integer = &H20
	
	Structure WD_License
		'UPGRADE_WARNING: Fixed-length string size must fit in the buffer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="3C1E4426-0B80-443E-B943-0627CD55D48B"'
		<VBFixedString(128),System.Runtime.InteropServices.MarshalAs(System.Runtime.InteropServices.UnmanagedType.ByValArray,SizeConst:=128)> Public cLicense() As Char ' Buffer with license string to register.
		' If valid license, it's setting information will
		' be returned by WD_License() in dwLicense/dwLicense2.
		' If empty string, WD_License() will return
		' the information for WinDriver license(s) currently
		' registered in the system.
		Dim dwLicense As Integer ' License settings returned from WD_License():
		' LICENSE_DEMO, LICENSE_WD etc... (or 0 for
		' invalid license).
		Dim dwLicense2 As Integer ' If dwLicense cannot hold all the information, then
		' the additional info will be returned in dwLicense2.
	End Structure
	
	Structure WD_BUS
		Dim dwBusType As Integer ' Bus Type: ISA, EISA, PCI, PCMCIA
		Dim dwBusNum As Integer ' Bus number
		Dim dwSlotFunc As Integer ' Slot number on Bus
	End Structure
	
	Public Const WD_BUS_ISA As Short = 1
	Public Const WD_BUS_EISA As Short = 2
	Public Const WD_BUS_PCI As Short = 5
	Public Const WD_BUS_PCMCIA As Short = 8
	
	Public Const ITEM_NONE As Short = 0
	Public Const ITEM_INTERRUPT As Short = 1
	Public Const ITEM_MEMORY As Short = 2
	Public Const ITEM_IO As Short = 3
	Public Const ITEM_BUS As Short = 5
	
	Public Const WD_ITEM_DO_NOT_MAP_KERNEL As Short = 1
	
	Structure WD_ITEMS
		Dim Item As Integer ' ITEM_TYPE
		Dim fNotSharable As Integer
		Dim dwContext As Integer ' Reserved for internal use
		Dim dwOptions As Integer ' can be WD_ITEM_DO_NOT_MAP_KERNEL
		' for ITEM_INTERRUPT
		' dw1 - number of interrupt to install
		' dw2 - interrupt options: INTERRUPT_LEVEL_SENSITIVE
		' dw3 - returns the handle of the interrupt installed
		' for ITEM_MEMORY
		' dw1 - physical address on card
		' dw2 - address range
		' dw3 - returns the address to pass on to transfer commands
		' dw4 - returns the address for direct user read/write
		' dw5 - returns the CPU physical address of card
		' dw6 - Base Address Register number of PCI card
		' for ITEM_IO
		' dw1 - beginning of io address
		' dw2 - io range
		' dw3 - Base Address Register number of PCI card
		Dim dw1 As Integer
		Dim dw2 As Integer
		Dim dw3 As Integer
		Dim dw4 As Integer
		Dim dw5 As Integer
		Dim dw6 As Integer
	End Structure
	
	Public Const WD_CARD_ITEMS As Short = 20
	
	Structure WD_CARD
		Dim dwItems As Integer
		<VBFixedArray(WD_CARD_ITEMS - 1)> Dim Item() As WD_ITEMS
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim Item(WD_CARD_ITEMS - 1)
		End Sub
	End Structure
	
	Structure WD_CARD_REGISTER
		'UPGRADE_WARNING: Arrays in structure Card may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim Card As WD_CARD ' card to register
		Dim fCheckLockOnly As Integer ' only check if card is lockable, return hCard=1 if OK
		Dim hCard As Integer ' handle of card
		Dim dwOptions As Integer ' should be zero
		<VBFixedArray(31)> Dim cName() As Byte ' name of card
		<VBFixedArray(100 - 1)> Dim cDescription() As Byte ' description
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			Card.Initialize()
			ReDim cName(31)
			ReDim cDescription(100 - 1)
		End Sub
	End Structure
	
	Public Const WD_PCI_CARDS As Short = 100
	
	Structure WD_PCI_SLOT
		Dim dwBus As Integer
		Dim dwSlot As Integer
		Dim dwFunction As Integer
	End Structure
	
	Structure WD_PCI_ID
		Dim dwVendorID As Integer
		Dim dwDeviceID As Integer
	End Structure
	
	Structure WD_PCI_SCAN_CARDS
		Dim searchId As WD_PCI_ID ' if dwVendorId = 0, scan all
		' vendor Ids
		' if dwDeviceId = 0, scan all
		' device Ids
		Dim dwCards As Integer ' Number of cards found
		<VBFixedArray(WD_PCI_CARDS - 1)> Dim cardId() As WD_PCI_ID
		' VendorID & DeviceID of cards found
		<VBFixedArray(WD_PCI_CARDS - 1)> Dim cardSlot() As WD_PCI_SLOT
		' PCI slot info of cards found
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim cardId(WD_PCI_CARDS - 1)
			ReDim cardSlot(WD_PCI_CARDS - 1)
		End Sub
	End Structure
	
	Structure WD_PCI_CARD_INFO
		Dim pciSlot As WD_PCI_SLOT ' PCI slot
		'UPGRADE_WARNING: Arrays in structure Card may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim Card As WD_CARD ' Get card parameters for PCI slot
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			Card.Initialize()
		End Sub
	End Structure
	
	Public Const PCI_ACCESS_OK As Short = 0
	Public Const PCI_ACCESS_ERROR As Short = 1
	Public Const PCI_BAD_BUS As Short = 2
	Public Const PCI_BAD_SLOT As Short = 3
	
	Structure WD_PCI_CONFIG_DUMP
		Dim pciSlot As WD_PCI_SLOT ' PCI bus, slot and function number
		Dim pBuffer As PVOID ' buffer for read/write
		Dim dwOffset As Integer ' offset in pci configuration space
		' to read/write from
		Dim dwBytes As Integer ' bytes to read/write from/to buffer
		' returns the # of bytes read/written
		Dim fIsRead As Integer ' if 1 then read pci config, 0 write pci config
		Dim dwResult As Integer ' PCI_ACCESS_RESULT
	End Structure
	
	Public Const WD_ISAPNP_CARDS As Short = 16
	Public Const WD_ISAPNP_COMPATIBLE_IDS As Short = 10
	Public Const WD_ISAPNP_COMP_ID_LENGTH As Short = 7 ' ISA compressed ID is 7 chars long
	Public Const WD_ISAPNP_ANSI_LENGTH As Short = 32 ' ISA ANSI ID is limited to 32 chars long
	
	
	Structure WD_ISAPNP_COMP_ID
		<VBFixedArray(WD_ISAPNP_COMP_ID_LENGTH)> Dim compID() As Byte
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim compID(WD_ISAPNP_COMP_ID_LENGTH)
		End Sub
	End Structure
	Structure WD_ISAPNP_ANSI
		'UPGRADE_NOTE: ansi was upgraded to ansi_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		<VBFixedArray(WD_ISAPNP_ANSI_LENGTH + 3)> Dim ansi_Renamed() As Byte ' add 3 bytes for DWORD alignment
	End Structure
	
	
	
	Structure WD_ISAPNP_CARD_ID
		'UPGRADE_WARNING: Arrays in structure cVendor may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim cVendor As WD_ISAPNP_COMP_ID ' Vendor ID
		Dim dwSerial As Integer ' Serial number of card
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			cVendor.Initialize()
		End Sub
	End Structure
	
	
	Structure WD_ISAPNP_CARD
		Dim cardId As WD_ISAPNP_CARD_ID ' VendorID & serial number of cards found
		Dim dcLogicalDevices As Integer ' Logical devices on the card
		Dim bPnPVersionMajor As Byte ' ISA PnP version Major
		Dim bPnPVersionMinor As Byte ' ISA PnP version Minor
		Dim bVendorVersionMajor As Byte ' Vendor version Major
		Dim bVendorVersionMinor As Byte ' Vendor version Minor
		'UPGRADE_WARNING: Arrays in structure cIdent may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim cIdent As WD_ISAPNP_ANSI ' Device identifier
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			cardId.Initialize()
		End Sub
	End Structure
	
	Structure WD_ISAPNP_SCAN_CARDS
		Dim searchId As WD_ISAPNP_CARD_ID ' if searchId.cVendor[0]==0 - scan all vendor IDs
		' if searchId.dwSerial==0 - scan all serial numbers
		Dim dwCards As Integer ' number of cards found
		'UPGRADE_WARNING: Array Card may need to have individual elements initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B97B714D-9338-48AC-B03F-345B617E2B02"'
		<VBFixedArray(WD_ISAPNP_CARDS - 1)> Dim Card() As WD_ISAPNP_CARD ' cards found
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			searchId.Initialize()
			ReDim Card(WD_ISAPNP_CARDS - 1)
		End Sub
	End Structure
	
	
	Structure WD_ISAPNP_CARD_INFO
		Dim cardId As WD_ISAPNP_CARD_ID ' VendorID and serial number of card
		Dim dwLogicalDevice As Integer ' logical device in card
		'UPGRADE_WARNING: Arrays in structure cLogicalDeviceId may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim cLogicalDeviceId As WD_ISAPNP_COMP_ID ' logical device ID
		Dim dwCompatibleDevices As Integer ' number of compatible device IDs
		'UPGRADE_WARNING: Array CompatibleDevice may need to have individual elements initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B97B714D-9338-48AC-B03F-345B617E2B02"'
		<VBFixedArray(WD_ISAPNP_COMPATIBLE_IDS - 1)> Dim CompatibleDevice() As WD_ISAPNP_COMP_ID ' Compatible device IDs
		'UPGRADE_WARNING: Arrays in structure cIdent may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim cIdent As WD_ISAPNP_ANSI ' Device identifier
		'UPGRADE_WARNING: Arrays in structure Card may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim Card As WD_CARD ' get card parameters for the ISA PnP card
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			cardId.Initialize()
			cLogicalDeviceId.Initialize()
			ReDim CompatibleDevice(WD_ISAPNP_COMPATIBLE_IDS - 1)
			Card.Initialize()
		End Sub
	End Structure
	
	Public Const ISAPNP_ACCESS_OK As Short = 0
	Public Const ISAPNP_ACCESS_ERROR As Short = 1
	Public Const ISAPNP_BAD_ID As Short = 2
	
	Structure WD_ISAPNP_CONFIG_DUMP
		Dim cardId As WD_ISAPNP_CARD_ID ' VendorID and serial number of card
		Dim dwOffset As Integer ' offset in ISA PnP configuration space to read/write from
		Dim fIsRead As Integer ' if 1 then read ISA PnP config, 0 write ISA PnP config
		Dim bData As Byte ' result data of byte read/write
		Dim dwResult As Integer ' ISAPNP_ACCESS_RESULT
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			cardId.Initialize()
		End Sub
	End Structure
	
	Public Const WD_PCMCIA_CARDS As Short = 8
	Public Const WD_PCMCIA_VERSION_LEN As Short = 4
	Public Const WD_PCMCIA_MANUFACTURER_LEN As Short = 48
	Public Const WD_PCMCIA_PRODUCTNAME_LEN As Short = 48
	Public Const WD_PCMCIA_MAX_SOCKET As Short = 2
	Public Const WD_PCMCIA_MAX_FUNCTION As Short = 2
	
	
	Structure WD_PCMCIA_SLOT
		Dim uSocket As Byte ' Specifies the socket number (first socket is 0)
		Dim uFunction As Byte ' Specifies the function number (first function is 0)
		Dim uPadding0 As Byte ' 2 bytes padding so structure will be 4 bytes aligned
		Dim uPadding1 As Byte
	End Structure
	
	Structure WD_PCMCIA_ID
		Dim dwManufacturerId As Integer ' card manufacturer
		Dim dwCardId As Integer ' card type and model
	End Structure
	
	Structure WD_PCMCIA_SCAN_CARDS
		Dim searchId As WD_PCMCIA_ID ' device ID to search for
		Dim dwCards As Integer ' number of cards found
		<VBFixedArray(WD_PCMCIA_CARDS - 1)> Dim cardId() As WD_PCMCIA_ID ' device IDs of cards found
		<VBFixedArray(WD_PCMCIA_CARDS - 1)> Dim cardSlot() As WD_PCMCIA_SLOT ' pcmcia slot info of cards found
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim cardId(WD_PCMCIA_CARDS - 1)
			ReDim cardSlot(WD_PCMCIA_CARDS - 1)
		End Sub
	End Structure
	
	Structure WD_PCMCIA_CARD_INFO
		Dim pcmciaSlot As WD_PCMCIA_SLOT ' pcmcia slot
		'UPGRADE_WARNING: Arrays in structure Card may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim Card As WD_CARD ' get card parameters for pcmcia slot
		<VBFixedArray(WD_PCMCIA_VERSION_LEN - 1)> Dim cVersion() As Byte
		<VBFixedArray(WD_PCMCIA_MANUFACTURER_LEN - 1)> Dim cManufacturer() As Byte
		<VBFixedArray(WD_PCMCIA_PRODUCTNAME_LEN - 1)> Dim cProductName() As Byte
		Dim dwManufacturerId As Integer ' card manufacturer
		Dim dwCardId As Integer ' card type and model
		Dim dwFuncId As Integer ' card function code
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			Card.Initialize()
			ReDim cVersion(WD_PCMCIA_VERSION_LEN - 1)
			ReDim cManufacturer(WD_PCMCIA_MANUFACTURER_LEN - 1)
			ReDim cProductName(WD_PCMCIA_PRODUCTNAME_LEN - 1)
		End Sub
	End Structure
	
	Structure WD_PCMCIA_CONFIG_DUMP
		Dim pcmciaSlot As WD_PCMCIA_SLOT
		Dim pBuffer As PVOID ' buffer for read/write
		Dim dwOffset As Integer ' offset in pcmcia configuration space to
		' read/write from
		Dim dwBytes As Integer ' bytes to read/write from/to buffer
		' returns the number of bytes read/wrote
		Dim fIsRead As Integer ' if 1 then read pci config, 0 write pci config
		Dim dwResult As Integer ' PCMCIA_ACCESS_RESULT
	End Structure
	
	Public Const SLEEP_NON_BUSY As Short = 1
	
	Structure WD_Sleep
		Dim dwMicroSeconds As Integer ' Sleep time in Micro Seconds (1/1,000,000 Second)
		Dim dwOptions As Integer ' can be:
		' SLEEP_NON_BUSY this is accurate only for times above 10000 uSec
	End Structure
	
	Public Const D_OFF As Short = 0
	Public Const D_ERROR As Short = 1
	Public Const D_WARN As Short = 2
	Public Const D_INFO As Short = 3
	Public Const D_TRACE As Short = 4
	
	Public Const S_ALL As Integer = &HFFFFFFFF
	Public Const S_IO As Integer = &H8
	Public Const S_MEM As Integer = &H10
	Public Const S_INT As Integer = &H20
	Public Const S_PCI As Integer = &H40
	Public Const S_DMA As Integer = &H80
	Public Const S_MISC As Integer = &H100
	Public Const S_LICENSE As Integer = &H200
	Public Const S_ISAPNP As Integer = &H400
	Public Const S_PCMCIA As Integer = &H800
	Public Const S_KER_PLUG As Integer = &H10000
	Public Const S_CARD_REG As Integer = &H2000
	
	Public Const DEBUG_STATUS As Short = 1
	Public Const DEBUG_SET_FILTER As Short = 2
	Public Const DEBUG_SET_BUFFER As Short = 3
	Public Const DEBUG_CLEAR_BUFFER As Short = 4
	Public Const DEBUG_DUMP_SEC_ON As Short = 5
	Public Const DEBUG_DUMP_SEC_OFF As Short = 6
	Public Const KERNEL_DEBUGGER_ON As Short = 7
	Public Const KERNEL_DEBUGGER_OFF As Short = 8
	
	'from win32API
	Declare Function CreateFile Lib "kernel32"  Alias "CreateFileA"(ByVal lpFileName As String, ByVal dwDesiredAccess As Integer, ByVal dwShareMode As Integer, ByVal lpSecurityAttributes As Integer, ByVal dwCreationDisposition As Integer, ByVal dwFlagsAndAttributes As Integer, ByVal hTemplateFile As Integer) As Integer
	Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Integer) As Integer
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function DeviceIoControl Lib "kernel32" (ByVal hDevice As Integer, ByVal dwIoControlCode As Integer, ByRef lpInBuffer As Any, ByVal nInBufferSize As Integer, ByRef lpOutBuffer As Integer, ByVal nOutBufferSize As Integer, ByRef lpBytesReturned As Integer, ByVal lpOverlapped As Integer) As Integer
	'Declare Sub MemCpy Lib "kernel32" Alias "RtlMoveMemory" _
	''         (ByVal hpvDest As Long, ByVal hpvSource As Any, ByVal cbCopy As Long)
	Private Const GENERIC_READ As Integer = &H80000000
	Private Const FILE_SHARE_READ As Integer = &H1
	Private Const FILE_SHARE_WRITE As Integer = &H2
	Private Const OPEN_EXISTING As Short = 3
	Private Const FILE_FLAG_OVERLAPPED As Integer = &H40000000
	Public Const INVALID_HANDLE_VALUE As Short = -1
	
	'call this function with the variable of which you need the pointer and the last two params pass 1
	'address = WD_VB_GetAddress (Variable, 1, 1) 'this extracts the address of Variable
	'UPGRADE_ISSUE: Declaring a parameter 'As Any' is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="FAE78A8D-8978-4FD4-8208-5B7324A8F795"'
	Declare Function WD_VB_GetAddress Lib "kernel32"  Alias "MulDiv"(ByRef dwNum As Any, ByVal one As Integer, ByVal one_ As Integer) As Integer
	
	Structure WD_Debug
		Dim dwCmd As Integer ' DEBUG_COMMAND as DEBUG_STATUS, DEBUG_SET_FILTER, DEBUG_SET_BUFFER, DEBUG_CLEAR_BUFFER
		' used for DEBUG_SET_FILTER
		Dim dwLevel As Integer ' DEBUG_LEVEL as D_ERROR, D_WARN..., or D_OFF to turn debugging off
		Dim dwSection As Integer ' DEBUG_SECTION as for all sections in driver as S_ALL
		' for partial sections as S_IO, S_MEM...
		Dim dwLevelMessageBox As Integer ' DEBUG_LEVEL to print in a message box
		' used for DEBUG_SET_BUFFER
		Dim dwBufferSize As Integer ' size of buffer in kernel
	End Structure
	
	Structure PChar
		Dim charPtr As Integer
	End Structure
	
	Structure WD_DEBUG_DUMP
		Dim pcBuffer As PChar ' buffer to receive debug messages
		Dim dwSize As Integer ' size of buffer in bytes
	End Structure
	
	Structure WD_DEBUG_ADD
		<VBFixedArray(256 - 1)> Dim pcBuffer() As Byte
		Dim dwLevel As Integer
		Dim dwSection As Integer
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim pcBuffer(256 - 1)
		End Sub
	End Structure
	
	Structure WD_KERNEL_PLUGIN
		Dim hKernelPlugIn As Integer
		Dim pcDriverName As PChar
		Dim pcDriverPath As PChar ' if NULL the driver will be searched in the windows system directory
		Dim pOpenData As PVOID
	End Structure
	
	Public Const PIPE_TYPE_CONTROL As Short = 0
	Public Const PIPE_TYPE_ISOCHRONOUS As Short = 1
	Public Const PIPE_TYPE_BULK As Short = 2
	Public Const PIPE_TYPE_INTERRUPT As Short = 3
	
	Public Const WD_USB_MAX_PIPE_NUMBER As Short = 32
	Public Const WD_USB_MAX_ENDPOINTS As Short = 32
	Public Const WD_USB_MAX_INTERFACES As Short = 30
	Public Const WD_USB_MAX_DEVICE_NUMBER As Short = 30
	
	Public Const WDU_DIR_IN As Short = 1
	Public Const WDU_DIR_OUT As Short = 2
	Public Const WDU_DIR_IN_OUT As Short = 3
	
	Structure WD_USB_ID
		Dim dwVendorID As Integer
		Dim dwProductID As Integer
	End Structure
	
	Structure WD_USB_PIPE_INFO
		Dim dwNumber As Integer ' Pipe 0 is the default pipe
		Dim dwMaximumPacketSize As Integer
		Dim type As Integer ' USB_PIPE_TYPE
		Dim direction As Integer ' WDU_DIR
		' Isochronous, Bulk, Interrupt are either WDU_DIR_IN or WDU_DIR_OUT
		' Control are WDU_DIR_IN_OUT
		Dim dwInterval As Integer ' interval in ms relevant to Interrupt pipes
	End Structure
	
	Structure WD_USB_CONFIG_DESC
		Dim dwNumInterfaces As Integer
		Dim dwValue As Integer
		Dim dwAttributes As Integer
		Dim MaxPower As Integer
	End Structure
	
	Structure WD_USB_INTERFACE_DESC
		Dim dwNumber As Integer
		Dim dwAlternateSetting As Integer
		Dim dwNumEndpoints As Integer
		Dim dwClass As Integer
		Dim dwSubClass As Integer
		Dim dwProtocol As Integer
		Dim dwIndex As Integer
	End Structure
	
	Structure WD_USB_ENDPOINT_DESC
		Dim dwEndpointAddress As Integer
		Dim dwAttributes As Integer
		Dim dwMaxPacketSize As Integer
		Dim dwInterval As Integer
	End Structure
	
	Structure WD_USB_INTERFACE
		'UPGRADE_NOTE: Interface was upgraded to Interface_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		Dim Interface_Renamed As WD_USB_INTERFACE_DESC
		<VBFixedArray(WD_USB_MAX_ENDPOINTS - 1)> Dim Endpoints() As WD_USB_ENDPOINT_DESC
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim Endpoints(WD_USB_MAX_ENDPOINTS - 1)
		End Sub
	End Structure
	
	Structure WD_USB_CONFIGURATION
		Dim uniqueId As Integer
		Dim dwConfigurationIndex As Integer
		Dim configuration As WD_USB_CONFIG_DESC
		Dim dwInterfaceAlternatives As Integer
		'UPGRADE_WARNING: Array Interface_Renamed may need to have individual elements initialized. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B97B714D-9338-48AC-B03F-345B617E2B02"'
		'UPGRADE_NOTE: Interface was upgraded to Interface_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
		<VBFixedArray(WD_USB_MAX_INTERFACES - 1)> Dim Interface_Renamed() As WD_USB_INTERFACE
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES enum definition.
		' WD_USBD_STATUS_SUCCESS for a successful configuration.
	End Structure
	
	Structure WD_USB_HUB_GENERAL_INFO
		Dim fBusPowered As Integer
		Dim dwPorts As Integer ' number of ports on this hub
		Dim dwCharacteristics As Integer ' Hub Characteristics
		Dim dwPowerOnToPowerGood As Integer ' port power on till power good in 2ms
		Dim dwHubControlCurrent As Integer ' max current in mA
	End Structure
	
	Public Const WD_SINGLE_INTERFACE As Integer = &HFFFFFFFF
	
	Structure WD_USB_DEVICE_GENERAL_INFO
		Dim deviceId As WD_USB_ID
		Dim dwHubNum As Integer
		Dim dwPortNum As Integer
		Dim fHub As Integer
		Dim fFullSpeed As Integer
		Dim dwConfigurationsNum As Integer
		Dim deviceAddress As Integer
		Dim hubInfo As WD_USB_HUB_GENERAL_INFO
		Dim deviceClass As Integer
		Dim deviceSubClass As Integer
		Dim dwInterfaceNum As Integer ' For a single device WinDriver sets this
		' value to WD_SINGLE_INTERFACE
	End Structure
	
	Structure WD_USB_DEVICE_INFO
		Dim dwPipes As Integer
		<VBFixedArray(WD_USB_MAX_PIPE_NUMBER - 1)> Dim Pipe() As WD_USB_PIPE_INFO
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim Pipe(WD_USB_MAX_PIPE_NUMBER - 1)
		End Sub
	End Structure
	
	Structure WD_USB_SCAN_DEVICES
		Dim searchId As WD_USB_ID ' if dwVendorID==0 - scan all vendor IDs
		' if dwProductID==0 - scan all product IDs
		Dim dwDevices As Integer
		<VBFixedArray(WD_USB_MAX_DEVICE_NUMBER - 1)> Dim uniqueId() As Integer ' a unique id to identify the device
		<VBFixedArray(WD_USB_MAX_DEVICE_NUMBER - 1)> Dim deviceGeneralInfo() As WD_USB_DEVICE_GENERAL_INFO
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES enum definition.
		' WD_USBD_STATUS_SUCCESS for a successful configuration.
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim uniqueId(WD_USB_MAX_DEVICE_NUMBER - 1)
			ReDim deviceGeneralInfo(WD_USB_MAX_DEVICE_NUMBER - 1)
		End Sub
	End Structure
	
	' WD_USB_ERROR_CODES returned values:
	' The following statuses are returned by WinDriver:
	Public Const WD_STATUS_SUCCESS As Integer = &H0
	Public Const WD_STATUS_INVALID_WD_HANDLE As Integer = &HFFFFFFFF
	Public Const WD_WINDRIVER_STATUS_ERROR As Integer = &H20000000
	
	Public Const WD_INVALID_HANDLE As Integer = &H20000001
	Public Const WD_INVALID_PIPE_NUMBER As Integer = &H20000002
	Public Const WD_READ_WRITE_CONFLICT As Integer = &H20000003 ' request to read from an OUT (write) pipe or
	' request to write to an IN (read) pipe
	Public Const WD_ZERO_PACKET_SIZE As Integer = &H20000004 ' maximum packet size is zero
	Public Const WD_INSUFFICIENT_RESOURCES As Integer = &H20000005
	Public Const WD_UNKNOWN_PIPE_TYPE As Integer = &H20000006
	Public Const WD_SYSTEM_INTERNAL_ERROR As Integer = &H20000007
	Public Const WD_DATA_MISMATCH As Integer = &H20000008
	Public Const WD_NO_LICENSE As Integer = &H20000009
	Public Const WD_NOT_IMPLEMENTED As Integer = &H2000000A
	Public Const WD_KERPLUG_FAILURE As Integer = &H2000000B
	Public Const WD_FAILED_ENABLING_INTERRUPT As Integer = &H2000000C
	Public Const WD_INTERRUPT_NOT_ENABLED As Integer = &H2000000D
	Public Const WD_RESOURCE_OVERLAP As Integer = &H2000000E
	Public Const WD_DEVICE_NOT_FOUND As Integer = &H2000000F
	Public Const WD_WRONG_UNIQUE_ID As Integer = &H20000010
	Public Const WD_OPERATION_ALREADY_DONE As Integer = &H20000011
	Public Const WD_INTERFACE_DESCRIPTOR_ERROR As Integer = &H20000012
	Public Const WD_SET_CONFIGURATION_FAILED As Integer = &H20000013
	Public Const WD_CANT_OBTAIN_PDO As Integer = &H20000014
	Public Const WD_TIME_OUT_EXPIRED As Integer = &H20000015
	Public Const WD_IRP_CANCELED As Integer = &H20000016
	Public Const WD_FAILED_USER_MAPPING As Integer = &H20000017
	Public Const WD_FAILED_KERNEL_MAPPING As Integer = &H20000018
	Public Const WD_NO_RESOURCES_ON_DEVICE As Integer = &H20000019
	Public Const WD_NO_EVENTS As Integer = &H2000001A
	Public Const WD_INVALID_PARAMETER As Integer = &H2000001B
	Public Const WD_INCORRECT_VERSION As Integer = &H2000001C
	Public Const WD_TRY_AGAIN As Integer = &H2000001D
	Public Const WD_WINDRIVER_NOT_FOUND As Integer = &H2000001E
	
	' The following statuses are returned by USBD:
	' USBD status types:
	Public Const WD_USBD_STATUS_SUCCESS As Integer = &H0
	Public Const WD_USBD_STATUS_PENDING As Integer = &H40000000
	Public Const WD_USBD_STATUS_ERROR As Integer = &H80000000
	Public Const WD_USBD_STATUS_HALTED As Integer = &HC0000000
	
	' USBD status codes:
	' NOTE: The following status codes are comprised of one of the status types above and an
	' error code [i.e. XYYYYYYY - where: X = status type; YYYYYYY = error code].
	' The same error codes may also appear with one of the other status types as well.
	
	' HC (Host Controller) status codes.
	' [NOTE: These status codes use the WD_USBD_STATUS_HALTED status type]:
	Public Const WD_USBD_STATUS_CRC As Integer = &HC0000001
	Public Const WD_USBD_STATUS_BTSTUFF As Integer = &HC0000002
	Public Const WD_USBD_STATUS_DATA_TOGGLE_MISMATCH As Integer = &HC0000003
	Public Const WD_USBD_STATUS_STALL_PID As Integer = &HC0000004
	Public Const WD_USBD_STATUS_DEV_NOT_RESPONDING As Integer = &HC0000005
	Public Const WD_USBD_STATUS_PID_CHECK_FAILURE As Integer = &HC0000006
	Public Const WD_USBD_STATUS_UNEXPECTED_PID As Integer = &HC0000007
	Public Const WD_USBD_STATUS_DATA_OVERRUN As Integer = &HC0000008
	Public Const WD_USBD_STATUS_DATA_UNDERRUN As Integer = &HC0000009
	Public Const WD_USBD_STATUS_RESERVED1 As Integer = &HC000000A
	Public Const WD_USBD_STATUS_RESERVED2 As Integer = &HC000000B
	Public Const WD_USBD_STATUS_BUFFER_OVERRUN As Integer = &HC000000C
	Public Const WD_USBD_STATUS_BUFFER_UNDERRUN As Integer = &HC000000D
	Public Const WD_USBD_STATUS_NOT_ACCESSED As Integer = &HC000000F
	Public Const WD_USBD_STATUS_FIFO As Integer = &HC0000010
	
	' Returned by HCD (Host Controller Driver) if a transfer is submitted to an endpoint that is
	' stalled:
	Public Const WD_USBD_STATUS_ENDPOINT_HALTED As Integer = &HC0000030
	
	' Software status codes
	' [NOTE: The following status codes have only the error bit set]:
	Public Const WD_USBD_STATUS_NO_MEMORY As Integer = &H80000100
	Public Const WD_USBD_STATUS_INVALID_URB_FUNCTION As Integer = &H80000200
	Public Const WD_USBD_STATUS_INVALID_PARAMETER As Integer = &H80000300
	
	' Returned if client driver attempts to close an endpoint/interface
	' or configuration with outstanding transfers:
	Public Const WD_USBD_STATUS_ERROR_BUSY As Integer = &H80000400
	
	' Returned by USBD if it cannot complete a URB request. Typically this
	' will be returned in the URB status field when the Irp is completed
	' with a more specific NT error code. [The Irp statuses are indicated in
	' WinDriver's Monitor Debug Messages (wddebug_gui) tool]:
	Public Const WD_USBD_STATUS_REQUEST_FAILED As Integer = &H80000500
	
	Public Const WD_USBD_STATUS_INVALID_PIPE_HANDLE As Integer = &H80000600
	
	' Returned when there is not enough bandwidth available
	' to open a requested endpoint:
	Public Const WD_USBD_STATUS_NO_BANDWIDTH As Integer = &H80000700
	
	' Generic HC (Host Controller) error:
	Public Const WD_USBD_STATUS_INTERNAL_HC_ERROR As Integer = &H80000800
	
	' Returned when a short packet terminates the transfer
	' i.e. USBD_SHORT_TRANSFER_OK bit not set:
	Public Const WD_USBD_STATUS_ERROR_SHORT_TRANSFER As Integer = &H80000900
	
	' Returned if the requested start frame is not within
	' USBD_ISO_START_FRAME_RANGE of the current USB frame,
	' NOTE: that the stall bit is set:
	Public Const WD_USBD_STATUS_BAD_START_FRAME As Integer = &HC0000A00
	
	' Returned by HCD (Host Controller Driver) if all packets in an iso transfer complete with
	' an error:
	Public Const WD_USBD_STATUS_ISOCH_REQUEST_FAILED As Integer = &HC0000B00
	
	' Returned by USBD if the frame length control for a given
	' HC (Host Controller) is already taken by another driver:
	Public Const WD_USBD_STATUS_FRAME_CONTROL_OWNED As Integer = &HC0000C00
	
	' Returned by USBD if the caller does not own frame length control and
	' attempts to release or modify the HC frame length:
	Public Const WD_USBD_STATUS_FRAME_CONTROL_NOT_OWNED As Integer = &HC0000D00
	
	' USB TRANSFER options
	Public Const USB_TRANSFER_HALT As Integer = 1
	Public Const USB_SHORT_TRANSFER As Integer = 2
	Public Const USB_FULL_TRANSFER As Integer = 4
	Public Const USB_ISOCH_ASAP As Integer = &H8
	Public Const USB_ISOCH_NOASAP As Integer = &H80
	Public Const USB_ISOCH_FULL_PACKETS_ONLY As Integer = &H20
	Public Const USB_ISOCH_RESET As Integer = &H10
	
	Structure WD_USB_TRANSFER
		Dim hDevice As Integer ' handle of USB device to read from or write to
		Dim dwPipe As Integer ' pipe number on device
		Dim fRead As Integer
		Dim dwOptions As Integer ' USB_TRANSFER options:
		'   USB_TRANSFER_HALT - halts the pervious transfer.
		'   USB_SHORT_TRANSFER - the transfer will be completed if
		'     the device sent a short packet of data.
		'   USB_FULL_TRANSFER - the transfer will normally be completed
		'     if all the requested data was transferred.
		Dim pBuffer As Integer ' pointer to buffer to read/write
		Dim dwBytes As Integer
		Dim dwTimeout As Integer ' timeout for the transfer in milliseconds. 0==>no timeout.
		Dim dwBytesTransfered As Integer ' returns the number of bytes actually read/written
		<VBFixedArray(8 - 1)> Dim SetupPacket() As Byte ' setup packet for control pipe transfer
		Dim fOK As Integer ' transfer succeeded
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES enum
		' definition.  WD_USBD_STATUS_SUCCESS for a successful
		' configuration.
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim SetupPacket(8 - 1)
		End Sub
	End Structure
	
	Structure WD_USB_DEVICE_REGISTER
		Dim uniqueId As Integer ' the device unique ID
		Dim dwConfigurationIndex As Integer ' the index of the configuration to register
		Dim dwInterfaceNum As Integer ' interface to register
		Dim dwInterfaceAlternate As Integer
		Dim hDevice As Integer ' handle of device
		'UPGRADE_WARNING: Arrays in structure Device may need to be initialized before they can be used. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="814DF224-76BD-4BB4-BFFB-EA359CB9FC48"'
		Dim Device As WD_USB_DEVICE_INFO ' description of the device
		Dim dwOptions As Integer ' should be zero
		<VBFixedArray(32 - 1)> Dim cName() As Byte ' name of card
		<VBFixedArray(100 - 1)> Dim cDescription() As Byte ' description
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES
		' enum definition.  WD_USBD_STATUS_SUCCESS for a
		' successful configuration.
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			Device.Initialize()
			ReDim cName(32 - 1)
			ReDim cDescription(100 - 1)
		End Sub
	End Structure
	
	Structure WD_USB_RESET_PIPE
		Dim hDevice As Integer
		Dim dwPipe As Integer
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES enum
		' definition.  WD_USBD_STATUS_SUCCESS for a successful
		' configuration.
	End Structure
	
	Structure WD_USB_RESET_DEVICE
		Dim hDevice As Integer
		Dim dwOptions As Integer ' USB_RESET options:
		' WD_USB_HARD_RESET - will reset the device
		' even if it is not disabled.
		' After using this option it is advised to
		' un-register the device (WD_UsbDeviceUnregister())
		' and register it again - to make sure that the
		' device has all its resources.
		Dim dwStatus As Integer ' Configuration status code - see WD_USB_ERROR_CODES enum
		' definition.  WD_USBD_STATUS_SUCCESS for a successful
		' configuration.
	End Structure
	
	Public Const WD_INSERT As Integer = &H1
	Public Const WD_REMOVE As Integer = &H2
	Public Const WD_POWER_CHANGED_D0 As Integer = &H10 ' Power states for the power management.
	Public Const WD_POWER_CHANGED_D1 As Integer = &H20
	Public Const WD_POWER_CHANGED_D2 As Integer = &H40
	Public Const WD_POWER_CHANGED_D3 As Integer = &H80
	Public Const WD_POWER_SYSTEM_WORKING As Integer = &H100
	Public Const WD_POWER_SYSTEM_SLEEPING1 As Integer = &H200
	Public Const WD_POWER_SYSTEM_SLEEPING2 As Integer = &H400
	Public Const WD_POWER_SYSTEM_SLEEPING3 As Integer = &H800
	Public Const WD_POWER_SYSTEM_HIBERNATE As Integer = &H1000
	Public Const WD_POWER_SYSTEM_SHUTDOWN As Integer = &H2000
	
	Public Const WD_ACTIONS_POWER As Integer = &H3FF0
	Public Const WD_ACTIONS_ALL As Integer = &H3FF3
	
	Public Const WD_ACKNOWLEDGE As Integer = &H1
	Public Const WD_REENUM As Integer = &H2
	
	Structure WD_EVENT
		Dim handle As Integer
		Dim dwAction As Integer ' WD_EVENT_ACTION
		Dim dwStatus As Integer ' EVENT_STATUS
		Dim dwEventId As Integer
		Dim dwCardType As Integer 'WD_BUS_PCI or WD_BUS_USB
		Dim hKernelPlugIn As Integer
		Dim dwOptions As Integer ' WD_EVENT_OPTION
		Dim dwVendorID As Integer
		Dim dwProductID As Integer ' dwDeviceId for PCI cards
		' for PCI card
		' dw1 - dwBus
		' dw2 - dwSlot
		' dw3 - dwFunction
		' for USB device
		' dw1 - dwUniqueID
		Dim dw1 As Integer
		Dim dw2 As Integer
		Dim dw3 As Integer
		Dim dwEventVer As Integer
		Dim dwNumMatchTables As Integer
		<VBFixedArray(1)> Dim matchTables() As WDU_MATCH_TABLE
		
		'UPGRADE_TODO: "Initialize" must be called to initialize instances of this structure. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="B4BFF9E0-8631-45CF-910E-62AB3970F27B"'
		Public Sub Initialize()
			ReDim matchTables(1)
		End Sub
	End Structure
	
	Public Const WD_USB_HARD_RESET As Short = 1
	
	Private IOCTL_WD_USB_RESET_PIPE As Integer
	Private IOCTL_WD_USB_RESET_DEVICE As Integer
	Private IOCTL_WD_USB_RESET_DEVICE_EX As Integer
	Private IOCTL_WD_USB_SCAN_DEVICES As Integer
	Private IOCTL_WD_USB_SCAN_DEVICES_V432 As Integer
	Private IOCTL_WD_USB_TRANSFER As Integer
	Private IOCTL_WD_USB_DEVICE_REGISTER As Integer
	Private IOCTL_WD_USB_DEVICE_UNREGISTER As Integer
	Private IOCTL_WD_USB_GET_CONFIGURATION As Integer
	
	Dim WinDriverGlobalDW As Integer
	
	Public Const WD_TYPE As Integer = 38200
	Public Const FILE_ANY_ACCESS As Integer = 0
	Public Const METHOD_NEITHER As Integer = 3
	
	'    This is an implementation of a WinIOCTL macro (CTL_CODE)
	Function Get_Ctl_Code(ByRef Nr As Short) As Integer
		Dim lTMP As Integer
		Const lMaxLong As Integer = 2147483647
		lTMP = (WD_TYPE * 2 ^ 15) Or (FILE_ANY_ACCESS * 2 ^ 13) + ((Nr * 4) Or (METHOD_NEITHER)) \ 2
		Get_Ctl_Code = 0 - (lMaxLong - lTMP) * 2 - 1
	End Function ' Get_Ctl_Code
	
	Function WD_Open() As Integer
		Static WD_Initialized As Short
		
		If (WD_Initialized = 0) Then
			WD_Initialize()
			WD_Initialized = 1
		End If
		
		WD_Open = CreateFile("\\.\WINDRVR6", GENERIC_READ, FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0)
	End Function
	
	Sub WD_Close(ByVal hWD As Integer)
		CloseHandle(hWD)
	End Sub
	
	'UPGRADE_NOTE: WD_Debug was upgraded to WD_Debug_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Function WD_Debug_Renamed(ByVal hWD As Integer, ByRef Debug_parm As WD_Debug) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_Debug. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Debug_parm. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_DEBUG, Debug_parm, LenB(Debug_parm), WD_Debug, 4, WinDriverGlobalDW, 0)
	End Function ' WD_Debug
	
	Function WD_DebugDump(ByVal hWD As Integer, ByRef DebugDump As WD_DEBUG_DUMP) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_DebugDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object DebugDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_DEBUG_DUMP, DebugDump, LenB(DebugDump), WD_DebugDump, 4, WinDriverGlobalDW, 0)
	End Function ' WD_DebugDump
	
	'UPGRADE_NOTE: WD_Transfer was upgraded to WD_Transfer_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Function WD_Transfer_Renamed(ByVal hWD As Integer, ByRef Transfer As WD_Transfer) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_Transfer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Transfer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_TRANSFER, Transfer, LenB(Transfer), WD_Transfer, 4, WinDriverGlobalDW, 0)
	End Function ' WD_Transfer
	
	Function WD_MultiTransfer(ByVal hWD As Integer, ByRef TransferArray As WD_Transfer, ByVal dwNumTransfers As Short) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_MultiTransfer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object TransferArray. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_MULTI_TRANSFER, TransferArray, LenB(TransferArray) * dwNumTransfers, WD_MultiTransfer, 4, WinDriverGlobalDW, 0)
	End Function ' WD_MultiTransfer
	
	Function WD_DMALock(ByVal hWD As Integer, ByRef Dma As WD_DMA) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_DMALock. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Dma. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_DMA_LOCK, Dma, LenB(Dma), WD_DMALock, 4, WinDriverGlobalDW, 0)
	End Function ' WD_DMALock
	
	Function WD_DMAUnlock(ByVal hWD As Integer, ByRef Dma As WD_DMA) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_DMAUnlock. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Dma. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_DMA_UNLOCK, Dma, LenB(Dma), WD_DMAUnlock, 4, WinDriverGlobalDW, 0)
	End Function ' WD_DMAUnlock
	
	Function WD_IntEnable(ByVal hWD As Integer, ByRef TheInterrupt As WD_INTERRUPT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IntEnable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object TheInterrupt. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_INT_ENABLE, TheInterrupt, LenB(TheInterrupt), WD_IntEnable, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IntEnable
	
	Function WD_IntDisable(ByVal hWD As Integer, ByRef TheInterrupt As WD_INTERRUPT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IntDisable. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object TheInterrupt. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_INT_DISABLE, TheInterrupt, LenB(TheInterrupt), WD_IntDisable, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IntDisable
	
	Function WD_IntCount(ByVal hWD As Integer, ByRef TheInterrupt As WD_INTERRUPT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IntCount. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object TheInterrupt. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_INT_COUNT, TheInterrupt, LenB(TheInterrupt), WD_IntCount, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IntCount
	
	Function WD_IntWait(ByVal hWD As Integer, ByRef TheInterrupt As WD_INTERRUPT) As Object
		Dim h As Integer
		h = WD_Open()
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IntWait. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object TheInterrupt. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(h, IOCTL_WD_INT_WAIT, TheInterrupt, LenB(TheInterrupt), WD_IntWait, 4, WinDriverGlobalDW, 0)
		WD_Close(h)
	End Function ' WD_IntWait
	
	Function WD_IsapnpScanCards(ByVal hWD As Integer, ByRef IsapnpScanCards As WD_ISAPNP_SCAN_CARDS) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IsapnpScanCards. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object IsapnpScanCards. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_ISAPNP_SCAN_CARDS, IsapnpScanCards, LenB(IsapnpScanCards), WD_IsapnpScanCards, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IsapnpScanCards
	
	Function WD_IsapnpGetCardInfo(ByVal hWD As Integer, ByRef IsapnpGetCardInfo As WD_ISAPNP_CARD_INFO) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IsapnpGetCardInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object IsapnpGetCardInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_ISAPNP_GET_CARD_INFO, IsapnpGetCardInfo, LenB(IsapnpGetCardInfo), WD_IsapnpGetCardInfo, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IsapnpGetCardInfo
	
	Function WD_IsapnpConfigDump(ByVal hWD As Integer, ByRef IsapnpConfigDump As WD_ISAPNP_CONFIG_DUMP) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_IsapnpConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object IsapnpConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_ISAPNP_CONFIG_DUMP, IsapnpConfigDump, LenB(IsapnpConfigDump), WD_IsapnpConfigDump, 4, WinDriverGlobalDW, 0)
	End Function ' WD_IsapnpConfigDump
	
	Function WD_PcmciaScanCards(ByVal hWD As Integer, ByRef PcmciaScanCards As WD_PCMCIA_SCAN_CARDS) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PcmciaScanCards. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object PcmciaScanCards. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCMCIA_SCAN_CARDS, PcmciaScanCards, LenB(PcmciaScanCards), WD_PcmciaScanCards, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PcmciaScanCards
	
	Function WD_PcmciaGetCardInfo(ByVal hWD As Integer, ByRef PcmciaCardInfo As WD_PCMCIA_CARD_INFO) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PcmciaGetCardInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object PcmciaCardInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCMCIA_GET_CARD_INFO, PcmciaCardInfo, LenB(PcmciaCardInfo), WD_PcmciaGetCardInfo, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PcmciaGetCardInfo
	
	Function WD_PcmciaConfigDump(ByVal hWD As Integer, ByRef PcmciaConfigDump As WD_PCMCIA_CONFIG_DUMP) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PcmciaConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object PcmciaConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCMCIA_CONFIG_DUMP, PcmciaConfigDump, LenB(PcmciaConfigDump), WD_PcmciaConfigDump, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PcmciaConfigDump
	
	'UPGRADE_NOTE: WD_Sleep was upgraded to WD_Sleep_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Function WD_Sleep_Renamed(ByVal hWD As Integer, ByRef Sleep As WD_Sleep) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_Sleep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Sleep. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_SLEEP, Sleep, LenB(Sleep), WD_Sleep, 4, WinDriverGlobalDW, 0)
	End Function ' WD_Sleep
	
	Function WD_CardRegister(ByVal hWD As Integer, ByRef Card As WD_CARD_REGISTER) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_CardRegister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Card. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_CARD_REGISTER, Card, LenB(Card), WD_CardRegister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_CardRegister
	
	Function WD_CardUnregister(ByVal hWD As Integer, ByRef Card As WD_CARD_REGISTER) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_CardUnregister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Card. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_CARD_UNREGISTER, Card, LenB(Card), WD_CardUnregister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_CardUnregister
	
	Function WD_PciScanCards(ByVal hWD As Integer, ByRef pciScan As WD_PCI_SCAN_CARDS) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PciScanCards. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object pciScan. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCI_SCAN_CARDS, pciScan, LenB(pciScan), WD_PciScanCards, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PciScanCards
	
	Function WD_PciGetCardInfo(ByVal hWD As Integer, ByRef PciCard As WD_PCI_CARD_INFO) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PciGetCardInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object PciCard. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCI_GET_CARD_INFO, PciCard, LenB(PciCard), WD_PciGetCardInfo, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PciGetCardInfo
	
	'UPGRADE_NOTE: WD_Version was upgraded to WD_Version_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Function WD_Version_Renamed(ByVal hWD As Integer, ByRef VerInfo As WD_Version) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_Version. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object VerInfo. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_VERSION, VerInfo, LenB(VerInfo), WD_Version, 4, WinDriverGlobalDW, 0)
	End Function ' WD_Version
	
	'UPGRADE_NOTE: WD_License was upgraded to WD_License_Renamed. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="A9E4979A-37FA-4718-9994-97DD76ED70A7"'
	Function WD_License_Renamed(ByVal hWD As Integer, ByRef License As WD_License) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_License. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object License. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_LICENSE, License, LenB(License), WD_License, 4, WinDriverGlobalDW, 0)
	End Function ' WD_License
	
	Function WD_KernelPlugInOpen(ByVal hWD As Integer, ByRef KernelPlugInOpen As WD_KERNEL_PLUGIN) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_KernelPlugInOpen. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object KernelPlugInOpen. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_KERNEL_PLUGIN_OPEN, KernelPlugInOpen, LenB(KernelPlugInOpen), WD_KernelPlugInOpen, 4, WinDriverGlobalDW, 0)
	End Function ' WD_KernelPlugInOpen
	
	Function WD_KernelPlugInClose(ByVal hWD As Integer, ByRef KernelPlugInClose As WD_KERNEL_PLUGIN) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_KernelPlugInClose. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object KernelPlugInClose. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_KERNEL_PLUGIN_CLOSE, KernelPlugInClose, LenB(KernelPlugInClose), WD_KernelPlugInClose, 4, WinDriverGlobalDW, 0)
	End Function ' WD_KernelPlugInClose
	
	Function WD_KernelPlugInCall(ByVal hWD As Integer, ByRef KernelPlugInCall As WD_KERNEL_PLUGIN_CALL) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_KernelPlugInCall. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object KernelPlugInCall. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_KERNEL_PLUGIN_CALL, KernelPlugInCall, LenB(KernelPlugInCall), WD_KernelPlugInCall, 4, WinDriverGlobalDW, 0)
	End Function ' WD_KernelPlugInCall
	
	Function WD_PciConfigDump(ByVal hWD As Integer, ByRef PciConfigDump As WD_PCI_CONFIG_DUMP) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_PciConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object PciConfigDump. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_PCI_CONFIG_DUMP, PciConfigDump, LenB(PciConfigDump), WD_PciConfigDump, 4, WinDriverGlobalDW, 0)
	End Function ' WD_PciConfigDump
	
	Function WD_UsbScanDevice(ByVal hWD As Integer, ByRef Scan As WD_USB_SCAN_DEVICES) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbScanDevice. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Scan. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_SCAN_DEVICES, Scan, LenB(Scan), WD_UsbScanDevice, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbScanDevice
	
	Function WD_UsbGetConfiguration(ByVal hWD As Integer, ByRef Config As WD_USB_CONFIGURATION) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbGetConfiguration. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Config. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_GET_CONFIGURATION, Config, LenB(Config), WD_UsbGetConfiguration, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbGetConfiguration
	
	Function WD_UsbDeviceRegister(ByVal hWD As Integer, ByRef Dev As WD_USB_DEVICE_REGISTER) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbDeviceRegister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Dev. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_DEVICE_REGISTER, Dev, LenB(Dev), WD_UsbDeviceRegister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbDeviceRegister
	
	Function WD_UsbTransfer(ByVal hWD As Integer, ByRef Trans As WD_USB_TRANSFER) As Object
		Dim h As Integer
		h = WD_Open()
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbTransfer. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Trans. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(h, IOCTL_WD_USB_TRANSFER, Trans, LenB(Trans), WD_UsbTransfer, 4, WinDriverGlobalDW, 0)
		WD_Close(h)
	End Function ' WD_UsbTransfer
	
	Function WD_UsbDeviceUnregister(ByVal hWD As Integer, ByRef Dev As WD_USB_DEVICE_REGISTER) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbDeviceUnregister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object Dev. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_DEVICE_UNREGISTER, Dev, LenB(Dev), WD_UsbDeviceUnregister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbDeviceUnregister
	
	Function WD_UsbResetPipe(ByVal hWD As Integer, ByRef ResetPipe As WD_USB_RESET_PIPE) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbResetPipe. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object ResetPipe. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_RESET_PIPE, ResetPipe, LenB(ResetPipe), WD_UsbResetPipe, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbResetPipe
	
	Function WD_UsbResetDevice(ByVal hWD As Integer, ByVal hDev As Integer) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbResetDevice. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_RESET_DEVICE, hDev, LenB(hDev), WD_UsbResetDevice, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbResetDevice
	
	Function WD_UsbResetDeviceEx(ByVal hWD As Integer, ByRef ResetDevice As WD_USB_RESET_DEVICE) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_UsbResetDeviceEx. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object ResetDevice. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_USB_RESET_DEVICE_EX, ResetDevice, LenB(ResetDevice), WD_UsbResetDeviceEx, 4, WinDriverGlobalDW, 0)
	End Function ' WD_UsbResetDevice_Ex
	
	Function WD_EventRegister(ByVal hWD As Integer, ByRef wdEvent As WD_EVENT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_EventRegister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object wdEvent. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_EVENT_REGISTER, wdEvent, LenB(wdEvent), WD_EventRegister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_EventRegister
	
	Function WD_EventUnregister(ByVal hWD As Integer, ByRef wdEvent As WD_EVENT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_EventUnregister. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object wdEvent. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_EVENT_UNREGISTER, wdEvent, LenB(wdEvent), WD_EventUnregister, 4, WinDriverGlobalDW, 0)
	End Function ' WD_EventUnregister
	
	Function WD_EventPull(ByVal hWD As Integer, ByRef wdEvent As WD_EVENT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_EventPull. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object wdEvent. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_EVENT_PULL, wdEvent, LenB(wdEvent), WD_EventPull, 4, WinDriverGlobalDW, 0)
	End Function ' WD_EventPull
	
	Function WD_EventSend(ByVal hWD As Integer, ByRef wdEvent As WD_EVENT) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_EventSend. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object wdEvent. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_EVENT_SEND, wdEvent, LenB(wdEvent), WD_EventSend, 4, WinDriverGlobalDW, 0)
	End Function ' WD_EventSend
	
	Function WD_DebugAdd(ByVal hWD As Integer, ByRef dbg As WD_DEBUG_ADD) As Object
		'UPGRADE_WARNING: Couldn't resolve default property of object WD_DebugAdd. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		'UPGRADE_ISSUE: LenB function is not supported. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="367764E5-F3F8-4E43-AC3E-7FE0B5E074E2"'
		'UPGRADE_WARNING: Couldn't resolve default property of object dbg. Click for more: 'ms-help://MS.VSCC.v90/dv_commoner/local/redirect.htm?keyword="6A50421D-15FE-4896-8A1B-2EC21E9037B2"'
		DeviceIoControl(hWD, IOCTL_WD_DEBUG_ADD, dbg, LenB(dbg), WD_DebugAdd, 4, WinDriverGlobalDW, 0)
	End Function ' WD_DebugAdd
	
	Sub WD_Initialize()
		
		IOCTL_WD_DMA_LOCK = Get_Ctl_Code(&H901)
		IOCTL_WD_DMA_UNLOCK = Get_Ctl_Code(&H902)
		IOCTL_WD_TRANSFER = Get_Ctl_Code(&H903)
		IOCTL_WD_MULTI_TRANSFER = Get_Ctl_Code(&H904)
		IOCTL_WD_PCI_SCAN_CARDS = Get_Ctl_Code(&H90E)
		IOCTL_WD_PCI_GET_CARD_INFO = Get_Ctl_Code(&H90F)
		IOCTL_WD_VERSION = Get_Ctl_Code(&H910)
		IOCTL_WD_PCI_CONFIG_DUMP = Get_Ctl_Code(&H91A)
		IOCTL_WD_KERNEL_PLUGIN_OPEN = Get_Ctl_Code(&H91B)
		IOCTL_WD_KERNEL_PLUGIN_CLOSE = Get_Ctl_Code(&H91C)
		IOCTL_WD_KERNEL_PLUGIN_CALL = Get_Ctl_Code(&H91D)
		IOCTL_WD_INT_ENABLE = Get_Ctl_Code(&H91E)
		IOCTL_WD_INT_DISABLE = Get_Ctl_Code(&H91F)
		IOCTL_WD_INT_COUNT = Get_Ctl_Code(&H920)
		IOCTL_WD_ISAPNP_SCAN_CARDS = Get_Ctl_Code(&H924)
		IOCTL_WD_ISAPNP_CONFIG_DUMP = Get_Ctl_Code(&H926)
		IOCTL_WD_SLEEP = Get_Ctl_Code(&H927)
		IOCTL_WD_DEBUG = Get_Ctl_Code(&H928)
		IOCTL_WD_DEBUG_DUMP = Get_Ctl_Code(&H929)
		IOCTL_WD_CARD_UNREGISTER = Get_Ctl_Code(&H92B)
		IOCTL_WD_ISAPNP_GET_CARD_INFO = Get_Ctl_Code(&H92D)
		IOCTL_WD_PCMCIA_SCAN_CARDS = Get_Ctl_Code(&H92F)
		IOCTL_WD_PCMCIA_GET_CARD_INFO = Get_Ctl_Code(&H930)
		IOCTL_WD_PCMCIA_CONFIG_DUMP = Get_Ctl_Code(&H931)
		IOCTL_WD_CARD_REGISTER = Get_Ctl_Code(&H99C)
		IOCTL_WD_INT_WAIT = Get_Ctl_Code(&H94B)
		IOCTL_WD_LICENSE = Get_Ctl_Code(&H952)
		IOCTL_WD_USB_RESET_PIPE = Get_Ctl_Code(&H971)
		IOCTL_WD_USB_RESET_DEVICE = Get_Ctl_Code(&H93F)
		IOCTL_WD_USB_SCAN_DEVICES = Get_Ctl_Code(&H969)
		IOCTL_WD_USB_TRANSFER = Get_Ctl_Code(&H967)
		IOCTL_WD_USB_DEVICE_REGISTER = Get_Ctl_Code(&H968)
		IOCTL_WD_USB_DEVICE_UNREGISTER = Get_Ctl_Code(&H970)
		IOCTL_WD_USB_GET_CONFIGURATION = Get_Ctl_Code(&H974)
		IOCTL_WD_USB_RESET_DEVICE_EX = Get_Ctl_Code(&H973)
		IOCTL_WD_EVENT_REGISTER = Get_Ctl_Code(&H99D)
		IOCTL_WD_EVENT_UNREGISTER = Get_Ctl_Code(&H962)
		IOCTL_WD_EVENT_PULL = Get_Ctl_Code(&H963)
		IOCTL_WD_EVENT_SEND = Get_Ctl_Code(&H97A)
		IOCTL_WD_DEBUG_ADD = Get_Ctl_Code(&H964)
		
	End Sub
End Module