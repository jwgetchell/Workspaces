VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsBitDefs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Match BF item values with GUI index

Public Enum BF
    PRST_
    IRDR_
    SLEP_
    
    WASH_
    TRLO_
    TRHI_
    PXEN_
    XPLS_
    
    STTS_ ' status
    PXFG_ ' near/far-int flag
    PXDN_ ' done
    RINT_ ' "brown out": re-initialize required
    NITEMS
End Enum

Private Type BitField
    addr As Integer
    mask As Integer
    shift As Integer
End Type

Dim btFld(BF.NITEMS) As BitField
Dim als As ucALSusb

Dim Status As Byte



Private Sub Class_Initialize()

    ' fixed to index of GUI cmbBitField
    btFld(BF.PRST_).addr = &H3: btFld(BF.PRST_).shift = 4: btFld(BF.PRST_).mask = 3
    btFld(BF.IRDR_).addr = &H1: btFld(BF.IRDR_).shift = 0: btFld(BF.IRDR_).mask = 7
    btFld(BF.SLEP_).addr = &H1: btFld(BF.SLEP_).shift = 4: btFld(BF.SLEP_).mask = 7
    
    ' remaining definitions
    '   registers
    btFld(BF.TRLO_).addr = &H4: btFld(BF.TRLO_).shift = 0: btFld(BF.TRLO_).mask = 255
    btFld(BF.TRHI_).addr = &H5: btFld(BF.TRHI_).shift = 0: btFld(BF.TRHI_).mask = 255
    btFld(BF.STTS_).addr = &H6: btFld(BF.STTS_).shift = 0: btFld(BF.STTS_).mask = 255
    btFld(BF.WASH_).addr = &H8: btFld(BF.WASH_).shift = 0: btFld(BF.WASH_).mask = 127
    '   bit fields
    btFld(BF.PXEN_).addr = &H3: btFld(BF.PXFG_).shift = 3: btFld(BF.PXFG_).mask = 1
    btFld(BF.XPLS_).addr = &H2: btFld(BF.XPLS_).shift = 6: btFld(BF.XPLS_).mask = 1
    '       part of status byte (short or wash are useless)
    btFld(BF.PXDN_).addr = &H6: btFld(BF.PXDN_).shift = 2: btFld(BF.PXDN_).mask = 1 ' done
    btFld(BF.PXFG_).addr = &H6: btFld(BF.PXFG_).shift = 3: btFld(BF.PXFG_).mask = 1 ' "int"
    btFld(BF.RINT_).addr = &H6: btFld(BF.RINT_).shift = 4: btFld(BF.RINT_).mask = 1 ' "brown out"
    
End Sub

Public Sub setAlsDrv(drv As ucALSusb)
    Set als = drv
End Sub





Public Sub writeField(ByVal field As BF, ByVal value As Long)
    als.dWriteField addr(field), shift(field), mask(field), value ' does read, modify, write
End Sub

Public Sub readField(ByVal field As BF, value As Byte)
    als.dReadField addr(field), shift(field), mask(field), value ' value is shifted to B0
End Sub




Public Function GetProximity(prox As Double) As Boolean
    ' Registers: STATUS, PROX_DT, PROX_WASH: 0x6-0x8
    ' responsible for reading status (clear on read)
    ' returns PROX_DONE
    
    GetProximity = getDone
    
    If GetProximity Then GetProximity = Not getInitNeeded ' return false on "brown out"
    
    If GetProximity Then
        als.dGetProximity prox
    Else
        als.dGetProximity prox ' breakpoint:PROX_DONE not set
    End If
    
End Function

Public Function getPflag() As Boolean

    getPflag = getStBit(BF.PXFG_)
    
End Function

Public Function getInitNeeded() As Boolean

    getInitNeeded = getStBit(BF.RINT_)
    
End Function

Private Function getDone() As Boolean

    readField BF.STTS_, Status
    
    If Status <> 4 Then
        getDone = False
    End If
    
    getDone = getStBit(BF.PXDN_)
    
End Function

Private Function getStBit(stBit As BF) As Boolean

    If ((Status / (2 ^ shift(stBit)) - 0.499999999999999) And mask(stBit)) > 0 Then
        getStBit = True
    Else
        getStBit = False
    End If
    
End Function






Private Function addr(ByVal bitF As BF) As Byte
    addr = btFld(bitF).addr
End Function
Private Function shift(ByVal bitF As BF) As Byte
    shift = btFld(bitF).shift
End Function
Private Function mask(ByVal bitF As BF) As Byte
    mask = btFld(bitF).mask
End Function



