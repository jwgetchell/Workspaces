VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestPwrAngle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb

Dim src As clsIloop
Dim msr As clsIloop

Dim etio As frmEtIo
Dim eep As frmEEprom

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single

Dim nChan As Long


Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    
    Set src = frmTest.pSource
    Set msr = frmTest.pMeasure
    
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Interval = 500
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        start_ = src.getStart
        stop_ = src.getStop
        step_ = src.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize plotDataType.pdALS, nMeas
        plt.setPlotSize plotDataType.pdProx, nMeas
        plt.setPlotSize plotDataType.pdIR, nMeas
        
        For i = 0 To 1
        
            plt.ucPlot1(i).XaxisDataMin = start_
            plt.ucPlot1(i).XaxisDataMax = stop_
            plt.ucPlot1(i).XaxisLabel = "nm"
        
        Next i
        
        src.arm
        
        als.dSetIRcomp 0 '(eep.getCmpVal(plt.getDnum))
        
        Sleep 3000
    
        Call als.dGetNchannel(nChan)
        If nChan > 1 Then Call als.dSetEnable(1, 1)
        
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
            
            If nChan > 1 Then Call als.dSetEnable(1, 0)
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(0) As Single
    
    If Not src.done Then
    
        If msr.getValue(value, id) Then
        
            Select Case id
            Case eMeasure.mProx: frm.send2plot plotDataType.pdProx, value(0)
            Case default: frm.send2plot plotDataType.pdALS, value(0)
            End Select
        
            'frm.send2plot pdALS, value
            
            measInc = measInc + 1
            
            src.next_
            
        End If
        
    Else
    
        measInc = nMeas
        
    End If
    
    next_ = measInc / nMeas

End Function



