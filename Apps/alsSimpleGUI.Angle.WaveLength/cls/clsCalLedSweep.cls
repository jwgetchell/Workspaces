VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCalLedSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb

Dim ang As ucNPXPS

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
    Set ang = frmThorlabsAPT.pSwp
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    Interval = 200
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        start_ = ang.getStart
        stop_ = ang.getStop
        step_ = ang.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.Enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdAls, nMeas
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        'plt.ucPlot1(i).caption
        plt.ucPlot1(0).XaxisLabel = "deg"
        
        'als.dSetIRcomp (31) ' JWG remove!!!!
        
        ang.arm
        
        Sleep 500
    
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
            frm.tmrPlot.Enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_() As Single
    Dim i As Integer
    Static testInProgress As Boolean
    
    If Not ang.done Or testInProgress Then
    
        If frm.measLuxValid Then
        
            frm.send2plot pdAls, frm.measLux
            
            frm.measLuxValid = False
            
            If Not ang.done Then
            
                measInc = measInc + 1
                
                ang.next_ 'Step
                
                testInProgress = True
                
            Else
                testInProgress = False
            End If
            
        End If
        
    Else
        
        measInc = nMeas
        
    End If
    
    next_ = measInc / nMeas

End Function



