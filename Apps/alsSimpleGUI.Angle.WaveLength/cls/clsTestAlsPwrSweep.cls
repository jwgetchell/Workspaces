VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestAlsPwrSweep"
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
Dim nRange As Long

Dim etio As frmEtIo
Dim eep As frmEEprom

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nSteps As Integer
Dim fwIdx() As Integer
Dim nPoints As Integer

Public Interval As Integer

'Names
Dim comp38 As Long

Private Sub Class_Initialize()

    Dim i As Integer
    
    ' read Name values from Excel
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
         If nRange > 2 Then Call als.dSetIRcomp(19)
    Else
        nRange = 1
    End If
    
    Interval = 1000
    
    nPoints = 2 ^ 0 ' enable FFT
    nSteps = 25: ReDim fwIdx(nSteps - 1) As Integer
    nMeas = nSteps * nPoints
    nMeas = nMeas * nRange
    
    For i = 0 To nSteps - 1
        Select Case i
        Case 13 To nSteps - 1
            fwIdx(i) = i + 1
        Case Else
            fwIdx(i) = i
        End Select
    Next i

End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        
        For i = 0 To 3
        
            plt.setPlotSize plotDataType.pdALS, nSteps * nPoints, i + 1
            plt.setPlotSize plotDataType.pdProx, nSteps * nPoints, i + 1
            plt.setPlotSize plotDataType.pdIR, nSteps * nPoints, i + 1
            
            plt.ucPlot1(i).XaxisDataMin = 0
            plt.ucPlot1(i).XaxisDataMax = nSteps * nPoints
            plt.ucPlot1(i).XaxisLabel = "meas#"
        
        Next i
        
        measInc = 0
        fltr.setFwIndex fwIdx(measInc)
        
        If msrDUT Then setCompRange
        
        Sleep 3000
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If nChan > 1 Then Call als.dSetEnable(1, 0)
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Sub getPointRangeStep(point As Integer, range As Integer, step_ As Integer)
    point = measInc Mod nPoints
    range = (measInc - point) / nPoints Mod nRange
    step_ = (measInc - range * nPoints - point) / (nRange * nPoints)
End Sub

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(0) As Single
    Dim step_ As Integer, range As Integer, point As Integer
    Dim lastStep As Integer, lastRange As Integer
    Static waitCount As Integer
    
    ' Loop = { step_ { Range {Point} } }
    ' measInc = point + (range * nPoints + step_) * nRange
    Call getPointRangeStep(point, range, step_)
    lastRange = range: lastStep = step_
    
    If msrDUT And frmMain.lblDataStats(2).BackColor <> vbGreen And waitCount < 5 Then
        waitCount = waitCount + 1
        GoTo skipNext
    Else
        Debug.Print "waitCount=", waitCount
        waitCount = 0
    End If
    
    If msr.getValue(value(), id) Then
    
        frm.send2plot plotDataType.pdALS, value(0), range + 1
    
        measInc = measInc + 1
        Call getPointRangeStep(point, range, step_)
        
        If measInc < nMeas Then
            If range <> lastRange Then Call als.dSetRange(0, range)
            If step_ <> lastStep Then fltr.setFwIndex fwIdx(step_): Sleep 500
        End If
        
    End If
    
    next_ = measInc / nMeas
    
skipNext:

End Function

Sub setCompRange()
    Dim c(31) As Long
    Static i As Integer
    
    If i = 0 Then
        c(i) = 11: i = i + 1: c(i) = 12: i = i + 1: c(i) = 13: i = i + 1: c(i) = 10: i = i + 1
        c(i) = 10: i = i + 1: c(i) = 11: i = i + 1: c(i) = 11: i = i + 1: c(i) = 11: i = i + 1
        c(i) = 10: i = i + 1: c(i) = 10: i = i + 1: c(i) = 9: i = i + 1: c(i) = 10: i = i + 1
        c(i) = 12: i = i + 1: c(i) = 9: i = i + 1: c(i) = 9: i = i + 1: c(i) = 10: i = i + 1
        c(i) = 10: i = i + 1: c(i) = 12: i = i + 1: c(i) = 10: i = i + 1: c(i) = 11: i = i + 1
        c(i) = 8: i = i + 1: c(i) = 10: i = i + 1: c(i) = 12: i = i + 1: c(i) = 10: i = i + 1
        c(i) = 12: i = i + 1: c(i) = 12: i = i + 1: c(i) = 11: i = i + 1: c(i) = 11: i = i + 1
        c(i) = 11: i = i + 1: c(i) = 12: i = i + 1: c(i) = 9: i = i + 1: c(i) = 10: i = i + 1
    End If
    
    Call als.dSetRange(0, 0) ' `38:2k
    als.dSetIRcomp comp38 'c(tst.getDnum)
    
End Sub


