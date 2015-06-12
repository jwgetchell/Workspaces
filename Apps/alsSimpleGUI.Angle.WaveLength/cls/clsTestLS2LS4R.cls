VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestLS2LS4R"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim fltr As ucMonochromator
Dim qth As ucThorlabsAPT
Dim als As ucALSusb
Dim et As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Dim lastIRstate As Boolean

Const nMeas As Integer = 20
Dim LoFilterIndex As Integer
Dim LoMidIndex As Integer

Const debugPrint_ As Boolean = True

Dim testCompSetup(nMeas - 1) As tTestComp

Public Interval As Integer

Enum testM4

    LedHi
    IRledHi
        IrlHi
        IrqHi
    QthHi
        
    QthMedHi
        IrqMedHi
        IrlMedHi
    LedMedHi
    IRledMedHi
        
    LedMedLo
    IRledMedLo
        IrlMedLo
        IrqMedLo
    QthMedLo
        
    QthLo
        IrqLo
        IrlLo
    LedLo
    IRledLo
    
End Enum

Private Sub testCompLast(measInc As Integer)
    ' stays the same as last
    testCompSetup(measInc).led = testCompSetup(measInc - 1).led
    testCompSetup(measInc).qth = testCompSetup(measInc - 1).qth
    testCompSetup(measInc).comp = testCompSetup(measInc - 1).comp
    testCompSetup(measInc).rng = testCompSetup(measInc - 1).rng
    testCompSetup(measInc).FW = testCompSetup(measInc - 1).FW
    ' returns to default
    testCompSetup(measInc).irLed = False
    testCompSetup(measInc).alsInp = True
    
End Sub

Private Sub setLedEnable(measInc As Integer, enable As Boolean)
    testCompSetup(measInc).led = enable
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
End Sub

Private Sub Class_Initialize()

    Set frm = frmMain
    Set plt = frmPlot
    Set als = frm.ucALSusb1
    Set et = frmEtIo
    Set fltr = frmMonochromator.ucMonochromator1
    
    Interval = 3000
    LoFilterIndex = 10
    LoMidIndex = 2

    ' tTestComp sets: FW,led,irLed,qth, comp(38 only), rng & alsInp
    
    measInc = testM4.LedHi
    testCompSetup(measInc).FW = 0
    Call setLedEnable(measInc, True)
    testCompSetup(measInc).irLed = False
    testCompSetup(measInc).rng = 3
    testCompSetup(measInc).alsInp = True

    measInc = testM4.IRledHi: testCompLast measInc
    testCompSetup(measInc).irLed = True
    
    measInc = testM4.IrlHi: testCompLast measInc
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.IrqHi: testCompLast measInc
    testCompSetup(measInc).alsInp = False
    Call setLedEnable(measInc, False)
    
    measInc = testM4.QthHi: testCompLast measInc

    '========
    
    measInc = testM4.QthMedHi: testCompLast measInc
    testCompSetup(measInc).rng = 2
    Call setLedEnable(measInc, False)

    measInc = testM4.IrqMedHi: testCompLast measInc
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.IrlMedHi: testCompLast measInc
    Call setLedEnable(measInc, True)
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.LedMedHi: testCompLast measInc

    measInc = testM4.IRledMedHi: testCompLast measInc
    testCompSetup(measInc).irLed = True

    '========
    
    measInc = testM4.LedMedLo: testCompLast measInc
    testCompSetup(measInc).FW = LoMidIndex
    testCompSetup(measInc).rng = 1

    measInc = testM4.IRledMedLo: testCompLast measInc
    testCompSetup(measInc).irLed = True
    
    measInc = testM4.IrlMedLo: testCompLast measInc
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.IrqMedLo: testCompLast measInc
    Call setLedEnable(measInc, False)
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.QthMedLo: testCompLast measInc

    '========

    measInc = testM4.QthLo: testCompLast measInc
    testCompSetup(measInc).rng = 0
    Call setLedEnable(measInc, False)
    testCompSetup(measInc).FW = LoFilterIndex

    measInc = testM4.IrqLo: testCompLast measInc
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.IrlLo: testCompLast measInc
    Call setLedEnable(measInc, True)
    testCompSetup(measInc).alsInp = False
    
    measInc = testM4.LedLo: testCompLast measInc

    measInc = testM4.IRledLo: testCompLast measInc
    testCompSetup(measInc).irLed = True
    
End Sub

Sub IRledEnable(on_ As Boolean)
    Dim manualMirror As Boolean: manualMirror = False
    
    If on_ Then
        If manualMirror Then MsgBox ("Insert Mirror")
        Call et.setLedEnable(5, True)
    Else
        If manualMirror Then MsgBox ("Remove Mirror")
        Call et.setLedEnable(5, False)
    End If
    
End Sub

Sub ledEnable(on_ As Boolean)
    
    If on_ Then
        Call et.setLedEnable(7, True)
    Else
        Call et.setLedEnable(7, False)
    End If
    
End Sub

Sub qthEnable(on_ As Boolean)
    
    et.shutterClosed on_

End Sub

Sub setup(value As Integer)
    fltr.setFwIndex testCompSetup(value).FW
    ledEnable testCompSetup(value).led
    qthEnable testCompSetup(value).qth
    IRledEnable testCompSetup(value).irLed
    
    If testCompSetup(value).alsInp Then
        als.dSetInputSelect 0, 0 ' als
        als.dSetRange 0, testCompSetup(value).rng
    Else
        als.dSetInputSelect 0, 1 ' als
        als.dSetRange 0, 3 ' JWG hardcoded for now (should m
    End If
    
    If debugPrint_ Then
        Call dpNoCr: debugPrint value
        Call dpNoCr: Call debugPrint("FW=", testCompSetup(value).FW)
        Call dpNoCr: Call debugPrint("LED=", testCompSetup(value).led)
        Call dpNoCr: Call debugPrint("QTH=", testCompSetup(value).qth)
        Call dpNoCr: Call debugPrint("IR=", testCompSetup(value).irLed)
    End If
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        frm.tmrPlot.enabled = False
        setPlotSize nMeas
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
        testInProgress = True
    
        measInc = 0
        setup measInc
        IRledEnable False
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

    Static Count As Integer
    
    If frm.lblDataStats(2).BackColor = vbGreen Or Count > 3 Then
    
        testCompSetup(measInc).als = frm.meanLux
    
        frm.send2plot pdALS, frm.meanLux
        
        If debugPrint_ Then debugPrint "ALS=", format(frm.meanLux, "###.0")
        
        measInc = measInc + 1
        
        If Not done Then setup measInc
        
        Count = 0
    Else
    
        Count = Count + 1
    
    End If

End Sub

Public Function next_(Optional idx As Integer = -1) As Single
    
    simpleMeas
    
    next_ = measInc / nMeas
    
End Function


