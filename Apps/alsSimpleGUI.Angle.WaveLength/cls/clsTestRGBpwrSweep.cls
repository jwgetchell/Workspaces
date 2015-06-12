VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRGBpwrSweep"
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

Private Sub Class_Initialize()

    Dim i As Integer

    ' read Name values from Excel
    ' Names must be listed in modDSP
    InputN = modDSP.getExcelName("inputN"): If InputN = 0 Then InputN = 1
    comp38 = modDSP.getExcelName("comp38")
    
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
    
    If msrDUT Then
         Call als.dGetNrange(0, nRange)
         Call als.dGetNinputSelect(0, Ninput)
    Else
        nRange = 1
    End If
    
    nSteps = 25: ReDim fwIdx(nSteps - 1) As Integer
    
    Select Case gPartNumber
    Case 29120: nMeas = nSteps * nRange * InputN: Interval = 1000
    Case 29125: nMeas = nSteps * nRange: Interval = 5 * frmRGBscan.tmrRGBscan.Interval
    End Select
    
    For i = 0 To nSteps - 1
        Select Case i
        Case 13 To nSteps - 1
            fwIdx(i) = i + 1
        Case Else
            fwIdx(i) = i
        End Select
    Next i

End Sub

Sub filterWheel2start()
    Dim c As Integer: c = 5
    
    Do
        fltr.setFilterWheel 0, 0: fltr.setFilterWheel 1, 0
        fltr.setFwIndex 0
        Sleep 1000
        c = c - 1
    Loop Until c <= 0 Or (fltr.getFwIndex = 0 And fltr.fwReady)
    
    Sleep 3000
    
End Sub

Public Sub arm()

    Dim i As Integer, c As Integer
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        
        For i = 0 To 3
        
            plt.setPlotSize plotDataType.pdALS, nSteps * nRange, i + 1
            plt.setPlotSize plotDataType.pdProx, nSteps * nRange, i + 1
            plt.setPlotSize plotDataType.pdIR, nSteps * nRange, i + 1
            
            plt.ucPlot1(i).XaxisDataMin = 0
            plt.ucPlot1(i).XaxisDataMax = nSteps
            plt.ucPlot1(i).XaxisLabel = "meas#"
        
        Next i
        
        als.dSetIRcomp comp38
        'als.dSetInputSelect 0, 0
        als.dSetRange 0, 0
        
        filterWheel2start
        
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
        
            filterWheel2start
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If nChan > 1 Then Call als.dSetEnable(1, 0)
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Sub getInputRangeStep(inp As Integer, range As Integer, step_ As Integer)
    If gPartNumber = 29120 Then
        inp = measInc Mod InputN
        range = (measInc - inp) / InputN Mod nRange
        step_ = (measInc - range * InputN - inp) / (nRange * InputN)
    Else
        If gPartNumber = 29125 Then
            range = measInc Mod nRange
            step_ = (measInc - range) / nRange
        End If
    End If
End Sub

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(5) As Single
    Dim step_ As Integer, range As Integer, inp As Integer
    Dim lastStep As Integer, lastRange As Integer
    Static waitCount As Integer
    
    ' Loop = { step_ { Range {Point} } }
    ' measInc = inp + (range * nPoints + step_) * nRange
    Call getInputRangeStep(inp, range, step_)
    lastRange = range: lastStep = step_
        
    If gPartNumber = 29120 Then
    
        If msrDUT And frmMain.lblDataStats(2).BackColor <> vbGreen And waitCount < 5 Then
            waitCount = waitCount + 1
            GoTo skipNext
        Else
            Debug.Print "waitCount=", waitCount
            waitCount = 0
        End If
    Else
    End If
    
    If msr.getValue(value(), id) Then
    
        'If id = measIn.cm Then Call msr.getValue(value(), id)
        
        Select Case gPartNumber
            Case 29120: frm.send2plot plotDataType.pdALS, value(0), range + 1
            Case 29125: For i = 0 To 2: frm.send2plot plotDataType.pdALS, value(i), i + 1: Next i
        End Select
    
'        If nInput > 1 Then
'            frm.send2plot plotDataType.pdALS, value(0), inp + 1
'        Else
'            frm.send2plot plotDataType.pdALS, value(0), range + 1
'        End If
        
        If id = eMeasure.mCM Then frm.send2plot plotDataType.pdALS, value(1), 2
    
        measInc = measInc + 1
        Call getInputRangeStep(inp, range, step_)
            
        If gPartNumber = 29120 Then
        
            Select Case inp ' RBG
            Case 0: Call als.dSetInputSelect(0, inp)
            Case 1: Call als.dSetInputSelect(0, inp + 1)
            Case 2: Call als.dSetInputSelect(0, inp - 1)
            End Select
        
        End If
        
        
        If measInc < nMeas Then
            If range <> lastRange Then Call als.dSetRange(0, range)
            If step_ <> lastStep Then fltr.setFwIndex fwIdx(step_): Sleep 500
            If gPartNumber = 29125 Then frmRGBscan.resetStack
        End If
        
    End If
    
    next_ = measInc / nMeas
    
skipNext:

End Function

