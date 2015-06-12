VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestProxARvsDelay"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim pg As ucMonochromator
Dim FW As ucMonochromator
Dim als As ucALSusb

Dim measInc As Integer
Dim testInProgress As Boolean
Dim lastProx As Integer

Const debugPrint_ As Boolean = True

Const irdrDelayTest As Boolean = True
Const nProx As Integer = 3, nFW As Integer = 8, nWid As Integer = 7

Const nMeas As Integer = nProx * nFW * nWid ' delay loop
Dim testProxARSetup(nFW - 1) As tTestProxAR
Dim recordIR As Boolean

Dim timerInterval As Integer
Const cTimerInterval As Integer = 450

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set pg = frmMonochromator.ucMonochromator1
    Set FW = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    
    ' IR .2 .3 .4 .5 .6 .9
    ' FW 13  7  5  4  2  1
    
    ' delay loop:
        'prox(3): {10,50,80%}
            'FW(8): {35,13,7,5,4,2,1,0}
                ' wid(7): (1,2,4,6,8,10,12}
    
    If irdrDelayTest Then
    
        measInc = 0
        testProxARSetup(measInc).FW = 35
        testProxARSetup(measInc).wid = 1
        testProxARSetup(measInc).prox = 0.1
    
        measInc = 1
        testProxARSetup(measInc).FW = 13
        testProxARSetup(measInc).wid = 2
        testProxARSetup(measInc).prox = 0.5
    
        measInc = 2
        testProxARSetup(measInc).FW = 7
        testProxARSetup(measInc).wid = 4
        testProxARSetup(measInc).prox = 0.8
    
        measInc = 3
        testProxARSetup(measInc).FW = 5
        testProxARSetup(measInc).wid = 6
        testProxARSetup(measInc).prox = testProxARSetup(measInc - 1).prox
    
        measInc = 4
        testProxARSetup(measInc).FW = 4
        testProxARSetup(measInc).wid = 8
        testProxARSetup(measInc).prox = testProxARSetup(measInc - 1).prox
    
        measInc = 5
        testProxARSetup(measInc).FW = 2
        testProxARSetup(measInc).wid = 10
        testProxARSetup(measInc).prox = testProxARSetup(measInc - 1).prox
    
        measInc = 6
        testProxARSetup(measInc).FW = 1
        testProxARSetup(measInc).wid = 12
        testProxARSetup(measInc).prox = testProxARSetup(measInc - 1).prox

        measInc = 7
        testProxARSetup(measInc).FW = 0
        testProxARSetup(measInc).wid = testProxARSetup(measInc - 1).wid
        testProxARSetup(measInc).prox = testProxARSetup(measInc - 1).prox

    Else
    End If
    
End Sub

Sub setup(ByVal value As Integer)

    Dim fwIdx As Integer, widIdx As Integer, proxIdx As Integer
    
    If irdrDelayTest Then
    
        widIdx = value Mod nWid: value = (value - widIdx) / nWid
        fwIdx = value Mod nFW: value = (value - fwIdx) / nFW
        proxIdx = value
        
        FW.setFwIndex (testProxARSetup(fwIdx).FW)
        pg.setPgWid (testProxARSetup(widIdx).wid)
        
        If debugPrint_ Then
            Call dpNoCr: Call debugPrint("FW=" & testProxARSetup(fwIdx).FW)
            Call dpNoCr: Call debugPrint("Delay=" & testProxARSetup(widIdx).wid)
        End If
        
        If lastProx <> proxIdx Then
            msg.message ("Adjust Prox Value to " & testProxARSetup(proxIdx).prox * 100 & "%")
            lastProx = proxIdx
        End If
        
        If proxIdx = 0 And widIdx = 0 Then
            recordIR = True
        End If
        
    Else
    End If
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        setPlotSize nMeas + nFW
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        If irdrDelayTest Then
            measInc = 0
            lastProx = -1
            setup measInc
            timerInterval = frm.tmrAR.Interval
            frm.tmrAR.Interval = cTimerInterval
        Else
            frmMonochromator.ucMonochromator1.setFwIndex (35)
        End If
    
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
            
            frm.tmrAR.Interval = timerInterval
            
        End If
        
    End If
End Function

Sub simpleMeas()
    
    If frm.lblDataStats(6).BackColor = vbGreen Then
    
        If recordIR Then frm.send2plot pdProx, frm.measIR
        frm.send2plot pdProx, frm.meanProx
        
        If debugPrint_ Then
            Call debugPrint("Prox=", format(frm.meanProx, "###.000"))
            If recordIR Then
                Call debugPrint("IR=", format(frm.measIR, "###.000"))
            Else
                debugPrint
            End If
        End If
        
        If recordIR Then recordIR = False
        
        measInc = measInc + 1
        If Not done Then setup measInc
    End If

End Sub

Public Sub next_()
    If testInProgress Then simpleMeas
End Sub

