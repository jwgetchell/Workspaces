VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsProxXtalk177"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim apt As ucThorlabsAPT
Dim etio As frmEtIo
Dim tst As frmTest

Dim measInc As Integer

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Const maxValue = 12.29

Public Interval As Integer

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set apt = frmThorlabsAPT.ucThorlabsAPT1(0)
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set tst = frmTest
    
    ' read Name values from Excel
    PswpStart = modDSP.getExcelName("PswpStart")
    PswpStop = modDSP.getExcelName("PswpStop")
    PswpStep = modDSP.getExcelName("PswpStep")
    
    Interval = 100
    
End Sub

Public Sub arm()

    Dim i As Integer
    Dim nRng As Long, nChn As Long
    
    'If Not testInProgress Then
    
        als.dSetEnable 1, 1
        measInc = 0
        als.dSetIrdr measInc
        frm.cb177CmpPrxOff(1).value = vbChecked: frm.cb177CmpPrxOff_Click 1
        
        nMeas = 8
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize plotDataType.pdALS, nMeas
        plt.ucPlot1(i).XaxisDataMin = 0
        plt.ucPlot1(i).XaxisDataMax = nMeas - 1
        plt.ucPlot1(i).XaxisLabel = "IRDR"
        
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
    
    'End If
    
End Sub

Function getValue() As Double
    getValue = Mid(frm.cb177CmpPrxOff(1).caption, 8, Len(frm.cb177CmpPrxOff(1).caption))
End Function

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            als.dSetEnable 1, 0
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_(Optional idx As Integer = -1) As Single
    Dim i As Long, param As Long, value As Double
    
    value = getValue
    frm.send2plot plotDataType.pdALS, value
    
    measInc = measInc + 1
    
    If Not done Then
        If value < maxValue Then
            als.dSetIrdr measInc
            Sleep 25: frmMain.cb177CmpPrxOff(1).value = vbChecked: DoEvents
            frm.cb177CmpPrxOff_Click 1
        Else
            For measInc = measInc To nMeas
                frm.send2plot plotDataType.pdALS, value
            Next measInc
        End If
    Else
    End If
   
    next_ = measInc / nMeas

End Function

