VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestSpectralAngle"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim mct As ucMonochromator
Dim etio As frmEtIo
Dim eep As frmEEprom

Dim src As clsIloop
Dim msr As clsIloop
Dim apt As ucThorlabsAPT

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer, tMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single
Dim startA_, stopA_, stepA_ As Single

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set mct = frmMonochromator.ucMonochromator1
    Set apt = frmThorlabsAPT.ucThorlabsAPT1(0)
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Set src = frmTest.pSource
    Set msr = frmTest.pMeasure
    
    Interval = 500
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        start_ = mct.getStart
        stop_ = mct.getStop
        step_ = mct.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        startA_ = apt.getStart
        stopA_ = apt.getStop
        stepA_ = apt.getStep
        tMeas = ((stopA_ - startA_) / stepA_ + 1) * nMeas
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        plt.ucPlot1(0).XaxisLabel = "nm"
        
        plt.setPlotSize pdIR, nMeas
        plt.ucPlot1(1).XaxisDataMin = start_
        plt.ucPlot1(1).XaxisDataMax = stop_
        plt.ucPlot1(1).XaxisLabel = "nm"
        
        mct.arm
        apt.arm
    
        Sleep 3000
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= tMeas
    
    If done Then
    
        If testInProgress Then
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
            mct.setValue (555)
        
        End If
        
    End If
End Function

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(0) As Single
    
    If Not mct.done Then
    
        msr.getValue value, id
        
        Select Case id
            Case eMeasure.mALS: frm.send2plot plotDataType.pdALS, value(0)
            Case eMeasure.mIR, measIn.prox30_: frm.send2plot plotDataType.pdIR, value(0)
            Case eMeasure.mProx: frm.send2plot plotDataType.pdProx, value(0)
        End Select
    
        measInc = measInc + 1
        
        mct.nextStep
                
    Else
    
        plt.send2excel
        
        If Not apt.done Then
            mct.arm
            apt.next_
        Else
            measInc = tMeas
        End If
    
    End If
    
    next_ = measInc / tMeas

End Function



