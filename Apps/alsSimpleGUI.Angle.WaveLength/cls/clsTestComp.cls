VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestComp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim led As ucMonochromator
Dim qth As ucThorlabsAPT
Dim als As ucALSusb
Dim et As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Const nMeas As Integer = 6
Const debugPrint_ As Boolean = True
Const useShutter As Boolean = True
Const paletteCard As Boolean = True

Dim testCompSetup(5) As tTestComp

Public Interval As Integer

Enum testN
    LedLo
    LedHi
    QthLo
    QthHi
    QthCalc
    LedCalc
    ErrorNone
    ErrorComp
End Enum

'Names
Dim RangeN As Long
Dim InputN As Long
Dim Comp35en As Long

Dim msr As clsIloop

Private Sub Class_Initialize()

    Const minTestComp As Integer = 0
    Dim maxTestComp As Integer
    
    ' read Name values from Excel
    maxTestComp = modDSP.getExcelName("DeltaComp")
    RangeN = modDSP.getExcelName("RangeN")
    InputN = modDSP.getExcelName("inputN")
    Comp35en = modDSP.getExcelName("Comp35en")

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set led = frmMonochromator.ucMonochromator1 ' DPS
    Set qth = frmThorlabsAPT.ucThorlabsAPT1(0) ' MTS50
    Set als = frm.ucALSusb1
    Set et = frmEtIo
    
    Set msr = frmTest.pMeasure
    
    Interval = 3000
    
    measInc = testN.LedLo
    testCompSetup(measInc).led = True
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).comp = minTestComp

    measInc = testN.LedHi
    testCompSetup(measInc).led = testCompSetup(measInc - 1).led
    testCompSetup(measInc).qth = testCompSetup(measInc - 1).qth
    testCompSetup(measInc).comp = maxTestComp

    measInc = testN.QthLo
    testCompSetup(measInc).led = False
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    testCompSetup(measInc).comp = minTestComp

    measInc = testN.QthHi
    testCompSetup(measInc).led = testCompSetup(measInc - 1).led
    testCompSetup(measInc).qth = testCompSetup(measInc - 1).qth
    testCompSetup(measInc).comp = maxTestComp

    measInc = testN.QthCalc
    testCompSetup(measInc).led = testCompSetup(measInc - 1).led
    testCompSetup(measInc).qth = testCompSetup(measInc - 1).qth

    measInc = testN.LedCalc
    testCompSetup(measInc).led = True
    testCompSetup(measInc).qth = Not testCompSetup(measInc).led
    'testCompSetup(measInc).comp = 0

    'led.setVolts 2.965
    
End Sub

Sub ledEnable(on_ As Boolean)
    
    If on_ Then
        Call et.setLedEnable(7, True)
    Else
        Call et.setLedEnable(7, False)
    End If
    
End Sub

Sub qthEnable(on_ As Boolean)
    
    If Not useShutter Then
        If on_ Then
            qth.setPosition 0
        Else
            qth.setPosition 30
        End If
    Else
        If paletteCard Then et.shutterClosed on_
    End If

End Sub

Function dSetIRcomp(ByVal value As Long) As Long

    dSetIRcomp = als.dSetIRcomp(value)
    
    If dSetIRcomp > 0 And Comp35en > 0 Then ' not a `38, use `34/35 test mode
        If value > 0 Then
            Call als.dWriteField(&HE, &H0, &HFF, &H89) ' access test mode
            Call als.dWriteField(&H8, &H0, &HFF, &H0) '  enable compensation
            Call als.dWriteField(&HE, &H0, &HFF, &H38) ' disable test mode
        Else
            Call als.dWriteField(&HE, &H0, &HFF, &H89) ' access test mode
            Call als.dWriteField(&H8, &H0, &HFF, &H80) ' disable compensation
            Call als.dWriteField(&HE, &H0, &HFF, &H38) ' disable test mode
        End If
    End If
    
End Function

Sub setup(value As Integer)
    dSetIRcomp testCompSetup(value).comp
    ledEnable testCompSetup(value).led
    qthEnable testCompSetup(value).qth
    If debugPrint_ Then
        Call dpNoCr: debugPrint value
        Call dpNoCr: Call debugPrint("comp=", testCompSetup(value).comp)
        Call dpNoCr: Call debugPrint("LED=", testCompSetup(value).led)
        Call dpNoCr: Call debugPrint("QTH=", testCompSetup(value).qth)
    End If
End Sub

Public Sub arm()
    
    If Not testInProgress Then
        frm.tmrPlot.enabled = False
        setPlotSize nMeas + 4
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
        testInProgress = True
    
        measInc = 0
        setup measInc
    End If
    
    Call als.dSetRange(0, RangeN)
    Call als.dSetInputSelect(0, InputN)
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    On Error GoTo endFunction
    
    If done Then
    
        If testInProgress Then
    
            error = testCompSetup(testN.QthCalc).comp
            frm.send2plot pdALS, error
            If debugPrint_ Then debugPrint "comp value=" & error
            
            f38.readRevOption
                    
            error = (f38.alsCompMin + testCompSetup(testN.QthCalc).comp / 31# * (f38.alsCompMax - f38.alsCompMin)) / 100#
            frm.send2plot pdALS, error
            If debugPrint_ Then debugPrint "comp value(%)=" & format(error, "##.0")
        
            error = testCompSetup(testN.QthLo).als / testCompSetup(testN.LedLo).als - 1
            frm.send2plot pdALS, error
            If debugPrint_ Then debugPrint "pre-comp error=" & format(error * 100, "##.0")
        
            error = testCompSetup(testN.QthCalc).als / testCompSetup(testN.LedCalc).als - 1
            frm.send2plot pdALS, error
            If debugPrint_ Then debugPrint "post-comp error=" & format(error * 100, "##.0")
        
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            et.setQthPledEnable True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
endFunction: End Function

Sub simpleMeas(Optional id As Integer = eMeasure.mRBG)
    Dim value(5) As Single

    If gPartNumber = 29125 Then
        msr.getValue value, id
        testCompSetup(measInc).als = value(1)
        frm.send2plot pdALS, testCompSetup(measInc).als
        measInc = measInc + 1
        If Not done Then setup measInc
    Else
        If frm.lblDataStats(2).BackColor = vbGreen Then
        
            testCompSetup(measInc).als = frm.meanLux
        
            frm.send2plot pdALS, testCompSetup(measInc).als
            
            If debugPrint_ Then
                debugPrint "ALS=", format(frm.meanLux, "###.0")
            End If
            
            measInc = measInc + 1
            If Not done Then setup measInc
        End If
    End If
End Sub

Sub calulateComp()
    On Error GoTo subExit
    Dim mLed As Double, mQth As Double, comp As Double
    
    mLed = testCompSetup(testN.LedLo).als - testCompSetup(testN.LedHi).als
    mLed = mLed / (testCompSetup(testN.LedLo).comp - testCompSetup(testN.LedHi).comp)
    
    mQth = testCompSetup(testN.QthLo).als - testCompSetup(testN.QthHi).als
    mQth = mQth / (testCompSetup(testN.QthLo).comp - testCompSetup(testN.QthHi).comp)
    
    comp = testCompSetup(testN.LedLo).als - testCompSetup(testN.QthLo).als
    comp = comp / (mQth - mLed)
    
    testCompSetup(testN.QthCalc).comp = comp
    testCompSetup(testN.LedCalc).comp = comp
subExit:
End Sub

Public Function next_(Optional dummy)
    
    Select Case measInc
    Case testN.LedLo To testN.LedCalc: simpleMeas
    Case Else: measInc = measInc + 1
    End Select
    
    If measInc = testN.QthHi + 1 Then
        calulateComp
        
        If testCompSetup(testN.QthCalc).comp > 63 Then
            dSetIRcomp 63
        Else
            If testCompSetup(testN.QthCalc).comp < 0 Then
                dSetIRcomp 0
            Else
                dSetIRcomp testCompSetup(testN.QthCalc).comp
            End If
        End If
        
    End If
    
    next_ = measInc / nMeas
    
End Function

