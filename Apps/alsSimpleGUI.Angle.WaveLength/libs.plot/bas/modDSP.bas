Attribute VB_Name = "modDSP"

' Tues Jul 30, 2013 - added getFirstTrue
' Wed  Mar  6, 2013 - major RGB updates
' Tues Sep 11, 2012 - added Tan3d
' Mon  Jul  2, 2012 - added lookup1st

Type linData
    start_ As Double
    stop_ As Double
    step_ As Double
    nItems As Integer
End Type

Private calData As linData, angleData As linData, wavelengthData As linData

Private data() As Double, sum() As Double, count() As Integer

Private calcEnabled As Boolean

Public Function calcTick(offset As Double, ByVal c0 As Double, ByVal c1 As Double, ByVal c2 As Double, ByVal c3 As Double) As Integer
    
    ' c0:3 = {4,11,45,90}
    ' returns offset tick value

    Dim range As Integer
    Dim o(3), t(3) As Integer
    
    range = 0
    
    ' #/items removed
    o(0) = 0                     '  0 @  4
    o(1) = Int(31 * c0 / c1) + 1 ' 12 @ 11
    o(2) = Int(31 * c1 / c2) + 1 '  8 @ 45
    o(3) = Int(31 * c2 / c3) + 1 ' 16 @ 90
    
    ' end of range
    t(0) = 31
    t(1) = 31 + t(0) - o(1) + 1
    t(2) = 31 + t(1) - o(2) + 1
    t(3) = 31 + t(2) - o(3) + 1
    
    If offset > 31 * c0 Then
        range = range + 1
        If offset > 31 * c1 Then
            range = range + 1
            If offset > 31 * c2 Then
                range = range + 1
                calcTick = t(range - 1) + offset / c3 - o(range) + 0.5
            Else
                calcTick = t(range - 1) + offset / c2 - o(range) + 0.5
            End If
        Else
            calcTick = t(range - 1) + offset / c1 - o(range) + 0.5
        End If
    Else
        calcTick = offset / c0 + 0.5
    End If
    
End Function

Public Function offsetCount(ByVal i As Integer, ByVal c0 As Double, ByVal c1 As Double, ByVal c2 As Double, ByVal c3 As Double) As Double

    ' c0:3 = {4,11,45,90}
    ' returns value of the index setting from tick value

    Dim range As Integer
    Dim o(3), t(3) As Integer
    
    range = 0
    
    o(0) = 0                     '  0 @  4
    o(1) = Int(31 * c0 / c1) + 1 ' 12 @ 11
    o(2) = Int(31 * c1 / c2) + 1 '  8 @ 45
    o(3) = Int(31 * c2 / c3) + 1 ' 16 @ 90
    
    t(0) = 31
    t(1) = 31 + t(0) - o(1) + 1
    t(2) = 31 + t(1) - o(2) + 1
    t(3) = 31 + t(2) - o(3) + 1
    
    If i > t(range) Then
        range = range + 1
        If i > t(range) Then
            range = range + 1
            If i > t(range) Then
                range = range + 1
                If i > t(range) Then
                    offsetCount = -1#                                    ' overrange
                Else
                    offsetCount = (i - t(range - 1) + o(range) - 1) * c3 ' 90 tick
                End If
            Else
                offsetCount = (i - t(range - 1) + o(range) - 1) * c2     ' 45 tick
            End If
        Else
            offsetCount = (i - t(range - 1) + o(range) - 1) * c1         ' 11 tick
        End If
    Else
        offsetCount = i * c0                                             ' 4 tick
    End If
    
End Function

Public Function findValueIndex(value As Double, data As range) As Integer
    Dim Dsz As Integer: Dsz = UBound(data.Value2, 1)
    Dim i As Integer
    For i = 1 To Dsz
        If data.Value2(i, 1) = value Then
            findValueIndex = i - 1
            i = Dsz
        End If
    Next i
End Function

Public Function getFirstTrue(data As range, valid As range) As Double

    ' Finds the 1st element of valid which is true & returns the corresponding value in data
    ' data:  range of values
    ' valid: range of booleans

    getFirstTrue = 0: On Error GoTo endFunction
    
    Dim Dsz As Integer: Dsz = UBound(data.Value2, 1)
    Dim Vsz As Integer: Vsz = UBound(valid.Value2, 1)
    
    If Dsz <> Vsz Then GoTo endFunction
    
    Dim i As Integer
    
    For i = 1 To Dsz
        If valid.Value2(i, 1) = True Then
            getFirstTrue = data.Value2(i, 1)
            i = Dsz
        End If
    Next i
    
endFunction: End Function

Function inlError(Xin As range, Yin As range, valid As range, lr As range, idx As Integer) As Single

    Dim wf As WorksheetFunction
    Dim m As Single, B As Single
    Dim i As Integer, size As Integer: size = UBound(valid.Value2, 1)
    
    m = lr.Value2(1, 1): B = lr.Value2(2, 1)
    
    
    If valid.Value2(idx, 1) = False Then
        inlError = 0
    Else
        inlError = Xin.Value2(idx, 1) * m + B - Yin.Value2(idx, 1)
    End If
    
End Function

Public Function getBlackBody(ByVal t As Double, ByVal wl As Double) As Double
    ' T: color temperature in K
    ' wl: wavelength in nm
    ' references: http://www.britannica.com/EBchecked/topic/462936/Plancks-radiation-law
    
    Const h As Double = 6.62606957 * 10 ^ -34 ' Planck constant (J-sec)
    Const k As Double = 1.3806488 * 10 ^ -23 ' Boltzmann constant (J/K)
    Const c As Double = 2.99792458 * 10 ^ 8 ' Speed of light (m/sec)
    Const E As Double = 2.718282 ' natural logarithm base
    Const pi As Double = 3.14159
    
    wl = wl * 0.000000001 ' convert to meters
    
    getBlackBody = (8 * pi * h * c / (wl ^ 5)) * (1 / (E ^ (h * c / (wl * k * t)) - 1))
    
End Function

Function checkName(var As String) As Boolean
    Dim names(28) As String, i As Integer, j As Integer: j = UBound(names)
    
    For i = 0 To 7
        names(i) = "LUT_" & i
    Next i
    
    names(i) = "RangeN": i = i + 1
    names(i) = "comp38": i = i + 1
    names(i) = "Ninputs": i = i + 1
    names(i) = "Irdr": i = i + 1
    
    names(i) = "xOffset": i = i + 1
    names(i) = "yOffset": i = i + 1
    
    names(i) = "DeltaComp": i = i + 1
    names(i) = "RangeN": i = i + 1
    names(i) = "inputN": i = i + 1

    names(i) = "PswpStart": i = i + 1
    names(i) = "PswpStop": i = i + 1
    names(i) = "PswpStep": i = i + 1

    names(i) = "Comp35en": i = i + 1

    names(i) = "LoFilterIndex": i = i + 1
    names(i) = "rng0Fw": i = i + 1
    names(i) = "rng1Fw": i = i + 1
    names(i) = "rng2Fw": i = i + 1
    names(i) = "rng3Fw": i = i + 1
    
    names(i) = "useRGBCoeff": i = i + 1
    names(i) = "aryRGBcoeff": i = i + 1
        
    names(i) = "inv125Comp": i = i + 1
    
    For i = 0 To j
        If var = names(i) Then
            checkName = True
            i = j
        End If
    Next i
End Function





Public Sub setExcelName(ByVal var As String, ByVal val As Double, Optional sn As String = "Summary")

    Dim N As Excel.Name, s As Excel.Worksheet
    
    On Error GoTo callFromExcel
    
    Set s = oBook.Worksheets(sn): GoTo startSearch

callFromExcel:
    Set s = Worksheets(sn)
    
startSearch:
    For Each N In s.Parent.names
        If var = N.Name Then
            s.Cells(N.RefersToRange.row, N.RefersToRange.Column) = val
        End If
    Next N

End Sub

Public Function getRGBcoeff(ary() As Double, Optional sn As String = "Summary") As Double

    getRGBcoeff = getExcelName("useRGBCoeff", sn)
    
    If (getRGBcoeff <> 0) Then
    
        Dim N As Excel.Name, s As Excel.Worksheet
        
        If checkName("aryRGBcoeff") Then
        
            On Error GoTo callFromExcel
            
            Set s = oBook.Worksheets(sn): GoTo startSearch
        
callFromExcel:
            Set s = Worksheets(sn)
            
startSearch:
            For Each N In s.Parent.names
                If "aryRGBcoeff" = N.Name Then
                    For i = 0 To 8
                        ary(i) = s.Cells(N.RefersToRange.row + i, N.RefersToRange.Column)
                    Next i
                End If
            Next N
            
        Else
            MsgBox (var & " not listed in modDSP:checkName")
        End If

    End If

End Function


Public Function getExcelName(ByVal var As String, Optional sn As String = "Summary") As Double

    Dim N As Excel.Name, s As Excel.Worksheet
    
    If checkName(var) Then
    
        On Error GoTo callFromExcel
        
        Set s = oBook.Worksheets(sn): GoTo startSearch
    
callFromExcel:
        Set s = Worksheets(sn)
        
startSearch:
        For Each N In s.Parent.names
            If var = N.Name Then
                getExcelName = s.Cells(N.RefersToRange.row, N.RefersToRange.Column)
            End If
        Next N
        
    Else
        MsgBox (var & " not listed in modDSP:checkName")
    End If

End Function

Public Sub macroSetRefSpectrum()
    Dim wavelength As Single
    Dim wl As Integer: wl = wavelength
    Dim r As Single, G As Single, B As Single
    Dim hi As Single, lo As Single
    Dim gain As Single: gain = 1#
    Dim Gamma As Single: Gamma = 0.8
    
    Dim wIdx As Integer
    Dim rng As range: Set rng = range("P2:FT2")
    
    For wavelength = 300 To 1100 Step 5
    
        wl = wavelength
    
        lo = 350: hi = 440: If (lo <= wl) And (wl < hi) Then r = -1# * (wl - hi) / (hi - lo): G = 0: B = 1
        lo = hi: hi = 490: If (lo <= wl) And (wl < hi) Then r = 0: G = 1# * (wl - lo) / (hi - lo): B = 1
        lo = hi: hi = 510: If (lo <= wl) And (wl < hi) Then r = 0: G = 1: B = -1# * (wl - hi) / (hi - lo)
        lo = hi: hi = 580: If (lo <= wl) And (wl < hi) Then r = 1# * (wl - lo) / (hi - lo): G = 1: B = 0
        lo = hi: hi = 645: If (lo <= wl) And (wl < hi) Then r = 1: G = -1# * (wl - hi) / (hi - lo): B = 0
        lo = hi: hi = 780: If (lo <= wl) And (wl < hi) Then r = 1: G = 0: B = 0
            
        If wl < 350 Then gain = 0#
        If (350 <= wl) And (wl < 420) Then gain = 0.3 + 0.7 * (wl - 350#) / (420# - 350#)
        If (700 <= wl) And (wl < 780) Then gain = 0.3 + 0.7 * (780# - wl) / (780# - 700#)
        If 780 <= wl Then gain = 0#
        
        r = (gain * r) ^ Gamma: G = (gain * G) ^ Gamma: B = (gain * B) ^ Gamma
        r = Int(255 * r): G = Int(255 * G): B = Int(255 * B)
        
        wIdx = (wavelength - 300) / 5 + 1
        rng.Cells(1, wIdx).Interior.color = RGB(r, G, B)
    
    Next wavelength
    
exitSub:
End Sub

Public Sub macroSetColor()

    Dim iRng As range, oRng As range
    Dim wavelength As Single
    
    Dim red As Integer, grn As Integer, blu As Integer, wIdx As Integer
    
    Const fs As Integer = 255 / 1.2
    
    Set iRng = range("E24:G184")
    Set oRng = range("P3:FT3")
    
    For wavelength = 300 To 1100 Step 5
    
        wIdx = (wavelength - 300) / 5 + 1
        
        red = iRng.Cells(wIdx, 1).Value2 * fs
        grn = iRng.Cells(wIdx, 2).Value2 * fs
        blu = iRng.Cells(wIdx, 3).Value2 * fs
    
        oRng.Cells(1, wIdx).Interior.color = RGB(red, grn, blu)
        
    Next wavelength
    
End Sub

Private Function rangeFromRowColumn(startRow, startColumn, stopRow, stopColumn) As String
    Dim mc As range
     Set mc = Worksheets("pixel").Cells(startRow, startColumn)
     rangeFromRowColumn = mc.address
     Set mc = Worksheets("pixel").Cells(stopRow, stopColumn)
     rangeFromRowColumn = rangeFromRowColumn & ":" & mc.address
End Function


Sub calcRGBcoef()

    Dim Unit As Long
    Dim col As Long
    Dim row As Long, r As Long
    Dim rng As String
    Dim mc As range
    Dim formula As String
    Dim unitFirst As Integer, unitLast As Integer
    
    Unit = 1
    col = 7
    row = 165
    
    unitFirst = getExcelName("unitFirst", "pixel")
    unitLast = getExcelName("unitLast", "pixel")
    
    For Unit = unitFirst To unitLast
    
        Debug.Print "==== " & Unit
    
        For r = 0 To 2
        
            rng = rangeFromRowColumn(row + r, col + Unit * 3, row + r, col + 2 + Unit * 3)
            formula = "=LINEST(R[" & -150 - r & "]C[" & r - 3 - 3 * Unit & "]:R[" & -56 - r & "]C[" & r - 3 - 3 * Unit & "],"
            formula = formula & "R[" & -150 - r & "]C[0]:R[" & -56 - r & "]C[2],FALSE)"
            
            Debug.Print rng
            Debug.Print formula
            
            range(rng).Select
            Selection.FormulaArray = formula
         
         Next r
    
    Next Unit

End Sub

Public Function setColor(selected As range) As Integer
    'Application.Volatile = True
    selected.Interior.ColorIndex = 5
    'ActiveCell.Interior.ColorIndex = 5
End Function

Public Function setCalcEnable(enable As Integer) As String
    If enable = 1 Then
        calcEnabled = True
    Else
        calcEnabled = False
    End If
    setCalcEnable = "Calc Enable="
End Function

Public Function decimation(indata As range, row As Integer, dec As Integer) As Double
    '
    ' calling cell: =decimation(E$2:E$802,CELL("row",G2),G$1)
    '
    Dim nRow As Integer: nRow = UBound(indata.Value2, 1)
    Dim rowOut As Integer: rowOut = ((row - indata.row) * dec)
    If rowOut <= nRow Then
        decimation = indata.Value2(rowOut + indata.row - 1, 1)
        'decimation = rowOut + indata.row - 1
    End If
End Function

Public Function histo(hdata As range, xdata As range, xpt As Double) As Double
    
    ' hdata: data to be histogrammed
    ' xdata: x axis (histogram bounderies)
    ' xpt upper boundery for data being counted
    
    'If calcEnabled Then

        Dim nRow As Integer: nRow = UBound(hdata.Value2, 1)
        Dim nCol As Integer: nCol = UBound(hdata.Value2, 2)
        Dim nBin As Integer: nBin = UBound(xdata.Value2, 1)
        
        ReDim count(nBin)
        
        histo = -1
        
        ' actual histogram
        For row = 1 To nRow
            For col = 1 To nCol
                For bin = 1 To nBin
                    If hdata.Value2(row, col) <> "" Then
                        If hdata.Value2(row, col) <= xdata.Value2(bin, 1) Then
                            count(bin) = count(bin) + 1
                            bin = nBin
                        Else
                            If bin = nBin Then count(bin) = count(bin) + 1
                        End If
                    End If
                Next bin
            Next col
        Next row
        
        For bin = 1 To nBin
            If xpt = xdata.Value2(bin, 1) Then histo = count(bin)
        Next bin
    'Else
    '    histogram = 0
    'End If

End Function

Public Function findArea(xdata As range, ydata As range, threshold As Double) As Double
    '
    ' given Range containing x & y data in columns
    ' returns extrapolated x value where integration of y = threshold
    '
    
    If calcEnabled Then
    
        Dim nRow As Integer: nRow = UBound(xdata.Value2, 1)
        
        'Dim nCol As Integer: nCol = UBound(data.Value2, 2)
        Dim sum As Double: sum = 0
        Dim sum2 As Double: sum2 = 0
        Dim lsum As Double: lsum = 0
        Dim tripIdx As Integer
        
        For i = 1 To nRow
            sum = sum + ydata.Value2(i, 1)
        Next i
        
        For i = 1 To nRow
            lsum = sum2
            sum2 = sum2 + ydata.Value2(i, 1)
            If sum2 > sum * threshold Then
                tripIdx = i
                i = nRow
            End If
        Next i
        dX = xdata.Value2(tripIdx, 1) - xdata.Value2(tripIdx - 1, 1)
        dY = sum2 - lsum
        findArea = ydata.Value2(tripIdx - 1, 1) + dX * (sum2 - sum * threshold) / dY
    Else
        findArea = 0
    End If

End Function
Public Function transition(angle As range, fsr As range, threshold As Double) As Double

    'If calcEnabled Then
    
        Dim startAngle As Double: startAngle = angle.Value2(1, 1)
        Dim nAngles As Double: nAngles = UBound(angle.Value2, 1)
        Dim stopAngle As Double: stopAngle = angle.Value2(nAngles, 1)
        Dim step As Double: step = (stopAngle - startAngle) / (nAngles - 1)
        Dim i As Integer
        
        If threshold < 0 Then ' falling edge
            threshold = -threshold
            For i = nAngles To 1 Step -1
                If fsr.Value2(i, 1) >= threshold Then
                    transition = angle.Value2(i, 1) + step * (fsr.Value2(i, 1) - threshold) / (fsr.Value2(i, 1) - fsr.Value2(i + 1, 1))
                    i = 1
                End If
            Next i
        Else
            For i = 1 To nAngles
                If fsr.Value2(i, 1) > threshold Then
                    transition = angle.Value2(i - 1, 1) + step * (fsr.Value2(i, 1) - threshold) / (fsr.Value2(i, 1) - fsr.Value2(i - 1, 1))
                    i = nAngles
                End If
            Next i
        End If
        
    'Else
    '    transition = 0
    'End If
    
End Function
Public Function interpolate(Xaxis As range, Yaxis As range, Xvalue As Double) As Double

    Static lastXidx As Integer: lastXidx = 1 'If lastXidx < 1 Then lastXidx = 1
    
    Dim dY As Double, dX As Double

    Dim xStart As Double: xStart = Xaxis.Value2(1, 1)
    Dim nValues As Double: nValues = UBound(Xaxis.Value2, 1)
    Dim xStop As Double: xStop = Xaxis.Value2(nValues, 1)
    
    While Xvalue <= Xaxis.Value2(lastXidx + 1, 1)
        lastXidx = lastXidx - 1
    Wend
    
    While Xvalue > Xaxis.Value2(lastXidx, 1)
        lastXidx = lastXidx + 1
    Wend
    
    interpolate = Yaxis.Value2(lastXidx - 1, 1)
    
    dY = Yaxis.Value2(lastXidx, 1) - Yaxis.Value2(lastXidx - 1, 1)
    
    dX = (Xvalue - Xaxis.Value2(lastXidx - 1, 1)) / (Xaxis.Value2(lastXidx, 1) - Xaxis.Value2(lastXidx - 1, 1))
    
    interpolate = interpolate + dY * dX
    
End Function

Public Function normAvgCalAdjust(w As Double, a As Double, cal As range, angle As range, wavelength As range, data0 As range, Data1 As range, Data2 As range, Data3 As range, Data4 As range) As Double
    
    If calcEnabled Then
    
        If w <> wavelength.Value2(1, 1) Or a <> angle.Value2(1, 1) Then GoTo returnValue
        
        calData.start_ = cal.Value2(1, 1)
        calData.nItems = UBound(cal.Value2, 1)
        calData.stop_ = cal.Value2(calData.nItems, 1)
        calData.step_ = (calData.stop_ - calData.start_) / (calData.nItems - 1)
    
        angleData.start_ = angle.Value2(1, 1)
        angleData.nItems = UBound(angle.Value2, 1)
        angleData.stop_ = angle.Value2(angleData.nItems, 1)
        angleData.step_ = (angleData.stop_ - angleData.start_) / (angleData.nItems - 1)
    
        wavelengthData.start_ = wavelength.Value2(1, 1)
        wavelengthData.nItems = UBound(wavelength.Value2, 2)
        wavelengthData.stop_ = wavelength.Value2(1, wavelengthData.nItems)
        wavelengthData.step_ = (wavelengthData.stop_ - wavelengthData.start_) / (wavelengthData.nItems - 1)
    
        ReDim sum(5): ReDim data(5, angleData.nItems, wavelengthData.nItems): Dim cIdx As Integer, D As Integer
        
        For wi = 1 To wavelengthData.nItems
            cIdx = 1 + ((wavelengthData.start_ + (wi - 1) * wavelengthData.step_) - calData.start_) / calData.step_
            For ai = 1 To angleData.nItems
                For D = 1 To 5
                    Select Case D
                    Case 1: data(D, ai, wi) = data0.Value2(ai, wi) / cal.Value2(cIdx, 2)
                    Case 2: data(D, ai, wi) = Data1.Value2(ai, wi) / cal.Value2(cIdx, 2)
                    Case 3: data(D, ai, wi) = Data2.Value2(ai, wi) / cal.Value2(cIdx, 2)
                    Case 4: data(D, ai, wi) = Data3.Value2(ai, wi) / cal.Value2(cIdx, 2)
                    Case 5: data(D, ai, wi) = Data4.Value2(ai, wi) / cal.Value2(cIdx, 2)
                    End Select
                    sum(D) = sum(D) + data(D, ai, wi)
                Next D
            Next ai
        Next wi
        
        
        Static peak As Double: peak = 0
        
        For wi = 1 To wavelengthData.nItems
            For ai = 1 To angleData.nItems
                For D = 1 To 5
                    data(D, ai, wi) = data(D, ai, wi) / sum(D)
                    data(0, ai, wi) = data(0, ai, wi) + data(D, ai, wi)
                Next D
                If peak < data(0, ai, wi) Then peak = data(0, ai, wi)
            Next ai
        Next wi
        
returnValue:
        wi = 1 + (w - wavelengthData.start_) / wavelengthData.step_
        ai = 1 + (a - angleData.start_) / angleData.step_
        normAvgCalAdjust = data(0, ai, wi) / peak
        
    Else
        normAvgCalAdjust = 0
    End If
    
End Function


