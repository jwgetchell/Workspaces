VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestLS2LS"
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
Dim tst As frmTest

Dim measInc As Integer
Dim testInProgress As Boolean

Dim lastIRstate As Boolean

Const nMeas As Integer = 5

Const debugPrint_ As Boolean = True

Dim testCompSetup(nMeas - 1) As tTestComp

Public Interval As Integer

Dim singleDUT As Boolean

Enum testM
    LedHi
    QthHi
    QthLo
    LedLo
    IRledLo
End Enum

'Names
Dim RangeN As Long
Dim InputN As Long
Dim LoFilterIndex As Long

Private Sub Class_Initialize()

    ' read Name values from Excel
    RangeN = modDSP.getExcelName("RangeN")
    InputN = modDSP.getExcelName("InputN")
    LoFilterIndex = modDSP.getExcelName("LoFilterIndex")
    
    If LoFilterIndex = 0 Then LoFilterIndex = 10

    Set frm = frmMain
    Set plt = frmPlot
    Set als = frm.ucALSusb1
    Set et = frmEtIo
    Set fltr = frmMonochromator.ucMonochromator1
    Set tst = frmTest
    
    Interval = 3000
    
    measInc = testM.LedHi
    testCompSetup(measInc).led = True
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).rng = 1
    testCompSetup(measInc).FW = 0

    measInc = testM.QthHi
    testCompSetup(measInc).led = False
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).rng = testCompSetup(measInc - 1).rng
    testCompSetup(measInc).FW = testCompSetup(measInc - 1).FW



    measInc = testM.QthLo
    testCompSetup(measInc).led = False
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).rng = 0
    testCompSetup(measInc).FW = LoFilterIndex

    measInc = testM.LedLo
    testCompSetup(measInc).led = True
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).rng = testCompSetup(measInc - 1).rng
    testCompSetup(measInc).FW = testCompSetup(measInc - 1).FW

    measInc = testM.IRledLo
    testCompSetup(measInc).irLed = True
    testCompSetup(measInc).led = testCompSetup(measInc - 1).led
    testCompSetup(measInc).qth = testCompSetup(measInc - 1).qth
    testCompSetup(measInc).rng = testCompSetup(measInc - 1).rng
    testCompSetup(measInc).FW = testCompSetup(measInc - 1).FW

    
End Sub

Sub IRledEnable(on_ As Boolean)
    Dim manualMirror As Boolean: manualMirror = False
    
    'If lastIRstate <> on_ Then
        If on_ Then
        
            If manualMirror Then MsgBox ("Insert Mirror")
            
            Call et.setLEDvolts(5, 5)
            
        Else
            If manualMirror Then MsgBox ("Remove Mirror")
            
            Call et.setLEDvolts(5, 0)
            
        End If
    'End If
    
    'lastIRstate = on_
    
End Sub

Sub ledEnable(on_ As Boolean)
    
    Static lastState As Boolean
    
    If on_ Then
            If singleDUT Then
                fltr.setVolts 5
            Else
                Call et.setLEDvolts(7, 5)
            End If
    Else
            If singleDUT Then
                fltr.setVolts 0
                If lastState Then fltr.setVolts 5
                fltr.setVolts 0
            Else
                Call et.setLEDvolts(7, 0)
            End If
    End If
    
    lastState = on_
    
End Sub

Sub qthEnable(on_ As Boolean)
    
    et.shutterClosed on_

End Sub

Sub setup(value As Integer)
    fltr.setFwIndex testCompSetup(value).FW
    ledEnable testCompSetup(value).led
    qthEnable testCompSetup(value).qth
    IRledEnable testCompSetup(value).irLed
    als.dSetRange 0, testCompSetup(value).rng
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
    
        singleDUT = tst.getSingleDUT
    
        frm.tmrPlot.enabled = False
        setPlotSize nMeas
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
        testInProgress = True
    
        measInc = 0
        setup measInc
        IRledEnable False
    End If
    
    'Call als.dSetRange(0, RangeN)
    'Call als.dSetInputSelect(0, InputN)
    
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
    
    Select Case measInc
    Case testN.LedLo To testN.LedCalc: simpleMeas
    Case Else: measInc = measInc + 1
    End Select
    
    next_ = measInc / nMeas
    
End Function

