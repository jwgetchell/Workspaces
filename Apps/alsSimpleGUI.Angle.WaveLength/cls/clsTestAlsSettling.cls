VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestAlsSettling"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim msg As frmPrompt
Dim als As ucALSusb

Dim nMeas As Long
Dim measInc As Integer
Dim testInProgress As Boolean

Dim testProx As Boolean

Const debugPrint_ As Boolean = True

Public Interval As Integer

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set als = frm.ucALSusb1
    
    nMeas = 4096
    Interval = 100
    testProx = True
    
End Sub

Public Sub arm()

    If Not testInProgress Then
    
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas, 1 ' add space for axis value
        plt.setPlotSize pdProx, nMeas, 1 ' add space for axis value
        plt.ucPlot1(0).XaxisDataMin = 0
        plt.ucPlot1(0).XaxisDataMax = Interval * (nMeas - 1)
        plt.ucPlot1(0).XaxisLabel = "meas#"
        
        'plt.selectDevice 0
        plt.ucPlot1(0).setExcelColNumber 0
        plt.ucPlot1(0).setExcelRowNumber 0
        
        measInc = 0
        
        Call als.dSetEnable(0, 1) ' enable ALS
        
        Sleep 0
        
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
            
            Call als.dSetEnable(0, 0) ' disable ALS
        
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_(Optional idx As Integer = -1) As Single

    If testProx Then
        frm.send2plot pdProx, frm.measSprox, 1
        measInc = measInc + 1
    Else
    
        If frmMain.measLuxValid And Not done Then
        
            frm.send2plot pdALS, frm.measLux, 1
            measInc = measInc + 1
            
        End If
    
    End If
        
    next_ = measInc / nMeas

End Function



