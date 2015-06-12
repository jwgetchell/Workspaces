VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestTaosXfer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim fltr As ucMonochromator
Dim msg As frmPrompt

Dim src As clsIloop
Dim msr As ucALSusb

Dim etio As frmEtIo
Dim eep As frmEEprom

Dim measInc As Integer
Dim testInProgress As Boolean
Dim als As ucALSusb

Const debugPrint_ As Boolean = True

Const nMeas As Integer = 9 * 4
Dim fwIdx(nMeas - 1) As Integer

Public Interval As Integer

Private Sub Class_Initialize()

    Dim i As Integer

    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set als = frmMain.ucALSusb1
    
    Set fltr = frmMonochromator.ucMonochromator1
    
    Set msr = frm.ucALSusb1
    
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Interval = 1000
    
    For i = 0 To 5: fwIdx(i) = i: Next i
    fwIdx(i) = 7: i = i + 1
    fwIdx(i) = 12: i = i + 1
    fwIdx(i) = 22: i = i + 1
    
End Sub

Public Sub arm()

    Dim i As Integer
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        For i = 0 To 3
        
            plt.setPlotSize plotDataType.pdALS, nMeas / 2, i + 1
            plt.ucPlot1(i).XaxisDataMin = 0
            plt.ucPlot1(i).XaxisDataMax = nMeas / 2
            plt.ucPlot1(i).XaxisLabel = "meas#"
        
        Next i
        
        measInc = 0
        fltr.setFwIndex fwIdx(measInc)
        msr.dSetRange 0, 0
        msr.dWriteI2cWord &H72, &H1, &HC0 ' ATIME: 0xDB,0xC0; 101,174ms; 37888,65535
        
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

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer
    Dim c0 As Long, c1 As Long
    
    i = measInc Mod 4
    
    msr.dReadI2cWord &H72, &H14, c0
    msr.dReadI2cWord &H72, &H16, c1
    
    frm.send2plot plotDataType.pdALS, c0, i + 1
    frm.send2plot plotDataType.pdALS, c1, i + 1

    measInc = measInc + 1: i = measInc Mod 4
    
    If measInc < nMeas Then
        msr.dSetRange 0, i
        If i = 0 Then fltr.setFwIndex fwIdx(measInc / 4)
    End If
        
    next_ = measInc / nMeas

End Function



