VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestProxAR0"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' +______________+
' | Prox AR0     |
' |==============|
' | Prox Offset  |
' |  25%    0    |
' |   -     2    |
' |   -     4    |
' +ŻŻŻŻŻŻŻŻŻŻŻŻŻŻ+

Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
'Dim pg As ucMonochromator
Dim FW As ucMonochromator
Dim als As ucALSusb
Dim etio As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Const nProx As Integer = 9, nFW As Integer = 8

Const nMeas As Integer = nProx * nFW ' delay loop
    
Const quickTest As Boolean = True
Const quickTest2 As Boolean = True

Dim testSetup(nProx - 1) As tTestProxAR
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
    
    Interval = 500
    
    ' IR    .2 .3 .4 .5 .6   .8 .9
    ' FW 35 13  7  5  4  2    1  0
    
    ' delay loop:
        'FW(8): {35,13,7,5,4,2,1,0}
            'prox(3): {10,50,80%}
                ' vih(9): (.78,1.08,1.32,1.48,1.78,2.02,2.08,2.38,2.61}
    
    measInc = 0
    testSetup(measInc).FW = 35
    testSetup(measInc).prox = 0.25 ' JWG 0.1
    testSetup(measInc).vih = 0.77
    testSetup(measInc).off = 0
    
    measInc = measInc + 1 '1
    testSetup(measInc).FW = 13
    testSetup(measInc).prox = 0.5
    If quickTest2 Then testSetup(measInc).prox = 0.25
    testSetup(measInc).vih = 1.04
    testSetup(measInc).off = testSetup(measInc - 1).off
    If quickTest2 Then testSetup(measInc).off = 2
    
    measInc = measInc + 1 '2
    testSetup(measInc).FW = 7
    testSetup(measInc).prox = 0.8
    If quickTest2 Then testSetup(measInc).prox = 0.25
    testSetup(measInc).vih = 1.25
    testSetup(measInc).off = testSetup(measInc - 1).off
    If quickTest2 Then testSetup(measInc).off = 4
    
    measInc = measInc + 1 '3
    testSetup(measInc).FW = 5
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 1.38
    testSetup(measInc).off = 8
    
    measInc = measInc + 1 '4
    testSetup(measInc).FW = 4
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 1.66
    testSetup(measInc).off = testSetup(measInc - 1).off
    
    measInc = measInc + 1 '5
    testSetup(measInc).FW = 2
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 1.9
    testSetup(measInc).off = testSetup(measInc - 1).off
    
    measInc = measInc + 1 '6
    testSetup(measInc).FW = 1
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 1.89
    testSetup(measInc).off = 15
    
    measInc = measInc + 1 '7
    testSetup(measInc).FW = 0
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 2.18
    testSetup(measInc).off = testSetup(measInc - 1).off
    
    measInc = measInc + 1 '8
    testSetup(measInc).prox = testSetup(measInc - 3).prox
    testSetup(measInc).vih = 2.44
    testSetup(measInc).off = testSetup(measInc - 1).off
    
End Sub

Sub setup(ByVal value As Integer)

    Dim fwIdx As Integer, widIdx As Integer, proxIdx As Integer
    
    proxIdx = value Mod nProx: value = (value - proxIdx) / nProx
    fwIdx = value
        
    FW.setFwIndex testSetup(fwIdx).FW
    etio.setProxLevel testSetup(proxIdx).vih
    als.dSetProxOffset testSetup(proxIdx).off
        
    If debugPrint_ Then
        Call dpNoCr: Call debugPrint("FW=" & testSetup(fwIdx).FW)
        Call dpNoCr: Call debugPrint("Vih=" & testSetup(proxIdx).vih)
        Call dpNoCr: Call debugPrint("pOff=" & testSetup(proxIdx).off)
    End If
        
    recordIR = (proxIdx = 0)
        
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        
        If quickTest2 Then
            setPlotSize 32
        Else
            If quickTest Then
                setPlotSize 40
            Else
                setPlotSize nMeas + nFW ' nFW is for IR measurements
            End If
        End If
        
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        measInc = 0
        setup measInc
        'timerInterval = frm.tmrAR.Interval
        'frm.tmrAR.Interval = cTimerInterval
    
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
            
            'frm.tmrAR.Interval = timerInterval
            
        End If
        
    End If
End Function

Sub simpleMeas()
    Static measCount As Integer
    If frm.lblDataStats(6).BackColor = vbGreen Or frm.meanProx = 0 Or measCount > 30 Then
    
        If measInc < 9 And Abs(frm.meanProx - testSetup(measInc Mod nProx).prox) > 0.02 Then
            
            testSetup(measInc).vih = testSetup(measInc).vih - 1# * (frm.measSprox - testSetup(measInc).prox)
            etio.setProxLevel testSetup(measInc).vih
        
        Else
            measCount = 0
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
            ' 10 50 90 10 50 90 10 50 90
            ' 00 01 02 03 04 05 06 07 08
            If quickTest2 Then
                Select Case measInc
                Case 3, 12, 21, 30, 39, 48, 57, 66: measInc = measInc + 6
                'Case 5, 14, 23, 32, 41, 50, 59, 68: measInc = measInc + 2
                'Case 8, 17, 26, 35, 44, 53, 62, 71: measInc = measInc + 1
                End Select
            Else
                If quickTest Then
                    Select Case measInc
                    Case 2, 11, 20, 29, 38, 47, 56, 65: measInc = measInc + 2
                    Case 5, 14, 23, 32, 41, 50, 59, 68: measInc = measInc + 2
                    Case 8, 17, 26, 35, 44, 53, 62, 71: measInc = measInc + 1
                    End Select
                End If
            End If
            
            If Not done Then setup measInc
        End If
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


