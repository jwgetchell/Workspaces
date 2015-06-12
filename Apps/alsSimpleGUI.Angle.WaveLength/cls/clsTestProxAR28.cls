VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestProxAR28"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' +______________+
' | Prox AR1     |
' |==============|
' | Prox Offset  |
' |  25%   NA    |
' |  50%   NA    |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
Dim frm As frmMain
Dim plt As frmPlot
'Dim f38 As frm29038
Dim msg As frmPrompt
Dim FW As ucMonochromator
Dim als As ucALSusb
Dim etio As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Const nProx As Integer = 2, nFW As Integer = 18

Const nMeas As Integer = nProx * nFW ' delay loop
    
Dim testSetup(nFW - 1) As tTestProxAR
Dim recordIR As Boolean

Dim timerInterval As Integer
Public Interval As Integer

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set FW = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    Interval = 750
    
    ' IR    .2 .3 .4 .5 .6   .8 .9
    ' FW 35 13  7  5  4  2    1  0
    
    ' delay loop:
        'FW(8): {35,13,7,5,4,2,1,0}
            'prox(2): {25,50%}
                ' vih(2): (.78,1.08}
    
    measInc = 0
    testSetup(measInc).FW = 35
    testSetup(measInc).prox = 0.25 ' JWG 0.1
    testSetup(measInc).vih = 0.87
    
    measInc = measInc + 1 '1
    testSetup(measInc).FW = 24
    testSetup(measInc).prox = 0.5
    testSetup(measInc).vih = 0.96
    
    measInc = measInc + 1: testSetup(measInc).FW = 21
    measInc = measInc + 1: testSetup(measInc).FW = 19
    measInc = measInc + 1: testSetup(measInc).FW = 18
    measInc = measInc + 1: testSetup(measInc).FW = 17
    measInc = measInc + 1: testSetup(measInc).FW = 15 ' adjust IR here
    measInc = measInc + 1: testSetup(measInc).FW = 10
    measInc = measInc + 1: testSetup(measInc).FW = 9
    measInc = measInc + 1: testSetup(measInc).FW = 8
    measInc = measInc + 1: testSetup(measInc).FW = 7
    measInc = measInc + 1: testSetup(measInc).FW = 6
    measInc = measInc + 1: testSetup(measInc).FW = 5
    measInc = measInc + 1: testSetup(measInc).FW = 4
    measInc = measInc + 1: testSetup(measInc).FW = 3
    measInc = measInc + 1: testSetup(measInc).FW = 2
    measInc = measInc + 1: testSetup(measInc).FW = 1
    measInc = measInc + 1: testSetup(measInc).FW = 0
    
End Sub

Sub setup(ByVal value As Integer)

    Dim fwIdx As Integer, widIdx As Integer, proxIdx As Integer
    
    proxIdx = value Mod nProx: value = (value - proxIdx) / nProx
    fwIdx = value
        
    FW.setFwIndex testSetup(fwIdx).FW
    etio.setProxLevel testSetup(proxIdx).vih
    als.dSetProxOffset testSetup(proxIdx).off
        
    If debugPrint_ Then
        Call dpNoCr: debugPrint "FW=" & testSetup(fwIdx).FW
        Call dpNoCr: debugPrint "Vih=" & format(testSetup(proxIdx).vih, "##0.00")
        Call dpNoCr: debugPrint "pOff=" & testSetup(proxIdx).off
    End If
        
    recordIR = (proxIdx = 0)
        
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        
        plt.setProxPlotClampEnable False
        setPlotSize nMeas + 3 * nFW ' nFW is for IR measurements
        
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
    
        If measInc <= (nProx - 1) And Abs(frm.meanProx - testSetup(measInc Mod nProx).prox) > 0.02 Then
            
            testSetup(measInc).vih = testSetup(measInc).vih - 0.5 * (frm.measSprox - testSetup(measInc).prox)
            etio.setProxLevel testSetup(measInc).vih
        
        Else
            measCount = 0
            If recordIR Then
                frm.send2plot pdProx, frm.measIR
                frm.send2plot pdProx, frm.meanLux / 1000#
                frm.send2plot pdProx, FW.getFwLux / 1000#
            End If
            frm.send2plot pdProx, frm.meanProx
            
            If debugPrint_ Then
                Call dpNoCr: Call debugPrint("Prox=", format(frm.meanProx, "###.000"))
                If recordIR Then
                    Call dpNoCr: Call debugPrint("IR=", format(frm.measIR, "###.000"))
                    Call dpNoCr: Call debugPrint("Lux=", format(frm.meanLux, "###.000"))
                    Call debugPrint("FW=", format(FW.getFwLux, "###.000"))
                Else
                    debugPrint
                End If
            End If
            
            If recordIR Then recordIR = False
            
            measInc = measInc + 1
            
            If Not done Then setup measInc
        End If
    Else
        measCount = measCount + 1
    End If

End Sub

Public Function next_(Optional dummy As Integer = 0)
    If testInProgress Then
        simpleMeas
        next_ = measInc / nMeas
    End If
End Function



