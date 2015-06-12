VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestProxOffset"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
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

Dim printVih As Boolean
Dim printIR As Boolean

Const debugPrint_ As Boolean = True

Const nVih As Integer = 4
Const nFW As Integer = 8 ' FW(8): {35,13,7,5,4,2,1,0}
Const nOffset As Integer = 16

Const nSetup = nOffset + (nVih - 1)
Dim testSetup(nSetup - 1) As tTestProxAR

Const nMeas As Integer = nFW * nSetup

Const nPoints As Integer = nMeas + nFW + nVih ' add IR & Vih levels

Dim timerInterval As Integer
Const cTimerInterval As Integer = 500

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set FW = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    measInc = 0: testSetup(measInc).FW = 35: measInc = measInc + 1

    If nFW = 8 Then
        testSetup(measInc).FW = 13: measInc = measInc + 1
        testSetup(measInc).FW = 7: measInc = measInc + 1
        testSetup(measInc).FW = 5: measInc = measInc + 1
        testSetup(measInc).FW = 4: measInc = measInc + 1
        testSetup(measInc).FW = 2: measInc = measInc + 1
        testSetup(measInc).FW = 1: measInc = measInc + 1
        testSetup(measInc).FW = 0: measInc = measInc + 1
    Else
        If nFW = 3 Then
            testSetup(measInc).FW = 7: measInc = measInc + 1
            testSetup(measInc).FW = 0: measInc = measInc + 1
        End If
    End If
    
    measInc = 0: testSetup(measInc).off = measInc
    testSetup(measInc).vih = 1.37
    
        For measInc = 1 To 3
            testSetup(measInc).off = testSetup(measInc - 1).off + 1
            testSetup(measInc).vih = testSetup(measInc - 1).vih
        Next measInc
    
    measInc = 4: testSetup(measInc).off = testSetup(measInc - 1).off + 0
    testSetup(measInc).vih = 1.73
    
        For measInc = 5 To 8
            testSetup(measInc).off = testSetup(measInc - 1).off + 1
            testSetup(measInc).vih = testSetup(measInc - 1).vih
        Next measInc
        
    measInc = 9: testSetup(measInc).off = testSetup(measInc - 1).off + 0
    testSetup(measInc).vih = 2.21
    
        For measInc = 10 To 13
            testSetup(measInc).off = testSetup(measInc - 1).off + 1
            testSetup(measInc).vih = testSetup(measInc - 1).vih
        Next measInc
            
    measInc = 14: testSetup(measInc).off = testSetup(measInc - 1).off + 0
    testSetup(measInc).vih = 2.7
    
        For measInc = 15 To 18
            testSetup(measInc).off = testSetup(measInc - 1).off + 1
            testSetup(measInc).vih = testSetup(measInc - 1).vih
        Next measInc
    
End Sub

Sub setup(ByVal value As Integer)

    Dim fwIdx As Integer
    
    fwIdx = value Mod nSetup
    
    fwIdx = (value - fwIdx) / nSetup
    FW.setFwIndex testSetup(fwIdx).FW
    
    value = value Mod nSetup: If value = 0 Then printIR = True
    
    etio.setProxLevel testSetup(value).vih
    als.dSetProxOffset testSetup(value).off
    
    If value > 0 And fwIdx = 0 Then
        If testSetup(value).vih <> testSetup(value - 1).vih Then printVih = True
    End If
        
    If debugPrint_ Then
        Call dpNoCr: Call debugPrint(format(value, "00") & ":")
        Call dpNoCr: Call debugPrint("Vih=" & testSetup(value).vih)
        Call dpNoCr: Call debugPrint("pOff=" & testSetup(value).off)
    End If
        
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        
        frm.tmrPlot.enabled = False
        setPlotSize nPoints
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        measInc = 0
        setup measInc
        timerInterval = frm.tmrProxOffset.Interval
        frm.tmrProxOffset.Interval = cTimerInterval
    
        testInProgress = True
        
        printVih = True
    
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
            
            frm.tmrProxOffset.Interval = timerInterval
            
        End If
        
    End If
End Function

Sub simpleMeas()
    
    If frm.lblDataStats(6).BackColor = vbGreen Then
    
    
        If printIR Then frm.send2plot pdProx, frm.measIR: printIR = False
        If printVih Then frm.send2plot pdProx, testSetup(measInc Mod (nSetup - 1)).vih: printVih = False
        
        frm.send2plot pdProx, frm.meanProx
            
        If debugPrint_ Then
            debugPrint "Prox=", format(frm.meanProx, "###.000")
        End If
        
        measInc = measInc + 1
        
        If Not done Then setup measInc
    
    End If

End Sub

Public Sub next_()
    If testInProgress Then simpleMeas
End Sub

