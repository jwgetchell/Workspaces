VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRGBleds"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim msg As frmPrompt
Dim als As ucALSusb
Dim etio As frmEtIo
Dim eep As frmEEprom

Dim src As clsIloop
Dim msr As clsIloop

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single

Dim colorN As Integer

'Excel Names
Dim RangeN As Long
Dim comp38 As Long
Dim aryRGBcoeff(8) As Double

Dim xyx2Vrgb(2, 3) As Double
Dim rgbVset() As Double
Dim xyEvCal() As Double
Dim nPoints As Integer
Dim Ev As Double, x As Double, y As Double

Private Sub Class_Initialize()

    Dim drvErr As Long

    ' read Name values from Excel
    RangeN = modDSP.getExcelName("RangeN")
    comp38 = modDSP.getExcelName("comp38")
    
    Set frm = frmMain
    Set plt = frmPlot
    Set msg = frmPrompt
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Set src = frmTest.pSource
    Set msr = frmTest.pMeasure
    
    Interval = 2000
    
    ' spread sheet needs `useRGBCoeff` set to `1`
    ' coefficients saved in named range `aryRGBcoeff`
    If gPartNumber = 29125 Then
        If modDSP.getRGBcoeff(aryRGBcoeff) Then
            If als.dLoadRgbCoeff(aryRGBcoeff) Then MsgBox (als.getError)
        Else
            If als.dClearRgbCoeff Then MsgBox (als.getError)
        End If
    End If
    
    readCalFile

End Sub

Private Sub readCalFile()
    On Error GoTo endSub
    Dim r As Integer, c As Integer
    Dim testProjDir As String: testProjDir = Environ("testProjDir") & "\calFiles\Vset.txt"
    
    Open testProjDir For Input As 1
    
    For r = 0 To 2: For c = 0 To 3
        Input #1, xyx2Vrgb(r, c)
    Next c: Next r
    
    Input #1, nPoints
    
    ReDim rgbVset(nPoints - 1, 2) As Double, xyEvCal(nPoints - 1, 2) As Double
    
    For r = 0 To nPoints - 1: For c = 0 To 2
        Input #1, rgbVset(r, c)
    Next c: Next r
    
    For r = 0 To nPoints - 1: For c = 0 To 2
        Input #1, xyEvCal(r, c)
    Next c: Next r
    
endSub: Close #1: End Sub

Private Sub setRGBfromExy(E As Double, x As Double, y As Double)
    Dim X_ As Double, Y_ As Double, Z_ As Double
    Dim Vr As Double, Vg As Double, Vb As Double
    
    X_ = modCMF.getXYZ(E, x, y, 0)
    Y_ = modCMF.getXYZ(E, x, y, 1)
    Z_ = modCMF.getXYZ(E, x, y, 2)
    
    Vr = xyx2Vrgb(0, 0) * X_ + xyx2Vrgb(0, 1) * Y_ + xyx2Vrgb(0, 2) * Z_ + xyx2Vrgb(0, 3)
    Vg = xyx2Vrgb(1, 0) * X_ + xyx2Vrgb(1, 1) * Y_ + xyx2Vrgb(1, 2) * Z_ + xyx2Vrgb(1, 3)
    Vb = xyx2Vrgb(2, 0) * X_ + xyx2Vrgb(2, 1) * Y_ + xyx2Vrgb(2, 2) * Z_ + xyx2Vrgb(2, 3)
        
    Call etio.setLEDvolts(AER.LED660, Vr)
    Call etio.setLEDvolts(AER.LED525, Vg)
    Call etio.setLEDvolts(AER.LED445, Vb)

End Sub

Private Sub setRGBtestPoint(ByVal point As Integer)

    ' set to point from calibration table
    ' return Ev,x,y calibration values from table
    
    On Error GoTo endSub
    
    If point < 0 Then
        point = 0
    Else
        If point > nPoints - 1 Then point = nPoints - 1
    End If
    
    Call etio.setLEDvolts(AER.LED660, rgbVset(point, 0))
    Call etio.setLEDvolts(AER.LED525, rgbVset(point, 1))
    Call etio.setLEDvolts(AER.LED445, rgbVset(point, 2))
    
    Ev = xyEvCal(point, 2)
    x = xyEvCal(point, 0)
    y = xyEvCal(point, 1)
    
endSub: End Sub

Public Sub arm()

    Dim i As Integer, nRange As Long
    
    If Not testInProgress Then
    
        Call als.dGetPartFamily(gPartFamily)
        
        nMeas = 6 * nPoints: start_ = 0: stop_ = nMeas - 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas, 1
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        plt.ucPlot1(0).XaxisLabel = "meas #"
        
        ' set Range
        als.dGetNrange 0, nRange
        als.dSetRange 0, nRange - RangeN
        als.dSetRange 0, RangeN
        
        'set to RGB
        als.dSetInputSelect 0, 1 ' als
        als.dSetInputSelect 0, 2 ' rgb
        
        ' set Comp
        If gPartNumber = 29125 Then
            als.dSetIRcomp 127 - comp38
        Else
            als.dSetIRcomp 31 - comp38
        End If
        als.dSetIRcomp comp38
                
        Sleep 300
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
        
        setRGBtestPoint 0
    
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

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, dbl As Double, value(5) As Single
    
    msr.getValue value, id
    
    For i = 0 To 2
        frm.send2plot plotDataType.pdALS, value(i)
    Next i
    
    frm.send2plot plotDataType.pdALS, Ev
    frm.send2plot plotDataType.pdALS, x
    frm.send2plot plotDataType.pdALS, y
    
    measInc = measInc + 6
    
    If measInc <= nMeas Then
        setRGBtestPoint measInc / 6
    End If
    
    next_ = measInc / nMeas

End Function



