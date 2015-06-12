VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsProxSweep177"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim apt As ucThorlabsAPT
Dim etio As frmEtIo
Dim tst As frmTest

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Const nIrdr As Integer = 4

Public Interval As Integer
Dim start_, stop_, step_ As Single

' offset
Private Type offsetSetting
    Index As Long
    value As Double ' fsr
End Type

Dim offset(nIrdr - 1) As offsetSetting

'Names
Dim PswpStart As Single
Dim PswpStop As Single
Dim PswpStep As Single

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set apt = frmThorlabsAPT.ucThorlabsAPT1(0)
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set tst = frmTest
    
    ' read Name values from Excel
    PswpStart = modDSP.getExcelName("PswpStart")
    PswpStop = modDSP.getExcelName("PswpStop")
    PswpStep = modDSP.getExcelName("PswpStep")
    
    Interval = 100
    
End Sub

Public Sub arm()

    Dim i As Integer
    Dim nRng As Long, nChn As Long
    
    If Not testInProgress Then
        
        If PswpStop * PswpStep Then
            apt.setStart PswpStart
            apt.setStop PswpStop
            apt.setStep PswpStep
        End If
        
        start_ = apt.getStart
        stop_ = apt.getStop
        step_ = apt.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        For i = 0 To nIrdr - 1
            plt.setPlotSize pdProx, nMeas + 1 + 4, i + 1 ' JWG add 1 for offset, 4 for pad
            plt.ucPlot1(i).XaxisDataMin = start_
            plt.ucPlot1(i).XaxisDataMax = stop_
            'plt.ucPlot1(i).caption
            plt.ucPlot1(i).XaxisLabel = "mm"
        Next i
        
        measProxOffset ' must be `38
        setIrdr 0: Sleep 25: DoEvents
        
        apt.arm
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            Call als.dSetEnable(1, 0) ' JWG good for 2 channel devices only
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Private Function setIrdr(ByVal value As Long) As Long
    
    als.dSetIrdr value
    
    setIrdr = offset(value).Index
    als.dSetProxOffset setIrdr
    
    Debug.Print value, setIrdr
    
End Function

Public Function next_(Optional idx As Integer = -1) As Single
    Dim i As Long, param As Long, value As Double
    
    If Not apt.done Then
    
        For i = 0 To nIrdr - 2
        
            als.dGetProximity value
            frm.send2plot pdProx, value, nIrdr - i
            
            If i < nIrdr - 2 Then
                param = setIrdr(i + 1)
            Else
                param = setIrdr(3)
            End If
                Sleep 25: DoEvents
        Next i
        
        als.dGetProximity value
        frm.send2plot pdProx, value, nIrdr - i
        param = setIrdr(0)
        measInc = measInc + 1
        
        apt.next_
    
    Else
    
        If Not done Then
            
            For i = 0 To nIrdr - 2
            
                als.dGetProximity value
                frm.send2plot pdProx, value, nIrdr - i
                
                If i < nIrdr - 2 Then
                    param = setIrdr(i + 1)
                Else
                    param = setIrdr(3)
                End If
                    Sleep 25: DoEvents
            Next i
            
            als.dGetProximity value
            frm.send2plot pdProx, value, nIrdr - i
            param = setIrdr(0)
            For i = 0 To nIrdr - 1
            
                value = offset(i).value / 100
                frm.send2plot pdProx, 0, nIrdr - i
                frm.send2plot pdProx, 0, nIrdr - i
                frm.send2plot pdProx, value, nIrdr - i
                frm.send2plot pdProx, 0, nIrdr - i
                frm.send2plot pdProx, 0, nIrdr - i
                
            Next i
            
            measInc = nMeas
        
        End If
        
    End If
    
    next_ = measInc / nMeas

End Function

Sub measProxOffset()
    Static pTable(11) As Long
    Dim i As Long, j As Long
    
    If pTable(0) = 0 Then
        pTable(i) = 30: i = i + 1: pTable(i) = 45: i = i + 1
        pTable(i) = 53: i = i + 1: pTable(i) = 58: i = i + 1
        pTable(i) = 63: i = i + 1: pTable(i) = 66: i = i + 1
        pTable(i) = 69: i = i + 1: pTable(i) = 72: i = i + 1
        pTable(i) = 74: i = i + 1: pTable(i) = 77: i = i + 1
        pTable(i) = 79: i = i + 1: pTable(i) = 81: i = i + 1
    End If

    Dim sleepTime As Long, pOffset As Long, prox As Double, pram As Long
    
    als.dGetSleep sleepTime
    als.dSetSleep 5 ' 25 ms
    als.dSetEnable 1, 1
    
    als.dSetIrdrMode 2 ' Hi only
    
    If stop_ > 50 Then
        apt.moveTo stop_ ' FAR
    Else
        apt.moveTo 150 ' FAR
    End If

    For j = 0 To nIrdr - 1
    
        als.dSetIrdr j
        
        als.dSetProxOffset 0
        Sleep 25: DoEvents
        als.dGetProximity prox
        
        i = 0
        Do While prox > 0.5
            pOffset = pTable(i): pram = pOffset
            als.dSetProxOffset pram
            Sleep 25: DoEvents
            als.dGetProximity prox
            i = i + 1: If i > 11 Then Exit Do
        Loop
        
        Do While prox > 0.01
            pOffset = pOffset + 1: pram = pOffset
            als.dSetProxOffset pram
            Sleep 25: DoEvents
            als.dGetProximity prox
            If pOffset > 92 Then Exit Do
        Loop
        
        Do While prox < 0.01
            pOffset = pOffset - 1: pram = pOffset
            als.dSetProxOffset pram
            Sleep 25: DoEvents
            als.dGetProximity prox
            If pOffset = 0 Then Exit Do
        Loop
        
        offset(j).Index = pOffset
        offset(j).value = prox + pram / 255
        
    Next j
    
End Sub


