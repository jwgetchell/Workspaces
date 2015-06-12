VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTest38reg"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim qth As ucThorlabsAPT
Dim als As ucALSusb
Dim et As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Dim nMeas As Integer
Dim debugPrint_ As Boolean

Public Interval As Integer
Dim startTime As Long
Dim rd4 As Integer, clr As Integer
Dim andOr As Boolean

Dim usingPlotBuffer As Boolean
Dim pBuf() As Double
Dim pBidx As Integer
Dim pBsz As Integer

Dim skipIntCheck As Boolean

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set als = frm.ucALSusb1
    Set et = frmEtIo
    Set fltr = frmMonochromator.ucMonochromator1
    Set f38 = frm29038
    
    debugPrint_ = False
    usingPlotBuffer = True
    skipIntCheck = False
    nMeas = 64
    Interval = 1
        
End Sub

Sub wrt(ByVal addr As Byte, ByVal data As Byte)
    Call als.dWriteField(addr, 0, &HFF, data)
    If debugPrint_ Then Call debugPrint("W:", Hex(addr), ":", Hex(data))
End Sub

Function rd(ByVal addr As Byte) As Byte
    Call als.dReadField(addr, 0, &HFF, rd)
    If debugPrint_ Then Call debugPrint("R:", Hex(addr), ":", Hex(rd))
End Function

Function rdInt() As Byte
    'GoTo skip
    rdInt = als.readHIDuCportBit(1, 0) ' port, bit
    If debugPrint_ Then Call debugPrint("Int=", rdInt)
skip:
End Function

Sub setForcedIntEnable(chan As Integer, on_ As Boolean)
    If chan Then ' proximity
        If on_ Then
            wrt 5, &HFF: wrt 6, 0
        Else
            wrt 5, 0: wrt 6, &HFF
        End If
        Call als.dWriteField(4, 7, 1, 0) ' clr pFLG
    Else         ' ALS
        If on_ Then
            wrt 7, &HFF: wrt 9, 0: wrt 8, &HF0
        Else
            wrt 7, 0: wrt 9, &HFF: wrt 8, &HF
        End If
        Call als.dWriteField(4, 3, 1, 0) ' clr aFLG
    End If
End Sub

Function fFlag(aflg As Integer, pflg As Integer, nInt As Integer) As Integer
    If andOr Then
        If nInt <> (aflg And pflg) Then
            fFlag = 1
        Else
            fFlag = 0
        End If
    Else
        If nInt <> (aflg Or pflg) Then
            fFlag = 1
        Else
            fFlag = 0
        End If
    End If
End Function

Function getFlagInt() As Integer
    Dim dp As Boolean: dp = debugPrint_: debugPrint_ = 0
    
    Dim aflg As Integer, pflg As Integer, nInt As Integer, fflg As Integer
    
    If Not skipIntCheck Then nInt = 1 - rdInt
    rd4 = rd(4)
    clr = (rd4 And &H77) Or ((rd4 And &H88) Xor &H88)
    pflg = Sgn(rd4 And (2 ^ 7))
    aflg = Sgn(rd4 And (2 ^ 3))
    
    fflg = fFlag(aflg, pflg, nInt)
    
    If fflg And Not skipIntCheck Then nInt = 1 - rdInt: fflg = fFlag(aflg, pflg, nInt)
    
    getFlagInt = fflg * 8 + nInt * 4 + aflg * 2 + pflg
    
    debugPrint_ = dp

End Function

Sub setup(value As Integer)

    If value = 0 Then
    
        als.dPrintTrace "<<<< Start Logic Test >>>>"
GoTo skipPreset
        wrt &HE, &H38 'soft reset
        
        als.dSetSleep 1 '400,100,50,25,12,6,3,0
            'wrt 1, &H0    'slp=100
        als.dSetRange 0, 3 '125,250,2k,4k
        als.dWriteField 2, 7, 1, 1 'int29
            'wrt 2, &H83   'int29, 4k
        wrt 3, &H0    '
            'wrt 4, &H0     'pPrst=2
        als.dSetIntPersist 0, 0 '1,2,4,8
        als.dSetIntPersist 1, 1
        ' force both interrupts
            'wrt 5, &HFF   'ptl=FF
            'wrt 6, &H0    'pth=0
            'wrt 7, &HFF   'atl
            'wrt 8, &HF0   'atl/ath
            'wrt 9, &H0    'ath
        
        If debugPrint_ Then Call dpNoCr: debugPrint "Mask Rev: "
        rd 0
        
        rdInt
        
skipPreset:
        setForcedIntEnable 0, True
        setForcedIntEnable 1, True
        
        als.dSetEnable 0, 1
        als.dSetEnable 1, 1
            'wrt 1, &H20   'prxEn
            'wrt 2, &H87   'alsEn
    Else
        'If debugPrint_ Then Call dpNoCr: rd (4)
        'rdInt
    End If
    
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        frm.tmrPlot.enabled = False
        
        pBsz = 2 * (2 * nMeas - 1): pBidx = 0
        ReDim pBuf(pBsz - 1)
        setPlotSize pBsz
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
        testInProgress = True
        
        als.setI2CclkMult 4
    
        startTime = GetTickCount
        measInc = 0
        setup measInc
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
        
            als.setI2CclkMult
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
            If usingPlotBuffer Then
                For pBidx = 0 To pBsz - 1
                    frm.send2plot pdAls, pBuf(pBidx)
                Next pBidx
            End If
                
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            plt.send2Excel 0
            
            als.dPrintTrace "^^^^^ End Logic Test ^^^^^"
        
        End If
        
    End If
End Function

Sub send2plot(ByVal Time As Double, ByVal value As Double)
    If usingPlotBuffer Then
        pBuf(pBidx) = Time: pBidx = pBidx + 1
        pBuf(pBidx) = value: pBidx = pBidx + 1
    Else
        frm.send2plot pdAls, Time
        frm.send2plot pdAls, value
    End If
End Sub

Public Function next_()
    
    Dim elapseTime As Long, now As Long, ioTime As Long
    Static lastNint As Integer
    Dim nInt As Integer
    
    now = GetTickCount
    elapseTime = now - startTime
    
    nInt = getFlagInt: If ((nInt And 3) <> 0) Then wrt 4, clr
    
    ioTime = GetTickCount - now
    
    If measInc Then
        send2plot elapseTime, lastNint
    Else
        startTime = GetTickCount
        elapseTime = 0
    End If
    
    send2plot elapseTime, nInt
    
    lastNint = nInt
    
    measInc = measInc + 1
    
    If debugPrint_ Then Call dpNoCr: debugPrint elapseTime
    If Not done Then setup measInc
    
    next_ = measInc / nMeas
    
End Function

