VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestWinScan"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim msg As frmPrompt
Dim als As ucALSusb
Dim pX As clsLoopTrans
Dim pY As clsLoopTrans

Dim xIdx As Integer, yIdx As Integer

Dim nMeas As Long
Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Public Interval As Integer

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set als = frm.ucALSusb1
    
    Set pX = frmThorlabsAPT.pAPTx
    Set pY = frmThorlabsAPT.pAPTy
    
    Interval = 100
    
End Sub

Public Sub arm()

    Dim nStep As Integer, start As Single, stop_ As Single, step As Single
    
    If Not testInProgress Then
    
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        start = pY.getStart
        stop_ = pY.getStop
        step = pY.getStep
        
        nStep = (stop_ - start) / step + 1
        
        plt.setPlotSize pdAls, nStep + 1, 1 ' add space for axis value
        plt.ucPlot1(0).XaxisDataMin = start
        plt.ucPlot1(0).XaxisDataMax = stop_
        plt.ucPlot1(0).XaxisLabel = "mm"
        
        plt.selectDevice 0
        plt.ucPlot1(0).setExcelColNumber 0
        plt.ucPlot1(0).setExcelRowNumber 0
        
        ' write axis
        frm.send2plot pdAls, step, 1
        For nMeas = 0 To nStep - 1
            frm.send2plot pdAls, start + nMeas * step, 1
        Next nMeas
        plt.send2Excel
        
        nMeas = (pX.getStop - pX.getStart) / pX.getStep + 1
        nMeas = nMeas * nStep
        
        measInc = 0: xIdx = 0: yIdx = 0
        
        pX.arm
        pY.arm
        
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
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_() As Single
    
    If frmMain.measLuxValid And Not done Then
    
        If yIdx = 0 Then frm.send2plot pdAls, pX.getStart + xIdx * pX.getStep, 1

        frm.send2plot pdAls, frm.measLux, 1
        measInc = measInc + 1
        
        If pY.done Then
            plt.send2Excel
            pY.arm: yIdx = 0
            pX.next_: xIdx = xIdx + 1
        Else
            pY.next_: yIdx = yIdx + 1
        End If
    
    End If
        
    next_ = measInc / nMeas

End Function



