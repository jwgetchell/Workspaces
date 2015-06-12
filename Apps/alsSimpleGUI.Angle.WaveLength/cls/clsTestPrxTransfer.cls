VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestPrxTransfer"
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

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_, vled_ As Single

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    Set src = frmTest.pSource
    Set msr = frmTest.pMeasure
    
    Interval = 200
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        start_ = 1.5
        stop_ = 6.5
        step_ = 0.05
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        'plt.ucPlot1(i).caption
        plt.ucPlot1(0).XaxisLabel = "VLED"
        
        Call als.dSetEnable(1, 1)
        
        src_arm
        
        Sleep 500
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
    End If
    
End Sub

Sub setVled(volts As Single)
    Dim vp As Double: vp = volts
    etio.setProxLevel vp
    volts = vp
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        
        If testInProgress Then
    
            Call als.dSetEnable(1, 0)
        
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Sub src_arm()
    vled_ = start_
    setVled vled_
End Sub
Sub src_next()
    If Not src_done Then
        vled_ = vled_ + step_
        setVled vled_
    End If
End Sub
Function src_done() As Boolean
    src_done = vled_ > stop_
End Function

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(0) As Single
    
    If measInc < nMeas Then
    
        If msr.getValue(value, id) Then
            value(0) = Abs(value(0))
            Select Case id
            Case eMeasure.mProx: frm.send2plot plotDataType.pdProx, value(0)
            Case Default: frm.send2plot plotDataType.pdALS, value(0)
            End Select
        
            measInc = measInc + 1
            
            src_next
            
        End If
        
    Else
    
        measInc = nMeas
        
    End If
    
    next_ = measInc / nMeas

End Function



