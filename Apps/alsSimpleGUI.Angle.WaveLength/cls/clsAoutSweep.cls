VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAoutSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim mct As ucMonochromator
Dim etio As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set mct = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    Interval = 500
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        start_ = mct.getStart
        stop_ = mct.getStop
        step_ = mct.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdAls, nMeas
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        'plt.ucPlot1(i).caption
        plt.ucPlot1(0).XaxisLabel = "nm"
        
        mct.arm
        
        Call mct.setCurrent(0)
        
        Sleep 3000
    
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
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_() As Single
    Dim i As Integer
    Dim volts As Double, amps As Double
    
    If Not mct.done Then
    
        Call mct.readVI(volts, amps)
    
        frm.send2plot pdAls, volts
        
        measInc = measInc + 1
            
        mct.nextStep
            
    Else
    
        measInc = nMeas
        
    End If
    
    nextTest = measInc / nMeas

End Function



