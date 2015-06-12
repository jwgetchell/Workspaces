VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestPrxArCEC"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' +_________________+
' | PrxArCEC        |
' |=================|
' | Prox  IRDR      |
' |  80%    0 (Max) |
' |  40%    1       |
' |  20%    2       |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Dim frm As frmMain
Dim plt As frmPlot
Dim msg As frmPrompt
Dim FW As ucMonochromator
Dim als As ucALSusb

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Const nFW As Integer = 8
Dim nProx As Long
Dim nMeas As Integer
    
Dim testSetup(nFW - 1) As tTestProxAR
Dim recordIR As Boolean

Dim timerInterval As Integer
Public Interval As Integer

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set FW = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    
    als.dGetNirdr (nProx): nProx = 2
    nMeas = nProx * nFW
    
    Interval = 1000
    
    ' IR    .2 .3 .4 .5 .6   .8 .9
    ' FW 35 13  7  5  4  2    1  0
    
    ' delay loop:
        'FW(8): {35,13,7,5,4,2,1,0}
            'prox(3): {80,40,20%}
    
    measInc = 0
    testSetup(measInc).FW = 35
    testSetup(measInc).irdr = nProx - 1
    
    measInc = measInc + 1 '1
    testSetup(measInc).FW = 13
    testSetup(measInc).irdr = nProx - 2
    
    measInc = measInc + 1 '2
    testSetup(measInc).FW = 7
    testSetup(measInc).irdr = nProx - 3
    
    measInc = measInc + 1 '3
    testSetup(measInc).FW = 5
    testSetup(measInc).irdr = nProx - 4
    
    measInc = measInc + 1 '4
    testSetup(measInc).FW = 4
    
    measInc = measInc + 1 '5
    testSetup(measInc).FW = 2
    
    measInc = measInc + 1 '6
    testSetup(measInc).FW = 1
    
    measInc = measInc + 1 '7
    testSetup(measInc).FW = 0

End Sub

Sub setup(ByVal value As Integer)

    Dim fwIdx As Integer, irdr As Long, proxIdx As Integer
    
    proxIdx = value Mod nProx: value = (value - proxIdx) / nProx
    fwIdx = value
        
    FW.setFwIndex testSetup(fwIdx).FW
    irdr = testSetup(proxIdx).irdr
    als.dSetIrdr irdr
        
    If debugPrint_ Then
        Call dpNoCr: Call debugPrint("FW=" & testSetup(fwIdx).FW)
        Call dpNoCr: Call debugPrint("IRDR=" & irdr)
    End If
        
    recordIR = (proxIdx = 0)
        
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        
        setPlotSize nMeas + nFW ' nFW is for IR measurements
        
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        measInc = 0
        setup measInc
    
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

Sub simpleMeas()
    Static measCount As Integer
    If frm.lblDataStats(6).BackColor = vbGreen Or frm.meanProx = 0 Or measCount > 30 Then
    
        measCount = 0
        If recordIR Then frm.send2plot pdProx, frm.measIR
        frm.send2plot pdProx, frm.meanProx
        
        If debugPrint_ Then
            Call dpNoCr: Call debugPrint("Prox=", format(frm.meanProx, "###.000"))
            If recordIR Then
                Call debugPrint("IR=", format(frm.measIR, "###.000"))
            Else
                debugPrint
            End If
        End If
        
        If recordIR Then recordIR = False
        
        measInc = measInc + 1
        
        If Not done Then setup measInc
            
    Else
        measCount = measCount + 1
    End If

End Sub

Public Function next_()
    If testInProgress Then
        simpleMeas
        next_ = measInc / nMeas
    End If
End Function


