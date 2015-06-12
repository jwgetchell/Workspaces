VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestrgbFSsweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim fltr As ucMonochromator
Dim msg As frmPrompt
Dim als As ucALSusb
Dim tst As frmTest
Dim luxMeter As clsLuxMeter

Dim src As clsIloop
Dim msr As clsIloop

Dim msrDUT As Boolean

Dim etio As frmEtIo
Dim eep As frmEEprom

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nSteps As Integer
Dim fwIdx() As Integer

Public Interval As Integer

Dim nRange As Long, Ninput As Long

'Names
Dim InputN As Long
Dim comp38 As Long

' for test loops
Dim ndVals(1) As Integer ' define in initialize as 4 & 17
Dim fltIdx As Integer
Dim ndSwitchStep(1) As Integer
Dim range As Integer
Dim vLedMax As Double
Dim vLedMin As Double
Dim vLedStep As Double

Private Sub Class_Initialize()

    Dim i As Integer
    
    ' read Name values from Excel
    ' Names must be listed in modDSP
    InputN = modDSP.getExcelName("inputN"): If InputN = 0 Then InputN = 1
    comp38 = modDSP.getExcelName("comp38")
    
    Set luxMeter = New clsLuxMeter
    
    Set frm = frmMain
    Set als = frm.ucALSusb1
    Set plt = frmPlot
    Set msg = frmPrompt
    Set tst = frmTest
    Set fltr = frmMonochromator.ucMonochromator1
    Set etio = frmEtIo
    Set eep = frmEEprom
    Set msr = tst.pMeasure
    
    msrDUT = tst.measuringDUT
        
End Sub

Sub loadLocals()

    vLedMax = 3.5
    vLedMin = 1.24
    
    ndVals(0) = 2: ndVals(1) = 17
    
    vLedStep = 0.02
    Interval = 1200
    
    nMeas = (vLedMax - vLedMin) / vLedStep + 1
    
    ndSwitchStep(0) = nMeas ' 114
    ndSwitchStep(1) = 4 * nMeas ' 456
    
    nMeas = 7 * nMeas ' 798
    
End Sub

Public Sub arm()

    Dim i As Integer, c As Integer
    
    loadLocals

    ' Plot
    frm.tmrPlot.enabled = False
    plt.cbPlotOnOff.value = vbUnchecked
    
    For i = 0 To 3
    
        plt.setPlotSize plotDataType.pdALS, nMeas, i + 1
        
        plt.ucPlot1(i).XaxisDataMin = 0
        plt.ucPlot1(i).XaxisDataMax = nMeas
        plt.ucPlot1(i).XaxisLabel = "meas#"
    
    Next i
    
    ' Device
    als.dSetIRcomp 1 * (0 * 128 + 63)
    als.dSetEnable 0, 1
    als.dSetInputSelect 0, 2 ' {OFF,ALS,RGB}
    range = 1: als.dSetRange 0, range ' {LO,HI,HS}
    
    ' Source
    fltIdx = 0: filterWheel2TstIdx fltIdx
    setLEDindex 0, vLedMin
    
    Sleep 1000
    
    If debugPrint_ Then debugPrint "<<<< START >>>>"
    measInc = 0
    testInProgress = True
    
End Sub

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(5) As Single
    Dim step_ As Integer, inp As Integer
    Dim lastStep As Integer, lastRange As Integer
    Static waitCount As Integer, lux(5) As Single
    
    If msr.getValue(value(), id) Then
    
        DoEvents
        If range = 1 Then luxMeter.getValue lux, 0
        frm.send2plot pdALS, lux(0), 4
        DoEvents
        For i = 0 To 2: frm.send2plot plotDataType.pdALS, value(i), i + 1: Next i
        
        measInc = measInc + 1
        
        If Not done Then
        
            If measInc >= ndSwitchStep(0) Then
                ' set range
                range = (measInc - ndSwitchStep(0)) Mod 3
                If range < 2 Then range = Abs(1 - range)
                als.dSetRange 0, range
                
                ' set ND
                If (measInc = ndSwitchStep(0)) Or (measInc = ndSwitchStep(1)) Then
                    fltIdx = fltIdx + 1: filterWheel2TstIdx fltIdx
                End If
                
            End If
            
            If range = 1 Then setLEDindex
            
        Else
            fltIdx = 0: filterWheel2TstIdx fltIdx
            als.dSetRange 0, 1 ' HI
            setLEDindex 0
        End If
        
    End If
    
    If debugPrint_ Then
        debugPrint measInc, range, fltIdx
    End If
    
    next_ = measInc / nMeas
    
skipNext:

End Function

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
        
            ' reset source
            filterWheel2TstIdx
            setLEDindex 0, vLedMin
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Sub filterWheel2TstIdx(Optional ByVal idx As Integer = 0)

    Dim c As Integer: c = 5
    
    fltIdx = idx
    
    If idx < 2 Then
        idx = ndVals(idx)
    Else
        idx = ndVals(1) + 1
    End If
    
    Do
        fltr.setFwIndex idx
        Sleep 1000
        c = c - 1
    Loop Until c <= 0 Or (fltr.getFwIndex = idx And fltr.fwReady)
    
    Sleep 3000
    
End Sub

Function setLEDindex(Optional lvl As Integer = -1, Optional setMin As Double = -1) As Integer

    ' no prams: increment level
    '           if level < min : reset level; toggle min
    '
    ' lvl only: resets level to 0 (not attenuation)

    Static level As Integer: Static min As Double
    Dim volts As Double
    
    If setMin > 0 Then
        min = setMin
    End If
    
    If lvl >= 0 Then
        level = lvl
    Else
        level = level + 1
    End If
    
    volts = vLedMax - level * vLedStep
    
    If volts < min Then
    
        If min = 0 Then ' if not set, set to minHi
            min = vLedMinHi
        Else
        
            level = 0
            volts = vLedMax
            
        End If
        
    End If
    
    etio.setLEDvolts AER.LED6500K, volts
    
    Sleep 10: DoEvents
    
    setLEDindex = level

End Function

