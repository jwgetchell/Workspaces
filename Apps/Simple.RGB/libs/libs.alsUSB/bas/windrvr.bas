Attribute VB_Name = "windrvr"
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

Option Explicit
Global WD_Opened As Boolean
Global Const WD_VER = 700

Global Const WD_VER_STR = "WinDriver V7.00 Jungo (c) 1999 - 2005"
Global Const WD_VER_MODULE = WD_VER_STR

Global Const CMD_NONE = 0         ' No command
Global Const CMD_END = 1          ' End command

Global Const RP_BYTE = 10         ' Read port byte
Global Const RP_WORD = 11         ' Read port word
Global Const RP_DWORD = 12        ' Read port dword
Global Const WP_BYTE = 13         ' Write port byte
Global Const WP_WORD = 14         ' Write port word
Global Const WP_DWORD = 15        ' Write port dword
Global Const RP_QWORD = 16        ' Read port qword
Global Const WP_QWORD = 17        ' Write port qword

Global Const RP_SBYTE = 20        ' Read port string byte
Global Const RP_SWORD = 21        ' Read port string word
Global Const RP_SDWORD = 22       ' Read port string dword
Global Const WP_SBYTE = 23        ' Write port string byte
Global Const WP_SWORD = 24        ' Write port string word
Global Const WP_SDWORD = 25       ' Write port string dword

Global Const RM_BYTE = 30         ' Read memory byte
Global Const RM_WORD = 31         ' Read memory word
Global Const RM_DWORD = 32        ' Read memory dword
Global Const WM_BYTE = 33         ' Write memory byte
Global Const WM_WORD = 34         ' Write memory word
Global Const WM_DWORD = 35        ' Write memory dword
Global Const RM_QWORD = 36        ' Read memory qword
Global Const WM_QWORD = 37        ' Write memory qword

Global Const RM_SBYTE = 40        ' Read memory string byte
Global Const RM_SWORD = 41        ' Read memory string word
Global Const RM_SDWORD = 42       ' Read memory string dword
Global Const WM_SBYTE = 43        ' Write memory string byte
Global Const WM_SWORD = 44        ' Write memory string word
Global Const WM_SDWORD = 45       ' Write memory string dword
Global Const RM_SQWORD = 46       ' Read memory string quad word
Global Const WM_SQWORD = 47       ' Write memory string quad word

Global Const WM_APP As Long = &H8000&    ' Platform SDK constant

Global Const WD_DMA_PAGES = 256

Global Const DMA_KERNEL_BUFFER_ALLOC = 1 ' the system allocates a contiguous buffer
                                         ' the user does not need to supply linear_address
Global Const DMA_KBUF_BELOW_16M = 2      ' if DMA_KERNEL_BUFFER_ALLOC if used,
                                         ' this will make sure it is under 16M
Global Const DMA_LARGE_BUFFER = 4        ' if DMA_LARGE_BUFFER if used,
                                 ' the maximum number of pages are dwPages, and not
                                 ' WD_DMA_PAGES. if you lock a user buffer (not a kernel
                                 ' allocated buffer) that is larger than 1MB, then use this
                                 ' option, and allocate memory for pages.


Type PVOID
    ptr As Long
End Type



Type WD_DMA_PAGE
    pPhysicalAddr As PVOID        ' physical address of page
    dwBytes       As Long        ' size of page
End Type


Type WD_DMA
    hDMA       As Long      ' handle of DMA buffer
    pUserAddr  As PVOID     ' beginning of buffer
    pKernelAddr As Long     ' Kernel mapping of kernel allocated buffer
    dwBytes    As Long      ' size of buffer
    dwOptions  As Long      ' allocation options
    dwPages    As Long      ' number of pages in buffer
    dwPad1     As Long      ' Reserved for internal use
    Page(0 To WD_DMA_PAGES - 1) As WD_DMA_PAGE
End Type

Type WD_Transfer
    dwPort      As Long  ' IO port for transfer or user memory address
    cmdTrans    As Long  ' Transfer command WD_TRANSFER_CMD
    dwBytes     As Long  ' For string transfer
    fAutoInc    As Long  ' Transfer from one port/address or
                         ' use incremental range of addresses
    dwOptions   As Long  ' Must be 0
    dwPad1 As Long       ' Padding for internal uses
    dwLowDataTransfer As Long
    dwHighDataTransfer As Long 'Must be zero for data size smaller then 64 bits
End Type

Type PWD_TRANSFER    ' pointer to WD_TRANSFER
    cmd As Long
End Type

Public Type WDU_INTERFACE_DESCRIPTOR
    bLength As Byte
    bDescriptorType As Byte
    bInterfaceNumber As Byte
    bAlternateSetting As Byte
    bNumEndpoints As Byte
    bInterfaceClass As Byte
    bInterfaceSubClass As Byte
    bInterfaceProtocol As Byte
    iInterface As Byte
End Type

Public Type WDU_ENDPOINT_DESCRIPTOR
    bLength As Byte
    bDescriptorType As Byte
    bEndpointAddress As Byte
    bmAttributes As Byte
    wMaxPacketSize As Integer
    bInterval As Byte
End Type

Public Type WDU_CONFIGURATION_DESCRIPTOR
    bLength As Byte
    bDescriptorType As Byte
    wTotalLength As Integer
    bNumInterfaces As Byte
    bConfigurationValue As Byte
    iConfiguration As Byte
    bmAttributes As Byte
    MaxPower As Byte
End Type

Public Type WDU_DEVICE_DESCRIPTOR
    bLength As Byte
    bDescriptorType As Byte
    bcdUSB As Integer
    bDeviceClass As Byte
    bDeviceSubClass As Byte
    bDeviceProtocol As Byte
    bMaxPacketSize0 As Byte
    idVendor As Integer
    idProduct As Integer
    bcdDevice As Integer
    iManufacturer As Byte
    iProduct As Byte
    iSerialNumber As Byte
    bNumConfigurations As Byte
End Type

Public Type WDU_PIPE_INFO
    dwNumber As Long
    dwMaximumPacketSize As Long
    type As Long
    direction As Long
    dwInterval As Long
End Type

Public Type WDU_ALTERNATE_SETTING
    Descriptor As WDU_INTERFACE_DESCRIPTOR
    pEndpointDescriptors As Long
    pPipes As Long
End Type

Public Type WDU_INTERFACE
    pAlternateSettings As Long
    dwNumAltSettings As Long
    pActiveAltSetting As Long
End Type

Public Type WDU_CONFIGURATION
    Descriptor As WDU_CONFIGURATION_DESCRIPTOR
    dwNumInterfaces As Long
    pInterfaces As Long
End Type

Public Type WDU_DEVICE
    Descriptor As WDU_DEVICE_DESCRIPTOR
    Pipe0 As WDU_PIPE_INFO
    pConfigs As Long
    pActiveConfig As Long
    pActiveInterface As Long
End Type

Public Type WDU_MATCH_TABLE
    wVendorId As Integer
    wProductId As Integer
    bDeviceClass As Byte
    bDeviceSubClass As Byte
    bInterfaceClass As Byte
    bInterfaceSubClass As Byte
    bInterfaceProtocol As Byte
End Type

Public Type WDU_EVENT_TABLE
    pfDeviceAttach As Long
    pfDeviceDetach As Long
    pfPowerChange As Long
    pUserData As Long
End Type

Public Type WDU_GET_DEVICE_DATA
    dwUniqueID As Long
    pBuf As Long
    dwBytes As Long
    dwOptions As Long
End Type

Public Type WDU_SET_INTERFACE
    dwUniqueID As Long
    dwInterfaceNum As Long
    dwAlternateSetting As Long
    dwOptions As Long
End Type

Public Type WDU_RESET_PIPE
    dwUniqueID As Long
    dwPipeNum As Long
    dwOptions As Long
End Type

Global Const WDU_WAKEUP_ENABLE = &H1
Global Const WDU_WAKEUP_DISABLE = &H2

Public Type WDU_HALT_TRANSFER
    dwUniqueID As Long
    dwPipeNum As Long
    dwOptions As Long
End Type

Public Type WDU_GET_DESCRIPTOR
    dwUniqueID As Long
    bType As Byte
    bIndex As Byte
    wLength As Integer
    pBuffer As Long
    wLanguage As Integer
End Type

Private IOCTL_WD_DMA_LOCK As Long
Private IOCTL_WD_DMA_UNLOCK As Long
Private IOCTL_WD_TRANSFER As Long
Private IOCTL_WD_MULTI_TRANSFER As Long
Private IOCTL_WD_PCI_SCAN_CARDS As Long
Private IOCTL_WD_PCI_GET_CARD_INFO As Long
Private IOCTL_WD_VERSION As Long
Private IOCTL_WD_LICENSE As Long
Private IOCTL_WD_PCI_CONFIG_DUMP As Long
Private IOCTL_WD_KERNEL_PLUGIN_OPEN As Long
Private IOCTL_WD_KERNEL_PLUGIN_CLOSE As Long
Private IOCTL_WD_KERNEL_PLUGIN_CALL As Long
Private IOCTL_WD_INT_ENABLE As Long
Private IOCTL_WD_INT_DISABLE As Long
Private IOCTL_WD_INT_COUNT As Long
Private IOCTL_WD_INT_WAIT As Long
Private IOCTL_WD_ISAPNP_SCAN_CARDS As Long
Private IOCTL_WD_ISAPNP_GET_CARD_INFO As Long
Private IOCTL_WD_ISAPNP_CONFIG_DUMP As Long
Private IOCTL_WD_PCMCIA_SCAN_CARDS As Long
Private IOCTL_WD_PCMCIA_GET_CARD_INFO As Long
Private IOCTL_WD_PCMCIA_CONFIG_DUMP As Long
Private IOCTL_WD_SLEEP As Long
Private IOCTL_WD_DEBUG As Long
Private IOCTL_WD_DEBUG_DUMP As Long
Private IOCTL_WD_CARD_UNREGISTER As Long
Private IOCTL_WD_CARD_REGISTER As Long
Private IOCTL_WD_EVENT_REGISTER As Long
Private IOCTL_WD_EVENT_UNREGISTER As Long
Private IOCTL_WD_EVENT_PULL As Long
Private IOCTL_WD_EVENT_SEND As Long
Private IOCTL_WD_DEBUG_ADD As Long


Global Const INTERRUPT_LEVEL_SENSITIVE = 1
Global Const INTERRUPT_CMD_COPY = 2

Type WD_KERNEL_PLUGIN_CALL
    hKernelPlugIn As Long
    dwMessage     As Long
    pData         As PVOID
    dwResult      As Long
End Type

Type WD_INTERRUPT
    hInterrupt As Long ' handle of interrupt
    dwOptions  As Long ' interrupt options as INTERRUPT_CMD_COPY
    cmd        As PWD_TRANSFER ' commands to do on interrupt
    dwCmds     As Long         ' number of commands for WD_IntEnable()
    kpCall    As WD_KERNEL_PLUGIN_CALL ' kernel plugin call
    fEnableOk As Long     ' did WD_IntEnable() succeed
                          ' For WD_IntWait() and WD_IntCount()
    dwCounter As Long ' number of interrupts received
    dwLost    As Long ' number of interrupts not yet dealt with
    fStopped  As Long ' was interrupt disabled during wait
End Type

Type WD_Version
    dwVer As Long
    cVer As String * 128
End Type

Global Const LICENSE_DEMO As Long = &H1
Global Const LICENSE_WD   As Long = &H4
Global Const LICENSE_KD   As Long = &H400000
Global Const LICENSE_IO   As Long = &H8
Global Const LICENSE_MEM  As Long = &H10
Global Const LICENSE_INT  As Long = &H20
Global Const LICENSE_PCI  As Long = &H40
Global Const LICENSE_DMA  As Long = &H80
Global Const LICENSE_NT   As Long = &H100
Global Const LICENSE_95   As Long = &H200
Global Const LICENSE_ISAPNP   As Long = &H400
Global Const LICENSE_PCMCIA   As Long = &H800
Global Const LICENSE_PCI_DUMP As Long = &H1000
Global Const LICENSE_MSG_GEN  As Long = &H2000
Global Const LICENSE_MSG_EDU  As Long = &H4000
Global Const LICENSE_MSG_INT  As Long = &H8000&
Global Const LICENSE_KER_PLUG As Long = &H10000
Global Const LICENSE_LINUX As Long = &H20000
Global Const LICENSE_CE    As Long = &H80000
Global Const LICENSE_VXWORKS As Long = &H10000000
Global Const LICENSE_THIS_PC As Long = &H100000
Global Const LICENSE_WIZARD  As Long = &H200000
Global Const LICENSE_SOLARIS As Long = &H800000
Global Const LICENSE_CPU0 As Long = &H40000
Global Const LICENSE_CPU1 As Long = &H1000000
Global Const LICENSE_CPU2 As Long = &H2000000
Global Const LICENSE_CPU3 As Long = &H4000000
Global Const LICENSE_USB  As Long = &H8000000

Global Const LICENSE2_EVENT As Long = &H8
Global Const LICENSE2_WDLIB As Long = &H10
Global Const LICENSE2_WDF As Long = &H20

Type WD_License
    cLicense As String * 128 ' Buffer with license string to register.
                       ' If valid license, it's setting information will
                       ' be returned by WD_License() in dwLicense/dwLicense2.
                       ' If empty string, WD_License() will return
                       ' the information for WinDriver license(s) currently
                       ' registered in the system.
    dwLicense  As Long ' License settings returned from WD_License():
                       ' LICENSE_DEMO, LICENSE_WD etc... (or 0 for
                       ' invalid license).
    dwLicense2 As Long ' If dwLicense cannot hold all the information, then
                       ' the additional info will be returned in dwLicense2.
End Type

Type WD_BUS
    dwBusType  As Long      ' Bus Type: ISA, EISA, PCI, PCMCIA
    dwBusNum   As Long      ' Bus number
    dwSlotFunc As Long      ' Slot number on Bus
End Type

Global Const WD_BUS_ISA = 1
Global Const WD_BUS_EISA = 2
Global Const WD_BUS_PCI = 5
Global Const WD_BUS_PCMCIA = 8

Global Const ITEM_NONE = 0
Global Const ITEM_INTERRUPT = 1
Global Const ITEM_MEMORY = 2
Global Const ITEM_IO = 3
Global Const ITEM_BUS = 5

Global Const WD_ITEM_DO_NOT_MAP_KERNEL = 1

Type WD_ITEMS
    Item         As Long ' ITEM_TYPE
    fNotSharable As Long
    dwContext As Long ' Reserved for internal use
    dwOptions As Long    ' can be WD_ITEM_DO_NOT_MAP_KERNEL
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
    dw1 As Long
    dw2 As Long
    dw3 As Long
    dw4 As Long
    dw5 As Long
    dw6 As Long
End Type

Global Const WD_CARD_ITEMS = 20

Type WD_CARD
    dwItems As Long
    Item(0 To WD_CARD_ITEMS - 1) As WD_ITEMS
End Type

Type WD_CARD_REGISTER
    Card           As WD_CARD ' card to register
    fCheckLockOnly As Long    ' only check if card is lockable, return hCard=1 if OK
    hCard          As Long    ' handle of card
    dwOptions      As Long    ' should be zero
    cName(0 To 31)      As Byte        ' name of card
    cDescription(0 To 100 - 1) As Byte ' description
End Type

Global Const WD_PCI_CARDS = 100

Type WD_PCI_SLOT
    dwBus  As Long
    dwSlot As Long
    dwFunction As Long
End Type

Type WD_PCI_ID
    dwVendorID As Long
    dwDeviceID As Long
End Type

Type WD_PCI_SCAN_CARDS
    searchId As WD_PCI_ID ' if dwVendorId = 0, scan all
                          ' vendor Ids
                          ' if dwDeviceId = 0, scan all
                          ' device Ids
    dwCards  As Long   ' Number of cards found
    cardId(0 To WD_PCI_CARDS - 1) As WD_PCI_ID
                     ' VendorID & DeviceID of cards found
    cardSlot(0 To WD_PCI_CARDS - 1) As WD_PCI_SLOT
                     ' PCI slot info of cards found
End Type

Type WD_PCI_CARD_INFO
    pciSlot As WD_PCI_SLOT ' PCI slot
    Card    As WD_CARD     ' Get card parameters for PCI slot
End Type

Global Const PCI_ACCESS_OK = 0
Global Const PCI_ACCESS_ERROR = 1
Global Const PCI_BAD_BUS = 2
Global Const PCI_BAD_SLOT = 3

Type WD_PCI_CONFIG_DUMP
    pciSlot  As WD_PCI_SLOT ' PCI bus, slot and function number
    pBuffer  As PVOID       ' buffer for read/write
    dwOffset As Long        ' offset in pci configuration space
                            ' to read/write from
    dwBytes  As Long       ' bytes to read/write from/to buffer
                                ' returns the # of bytes read/written
    fIsRead  As Long       ' if 1 then read pci config, 0 write pci config
    dwResult As Long       ' PCI_ACCESS_RESULT
End Type

Global Const WD_ISAPNP_CARDS = 16
Global Const WD_ISAPNP_COMPATIBLE_IDS = 10
Global Const WD_ISAPNP_COMP_ID_LENGTH = 7  ' ISA compressed ID is 7 chars long
Global Const WD_ISAPNP_ANSI_LENGTH = 32    ' ISA ANSI ID is limited to 32 chars long


Type WD_ISAPNP_COMP_ID
    compID(0 To WD_ISAPNP_COMP_ID_LENGTH) As Byte
End Type
Type WD_ISAPNP_ANSI
    ansi(0 To WD_ISAPNP_ANSI_LENGTH + 3) As Byte ' add 3 bytes for DWORD alignment
End Type



Type WD_ISAPNP_CARD_ID
    cVendor  As WD_ISAPNP_COMP_ID ' Vendor ID
    dwSerial As Long ' Serial number of card
End Type


Type WD_ISAPNP_CARD
    cardId As WD_ISAPNP_CARD_ID ' VendorID & serial number of cards found
    dcLogicalDevices As Long   ' Logical devices on the card
    bPnPVersionMajor As Byte    ' ISA PnP version Major
    bPnPVersionMinor As Byte    ' ISA PnP version Minor
    bVendorVersionMajor As Byte ' Vendor version Major
    bVendorVersionMinor As Byte ' Vendor version Minor
    cIdent As WD_ISAPNP_ANSI    ' Device identifier
End Type

Type WD_ISAPNP_SCAN_CARDS
    searchId As WD_ISAPNP_CARD_ID ' if searchId.cVendor[0]==0 - scan all vendor IDs
                                      ' if searchId.dwSerial==0 - scan all serial numbers
    dwCards As Long  ' number of cards found
    Card(0 To WD_ISAPNP_CARDS - 1) As WD_ISAPNP_CARD ' cards found
End Type


Type WD_ISAPNP_CARD_INFO
    cardId   As WD_ISAPNP_CARD_ID  ' VendorID and serial number of card
    dwLogicalDevice     As Long   ' logical device in card
    cLogicalDeviceId    As WD_ISAPNP_COMP_ID  ' logical device ID
    dwCompatibleDevices As Long   ' number of compatible device IDs
    CompatibleDevice(0 To WD_ISAPNP_COMPATIBLE_IDS - 1) As WD_ISAPNP_COMP_ID ' Compatible device IDs
    cIdent As WD_ISAPNP_ANSI  ' Device identifier
    Card As WD_CARD  ' get card parameters for the ISA PnP card
End Type

Global Const ISAPNP_ACCESS_OK = 0
Global Const ISAPNP_ACCESS_ERROR = 1
Global Const ISAPNP_BAD_ID = 2

Type WD_ISAPNP_CONFIG_DUMP
    cardId   As WD_ISAPNP_CARD_ID  ' VendorID and serial number of card
    dwOffset As Long   ' offset in ISA PnP configuration space to read/write from
    fIsRead  As Long   ' if 1 then read ISA PnP config, 0 write ISA PnP config
    bData    As Byte    ' result data of byte read/write
    dwResult As Long ' ISAPNP_ACCESS_RESULT
End Type

Global Const WD_PCMCIA_CARDS = 8
Global Const WD_PCMCIA_VERSION_LEN = 4
Global Const WD_PCMCIA_MANUFACTURER_LEN = 48
Global Const WD_PCMCIA_PRODUCTNAME_LEN = 48
Global Const WD_PCMCIA_MAX_SOCKET = 2
Global Const WD_PCMCIA_MAX_FUNCTION = 2


Type WD_PCMCIA_SLOT
    uSocket    As Byte  ' Specifies the socket number (first socket is 0)
    uFunction  As Byte  ' Specifies the function number (first function is 0)
    uPadding0  As Byte  ' 2 bytes padding so structure will be 4 bytes aligned
    uPadding1  As Byte
End Type

Type WD_PCMCIA_ID
    dwManufacturerId As Long ' card manufacturer
    dwCardId         As Long ' card type and model
End Type

Type WD_PCMCIA_SCAN_CARDS
    searchId As WD_PCMCIA_ID                              ' device ID to search for
    dwCards As Long                                       ' number of cards found
    cardId(0 To WD_PCMCIA_CARDS - 1) As WD_PCMCIA_ID      ' device IDs of cards found
    cardSlot(0 To WD_PCMCIA_CARDS - 1) As WD_PCMCIA_SLOT  ' pcmcia slot info of cards found
End Type

Type WD_PCMCIA_CARD_INFO
    pcmciaSlot As WD_PCMCIA_SLOT  ' pcmcia slot
    Card As WD_CARD               ' get card parameters for pcmcia slot
    cVersion(0 To WD_PCMCIA_VERSION_LEN - 1) As Byte
    cManufacturer(0 To WD_PCMCIA_MANUFACTURER_LEN - 1) As Byte
    cProductName(0 To WD_PCMCIA_PRODUCTNAME_LEN - 1) As Byte
    dwManufacturerId As Long      ' card manufacturer
    dwCardId As Long              ' card type and model
    dwFuncId As Long              ' card function code
End Type

Type WD_PCMCIA_CONFIG_DUMP
    pcmciaSlot As WD_PCMCIA_SLOT
    pBuffer    As PVOID     ' buffer for read/write
    dwOffset   As Long      ' offset in pcmcia configuration space to
                            ' read/write from
    dwBytes    As Long      ' bytes to read/write from/to buffer
                            ' returns the number of bytes read/wrote
    fIsRead    As Long      ' if 1 then read pci config, 0 write pci config
    dwResult   As Long      ' PCMCIA_ACCESS_RESULT
End Type

Global Const SLEEP_NON_BUSY = 1

Type WD_Sleep
    dwMicroSeconds As Long ' Sleep time in Micro Seconds (1/1,000,000 Second)
    dwOptions      As Long ' can be:
                           ' SLEEP_NON_BUSY this is accurate only for times above 10000 uSec
End Type

Global Const D_OFF = 0
Global Const D_ERROR = 1
Global Const D_WARN = 2
Global Const D_INFO = 3
Global Const D_TRACE = 4

Global Const S_ALL As Long = &HFFFFFFFF
Global Const S_IO As Long = &H8
Global Const S_MEM As Long = &H10
Global Const S_INT As Long = &H20
Global Const S_PCI As Long = &H40
Global Const S_DMA As Long = &H80
Global Const S_MISC As Long = &H100
Global Const S_LICENSE As Long = &H200
Global Const S_ISAPNP As Long = &H400
Global Const S_PCMCIA As Long = &H800
Global Const S_KER_PLUG As Long = &H10000
Global Const S_CARD_REG As Long = &H2000

Global Const DEBUG_STATUS = 1
Global Const DEBUG_SET_FILTER = 2
Global Const DEBUG_SET_BUFFER = 3
Global Const DEBUG_CLEAR_BUFFER = 4
Global Const DEBUG_DUMP_SEC_ON = 5
Global Const DEBUG_DUMP_SEC_OFF = 6
Global Const KERNEL_DEBUGGER_ON = 7
Global Const KERNEL_DEBUGGER_OFF = 8

'from win32API
Declare Function CreateFile Lib "kernel32" Alias "CreateFileA" (ByVal lpFileName As String, ByVal dwDesiredAccess As Long, ByVal dwShareMode As Long, ByVal lpSecurityAttributes As Long, ByVal dwCreationDisposition As Long, ByVal dwFlagsAndAttributes As Long, ByVal hTemplateFile As Long) As Long
Declare Function CloseHandle Lib "kernel32" (ByVal hObject As Long) As Long
Declare Function DeviceIoControl Lib "kernel32" ( _
    ByVal hDevice As Long, _
    ByVal dwIoControlCode As Long, _
          lpInBuffer As Any, _
    ByVal nInBufferSize As Long, _
          lpOutBuffer As Long, _
    ByVal nOutBufferSize As Long, _
          lpBytesReturned As Long, _
    ByVal lpOverlapped As Long) As Long
'Declare Sub MemCpy Lib "kernel32" Alias "RtlMoveMemory" _
'         (ByVal hpvDest As Long, ByVal hpvSource As Any, ByVal cbCopy As Long)
Private Const GENERIC_READ = &H80000000
Private Const FILE_SHARE_READ = &H1
Private Const FILE_SHARE_WRITE = &H2
Private Const OPEN_EXISTING = 3
Private Const FILE_FLAG_OVERLAPPED = &H40000000
Global Const INVALID_HANDLE_VALUE = -1

'call this function with the variable of which you need the pointer and the last two params pass 1
'address = WD_VB_GetAddress (Variable, 1, 1) 'this extracts the address of Variable
Declare Function WD_VB_GetAddress Lib "kernel32" Alias "MulDiv" (ByRef dwNum As Any, ByVal one As Long, ByVal one_ As Long) As Long

Type WD_Debug
    dwCmd As Long          ' DEBUG_COMMAND as DEBUG_STATUS, DEBUG_SET_FILTER, DEBUG_SET_BUFFER, DEBUG_CLEAR_BUFFER
                           ' used for DEBUG_SET_FILTER
    dwLevel As Long        ' DEBUG_LEVEL as D_ERROR, D_WARN..., or D_OFF to turn debugging off
    dwSection As Long      ' DEBUG_SECTION as for all sections in driver as S_ALL
                           ' for partial sections as S_IO, S_MEM...
    dwLevelMessageBox As Long  ' DEBUG_LEVEL to print in a message box
                               ' used for DEBUG_SET_BUFFER
    dwBufferSize As Long   ' size of buffer in kernel
End Type

Type PChar
    charPtr As Long
End Type

Type WD_DEBUG_DUMP
    pcBuffer As PChar ' buffer to receive debug messages
    dwSize As Long    ' size of buffer in bytes
End Type

Type WD_DEBUG_ADD
    pcBuffer(0 To 256 - 1) As Byte
    dwLevel As Long
    dwSection As Long
End Type

Type WD_KERNEL_PLUGIN
    hKernelPlugIn As Long
    pcDriverName As PChar
    pcDriverPath As PChar ' if NULL the driver will be searched in the windows system directory
    pOpenData As PVOID
End Type

Global Const PIPE_TYPE_CONTROL = 0
Global Const PIPE_TYPE_ISOCHRONOUS = 1
Global Const PIPE_TYPE_BULK = 2
Global Const PIPE_TYPE_INTERRUPT = 3

Global Const WD_USB_MAX_PIPE_NUMBER = 32
Global Const WD_USB_MAX_ENDPOINTS = 32
Global Const WD_USB_MAX_INTERFACES = 30
Global Const WD_USB_MAX_DEVICE_NUMBER = 30

Global Const WDU_DIR_IN = 1
Global Const WDU_DIR_OUT = 2
Global Const WDU_DIR_IN_OUT = 3

Type WD_USB_ID
    dwVendorID  As Long
    dwProductID As Long
End Type

Type WD_USB_PIPE_INFO
    dwNumber As Long        ' Pipe 0 is the default pipe
    dwMaximumPacketSize As Long
    type As Long            ' USB_PIPE_TYPE
    direction As Long       ' WDU_DIR
                            ' Isochronous, Bulk, Interrupt are either WDU_DIR_IN or WDU_DIR_OUT
                            ' Control are WDU_DIR_IN_OUT
    dwInterval As Long      ' interval in ms relevant to Interrupt pipes
End Type

Type WD_USB_CONFIG_DESC
    dwNumInterfaces As Long
    dwValue         As Long
    dwAttributes    As Long
    MaxPower        As Long
End Type

Type WD_USB_INTERFACE_DESC
    dwNumber           As Long
    dwAlternateSetting As Long
    dwNumEndpoints     As Long
    dwClass            As Long
    dwSubClass         As Long
    dwProtocol         As Long
    dwIndex            As Long
End Type

Type WD_USB_ENDPOINT_DESC
    dwEndpointAddress As Long
    dwAttributes      As Long
    dwMaxPacketSize   As Long
    dwInterval        As Long
End Type

Type WD_USB_INTERFACE
    Interface As WD_USB_INTERFACE_DESC
    Endpoints(0 To WD_USB_MAX_ENDPOINTS - 1) As WD_USB_ENDPOINT_DESC
End Type

Type WD_USB_CONFIGURATION
    uniqueId As Long
    dwConfigurationIndex As Long
    configuration As WD_USB_CONFIG_DESC
    dwInterfaceAlternatives As Long
    Interface(0 To WD_USB_MAX_INTERFACES - 1) As WD_USB_INTERFACE
    dwStatus As Long  ' Configuration status code - see WD_USB_ERROR_CODES enum definition.
                      ' WD_USBD_STATUS_SUCCESS for a successful configuration.
End Type

Type WD_USB_HUB_GENERAL_INFO
    fBusPowered          As Long
    dwPorts              As Long  ' number of ports on this hub
    dwCharacteristics    As Long  ' Hub Characteristics
    dwPowerOnToPowerGood As Long  ' port power on till power good in 2ms
    dwHubControlCurrent  As Long  ' max current in mA
End Type

Global Const WD_SINGLE_INTERFACE As Long = &HFFFFFFFF

Type WD_USB_DEVICE_GENERAL_INFO
    deviceId            As WD_USB_ID
    dwHubNum            As Long
    dwPortNum           As Long
    fHub                As Long
    fFullSpeed          As Long
    dwConfigurationsNum As Long
    deviceAddress       As Long
    hubInfo             As WD_USB_HUB_GENERAL_INFO
    deviceClass         As Long
    deviceSubClass      As Long
    dwInterfaceNum      As Long ' For a single device WinDriver sets this
                                ' value to WD_SINGLE_INTERFACE
End Type

Type WD_USB_DEVICE_INFO
    dwPipes As Long
    Pipe(0 To WD_USB_MAX_PIPE_NUMBER - 1) As WD_USB_PIPE_INFO
End Type

Type WD_USB_SCAN_DEVICES
    searchId  As WD_USB_ID ' if dwVendorID==0 - scan all vendor IDs
                           ' if dwProductID==0 - scan all product IDs
    dwDevices As Long
    uniqueId(0 To WD_USB_MAX_DEVICE_NUMBER - 1) As Long         ' a unique id to identify the device
    deviceGeneralInfo(0 To WD_USB_MAX_DEVICE_NUMBER - 1) As WD_USB_DEVICE_GENERAL_INFO
    dwStatus As Long  ' Configuration status code - see WD_USB_ERROR_CODES enum definition.
                      ' WD_USBD_STATUS_SUCCESS for a successful configuration.
End Type

' WD_USB_ERROR_CODES returned values:
    ' The following statuses are returned by WinDriver:
Global Const WD_STATUS_SUCCESS As Long = &H0
Global Const WD_STATUS_INVALID_WD_HANDLE As Long = &HFFFFFFFF
Global Const WD_WINDRIVER_STATUS_ERROR As Long = &H20000000

Global Const WD_INVALID_HANDLE As Long = &H20000001
Global Const WD_INVALID_PIPE_NUMBER As Long = &H20000002
Global Const WD_READ_WRITE_CONFLICT As Long = &H20000003  ' request to read from an OUT (write) pipe or
                                                  ' request to write to an IN (read) pipe
Global Const WD_ZERO_PACKET_SIZE As Long = &H20000004     ' maximum packet size is zero
Global Const WD_INSUFFICIENT_RESOURCES As Long = &H20000005
Global Const WD_UNKNOWN_PIPE_TYPE As Long = &H20000006
Global Const WD_SYSTEM_INTERNAL_ERROR As Long = &H20000007
Global Const WD_DATA_MISMATCH As Long = &H20000008
Global Const WD_NO_LICENSE As Long = &H20000009
Global Const WD_NOT_IMPLEMENTED As Long = &H2000000A
Global Const WD_KERPLUG_FAILURE As Long = &H2000000B
Global Const WD_FAILED_ENABLING_INTERRUPT As Long = &H2000000C
Global Const WD_INTERRUPT_NOT_ENABLED As Long = &H2000000D
Global Const WD_RESOURCE_OVERLAP As Long = &H2000000E
Global Const WD_DEVICE_NOT_FOUND As Long = &H2000000F
Global Const WD_WRONG_UNIQUE_ID As Long = &H20000010
Global Const WD_OPERATION_ALREADY_DONE As Long = &H20000011
Global Const WD_INTERFACE_DESCRIPTOR_ERROR As Long = &H20000012
Global Const WD_SET_CONFIGURATION_FAILED As Long = &H20000013
Global Const WD_CANT_OBTAIN_PDO As Long = &H20000014
Global Const WD_TIME_OUT_EXPIRED As Long = &H20000015
Global Const WD_IRP_CANCELED As Long = &H20000016
Global Const WD_FAILED_USER_MAPPING As Long = &H20000017
Global Const WD_FAILED_KERNEL_MAPPING As Long = &H20000018
Global Const WD_NO_RESOURCES_ON_DEVICE As Long = &H20000019
Global Const WD_NO_EVENTS As Long = &H2000001A
Global Const WD_INVALID_PARAMETER As Long = &H2000001B
Global Const WD_INCORRECT_VERSION As Long = &H2000001C
Global Const WD_TRY_AGAIN As Long = &H2000001D
Global Const WD_WINDRIVER_NOT_FOUND As Long = &H2000001E

' The following statuses are returned by USBD:
    ' USBD status types:
Global Const WD_USBD_STATUS_SUCCESS As Long = &H0
Global Const WD_USBD_STATUS_PENDING As Long = &H40000000
Global Const WD_USBD_STATUS_ERROR As Long = &H80000000
Global Const WD_USBD_STATUS_HALTED As Long = &HC0000000

    ' USBD status codes:
    ' NOTE: The following status codes are comprised of one of the status types above and an
    ' error code [i.e. XYYYYYYY - where: X = status type; YYYYYYY = error code].
    ' The same error codes may also appear with one of the other status types as well.

    ' HC (Host Controller) status codes.
    ' [NOTE: These status codes use the WD_USBD_STATUS_HALTED status type]:
Global Const WD_USBD_STATUS_CRC As Long = &HC0000001
Global Const WD_USBD_STATUS_BTSTUFF As Long = &HC0000002
Global Const WD_USBD_STATUS_DATA_TOGGLE_MISMATCH As Long = &HC0000003
Global Const WD_USBD_STATUS_STALL_PID As Long = &HC0000004
Global Const WD_USBD_STATUS_DEV_NOT_RESPONDING As Long = &HC0000005
Global Const WD_USBD_STATUS_PID_CHECK_FAILURE As Long = &HC0000006
Global Const WD_USBD_STATUS_UNEXPECTED_PID As Long = &HC0000007
Global Const WD_USBD_STATUS_DATA_OVERRUN As Long = &HC0000008
Global Const WD_USBD_STATUS_DATA_UNDERRUN As Long = &HC0000009
Global Const WD_USBD_STATUS_RESERVED1 As Long = &HC000000A
Global Const WD_USBD_STATUS_RESERVED2 As Long = &HC000000B
Global Const WD_USBD_STATUS_BUFFER_OVERRUN As Long = &HC000000C
Global Const WD_USBD_STATUS_BUFFER_UNDERRUN As Long = &HC000000D
Global Const WD_USBD_STATUS_NOT_ACCESSED As Long = &HC000000F
Global Const WD_USBD_STATUS_FIFO As Long = &HC0000010

    ' Returned by HCD (Host Controller Driver) if a transfer is submitted to an endpoint that is
    ' stalled:
Global Const WD_USBD_STATUS_ENDPOINT_HALTED As Long = &HC0000030

    ' Software status codes
    ' [NOTE: The following status codes have only the error bit set]:
Global Const WD_USBD_STATUS_NO_MEMORY As Long = &H80000100
Global Const WD_USBD_STATUS_INVALID_URB_FUNCTION As Long = &H80000200
Global Const WD_USBD_STATUS_INVALID_PARAMETER As Long = &H80000300

    ' Returned if client driver attempts to close an endpoint/interface
    ' or configuration with outstanding transfers:
Global Const WD_USBD_STATUS_ERROR_BUSY As Long = &H80000400

    ' Returned by USBD if it cannot complete a URB request. Typically this
    ' will be returned in the URB status field when the Irp is completed
    ' with a more specific NT error code. [The Irp statuses are indicated in
    ' WinDriver's Monitor Debug Messages (wddebug_gui) tool]:
Global Const WD_USBD_STATUS_REQUEST_FAILED As Long = &H80000500

Global Const WD_USBD_STATUS_INVALID_PIPE_HANDLE As Long = &H80000600

    ' Returned when there is not enough bandwidth available
    ' to open a requested endpoint:
Global Const WD_USBD_STATUS_NO_BANDWIDTH As Long = &H80000700

    ' Generic HC (Host Controller) error:
Global Const WD_USBD_STATUS_INTERNAL_HC_ERROR As Long = &H80000800

    ' Returned when a short packet terminates the transfer
    ' i.e. USBD_SHORT_TRANSFER_OK bit not set:
Global Const WD_USBD_STATUS_ERROR_SHORT_TRANSFER As Long = &H80000900

    ' Returned if the requested start frame is not within
    ' USBD_ISO_START_FRAME_RANGE of the current USB frame,
    ' NOTE: that the stall bit is set:
Global Const WD_USBD_STATUS_BAD_START_FRAME As Long = &HC0000A00

    ' Returned by HCD (Host Controller Driver) if all packets in an iso transfer complete with
    ' an error:
Global Const WD_USBD_STATUS_ISOCH_REQUEST_FAILED As Long = &HC0000B00

    ' Returned by USBD if the frame length control for a given
    ' HC (Host Controller) is already taken by another driver:
Global Const WD_USBD_STATUS_FRAME_CONTROL_OWNED As Long = &HC0000C00

    ' Returned by USBD if the caller does not own frame length control and
    ' attempts to release or modify the HC frame length:
Global Const WD_USBD_STATUS_FRAME_CONTROL_NOT_OWNED As Long = &HC0000D00

' USB TRANSFER options
Global Const USB_TRANSFER_HALT As Long = 1
Global Const USB_SHORT_TRANSFER As Long = 2
Global Const USB_FULL_TRANSFER As Long = 4
Global Const USB_ISOCH_ASAP As Long = &H8
Global Const USB_ISOCH_NOASAP As Long = &H80
Global Const USB_ISOCH_FULL_PACKETS_ONLY As Long = &H20
Global Const USB_ISOCH_RESET As Long = &H10

Type WD_USB_TRANSFER
    hDevice      As Long       ' handle of USB device to read from or write to
    dwPipe       As Long       ' pipe number on device
    fRead        As Long
    dwOptions    As Long       ' USB_TRANSFER options:
                               '   USB_TRANSFER_HALT - halts the pervious transfer.
                               '   USB_SHORT_TRANSFER - the transfer will be completed if
                               '     the device sent a short packet of data.
                               '   USB_FULL_TRANSFER - the transfer will normally be completed
                               '     if all the requested data was transferred.
    pBuffer      As Long       ' pointer to buffer to read/write
    dwBytes      As Long
    dwTimeout    As Long       ' timeout for the transfer in milliseconds. 0==>no timeout.
    dwBytesTransfered As Long  ' returns the number of bytes actually read/written
    SetupPacket(0 To 8 - 1) As Byte     ' setup packet for control pipe transfer
    fOK          As Long       ' transfer succeeded
    dwStatus     As Long       ' Configuration status code - see WD_USB_ERROR_CODES enum
                               ' definition.  WD_USBD_STATUS_SUCCESS for a successful
                               ' configuration.
End Type

Type WD_USB_DEVICE_REGISTER
    uniqueId             As Long         ' the device unique ID
    dwConfigurationIndex As Long         ' the index of the configuration to register
    dwInterfaceNum       As Long         ' interface to register
    dwInterfaceAlternate As Long
    hDevice              As Long         ' handle of device
    Device               As WD_USB_DEVICE_INFO      ' description of the device
    dwOptions            As Long         ' should be zero
    cName(0 To 32 - 1)   As Byte         ' name of card
    cDescription(0 To 100 - 1) As Byte   ' description
    dwStatus             As Long         ' Configuration status code - see WD_USB_ERROR_CODES
                                         ' enum definition.  WD_USBD_STATUS_SUCCESS for a
                                         ' successful configuration.
End Type

Type WD_USB_RESET_PIPE
        hDevice As Long
        dwPipe As Long
        dwStatus     As Long       ' Configuration status code - see WD_USB_ERROR_CODES enum
                                   ' definition.  WD_USBD_STATUS_SUCCESS for a successful
                                   ' configuration.
End Type

Type WD_USB_RESET_DEVICE
        hDevice As Long
        dwOptions As Long          ' USB_RESET options:
                                   ' WD_USB_HARD_RESET - will reset the device
                                   ' even if it is not disabled.
                                   ' After using this option it is advised to
                                   ' un-register the device (WD_UsbDeviceUnregister())
                                   ' and register it again - to make sure that the
                                   ' device has all its resources.
        dwStatus As Long           ' Configuration status code - see WD_USB_ERROR_CODES enum
                                   ' definition.  WD_USBD_STATUS_SUCCESS for a successful
                                   ' configuration.
End Type

Global Const WD_INSERT = &H1
Global Const WD_REMOVE = &H2
Global Const WD_POWER_CHANGED_D0 = &H10 ' Power states for the power management.
Global Const WD_POWER_CHANGED_D1 = &H20
Global Const WD_POWER_CHANGED_D2 = &H40
Global Const WD_POWER_CHANGED_D3 = &H80
Global Const WD_POWER_SYSTEM_WORKING = &H100
Global Const WD_POWER_SYSTEM_SLEEPING1 = &H200
Global Const WD_POWER_SYSTEM_SLEEPING2 = &H400
Global Const WD_POWER_SYSTEM_SLEEPING3 = &H800
Global Const WD_POWER_SYSTEM_HIBERNATE = &H1000
Global Const WD_POWER_SYSTEM_SHUTDOWN = &H2000

Global Const WD_ACTIONS_POWER = &H3FF0
Global Const WD_ACTIONS_ALL = &H3FF3

Global Const WD_ACKNOWLEDGE = &H1
Global Const WD_REENUM = &H2

Type WD_EVENT
    handle As Long
    dwAction As Long ' WD_EVENT_ACTION
    dwStatus As Long ' EVENT_STATUS
    dwEventId As Long
    dwCardType As Long 'WD_BUS_PCI or WD_BUS_USB
    hKernelPlugIn As Long
    dwOptions As Long ' WD_EVENT_OPTION
    dwVendorID As Long
    dwProductID As Long ' dwDeviceId for PCI cards
    ' for PCI card
    ' dw1 - dwBus
    ' dw2 - dwSlot
    ' dw3 - dwFunction
    ' for USB device
    ' dw1 - dwUniqueID
    dw1 As Long
    dw2 As Long
    dw3 As Long
    dwEventVer As Long
    dwNumMatchTables As Long
    matchTables(1) As WDU_MATCH_TABLE
End Type

Global Const WD_USB_HARD_RESET = 1

Private IOCTL_WD_USB_RESET_PIPE         As Long
Private IOCTL_WD_USB_RESET_DEVICE       As Long
Private IOCTL_WD_USB_RESET_DEVICE_EX    As Long
Private IOCTL_WD_USB_SCAN_DEVICES       As Long
Private IOCTL_WD_USB_SCAN_DEVICES_V432  As Long
Private IOCTL_WD_USB_TRANSFER           As Long
Private IOCTL_WD_USB_DEVICE_REGISTER    As Long
Private IOCTL_WD_USB_DEVICE_UNREGISTER  As Long
Private IOCTL_WD_USB_GET_CONFIGURATION  As Long

Dim WinDriverGlobalDW As Long

Global Const WD_TYPE As Long = 38200
Global Const FILE_ANY_ACCESS As Long = 0
Global Const METHOD_NEITHER As Long = 3

'    This is an implementation of a WinIOCTL macro (CTL_CODE)
Function Get_Ctl_Code(Nr As Integer) As Long
Dim lTMP As Long
Const lMaxLong As Long = 2147483647
   lTMP = (WD_TYPE * 2 ^ 15) Or (FILE_ANY_ACCESS * 2 ^ 13) + ((Nr * 4) Or (METHOD_NEITHER)) \ 2
   Get_Ctl_Code = 0 - (lMaxLong - lTMP) * 2 - 1
End Function ' Get_Ctl_Code

Function WD_Open() As Long
  Static WD_Initialized As Integer

  If (WD_Initialized = 0) Then
    WD_Initialize
    WD_Initialized = 1
  End If

  WD_Open = CreateFile("\\.\WINDRVR6", GENERIC_READ, _
     FILE_SHARE_READ Or FILE_SHARE_WRITE, 0, _
     OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0)
End Function

Sub WD_Close(ByVal hWD As Long)
  CloseHandle hWD
End Sub

Function WD_Debug(ByVal hWD As Long, ByRef Debug_parm As WD_Debug)
   DeviceIoControl hWD, IOCTL_WD_DEBUG, Debug_parm, _
                  LenB(Debug_parm), WD_Debug, 4, WinDriverGlobalDW, 0
End Function ' WD_Debug

Function WD_DebugDump(ByVal hWD As Long, ByRef DebugDump As WD_DEBUG_DUMP)
  DeviceIoControl hWD, IOCTL_WD_DEBUG_DUMP, DebugDump, _
                  LenB(DebugDump), WD_DebugDump, 4, WinDriverGlobalDW, 0
End Function ' WD_DebugDump

Function WD_Transfer(ByVal hWD As Long, ByRef Transfer As WD_Transfer)
  DeviceIoControl hWD, IOCTL_WD_TRANSFER, Transfer, _
                  LenB(Transfer), WD_Transfer, 4, WinDriverGlobalDW, 0
End Function ' WD_Transfer

Function WD_MultiTransfer(ByVal hWD As Long, ByRef TransferArray As WD_Transfer, ByVal dwNumTransfers As Integer)
  DeviceIoControl hWD, IOCTL_WD_MULTI_TRANSFER, TransferArray, _
                  LenB(TransferArray) * dwNumTransfers, WD_MultiTransfer, _
                  4, WinDriverGlobalDW, 0
End Function ' WD_MultiTransfer

Function WD_DMALock(ByVal hWD As Long, ByRef Dma As WD_DMA)
  DeviceIoControl hWD, IOCTL_WD_DMA_LOCK, Dma, LenB(Dma), WD_DMALock, 4, _
                  WinDriverGlobalDW, 0
End Function ' WD_DMALock

Function WD_DMAUnlock(ByVal hWD As Long, ByRef Dma As WD_DMA)
  DeviceIoControl hWD, IOCTL_WD_DMA_UNLOCK, Dma, LenB(Dma), WD_DMAUnlock, _
                  4, WinDriverGlobalDW, 0
End Function ' WD_DMAUnlock

Function WD_IntEnable(ByVal hWD As Long, ByRef TheInterrupt As WD_INTERRUPT)
  DeviceIoControl hWD, IOCTL_WD_INT_ENABLE, TheInterrupt, _
                  LenB(TheInterrupt), WD_IntEnable, 4, WinDriverGlobalDW, 0
End Function ' WD_IntEnable

Function WD_IntDisable(ByVal hWD As Long, ByRef TheInterrupt As WD_INTERRUPT)
  DeviceIoControl hWD, IOCTL_WD_INT_DISABLE, TheInterrupt, _
                  LenB(TheInterrupt), WD_IntDisable, 4, WinDriverGlobalDW, 0
End Function ' WD_IntDisable

Function WD_IntCount(ByVal hWD As Long, ByRef TheInterrupt As WD_INTERRUPT)
  DeviceIoControl hWD, IOCTL_WD_INT_COUNT, TheInterrupt, _
                  LenB(TheInterrupt), WD_IntCount, 4, WinDriverGlobalDW, 0
End Function ' WD_IntCount

Function WD_IntWait(ByVal hWD As Long, ByRef TheInterrupt As WD_INTERRUPT)
Dim h As Long
  h = WD_Open()
  DeviceIoControl h, IOCTL_WD_INT_WAIT, TheInterrupt, _
                  LenB(TheInterrupt), WD_IntWait, 4, WinDriverGlobalDW, 0
  WD_Close h
End Function ' WD_IntWait

Function WD_IsapnpScanCards(ByVal hWD As Long, ByRef IsapnpScanCards As WD_ISAPNP_SCAN_CARDS)
  DeviceIoControl hWD, IOCTL_WD_ISAPNP_SCAN_CARDS, IsapnpScanCards, _
                  LenB(IsapnpScanCards), WD_IsapnpScanCards, 4, WinDriverGlobalDW, 0
End Function ' WD_IsapnpScanCards

Function WD_IsapnpGetCardInfo(ByVal hWD As Long, ByRef IsapnpGetCardInfo As WD_ISAPNP_CARD_INFO)
  DeviceIoControl hWD, IOCTL_WD_ISAPNP_GET_CARD_INFO, IsapnpGetCardInfo, _
                  LenB(IsapnpGetCardInfo), WD_IsapnpGetCardInfo, 4, WinDriverGlobalDW, 0
End Function ' WD_IsapnpGetCardInfo

Function WD_IsapnpConfigDump(ByVal hWD As Long, ByRef IsapnpConfigDump As WD_ISAPNP_CONFIG_DUMP)
  DeviceIoControl hWD, IOCTL_WD_ISAPNP_CONFIG_DUMP, IsapnpConfigDump, _
                  LenB(IsapnpConfigDump), WD_IsapnpConfigDump, 4, WinDriverGlobalDW, 0
End Function ' WD_IsapnpConfigDump

Function WD_PcmciaScanCards(ByVal hWD As Long, ByRef PcmciaScanCards As WD_PCMCIA_SCAN_CARDS)
  DeviceIoControl hWD, IOCTL_WD_PCMCIA_SCAN_CARDS, PcmciaScanCards, _
                                  LenB(PcmciaScanCards), WD_PcmciaScanCards, 4, WinDriverGlobalDW, 0
End Function ' WD_PcmciaScanCards

Function WD_PcmciaGetCardInfo(ByVal hWD As Long, ByRef PcmciaCardInfo As WD_PCMCIA_CARD_INFO)
  DeviceIoControl hWD, IOCTL_WD_PCMCIA_GET_CARD_INFO, PcmciaCardInfo, _
                                  LenB(PcmciaCardInfo), WD_PcmciaGetCardInfo, 4, WinDriverGlobalDW, 0
End Function ' WD_PcmciaGetCardInfo

Function WD_PcmciaConfigDump(ByVal hWD As Long, ByRef PcmciaConfigDump As WD_PCMCIA_CONFIG_DUMP)
  DeviceIoControl hWD, IOCTL_WD_PCMCIA_CONFIG_DUMP, PcmciaConfigDump, _
                          LenB(PcmciaConfigDump), WD_PcmciaConfigDump, 4, WinDriverGlobalDW, 0
End Function ' WD_PcmciaConfigDump

Function WD_Sleep(ByVal hWD As Long, ByRef Sleep As WD_Sleep)
  DeviceIoControl hWD, IOCTL_WD_SLEEP, Sleep, _
                  LenB(Sleep), WD_Sleep, 4, WinDriverGlobalDW, 0
End Function ' WD_Sleep

Function WD_CardRegister(ByVal hWD As Long, ByRef Card As WD_CARD_REGISTER)
   DeviceIoControl hWD, IOCTL_WD_CARD_REGISTER, Card, _
                  LenB(Card), WD_CardRegister, 4, WinDriverGlobalDW, 0
End Function ' WD_CardRegister

Function WD_CardUnregister(ByVal hWD As Long, ByRef Card As WD_CARD_REGISTER)
  DeviceIoControl hWD, IOCTL_WD_CARD_UNREGISTER, Card, _
                  LenB(Card), WD_CardUnregister, 4, WinDriverGlobalDW, 0
End Function ' WD_CardUnregister

Function WD_PciScanCards(ByVal hWD As Long, ByRef pciScan As WD_PCI_SCAN_CARDS)
   DeviceIoControl hWD, IOCTL_WD_PCI_SCAN_CARDS, pciScan, _
                  LenB(pciScan), WD_PciScanCards, 4, WinDriverGlobalDW, 0
End Function ' WD_PciScanCards

Function WD_PciGetCardInfo(ByVal hWD As Long, ByRef PciCard As WD_PCI_CARD_INFO)
 DeviceIoControl hWD, IOCTL_WD_PCI_GET_CARD_INFO, PciCard, _
                  LenB(PciCard), WD_PciGetCardInfo, 4, WinDriverGlobalDW, 0
End Function ' WD_PciGetCardInfo

Function WD_Version(ByVal hWD As Long, ByRef VerInfo As WD_Version)
  DeviceIoControl hWD, IOCTL_WD_VERSION, VerInfo, _
                  LenB(VerInfo), WD_Version, 4, WinDriverGlobalDW, 0
End Function ' WD_Version

Function WD_License(ByVal hWD As Long, ByRef License As WD_License)
  DeviceIoControl hWD, IOCTL_WD_LICENSE, License, _
                  LenB(License), WD_License, 4, WinDriverGlobalDW, 0
End Function ' WD_License

Function WD_KernelPlugInOpen(ByVal hWD As Long, ByRef KernelPlugInOpen As WD_KERNEL_PLUGIN)
  DeviceIoControl hWD, IOCTL_WD_KERNEL_PLUGIN_OPEN, KernelPlugInOpen, _
                  LenB(KernelPlugInOpen), WD_KernelPlugInOpen, 4, WinDriverGlobalDW, 0
End Function ' WD_KernelPlugInOpen

Function WD_KernelPlugInClose(ByVal hWD As Long, ByRef KernelPlugInClose As WD_KERNEL_PLUGIN)
  DeviceIoControl hWD, IOCTL_WD_KERNEL_PLUGIN_CLOSE, KernelPlugInClose, _
                  LenB(KernelPlugInClose), WD_KernelPlugInClose, 4, WinDriverGlobalDW, 0
End Function ' WD_KernelPlugInClose

Function WD_KernelPlugInCall(ByVal hWD As Long, ByRef KernelPlugInCall As WD_KERNEL_PLUGIN_CALL)
  DeviceIoControl hWD, IOCTL_WD_KERNEL_PLUGIN_CALL, KernelPlugInCall, _
                  LenB(KernelPlugInCall), WD_KernelPlugInCall, 4, WinDriverGlobalDW, 0
End Function ' WD_KernelPlugInCall

Function WD_PciConfigDump(ByVal hWD As Long, ByRef PciConfigDump As WD_PCI_CONFIG_DUMP)
  DeviceIoControl hWD, IOCTL_WD_PCI_CONFIG_DUMP, PciConfigDump, _
                  LenB(PciConfigDump), WD_PciConfigDump, 4, WinDriverGlobalDW, 0
End Function ' WD_PciConfigDump

Function WD_UsbScanDevice(ByVal hWD As Long, ByRef Scan As WD_USB_SCAN_DEVICES)
  DeviceIoControl hWD, IOCTL_WD_USB_SCAN_DEVICES, Scan, _
                  LenB(Scan), WD_UsbScanDevice, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbScanDevice

Function WD_UsbGetConfiguration(ByVal hWD As Long, ByRef Config As WD_USB_CONFIGURATION)
  DeviceIoControl hWD, IOCTL_WD_USB_GET_CONFIGURATION, Config, _
                  LenB(Config), WD_UsbGetConfiguration, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbGetConfiguration

Function WD_UsbDeviceRegister(ByVal hWD As Long, ByRef Dev As WD_USB_DEVICE_REGISTER)
  DeviceIoControl hWD, IOCTL_WD_USB_DEVICE_REGISTER, Dev, _
                  LenB(Dev), WD_UsbDeviceRegister, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbDeviceRegister

Function WD_UsbTransfer(ByVal hWD As Long, ByRef Trans As WD_USB_TRANSFER)
Dim h As Long
  h = WD_Open()
  DeviceIoControl h, IOCTL_WD_USB_TRANSFER, Trans, _
                  LenB(Trans), WD_UsbTransfer, 4, WinDriverGlobalDW, 0
  WD_Close h
End Function ' WD_UsbTransfer

Function WD_UsbDeviceUnregister(ByVal hWD As Long, ByRef Dev As WD_USB_DEVICE_REGISTER)
  DeviceIoControl hWD, IOCTL_WD_USB_DEVICE_UNREGISTER, Dev, _
                  LenB(Dev), WD_UsbDeviceUnregister, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbDeviceUnregister

Function WD_UsbResetPipe(ByVal hWD As Long, ByRef ResetPipe As WD_USB_RESET_PIPE)
  DeviceIoControl hWD, IOCTL_WD_USB_RESET_PIPE, ResetPipe, _
                  LenB(ResetPipe), WD_UsbResetPipe, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbResetPipe

Function WD_UsbResetDevice(ByVal hWD As Long, ByVal hDev As Long)
  DeviceIoControl hWD, IOCTL_WD_USB_RESET_DEVICE, hDev, _
                  LenB(hDev), WD_UsbResetDevice, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbResetDevice

Function WD_UsbResetDeviceEx(ByVal hWD As Long, ByRef ResetDevice As WD_USB_RESET_DEVICE)
  DeviceIoControl hWD, IOCTL_WD_USB_RESET_DEVICE_EX, ResetDevice, _
                  LenB(ResetDevice), WD_UsbResetDeviceEx, 4, WinDriverGlobalDW, 0
End Function ' WD_UsbResetDevice_Ex

Function WD_EventRegister(ByVal hWD As Long, ByRef wdEvent As WD_EVENT)
  DeviceIoControl hWD, IOCTL_WD_EVENT_REGISTER, wdEvent, _
                  LenB(wdEvent), WD_EventRegister, 4, WinDriverGlobalDW, 0
End Function ' WD_EventRegister

Function WD_EventUnregister(ByVal hWD As Long, ByRef wdEvent As WD_EVENT)
  DeviceIoControl hWD, IOCTL_WD_EVENT_UNREGISTER, wdEvent, _
                  LenB(wdEvent), WD_EventUnregister, 4, WinDriverGlobalDW, 0
End Function ' WD_EventUnregister

Function WD_EventPull(ByVal hWD As Long, ByRef wdEvent As WD_EVENT)
  DeviceIoControl hWD, IOCTL_WD_EVENT_PULL, wdEvent, _
                  LenB(wdEvent), WD_EventPull, 4, WinDriverGlobalDW, 0
End Function ' WD_EventPull

Function WD_EventSend(ByVal hWD As Long, ByRef wdEvent As WD_EVENT)
  DeviceIoControl hWD, IOCTL_WD_EVENT_SEND, wdEvent, _
                  LenB(wdEvent), WD_EventSend, 4, WinDriverGlobalDW, 0
End Function ' WD_EventSend

Function WD_DebugAdd(ByVal hWD As Long, ByRef dbg As WD_DEBUG_ADD)
  DeviceIoControl hWD, IOCTL_WD_DEBUG_ADD, dbg, _
                  LenB(dbg), WD_DebugAdd, 4, WinDriverGlobalDW, 0
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
