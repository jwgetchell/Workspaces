Attribute VB_Name = "modCMF"

' CMF Functions
' Source: http://www.cvrl.org/
' Colour & Vision Research Laboratory

Private Enum CMF
    cmf1931
    cmf1931_Judd
    cmf1931_Judd_Vos
    cmf1964
    cmf2006_2Deg
    cmf2006_10Deg
End Enum

'------------------- RGB -----------------------------
Private Enum rgbCo
    Alpha = 1
    Beta
    Gamma
    Krg
    Krb
    Kgr
    Kgb
    Kbr
    Kbg
End Enum

Private Enum pixel
    red = 1
    green
    blue
End Enum

Private Sub initRGB()




Static initRGBdone As Boolean

End Sub

Public Function XYZ2sRGB(xyz() As Double, rgb() As Double, Optional greyScaleCmd As Integer = -1) As Long
    ' from:https://en.wikipedia.org/wiki/SRGB#The_forward_transformation_.28CIE_xyY_or_CIE_XYZ_to_sRGB.29
    ' greyScaleCmd = { <0, =0, >0 } = { use, clear, set }
    Dim matrix(2, 2) As Double, i As Integer, maxVal As Double
    Static greyScaleValue As Double
    
    matrix(0, 0) = 3.2406: matrix(0, 1) = -1.5372: matrix(0, 2) = -0.4986
    matrix(1, 0) = -0.9689: matrix(1, 1) = 1.8758: matrix(1, 2) = 0.0415
    matrix(2, 0) = 0.0557: matrix(2, 1) = -0.204: matrix(2, 2) = 1.057
    
    For i = 0 To 2
        rgb(i) = matrix(i, 0) * xyz(0) + matrix(i, 1) * xyz(1) + matrix(i, 2) * xyz(2)
    Next i
    
    If greyScaleCmd = 0 Then greyScaleValue = 0: Exit Function
    
    If greyScaleCmd > 0 Or greyScaleValue = 0 Then ' set or none
    
        maxVal = rgb(0)
        If maxVal < rgb(1) Then maxVal = rgb(1)
        If maxVal < rgb(2) Then maxVal = rgb(2)
        
        If greyScaleCmd > 0 Then ' set
            If maxVal = 0 Then
                greyScaleValue = 0
            Else
                maxVal = rgb(1)
                greyScaleValue = maxVal / 0.18 ' probably should use luminosity equation
            End If
        End If
        
    End If
    
    If greyScaleValue > 0 Then maxVal = greyScaleValue
    
    For i = 0 To 2
    
        rgb(i) = rgb(i) / maxVal
        If rgb(i) < 0 Then rgb(i) = 0
        If rgb(i) > 1 Then rgb(i) = 1
        
        If rgb(i) <= 0.0031308 Then
            rgb(i) = 12.92 * rgb(i)
        Else
            rgb(i) = 1.055 * rgb(i) ^ (1 / 2.4) - 0.055
        End If
        
        rgb(i) = Int(255 * rgb(i))
        
        XYZ2sRGB = XYZ2sRGB + rgb(i) * 256 ^ i
        
    Next i
    
End Function

Public Sub get_sRGBD50_XYZtoRGB(matrix() As Single)
    
    ' from:http://www.brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
    ' 3.1338561 -1.6168667 -0.4906146
    '-0.9787684  1.9161415  0.0334540
    ' 0.0719453 -0.2289914  1.4052427
 
    matrix(0, 0) = 3.1338561: matrix(0, 1) = -1.6168667: matrix(0, 2) = -0.4906146
    matrix(1, 0) = -0.9787684: matrix(1, 1) = 1.9161415: matrix(1, 2) = 0.033454
    matrix(2, 0) = 0.0719453: matrix(2, 1) = -0.2289914: matrix(2, 2) = 1.4052427

End Sub

Public Sub get_sRGBD65_XYZtoRGB(matrix() As Single)

    ' from:http://www.brucelindbloom.com/index.html?Eqn_RGB_XYZ_Matrix.html
    ' 3.2404542 -1.5371385 -0.4985314
    '-0.9692660  1.8760108  0.0415560
    ' 0.0556434 -0.2040259  1.0572252
    
    matrix(0, 0) = 3.2404542: matrix(0, 1) = -1.5371385: matrix(0, 2) = -0.4985314
    matrix(1, 0) = -0.969266: matrix(1, 1) = 1.8760108: matrix(1, 2) = 0.041556
    matrix(2, 0) = 0.0556434: matrix(2, 1) = -0.2040259: matrix(2, 2) = 1.0572252

End Sub

Public Sub get_panel_XYZtoRGB(matrix() As Single)
    
    ' from:My calibration of Crossover Monitor after matching E to laptop: User set RGB(%)={77,80,90}; E RGB={255,230,199}
    '              0.019869051                  -0.006173046                -0.003046535                    0.056809523
    '              -0.006377214                 0.014002166                 0.00016673                      0.058489394
    '              0.000434956                  -0.001099962                0.007261552                     0.010603047
    matrix(0, 0) = 0.019869051:  matrix(0, 1) = -0.006173046: matrix(0, 2) = -0.0030465352: matrix(0, 3) = 0.0568095232
    matrix(1, 0) = -0.006377214: matrix(1, 1) = 0.014002166:  matrix(1, 2) = 0.00016673:  matrix(1, 3) = 0.058489394
    matrix(2, 0) = 0.000434956:  matrix(2, 1) = -0.001099962: matrix(2, 2) = 0.007261557:  matrix(2, 3) = 0.010603042

End Sub

Public Function getXYZ(ByVal E As Double, ByVal X As Double, ByVal Y As Double, idx As Integer) As Double
On Error Resume Next
    Select Case idx
    Case 0: getXYZ = E * X / Y
    Case 1: getXYZ = E
    Case 2: getXYZ = E * (1 - X - Y) / Y
    End Select

End Function

Public Function getUfromXY(ByVal X As Double, ByVal Y As Double) As Double
    getUfromXY = 4 * X / (-2 * X + 12 * Y + 3)
End Function
    
Public Function getVfromXY(ByVal X As Double, ByVal Y As Double) As Double
    getVfromXY = 6 * Y / (-2 * X + 12 * Y + 3)
End Function
    
Public Function getXfromUV(ByVal u As Double, ByVal v As Double) As Double
    getXfromUV = 3 * u / (2 * u - 8 * v + 4)
End Function
    
Public Function getYfromUV(ByVal u As Double, ByVal v As Double) As Double
    getYfromUV = 2 * v / (2 * u - 8 * v + 4)
End Function
    
Public Function getCMFlistItem(ByVal Item As Integer) As String
    Select Case Item
        Case CMF.cmf1931: getCMFlistItem = "CIE 1931 2 deg"
        Case CMF.cmf1931_Judd: getCMFlistItem = "CIE 1931 & Judd(1951)"
        Case CMF.cmf1931_Judd_Vos: getCMFlistItem = "CIE 1931 & Judd & Vos(1978)"
        Case CMF.cmf1964: getCMFlistItem = "CIE 1964 10 deg"
        Case CMF.cmf2006_2Deg: getCMFlistItem = "CIE 2006 2 deg"
        Case CMF.cmf2006_10Deg: getCMFlistItem = "CIE 2006 10 deg"
        Case Else: getCMFlistItem = "No Item"
    End Select
End Function

Public Function getXYZfromCMF(ByVal color As Integer, ByVal nm As Integer, Optional ByVal version As Integer = 0) As Double

    Static L(94) As Integer, X(94) As Double, Y(94) As Double, Z(94) As Double, lVersion As Integer, items As Integer
    
    If 0 <= version And version < 6 Then
        
        If (items = 0) Or (lVersion <> version) Then
            Select Case version
                Case CMF.cmf1931: items = loadCMF1931(X(), Y(), Z())
                Case CMF.cmf1931_Judd: items = loadCMF1931_Judd(X(), Y(), Z())
                Case CMF.cmf1931_Judd_Vos: items = loadCMF1931_Judd_Vos(X(), Y(), Z())
                Case CMF.cmf1964: items = loadCMF1964(X(), Y(), Z())
                Case CMF.cmf2006_2Deg: items = loadCMF2006_2deg(X(), Y(), Z())
                Case CMF.cmf2006_10Deg: items = loadCMF2006_10deg(X(), Y(), Z())
            End Select
            lVersion = version
        End If
        
        nm = (nm - 360) / 5 ' convert to index
        
        If (0 <= nm And nm <= 94) And (0 <= color And color <= 2) Then
            Select Case color
                Case 0: getXYXfromCMF = X(nm)
                Case 1: getXYXfromCMF = Y(nm)
                Case 2: getXYXfromCMF = Z(nm)
            End Select
        End If
        
    End If

End Function

Public Function getREDfromXYZ(ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ R ]   [  3.240479 -1.537150 -0.498535 ]   [ X ]
    '   [ G ] = [ -0.969256  1.875992  0.041556 ] * [ Y ]
    '   [ B ]   [  0.055648 -0.204043  1.057311 ]   [ Z ]
    
    getREDfromXYZ = 3.240479 * X - 1.53715 * Y - 0.498535 * Z

End Function

Public Function getGREENfromXYZ(ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ R ]   [  3.240479 -1.537150 -0.498535 ]   [ X ]
    '   [ G ] = [ -0.969256  1.875992  0.041556 ] * [ Y ]
    '   [ B ]   [  0.055648 -0.204043  1.057311 ]   [ Z ]
    
    getGREENfromXYZ = -0.969256 * X + 1.875992 * Y + 0.041556 * Z

End Function

Public Function getBLUEfromXYZ(ByVal X As Double, ByVal Y As Double, ByVal Z As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ R ]   [  3.240479 -1.537150 -0.498535 ]   [ X ]
    '   [ G ] = [ -0.969256  1.875992  0.041556 ] * [ Y ]
    '   [ B ]   [  0.055648 -0.204043  1.057311 ]   [ Z ]
    
    getBLUEfromXYZ = 0.055648 * X - 0.204043 * Y + 1.057311 * Z

End Function

Public Function getXfromRGB(ByVal r As Double, ByVal G As Double, ByVal B As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ X ]   [  0.412453  0.357580  0.180423 ]   [ R ]
    '   [ Y ] = [  0.212671  0.715160  0.072169 ] * [ G ]
    '   [ Z ]   [  0.019334  0.119193  0.950227 ]   [ B ]
    
    getXfromRGB = 0.412453 * r + 0.35758 * G + 0.180423 * B

End Function

Public Function getYfromRGB(ByVal r As Double, ByVal G As Double, ByVal B As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ X ]   [  0.412453  0.357580  0.180423 ]   [ R ]
    '   [ Y ] = [  0.212671  0.715160  0.072169 ] * [ G ]
    '   [ Z ]   [  0.019334  0.119193  0.950227 ]   [ B ]
    
    getYfromRGB = 0.212671 * r + 0.71516 * G + 0.072169 * B

End Function

Public Function getZfromRGB(ByVal r As Double, ByVal G As Double, ByVal B As Double) As Double
    ' references: XYZ <> RGB: http://www.cs.rit.edu/~ncs/color/t_convert.html

    '   [ X ]   [  0.412453  0.357580  0.180423 ]   [ R ]
    '   [ Y ] = [  0.212671  0.715160  0.072169 ] * [ G ]
    '   [ Z ]   [  0.019334  0.119193  0.950227 ]   [ B ]
    
    getZfromRGB = 0.019334 * r + 0.119193 * G + 0.950227 * B

End Function

Public Function getCCT(ByVal r As Double, ByVal G As Double, ByVal B As Double) As Double

    Dim X As Double, Y As Double, n As Double
    getCCT = 0: On Error GoTo endFunction
    
    X = r / (r + G + B)
    Y = G / (r + G + B)
    n = (X - 0.332) / (Y - 0.1858)
    
    getCCT = -449 * n ^ 3 + 3525 * n ^ 2 - 6823.3 * n + 5520.33
    
endFunction: End Function

Public Function getCCTfromXY_(ByVal X As Double, ByVal Y As Double, Optional algo As Integer = 0) As Double

    ' http://en.wikipedia.org/wiki/Color_temperature#Approximation
    Select Case algo
    Case 0:                                                              'McCamy
        Dim n As Double
        n = (X - 0.332) / (Y - 0.1858)
        getCCTfromXY_ = -449 * n ^ 3 + 3525 * n ^ 2 - 6823.3 * n + 5520.33
    Case 1:
        Const exp As Double = 2.718281828
        Const Xe As Double = 0.3366
        Const Ye As Double = 0.1735
        Const A0 As Double = -949.86315
        Const A1 As Double = 6253.80338
        Const A2 As Double = 28.70599
        Const A3 As Double = 0.00004
        Const T1 As Double = 0.92159
        Const T2 As Double = 0.20039
        Const T3 As Double = 0.07125
        n = (X - Xe) / (Y - Ye)
        getCCTfromXY_ = A0 + A1 * exp ^ (-n / T1) + A2 * exp ^ (-n / T2) + A3 * exp ^ (-n / T3)
    Case 2:
        getCCTfromXY_ = getCCTfromXYtable(X, Y)
    Case 3:
        getCCTfromXY_ = getCCTfromXYtable(X, Y, 1)
    Case 4:
        getCCTfromXY_ = getCCTfromXYtable(X, Y, 2)
    End Select
    
End Function

Public Function getCCTfromUV(ByVal u As Double, ByVal v As Double, uv1to10kK As range) As Double

    ' http://www.vendian.org/mncharity/dir3/blackbody/ (table values)
    
    Dim hiIdx As Integer: hiIdx = UBound(uv1to10kK.Value2, 1)
    Dim res As Double: res = 8000# / (hiIdx - 1)
    Const base As Double = 2000#
    
    Dim d0 As Double, d1
    Dim i As Double: i = 0
    
    Dim u0 As Double, v0 As Double
    Dim delta As Double: delta = 4000
    Dim bit As Integer: bit = Int(delta / res)
    
    While bit > 0
    
        u0 = uv1to10kK.Value2(i + bit + 1, 1): v0 = uv1to10kK.Value2(i + bit + 1, 2)
        d1 = (u - u0) ^ 2 + (v - v0) ^ 2
        
        u0 = uv1to10kK.Value2(i + bit, 1): v0 = uv1to10kK.Value2(i + bit, 2)
        d0 = (u - u0) ^ 2 + (v - v0) ^ 2
        
        If d1 <= d0 Then
            i = i + bit
        End If
        
        delta = delta / 2: bit = Int(delta / res + 0.5)
        
        Debug.Print i * res + base, d1, d0, delta
        
    Wend
    
    getCCTfromUV = i * res + base

End Function

Public Function getCCTfromXYtable(ByVal X As Double, ByVal Y As Double, Optional ByVal version As Integer = 0) As Double

    ' http://www.vendian.org/mncharity/dir3/blackbody/ (table values)
    Static Xt(900) As Double, Yt(900) As Double, lVersion As Integer
    Static hiIdx As Integer
    
    If Not hiIdx Or lVersion <> version Then
        Select Case version
        Case 0, 2: hiIdx = loadCCTxyTable1964(Xt, Yt)
        Case 1: hiIdx = loadCCTxyTable1931(Xt, Yt)
        End Select
        lVersion = version
    End If
    
    Dim res As Double: res = 9000# / hiIdx
    Const base As Double = 1000#
    
    Dim d0 As Double, d1
    Dim i As Double: i = 0
    
    Dim x0 As Double, y0 As Double
    Dim delta As Double: delta = 4500
    Dim bit As Integer: bit = Int(delta / res)
    
    While bit > 0
    
        If version = 2 Then
            x0 = getPlanckianLocusX(base + res * (i + bit)): y0 = getPlanckianLocusY(base + res * (i + bit))
        Else
            x0 = Xt(i + bit): y0 = Yt(i + bit)
        End If
        
        d1 = (X - x0) ^ 2 + (Y - y0) ^ 2
        
        If version = 2 Then
            x0 = getPlanckianLocusX(base + res * (i + bit - 1)): y0 = getPlanckianLocusY(base + res * (i + bit - 1))
        Else
            x0 = Xt(i + bit - 1): y0 = Yt(i + bit - 1)
        End If
        
        d0 = (X - x0) ^ 2 + (Y - y0) ^ 2
        
        If d1 <= d0 Then
            i = i + bit
        End If
        
        delta = delta / 2: bit = Int(delta / res + 0.5)
        
    Wend
    
    getCCTfromXYtable = i * res + base

End Function

Public Function getRed(rgb_ As range, coef As range, Optional vertRgbRange As Integer = 0) As Double

    getRed = -100: On Error GoTo endFunction
    
    If vertRgbRange Then
        getRed = coef.Value2(rgbCo.Alpha, 1) * ( _
                                             rgb_.Value2(pixel.red, 1) + _
                 coef.Value2(rgbCo.Krg, 1) * rgb_.Value2(pixel.green, 1) + _
                 coef.Value2(rgbCo.Krb, 1) * rgb_.Value2(pixel.blue, 1) _
                 )
    Else
        getRed = coef.Value2(rgbCo.Alpha, 1) * ( _
                                             rgb_.Value2(1, pixel.red) + _
                 coef.Value2(rgbCo.Krg, 1) * rgb_.Value2(1, pixel.green) + _
                 coef.Value2(rgbCo.Krb, 1) * rgb_.Value2(1, pixel.blue) _
                 )
    End If
    
endFunction: End Function

Public Function getGreen(rgb_ As range, coef As range, Optional vertRgbRange As Integer = 0) As Double

    getGreen = -100: On Error GoTo endFunction
    
    If vertRgbRange Then
        getGreen = coef.Value2(rgbCo.Beta, 1) * ( _
                   coef.Value2(rgbCo.Kgr, 1) * rgb_.Value2(pixel.red, 1) + _
                                               rgb_.Value2(pixel.green, 1) + _
                   coef.Value2(rgbCo.Kgb, 1) * rgb_.Value2(pixel.blue, 1) _
                   )
    Else
        getGreen = coef.Value2(rgbCo.Beta, 1) * ( _
                   coef.Value2(rgbCo.Kgr, 1) * rgb_.Value2(1, pixel.red) + _
                                               rgb_.Value2(1, pixel.green) + _
                   coef.Value2(rgbCo.Kgb, 1) * rgb_.Value2(1, pixel.blue) _
                   )
    End If
    
endFunction: End Function

Public Function getBlue(rgb_ As range, coef As range, Optional vertRgbRange As Integer = 0) As Double

    getBlue = -100: On Error GoTo endFunction
    
    If vertRgbRange Then
        getBlue = coef.Value2(rgbCo.Gamma, 1) * ( _
                  coef.Value2(rgbCo.Kbr, 1) * rgb_.Value2(pixel.red, 1) + _
                  coef.Value2(rgbCo.Kbg, 1) * rgb_.Value2(pixel.green, 1) + _
                                              rgb_.Value2(pixel.blue, 1) _
                   )
    Else
        getBlue = coef.Value2(rgbCo.Gamma, 1) * ( _
                  coef.Value2(rgbCo.Kbr, 1) * rgb_.Value2(1, pixel.red) + _
                  coef.Value2(rgbCo.Kbg, 1) * rgb_.Value2(1, pixel.green) + _
                                              rgb_.Value2(1, pixel.blue) _
                   )
    End If
    
endFunction: End Function
'^^^^^^^^^^^^^^^^^ END RGB ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Private Function loadCMF1931_Judd(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double

    i = i + 0: L(i) = 360: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 370: X(i) = 0.0008: Y(i) = 0.0001: Z(i) = 0.0046
    i = i + 1: L(i) = 380: X(i) = 0.0045: Y(i) = 0.0004: Z(i) = 0.0224
    i = i + 1: L(i) = 390: X(i) = 0.0201: Y(i) = 0.0015: Z(i) = 0.0925
    i = i + 1: L(i) = 400: X(i) = 0.0611: Y(i) = 0.0045: Z(i) = 0.2799
    i = i + 1: L(i) = 410: X(i) = 0.1267: Y(i) = 0.0093: Z(i) = 0.5835
    i = i + 1: L(i) = 420: X(i) = 0.2285: Y(i) = 0.0175: Z(i) = 1.0622
    i = i + 1: L(i) = 430: X(i) = 0.3081: Y(i) = 0.0273: Z(i) = 1.4526
    i = i + 1: L(i) = 440: X(i) = 0.3312: Y(i) = 0.0379: Z(i) = 1.6064
    i = i + 1: L(i) = 450: X(i) = 0.2888: Y(i) = 0.0468: Z(i) = 1.4717
    i = i + 1: L(i) = 460: X(i) = 0.2323: Y(i) = 0.06: Z(i) = 1.288
    i = i + 1: L(i) = 470: X(i) = 0.1745: Y(i) = 0.091: Z(i) = 1.1133
    i = i + 1: L(i) = 480: X(i) = 0.092: Y(i) = 0.139: Z(i) = 0.7552
    i = i + 1: L(i) = 490: X(i) = 0.0318: Y(i) = 0.208: Z(i) = 0.4461
    i = i + 1: L(i) = 500: X(i) = 0.0048: Y(i) = 0.323: Z(i) = 0.2644
    i = i + 1: L(i) = 510: X(i) = 0.0093: Y(i) = 0.503: Z(i) = 0.1541
    i = i + 1: L(i) = 520: X(i) = 0.0636: Y(i) = 0.71: Z(i) = 0.0763
    i = i + 1: L(i) = 530: X(i) = 0.1668: Y(i) = 0.862: Z(i) = 0.0412
    i = i + 1: L(i) = 540: X(i) = 0.2926: Y(i) = 0.954: Z(i) = 0.02
    i = i + 1: L(i) = 550: X(i) = 0.4364: Y(i) = 0.995: Z(i) = 0.0088
    i = i + 1: L(i) = 560: X(i) = 0.597: Y(i) = 0.995: Z(i) = 0.0039
    i = i + 1: L(i) = 570: X(i) = 0.7642: Y(i) = 0.952: Z(i) = 0.002
    i = i + 1: L(i) = 580: X(i) = 0.9159: Y(i) = 0.87: Z(i) = 0.0016
    i = i + 1: L(i) = 590: X(i) = 1.0225: Y(i) = 0.757: Z(i) = 0.0011
    i = i + 1: L(i) = 600: X(i) = 1.0544: Y(i) = 0.631: Z(i) = 0.0007
    i = i + 1: L(i) = 610: X(i) = 0.9922: Y(i) = 0.503: Z(i) = 0.0003
    i = i + 1: L(i) = 620: X(i) = 0.8432: Y(i) = 0.381: Z(i) = 0.0002
    i = i + 1: L(i) = 630: X(i) = 0.6327: Y(i) = 0.265: Z(i) = 0.0001
    i = i + 1: L(i) = 640: X(i) = 0.4404: Y(i) = 0.175: Z(i) = 0#
    i = i + 1: L(i) = 650: X(i) = 0.2787: Y(i) = 0.107: Z(i) = 0#
    i = i + 1: L(i) = 660: X(i) = 0.1619: Y(i) = 0.061: Z(i) = 0#
    i = i + 1: L(i) = 670: X(i) = 0.0858: Y(i) = 0.032: Z(i) = 0#
    i = i + 1: L(i) = 680: X(i) = 0.0459: Y(i) = 0.017: Z(i) = 0#
    i = i + 1: L(i) = 690: X(i) = 0.0222: Y(i) = 0.0082: Z(i) = 0#
    i = i + 1: L(i) = 700: X(i) = 0.0113: Y(i) = 0.0041: Z(i) = 0#
    i = i + 1: L(i) = 710: X(i) = 0.0057: Y(i) = 0.0021: Z(i) = 0#
    i = i + 1: L(i) = 720: X(i) = 0.0028: Y(i) = 0.0011: Z(i) = 0#
    i = i + 1: L(i) = 730: X(i) = 0.0015: Y(i) = 0.0005: Z(i) = 0#
    i = i + 1: L(i) = 740: X(i) = 0.0005: Y(i) = 0.0002: Z(i) = 0#
    i = i + 1: L(i) = 750: X(i) = 0.0003: Y(i) = 0.0001: Z(i) = 0#
    i = i + 1: L(i) = 760: X(i) = 0.0002: Y(i) = 0.0001: Z(i) = 0#
    i = i + 1: L(i) = 770: X(i) = 0.0001: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 780: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 790: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 800: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 810: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 820: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 830: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    
    loadCMF1931_Judd = i
    
End Function

Private Function loadCMF1931_Judd_Vos(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double

    i = i + 0: L(i) = 360: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 365: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 370: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 375: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 380: X(i) = 0.0026899: Y(i) = 0.0002: Z(i) = 0.01226
    i = i + 1: L(i) = 385: X(i) = 0.0053105: Y(i) = 0.00039556: Z(i) = 0.024222
    i = i + 1: L(i) = 390: X(i) = 0.010781: Y(i) = 0.0008: Z(i) = 0.04925
    i = i + 1: L(i) = 395: X(i) = 0.020792: Y(i) = 0.0015457: Z(i) = 0.095135
    i = i + 1: L(i) = 400: X(i) = 0.037981: Y(i) = 0.0028: Z(i) = 0.17409
    i = i + 1: L(i) = 405: X(i) = 0.063157: Y(i) = 0.0046562: Z(i) = 0.29013
    i = i + 1: L(i) = 410: X(i) = 0.099941: Y(i) = 0.0074: Z(i) = 0.46053
    i = i + 1: L(i) = 415: X(i) = 0.15824: Y(i) = 0.011779: Z(i) = 0.73166
    i = i + 1: L(i) = 420: X(i) = 0.22948: Y(i) = 0.0175: Z(i) = 1.0658
    i = i + 1: L(i) = 425: X(i) = 0.28108: Y(i) = 0.022678: Z(i) = 1.3146
    i = i + 1: L(i) = 430: X(i) = 0.31095: Y(i) = 0.0273: Z(i) = 1.4672
    i = i + 1: L(i) = 435: X(i) = 0.33072: Y(i) = 0.032584: Z(i) = 1.5796
    i = i + 1: L(i) = 440: X(i) = 0.33336: Y(i) = 0.0379: Z(i) = 1.6166
    i = i + 1: L(i) = 445: X(i) = 0.31672: Y(i) = 0.042391: Z(i) = 1.5682
    i = i + 1: L(i) = 450: X(i) = 0.28882: Y(i) = 0.0468: Z(i) = 1.4717
    i = i + 1: L(i) = 455: X(i) = 0.25969: Y(i) = 0.052122: Z(i) = 1.374
    i = i + 1: L(i) = 460: X(i) = 0.23276: Y(i) = 0.06: Z(i) = 1.2917
    i = i + 1: L(i) = 465: X(i) = 0.20999: Y(i) = 0.072942: Z(i) = 1.2356
    i = i + 1: L(i) = 470: X(i) = 0.17476: Y(i) = 0.09098: Z(i) = 1.1138
    i = i + 1: L(i) = 475: X(i) = 0.13287: Y(i) = 0.11284: Z(i) = 0.9422
    i = i + 1: L(i) = 480: X(i) = 0.091944: Y(i) = 0.13902: Z(i) = 0.75596
    i = i + 1: L(i) = 485: X(i) = 0.056985: Y(i) = 0.16987: Z(i) = 0.5864
    i = i + 1: L(i) = 490: X(i) = 0.031731: Y(i) = 0.20802: Z(i) = 0.44669
    i = i + 1: L(i) = 495: X(i) = 0.014613: Y(i) = 0.25808: Z(i) = 0.34116
    i = i + 1: L(i) = 500: X(i) = 0.0048491: Y(i) = 0.323: Z(i) = 0.26437
    i = i + 1: L(i) = 505: X(i) = 0.0023215: Y(i) = 0.4054: Z(i) = 0.20594
    i = i + 1: L(i) = 510: X(i) = 0.0092899: Y(i) = 0.503: Z(i) = 0.15445
    i = i + 1: L(i) = 515: X(i) = 0.029278: Y(i) = 0.60811: Z(i) = 0.10918
    i = i + 1: L(i) = 520: X(i) = 0.063791: Y(i) = 0.71: Z(i) = 0.076585
    i = i + 1: L(i) = 525: X(i) = 0.11081: Y(i) = 0.7951: Z(i) = 0.056227
    i = i + 1: L(i) = 530: X(i) = 0.16692: Y(i) = 0.862: Z(i) = 0.041366
    i = i + 1: L(i) = 535: X(i) = 0.22768: Y(i) = 0.91505: Z(i) = 0.029353
    i = i + 1: L(i) = 540: X(i) = 0.29269: Y(i) = 0.954: Z(i) = 0.020042
    i = i + 1: L(i) = 545: X(i) = 0.36225: Y(i) = 0.98004: Z(i) = 0.013312
    i = i + 1: L(i) = 550: X(i) = 0.43635: Y(i) = 0.99495: Z(i) = 0.0087823
    i = i + 1: L(i) = 555: X(i) = 0.51513: Y(i) = 1.0001: Z(i) = 0.0058573
    i = i + 1: L(i) = 560: X(i) = 0.59748: Y(i) = 0.995: Z(i) = 0.0040493
    i = i + 1: L(i) = 565: X(i) = 0.68121: Y(i) = 0.97875: Z(i) = 0.0029217
    i = i + 1: L(i) = 570: X(i) = 0.76425: Y(i) = 0.952: Z(i) = 0.0022771
    i = i + 1: L(i) = 575: X(i) = 0.84394: Y(i) = 0.91558: Z(i) = 0.0019706
    i = i + 1: L(i) = 580: X(i) = 0.91635: Y(i) = 0.87: Z(i) = 0.0018066
    i = i + 1: L(i) = 585: X(i) = 0.97703: Y(i) = 0.81623: Z(i) = 0.0015449
    i = i + 1: L(i) = 590: X(i) = 1.023: Y(i) = 0.757: Z(i) = 0.0012348
    i = i + 1: L(i) = 595: X(i) = 1.0513: Y(i) = 0.69483: Z(i) = 0.0011177
    i = i + 1: L(i) = 600: X(i) = 1.055: Y(i) = 0.631: Z(i) = 0.00090564
    i = i + 1: L(i) = 605: X(i) = 1.0362: Y(i) = 0.56654: Z(i) = 0.00069467
    i = i + 1: L(i) = 610: X(i) = 0.99239: Y(i) = 0.503: Z(i) = 0.00042885
    i = i + 1: L(i) = 615: X(i) = 0.92861: Y(i) = 0.44172: Z(i) = 0.00031817
    i = i + 1: L(i) = 620: X(i) = 0.84346: Y(i) = 0.381: Z(i) = 0.00025598
    i = i + 1: L(i) = 625: X(i) = 0.73983: Y(i) = 0.32052: Z(i) = 0.00015679
    i = i + 1: L(i) = 630: X(i) = 0.63289: Y(i) = 0.265: Z(i) = 0.000097694
    i = i + 1: L(i) = 635: X(i) = 0.53351: Y(i) = 0.21702: Z(i) = 0.000068944
    i = i + 1: L(i) = 640: X(i) = 0.44062: Y(i) = 0.175: Z(i) = 0.000051165
    i = i + 1: L(i) = 645: X(i) = 0.35453: Y(i) = 0.13812: Z(i) = 0.000036016
    i = i + 1: L(i) = 650: X(i) = 0.27862: Y(i) = 0.107: Z(i) = 0.000024238
    i = i + 1: L(i) = 655: X(i) = 0.21485: Y(i) = 0.081652: Z(i) = 0.000016915
    i = i + 1: L(i) = 660: X(i) = 0.16161: Y(i) = 0.061: Z(i) = 0.000011906
    i = i + 1: L(i) = 665: X(i) = 0.1182: Y(i) = 0.044327: Z(i) = 0.0000081489
    i = i + 1: L(i) = 670: X(i) = 0.085753: Y(i) = 0.032: Z(i) = 0.0000056006
    i = i + 1: L(i) = 675: X(i) = 0.063077: Y(i) = 0.023454: Z(i) = 0.0000039544
    i = i + 1: L(i) = 680: X(i) = 0.045834: Y(i) = 0.017: Z(i) = 0.0000027912
    i = i + 1: L(i) = 685: X(i) = 0.032057: Y(i) = 0.011872: Z(i) = 0.0000019176
    i = i + 1: L(i) = 690: X(i) = 0.022187: Y(i) = 0.00821: Z(i) = 0.0000013135
    i = i + 1: L(i) = 695: X(i) = 0.015612: Y(i) = 0.0057723: Z(i) = 0.00000091519
    i = i + 1: L(i) = 700: X(i) = 0.011098: Y(i) = 0.004102: Z(i) = 0.00000064767
    i = i + 1: L(i) = 705: X(i) = 0.0079233: Y(i) = 0.0029291: Z(i) = 0.00000046352
    i = i + 1: L(i) = 710: X(i) = 0.0056531: Y(i) = 0.002091: Z(i) = 0.00000033304
    i = i + 1: L(i) = 715: X(i) = 0.0040039: Y(i) = 0.0014822: Z(i) = 0.00000023823
    i = i + 1: L(i) = 720: X(i) = 0.0028253: Y(i) = 0.001047: Z(i) = 0.00000017026
    i = i + 1: L(i) = 725: X(i) = 0.0019947: Y(i) = 0.00074015: Z(i) = 0.00000012207
    i = i + 1: L(i) = 730: X(i) = 0.0013994: Y(i) = 0.00052: Z(i) = 0.000000087107
    i = i + 1: L(i) = 735: X(i) = 0.0009698: Y(i) = 0.00036093: Z(i) = 0.000000061455
    i = i + 1: L(i) = 740: X(i) = 0.00066847: Y(i) = 0.0002492: Z(i) = 0.000000043162
    i = i + 1: L(i) = 745: X(i) = 0.00046141: Y(i) = 0.00017231: Z(i) = 0.000000030379
    i = i + 1: L(i) = 750: X(i) = 0.00032073: Y(i) = 0.00012: Z(i) = 0.000000021554
    i = i + 1: L(i) = 755: X(i) = 0.00022573: Y(i) = 0.00008462: Z(i) = 0.000000015493
    i = i + 1: L(i) = 760: X(i) = 0.00015973: Y(i) = 0.00006: Z(i) = 0.000000011204
    i = i + 1: L(i) = 765: X(i) = 0.00011275: Y(i) = 0.000042446: Z(i) = 0.0000000080873
    i = i + 1: L(i) = 770: X(i) = 0.000079513: Y(i) = 0.00003: Z(i) = 0.000000005834
    i = i + 1: L(i) = 775: X(i) = 0.000056087: Y(i) = 0.00002121: Z(i) = 0.000000004211
    i = i + 1: L(i) = 780: X(i) = 0.000039541: Y(i) = 0.000014989: Z(i) = 0.0000000030383
    i = i + 1: L(i) = 785: X(i) = 0.000027852: Y(i) = 0.000010584: Z(i) = 0.0000000021907
    i = i + 1: L(i) = 790: X(i) = 0.000019597: Y(i) = 0.0000074656: Z(i) = 0.0000000015778
    i = i + 1: L(i) = 795: X(i) = 0.00001377: Y(i) = 0.0000052592: Z(i) = 0.0000000011348
    i = i + 1: L(i) = 800: X(i) = 0.00000967: Y(i) = 0.0000037028: Z(i) = 0.00000000081565
    i = i + 1: L(i) = 805: X(i) = 0.0000067918: Y(i) = 0.0000026076: Z(i) = 0.00000000058626
    i = i + 1: L(i) = 810: X(i) = 0.0000047706: Y(i) = 0.0000018365: Z(i) = 0.00000000042138
    i = i + 1: L(i) = 815: X(i) = 0.000003355: Y(i) = 0.000001295: Z(i) = 0.00000000030319
    i = i + 1: L(i) = 820: X(i) = 0.0000023534: Y(i) = 0.00000091092: Z(i) = 0.00000000021753
    i = i + 1: L(i) = 825: X(i) = 0.0000016377: Y(i) = 0.00000063564: Z(i) = 0.00000000015476
    i = i + 1: L(i) = 830: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    
    loadCMF1931_Judd_Vos = i
    
End Function

Private Function loadCMF2006_2deg(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double

    i = i + 0: L(i) = 360: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 365: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 370: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 375: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 380: X(i) = 0.0026899: Y(i) = 0.0002: Z(i) = 0.01226
    i = i + 1: L(i) = 385: X(i) = 0.0053105: Y(i) = 0.00039556: Z(i) = 0.024222
    i = i + 1: L(i) = 390: X(i) = 0.003769647:   Y(i) = 0.0004146161:  Z(i) = 0.0184726
    i = i + 1: L(i) = 395: X(i) = 0.009382967:   Y(i) = 0.001059646:   Z(i) = 0.04609784
    i = i + 1: L(i) = 400: X(i) = 0.02214302:    Y(i) = 0.002452194:   Z(i) = 0.109609
    i = i + 1: L(i) = 405: X(i) = 0.04742986:    Y(i) = 0.004971717:   Z(i) = 0.2369246
    i = i + 1: L(i) = 410: X(i) = 0.08953803:    Y(i) = 0.00907986:    Z(i) = 0.4508369
    i = i + 1: L(i) = 415: X(i) = 0.1446214:     Y(i) = 0.01429377:    Z(i) = 0.7378822
    i = i + 1: L(i) = 420: X(i) = 0.2035729:     Y(i) = 0.02027369:    Z(i) = 1.051821
    i = i + 1: L(i) = 425: X(i) = 0.2488523:     Y(i) = 0.02612106:    Z(i) = 1.305008
    i = i + 1: L(i) = 430: X(i) = 0.2918246:     Y(i) = 0.03319038:    Z(i) = 1.552826
    i = i + 1: L(i) = 435: X(i) = 0.3227087:     Y(i) = 0.0415794:     Z(i) = 1.74828
    i = i + 1: L(i) = 440: X(i) = 0.3482554:     Y(i) = 0.05033657:    Z(i) = 1.917479
    i = i + 1: L(i) = 445: X(i) = 0.3418483:     Y(i) = 0.05743393:    Z(i) = 1.918437
    i = i + 1: L(i) = 450: X(i) = 0.3224637:     Y(i) = 0.06472352:    Z(i) = 1.848545
    i = i + 1: L(i) = 455: X(i) = 0.2826646:     Y(i) = 0.07238339:    Z(i) = 1.664439
    i = i + 1: L(i) = 460: X(i) = 0.2485254:     Y(i) = 0.08514816:    Z(i) = 1.522157
    i = i + 1: L(i) = 465: X(i) = 0.2219781:     Y(i) = 0.1060145:     Z(i) = 1.42844
    i = i + 1: L(i) = 470: X(i) = 0.1806905:     Y(i) = 0.1298957:     Z(i) = 1.25061
    i = i + 1: L(i) = 475: X(i) = 0.129192:      Y(i) = 0.1535066:     Z(i) = 0.9991789
    i = i + 1: L(i) = 480: X(i) = 0.08182895:    Y(i) = 0.1788048:     Z(i) = 0.7552379
    i = i + 1: L(i) = 485: X(i) = 0.04600865:    Y(i) = 0.2064828:     Z(i) = 0.5617313
    i = i + 1: L(i) = 490: X(i) = 0.02083981:    Y(i) = 0.237916:      Z(i) = 0.4099313
    i = i + 1: L(i) = 495: X(i) = 0.007097731:   Y(i) = 0.285068:      Z(i) = 0.3105939
    i = i + 1: L(i) = 500: X(i) = 0.002461588:   Y(i) = 0.3483536:     Z(i) = 0.2376753
    i = i + 1: L(i) = 505: X(i) = 0.003649178:   Y(i) = 0.4277595:     Z(i) = 0.1720018
    i = i + 1: L(i) = 510: X(i) = 0.01556989:    Y(i) = 0.5204972:     Z(i) = 0.1176796
    i = i + 1: L(i) = 515: X(i) = 0.04315171:    Y(i) = 0.6206256:     Z(i) = 0.08283548
    i = i + 1: L(i) = 520: X(i) = 0.07962917:    Y(i) = 0.718089:      Z(i) = 0.05650407
    i = i + 1: L(i) = 525: X(i) = 0.1268468:     Y(i) = 0.7946448:     Z(i) = 0.03751912
    i = i + 1: L(i) = 530: X(i) = 0.1818026:     Y(i) = 0.8575799:     Z(i) = 0.02438164
    i = i + 1: L(i) = 535: X(i) = 0.2405015:     Y(i) = 0.9071347:     Z(i) = 0.01566174
    i = i + 1: L(i) = 540: X(i) = 0.3098117:     Y(i) = 0.9544675:     Z(i) = 0.00984647
    i = i + 1: L(i) = 545: X(i) = 0.3804244:     Y(i) = 0.9814106:     Z(i) = 0.006131421
    i = i + 1: L(i) = 550: X(i) = 0.4494206:     Y(i) = 0.9890228:     Z(i) = 0.003790291
    i = i + 1: L(i) = 555: X(i) = 0.5280233:     Y(i) = 0.9994608:     Z(i) = 0.002327186
    i = i + 1: L(i) = 560: X(i) = 0.6133784:     Y(i) = 0.9967737:     Z(i) = 0.001432128
    i = i + 1: L(i) = 565: X(i) = 0.7016774:     Y(i) = 0.9902549:     Z(i) = 0.0008822531
    i = i + 1: L(i) = 570: X(i) = 0.796775:      Y(i) = 0.9732611:     Z(i) = 0.0005452416
    i = i + 1: L(i) = 575: X(i) = 0.8853376:     Y(i) = 0.9424569:     Z(i) = 0.0003386739
    i = i + 1: L(i) = 580: X(i) = 0.9638388:     Y(i) = 0.8963613:     Z(i) = 0.0002117772
    i = i + 1: L(i) = 585: X(i) = 1.051011:      Y(i) = 0.8587203:     Z(i) = 0.0001335031
    i = i + 1: L(i) = 590: X(i) = 1.109767:      Y(i) = 0.8115868:     Z(i) = 0.00008494468
    i = i + 1: L(i) = 595: X(i) = 1.14362:       Y(i) = 0.7544785:     Z(i) = 0.00005460706
    i = i + 1: L(i) = 600: X(i) = 1.151033:      Y(i) = 0.6918553:     Z(i) = 0.00003549661
    i = i + 1: L(i) = 605: X(i) = 1.134757:      Y(i) = 0.6270066:     Z(i) = 0.00002334738
    i = i + 1: L(i) = 610: X(i) = 1.083928:      Y(i) = 0.5583746:     Z(i) = 0.00001554631
    i = i + 1: L(i) = 615: X(i) = 1.007344:      Y(i) = 0.489595:      Z(i) = 0.00001048387
    i = i + 1: L(i) = 620: X(i) = 0.9142877:     Y(i) = 0.4229897:     Z(i) = 0#
    i = i + 1: L(i) = 625: X(i) = 0.8135565:     Y(i) = 0.3609245:     Z(i) = 0#
    i = i + 1: L(i) = 630: X(i) = 0.6924717:     Y(i) = 0.2980865:     Z(i) = 0#
    i = i + 1: L(i) = 635: X(i) = 0.575541:      Y(i) = 0.2416902:     Z(i) = 0#
    i = i + 1: L(i) = 640: X(i) = 0.4731224:     Y(i) = 0.1943124:     Z(i) = 0#
    i = i + 1: L(i) = 645: X(i) = 0.3844986:     Y(i) = 0.1547397:     Z(i) = 0#
    i = i + 1: L(i) = 650: X(i) = 0.2997374:     Y(i) = 0.119312:      Z(i) = 0#
    i = i + 1: L(i) = 655: X(i) = 0.2277792:     Y(i) = 0.08979594:    Z(i) = 0#
    i = i + 1: L(i) = 660: X(i) = 0.1707914:     Y(i) = 0.06671045:    Z(i) = 0#
    i = i + 1: L(i) = 665: X(i) = 0.1263808:     Y(i) = 0.04899699:    Z(i) = 0#
    i = i + 1: L(i) = 670: X(i) = 0.09224597:    Y(i) = 0.03559982:    Z(i) = 0#
    i = i + 1: L(i) = 675: X(i) = 0.0663996:     Y(i) = 0.02554223:    Z(i) = 0#
    i = i + 1: L(i) = 680: X(i) = 0.04710606:    Y(i) = 0.01807939:    Z(i) = 0#
    i = i + 1: L(i) = 685: X(i) = 0.03292138:    Y(i) = 0.01261573:    Z(i) = 0#
    i = i + 1: L(i) = 690: X(i) = 0.02262306:    Y(i) = 0.008661284:   Z(i) = 0#
    i = i + 1: L(i) = 695: X(i) = 0.01575417:    Y(i) = 0.006027677:   Z(i) = 0#
    i = i + 1: L(i) = 700: X(i) = 0.01096778:    Y(i) = 0.004195941:   Z(i) = 0#
    i = i + 1: L(i) = 705: X(i) = 0.00760875:    Y(i) = 0.002910864:   Z(i) = 0#
    i = i + 1: L(i) = 710: X(i) = 0.005214608:   Y(i) = 0.001995557:   Z(i) = 0#
    i = i + 1: L(i) = 715: X(i) = 0.003569452:   Y(i) = 0.001367022:   Z(i) = 0#
    i = i + 1: L(i) = 720: X(i) = 0.002464821:   Y(i) = 0.0009447269:  Z(i) = 0#
    i = i + 1: L(i) = 725: X(i) = 0.001703876:   Y(i) = 0.000653705:   Z(i) = 0#
    i = i + 1: L(i) = 730: X(i) = 0.001186238:   Y(i) = 0.000455597:   Z(i) = 0#
    i = i + 1: L(i) = 735: X(i) = 0.0008269535:  Y(i) = 0.0003179738:  Z(i) = 0#
    i = i + 1: L(i) = 740: X(i) = 0.0005758303:  Y(i) = 0.0002217445:  Z(i) = 0#
    i = i + 1: L(i) = 745: X(i) = 0.0004058303:  Y(i) = 0.0001565566:  Z(i) = 0#
    i = i + 1: L(i) = 750: X(i) = 0.0002856577:  Y(i) = 0.0001103928:  Z(i) = 0#
    i = i + 1: L(i) = 755: X(i) = 0.0002021853:  Y(i) = 0.00007827442: Z(i) = 0#
    i = i + 1: L(i) = 760: X(i) = 0.000143827:   Y(i) = 0.00005578862: Z(i) = 0#
    i = i + 1: L(i) = 765: X(i) = 0.0001024685:  Y(i) = 0.00003981884: Z(i) = 0#
    i = i + 1: L(i) = 770: X(i) = 0.00007347551: Y(i) = 0.00002860175: Z(i) = 0#
    i = i + 1: L(i) = 775: X(i) = 0.0000525987:  Y(i) = 0.00002051259: Z(i) = 0#
    i = i + 1: L(i) = 780: X(i) = 0.00003806114: Y(i) = 0.00001487243: Z(i) = 0#
    i = i + 1: L(i) = 785: X(i) = 0.00002758222: Y(i) = 0.00001080001: Z(i) = 0#
    i = i + 1: L(i) = 790: X(i) = 0.00002004122: Y(i) = 0.00000786392: Z(i) = 0#
    i = i + 1: L(i) = 795: X(i) = 0.00001458792: Y(i) = 0.000005736935: Z(i) = 0#
    i = i + 1: L(i) = 800: X(i) = 0.00001068141: Y(i) = 0.000004211597: Z(i) = 0#
    i = i + 1: L(i) = 805: X(i) = 0.000007857521: Y(i) = 0.000003106561: Z(i) = 0#
    i = i + 1: L(i) = 810: X(i) = 0.000005768284: Y(i) = 0.000002286786: Z(i) = 0#
    i = i + 1: L(i) = 815: X(i) = 0.000004259166: Y(i) = 0.000001693147: Z(i) = 0#
    i = i + 1: L(i) = 820: X(i) = 0.000003167765: Y(i) = 0.000001262556: Z(i) = 0#
    i = i + 1: L(i) = 825: X(i) = 0.000002358723: Y(i) = 0.0000009422514: Z(i) = 0#
    i = i + 1: L(i) = 830: X(i) = 0.000001762465: Y(i) = 0.000000705386: Z(i) = 0#
    
    loadCMF2006_2deg = i
    
End Function

Private Function loadCMF2006_10deg(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double

    i = i + 0: L(i) = 360: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 365: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 370: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 375: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 380: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 385: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 390: X(i) = 0.00295242: Y(i) = 0.0004076779: Z(i) = 0.01318752
    i = i + 1: L(i) = 395: X(i) = 0.007641137: Y(i) = 0.001078166: Z(i) = 0.03424588
    i = i + 1: L(i) = 400: X(i) = 0.01879338: Y(i) = 0.002589775: Z(i) = 0.08508254
    i = i + 1: L(i) = 405: X(i) = 0.04204986: Y(i) = 0.005474207: Z(i) = 0.1927065
    i = i + 1: L(i) = 410: X(i) = 0.08277331: Y(i) = 0.01041303: Z(i) = 0.3832822
    i = i + 1: L(i) = 415: X(i) = 0.1395127: Y(i) = 0.01712968: Z(i) = 0.6568187
    i = i + 1: L(i) = 420: X(i) = 0.2077647: Y(i) = 0.02576133: Z(i) = 0.9933444
    i = i + 1: L(i) = 425: X(i) = 0.2688989: Y(i) = 0.03529554: Z(i) = 1.308674
    i = i + 1: L(i) = 430: X(i) = 0.3281798: Y(i) = 0.04698226: Z(i) = 1.62494
    i = i + 1: L(i) = 435: X(i) = 0.3693084: Y(i) = 0.06047429: Z(i) = 1.867751
    i = i + 1: L(i) = 440: X(i) = 0.4026189: Y(i) = 0.07468288: Z(i) = 2.075946
    i = i + 1: L(i) = 445: X(i) = 0.4042529: Y(i) = 0.08820537: Z(i) = 2.132574
    i = i + 1: L(i) = 450: X(i) = 0.3932139: Y(i) = 0.103903: Z(i) = 2.128264
    i = i + 1: L(i) = 455: X(i) = 0.3482214: Y(i) = 0.1195389: Z(i) = 1.946651
    i = i + 1: L(i) = 460: X(i) = 0.3013112: Y(i) = 0.1414586: Z(i) = 1.76844
    i = i + 1: L(i) = 465: X(i) = 0.2534221: Y(i) = 0.1701373: Z(i) = 1.582342
    i = i + 1: L(i) = 470: X(i) = 0.1914176: Y(i) = 0.1999859: Z(i) = 1.310576
    i = i + 1: L(i) = 475: X(i) = 0.1283167: Y(i) = 0.2312426: Z(i) = 1.010952
    i = i + 1: L(i) = 480: X(i) = 0.0759312: Y(i) = 0.2682271: Z(i) = 0.7516389
    i = i + 1: L(i) = 485: X(i) = 0.0383677: Y(i) = 0.3109438: Z(i) = 0.5549619
    i = i + 1: L(i) = 490: X(i) = 0.01400745: Y(i) = 0.3554018: Z(i) = 0.3978114
    i = i + 1: L(i) = 495: X(i) = 0.00344681: Y(i) = 0.4148227: Z(i) = 0.2905816
    i = i + 1: L(i) = 500: X(i) = 0.005652072: Y(i) = 0.4780482: Z(i) = 0.2078158
    i = i + 1: L(i) = 505: X(i) = 0.01561956: Y(i) = 0.5491344: Z(i) = 0.1394643
    i = i + 1: L(i) = 510: X(i) = 0.03778185: Y(i) = 0.6248296: Z(i) = 0.08852389
    i = i + 1: L(i) = 515: X(i) = 0.07538941: Y(i) = 0.7012292: Z(i) = 0.05824484
    i = i + 1: L(i) = 520: X(i) = 0.1201511: Y(i) = 0.7788199: Z(i) = 0.03784916
    i = i + 1: L(i) = 525: X(i) = 0.1756832: Y(i) = 0.8376358: Z(i) = 0.02431375
    i = i + 1: L(i) = 530: X(i) = 0.2380254: Y(i) = 0.8829552: Z(i) = 0.01539505
    i = i + 1: L(i) = 535: X(i) = 0.3046991: Y(i) = 0.9233858: Z(i) = 0.009753
    i = i + 1: L(i) = 540: X(i) = 0.3841856: Y(i) = 0.9665325: Z(i) = 0.006083223
    i = i + 1: L(i) = 545: X(i) = 0.4633109: Y(i) = 0.9886887: Z(i) = 0.003769336
    i = i + 1: L(i) = 550: X(i) = 0.537417: Y(i) = 0.99075: Z(i) = 0.002323578
    i = i + 1: L(i) = 555: X(i) = 0.6230892: Y(i) = 0.9997775: Z(i) = 0.001426627
    i = i + 1: L(i) = 560: X(i) = 0.7123849: Y(i) = 0.9944304: Z(i) = 0.0008779264
    i = i + 1: L(i) = 565: X(i) = 0.8016277: Y(i) = 0.9848127: Z(i) = 0.0005408385
    i = i + 1: L(i) = 570: X(i) = 0.8933408: Y(i) = 0.9640545: Z(i) = 0.0003342429
    i = i + 1: L(i) = 575: X(i) = 0.9721304: Y(i) = 0.9286495: Z(i) = 0.0002076129
    i = i + 1: L(i) = 580: X(i) = 1.034327: Y(i) = 0.877536: Z(i) = 0.000129823
    i = i + 1: L(i) = 585: X(i) = 1.106886: Y(i) = 0.8370838: Z(i) = 0.00008183954
    i = i + 1: L(i) = 590: X(i) = 1.147304: Y(i) = 0.786995: Z(i) = 0.00005207245
    i = i + 1: L(i) = 595: X(i) = 1.160477: Y(i) = 0.7272309: Z(i) = 0.00003347499
    i = i + 1: L(i) = 600: X(i) = 1.148163: Y(i) = 0.6629035: Z(i) = 0.00002175998
    i = i + 1: L(i) = 605: X(i) = 1.113846: Y(i) = 0.5970375: Z(i) = 0.00001431231
    i = i + 1: L(i) = 610: X(i) = 1.048485: Y(i) = 0.5282296: Z(i) = 0.00000953013
    i = i + 1: L(i) = 615: X(i) = 0.9617111: Y(i) = 0.4601308: Z(i) = 0.000006426776
    i = i + 1: L(i) = 620: X(i) = 0.8629581: Y(i) = 0.3950755: Z(i) = 0#
    i = i + 1: L(i) = 625: X(i) = 0.7603498: Y(i) = 0.3351794: Z(i) = 0#
    i = i + 1: L(i) = 630: X(i) = 0.6413984: Y(i) = 0.2751807: Z(i) = 0#
    i = i + 1: L(i) = 635: X(i) = 0.5290979: Y(i) = 0.2219564: Z(i) = 0#
    i = i + 1: L(i) = 640: X(i) = 0.4323126: Y(i) = 0.1776882: Z(i) = 0#
    i = i + 1: L(i) = 645: X(i) = 0.3496358: Y(i) = 0.1410203: Z(i) = 0#
    i = i + 1: L(i) = 650: X(i) = 0.27149: Y(i) = 0.1083996: Z(i) = 0#
    i = i + 1: L(i) = 655: X(i) = 0.2056507: Y(i) = 0.08137687: Z(i) = 0#
    i = i + 1: L(i) = 660: X(i) = 0.1538163: Y(i) = 0.06033976: Z(i) = 0#
    i = i + 1: L(i) = 665: X(i) = 0.1136072: Y(i) = 0.04425383: Z(i) = 0#
    i = i + 1: L(i) = 670: X(i) = 0.0828101: Y(i) = 0.03211852: Z(i) = 0#
    i = i + 1: L(i) = 675: X(i) = 0.05954815: Y(i) = 0.02302574: Z(i) = 0#
    i = i + 1: L(i) = 680: X(i) = 0.04221473: Y(i) = 0.01628841: Z(i) = 0#
    i = i + 1: L(i) = 685: X(i) = 0.02948752: Y(i) = 0.01136106: Z(i) = 0#
    i = i + 1: L(i) = 690: X(i) = 0.0202559: Y(i) = 0.007797457: Z(i) = 0#
    i = i + 1: L(i) = 695: X(i) = 0.0141023: Y(i) = 0.005425391: Z(i) = 0#
    i = i + 1: L(i) = 700: X(i) = 0.009816228: Y(i) = 0.00377614: Z(i) = 0#
    i = i + 1: L(i) = 705: X(i) = 0.006809147: Y(i) = 0.002619372: Z(i) = 0#
    i = i + 1: L(i) = 710: X(i) = 0.004666298: Y(i) = 0.001795595: Z(i) = 0#
    i = i + 1: L(i) = 715: X(i) = 0.003194041: Y(i) = 0.00122998: Z(i) = 0#
    i = i + 1: L(i) = 720: X(i) = 0.002205568: Y(i) = 0.0008499903: Z(i) = 0#
    i = i + 1: L(i) = 725: X(i) = 0.001524672: Y(i) = 0.0005881375: Z(i) = 0#
    i = i + 1: L(i) = 730: X(i) = 0.001061495: Y(i) = 0.0004098928: Z(i) = 0#
    i = i + 1: L(i) = 735: X(i) = 0.000740012: Y(i) = 0.0002860718: Z(i) = 0#
    i = i + 1: L(i) = 740: X(i) = 0.0005153113: Y(i) = 0.0001994949: Z(i) = 0#
    i = i + 1: L(i) = 745: X(i) = 0.0003631969: Y(i) = 0.0001408466: Z(i) = 0#
    i = i + 1: L(i) = 750: X(i) = 0.0002556624: Y(i) = 0.00009931439: Z(i) = 0#
    i = i + 1: L(i) = 755: X(i) = 0.0001809649: Y(i) = 0.00007041878: Z(i) = 0#
    i = i + 1: L(i) = 760: X(i) = 0.0001287394: Y(i) = 0.00005018934: Z(i) = 0#
    i = i + 1: L(i) = 765: X(i) = 0.00009172477: Y(i) = 0.00003582218: Z(i) = 0#
    i = i + 1: L(i) = 770: X(i) = 0.00006577532: Y(i) = 0.00002573083: Z(i) = 0#
    i = i + 1: L(i) = 775: X(i) = 0.00004708916: Y(i) = 0.00001845353: Z(i) = 0#
    i = i + 1: L(i) = 780: X(i) = 0.00003407653: Y(i) = 0.00001337946: Z(i) = 0#
    i = i + 1: L(i) = 785: X(i) = 0.0000246963: Y(i) = 0.000009715798: Z(i) = 0#
    i = i + 1: L(i) = 790: X(i) = 0.00001794555: Y(i) = 0.000007074424: Z(i) = 0#
    i = i + 1: L(i) = 795: X(i) = 0.00001306345: Y(i) = 0.000005160948: Z(i) = 0#
    i = i + 1: L(i) = 800: X(i) = 0.000009565993: Y(i) = 0.000003788729: Z(i) = 0#
    i = i + 1: L(i) = 805: X(i) = 0.000007037621: Y(i) = 0.000002794625: Z(i) = 0#
    i = i + 1: L(i) = 810: X(i) = 0.000005166853: Y(i) = 0.000002057152: Z(i) = 0#
    i = i + 1: L(i) = 815: X(i) = 0.000003815429: Y(i) = 0.000001523114: Z(i) = 0#
    i = i + 1: L(i) = 820: X(i) = 0.00000283798: Y(i) = 0.000001135758: Z(i) = 0#
    i = i + 1: L(i) = 825: X(i) = 0.000002113325: Y(i) = 0.0000008476168: Z(i) = 0#
    i = i + 1: L(i) = 830: X(i) = 0.000001579199: Y(i) = 0.000000634538: Z(i) = 0#
    
    loadCMF2006_10deg = i
    
End Function

Private Function loadCCTxyTable1931(X() As Double, Y() As Double) As Integer
    Dim i As Integer: i = 0
    Dim t(901) As Double
    
    i = i + 0: t(i) = 1000: X(i) = 0.652751748: Y(i) = 0.344460656
    i = i + 1: t(i) = 1010: X(i) = 0.651340466: Y(i) = 0.345708667
    i = i + 1: t(i) = 1020: X(i) = 0.649931671: Y(i) = 0.346947304
    i = i + 1: t(i) = 1030: X(i) = 0.648525422: Y(i) = 0.348176371
    i = i + 1: t(i) = 1040: X(i) = 0.647121774: Y(i) = 0.349395678
    i = i + 1: t(i) = 1050: X(i) = 0.645720775: Y(i) = 0.350605045
    i = i + 1: t(i) = 1060: X(i) = 0.644322469: Y(i) = 0.351804301
    i = i + 1: t(i) = 1070: X(i) = 0.642926896: Y(i) = 0.352993281
    i = i + 1: t(i) = 1080: X(i) = 0.641534092: Y(i) = 0.35417183
    i = i + 1: t(i) = 1090: X(i) = 0.640144089: Y(i) = 0.3553398
    i = i + 1: t(i) = 1100: X(i) = 0.638756915: Y(i) = 0.356497049
    i = i + 1: t(i) = 1110: X(i) = 0.637372596: Y(i) = 0.357643444
    i = i + 1: t(i) = 1120: X(i) = 0.635991154: Y(i) = 0.358778858
    i = i + 1: t(i) = 1130: X(i) = 0.634612609: Y(i) = 0.359903173
    i = i + 1: t(i) = 1140: X(i) = 0.63323698: Y(i) = 0.361016274
    i = i + 1: t(i) = 1150: X(i) = 0.631864281: Y(i) = 0.362118055
    i = i + 1: t(i) = 1160: X(i) = 0.630494526: Y(i) = 0.363208416
    i = i + 1: t(i) = 1170: X(i) = 0.629127727: Y(i) = 0.364287263
    i = i + 1: t(i) = 1180: X(i) = 0.627763895: Y(i) = 0.365354508
    i = i + 1: t(i) = 1190: X(i) = 0.626403038: Y(i) = 0.366410069
    i = i + 1: t(i) = 1200: X(i) = 0.625045165: Y(i) = 0.36745387
    i = i + 1: t(i) = 1210: X(i) = 0.623690283: Y(i) = 0.368485841
    i = i + 1: t(i) = 1220: X(i) = 0.622338397: Y(i) = 0.369505915
    i = i + 1: t(i) = 1230: X(i) = 0.620989512: Y(i) = 0.370514033
    i = i + 1: t(i) = 1240: X(i) = 0.619643634: Y(i) = 0.37151014
    i = i + 1: t(i) = 1250: X(i) = 0.618300766: Y(i) = 0.372494187
    i = i + 1: t(i) = 1260: X(i) = 0.616960912: Y(i) = 0.373466129
    i = i + 1: t(i) = 1270: X(i) = 0.615624076: Y(i) = 0.374425927
    i = i + 1: t(i) = 1280: X(i) = 0.61429026: Y(i) = 0.375373545
    i = i + 1: t(i) = 1290: X(i) = 0.612959468: Y(i) = 0.376308952
    i = i + 1: t(i) = 1300: X(i) = 0.611631702: Y(i) = 0.377232124
    i = i + 1: t(i) = 1310: X(i) = 0.610306965: Y(i) = 0.378143037
    i = i + 1: t(i) = 1320: X(i) = 0.608985261: Y(i) = 0.379041676
    i = i + 1: t(i) = 1330: X(i) = 0.607666593: Y(i) = 0.379928026
    i = i + 1: t(i) = 1340: X(i) = 0.606350963: Y(i) = 0.38080208
    i = i + 1: t(i) = 1350: X(i) = 0.605038376: Y(i) = 0.381663831
    i = i + 1: t(i) = 1360: X(i) = 0.603728834: Y(i) = 0.382513278
    i = i + 1: t(i) = 1370: X(i) = 0.602422343: Y(i) = 0.383350424
    i = i + 1: t(i) = 1380: X(i) = 0.601118905: Y(i) = 0.384175276
    i = i + 1: t(i) = 1390: X(i) = 0.599818527: Y(i) = 0.384987842
    i = i + 1: t(i) = 1400: X(i) = 0.598521212: Y(i) = 0.385788136
    i = i + 1: t(i) = 1410: X(i) = 0.597226967: Y(i) = 0.386576175
    i = i + 1: t(i) = 1420: X(i) = 0.595935797: Y(i) = 0.387351979
    i = i + 1: t(i) = 1430: X(i) = 0.594647708: Y(i) = 0.38811557
    i = i + 1: t(i) = 1440: X(i) = 0.593362706: Y(i) = 0.388866975
    i = i + 1: t(i) = 1450: X(i) = 0.5920808: Y(i) = 0.389606224
    i = i + 1: t(i) = 1460: X(i) = 0.590801995: Y(i) = 0.390333347
    i = i + 1: t(i) = 1470: X(i) = 0.589526301: Y(i) = 0.391048381
    i = i + 1: t(i) = 1480: X(i) = 0.588253724: Y(i) = 0.391751363
    i = i + 1: t(i) = 1490: X(i) = 0.586984275: Y(i) = 0.392442334
    i = i + 1: t(i) = 1500: X(i) = 0.585717961: Y(i) = 0.393121336
    i = i + 1: t(i) = 1510: X(i) = 0.584454793: Y(i) = 0.393788415
    i = i + 1: t(i) = 1520: X(i) = 0.58319478: Y(i) = 0.394443619
    i = i + 1: t(i) = 1530: X(i) = 0.581937932: Y(i) = 0.395086999
    i = i + 1: t(i) = 1540: X(i) = 0.58068426: Y(i) = 0.395718607
    i = i + 1: t(i) = 1550: X(i) = 0.579433776: Y(i) = 0.396338498
    i = i + 1: t(i) = 1560: X(i) = 0.578186489: Y(i) = 0.396946729
    i = i + 1: t(i) = 1570: X(i) = 0.576942413: Y(i) = 0.397543359
    i = i + 1: t(i) = 1580: X(i) = 0.575701559: Y(i) = 0.39812845
    i = i + 1: t(i) = 1590: X(i) = 0.574463938: Y(i) = 0.398702063
    i = i + 1: t(i) = 1600: X(i) = 0.573229565: Y(i) = 0.399264264
    i = i + 1: t(i) = 1610: X(i) = 0.571998451: Y(i) = 0.39981512
    i = i + 1: t(i) = 1620: X(i) = 0.57077061: Y(i) = 0.400354699
    i = i + 1: t(i) = 1630: X(i) = 0.569546055: Y(i) = 0.40088307
    i = i + 1: t(i) = 1640: X(i) = 0.568324799: Y(i) = 0.401400305
    i = i + 1: t(i) = 1650: X(i) = 0.567106857: Y(i) = 0.401906477
    i = i + 1: t(i) = 1660: X(i) = 0.565892242: Y(i) = 0.40240166
    i = i + 1: t(i) = 1670: X(i) = 0.564680968: Y(i) = 0.402885931
    i = i + 1: t(i) = 1680: X(i) = 0.563473049: Y(i) = 0.403359366
    i = i + 1: t(i) = 1690: X(i) = 0.5622685: Y(i) = 0.403822044
    i = i + 1: t(i) = 1700: X(i) = 0.561067335: Y(i) = 0.404274043
    i = i + 1: t(i) = 1710: X(i) = 0.559869569: Y(i) = 0.404715446
    i = i + 1: t(i) = 1720: X(i) = 0.558675216: Y(i) = 0.405146333
    i = i + 1: t(i) = 1730: X(i) = 0.557484292: Y(i) = 0.405566788
    i = i + 1: t(i) = 1740: X(i) = 0.556296809: Y(i) = 0.405976894
    i = i + 1: t(i) = 1750: X(i) = 0.555112785: Y(i) = 0.406376735
    i = i + 1: t(i) = 1760: X(i) = 0.553932232: Y(i) = 0.406766398
    i = i + 1: t(i) = 1770: X(i) = 0.552755166: Y(i) = 0.407145968
    i = i + 1: t(i) = 1780: X(i) = 0.551581602: Y(i) = 0.407515532
    i = i + 1: t(i) = 1790: X(i) = 0.550411553: Y(i) = 0.407875179
    i = i + 1: t(i) = 1800: X(i) = 0.549245035: Y(i) = 0.408224997
    i = i + 1: t(i) = 1810: X(i) = 0.548082062: Y(i) = 0.408565074
    i = i + 1: t(i) = 1820: X(i) = 0.546922649: Y(i) = 0.4088955
    i = i + 1: t(i) = 1830: X(i) = 0.54576681: Y(i) = 0.409216366
    i = i + 1: t(i) = 1840: X(i) = 0.544614558: Y(i) = 0.409527761
    i = i + 1: t(i) = 1850: X(i) = 0.543465908: Y(i) = 0.409829777
    i = i + 1: t(i) = 1860: X(i) = 0.542320874: Y(i) = 0.410122505
    i = i + 1: t(i) = 1870: X(i) = 0.541179469: Y(i) = 0.410406037
    i = i + 1: t(i) = 1880: X(i) = 0.540041707: Y(i) = 0.410680465
    i = i + 1: t(i) = 1890: X(i) = 0.538907602: Y(i) = 0.41094588
    i = i + 1: t(i) = 1900: X(i) = 0.537777166: Y(i) = 0.411202376
    i = i + 1: t(i) = 1910: X(i) = 0.536650412: Y(i) = 0.411450045
    i = i + 1: t(i) = 1920: X(i) = 0.535527354: Y(i) = 0.411688979
    i = i + 1: t(i) = 1930: X(i) = 0.534408003: Y(i) = 0.411919272
    i = i + 1: t(i) = 1940: X(i) = 0.533292372: Y(i) = 0.412141017
    i = i + 1: t(i) = 1950: X(i) = 0.532180473: Y(i) = 0.412354305
    i = i + 1: t(i) = 1960: X(i) = 0.531072318: Y(i) = 0.412559232
    i = i + 1: t(i) = 1970: X(i) = 0.529967917: Y(i) = 0.412755889
    i = i + 1: t(i) = 1980: X(i) = 0.528867283: Y(i) = 0.412944369
    i = i + 1: t(i) = 1990: X(i) = 0.527770427: Y(i) = 0.413124765
    i = i + 1: t(i) = 2000: X(i) = 0.526677358: Y(i) = 0.41329717
    i = i + 1: t(i) = 2010: X(i) = 0.525588087: Y(i) = 0.413461677
    i = i + 1: t(i) = 2020: X(i) = 0.524502625: Y(i) = 0.413618377
    i = i + 1: t(i) = 2030: X(i) = 0.523420981: Y(i) = 0.413767364
    i = i + 1: t(i) = 2040: X(i) = 0.522343164: Y(i) = 0.413908728
    i = i + 1: t(i) = 2050: X(i) = 0.521269184: Y(i) = 0.414042562
    i = i + 1: t(i) = 2060: X(i) = 0.52019905: Y(i) = 0.414168957
    i = i + 1: t(i) = 2070: X(i) = 0.51913277: Y(i) = 0.414288005
    i = i + 1: t(i) = 2080: X(i) = 0.518070352: Y(i) = 0.414399795
    i = i + 1: t(i) = 2090: X(i) = 0.517011803: Y(i) = 0.41450442
    i = i + 1: t(i) = 2100: X(i) = 0.515957133: Y(i) = 0.414601968
    i = i + 1: t(i) = 2110: X(i) = 0.514906347: Y(i) = 0.414692529
    i = i + 1: t(i) = 2120: X(i) = 0.513859453: Y(i) = 0.414776194
    i = i + 1: t(i) = 2130: X(i) = 0.512816456: Y(i) = 0.414853051
    i = i + 1: t(i) = 2140: X(i) = 0.511777364: Y(i) = 0.414923188
    i = i + 1: t(i) = 2150: X(i) = 0.510742182: Y(i) = 0.414986693
    i = i + 1: t(i) = 2160: X(i) = 0.509710916: Y(i) = 0.415043655
    i = i + 1: t(i) = 2170: X(i) = 0.50868357: Y(i) = 0.41509416
    i = i + 1: t(i) = 2180: X(i) = 0.507660149: Y(i) = 0.415138295
    i = i + 1: t(i) = 2190: X(i) = 0.506640659: Y(i) = 0.415176147
    i = i + 1: t(i) = 2200: X(i) = 0.505625102: Y(i) = 0.415207799
    i = i + 1: t(i) = 2210: X(i) = 0.504613483: Y(i) = 0.415233339
    i = i + 1: t(i) = 2220: X(i) = 0.503605806: Y(i) = 0.41525285
    i = i + 1: t(i) = 2230: X(i) = 0.502602072: Y(i) = 0.415266416
    i = i + 1: t(i) = 2240: X(i) = 0.501602286: Y(i) = 0.41527412
    i = i + 1: t(i) = 2250: X(i) = 0.500606449: Y(i) = 0.415276046
    i = i + 1: t(i) = 2260: X(i) = 0.499614563: Y(i) = 0.415272276
    i = i + 1: t(i) = 2270: X(i) = 0.498626631: Y(i) = 0.415262891
    i = i + 1: t(i) = 2280: X(i) = 0.497642653: Y(i) = 0.415247972
    i = i + 1: t(i) = 2290: X(i) = 0.49666263: Y(i) = 0.4152276
    i = i + 1: t(i) = 2300: X(i) = 0.495686564: Y(i) = 0.415201855
    i = i + 1: t(i) = 2310: X(i) = 0.494714455: Y(i) = 0.415170815
    i = i + 1: t(i) = 2320: X(i) = 0.493746302: Y(i) = 0.415134559
    i = i + 1: t(i) = 2330: X(i) = 0.492782106: Y(i) = 0.415093164
    i = i + 1: t(i) = 2340: X(i) = 0.491821865: Y(i) = 0.415046709
    i = i + 1: t(i) = 2350: X(i) = 0.49086558: Y(i) = 0.41499527
    i = i + 1: t(i) = 2360: X(i) = 0.489913248: Y(i) = 0.414938922
    i = i + 1: t(i) = 2370: X(i) = 0.488964869: Y(i) = 0.414877741
    i = i + 1: t(i) = 2380: X(i) = 0.48802044: Y(i) = 0.4148118
    i = i + 1: t(i) = 2390: X(i) = 0.487079959: Y(i) = 0.414741175
    i = i + 1: t(i) = 2400: X(i) = 0.486143425: Y(i) = 0.414665939
    i = i + 1: t(i) = 2410: X(i) = 0.485210833: Y(i) = 0.414586163
    i = i + 1: t(i) = 2420: X(i) = 0.484282181: Y(i) = 0.414501919
    i = i + 1: t(i) = 2430: X(i) = 0.483357466: Y(i) = 0.41441328
    i = i + 1: t(i) = 2440: X(i) = 0.482436685: Y(i) = 0.414320314
    i = i + 1: t(i) = 2450: X(i) = 0.481519832: Y(i) = 0.414223093
    i = i + 1: t(i) = 2460: X(i) = 0.480606905: Y(i) = 0.414121684
    i = i + 1: t(i) = 2470: X(i) = 0.479697898: Y(i) = 0.414016157
    i = i + 1: t(i) = 2480: X(i) = 0.478792807: Y(i) = 0.413906579
    i = i + 1: t(i) = 2490: X(i) = 0.477891627: Y(i) = 0.413793016
    i = i + 1: t(i) = 2500: X(i) = 0.476994352: Y(i) = 0.413675536
    i = i + 1: t(i) = 2510: X(i) = 0.476100978: Y(i) = 0.413554204
    i = i + 1: t(i) = 2520: X(i) = 0.475211498: Y(i) = 0.413429085
    i = i + 1: t(i) = 2530: X(i) = 0.474325906: Y(i) = 0.413300242
    i = i + 1: t(i) = 2540: X(i) = 0.473444197: Y(i) = 0.41316774
    i = i + 1: t(i) = 2550: X(i) = 0.472566363: Y(i) = 0.413031642
    i = i + 1: t(i) = 2560: X(i) = 0.471692398: Y(i) = 0.412892009
    i = i + 1: t(i) = 2570: X(i) = 0.470822295: Y(i) = 0.412748902
    i = i + 1: t(i) = 2580: X(i) = 0.469956046: Y(i) = 0.412602384
    i = i + 1: t(i) = 2590: X(i) = 0.469093645: Y(i) = 0.412452513
    i = i + 1: t(i) = 2600: X(i) = 0.468235084: Y(i) = 0.41229935
    i = i + 1: t(i) = 2610: X(i) = 0.467380354: Y(i) = 0.412142952
    i = i + 1: t(i) = 2620: X(i) = 0.466529448: Y(i) = 0.411983378
    i = i + 1: t(i) = 2630: X(i) = 0.465682357: Y(i) = 0.411820686
    i = i + 1: t(i) = 2640: X(i) = 0.464839073: Y(i) = 0.411654931
    i = i + 1: t(i) = 2650: X(i) = 0.463999588: Y(i) = 0.411486171
    i = i + 1: t(i) = 2660: X(i) = 0.463163892: Y(i) = 0.41131446
    i = i + 1: t(i) = 2670: X(i) = 0.462331976: Y(i) = 0.411139853
    i = i + 1: t(i) = 2680: X(i) = 0.461503831: Y(i) = 0.410962404
    i = i + 1: t(i) = 2690: X(i) = 0.460679448: Y(i) = 0.410782167
    i = i + 1: t(i) = 2700: X(i) = 0.459858817: Y(i) = 0.410599194
    i = i + 1: t(i) = 2710: X(i) = 0.459041928: Y(i) = 0.410413538
    i = i + 1: t(i) = 2720: X(i) = 0.458228771: Y(i) = 0.410225249
    i = i + 1: t(i) = 2730: X(i) = 0.457419337: Y(i) = 0.410034379
    i = i + 1: t(i) = 2740: X(i) = 0.456613614: Y(i) = 0.409840978
    i = i + 1: t(i) = 2750: X(i) = 0.455811593: Y(i) = 0.409645095
    i = i + 1: t(i) = 2760: X(i) = 0.455013263: Y(i) = 0.40944678
    i = i + 1: t(i) = 2770: X(i) = 0.454218613: Y(i) = 0.40924608
    i = i + 1: t(i) = 2780: X(i) = 0.453427632: Y(i) = 0.409043044
    i = i + 1: t(i) = 2790: X(i) = 0.45264031: Y(i) = 0.408837718
    i = i + 1: t(i) = 2800: X(i) = 0.451856635: Y(i) = 0.408630148
    i = i + 1: t(i) = 2810: X(i) = 0.451076595: Y(i) = 0.408420382
    i = i + 1: t(i) = 2820: X(i) = 0.45030018: Y(i) = 0.408208463
    i = i + 1: t(i) = 2830: X(i) = 0.449527378: Y(i) = 0.407994437
    i = i + 1: t(i) = 2840: X(i) = 0.448758177: Y(i) = 0.407778348
    i = i + 1: t(i) = 2850: X(i) = 0.447992566: Y(i) = 0.407560239
    i = i + 1: t(i) = 2860: X(i) = 0.447230532: Y(i) = 0.407340153
    i = i + 1: t(i) = 2870: X(i) = 0.446472063: Y(i) = 0.407118133
    i = i + 1: t(i) = 2880: X(i) = 0.445717148: Y(i) = 0.40689422
    i = i + 1: t(i) = 2890: X(i) = 0.444965775: Y(i) = 0.406668455
    i = i + 1: t(i) = 2900: X(i) = 0.44421793: Y(i) = 0.406440879
    i = i + 1: t(i) = 2910: X(i) = 0.443473602: Y(i) = 0.406211533
    i = i + 1: t(i) = 2920: X(i) = 0.442732777: Y(i) = 0.405980455
    i = i + 1: t(i) = 2930: X(i) = 0.441995445: Y(i) = 0.405747685
    i = i + 1: t(i) = 2940: X(i) = 0.441261591: Y(i) = 0.405513261
    i = i + 1: t(i) = 2950: X(i) = 0.440531203: Y(i) = 0.405277221
    i = i + 1: t(i) = 2960: X(i) = 0.439804268: Y(i) = 0.405039603
    i = i + 1: t(i) = 2970: X(i) = 0.439080773: Y(i) = 0.404800443
    i = i + 1: t(i) = 2980: X(i) = 0.438360706: Y(i) = 0.404559777
    i = i + 1: t(i) = 2990: X(i) = 0.437644053: Y(i) = 0.404317643
    i = i + 1: t(i) = 3000: X(i) = 0.436930801: Y(i) = 0.404074074
    i = i + 1: t(i) = 3010: X(i) = 0.436220937: Y(i) = 0.403829106
    i = i + 1: t(i) = 3020: X(i) = 0.435514448: Y(i) = 0.403582773
    i = i + 1: t(i) = 3030: X(i) = 0.43481132: Y(i) = 0.403335109
    i = i + 1: t(i) = 3040: X(i) = 0.43411154: Y(i) = 0.403086148
    i = i + 1: t(i) = 3050: X(i) = 0.433415095: Y(i) = 0.402835921
    i = i + 1: t(i) = 3060: X(i) = 0.432721971: Y(i) = 0.402584462
    i = i + 1: t(i) = 3070: X(i) = 0.432032154: Y(i) = 0.402331803
    i = i + 1: t(i) = 3080: X(i) = 0.431345632: Y(i) = 0.402077974
    i = i + 1: t(i) = 3090: X(i) = 0.43066239: Y(i) = 0.401823008
    i = i + 1: t(i) = 3100: X(i) = 0.429982415: Y(i) = 0.401566934
    i = i + 1: t(i) = 3110: X(i) = 0.429305693: Y(i) = 0.401309782
    i = i + 1: t(i) = 3120: X(i) = 0.42863221: Y(i) = 0.401051583
    i = i + 1: t(i) = 3130: X(i) = 0.427961954: Y(i) = 0.400792366
    i = i + 1: t(i) = 3140: X(i) = 0.427294909: Y(i) = 0.400532158
    i = i + 1: t(i) = 3150: X(i) = 0.426631062: Y(i) = 0.400270989
    i = i + 1: t(i) = 3160: X(i) = 0.4259704: Y(i) = 0.400008887
    i = i + 1: t(i) = 3170: X(i) = 0.425312908: Y(i) = 0.399745879
    i = i + 1: t(i) = 3180: X(i) = 0.424658573: Y(i) = 0.399481992
    i = i + 1: t(i) = 3190: X(i) = 0.424007381: Y(i) = 0.399217252
    i = i + 1: t(i) = 3200: X(i) = 0.423359317: Y(i) = 0.398951687
    i = i + 1: t(i) = 3210: X(i) = 0.422714368: Y(i) = 0.398685322
    i = i + 1: t(i) = 3220: X(i) = 0.422072521: Y(i) = 0.398418181
    i = i + 1: t(i) = 3230: X(i) = 0.42143376: Y(i) = 0.398150292
    i = i + 1: t(i) = 3240: X(i) = 0.420798073: Y(i) = 0.397881677
    i = i + 1: t(i) = 3250: X(i) = 0.420165444: Y(i) = 0.397612362
    i = i + 1: t(i) = 3260: X(i) = 0.419535861: Y(i) = 0.397342371
    i = i + 1: t(i) = 3270: X(i) = 0.418909309: Y(i) = 0.397071726
    i = i + 1: t(i) = 3280: X(i) = 0.418285775: Y(i) = 0.396800452
    i = i + 1: t(i) = 3290: X(i) = 0.417665244: Y(i) = 0.39652857
    i = i + 1: t(i) = 3300: X(i) = 0.417047702: Y(i) = 0.396256104
    i = i + 1: t(i) = 3310: X(i) = 0.416433135: Y(i) = 0.395983076
    i = i + 1: t(i) = 3320: X(i) = 0.41582153: Y(i) = 0.395709507
    i = i + 1: t(i) = 3330: X(i) = 0.415212873: Y(i) = 0.395435419
    i = i + 1: t(i) = 3340: X(i) = 0.414607149: Y(i) = 0.395160832
    i = i + 1: t(i) = 3350: X(i) = 0.414004345: Y(i) = 0.394885768
    i = i + 1: t(i) = 3360: X(i) = 0.413404447: Y(i) = 0.394610248
    i = i + 1: t(i) = 3370: X(i) = 0.41280744: Y(i) = 0.39433429
    i = i + 1: t(i) = 3380: X(i) = 0.412213312: Y(i) = 0.394057915
    i = i + 1: t(i) = 3390: X(i) = 0.411622047: Y(i) = 0.393781143
    i = i + 1: t(i) = 3400: X(i) = 0.411033633: Y(i) = 0.393503992
    i = i + 1: t(i) = 3410: X(i) = 0.410448055: Y(i) = 0.393226481
    i = i + 1: t(i) = 3420: X(i) = 0.4098653: Y(i) = 0.392948629
    i = i + 1: t(i) = 3430: X(i) = 0.409285354: Y(i) = 0.392670454
    i = i + 1: t(i) = 3440: X(i) = 0.408708203: Y(i) = 0.392391974
    i = i + 1: t(i) = 3450: X(i) = 0.408133833: Y(i) = 0.392113206
    i = i + 1: t(i) = 3460: X(i) = 0.407562231: Y(i) = 0.391834168
    i = i + 1: t(i) = 3470: X(i) = 0.406993383: Y(i) = 0.391554877
    i = i + 1: t(i) = 3480: X(i) = 0.406427275: Y(i) = 0.39127535
    i = i + 1: t(i) = 3490: X(i) = 0.405863894: Y(i) = 0.390995603
    i = i + 1: t(i) = 3500: X(i) = 0.405303226: Y(i) = 0.390715652
    i = i + 1: t(i) = 3510: X(i) = 0.404745257: Y(i) = 0.390435514
    i = i + 1: t(i) = 3520: X(i) = 0.404189974: Y(i) = 0.390155203
    i = i + 1: t(i) = 3530: X(i) = 0.403637363: Y(i) = 0.389874736
    i = i + 1: t(i) = 3540: X(i) = 0.403087411: Y(i) = 0.389594127
    i = i + 1: t(i) = 3550: X(i) = 0.402540105: Y(i) = 0.389313391
    i = i + 1: t(i) = 3560: X(i) = 0.401995431: Y(i) = 0.389032543
    i = i + 1: t(i) = 3570: X(i) = 0.401453375: Y(i) = 0.388751598
    i = i + 1: t(i) = 3580: X(i) = 0.400913925: Y(i) = 0.388470569
    i = i + 1: t(i) = 3590: X(i) = 0.400377067: Y(i) = 0.38818947
    i = i + 1: t(i) = 3600: X(i) = 0.399842787: Y(i) = 0.387908316
    i = i + 1: t(i) = 3610: X(i) = 0.399311073: Y(i) = 0.387627119
    i = i + 1: t(i) = 3620: X(i) = 0.398781912: Y(i) = 0.387345892
    i = i + 1: t(i) = 3630: X(i) = 0.398255289: Y(i) = 0.387064649
    i = i + 1: t(i) = 3640: X(i) = 0.397731193: Y(i) = 0.386783402
    i = i + 1: t(i) = 3650: X(i) = 0.397209609: Y(i) = 0.386502164
    i = i + 1: t(i) = 3660: X(i) = 0.396690525: Y(i) = 0.386220947
    i = i + 1: t(i) = 3670: X(i) = 0.396173929: Y(i) = 0.385939762
    i = i + 1: t(i) = 3680: X(i) = 0.395659806: Y(i) = 0.385658623
    i = i + 1: t(i) = 3690: X(i) = 0.395148145: Y(i) = 0.385377541
    i = i + 1: t(i) = 3700: X(i) = 0.394638932: Y(i) = 0.385096526
    i = i + 1: t(i) = 3710: X(i) = 0.394132154: Y(i) = 0.384815591
    i = i + 1: t(i) = 3720: X(i) = 0.393627799: Y(i) = 0.384534745
    i = i + 1: t(i) = 3730: X(i) = 0.393125854: Y(i) = 0.384254001
    i = i + 1: t(i) = 3740: X(i) = 0.392626306: Y(i) = 0.383973369
    i = i + 1: t(i) = 3750: X(i) = 0.392129143: Y(i) = 0.383692858
    i = i + 1: t(i) = 3760: X(i) = 0.391634352: Y(i) = 0.38341248
    i = i + 1: t(i) = 3770: X(i) = 0.391141921: Y(i) = 0.383132244
    i = i + 1: t(i) = 3780: X(i) = 0.390651837: Y(i) = 0.382852161
    i = i + 1: t(i) = 3790: X(i) = 0.390164087: Y(i) = 0.382572239
    i = i + 1: t(i) = 3800: X(i) = 0.38967866: Y(i) = 0.382292489
    i = i + 1: t(i) = 3810: X(i) = 0.389195543: Y(i) = 0.38201292
    i = i + 1: t(i) = 3820: X(i) = 0.388714723: Y(i) = 0.381733541
    i = i + 1: t(i) = 3830: X(i) = 0.388236189: Y(i) = 0.38145436
    i = i + 1: t(i) = 3840: X(i) = 0.387759928: Y(i) = 0.381175387
    i = i + 1: t(i) = 3850: X(i) = 0.387285928: Y(i) = 0.380896631
    i = i + 1: t(i) = 3860: X(i) = 0.386814177: Y(i) = 0.3806181
    i = i + 1: t(i) = 3870: X(i) = 0.386344663: Y(i) = 0.380339801
    i = i + 1: t(i) = 3880: X(i) = 0.385877374: Y(i) = 0.380061744
    i = i + 1: t(i) = 3890: X(i) = 0.385412298: Y(i) = 0.379783937
    i = i + 1: t(i) = 3900: X(i) = 0.384949423: Y(i) = 0.379506386
    i = i + 1: t(i) = 3910: X(i) = 0.384488738: Y(i) = 0.379229101
    i = i + 1: t(i) = 3920: X(i) = 0.38403023: Y(i) = 0.378952088
    i = i + 1: t(i) = 3930: X(i) = 0.383573888: Y(i) = 0.378675354
    i = i + 1: t(i) = 3940: X(i) = 0.3831197: Y(i) = 0.378398908
    i = i + 1: t(i) = 3950: X(i) = 0.382667654: Y(i) = 0.378122756
    i = i + 1: t(i) = 3960: X(i) = 0.38221774: Y(i) = 0.377846905
    i = i + 1: t(i) = 3970: X(i) = 0.381769945: Y(i) = 0.377571363
    i = i + 1: t(i) = 3980: X(i) = 0.381324258: Y(i) = 0.377296134
    i = i + 1: t(i) = 3990: X(i) = 0.380880667: Y(i) = 0.377021227
    i = i + 1: t(i) = 4000: X(i) = 0.380439162: Y(i) = 0.376746648
    i = i + 1: t(i) = 4010: X(i) = 0.37999973: Y(i) = 0.376472403
    i = i + 1: t(i) = 4020: X(i) = 0.379562361: Y(i) = 0.376198498
    i = i + 1: t(i) = 4030: X(i) = 0.379127044: Y(i) = 0.375924938
    i = i + 1: t(i) = 4040: X(i) = 0.378693767: Y(i) = 0.375651731
    i = i + 1: t(i) = 4050: X(i) = 0.378262519: Y(i) = 0.375378882
    i = i + 1: t(i) = 4060: X(i) = 0.37783329: Y(i) = 0.375106396
    i = i + 1: t(i) = 4070: X(i) = 0.377406067: Y(i) = 0.37483428
    i = i + 1: t(i) = 4080: X(i) = 0.376980841: Y(i) = 0.374562537
    i = i + 1: t(i) = 4090: X(i) = 0.3765576: Y(i) = 0.374291175
    i = i + 1: t(i) = 4100: X(i) = 0.376136333: Y(i) = 0.374020197
    i = i + 1: t(i) = 4110: X(i) = 0.375717031: Y(i) = 0.37374961
    i = i + 1: t(i) = 4120: X(i) = 0.375299681: Y(i) = 0.373479417
    i = i + 1: t(i) = 4130: X(i) = 0.374884274: Y(i) = 0.373209625
    i = i + 1: t(i) = 4140: X(i) = 0.374470799: Y(i) = 0.372940237
    i = i + 1: t(i) = 4150: X(i) = 0.374059245: Y(i) = 0.372671259
    i = i + 1: t(i) = 4160: X(i) = 0.373649601: Y(i) = 0.372402694
    i = i + 1: t(i) = 4170: X(i) = 0.373241858: Y(i) = 0.372134548
    i = i + 1: t(i) = 4180: X(i) = 0.372836005: Y(i) = 0.371866824
    i = i + 1: t(i) = 4190: X(i) = 0.372432031: Y(i) = 0.371599527
    i = i + 1: t(i) = 4200: X(i) = 0.372029926: Y(i) = 0.371332661
    i = i + 1: t(i) = 4210: X(i) = 0.371629681: Y(i) = 0.37106623
    i = i + 1: t(i) = 4220: X(i) = 0.371231284: Y(i) = 0.370800239
    i = i + 1: t(i) = 4230: X(i) = 0.370834726: Y(i) = 0.37053469
    i = i + 1: t(i) = 4240: X(i) = 0.370439996: Y(i) = 0.370269588
    i = i + 1: t(i) = 4250: X(i) = 0.370047085: Y(i) = 0.370004936
    i = i + 1: t(i) = 4260: X(i) = 0.369655983: Y(i) = 0.369740739
    i = i + 1: t(i) = 4270: X(i) = 0.369266679: Y(i) = 0.369476998
    i = i + 1: t(i) = 4280: X(i) = 0.368879164: Y(i) = 0.369213719
    i = i + 1: t(i) = 4290: X(i) = 0.368493428: Y(i) = 0.368950904
    i = i + 1: t(i) = 4300: X(i) = 0.368109462: Y(i) = 0.368688556
    i = i + 1: t(i) = 4310: X(i) = 0.367727255: Y(i) = 0.36842668
    i = i + 1: t(i) = 4320: X(i) = 0.367346797: Y(i) = 0.368165276
    i = i + 1: t(i) = 4330: X(i) = 0.36696808: Y(i) = 0.36790435
    i = i + 1: t(i) = 4340: X(i) = 0.366591094: Y(i) = 0.367643903
    i = i + 1: t(i) = 4350: X(i) = 0.366215829: Y(i) = 0.367383939
    i = i + 1: t(i) = 4360: X(i) = 0.365842275: Y(i) = 0.36712446
    i = i + 1: t(i) = 4370: X(i) = 0.365470424: Y(i) = 0.366865469
    i = i + 1: t(i) = 4380: X(i) = 0.365100266: Y(i) = 0.366606969
    i = i + 1: t(i) = 4390: X(i) = 0.364731792: Y(i) = 0.366348962
    i = i + 1: t(i) = 4400: X(i) = 0.364364992: Y(i) = 0.366091451
    i = i + 1: t(i) = 4410: X(i) = 0.363999858: Y(i) = 0.365834438
    i = i + 1: t(i) = 4420: X(i) = 0.363636379: Y(i) = 0.365577925
    i = i + 1: t(i) = 4430: X(i) = 0.363274548: Y(i) = 0.365321915
    i = i + 1: t(i) = 4440: X(i) = 0.362914354: Y(i) = 0.365066411
    i = i + 1: t(i) = 4450: X(i) = 0.36255579: Y(i) = 0.364811413
    i = i + 1: t(i) = 4460: X(i) = 0.362198846: Y(i) = 0.364556924
    i = i + 1: t(i) = 4470: X(i) = 0.361843512: Y(i) = 0.364302947
    i = i + 1: t(i) = 4480: X(i) = 0.361489781: Y(i) = 0.364049483
    i = i + 1: t(i) = 4490: X(i) = 0.361137644: Y(i) = 0.363796534
    i = i + 1: t(i) = 4500: X(i) = 0.360787091: Y(i) = 0.363544103
    i = i + 1: t(i) = 4510: X(i) = 0.360438115: Y(i) = 0.363292189
    i = i + 1: t(i) = 4520: X(i) = 0.360090706: Y(i) = 0.363040797
    i = i + 1: t(i) = 4530: X(i) = 0.359744855: Y(i) = 0.362789926
    i = i + 1: t(i) = 4540: X(i) = 0.359400555: Y(i) = 0.36253958
    i = i + 1: t(i) = 4550: X(i) = 0.359057797: Y(i) = 0.362289758
    i = i + 1: t(i) = 4560: X(i) = 0.358716572: Y(i) = 0.362040463
    i = i + 1: t(i) = 4570: X(i) = 0.358376873: Y(i) = 0.361791697
    i = i + 1: t(i) = 4580: X(i) = 0.358038689: Y(i) = 0.36154346
    i = i + 1: t(i) = 4590: X(i) = 0.357702014: Y(i) = 0.361295755
    i = i + 1: t(i) = 4600: X(i) = 0.357366839: Y(i) = 0.361048581
    i = i + 1: t(i) = 4610: X(i) = 0.357033156: Y(i) = 0.360801941
    i = i + 1: t(i) = 4620: X(i) = 0.356700957: Y(i) = 0.360555836
    i = i + 1: t(i) = 4630: X(i) = 0.356370233: Y(i) = 0.360310267
    i = i + 1: t(i) = 4640: X(i) = 0.356040976: Y(i) = 0.360065234
    i = i + 1: t(i) = 4650: X(i) = 0.355713179: Y(i) = 0.35982074
    i = i + 1: t(i) = 4660: X(i) = 0.355386833: Y(i) = 0.359576784
    i = i + 1: t(i) = 4670: X(i) = 0.355061931: Y(i) = 0.359333369
    i = i + 1: t(i) = 4680: X(i) = 0.354738464: Y(i) = 0.359090495
    i = i + 1: t(i) = 4690: X(i) = 0.354416426: Y(i) = 0.358848162
    i = i + 1: t(i) = 4700: X(i) = 0.354095807: Y(i) = 0.358606372
    i = i + 1: t(i) = 4710: X(i) = 0.3537766: Y(i) = 0.358365125
    i = i + 1: t(i) = 4720: X(i) = 0.353458798: Y(i) = 0.358124423
    i = i + 1: t(i) = 4730: X(i) = 0.353142393: Y(i) = 0.357884265
    i = i + 1: t(i) = 4740: X(i) = 0.352827377: Y(i) = 0.357644652
    i = i + 1: t(i) = 4750: X(i) = 0.352513743: Y(i) = 0.357405586
    i = i + 1: t(i) = 4760: X(i) = 0.352201483: Y(i) = 0.357167067
    i = i + 1: t(i) = 4770: X(i) = 0.35189059: Y(i) = 0.356929095
    i = i + 1: t(i) = 4780: X(i) = 0.351581056: Y(i) = 0.35669167
    i = i + 1: t(i) = 4790: X(i) = 0.351272874: Y(i) = 0.356454794
    i = i + 1: t(i) = 4800: X(i) = 0.350966036: Y(i) = 0.356218467
    i = i + 1: t(i) = 4810: X(i) = 0.350660536: Y(i) = 0.355982688
    i = i + 1: t(i) = 4820: X(i) = 0.350356365: Y(i) = 0.355747459
    i = i + 1: t(i) = 4830: X(i) = 0.350053517: Y(i) = 0.35551278
    i = i + 1: t(i) = 4840: X(i) = 0.349751985: Y(i) = 0.355278651
    i = i + 1: t(i) = 4850: X(i) = 0.349451761: Y(i) = 0.355045072
    i = i + 1: t(i) = 4860: X(i) = 0.349152838: Y(i) = 0.354812044
    i = i + 1: t(i) = 4870: X(i) = 0.34885521: Y(i) = 0.354579566
    i = i + 1: t(i) = 4880: X(i) = 0.348558869: Y(i) = 0.35434764
    i = i + 1: t(i) = 4890: X(i) = 0.348263808: Y(i) = 0.354116265
    i = i + 1: t(i) = 4900: X(i) = 0.34797002: Y(i) = 0.35388544
    i = i + 1: t(i) = 4910: X(i) = 0.347677499: Y(i) = 0.353655168
    i = i + 1: t(i) = 4920: X(i) = 0.347386237: Y(i) = 0.353425446
    i = i + 1: t(i) = 4930: X(i) = 0.347096228: Y(i) = 0.353196276
    i = i + 1: t(i) = 4940: X(i) = 0.346807466: Y(i) = 0.352967657
    i = i + 1: t(i) = 4950: X(i) = 0.346519942: Y(i) = 0.35273959
    i = i + 1: t(i) = 4960: X(i) = 0.346233651: Y(i) = 0.352512073
    i = i + 1: t(i) = 4970: X(i) = 0.345948586: Y(i) = 0.352285108
    i = i + 1: t(i) = 4980: X(i) = 0.345664741: Y(i) = 0.352058694
    i = i + 1: t(i) = 4990: X(i) = 0.345382108: Y(i) = 0.351832831
    i = i + 1: t(i) = 5000: X(i) = 0.345100681: Y(i) = 0.351607519
    i = i + 1: t(i) = 5010: X(i) = 0.344820454: Y(i) = 0.351382757
    i = i + 1: t(i) = 5020: X(i) = 0.344541421: Y(i) = 0.351158546
    i = i + 1: t(i) = 5030: X(i) = 0.344263574: Y(i) = 0.350934885
    i = i + 1: t(i) = 5040: X(i) = 0.343986908: Y(i) = 0.350711774
    i = i + 1: t(i) = 5050: X(i) = 0.343711416: Y(i) = 0.350489212
    i = i + 1: t(i) = 5060: X(i) = 0.343437092: Y(i) = 0.350267199
    i = i + 1: t(i) = 5070: X(i) = 0.34316393: Y(i) = 0.350045736
    i = i + 1: t(i) = 5080: X(i) = 0.342891923: Y(i) = 0.349824821
    i = i + 1: t(i) = 5090: X(i) = 0.342621065: Y(i) = 0.349604455
    i = i + 1: t(i) = 5100: X(i) = 0.34235135: Y(i) = 0.349384636
    i = i + 1: t(i) = 5110: X(i) = 0.342082772: Y(i) = 0.349165365
    i = i + 1: t(i) = 5120: X(i) = 0.341815325: Y(i) = 0.34894664
    i = i + 1: t(i) = 5130: X(i) = 0.341549003: Y(i) = 0.348728463
    i = i + 1: t(i) = 5140: X(i) = 0.3412838: Y(i) = 0.348510831
    i = i + 1: t(i) = 5150: X(i) = 0.34101971: Y(i) = 0.348293745
    i = i + 1: t(i) = 5160: X(i) = 0.340756726: Y(i) = 0.348077204
    i = i + 1: t(i) = 5170: X(i) = 0.340494844: Y(i) = 0.347861208
    i = i + 1: t(i) = 5180: X(i) = 0.340234057: Y(i) = 0.347645756
    i = i + 1: t(i) = 5190: X(i) = 0.339974359: Y(i) = 0.347430847
    i = i + 1: t(i) = 5200: X(i) = 0.339715744: Y(i) = 0.347216481
    i = i + 1: t(i) = 5210: X(i) = 0.339458208: Y(i) = 0.347002658
    i = i + 1: t(i) = 5220: X(i) = 0.339201743: Y(i) = 0.346789376
    i = i + 1: t(i) = 5230: X(i) = 0.338946345: Y(i) = 0.346576635
    i = i + 1: t(i) = 5240: X(i) = 0.338692008: Y(i) = 0.346364435
    i = i + 1: t(i) = 5250: X(i) = 0.338438726: Y(i) = 0.346152775
    i = i + 1: t(i) = 5260: X(i) = 0.338186493: Y(i) = 0.345941653
    i = i + 1: t(i) = 5270: X(i) = 0.337935305: Y(i) = 0.34573107
    i = i + 1: t(i) = 5280: X(i) = 0.337685154: Y(i) = 0.345521025
    i = i + 1: t(i) = 5290: X(i) = 0.337436037: Y(i) = 0.345311517
    i = i + 1: t(i) = 5300: X(i) = 0.337187947: Y(i) = 0.345102545
    i = i + 1: t(i) = 5310: X(i) = 0.33694088: Y(i) = 0.344894109
    i = i + 1: t(i) = 5320: X(i) = 0.336694829: Y(i) = 0.344686207
    i = i + 1: t(i) = 5330: X(i) = 0.336449789: Y(i) = 0.344478839
    i = i + 1: t(i) = 5340: X(i) = 0.336205756: Y(i) = 0.344272005
    i = i + 1: t(i) = 5350: X(i) = 0.335962723: Y(i) = 0.344065703
    i = i + 1: t(i) = 5360: X(i) = 0.335720686: Y(i) = 0.343859933
    i = i + 1: t(i) = 5370: X(i) = 0.335479639: Y(i) = 0.343654693
    i = i + 1: t(i) = 5380: X(i) = 0.335239577: Y(i) = 0.343449984
    i = i + 1: t(i) = 5390: X(i) = 0.335000495: Y(i) = 0.343245804
    i = i + 1: t(i) = 5400: X(i) = 0.334762387: Y(i) = 0.343042152
    i = i + 1: t(i) = 5410: X(i) = 0.33452525: Y(i) = 0.342839027
    i = i + 1: t(i) = 5420: X(i) = 0.334289077: Y(i) = 0.342636429
    i = i + 1: t(i) = 5430: X(i) = 0.334053863: Y(i) = 0.342434356
    i = i + 1: t(i) = 5440: X(i) = 0.333819604: Y(i) = 0.342232809
    i = i + 1: t(i) = 5450: X(i) = 0.333586294: Y(i) = 0.342031785
    i = i + 1: t(i) = 5460: X(i) = 0.333353929: Y(i) = 0.341831284
    i = i + 1: t(i) = 5470: X(i) = 0.333122504: Y(i) = 0.341631305
    i = i + 1: t(i) = 5480: X(i) = 0.332892014: Y(i) = 0.341431848
    i = i + 1: t(i) = 5490: X(i) = 0.332662453: Y(i) = 0.34123291
    i = i + 1: t(i) = 5500: X(i) = 0.332433818: Y(i) = 0.341034492
    i = i + 1: t(i) = 5510: X(i) = 0.332206102: Y(i) = 0.340836592
    i = i + 1: t(i) = 5520: X(i) = 0.331979303: Y(i) = 0.340639209
    i = i + 1: t(i) = 5530: X(i) = 0.331753414: Y(i) = 0.340442342
    i = i + 1: t(i) = 5540: X(i) = 0.331528431: Y(i) = 0.340245991
    i = i + 1: t(i) = 5550: X(i) = 0.331304349: Y(i) = 0.340050154
    i = i + 1: t(i) = 5560: X(i) = 0.331081164: Y(i) = 0.339854831
    i = i + 1: t(i) = 5570: X(i) = 0.330858871: Y(i) = 0.339660019
    i = i + 1: t(i) = 5580: X(i) = 0.330637465: Y(i) = 0.33946572
    i = i + 1: t(i) = 5590: X(i) = 0.330416943: Y(i) = 0.33927193
    i = i + 1: t(i) = 5600: X(i) = 0.330197298: Y(i) = 0.339078649
    i = i + 1: t(i) = 5610: X(i) = 0.329978527: Y(i) = 0.338885877
    i = i + 1: t(i) = 5620: X(i) = 0.329760626: Y(i) = 0.338693612
    i = i + 1: t(i) = 5630: X(i) = 0.329543589: Y(i) = 0.338501853
    i = i + 1: t(i) = 5640: X(i) = 0.329327413: Y(i) = 0.338310599
    i = i + 1: t(i) = 5650: X(i) = 0.329112092: Y(i) = 0.338119849
    i = i + 1: t(i) = 5660: X(i) = 0.328897623: Y(i) = 0.337929602
    i = i + 1: t(i) = 5670: X(i) = 0.328684002: Y(i) = 0.337739857
    i = i + 1: t(i) = 5680: X(i) = 0.328471223: Y(i) = 0.337550613
    i = i + 1: t(i) = 5690: X(i) = 0.328259282: Y(i) = 0.337361868
    i = i + 1: t(i) = 5700: X(i) = 0.328048176: Y(i) = 0.337173622
    i = i + 1: t(i) = 5710: X(i) = 0.3278379: Y(i) = 0.336985874
    i = i + 1: t(i) = 5720: X(i) = 0.327628449: Y(i) = 0.336798622
    i = i + 1: t(i) = 5730: X(i) = 0.32741982: Y(i) = 0.336611865
    i = i + 1: t(i) = 5740: X(i) = 0.327212008: Y(i) = 0.336425603
    i = i + 1: t(i) = 5750: X(i) = 0.327005009: Y(i) = 0.336239833
    i = i + 1: t(i) = 5760: X(i) = 0.32679882: Y(i) = 0.336054556
    i = i + 1: t(i) = 5770: X(i) = 0.326593435: Y(i) = 0.335869769
    i = i + 1: t(i) = 5780: X(i) = 0.326388851: Y(i) = 0.335685472
    i = i + 1: t(i) = 5790: X(i) = 0.326185064: Y(i) = 0.335501664
    i = i + 1: t(i) = 5800: X(i) = 0.325982069: Y(i) = 0.335318343
    i = i + 1: t(i) = 5810: X(i) = 0.325779863: Y(i) = 0.335135509
    i = i + 1: t(i) = 5820: X(i) = 0.325578442: Y(i) = 0.33495316
    i = i + 1: t(i) = 5830: X(i) = 0.325377802: Y(i) = 0.334771294
    i = i + 1: t(i) = 5840: X(i) = 0.325177938: Y(i) = 0.334589912
    i = i + 1: t(i) = 5850: X(i) = 0.324978847: Y(i) = 0.334409012
    i = i + 1: t(i) = 5860: X(i) = 0.324780525: Y(i) = 0.334228592
    i = i + 1: t(i) = 5870: X(i) = 0.324582968: Y(i) = 0.334048651
    i = i + 1: t(i) = 5880: X(i) = 0.324386173: Y(i) = 0.333869189
    i = i + 1: t(i) = 5890: X(i) = 0.324190135: Y(i) = 0.333690204
    i = i + 1: t(i) = 5900: X(i) = 0.32399485: Y(i) = 0.333511695
    i = i + 1: t(i) = 5910: X(i) = 0.323800315: Y(i) = 0.333333661
    i = i + 1: t(i) = 5920: X(i) = 0.323606526: Y(i) = 0.3331561
    i = i + 1: t(i) = 5930: X(i) = 0.32341348: Y(i) = 0.332979012
    i = i + 1: t(i) = 5940: X(i) = 0.323221172: Y(i) = 0.332802395
    i = i + 1: t(i) = 5950: X(i) = 0.323029598: Y(i) = 0.332626248
    i = i + 1: t(i) = 5960: X(i) = 0.322838757: Y(i) = 0.33245057
    i = i + 1: t(i) = 5970: X(i) = 0.322648642: Y(i) = 0.33227536
    i = i + 1: t(i) = 5980: X(i) = 0.322459252: Y(i) = 0.332100616
    i = i + 1: t(i) = 5990: X(i) = 0.322270582: Y(i) = 0.331926338
    i = i + 1: t(i) = 6000: X(i) = 0.322082628: Y(i) = 0.331752524
    i = i + 1: t(i) = 6010: X(i) = 0.321895388: Y(i) = 0.331579173
    i = i + 1: t(i) = 6020: X(i) = 0.321708857: Y(i) = 0.331406284
    i = i + 1: t(i) = 6030: X(i) = 0.321523032: Y(i) = 0.331233855
    i = i + 1: t(i) = 6040: X(i) = 0.32133791: Y(i) = 0.331061886
    i = i + 1: t(i) = 6050: X(i) = 0.321153487: Y(i) = 0.330890376
    i = i + 1: t(i) = 6060: X(i) = 0.32096976: Y(i) = 0.330719322
    i = i + 1: t(i) = 6070: X(i) = 0.320786725: Y(i) = 0.330548724
    i = i + 1: t(i) = 6080: X(i) = 0.320604378: Y(i) = 0.330378581
    i = i + 1: t(i) = 6090: X(i) = 0.320422717: Y(i) = 0.330208891
    i = i + 1: t(i) = 6100: X(i) = 0.320241738: Y(i) = 0.330039654
    i = i + 1: t(i) = 6110: X(i) = 0.320061437: Y(i) = 0.329870867
    i = i + 1: t(i) = 6120: X(i) = 0.319881812: Y(i) = 0.329702531
    i = i + 1: t(i) = 6130: X(i) = 0.319702858: Y(i) = 0.329534643
    i = i + 1: t(i) = 6140: X(i) = 0.319524573: Y(i) = 0.329367203
    i = i + 1: t(i) = 6150: X(i) = 0.319346954: Y(i) = 0.329200209
    i = i + 1: t(i) = 6160: X(i) = 0.319169996: Y(i) = 0.32903366
    i = i + 1: t(i) = 6170: X(i) = 0.318993698: Y(i) = 0.328867555
    i = i + 1: t(i) = 6180: X(i) = 0.318818055: Y(i) = 0.328701893
    i = i + 1: t(i) = 6190: X(i) = 0.318643064: Y(i) = 0.328536672
    i = i + 1: t(i) = 6200: X(i) = 0.318468723: Y(i) = 0.328371892
    i = i + 1: t(i) = 6210: X(i) = 0.318295027: Y(i) = 0.328207551
    i = i + 1: t(i) = 6220: X(i) = 0.318121974: Y(i) = 0.328043647
    i = i + 1: t(i) = 6230: X(i) = 0.317949561: Y(i) = 0.327880181
    i = i + 1: t(i) = 6240: X(i) = 0.317777785: Y(i) = 0.32771715
    i = i + 1: t(i) = 6250: X(i) = 0.317606642: Y(i) = 0.327554553
    i = i + 1: t(i) = 6260: X(i) = 0.31743613: Y(i) = 0.327392389
    i = i + 1: t(i) = 6270: X(i) = 0.317266245: Y(i) = 0.327230657
    i = i + 1: t(i) = 6280: X(i) = 0.317096984: Y(i) = 0.327069356
    i = i + 1: t(i) = 6290: X(i) = 0.316928344: Y(i) = 0.326908485
    i = i + 1: t(i) = 6300: X(i) = 0.316760323: Y(i) = 0.326748041
    i = i + 1: t(i) = 6310: X(i) = 0.316592917: Y(i) = 0.326588025
    i = i + 1: t(i) = 6320: X(i) = 0.316426123: Y(i) = 0.326428435
    i = i + 1: t(i) = 6330: X(i) = 0.316259939: Y(i) = 0.32626927
    i = i + 1: t(i) = 6340: X(i) = 0.316094361: Y(i) = 0.326110528
    i = i + 1: t(i) = 6350: X(i) = 0.315929386: Y(i) = 0.325952208
    i = i + 1: t(i) = 6360: X(i) = 0.315765012: Y(i) = 0.32579431
    i = i + 1: t(i) = 6370: X(i) = 0.315601236: Y(i) = 0.325636832
    i = i + 1: t(i) = 6380: X(i) = 0.315438054: Y(i) = 0.325479772
    i = i + 1: t(i) = 6390: X(i) = 0.315275464: Y(i) = 0.32532313
    i = i + 1: t(i) = 6400: X(i) = 0.315113464: Y(i) = 0.325166905
    i = i + 1: t(i) = 6410: X(i) = 0.314952049: Y(i) = 0.325011094
    i = i + 1: t(i) = 6420: X(i) = 0.314791218: Y(i) = 0.324855698
    i = i + 1: t(i) = 6430: X(i) = 0.314630968: Y(i) = 0.324700714
    i = i + 1: t(i) = 6440: X(i) = 0.314471296: Y(i) = 0.324546143
    i = i + 1: t(i) = 6450: X(i) = 0.314312198: Y(i) = 0.324391981
    i = i + 1: t(i) = 6460: X(i) = 0.314153673: Y(i) = 0.32423823
    i = i + 1: t(i) = 6470: X(i) = 0.313995718: Y(i) = 0.324084886
    i = i + 1: t(i) = 6480: X(i) = 0.31383833: Y(i) = 0.323931949
    i = i + 1: t(i) = 6490: X(i) = 0.313681506: Y(i) = 0.323779418
    i = i + 1: t(i) = 6500: X(i) = 0.313525243: Y(i) = 0.323627291
    i = i + 1: t(i) = 6510: X(i) = 0.313369539: Y(i) = 0.323475568
    i = i + 1: t(i) = 6520: X(i) = 0.313214391: Y(i) = 0.323324247
    i = i + 1: t(i) = 6530: X(i) = 0.313059797: Y(i) = 0.323173328
    i = i + 1: t(i) = 6540: X(i) = 0.312905754: Y(i) = 0.323022808
    i = i + 1: t(i) = 6550: X(i) = 0.31275226: Y(i) = 0.322872687
    i = i + 1: t(i) = 6560: X(i) = 0.312599311: Y(i) = 0.322722964
    i = i + 1: t(i) = 6570: X(i) = 0.312446905: Y(i) = 0.322573637
    i = i + 1: t(i) = 6580: X(i) = 0.31229504: Y(i) = 0.322424705
    i = i + 1: t(i) = 6590: X(i) = 0.312143712: Y(i) = 0.322276167
    i = i + 1: t(i) = 6600: X(i) = 0.311992921: Y(i) = 0.322128023
    i = i + 1: t(i) = 6610: X(i) = 0.311842662: Y(i) = 0.32198027
    i = i + 1: t(i) = 6620: X(i) = 0.311692934: Y(i) = 0.321832907
    i = i + 1: t(i) = 6630: X(i) = 0.311543734: Y(i) = 0.321685935
    i = i + 1: t(i) = 6640: X(i) = 0.311395059: Y(i) = 0.32153935
    i = i + 1: t(i) = 6650: X(i) = 0.311246907: Y(i) = 0.321393153
    i = i + 1: t(i) = 6660: X(i) = 0.311099276: Y(i) = 0.321247342
    i = i + 1: t(i) = 6670: X(i) = 0.310952163: Y(i) = 0.321101915
    i = i + 1: t(i) = 6680: X(i) = 0.310805566: Y(i) = 0.320956873
    i = i + 1: t(i) = 6690: X(i) = 0.310659482: Y(i) = 0.320812213
    i = i + 1: t(i) = 6700: X(i) = 0.31051391: Y(i) = 0.320667934
    i = i + 1: t(i) = 6710: X(i) = 0.310368845: Y(i) = 0.320524036
    i = i + 1: t(i) = 6720: X(i) = 0.310224287: Y(i) = 0.320380517
    i = i + 1: t(i) = 6730: X(i) = 0.310080233: Y(i) = 0.320237376
    i = i + 1: t(i) = 6740: X(i) = 0.30993668: Y(i) = 0.320094612
    i = i + 1: t(i) = 6750: X(i) = 0.309793626: Y(i) = 0.319952224
    i = i + 1: t(i) = 6760: X(i) = 0.30965107: Y(i) = 0.319810211
    i = i + 1: t(i) = 6770: X(i) = 0.309509007: Y(i) = 0.319668571
    i = i + 1: t(i) = 6780: X(i) = 0.309367437: Y(i) = 0.319527303
    i = i + 1: t(i) = 6790: X(i) = 0.309226357: Y(i) = 0.319386407
    i = i + 1: t(i) = 6800: X(i) = 0.309085765: Y(i) = 0.319245881
    i = i + 1: t(i) = 6810: X(i) = 0.308945658: Y(i) = 0.319105724
    i = i + 1: t(i) = 6820: X(i) = 0.308806034: Y(i) = 0.318965935
    i = i + 1: t(i) = 6830: X(i) = 0.308666892: Y(i) = 0.318826513
    i = i + 1: t(i) = 6840: X(i) = 0.308528228: Y(i) = 0.318687457
    i = i + 1: t(i) = 6850: X(i) = 0.30839004: Y(i) = 0.318548765
    i = i + 1: t(i) = 6860: X(i) = 0.308252327: Y(i) = 0.318410437
    i = i + 1: t(i) = 6870: X(i) = 0.308115086: Y(i) = 0.318272472
    i = i + 1: t(i) = 6880: X(i) = 0.307978316: Y(i) = 0.318134867
    i = i + 1: t(i) = 6890: X(i) = 0.307842013: Y(i) = 0.317997623
    i = i + 1: t(i) = 6900: X(i) = 0.307706176: Y(i) = 0.317860738
    i = i + 1: t(i) = 6910: X(i) = 0.307570802: Y(i) = 0.317724212
    i = i + 1: t(i) = 6920: X(i) = 0.30743589: Y(i) = 0.317588042
    i = i + 1: t(i) = 6930: X(i) = 0.307301437: Y(i) = 0.317452228
    i = i + 1: t(i) = 6940: X(i) = 0.307167442: Y(i) = 0.317316769
    i = i + 1: t(i) = 6950: X(i) = 0.307033902: Y(i) = 0.317181663
    i = i + 1: t(i) = 6960: X(i) = 0.306900815: Y(i) = 0.317046911
    i = i + 1: t(i) = 6970: X(i) = 0.306768179: Y(i) = 0.316912509
    i = i + 1: t(i) = 6980: X(i) = 0.306635992: Y(i) = 0.316778459
    i = i + 1: t(i) = 6990: X(i) = 0.306504252: Y(i) = 0.316644757
    i = i + 1: t(i) = 7000: X(i) = 0.306372957: Y(i) = 0.316511405
    i = i + 1: t(i) = 7010: X(i) = 0.306242105: Y(i) = 0.316378399
    i = i + 1: t(i) = 7020: X(i) = 0.306111693: Y(i) = 0.31624574
    i = i + 1: t(i) = 7030: X(i) = 0.305981721: Y(i) = 0.316113425
    i = i + 1: t(i) = 7040: X(i) = 0.305852186: Y(i) = 0.315981455
    i = i + 1: t(i) = 7050: X(i) = 0.305723086: Y(i) = 0.315849828
    i = i + 1: t(i) = 7060: X(i) = 0.305594418: Y(i) = 0.315718543
    i = i + 1: t(i) = 7070: X(i) = 0.305466182: Y(i) = 0.315587599
    i = i + 1: t(i) = 7080: X(i) = 0.305338375: Y(i) = 0.315456995
    i = i + 1: t(i) = 7090: X(i) = 0.305210996: Y(i) = 0.31532673
    i = i + 1: t(i) = 7100: X(i) = 0.305084041: Y(i) = 0.315196802
    i = i + 1: t(i) = 7110: X(i) = 0.30495751: Y(i) = 0.315067212
    i = i + 1: t(i) = 7120: X(i) = 0.3048314: Y(i) = 0.314937957
    i = i + 1: t(i) = 7130: X(i) = 0.30470571: Y(i) = 0.314809037
    i = i + 1: t(i) = 7140: X(i) = 0.304580438: Y(i) = 0.31468045
    i = i + 1: t(i) = 7150: X(i) = 0.304455581: Y(i) = 0.314552196
    i = i + 1: t(i) = 7160: X(i) = 0.304331139: Y(i) = 0.314424274
    i = i + 1: t(i) = 7170: X(i) = 0.304207109: Y(i) = 0.314296682
    i = i + 1: t(i) = 7180: X(i) = 0.304083489: Y(i) = 0.31416942
    i = i + 1: t(i) = 7190: X(i) = 0.303960277: Y(i) = 0.314042487
    i = i + 1: t(i) = 7200: X(i) = 0.303837472: Y(i) = 0.313915881
    i = i + 1: t(i) = 7210: X(i) = 0.303715072: Y(i) = 0.313789601
    i = i + 1: t(i) = 7220: X(i) = 0.303593076: Y(i) = 0.313663648
    i = i + 1: t(i) = 7230: X(i) = 0.30347148: Y(i) = 0.313538018
    i = i + 1: t(i) = 7240: X(i) = 0.303350284: Y(i) = 0.313412712
    i = i + 1: t(i) = 7250: X(i) = 0.303229486: Y(i) = 0.313287729
    i = i + 1: t(i) = 7260: X(i) = 0.303109083: Y(i) = 0.313163067
    i = i + 1: t(i) = 7270: X(i) = 0.302989075: Y(i) = 0.313038726
    i = i + 1: t(i) = 7280: X(i) = 0.302869459: Y(i) = 0.312914704
    i = i + 1: t(i) = 7290: X(i) = 0.302750235: Y(i) = 0.312791001
    i = i + 1: t(i) = 7300: X(i) = 0.302631399: Y(i) = 0.312667615
    i = i + 1: t(i) = 7310: X(i) = 0.30251295: Y(i) = 0.312544546
    i = i + 1: t(i) = 7320: X(i) = 0.302394887: Y(i) = 0.312421792
    i = i + 1: t(i) = 7330: X(i) = 0.302277208: Y(i) = 0.312299353
    i = i + 1: t(i) = 7340: X(i) = 0.302159912: Y(i) = 0.312177228
    i = i + 1: t(i) = 7350: X(i) = 0.302042996: Y(i) = 0.312055415
    i = i + 1: t(i) = 7360: X(i) = 0.301926458: Y(i) = 0.311933914
    i = i + 1: t(i) = 7370: X(i) = 0.301810298: Y(i) = 0.311812724
    i = i + 1: t(i) = 7380: X(i) = 0.301694514: Y(i) = 0.311691843
    i = i + 1: t(i) = 7390: X(i) = 0.301579104: Y(i) = 0.311571272
    i = i + 1: t(i) = 7400: X(i) = 0.301464066: Y(i) = 0.311451008
    i = i + 1: t(i) = 7410: X(i) = 0.301349398: Y(i) = 0.31133105
    i = i + 1: t(i) = 7420: X(i) = 0.3012351: Y(i) = 0.311211399
    i = i + 1: t(i) = 7430: X(i) = 0.301121169: Y(i) = 0.311092053
    i = i + 1: t(i) = 7440: X(i) = 0.301007604: Y(i) = 0.310973011
    i = i + 1: t(i) = 7450: X(i) = 0.300894404: Y(i) = 0.310854271
    i = i + 1: t(i) = 7460: X(i) = 0.300781566: Y(i) = 0.310735834
    i = i + 1: t(i) = 7470: X(i) = 0.300669089: Y(i) = 0.310617698
    i = i + 1: t(i) = 7480: X(i) = 0.300556972: Y(i) = 0.310499863
    i = i + 1: t(i) = 7490: X(i) = 0.300445213: Y(i) = 0.310382326
    i = i + 1: t(i) = 7500: X(i) = 0.30033381: Y(i) = 0.310265088
    i = i + 1: t(i) = 7510: X(i) = 0.300222763: Y(i) = 0.310148148
    i = i + 1: t(i) = 7520: X(i) = 0.300112069: Y(i) = 0.310031504
    i = i + 1: t(i) = 7530: X(i) = 0.300001726: Y(i) = 0.309915155
    i = i + 1: t(i) = 7540: X(i) = 0.299891734: Y(i) = 0.309799101
    i = i + 1: t(i) = 7550: X(i) = 0.299782091: Y(i) = 0.309683341
    i = i + 1: t(i) = 7560: X(i) = 0.299672796: Y(i) = 0.309567874
    i = i + 1: t(i) = 7570: X(i) = 0.299563846: Y(i) = 0.309452698
    i = i + 1: t(i) = 7580: X(i) = 0.299455241: Y(i) = 0.309337814
    i = i + 1: t(i) = 7590: X(i) = 0.299346978: Y(i) = 0.30922322
    i = i + 1: t(i) = 7600: X(i) = 0.299239057: Y(i) = 0.309108915
    i = i + 1: t(i) = 7610: X(i) = 0.299131476: Y(i) = 0.308994898
    i = i + 1: t(i) = 7620: X(i) = 0.299024234: Y(i) = 0.308881168
    i = i + 1: t(i) = 7630: X(i) = 0.298917329: Y(i) = 0.308767726
    i = i + 1: t(i) = 7640: X(i) = 0.298810759: Y(i) = 0.308654568
    i = i + 1: t(i) = 7650: X(i) = 0.298704524: Y(i) = 0.308541696
    i = i + 1: t(i) = 7660: X(i) = 0.298598621: Y(i) = 0.308429107
    i = i + 1: t(i) = 7670: X(i) = 0.29849305: Y(i) = 0.308316801
    i = i + 1: t(i) = 7680: X(i) = 0.298387809: Y(i) = 0.308204777
    i = i + 1: t(i) = 7690: X(i) = 0.298282897: Y(i) = 0.308093034
    i = i + 1: t(i) = 7700: X(i) = 0.298178312: Y(i) = 0.307981572
    i = i + 1: t(i) = 7710: X(i) = 0.298074052: Y(i) = 0.307870389
    i = i + 1: t(i) = 7720: X(i) = 0.297970117: Y(i) = 0.307759485
    i = i + 1: t(i) = 7730: X(i) = 0.297866505: Y(i) = 0.307648858
    i = i + 1: t(i) = 7740: X(i) = 0.297763215: Y(i) = 0.307538508
    i = i + 1: t(i) = 7750: X(i) = 0.297660245: Y(i) = 0.307428434
    i = i + 1: t(i) = 7760: X(i) = 0.297557595: Y(i) = 0.307318635
    i = i + 1: t(i) = 7770: X(i) = 0.297455261: Y(i) = 0.307209111
    i = i + 1: t(i) = 7780: X(i) = 0.297353245: Y(i) = 0.307099859
    i = i + 1: t(i) = 7790: X(i) = 0.297251543: Y(i) = 0.306990881
    i = i + 1: t(i) = 7800: X(i) = 0.297150155: Y(i) = 0.306882173
    i = i + 1: t(i) = 7810: X(i) = 0.297049079: Y(i) = 0.306773737
    i = i + 1: t(i) = 7820: X(i) = 0.296948314: Y(i) = 0.306665571
    i = i + 1: t(i) = 7830: X(i) = 0.296847859: Y(i) = 0.306557674
    i = i + 1: t(i) = 7840: X(i) = 0.296747713: Y(i) = 0.306450045
    i = i + 1: t(i) = 7850: X(i) = 0.296647874: Y(i) = 0.306342683
    i = i + 1: t(i) = 7860: X(i) = 0.29654834: Y(i) = 0.306235588
    i = i + 1: t(i) = 7870: X(i) = 0.296449112: Y(i) = 0.306128759
    i = i + 1: t(i) = 7880: X(i) = 0.296350186: Y(i) = 0.306022195
    i = i + 1: t(i) = 7890: X(i) = 0.296251563: Y(i) = 0.305915895
    i = i + 1: t(i) = 7900: X(i) = 0.296153241: Y(i) = 0.305809858
    i = i + 1: t(i) = 7910: X(i) = 0.296055218: Y(i) = 0.305704084
    i = i + 1: t(i) = 7920: X(i) = 0.295957493: Y(i) = 0.305598572
    i = i + 1: t(i) = 7930: X(i) = 0.295860066: Y(i) = 0.30549332
    i = i + 1: t(i) = 7940: X(i) = 0.295762934: Y(i) = 0.305388328
    i = i + 1: t(i) = 7950: X(i) = 0.295666098: Y(i) = 0.305283596
    i = i + 1: t(i) = 7960: X(i) = 0.295569554: Y(i) = 0.305179122
    i = i + 1: t(i) = 7970: X(i) = 0.295473303: Y(i) = 0.305074906
    i = i + 1: t(i) = 7980: X(i) = 0.295377343: Y(i) = 0.304970946
    i = i + 1: t(i) = 7990: X(i) = 0.295281672: Y(i) = 0.304867242
    i = i + 1: t(i) = 8000: X(i) = 0.295186291: Y(i) = 0.304763794
    i = i + 1: t(i) = 8010: X(i) = 0.295091196: Y(i) = 0.3046606
    i = i + 1: t(i) = 8020: X(i) = 0.294996388: Y(i) = 0.30455766
    i = i + 1: t(i) = 8030: X(i) = 0.294901866: Y(i) = 0.304454972
    i = i + 1: t(i) = 8040: X(i) = 0.294807627: Y(i) = 0.304352537
    i = i + 1: t(i) = 8050: X(i) = 0.29471367: Y(i) = 0.304250353
    i = i + 1: t(i) = 8060: X(i) = 0.294619996: Y(i) = 0.304148419
    i = i + 1: t(i) = 8070: X(i) = 0.294526602: Y(i) = 0.304046735
    i = i + 1: t(i) = 8080: X(i) = 0.294433487: Y(i) = 0.3039453
    i = i + 1: t(i) = 8090: X(i) = 0.29434065: Y(i) = 0.303844113
    i = i + 1: t(i) = 8100: X(i) = 0.29424809: Y(i) = 0.303743173
    i = i + 1: t(i) = 8110: X(i) = 0.294155807: Y(i) = 0.30364248
    i = i + 1: t(i) = 8120: X(i) = 0.294063798: Y(i) = 0.303542033
    i = i + 1: t(i) = 8130: X(i) = 0.293972062: Y(i) = 0.303441831
    i = i + 1: t(i) = 8140: X(i) = 0.2938806: Y(i) = 0.303341874
    i = i + 1: t(i) = 8150: X(i) = 0.293789408: Y(i) = 0.303242159
    i = i + 1: t(i) = 8160: X(i) = 0.293698487: Y(i) = 0.303142688
    i = i + 1: t(i) = 8170: X(i) = 0.293607835: Y(i) = 0.303043459
    i = i + 1: t(i) = 8180: X(i) = 0.293517452: Y(i) = 0.302944471
    i = i + 1: t(i) = 8190: X(i) = 0.293427335: Y(i) = 0.302845723
    i = i + 1: t(i) = 8200: X(i) = 0.293337485: Y(i) = 0.302747216
    i = i + 1: t(i) = 8210: X(i) = 0.293247899: Y(i) = 0.302648947
    i = i + 1: t(i) = 8220: X(i) = 0.293158578: Y(i) = 0.302550917
    i = i + 1: t(i) = 8230: X(i) = 0.293069519: Y(i) = 0.302453124
    i = i + 1: t(i) = 8240: X(i) = 0.292980722: Y(i) = 0.302355568
    i = i + 1: t(i) = 8250: X(i) = 0.292892185: Y(i) = 0.302258248
    i = i + 1: t(i) = 8260: X(i) = 0.292803909: Y(i) = 0.302161164
    i = i + 1: t(i) = 8270: X(i) = 0.29271589: Y(i) = 0.302064314
    i = i + 1: t(i) = 8280: X(i) = 0.29262813: Y(i) = 0.301967698
    i = i + 1: t(i) = 8290: X(i) = 0.292540626: Y(i) = 0.301871316
    i = i + 1: t(i) = 8300: X(i) = 0.292453377: Y(i) = 0.301775165
    i = i + 1: t(i) = 8310: X(i) = 0.292366383: Y(i) = 0.301679247
    i = i + 1: t(i) = 8320: X(i) = 0.292279642: Y(i) = 0.301583559
    i = i + 1: t(i) = 8330: X(i) = 0.292193154: Y(i) = 0.301488102
    i = i + 1: t(i) = 8340: X(i) = 0.292106917: Y(i) = 0.301392875
    i = i + 1: t(i) = 8350: X(i) = 0.292020931: Y(i) = 0.301297876
    i = i + 1: t(i) = 8360: X(i) = 0.291935194: Y(i) = 0.301203106
    i = i + 1: t(i) = 8370: X(i) = 0.291849706: Y(i) = 0.301108563
    i = i + 1: t(i) = 8380: X(i) = 0.291764465: Y(i) = 0.301014246
    i = i + 1: t(i) = 8390: X(i) = 0.291679471: Y(i) = 0.300920156
    i = i + 1: t(i) = 8400: X(i) = 0.291594722: Y(i) = 0.300826292
    i = i + 1: t(i) = 8410: X(i) = 0.291510218: Y(i) = 0.300732652
    i = i + 1: t(i) = 8420: X(i) = 0.291425957: Y(i) = 0.300639235
    i = i + 1: t(i) = 8430: X(i) = 0.291341939: Y(i) = 0.300546043
    i = i + 1: t(i) = 8440: X(i) = 0.291258163: Y(i) = 0.300453072
    i = i + 1: t(i) = 8450: X(i) = 0.291174627: Y(i) = 0.300360324
    i = i + 1: t(i) = 8460: X(i) = 0.291091331: Y(i) = 0.300267797
    i = i + 1: t(i) = 8470: X(i) = 0.291008274: Y(i) = 0.300175491
    i = i + 1: t(i) = 8480: X(i) = 0.290925455: Y(i) = 0.300083404
    i = i + 1: t(i) = 8490: X(i) = 0.290842873: Y(i) = 0.299991537
    i = i + 1: t(i) = 8500: X(i) = 0.290760526: Y(i) = 0.299899888
    i = i + 1: t(i) = 8510: X(i) = 0.290678415: Y(i) = 0.299808457
    i = i + 1: t(i) = 8520: X(i) = 0.290596538: Y(i) = 0.299717243
    i = i + 1: t(i) = 8530: X(i) = 0.290514895: Y(i) = 0.299626246
    i = i + 1: t(i) = 8540: X(i) = 0.290433483: Y(i) = 0.299535464
    i = i + 1: t(i) = 8550: X(i) = 0.290352303: Y(i) = 0.299444898
    i = i + 1: t(i) = 8560: X(i) = 0.290271354: Y(i) = 0.299354546
    i = i + 1: t(i) = 8570: X(i) = 0.290190634: Y(i) = 0.299264408
    i = i + 1: t(i) = 8580: X(i) = 0.290110143: Y(i) = 0.299174483
    i = i + 1: t(i) = 8590: X(i) = 0.29002988: Y(i) = 0.299084771
    i = i + 1: t(i) = 8600: X(i) = 0.289949844: Y(i) = 0.298995271
    i = i + 1: t(i) = 8610: X(i) = 0.289870034: Y(i) = 0.298905982
    i = i + 1: t(i) = 8620: X(i) = 0.289790449: Y(i) = 0.298816904
    i = i + 1: t(i) = 8630: X(i) = 0.289711088: Y(i) = 0.298728035
    i = i + 1: t(i) = 8640: X(i) = 0.289631951: Y(i) = 0.298639376
    i = i + 1: t(i) = 8650: X(i) = 0.289553037: Y(i) = 0.298550925
    i = i + 1: t(i) = 8660: X(i) = 0.289474344: Y(i) = 0.298462683
    i = i + 1: t(i) = 8670: X(i) = 0.289395872: Y(i) = 0.298374648
    i = i + 1: t(i) = 8680: X(i) = 0.28931762: Y(i) = 0.29828682
    i = i + 1: t(i) = 8690: X(i) = 0.289239588: Y(i) = 0.298199197
    i = i + 1: t(i) = 8700: X(i) = 0.289161773: Y(i) = 0.298111781
    i = i + 1: t(i) = 8710: X(i) = 0.289084176: Y(i) = 0.298024569
    i = i + 1: t(i) = 8720: X(i) = 0.289006796: Y(i) = 0.297937561
    i = i + 1: t(i) = 8730: X(i) = 0.288929632: Y(i) = 0.297850757
    i = i + 1: t(i) = 8740: X(i) = 0.288852683: Y(i) = 0.297764156
    i = i + 1: t(i) = 8750: X(i) = 0.288775948: Y(i) = 0.297677758
    i = i + 1: t(i) = 8760: X(i) = 0.288699426: Y(i) = 0.297591561
    i = i + 1: t(i) = 8770: X(i) = 0.288623117: Y(i) = 0.297505565
    i = i + 1: t(i) = 8780: X(i) = 0.288547019: Y(i) = 0.29741977
    i = i + 1: t(i) = 8790: X(i) = 0.288471133: Y(i) = 0.297334175
    i = i + 1: t(i) = 8800: X(i) = 0.288395456: Y(i) = 0.297248779
    i = i + 1: t(i) = 8810: X(i) = 0.288319989: Y(i) = 0.297163582
    i = i + 1: t(i) = 8820: X(i) = 0.28824473: Y(i) = 0.297078583
    i = i + 1: t(i) = 8830: X(i) = 0.28816968: Y(i) = 0.296993781
    i = i + 1: t(i) = 8840: X(i) = 0.288094836: Y(i) = 0.296909176
    i = i + 1: t(i) = 8850: X(i) = 0.288020198: Y(i) = 0.296824768
    i = i + 1: t(i) = 8860: X(i) = 0.287945765: Y(i) = 0.296740555
    i = i + 1: t(i) = 8870: X(i) = 0.287871538: Y(i) = 0.296656538
    i = i + 1: t(i) = 8880: X(i) = 0.287797514: Y(i) = 0.296572714
    i = i + 1: t(i) = 8890: X(i) = 0.287723693: Y(i) = 0.296489085
    i = i + 1: t(i) = 8900: X(i) = 0.287650074: Y(i) = 0.296405649
    i = i + 1: t(i) = 8910: X(i) = 0.287576657: Y(i) = 0.296322406
    i = i + 1: t(i) = 8920: X(i) = 0.28750344: Y(i) = 0.296239355
    i = i + 1: t(i) = 8930: X(i) = 0.287430424: Y(i) = 0.296156496
    i = i + 1: t(i) = 8940: X(i) = 0.287357607: Y(i) = 0.296073828
    i = i + 1: t(i) = 8950: X(i) = 0.287284988: Y(i) = 0.29599135
    i = i + 1: t(i) = 8960: X(i) = 0.287212567: Y(i) = 0.295909061
    i = i + 1: t(i) = 8970: X(i) = 0.287140343: Y(i) = 0.295826963
    i = i + 1: t(i) = 8980: X(i) = 0.287068316: Y(i) = 0.295745052
    i = i + 1: t(i) = 8990: X(i) = 0.286996484: Y(i) = 0.29566333
    i = i + 1: t(i) = 9000: X(i) = 0.286924846: Y(i) = 0.295581796
    i = i + 1: t(i) = 9010: X(i) = 0.286853403: Y(i) = 0.295500449
    i = i + 1: t(i) = 9020: X(i) = 0.286782153: Y(i) = 0.295419287
    i = i + 1: t(i) = 9030: X(i) = 0.286711096: Y(i) = 0.295338312
    i = i + 1: t(i) = 9040: X(i) = 0.28664023: Y(i) = 0.295257522
    i = i + 1: t(i) = 9050: X(i) = 0.286569556: Y(i) = 0.295176917
    i = i + 1: t(i) = 9060: X(i) = 0.286499073: Y(i) = 0.295096496
    i = i + 1: t(i) = 9070: X(i) = 0.286428779: Y(i) = 0.295016259
    i = i + 1: t(i) = 9080: X(i) = 0.286358674: Y(i) = 0.294936205
    i = i + 1: t(i) = 9090: X(i) = 0.286288757: Y(i) = 0.294856333
    i = i + 1: t(i) = 9100: X(i) = 0.286219028: Y(i) = 0.294776643
    i = i + 1: t(i) = 9110: X(i) = 0.286149487: Y(i) = 0.294697135
    i = i + 1: t(i) = 9120: X(i) = 0.286080131: Y(i) = 0.294617808
    i = i + 1: t(i) = 9130: X(i) = 0.286010961: Y(i) = 0.294538661
    i = i + 1: t(i) = 9140: X(i) = 0.285941976: Y(i) = 0.294459693
    i = i + 1: t(i) = 9150: X(i) = 0.285873175: Y(i) = 0.294380906
    i = i + 1: t(i) = 9160: X(i) = 0.285804558: Y(i) = 0.294302296
    i = i + 1: t(i) = 9170: X(i) = 0.285736123: Y(i) = 0.294223865
    i = i + 1: t(i) = 9180: X(i) = 0.285667871: Y(i) = 0.294145612
    i = i + 1: t(i) = 9190: X(i) = 0.2855998: Y(i) = 0.294067535
    i = i + 1: t(i) = 9200: X(i) = 0.28553191: Y(i) = 0.293989636
    i = i + 1: t(i) = 9210: X(i) = 0.2854642: Y(i) = 0.293911912
    i = i + 1: t(i) = 9220: X(i) = 0.28539667: Y(i) = 0.293834364
    i = i + 1: t(i) = 9230: X(i) = 0.285329319: Y(i) = 0.293756991
    i = i + 1: t(i) = 9240: X(i) = 0.285262145: Y(i) = 0.293679792
    i = i + 1: t(i) = 9250: X(i) = 0.28519515: Y(i) = 0.293602768
    i = i + 1: t(i) = 9260: X(i) = 0.285128331: Y(i) = 0.293525917
    i = i + 1: t(i) = 9270: X(i) = 0.285061689: Y(i) = 0.293449238
    i = i + 1: t(i) = 9280: X(i) = 0.284995222: Y(i) = 0.293372733
    i = i + 1: t(i) = 9290: X(i) = 0.28492893: Y(i) = 0.293296399
    i = i + 1: t(i) = 9300: X(i) = 0.284862813: Y(i) = 0.293220236
    i = i + 1: t(i) = 9310: X(i) = 0.284796869: Y(i) = 0.293144244
    i = i + 1: t(i) = 9320: X(i) = 0.284731098: Y(i) = 0.293068423
    i = i + 1: t(i) = 9330: X(i) = 0.2846655: Y(i) = 0.292992772
    i = i + 1: t(i) = 9340: X(i) = 0.284600073: Y(i) = 0.29291729
    i = i + 1: t(i) = 9350: X(i) = 0.284534818: Y(i) = 0.292841976
    i = i + 1: t(i) = 9360: X(i) = 0.284469733: Y(i) = 0.292766831
    i = i + 1: t(i) = 9370: X(i) = 0.284404819: Y(i) = 0.292691854
    i = i + 1: t(i) = 9380: X(i) = 0.284340073: Y(i) = 0.292617045
    i = i + 1: t(i) = 9390: X(i) = 0.284275497: Y(i) = 0.292542402
    i = i + 1: t(i) = 9400: X(i) = 0.284211088: Y(i) = 0.292467925
    i = i + 1: t(i) = 9410: X(i) = 0.284146847: Y(i) = 0.292393615
    i = i + 1: t(i) = 9420: X(i) = 0.284082773: Y(i) = 0.29231947
    i = i + 1: t(i) = 9430: X(i) = 0.284018865: Y(i) = 0.292245489
    i = i + 1: t(i) = 9440: X(i) = 0.283955123: Y(i) = 0.292171673
    i = i + 1: t(i) = 9450: X(i) = 0.283891546: Y(i) = 0.292098021
    i = i + 1: t(i) = 9460: X(i) = 0.283828134: Y(i) = 0.292024533
    i = i + 1: t(i) = 9470: X(i) = 0.283764885: Y(i) = 0.291951207
    i = i + 1: t(i) = 9480: X(i) = 0.2837018: Y(i) = 0.291878044
    i = i + 1: t(i) = 9490: X(i) = 0.283638878: Y(i) = 0.291805042
    i = i + 1: t(i) = 9500: X(i) = 0.283576118: Y(i) = 0.291732203
    i = i + 1: t(i) = 9510: X(i) = 0.283513519: Y(i) = 0.291659524
    i = i + 1: t(i) = 9520: X(i) = 0.283451082: Y(i) = 0.291587006
    i = i + 1: t(i) = 9530: X(i) = 0.283388805: Y(i) = 0.291514648
    i = i + 1: t(i) = 9540: X(i) = 0.283326687: Y(i) = 0.291442449
    i = i + 1: t(i) = 9550: X(i) = 0.28326473: Y(i) = 0.29137041
    i = i + 1: t(i) = 9560: X(i) = 0.28320293: Y(i) = 0.291298529
    i = i + 1: t(i) = 9570: X(i) = 0.283141289: Y(i) = 0.291226807
    i = i + 1: t(i) = 9580: X(i) = 0.283079806: Y(i) = 0.291155242
    i = i + 1: t(i) = 9590: X(i) = 0.28301848: Y(i) = 0.291083835
    i = i + 1: t(i) = 9600: X(i) = 0.28295731: Y(i) = 0.291012584
    i = i + 1: t(i) = 9610: X(i) = 0.282896296: Y(i) = 0.29094149
    i = i + 1: t(i) = 9620: X(i) = 0.282835437: Y(i) = 0.290870551
    i = i + 1: t(i) = 9630: X(i) = 0.282774734: Y(i) = 0.290799768
    i = i + 1: t(i) = 9640: X(i) = 0.282714185: Y(i) = 0.29072914
    i = i + 1: t(i) = 9650: X(i) = 0.282653789: Y(i) = 0.290658667
    i = i + 1: t(i) = 9660: X(i) = 0.282593547: Y(i) = 0.290588347
    i = i + 1: t(i) = 9670: X(i) = 0.282533457: Y(i) = 0.290518181
    i = i + 1: t(i) = 9680: X(i) = 0.282473519: Y(i) = 0.290448169
    i = i + 1: t(i) = 9690: X(i) = 0.282413733: Y(i) = 0.290378309
    i = i + 1: t(i) = 9700: X(i) = 0.282354098: Y(i) = 0.290308601
    i = i + 1: t(i) = 9710: X(i) = 0.282294614: Y(i) = 0.290239046
    i = i + 1: t(i) = 9720: X(i) = 0.28223528: Y(i) = 0.290169641
    i = i + 1: t(i) = 9730: X(i) = 0.282176095: Y(i) = 0.290100388
    i = i + 1: t(i) = 9740: X(i) = 0.282117059: Y(i) = 0.290031285
    i = i + 1: t(i) = 9750: X(i) = 0.282058171: Y(i) = 0.289962332
    i = i + 1: t(i) = 9760: X(i) = 0.281999432: Y(i) = 0.289893529
    i = i + 1: t(i) = 9770: X(i) = 0.28194084: Y(i) = 0.289824875
    i = i + 1: t(i) = 9780: X(i) = 0.281882394: Y(i) = 0.289756369
    i = i + 1: t(i) = 9790: X(i) = 0.281824096: Y(i) = 0.289688012
    i = i + 1: t(i) = 9800: X(i) = 0.281765943: Y(i) = 0.289619803
    i = i + 1: t(i) = 9810: X(i) = 0.281707935: Y(i) = 0.289551742
    i = i + 1: t(i) = 9820: X(i) = 0.281650072: Y(i) = 0.289483827
    i = i + 1: t(i) = 9830: X(i) = 0.281592354: Y(i) = 0.289416059
    i = i + 1: t(i) = 9840: X(i) = 0.281534779: Y(i) = 0.289348438
    i = i + 1: t(i) = 9850: X(i) = 0.281477348: Y(i) = 0.289280962
    i = i + 1: t(i) = 9860: X(i) = 0.281420059: Y(i) = 0.289213631
    i = i + 1: t(i) = 9870: X(i) = 0.281362913: Y(i) = 0.289146445
    i = i + 1: t(i) = 9880: X(i) = 0.281305909: Y(i) = 0.289079404
    i = i + 1: t(i) = 9890: X(i) = 0.281249046: Y(i) = 0.289012507
    i = i + 1: t(i) = 9900: X(i) = 0.281192324: Y(i) = 0.288945753
    i = i + 1: t(i) = 9910: X(i) = 0.281135743: Y(i) = 0.288879143
    i = i + 1: t(i) = 9920: X(i) = 0.281079301: Y(i) = 0.288812676
    i = i + 1: t(i) = 9930: X(i) = 0.281022999: Y(i) = 0.288746351
    i = i + 1: t(i) = 9940: X(i) = 0.280966836: Y(i) = 0.288680168
    i = i + 1: t(i) = 9950: X(i) = 0.280910811: Y(i) = 0.288614127
    i = i + 1: t(i) = 9960: X(i) = 0.280854924: Y(i) = 0.288548227
    i = i + 1: t(i) = 9970: X(i) = 0.280799175: Y(i) = 0.288482467
    i = i + 1: t(i) = 9980: X(i) = 0.280743563: Y(i) = 0.288416848
    i = i + 1: t(i) = 9990: X(i) = 0.280688087: Y(i) = 0.288351369
    i = i + 1: t(i) = 10000: X(i) = 0.280632748: Y(i) = 0.28828603
    
    loadCCTxyTable1931 = i
    
End Function

Private Function loadCCTxyTable1964(X() As Double, Y() As Double) As Integer
    Dim i As Integer: i = 0
    Dim t(901) As Double
    
    i = i + 0: t(i) = 1000: X(i) = 0.650015398: Y(i) = 0.348013681
    i = i + 1: t(i) = 1010: X(i) = 0.648773309: Y(i) = 0.349121309
    i = i + 1: t(i) = 1020: X(i) = 0.647532214: Y(i) = 0.350221493
    i = i + 1: t(i) = 1030: X(i) = 0.646292142: Y(i) = 0.351314052
    i = i + 1: t(i) = 1040: X(i) = 0.645053117: Y(i) = 0.352398812
    i = i + 1: t(i) = 1050: X(i) = 0.643815161: Y(i) = 0.353475605
    i = i + 1: t(i) = 1060: X(i) = 0.642578291: Y(i) = 0.354544269
    i = i + 1: t(i) = 1070: X(i) = 0.641342523: Y(i) = 0.355604649
    i = i + 1: t(i) = 1080: X(i) = 0.640107869: Y(i) = 0.356656594
    i = i + 1: t(i) = 1090: X(i) = 0.638874341: Y(i) = 0.357699961
    i = i + 1: t(i) = 1100: X(i) = 0.637641946: Y(i) = 0.358734612
    i = i + 1: t(i) = 1110: X(i) = 0.636410692: Y(i) = 0.359760414
    i = i + 1: t(i) = 1120: X(i) = 0.635180585: Y(i) = 0.360777239
    i = i + 1: t(i) = 1130: X(i) = 0.633951629: Y(i) = 0.361784966
    i = i + 1: t(i) = 1140: X(i) = 0.632723826: Y(i) = 0.362783478
    i = i + 1: t(i) = 1150: X(i) = 0.631497181: Y(i) = 0.363772664
    i = i + 1: t(i) = 1160: X(i) = 0.630271693: Y(i) = 0.364752416
    i = i + 1: t(i) = 1170: X(i) = 0.629047365: Y(i) = 0.365722633
    i = i + 1: t(i) = 1180: X(i) = 0.627824197: Y(i) = 0.366683219
    i = i + 1: t(i) = 1190: X(i) = 0.62660219: Y(i) = 0.367634081
    i = i + 1: t(i) = 1200: X(i) = 0.625381344: Y(i) = 0.368575133
    i = i + 1: t(i) = 1210: X(i) = 0.62416166: Y(i) = 0.369506291
    i = i + 1: t(i) = 1220: X(i) = 0.622943139: Y(i) = 0.370427477
    i = i + 1: t(i) = 1230: X(i) = 0.62172578: Y(i) = 0.371338618
    i = i + 1: t(i) = 1240: X(i) = 0.620509586: Y(i) = 0.372239644
    i = i + 1: t(i) = 1250: X(i) = 0.619294558: Y(i) = 0.373130491
    i = i + 1: t(i) = 1260: X(i) = 0.618080697: Y(i) = 0.374011097
    i = i + 1: t(i) = 1270: X(i) = 0.616868006: Y(i) = 0.374881406
    i = i + 1: t(i) = 1280: X(i) = 0.615656489: Y(i) = 0.375741365
    i = i + 1: t(i) = 1290: X(i) = 0.614446149: Y(i) = 0.376590927
    i = i + 1: t(i) = 1300: X(i) = 0.61323699: Y(i) = 0.377430046
    i = i + 1: t(i) = 1310: X(i) = 0.612029017: Y(i) = 0.378258682
    i = i + 1: t(i) = 1320: X(i) = 0.610822237: Y(i) = 0.379076797
    i = i + 1: t(i) = 1330: X(i) = 0.609616656: Y(i) = 0.37988436
    i = i + 1: t(i) = 1340: X(i) = 0.608412282: Y(i) = 0.38068134
    i = i + 1: t(i) = 1350: X(i) = 0.607209122: Y(i) = 0.381467712
    i = i + 1: t(i) = 1360: X(i) = 0.606007187: Y(i) = 0.382243454
    i = i + 1: t(i) = 1370: X(i) = 0.604806486: Y(i) = 0.383008546
    i = i + 1: t(i) = 1380: X(i) = 0.603607031: Y(i) = 0.383762974
    i = i + 1: t(i) = 1390: X(i) = 0.602408833: Y(i) = 0.384506725
    i = i + 1: t(i) = 1400: X(i) = 0.601211904: Y(i) = 0.385239792
    i = i + 1: t(i) = 1410: X(i) = 0.600016259: Y(i) = 0.385962167
    i = i + 1: t(i) = 1420: X(i) = 0.598821912: Y(i) = 0.38667385
    i = i + 1: t(i) = 1430: X(i) = 0.597628879: Y(i) = 0.387374841
    i = i + 1: t(i) = 1440: X(i) = 0.596437175: Y(i) = 0.388065144
    i = i + 1: t(i) = 1450: X(i) = 0.595246818: Y(i) = 0.388744766
    i = i + 1: t(i) = 1460: X(i) = 0.594057826: Y(i) = 0.389413716
    i = i + 1: t(i) = 1470: X(i) = 0.592870217: Y(i) = 0.390072007
    i = i + 1: t(i) = 1480: X(i) = 0.591684011: Y(i) = 0.390719654
    i = i + 1: t(i) = 1490: X(i) = 0.590499228: Y(i) = 0.391356676
    i = i + 1: t(i) = 1500: X(i) = 0.589315889: Y(i) = 0.391983092
    i = i + 1: t(i) = 1510: X(i) = 0.588134016: Y(i) = 0.392598927
    i = i + 1: t(i) = 1520: X(i) = 0.586953632: Y(i) = 0.393204206
    i = i + 1: t(i) = 1530: X(i) = 0.58577476: Y(i) = 0.393798956
    i = i + 1: t(i) = 1540: X(i) = 0.584597423: Y(i) = 0.39438321
    i = i + 1: t(i) = 1550: X(i) = 0.583421646: Y(i) = 0.394956999
    i = i + 1: t(i) = 1560: X(i) = 0.582247454: Y(i) = 0.39552036
    i = i + 1: t(i) = 1570: X(i) = 0.581074873: Y(i) = 0.396073328
    i = i + 1: t(i) = 1580: X(i) = 0.579903928: Y(i) = 0.396615944
    i = i + 1: t(i) = 1590: X(i) = 0.578734648: Y(i) = 0.39714825
    i = i + 1: t(i) = 1600: X(i) = 0.577567058: Y(i) = 0.397670289
    i = i + 1: t(i) = 1610: X(i) = 0.576401186: Y(i) = 0.398182106
    i = i + 1: t(i) = 1620: X(i) = 0.575237062: Y(i) = 0.39868375
    i = i + 1: t(i) = 1630: X(i) = 0.574074712: Y(i) = 0.399175268
    i = i + 1: t(i) = 1640: X(i) = 0.572914166: Y(i) = 0.399656714
    i = i + 1: t(i) = 1650: X(i) = 0.571755452: Y(i) = 0.400128138
    i = i + 1: t(i) = 1660: X(i) = 0.570598602: Y(i) = 0.400589596
    i = i + 1: t(i) = 1670: X(i) = 0.569443644: Y(i) = 0.401041144
    i = i + 1: t(i) = 1680: X(i) = 0.568290608: Y(i) = 0.401482839
    i = i + 1: t(i) = 1690: X(i) = 0.567139525: Y(i) = 0.401914741
    i = i + 1: t(i) = 1700: X(i) = 0.565990424: Y(i) = 0.40233691
    i = i + 1: t(i) = 1710: X(i) = 0.564843338: Y(i) = 0.402749407
    i = i + 1: t(i) = 1720: X(i) = 0.563698296: Y(i) = 0.403152297
    i = i + 1: t(i) = 1730: X(i) = 0.562555329: Y(i) = 0.403545643
    i = i + 1: t(i) = 1740: X(i) = 0.561414468: Y(i) = 0.403929511
    i = i + 1: t(i) = 1750: X(i) = 0.560275745: Y(i) = 0.404303968
    i = i + 1: t(i) = 1760: X(i) = 0.55913919: Y(i) = 0.404669083
    i = i + 1: t(i) = 1770: X(i) = 0.558004834: Y(i) = 0.405024923
    i = i + 1: t(i) = 1780: X(i) = 0.556872709: Y(i) = 0.40537156
    i = i + 1: t(i) = 1790: X(i) = 0.555742845: Y(i) = 0.405709064
    i = i + 1: t(i) = 1800: X(i) = 0.554615273: Y(i) = 0.406037506
    i = i + 1: t(i) = 1810: X(i) = 0.553490025: Y(i) = 0.406356961
    i = i + 1: t(i) = 1820: X(i) = 0.552367131: Y(i) = 0.406667501
    i = i + 1: t(i) = 1830: X(i) = 0.551246621: Y(i) = 0.406969201
    i = i + 1: t(i) = 1840: X(i) = 0.550128527: Y(i) = 0.407262136
    i = i + 1: t(i) = 1850: X(i) = 0.549012877: Y(i) = 0.407546381
    i = i + 1: t(i) = 1860: X(i) = 0.547899704: Y(i) = 0.407822014
    i = i + 1: t(i) = 1870: X(i) = 0.546789035: Y(i) = 0.408089111
    i = i + 1: t(i) = 1880: X(i) = 0.545680902: Y(i) = 0.408347749
    i = i + 1: t(i) = 1890: X(i) = 0.544575334: Y(i) = 0.408598007
    i = i + 1: t(i) = 1900: X(i) = 0.543472359: Y(i) = 0.408839963
    i = i + 1: t(i) = 1910: X(i) = 0.542372007: Y(i) = 0.409073697
    i = i + 1: t(i) = 1920: X(i) = 0.541274306: Y(i) = 0.409299287
    i = i + 1: t(i) = 1930: X(i) = 0.540179285: Y(i) = 0.409516814
    i = i + 1: t(i) = 1940: X(i) = 0.539086971: Y(i) = 0.409726357
    i = i + 1: t(i) = 1950: X(i) = 0.537997393: Y(i) = 0.409927996
    i = i + 1: t(i) = 1960: X(i) = 0.536910577: Y(i) = 0.410121813
    i = i + 1: t(i) = 1970: X(i) = 0.535826551: Y(i) = 0.410307888
    i = i + 1: t(i) = 1980: X(i) = 0.534745341: Y(i) = 0.410486303
    i = i + 1: t(i) = 1990: X(i) = 0.533666973: Y(i) = 0.410657137
    i = i + 1: t(i) = 2000: X(i) = 0.532591473: Y(i) = 0.410820473
    i = i + 1: t(i) = 2010: X(i) = 0.531518868: Y(i) = 0.410976392
    i = i + 1: t(i) = 2020: X(i) = 0.53044918: Y(i) = 0.411124975
    i = i + 1: t(i) = 2030: X(i) = 0.529382436: Y(i) = 0.411266303
    i = i + 1: t(i) = 2040: X(i) = 0.52831866: Y(i) = 0.411400458
    i = i + 1: t(i) = 2050: X(i) = 0.527257875: Y(i) = 0.411527522
    i = i + 1: t(i) = 2060: X(i) = 0.526200104: Y(i) = 0.411647576
    i = i + 1: t(i) = 2070: X(i) = 0.52514537: Y(i) = 0.4117607
    i = i + 1: t(i) = 2080: X(i) = 0.524093696: Y(i) = 0.411866976
    i = i + 1: t(i) = 2090: X(i) = 0.523045104: Y(i) = 0.411966486
    i = i + 1: t(i) = 2100: X(i) = 0.521999615: Y(i) = 0.412059309
    i = i + 1: t(i) = 2110: X(i) = 0.520957251: Y(i) = 0.412145527
    i = i + 1: t(i) = 2120: X(i) = 0.519918031: Y(i) = 0.41222522
    i = i + 1: t(i) = 2130: X(i) = 0.518881975: Y(i) = 0.412298468
    i = i + 1: t(i) = 2140: X(i) = 0.517849105: Y(i) = 0.412365352
    i = i + 1: t(i) = 2150: X(i) = 0.516819437: Y(i) = 0.41242595
    i = i + 1: t(i) = 2160: X(i) = 0.515792992: Y(i) = 0.412480343
    i = i + 1: t(i) = 2170: X(i) = 0.514769787: Y(i) = 0.41252861
    i = i + 1: t(i) = 2180: X(i) = 0.51374984: Y(i) = 0.412570829
    i = i + 1: t(i) = 2190: X(i) = 0.512733169: Y(i) = 0.412607079
    i = i + 1: t(i) = 2200: X(i) = 0.511719789: Y(i) = 0.412637438
    i = i + 1: t(i) = 2210: X(i) = 0.510709717: Y(i) = 0.412661983
    i = i + 1: t(i) = 2220: X(i) = 0.509702969: Y(i) = 0.412680793
    i = i + 1: t(i) = 2230: X(i) = 0.50869956: Y(i) = 0.412693944
    i = i + 1: t(i) = 2240: X(i) = 0.507699504: Y(i) = 0.412701513
    i = i + 1: t(i) = 2250: X(i) = 0.506702817: Y(i) = 0.412703576
    i = i + 1: t(i) = 2260: X(i) = 0.505709511: Y(i) = 0.412700209
    i = i + 1: t(i) = 2270: X(i) = 0.504719601: Y(i) = 0.412691486
    i = i + 1: t(i) = 2280: X(i) = 0.503733098: Y(i) = 0.412677483
    i = i + 1: t(i) = 2290: X(i) = 0.502750015: Y(i) = 0.412658274
    i = i + 1: t(i) = 2300: X(i) = 0.501770365: Y(i) = 0.412633933
    i = i + 1: t(i) = 2310: X(i) = 0.500794158: Y(i) = 0.412604533
    i = i + 1: t(i) = 2320: X(i) = 0.499821405: Y(i) = 0.412570147
    i = i + 1: t(i) = 2330: X(i) = 0.498852117: Y(i) = 0.412530848
    i = i + 1: t(i) = 2340: X(i) = 0.497886304: Y(i) = 0.412486706
    i = i + 1: t(i) = 2350: X(i) = 0.496923974: Y(i) = 0.412437794
    i = i + 1: t(i) = 2360: X(i) = 0.495965139: Y(i) = 0.412384182
    i = i + 1: t(i) = 2370: X(i) = 0.495009805: Y(i) = 0.41232594
    i = i + 1: t(i) = 2380: X(i) = 0.494057981: Y(i) = 0.412263138
    i = i + 1: t(i) = 2390: X(i) = 0.493109674: Y(i) = 0.412195845
    i = i + 1: t(i) = 2400: X(i) = 0.492164893: Y(i) = 0.412124129
    i = i + 1: t(i) = 2410: X(i) = 0.491223643: Y(i) = 0.412048059
    i = i + 1: t(i) = 2420: X(i) = 0.490285932: Y(i) = 0.411967701
    i = i + 1: t(i) = 2430: X(i) = 0.489351765: Y(i) = 0.411883123
    i = i + 1: t(i) = 2440: X(i) = 0.488421147: Y(i) = 0.411794391
    i = i + 1: t(i) = 2450: X(i) = 0.487494084: Y(i) = 0.411701569
    i = i + 1: t(i) = 2460: X(i) = 0.486570581: Y(i) = 0.411604724
    i = i + 1: t(i) = 2470: X(i) = 0.485650641: Y(i) = 0.41150392
    i = i + 1: t(i) = 2480: X(i) = 0.484734269: Y(i) = 0.41139922
    i = i + 1: t(i) = 2490: X(i) = 0.483821467: Y(i) = 0.411290688
    i = i + 1: t(i) = 2500: X(i) = 0.48291224: Y(i) = 0.411178386
    i = i + 1: t(i) = 2510: X(i) = 0.48200659: Y(i) = 0.411062377
    i = i + 1: t(i) = 2520: X(i) = 0.481104519: Y(i) = 0.410942721
    i = i + 1: t(i) = 2530: X(i) = 0.480206028: Y(i) = 0.410819479
    i = i + 1: t(i) = 2540: X(i) = 0.479311121: Y(i) = 0.410692712
    i = i + 1: t(i) = 2550: X(i) = 0.478419797: Y(i) = 0.410562479
    i = i + 1: t(i) = 2560: X(i) = 0.477532057: Y(i) = 0.41042884
    i = i + 1: t(i) = 2570: X(i) = 0.476647903: Y(i) = 0.410291852
    i = i + 1: t(i) = 2580: X(i) = 0.475767334: Y(i) = 0.410151573
    i = i + 1: t(i) = 2590: X(i) = 0.474890349: Y(i) = 0.41000806
    i = i + 1: t(i) = 2600: X(i) = 0.474016949: Y(i) = 0.40986137
    i = i + 1: t(i) = 2610: X(i) = 0.473147132: Y(i) = 0.409711559
    i = i + 1: t(i) = 2620: X(i) = 0.472280898: Y(i) = 0.409558682
    i = i + 1: t(i) = 2630: X(i) = 0.471418244: Y(i) = 0.409402793
    i = i + 1: t(i) = 2640: X(i) = 0.470559168: Y(i) = 0.409243947
    i = i + 1: t(i) = 2650: X(i) = 0.469703669: Y(i) = 0.409082198
    i = i + 1: t(i) = 2660: X(i) = 0.468851744: Y(i) = 0.408917597
    i = i + 1: t(i) = 2670: X(i) = 0.46800339: Y(i) = 0.408750198
    i = i + 1: t(i) = 2680: X(i) = 0.467158604: Y(i) = 0.408580052
    i = i + 1: t(i) = 2690: X(i) = 0.466317383: Y(i) = 0.40840721
    i = i + 1: t(i) = 2700: X(i) = 0.465479723: Y(i) = 0.408231722
    i = i + 1: t(i) = 2710: X(i) = 0.46464562: Y(i) = 0.408053639
    i = i + 1: t(i) = 2720: X(i) = 0.463815069: Y(i) = 0.40787301
    i = i + 1: t(i) = 2730: X(i) = 0.462988067: Y(i) = 0.407689883
    i = i + 1: t(i) = 2740: X(i) = 0.462164608: Y(i) = 0.407504306
    i = i + 1: t(i) = 2750: X(i) = 0.461344688: Y(i) = 0.407316328
    i = i + 1: t(i) = 2760: X(i) = 0.460528301: Y(i) = 0.407125994
    i = i + 1: t(i) = 2770: X(i) = 0.459715441: Y(i) = 0.406933352
    i = i + 1: t(i) = 2780: X(i) = 0.458906103: Y(i) = 0.406738447
    i = i + 1: t(i) = 2790: X(i) = 0.458100282: Y(i) = 0.406541324
    i = i + 1: t(i) = 2800: X(i) = 0.45729797: Y(i) = 0.406342028
    i = i + 1: t(i) = 2810: X(i) = 0.456499161: Y(i) = 0.406140604
    i = i + 1: t(i) = 2820: X(i) = 0.455703849: Y(i) = 0.405937094
    i = i + 1: t(i) = 2830: X(i) = 0.454912026: Y(i) = 0.405731542
    i = i + 1: t(i) = 2840: X(i) = 0.454123686: Y(i) = 0.40552399
    i = i + 1: t(i) = 2850: X(i) = 0.453338821: Y(i) = 0.40531448
    i = i + 1: t(i) = 2860: X(i) = 0.452557424: Y(i) = 0.405103053
    i = i + 1: t(i) = 2870: X(i) = 0.451779487: Y(i) = 0.404889751
    i = i + 1: t(i) = 2880: X(i) = 0.451005001: Y(i) = 0.404674613
    i = i + 1: t(i) = 2890: X(i) = 0.45023396: Y(i) = 0.404457679
    i = i + 1: t(i) = 2900: X(i) = 0.449466355: Y(i) = 0.404238989
    i = i + 1: t(i) = 2910: X(i) = 0.448702177: Y(i) = 0.404018581
    i = i + 1: t(i) = 2920: X(i) = 0.447941418: Y(i) = 0.403796493
    i = i + 1: t(i) = 2930: X(i) = 0.447184068: Y(i) = 0.403572763
    i = i + 1: t(i) = 2940: X(i) = 0.44643012: Y(i) = 0.403347429
    i = i + 1: t(i) = 2950: X(i) = 0.445679564: Y(i) = 0.403120526
    i = i + 1: t(i) = 2960: X(i) = 0.44493239: Y(i) = 0.402892091
    i = i + 1: t(i) = 2970: X(i) = 0.444188589: Y(i) = 0.40266216
    i = i + 1: t(i) = 2980: X(i) = 0.443448152: Y(i) = 0.402430768
    i = i + 1: t(i) = 2990: X(i) = 0.442711069: Y(i) = 0.402197949
    i = i + 1: t(i) = 3000: X(i) = 0.44197733: Y(i) = 0.401963738
    i = i + 1: t(i) = 3010: X(i) = 0.441246925: Y(i) = 0.401728169
    i = i + 1: t(i) = 3020: X(i) = 0.440519845: Y(i) = 0.401491274
    i = i + 1: t(i) = 3030: X(i) = 0.439796078: Y(i) = 0.401253086
    i = i + 1: t(i) = 3040: X(i) = 0.439075615: Y(i) = 0.401013638
    i = i + 1: t(i) = 3050: X(i) = 0.438358444: Y(i) = 0.400772962
    i = i + 1: t(i) = 3060: X(i) = 0.437644557: Y(i) = 0.400531089
    i = i + 1: t(i) = 3070: X(i) = 0.436933941: Y(i) = 0.40028805
    i = i + 1: t(i) = 3080: X(i) = 0.436226586: Y(i) = 0.400043876
    i = i + 1: t(i) = 3090: X(i) = 0.435522481: Y(i) = 0.399798596
    i = i + 1: t(i) = 3100: X(i) = 0.434821616: Y(i) = 0.39955224
    i = i + 1: t(i) = 3110: X(i) = 0.434123978: Y(i) = 0.399304838
    i = i + 1: t(i) = 3120: X(i) = 0.433429558: Y(i) = 0.399056418
    i = i + 1: t(i) = 3130: X(i) = 0.432738343: Y(i) = 0.398807008
    i = i + 1: t(i) = 3140: X(i) = 0.432050322: Y(i) = 0.398556637
    i = i + 1: t(i) = 3150: X(i) = 0.431365485: Y(i) = 0.398305332
    i = i + 1: t(i) = 3160: X(i) = 0.430683818: Y(i) = 0.398053121
    i = i + 1: t(i) = 3170: X(i) = 0.430005312: Y(i) = 0.397800029
    i = i + 1: t(i) = 3180: X(i) = 0.429329954: Y(i) = 0.397546083
    i = i + 1: t(i) = 3190: X(i) = 0.428657731: Y(i) = 0.397291309
    i = i + 1: t(i) = 3200: X(i) = 0.427988634: Y(i) = 0.397035733
    i = i + 1: t(i) = 3210: X(i) = 0.427322649: Y(i) = 0.39677938
    i = i + 1: t(i) = 3220: X(i) = 0.426659766: Y(i) = 0.396522274
    i = i + 1: t(i) = 3230: X(i) = 0.425999971: Y(i) = 0.39626444
    i = i + 1: t(i) = 3240: X(i) = 0.425343253: Y(i) = 0.396005902
    i = i + 1: t(i) = 3250: X(i) = 0.424689599: Y(i) = 0.395746683
    i = i + 1: t(i) = 3260: X(i) = 0.424038999: Y(i) = 0.395486808
    i = i + 1: t(i) = 3270: X(i) = 0.423391439: Y(i) = 0.395226298
    i = i + 1: t(i) = 3280: X(i) = 0.422746907: Y(i) = 0.394965176
    i = i + 1: t(i) = 3290: X(i) = 0.422105391: Y(i) = 0.394703465
    i = i + 1: t(i) = 3300: X(i) = 0.421466879: Y(i) = 0.394441186
    i = i + 1: t(i) = 3310: X(i) = 0.420831358: Y(i) = 0.394178362
    i = i + 1: t(i) = 3320: X(i) = 0.420198816: Y(i) = 0.393915012
    i = i + 1: t(i) = 3330: X(i) = 0.41956924: Y(i) = 0.393651158
    i = i + 1: t(i) = 3340: X(i) = 0.418942619: Y(i) = 0.393386821
    i = i + 1: t(i) = 3350: X(i) = 0.41831894: Y(i) = 0.393122021
    i = i + 1: t(i) = 3360: X(i) = 0.417698189: Y(i) = 0.392856777
    i = i + 1: t(i) = 3370: X(i) = 0.417080356: Y(i) = 0.392591109
    i = i + 1: t(i) = 3380: X(i) = 0.416465427: Y(i) = 0.392325036
    i = i + 1: t(i) = 3390: X(i) = 0.415853389: Y(i) = 0.392058578
    i = i + 1: t(i) = 3400: X(i) = 0.41524423: Y(i) = 0.391791753
    i = i + 1: t(i) = 3410: X(i) = 0.414637938: Y(i) = 0.391524579
    i = i + 1: t(i) = 3420: X(i) = 0.414034499: Y(i) = 0.391257074
    i = i + 1: t(i) = 3430: X(i) = 0.413433902: Y(i) = 0.390989257
    i = i + 1: t(i) = 3440: X(i) = 0.412836134: Y(i) = 0.390721143
    i = i + 1: t(i) = 3450: X(i) = 0.412241181: Y(i) = 0.390452752
    i = i + 1: t(i) = 3460: X(i) = 0.411649032: Y(i) = 0.390184099
    i = i + 1: t(i) = 3470: X(i) = 0.411059674: Y(i) = 0.389915201
    i = i + 1: t(i) = 3480: X(i) = 0.410473094: Y(i) = 0.389646074
    i = i + 1: t(i) = 3490: X(i) = 0.40988928: Y(i) = 0.389376735
    i = i + 1: t(i) = 3500: X(i) = 0.409308218: Y(i) = 0.389107199
    i = i + 1: t(i) = 3510: X(i) = 0.408729896: Y(i) = 0.388837482
    i = i + 1: t(i) = 3520: X(i) = 0.408154303: Y(i) = 0.3885676
    i = i + 1: t(i) = 3530: X(i) = 0.407581424: Y(i) = 0.388297566
    i = i + 1: t(i) = 3540: X(i) = 0.407011247: Y(i) = 0.388027396
    i = i + 1: t(i) = 3550: X(i) = 0.406443761: Y(i) = 0.387757104
    i = i + 1: t(i) = 3560: X(i) = 0.405878951: Y(i) = 0.387486705
    i = i + 1: t(i) = 3570: X(i) = 0.405316806: Y(i) = 0.387216212
    i = i + 1: t(i) = 3580: X(i) = 0.404757313: Y(i) = 0.38694564
    i = i + 1: t(i) = 3590: X(i) = 0.40420046: Y(i) = 0.386675001
    i = i + 1: t(i) = 3600: X(i) = 0.403646233: Y(i) = 0.38640431
    i = i + 1: t(i) = 3610: X(i) = 0.403094621: Y(i) = 0.386133579
    i = i + 1: t(i) = 3620: X(i) = 0.402545611: Y(i) = 0.385862821
    i = i + 1: t(i) = 3630: X(i) = 0.401999189: Y(i) = 0.385592048
    i = i + 1: t(i) = 3640: X(i) = 0.401455345: Y(i) = 0.385321274
    i = i + 1: t(i) = 3650: X(i) = 0.400914066: Y(i) = 0.38505051
    i = i + 1: t(i) = 3660: X(i) = 0.400375338: Y(i) = 0.384779768
    i = i + 1: t(i) = 3670: X(i) = 0.39983915: Y(i) = 0.38450906
    i = i + 1: t(i) = 3680: X(i) = 0.399305489: Y(i) = 0.384238398
    i = i + 1: t(i) = 3690: X(i) = 0.398774343: Y(i) = 0.383967792
    i = i + 1: t(i) = 3700: X(i) = 0.398245699: Y(i) = 0.383697254
    i = i + 1: t(i) = 3710: X(i) = 0.397719545: Y(i) = 0.383426796
    i = i + 1: t(i) = 3720: X(i) = 0.39719587: Y(i) = 0.383156427
    i = i + 1: t(i) = 3730: X(i) = 0.39667466: Y(i) = 0.382886158
    i = i + 1: t(i) = 3740: X(i) = 0.396155903: Y(i) = 0.382615999
    i = i + 1: t(i) = 3750: X(i) = 0.395639588: Y(i) = 0.382345962
    i = i + 1: t(i) = 3760: X(i) = 0.395125701: Y(i) = 0.382076054
    i = i + 1: t(i) = 3770: X(i) = 0.394614232: Y(i) = 0.381806288
    i = i + 1: t(i) = 3780: X(i) = 0.394105167: Y(i) = 0.381536671
    i = i + 1: t(i) = 3790: X(i) = 0.393598495: Y(i) = 0.381267214
    i = i + 1: t(i) = 3800: X(i) = 0.393094204: Y(i) = 0.380997926
    i = i + 1: t(i) = 3810: X(i) = 0.392592282: Y(i) = 0.380728815
    i = i + 1: t(i) = 3820: X(i) = 0.392092716: Y(i) = 0.380459891
    i = i + 1: t(i) = 3830: X(i) = 0.391595495: Y(i) = 0.380191163
    i = i + 1: t(i) = 3840: X(i) = 0.391100606: Y(i) = 0.379922639
    i = i + 1: t(i) = 3850: X(i) = 0.390608039: Y(i) = 0.379654327
    i = i + 1: t(i) = 3860: X(i) = 0.390117781: Y(i) = 0.379386236
    i = i + 1: t(i) = 3870: X(i) = 0.389629821: Y(i) = 0.379118374
    i = i + 1: t(i) = 3880: X(i) = 0.389144146: Y(i) = 0.378850748
    i = i + 1: t(i) = 3890: X(i) = 0.388660745: Y(i) = 0.378583367
    i = i + 1: t(i) = 3900: X(i) = 0.388179606: Y(i) = 0.378316239
    i = i + 1: t(i) = 3910: X(i) = 0.387700718: Y(i) = 0.37804937
    i = i + 1: t(i) = 3920: X(i) = 0.38722407: Y(i) = 0.377782768
    i = i + 1: t(i) = 3930: X(i) = 0.386749648: Y(i) = 0.37751644
    i = i + 1: t(i) = 3940: X(i) = 0.386277443: Y(i) = 0.377250393
    i = i + 1: t(i) = 3950: X(i) = 0.385807442: Y(i) = 0.376984635
    i = i + 1: t(i) = 3960: X(i) = 0.385339635: Y(i) = 0.376719171
    i = i + 1: t(i) = 3970: X(i) = 0.384874009: Y(i) = 0.376454009
    i = i + 1: t(i) = 3980: X(i) = 0.384410553: Y(i) = 0.376189155
    i = i + 1: t(i) = 3990: X(i) = 0.383949257: Y(i) = 0.375924616
    i = i + 1: t(i) = 4000: X(i) = 0.383490108: Y(i) = 0.375660397
    i = i + 1: t(i) = 4010: X(i) = 0.383033097: Y(i) = 0.375396505
    i = i + 1: t(i) = 4020: X(i) = 0.38257821: Y(i) = 0.375132946
    i = i + 1: t(i) = 4030: X(i) = 0.382125439: Y(i) = 0.374869726
    i = i + 1: t(i) = 4040: X(i) = 0.38167477: Y(i) = 0.374606849
    i = i + 1: t(i) = 4050: X(i) = 0.381226194: Y(i) = 0.374344323
    i = i + 1: t(i) = 4060: X(i) = 0.380779699: Y(i) = 0.374082153
    i = i + 1: t(i) = 4070: X(i) = 0.380335274: Y(i) = 0.373820343
    i = i + 1: t(i) = 4080: X(i) = 0.379892909: Y(i) = 0.373558899
    i = i + 1: t(i) = 4090: X(i) = 0.379452593: Y(i) = 0.373297827
    i = i + 1: t(i) = 4100: X(i) = 0.379014314: Y(i) = 0.373037131
    i = i + 1: t(i) = 4110: X(i) = 0.378578062: Y(i) = 0.372776816
    i = i + 1: t(i) = 4120: X(i) = 0.378143827: Y(i) = 0.372516887
    i = i + 1: t(i) = 4130: X(i) = 0.377711598: Y(i) = 0.37225735
    i = i + 1: t(i) = 4140: X(i) = 0.377281363: Y(i) = 0.371998207
    i = i + 1: t(i) = 4150: X(i) = 0.376853113: Y(i) = 0.371739465
    i = i + 1: t(i) = 4160: X(i) = 0.376426837: Y(i) = 0.371481127
    i = i + 1: t(i) = 4170: X(i) = 0.376002525: Y(i) = 0.371223197
    i = i + 1: t(i) = 4180: X(i) = 0.375580165: Y(i) = 0.37096568
    i = i + 1: t(i) = 4190: X(i) = 0.375159749: Y(i) = 0.370708581
    i = i + 1: t(i) = 4200: X(i) = 0.374741265: Y(i) = 0.370451902
    i = i + 1: t(i) = 4210: X(i) = 0.374324702: Y(i) = 0.370195648
    i = i + 1: t(i) = 4220: X(i) = 0.373910052: Y(i) = 0.369939823
    i = i + 1: t(i) = 4230: X(i) = 0.373497303: Y(i) = 0.36968443
    i = i + 1: t(i) = 4240: X(i) = 0.373086446: Y(i) = 0.369429474
    i = i + 1: t(i) = 4250: X(i) = 0.372677471: Y(i) = 0.369174957
    i = i + 1: t(i) = 4260: X(i) = 0.372270366: Y(i) = 0.368920883
    i = i + 1: t(i) = 4270: X(i) = 0.371865124: Y(i) = 0.368667256
    i = i + 1: t(i) = 4280: X(i) = 0.371461732: Y(i) = 0.368414079
    i = i + 1: t(i) = 4290: X(i) = 0.371060182: Y(i) = 0.368161354
    i = i + 1: t(i) = 4300: X(i) = 0.370660464: Y(i) = 0.367909086
    i = i + 1: t(i) = 4310: X(i) = 0.370262568: Y(i) = 0.367657277
    i = i + 1: t(i) = 4320: X(i) = 0.369866483: Y(i) = 0.367405931
    i = i + 1: t(i) = 4330: X(i) = 0.369472202: Y(i) = 0.367155049
    i = i + 1: t(i) = 4340: X(i) = 0.369079713: Y(i) = 0.366904636
    i = i + 1: t(i) = 4350: X(i) = 0.368689007: Y(i) = 0.366654693
    i = i + 1: t(i) = 4360: X(i) = 0.368300074: Y(i) = 0.366405224
    i = i + 1: t(i) = 4370: X(i) = 0.367912906: Y(i) = 0.36615623
    i = i + 1: t(i) = 4380: X(i) = 0.367527492: Y(i) = 0.365907715
    i = i + 1: t(i) = 4390: X(i) = 0.367143824: Y(i) = 0.365659682
    i = i + 1: t(i) = 4400: X(i) = 0.366761891: Y(i) = 0.365412131
    i = i + 1: t(i) = 4410: X(i) = 0.366381684: Y(i) = 0.365165067
    i = i + 1: t(i) = 4420: X(i) = 0.366003195: Y(i) = 0.36491849
    i = i + 1: t(i) = 4430: X(i) = 0.365626414: Y(i) = 0.364672403
    i = i + 1: t(i) = 4440: X(i) = 0.365251331: Y(i) = 0.364426809
    i = i + 1: t(i) = 4450: X(i) = 0.364877938: Y(i) = 0.364181709
    i = i + 1: t(i) = 4460: X(i) = 0.364506226: Y(i) = 0.363937106
    i = i + 1: t(i) = 4470: X(i) = 0.364136185: Y(i) = 0.363693001
    i = i + 1: t(i) = 4480: X(i) = 0.363767807: Y(i) = 0.363449396
    i = i + 1: t(i) = 4490: X(i) = 0.363401082: Y(i) = 0.363206293
    i = i + 1: t(i) = 4500: X(i) = 0.363036002: Y(i) = 0.362963694
    i = i + 1: t(i) = 4510: X(i) = 0.362672557: Y(i) = 0.3627216
    i = i + 1: t(i) = 4520: X(i) = 0.362310739: Y(i) = 0.362480013
    i = i + 1: t(i) = 4530: X(i) = 0.36195054: Y(i) = 0.362238935
    i = i + 1: t(i) = 4540: X(i) = 0.36159195: Y(i) = 0.361998368
    i = i + 1: t(i) = 4550: X(i) = 0.361234961: Y(i) = 0.361758312
    i = i + 1: t(i) = 4560: X(i) = 0.360879565: Y(i) = 0.361518769
    i = i + 1: t(i) = 4570: X(i) = 0.360525751: Y(i) = 0.361279741
    i = i + 1: t(i) = 4580: X(i) = 0.360173513: Y(i) = 0.361041229
    i = i + 1: t(i) = 4590: X(i) = 0.359822842: Y(i) = 0.360803234
    i = i + 1: t(i) = 4600: X(i) = 0.359473728: Y(i) = 0.360565757
    i = i + 1: t(i) = 4610: X(i) = 0.359126165: Y(i) = 0.3603288
    i = i + 1: t(i) = 4620: X(i) = 0.358780143: Y(i) = 0.360092363
    i = i + 1: t(i) = 4630: X(i) = 0.358435654: Y(i) = 0.359856448
    i = i + 1: t(i) = 4640: X(i) = 0.35809269: Y(i) = 0.359621056
    i = i + 1: t(i) = 4650: X(i) = 0.357751242: Y(i) = 0.359386188
    i = i + 1: t(i) = 4660: X(i) = 0.357411303: Y(i) = 0.359151844
    i = i + 1: t(i) = 4670: X(i) = 0.357072865: Y(i) = 0.358918026
    i = i + 1: t(i) = 4680: X(i) = 0.356735918: Y(i) = 0.358684735
    i = i + 1: t(i) = 4690: X(i) = 0.356400456: Y(i) = 0.358451971
    i = i + 1: t(i) = 4700: X(i) = 0.356066471: Y(i) = 0.358219735
    i = i + 1: t(i) = 4710: X(i) = 0.355733953: Y(i) = 0.357988028
    i = i + 1: t(i) = 4720: X(i) = 0.355402896: Y(i) = 0.35775685
    i = i + 1: t(i) = 4730: X(i) = 0.355073292: Y(i) = 0.357526202
    i = i + 1: t(i) = 4740: X(i) = 0.354745132: Y(i) = 0.357296085
    i = i + 1: t(i) = 4750: X(i) = 0.354418409: Y(i) = 0.3570665
    i = i + 1: t(i) = 4760: X(i) = 0.354093116: Y(i) = 0.356837446
    i = i + 1: t(i) = 4770: X(i) = 0.353769244: Y(i) = 0.356608925
    i = i + 1: t(i) = 4780: X(i) = 0.353446786: Y(i) = 0.356380937
    i = i + 1: t(i) = 4790: X(i) = 0.353125735: Y(i) = 0.356153481
    i = i + 1: t(i) = 4800: X(i) = 0.352806082: Y(i) = 0.35592656
    i = i + 1: t(i) = 4810: X(i) = 0.352487821: Y(i) = 0.355700172
    i = i + 1: t(i) = 4820: X(i) = 0.352170943: Y(i) = 0.355474319
    i = i + 1: t(i) = 4830: X(i) = 0.351855442: Y(i) = 0.355249001
    i = i + 1: t(i) = 4840: X(i) = 0.35154131: Y(i) = 0.355024217
    i = i + 1: t(i) = 4850: X(i) = 0.351228539: Y(i) = 0.354799969
    i = i + 1: t(i) = 4860: X(i) = 0.350917123: Y(i) = 0.354576256
    i = i + 1: t(i) = 4870: X(i) = 0.350607054: Y(i) = 0.354353078
    i = i + 1: t(i) = 4880: X(i) = 0.350298325: Y(i) = 0.354130436
    i = i + 1: t(i) = 4890: X(i) = 0.349990928: Y(i) = 0.35390833
    i = i + 1: t(i) = 4900: X(i) = 0.349684857: Y(i) = 0.353686759
    i = i + 1: t(i) = 4910: X(i) = 0.349380105: Y(i) = 0.353465725
    i = i + 1: t(i) = 4920: X(i) = 0.349076664: Y(i) = 0.353245226
    i = i + 1: t(i) = 4930: X(i) = 0.348774528: Y(i) = 0.353025263
    i = i + 1: t(i) = 4940: X(i) = 0.348473688: Y(i) = 0.352805836
    i = i + 1: t(i) = 4950: X(i) = 0.34817414: Y(i) = 0.352586944
    i = i + 1: t(i) = 4960: X(i) = 0.347875875: Y(i) = 0.352368589
    i = i + 1: t(i) = 4970: X(i) = 0.347578887: Y(i) = 0.352150769
    i = i + 1: t(i) = 4980: X(i) = 0.347283168: Y(i) = 0.351933484
    i = i + 1: t(i) = 4990: X(i) = 0.346988713: Y(i) = 0.351716734
    i = i + 1: t(i) = 5000: X(i) = 0.346695514: Y(i) = 0.35150052
    i = i + 1: t(i) = 5010: X(i) = 0.346403565: Y(i) = 0.351284841
    i = i + 1: t(i) = 5020: X(i) = 0.346112859: Y(i) = 0.351069696
    i = i + 1: t(i) = 5030: X(i) = 0.34582339: Y(i) = 0.350855085
    i = i + 1: t(i) = 5040: X(i) = 0.34553515: Y(i) = 0.350641009
    i = i + 1: t(i) = 5050: X(i) = 0.345248134: Y(i) = 0.350427466
    i = i + 1: t(i) = 5060: X(i) = 0.344962335: Y(i) = 0.350214456
    i = i + 1: t(i) = 5070: X(i) = 0.344677746: Y(i) = 0.35000198
    i = i + 1: t(i) = 5080: X(i) = 0.34439436: Y(i) = 0.349790037
    i = i + 1: t(i) = 5090: X(i) = 0.344112173: Y(i) = 0.349578626
    i = i + 1: t(i) = 5100: X(i) = 0.343831176: Y(i) = 0.349367746
    i = i + 1: t(i) = 5110: X(i) = 0.343551364: Y(i) = 0.349157399
    i = i + 1: t(i) = 5120: X(i) = 0.343272731: Y(i) = 0.348947582
    i = i + 1: t(i) = 5130: X(i) = 0.342995271: Y(i) = 0.348738296
    i = i + 1: t(i) = 5140: X(i) = 0.342718976: Y(i) = 0.34852954
    i = i + 1: t(i) = 5150: X(i) = 0.342443841: Y(i) = 0.348321314
    i = i + 1: t(i) = 5160: X(i) = 0.34216986: Y(i) = 0.348113616
    i = i + 1: t(i) = 5170: X(i) = 0.341897027: Y(i) = 0.347906448
    i = i + 1: t(i) = 5180: X(i) = 0.341625335: Y(i) = 0.347699807
    i = i + 1: t(i) = 5190: X(i) = 0.341354779: Y(i) = 0.347493694
    i = i + 1: t(i) = 5200: X(i) = 0.341085353: Y(i) = 0.347288107
    i = i + 1: t(i) = 5210: X(i) = 0.34081705: Y(i) = 0.347083047
    i = i + 1: t(i) = 5220: X(i) = 0.340549865: Y(i) = 0.346878512
    i = i + 1: t(i) = 5230: X(i) = 0.340283792: Y(i) = 0.346674502
    i = i + 1: t(i) = 5240: X(i) = 0.340018824: Y(i) = 0.346471017
    i = i + 1: t(i) = 5250: X(i) = 0.339754957: Y(i) = 0.346268055
    i = i + 1: t(i) = 5260: X(i) = 0.339492184: Y(i) = 0.346065616
    i = i + 1: t(i) = 5270: X(i) = 0.3392305: Y(i) = 0.3458637
    i = i + 1: t(i) = 5280: X(i) = 0.338969899: Y(i) = 0.345662305
    i = i + 1: t(i) = 5290: X(i) = 0.338710375: Y(i) = 0.345461431
    i = i + 1: t(i) = 5300: X(i) = 0.338451922: Y(i) = 0.345261076
    i = i + 1: t(i) = 5310: X(i) = 0.338194535: Y(i) = 0.345061242
    i = i + 1: t(i) = 5320: X(i) = 0.337938209: Y(i) = 0.344861926
    i = i + 1: t(i) = 5330: X(i) = 0.337682937: Y(i) = 0.344663127
    i = i + 1: t(i) = 5340: X(i) = 0.337428715: Y(i) = 0.344464846
    i = i + 1: t(i) = 5350: X(i) = 0.337175537: Y(i) = 0.344267081
    i = i + 1: t(i) = 5360: X(i) = 0.336923396: Y(i) = 0.344069832
    i = i + 1: t(i) = 5370: X(i) = 0.336672289: Y(i) = 0.343873097
    i = i + 1: t(i) = 5380: X(i) = 0.336422209: Y(i) = 0.343676875
    i = i + 1: t(i) = 5390: X(i) = 0.336173151: Y(i) = 0.343481167
    i = i + 1: t(i) = 5400: X(i) = 0.33592511: Y(i) = 0.343285971
    i = i + 1: t(i) = 5410: X(i) = 0.335678081: Y(i) = 0.343091286
    i = i + 1: t(i) = 5420: X(i) = 0.335432058: Y(i) = 0.342897111
    i = i + 1: t(i) = 5430: X(i) = 0.335187036: Y(i) = 0.342703446
    i = i + 1: t(i) = 5440: X(i) = 0.334943009: Y(i) = 0.342510289
    i = i + 1: t(i) = 5450: X(i) = 0.334699974: Y(i) = 0.34231764
    i = i + 1: t(i) = 5460: X(i) = 0.334457923: Y(i) = 0.342125498
    i = i + 1: t(i) = 5470: X(i) = 0.334216853: Y(i) = 0.341933862
    i = i + 1: t(i) = 5480: X(i) = 0.333976759: Y(i) = 0.34174273
    i = i + 1: t(i) = 5490: X(i) = 0.333737634: Y(i) = 0.341552103
    i = i + 1: t(i) = 5500: X(i) = 0.333499475: Y(i) = 0.341361978
    i = i + 1: t(i) = 5510: X(i) = 0.333262276: Y(i) = 0.341172355
    i = i + 1: t(i) = 5520: X(i) = 0.333026032: Y(i) = 0.340983234
    i = i + 1: t(i) = 5530: X(i) = 0.332790739: Y(i) = 0.340794613
    i = i + 1: t(i) = 5540: X(i) = 0.332556391: Y(i) = 0.34060649
    i = i + 1: t(i) = 5550: X(i) = 0.332322983: Y(i) = 0.340418866
    i = i + 1: t(i) = 5560: X(i) = 0.332090511: Y(i) = 0.340231739
    i = i + 1: t(i) = 5570: X(i) = 0.33185897: Y(i) = 0.340045108
    i = i + 1: t(i) = 5580: X(i) = 0.331628355: Y(i) = 0.339858973
    i = i + 1: t(i) = 5590: X(i) = 0.331398662: Y(i) = 0.339673331
    i = i + 1: t(i) = 5600: X(i) = 0.331169885: Y(i) = 0.339488183
    i = i + 1: t(i) = 5610: X(i) = 0.330942019: Y(i) = 0.339303526
    i = i + 1: t(i) = 5620: X(i) = 0.330715061: Y(i) = 0.339119361
    i = i + 1: t(i) = 5630: X(i) = 0.330489006: Y(i) = 0.338935686
    i = i + 1: t(i) = 5640: X(i) = 0.330263848: Y(i) = 0.338752499
    i = i + 1: t(i) = 5650: X(i) = 0.330039583: Y(i) = 0.338569801
    i = i + 1: t(i) = 5660: X(i) = 0.329816208: Y(i) = 0.338387589
    i = i + 1: t(i) = 5670: X(i) = 0.329593716: Y(i) = 0.338205863
    i = i + 1: t(i) = 5680: X(i) = 0.329372104: Y(i) = 0.338024622
    i = i + 1: t(i) = 5690: X(i) = 0.329151368: Y(i) = 0.337843864
    i = i + 1: t(i) = 5700: X(i) = 0.328931502: Y(i) = 0.337663589
    i = i + 1: t(i) = 5710: X(i) = 0.328712502: Y(i) = 0.337483796
    i = i + 1: t(i) = 5720: X(i) = 0.328494364: Y(i) = 0.337304482
    i = i + 1: t(i) = 5730: X(i) = 0.328277084: Y(i) = 0.337125648
    i = i + 1: t(i) = 5740: X(i) = 0.328060657: Y(i) = 0.336947293
    i = i + 1: t(i) = 5750: X(i) = 0.327845078: Y(i) = 0.336769414
    i = i + 1: t(i) = 5760: X(i) = 0.327630344: Y(i) = 0.336592012
    i = i + 1: t(i) = 5770: X(i) = 0.32741645: Y(i) = 0.336415084
    i = i + 1: t(i) = 5780: X(i) = 0.327203392: Y(i) = 0.33623863
    i = i + 1: t(i) = 5790: X(i) = 0.326991166: Y(i) = 0.336062649
    i = i + 1: t(i) = 5800: X(i) = 0.326779767: Y(i) = 0.335887139
    i = i + 1: t(i) = 5810: X(i) = 0.326569192: Y(i) = 0.3357121
    i = i + 1: t(i) = 5820: X(i) = 0.326359435: Y(i) = 0.33553753
    i = i + 1: t(i) = 5830: X(i) = 0.326150494: Y(i) = 0.335363428
    i = i + 1: t(i) = 5840: X(i) = 0.325942363: Y(i) = 0.335189793
    i = i + 1: t(i) = 5850: X(i) = 0.32573504: Y(i) = 0.335016624
    i = i + 1: t(i) = 5860: X(i) = 0.325528519: Y(i) = 0.33484392
    i = i + 1: t(i) = 5870: X(i) = 0.325322797: Y(i) = 0.334671679
    i = i + 1: t(i) = 5880: X(i) = 0.325117869: Y(i) = 0.334499901
    i = i + 1: t(i) = 5890: X(i) = 0.324913732: Y(i) = 0.334328585
    i = i + 1: t(i) = 5900: X(i) = 0.324710382: Y(i) = 0.334157728
    i = i + 1: t(i) = 5910: X(i) = 0.324507815: Y(i) = 0.333987331
    i = i + 1: t(i) = 5920: X(i) = 0.324306026: Y(i) = 0.333817391
    i = i + 1: t(i) = 5930: X(i) = 0.324105013: Y(i) = 0.333647908
    i = i + 1: t(i) = 5940: X(i) = 0.32390477: Y(i) = 0.333478881
    i = i + 1: t(i) = 5950: X(i) = 0.323705295: Y(i) = 0.333310308
    i = i + 1: t(i) = 5960: X(i) = 0.323506583: Y(i) = 0.333142188
    i = i + 1: t(i) = 5970: X(i) = 0.32330863: Y(i) = 0.332974521
    i = i + 1: t(i) = 5980: X(i) = 0.323111434: Y(i) = 0.332807304
    i = i + 1: t(i) = 5990: X(i) = 0.322914989: Y(i) = 0.332640537
    i = i + 1: t(i) = 6000: X(i) = 0.322719293: Y(i) = 0.332474219
    i = i + 1: t(i) = 6010: X(i) = 0.322524342: Y(i) = 0.332308348
    i = i + 1: t(i) = 6020: X(i) = 0.322330131: Y(i) = 0.332142923
    i = i + 1: t(i) = 6030: X(i) = 0.322136657: Y(i) = 0.331977944
    i = i + 1: t(i) = 6040: X(i) = 0.321943917: Y(i) = 0.331813408
    i = i + 1: t(i) = 6050: X(i) = 0.321751907: Y(i) = 0.331649315
    i = i + 1: t(i) = 6060: X(i) = 0.321560623: Y(i) = 0.331485664
    i = i + 1: t(i) = 6070: X(i) = 0.321370062: Y(i) = 0.331322453
    i = i + 1: t(i) = 6080: X(i) = 0.32118022: Y(i) = 0.331159682
    i = i + 1: t(i) = 6090: X(i) = 0.320991093: Y(i) = 0.330997348
    i = i + 1: t(i) = 6100: X(i) = 0.320802678: Y(i) = 0.330835452
    i = i + 1: t(i) = 6110: X(i) = 0.320614972: Y(i) = 0.330673991
    i = i + 1: t(i) = 6120: X(i) = 0.320427971: Y(i) = 0.330512964
    i = i + 1: t(i) = 6130: X(i) = 0.320241672: Y(i) = 0.330352371
    i = i + 1: t(i) = 6140: X(i) = 0.320056071: Y(i) = 0.33019221
    i = i + 1: t(i) = 6150: X(i) = 0.319871164: Y(i) = 0.33003248
    i = i + 1: t(i) = 6160: X(i) = 0.319686949: Y(i) = 0.32987318
    i = i + 1: t(i) = 6170: X(i) = 0.319503421: Y(i) = 0.329714309
    i = i + 1: t(i) = 6180: X(i) = 0.319320578: Y(i) = 0.329555865
    i = i + 1: t(i) = 6190: X(i) = 0.319138416: Y(i) = 0.329397847
    i = i + 1: t(i) = 6200: X(i) = 0.318956932: Y(i) = 0.329240255
    i = i + 1: t(i) = 6210: X(i) = 0.318776123: Y(i) = 0.329083086
    i = i + 1: t(i) = 6220: X(i) = 0.318595985: Y(i) = 0.32892634
    i = i + 1: t(i) = 6230: X(i) = 0.318416514: Y(i) = 0.328770016
    i = i + 1: t(i) = 6240: X(i) = 0.318237709: Y(i) = 0.328614112
    i = i + 1: t(i) = 6250: X(i) = 0.318059565: Y(i) = 0.328458628
    i = i + 1: t(i) = 6260: X(i) = 0.317882079: Y(i) = 0.328303561
    i = i + 1: t(i) = 6270: X(i) = 0.317705248: Y(i) = 0.328148912
    i = i + 1: t(i) = 6280: X(i) = 0.317529069: Y(i) = 0.327994678
    i = i + 1: t(i) = 6290: X(i) = 0.317353538: Y(i) = 0.327840859
    i = i + 1: t(i) = 6300: X(i) = 0.317178654: Y(i) = 0.327687453
    i = i + 1: t(i) = 6310: X(i) = 0.317004411: Y(i) = 0.327534459
    i = i + 1: t(i) = 6320: X(i) = 0.316830808: Y(i) = 0.327381876
    i = i + 1: t(i) = 6330: X(i) = 0.316657841: Y(i) = 0.327229703
    i = i + 1: t(i) = 6340: X(i) = 0.316485508: Y(i) = 0.327077939
    i = i + 1: t(i) = 6350: X(i) = 0.316313804: Y(i) = 0.326926583
    i = i + 1: t(i) = 6360: X(i) = 0.316142728: Y(i) = 0.326775632
    i = i + 1: t(i) = 6370: X(i) = 0.315972275: Y(i) = 0.326625087
    i = i + 1: t(i) = 6380: X(i) = 0.315802444: Y(i) = 0.326474946
    i = i + 1: t(i) = 6390: X(i) = 0.31563323: Y(i) = 0.326325208
    i = i + 1: t(i) = 6400: X(i) = 0.315464632: Y(i) = 0.326175871
    i = i + 1: t(i) = 6410: X(i) = 0.315296645: Y(i) = 0.326026935
    i = i + 1: t(i) = 6420: X(i) = 0.315129268: Y(i) = 0.325878399
    i = i + 1: t(i) = 6430: X(i) = 0.314962498: Y(i) = 0.325730261
    i = i + 1: t(i) = 6440: X(i) = 0.31479633: Y(i) = 0.325582519
    i = i + 1: t(i) = 6450: X(i) = 0.314630763: Y(i) = 0.325435174
    i = i + 1: t(i) = 6460: X(i) = 0.314465794: Y(i) = 0.325288223
    i = i + 1: t(i) = 6470: X(i) = 0.314301419: Y(i) = 0.325141666
    i = i + 1: t(i) = 6480: X(i) = 0.314137637: Y(i) = 0.324995502
    i = i + 1: t(i) = 6490: X(i) = 0.313974443: Y(i) = 0.324849728
    i = i + 1: t(i) = 6500: X(i) = 0.313811836: Y(i) = 0.324704345
    i = i + 1: t(i) = 6510: X(i) = 0.313649812: Y(i) = 0.324559351
    i = i + 1: t(i) = 6520: X(i) = 0.313488369: Y(i) = 0.324414745
    i = i + 1: t(i) = 6530: X(i) = 0.313327504: Y(i) = 0.324270525
    i = i + 1: t(i) = 6540: X(i) = 0.313167215: Y(i) = 0.324126691
    i = i + 1: t(i) = 6550: X(i) = 0.313007497: Y(i) = 0.323983241
    i = i + 1: t(i) = 6560: X(i) = 0.31284835: Y(i) = 0.323840175
    i = i + 1: t(i) = 6570: X(i) = 0.31268977: Y(i) = 0.323697491
    i = i + 1: t(i) = 6580: X(i) = 0.312531754: Y(i) = 0.323555188
    i = i + 1: t(i) = 6590: X(i) = 0.3123743: Y(i) = 0.323413264
    i = i + 1: t(i) = 6600: X(i) = 0.312217405: Y(i) = 0.32327172
    i = i + 1: t(i) = 6610: X(i) = 0.312061066: Y(i) = 0.323130553
    i = i + 1: t(i) = 6620: X(i) = 0.311905281: Y(i) = 0.322989763
    i = i + 1: t(i) = 6630: X(i) = 0.311750048: Y(i) = 0.322849348
    i = i + 1: t(i) = 6640: X(i) = 0.311595363: Y(i) = 0.322709307
    i = i + 1: t(i) = 6650: X(i) = 0.311441225: Y(i) = 0.322569639
    i = i + 1: t(i) = 6660: X(i) = 0.31128763: Y(i) = 0.322430344
    i = i + 1: t(i) = 6670: X(i) = 0.311134576: Y(i) = 0.322291419
    i = i + 1: t(i) = 6680: X(i) = 0.31098206: Y(i) = 0.322152864
    i = i + 1: t(i) = 6690: X(i) = 0.31083008: Y(i) = 0.322014677
    i = i + 1: t(i) = 6700: X(i) = 0.310678634: Y(i) = 0.321876859
    i = i + 1: t(i) = 6710: X(i) = 0.310527719: Y(i) = 0.321739406
    i = i + 1: t(i) = 6720: X(i) = 0.310377332: Y(i) = 0.321602319
    i = i + 1: t(i) = 6730: X(i) = 0.310227471: Y(i) = 0.321465596
    i = i + 1: t(i) = 6740: X(i) = 0.310078134: Y(i) = 0.321329237
    i = i + 1: t(i) = 6750: X(i) = 0.309929317: Y(i) = 0.321193239
    i = i + 1: t(i) = 6760: X(i) = 0.30978102: Y(i) = 0.321057602
    i = i + 1: t(i) = 6770: X(i) = 0.309633239: Y(i) = 0.320922325
    i = i + 1: t(i) = 6780: X(i) = 0.309485971: Y(i) = 0.320787407
    i = i + 1: t(i) = 6790: X(i) = 0.309339216: Y(i) = 0.320652846
    i = i + 1: t(i) = 6800: X(i) = 0.309192969: Y(i) = 0.320518642
    i = i + 1: t(i) = 6810: X(i) = 0.309047229: Y(i) = 0.320384794
    i = i + 1: t(i) = 6820: X(i) = 0.308901994: Y(i) = 0.320251299
    i = i + 1: t(i) = 6830: X(i) = 0.308757261: Y(i) = 0.320118158
    i = i + 1: t(i) = 6840: X(i) = 0.308613027: Y(i) = 0.31998537
    i = i + 1: t(i) = 6850: X(i) = 0.308469291: Y(i) = 0.319852932
    i = i + 1: t(i) = 6860: X(i) = 0.30832605: Y(i) = 0.319720845
    i = i + 1: t(i) = 6870: X(i) = 0.308183303: Y(i) = 0.319589106
    i = i + 1: t(i) = 6880: X(i) = 0.308041046: Y(i) = 0.319457716
    i = i + 1: t(i) = 6890: X(i) = 0.307899277: Y(i) = 0.319326672
    i = i + 1: t(i) = 6900: X(i) = 0.307757994: Y(i) = 0.319195974
    i = i + 1: t(i) = 6910: X(i) = 0.307617196: Y(i) = 0.319065621
    i = i + 1: t(i) = 6920: X(i) = 0.307476879: Y(i) = 0.318935611
    i = i + 1: t(i) = 6930: X(i) = 0.307337042: Y(i) = 0.318805944
    i = i + 1: t(i) = 6940: X(i) = 0.307197682: Y(i) = 0.318676618
    i = i + 1: t(i) = 6950: X(i) = 0.307058797: Y(i) = 0.318547633
    i = i + 1: t(i) = 6960: X(i) = 0.306920386: Y(i) = 0.318418988
    i = i + 1: t(i) = 6970: X(i) = 0.306782445: Y(i) = 0.318290681
    i = i + 1: t(i) = 6980: X(i) = 0.306644973: Y(i) = 0.318162711
    i = i + 1: t(i) = 6990: X(i) = 0.306507967: Y(i) = 0.318035078
    i = i + 1: t(i) = 7000: X(i) = 0.306371426: Y(i) = 0.317907779
    i = i + 1: t(i) = 7010: X(i) = 0.306235347: Y(i) = 0.317780815
    i = i + 1: t(i) = 7020: X(i) = 0.306099729: Y(i) = 0.317654185
    i = i + 1: t(i) = 7030: X(i) = 0.305964569: Y(i) = 0.317527886
    i = i + 1: t(i) = 7040: X(i) = 0.305829864: Y(i) = 0.317401919
    i = i + 1: t(i) = 7050: X(i) = 0.305695614: Y(i) = 0.317276281
    i = i + 1: t(i) = 7060: X(i) = 0.305561816: Y(i) = 0.317150973
    i = i + 1: t(i) = 7070: X(i) = 0.305428468: Y(i) = 0.317025993
    i = i + 1: t(i) = 7080: X(i) = 0.305295568: Y(i) = 0.316901339
    i = i + 1: t(i) = 7090: X(i) = 0.305163113: Y(i) = 0.316777012
    i = i + 1: t(i) = 7100: X(i) = 0.305031103: Y(i) = 0.31665301
    i = i + 1: t(i) = 7110: X(i) = 0.304899534: Y(i) = 0.316529332
    i = i + 1: t(i) = 7120: X(i) = 0.304768406: Y(i) = 0.316405977
    i = i + 1: t(i) = 7130: X(i) = 0.304637715: Y(i) = 0.316282943
    i = i + 1: t(i) = 7140: X(i) = 0.30450746: Y(i) = 0.316160231
    i = i + 1: t(i) = 7150: X(i) = 0.30437764: Y(i) = 0.316037839
    i = i + 1: t(i) = 7160: X(i) = 0.304248251: Y(i) = 0.315915766
    i = i + 1: t(i) = 7170: X(i) = 0.304119293: Y(i) = 0.31579401
    i = i + 1: t(i) = 7180: X(i) = 0.303990762: Y(i) = 0.315672572
    i = i + 1: t(i) = 7190: X(i) = 0.303862659: Y(i) = 0.31555145
    i = i + 1: t(i) = 7200: X(i) = 0.303734979: Y(i) = 0.315430642
    i = i + 1: t(i) = 7210: X(i) = 0.303607722: Y(i) = 0.315310149
    i = i + 1: t(i) = 7220: X(i) = 0.303480886: Y(i) = 0.315189969
    i = i + 1: t(i) = 7230: X(i) = 0.303354469: Y(i) = 0.315070101
    i = i + 1: t(i) = 7240: X(i) = 0.303228468: Y(i) = 0.314950543
    i = i + 1: t(i) = 7250: X(i) = 0.303102883: Y(i) = 0.314831296
    i = i + 1: t(i) = 7260: X(i) = 0.302977711: Y(i) = 0.314712359
    i = i + 1: t(i) = 7270: X(i) = 0.30285295: Y(i) = 0.314593729
    i = i + 1: t(i) = 7280: X(i) = 0.302728599: Y(i) = 0.314475407
    i = i + 1: t(i) = 7290: X(i) = 0.302604656: Y(i) = 0.31435739
    i = i + 1: t(i) = 7300: X(i) = 0.302481118: Y(i) = 0.314239679
    i = i + 1: t(i) = 7310: X(i) = 0.302357985: Y(i) = 0.314122273
    i = i + 1: t(i) = 7320: X(i) = 0.302235255: Y(i) = 0.31400517
    i = i + 1: t(i) = 7330: X(i) = 0.302112925: Y(i) = 0.313888369
    i = i + 1: t(i) = 7340: X(i) = 0.301990993: Y(i) = 0.31377187
    i = i + 1: t(i) = 7350: X(i) = 0.301869459: Y(i) = 0.313655671
    i = i + 1: t(i) = 7360: X(i) = 0.301748321: Y(i) = 0.313539772
    i = i + 1: t(i) = 7370: X(i) = 0.301627576: Y(i) = 0.313424171
    i = i + 1: t(i) = 7380: X(i) = 0.301507223: Y(i) = 0.313308868
    i = i + 1: t(i) = 7390: X(i) = 0.30138726: Y(i) = 0.313193862
    i = i + 1: t(i) = 7400: X(i) = 0.301267686: Y(i) = 0.313079152
    i = i + 1: t(i) = 7410: X(i) = 0.301148498: Y(i) = 0.312964737
    i = i + 1: t(i) = 7420: X(i) = 0.301029696: Y(i) = 0.312850615
    i = i + 1: t(i) = 7430: X(i) = 0.300911277: Y(i) = 0.312736787
    i = i + 1: t(i) = 7440: X(i) = 0.30079324: Y(i) = 0.312623251
    i = i + 1: t(i) = 7450: X(i) = 0.300675583: Y(i) = 0.312510006
    i = i + 1: t(i) = 7460: X(i) = 0.300558305: Y(i) = 0.312397051
    i = i + 1: t(i) = 7470: X(i) = 0.300441403: Y(i) = 0.312284386
    i = i + 1: t(i) = 7480: X(i) = 0.300324877: Y(i) = 0.312172009
    i = i + 1: t(i) = 7490: X(i) = 0.300208724: Y(i) = 0.31205992
    i = i + 1: t(i) = 7500: X(i) = 0.300092943: Y(i) = 0.311948118
    i = i + 1: t(i) = 7510: X(i) = 0.299977533: Y(i) = 0.311836601
    i = i + 1: t(i) = 7520: X(i) = 0.299862491: Y(i) = 0.311725369
    i = i + 1: t(i) = 7530: X(i) = 0.299747816: Y(i) = 0.311614421
    i = i + 1: t(i) = 7540: X(i) = 0.299633507: Y(i) = 0.311503756
    i = i + 1: t(i) = 7550: X(i) = 0.299519562: Y(i) = 0.311393373
    i = i + 1: t(i) = 7560: X(i) = 0.299405979: Y(i) = 0.311283272
    i = i + 1: t(i) = 7570: X(i) = 0.299292758: Y(i) = 0.311173451
    i = i + 1: t(i) = 7580: X(i) = 0.299179895: Y(i) = 0.311063909
    i = i + 1: t(i) = 7590: X(i) = 0.299067391: Y(i) = 0.310954647
    i = i + 1: t(i) = 7600: X(i) = 0.298955242: Y(i) = 0.310845661
    i = i + 1: t(i) = 7610: X(i) = 0.298843448: Y(i) = 0.310736953
    i = i + 1: t(i) = 7620: X(i) = 0.298732008: Y(i) = 0.310628521
    i = i + 1: t(i) = 7630: X(i) = 0.298620919: Y(i) = 0.310520364
    i = i + 1: t(i) = 7640: X(i) = 0.298510181: Y(i) = 0.310412481
    i = i + 1: t(i) = 7650: X(i) = 0.298399791: Y(i) = 0.310304872
    i = i + 1: t(i) = 7660: X(i) = 0.298289748: Y(i) = 0.310197535
    i = i + 1: t(i) = 7670: X(i) = 0.298180051: Y(i) = 0.31009047
    i = i + 1: t(i) = 7680: X(i) = 0.298070698: Y(i) = 0.309983676
    i = i + 1: t(i) = 7690: X(i) = 0.297961688: Y(i) = 0.309877151
    i = i + 1: t(i) = 7700: X(i) = 0.29785302: Y(i) = 0.309770896
    i = i + 1: t(i) = 7710: X(i) = 0.297744691: Y(i) = 0.309664909
    i = i + 1: t(i) = 7720: X(i) = 0.297636701: Y(i) = 0.30955919
    i = i + 1: t(i) = 7730: X(i) = 0.297529047: Y(i) = 0.309453737
    i = i + 1: t(i) = 7740: X(i) = 0.29742173: Y(i) = 0.30934855
    i = i + 1: t(i) = 7750: X(i) = 0.297314746: Y(i) = 0.309243628
    i = i + 1: t(i) = 7760: X(i) = 0.297208096: Y(i) = 0.309138969
    i = i + 1: t(i) = 7770: X(i) = 0.297101776: Y(i) = 0.309034575
    i = i + 1: t(i) = 7780: X(i) = 0.296995787: Y(i) = 0.308930442
    i = i + 1: t(i) = 7790: X(i) = 0.296890126: Y(i) = 0.308826571
    i = i + 1: t(i) = 7800: X(i) = 0.296784793: Y(i) = 0.308722961
    i = i + 1: t(i) = 7810: X(i) = 0.296679785: Y(i) = 0.308619611
    i = i + 1: t(i) = 7820: X(i) = 0.296575101: Y(i) = 0.30851652
    i = i + 1: t(i) = 7830: X(i) = 0.296470741: Y(i) = 0.308413687
    i = i + 1: t(i) = 7840: X(i) = 0.296366703: Y(i) = 0.308311112
    i = i + 1: t(i) = 7850: X(i) = 0.296262984: Y(i) = 0.308208794
    i = i + 1: t(i) = 7860: X(i) = 0.296159585: Y(i) = 0.308106731
    i = i + 1: t(i) = 7870: X(i) = 0.296056504: Y(i) = 0.308004923
    i = i + 1: t(i) = 7880: X(i) = 0.295953739: Y(i) = 0.30790337
    i = i + 1: t(i) = 7890: X(i) = 0.295851289: Y(i) = 0.30780207
    i = i + 1: t(i) = 7900: X(i) = 0.295749153: Y(i) = 0.307701023
    i = i + 1: t(i) = 7910: X(i) = 0.295647329: Y(i) = 0.307600228
    i = i + 1: t(i) = 7920: X(i) = 0.295545817: Y(i) = 0.307499684
    i = i + 1: t(i) = 7930: X(i) = 0.295444614: Y(i) = 0.30739939
    i = i + 1: t(i) = 7940: X(i) = 0.29534372: Y(i) = 0.307299346
    i = i + 1: t(i) = 7950: X(i) = 0.295243133: Y(i) = 0.30719955
    i = i + 1: t(i) = 7960: X(i) = 0.295142852: Y(i) = 0.307100002
    i = i + 1: t(i) = 7970: X(i) = 0.295042876: Y(i) = 0.307000702
    i = i + 1: t(i) = 7980: X(i) = 0.294943203: Y(i) = 0.306901648
    i = i + 1: t(i) = 7990: X(i) = 0.294843833: Y(i) = 0.306802839
    i = i + 1: t(i) = 8000: X(i) = 0.294744764: Y(i) = 0.306704275
    i = i + 1: t(i) = 8010: X(i) = 0.294645994: Y(i) = 0.306605956
    i = i + 1: t(i) = 8020: X(i) = 0.294547523: Y(i) = 0.306507879
    i = i + 1: t(i) = 8030: X(i) = 0.294449349: Y(i) = 0.306410045
    i = i + 1: t(i) = 8040: X(i) = 0.294351472: Y(i) = 0.306312453
    i = i + 1: t(i) = 8050: X(i) = 0.294253889: Y(i) = 0.306215102
    i = i + 1: t(i) = 8060: X(i) = 0.2941566: Y(i) = 0.306117992
    i = i + 1: t(i) = 8070: X(i) = 0.294059603: Y(i) = 0.30602112
    i = i + 1: t(i) = 8080: X(i) = 0.293962897: Y(i) = 0.305924488
    i = i + 1: t(i) = 8090: X(i) = 0.293866482: Y(i) = 0.305828093
    i = i + 1: t(i) = 8100: X(i) = 0.293770355: Y(i) = 0.305731936
    i = i + 1: t(i) = 8110: X(i) = 0.293674516: Y(i) = 0.305636015
    i = i + 1: t(i) = 8120: X(i) = 0.293578964: Y(i) = 0.305540331
    i = i + 1: t(i) = 8130: X(i) = 0.293483697: Y(i) = 0.305444881
    i = i + 1: t(i) = 8140: X(i) = 0.293388714: Y(i) = 0.305349665
    i = i + 1: t(i) = 8150: X(i) = 0.293294014: Y(i) = 0.305254683
    i = i + 1: t(i) = 8160: X(i) = 0.293199596: Y(i) = 0.305159934
    i = i + 1: t(i) = 8170: X(i) = 0.293105459: Y(i) = 0.305065417
    i = i + 1: t(i) = 8180: X(i) = 0.293011601: Y(i) = 0.304971131
    i = i + 1: t(i) = 8190: X(i) = 0.292918022: Y(i) = 0.304877076
    i = i + 1: t(i) = 8200: X(i) = 0.29282472: Y(i) = 0.30478325
    i = i + 1: t(i) = 8210: X(i) = 0.292731694: Y(i) = 0.304689654
    i = i + 1: t(i) = 8220: X(i) = 0.292638944: Y(i) = 0.304596287
    i = i + 1: t(i) = 8230: X(i) = 0.292546467: Y(i) = 0.304503147
    i = i + 1: t(i) = 8240: X(i) = 0.292454263: Y(i) = 0.304410235
    i = i + 1: t(i) = 8250: X(i) = 0.292362331: Y(i) = 0.304317548
    i = i + 1: t(i) = 8260: X(i) = 0.29227067: Y(i) = 0.304225088
    i = i + 1: t(i) = 8270: X(i) = 0.292179278: Y(i) = 0.304132852
    i = i + 1: t(i) = 8280: X(i) = 0.292088155: Y(i) = 0.30404084
    i = i + 1: t(i) = 8290: X(i) = 0.291997299: Y(i) = 0.303949052
    i = i + 1: t(i) = 8300: X(i) = 0.29190671: Y(i) = 0.303857487
    i = i + 1: t(i) = 8310: X(i) = 0.291816386: Y(i) = 0.303766144
    i = i + 1: t(i) = 8320: X(i) = 0.291726326: Y(i) = 0.303675023
    i = i + 1: t(i) = 8330: X(i) = 0.29163653: Y(i) = 0.303584122
    i = i + 1: t(i) = 8340: X(i) = 0.291546995: Y(i) = 0.303493441
    i = i + 1: t(i) = 8350: X(i) = 0.291457722: Y(i) = 0.30340298
    i = i + 1: t(i) = 8360: X(i) = 0.291368708: Y(i) = 0.303312737
    i = i + 1: t(i) = 8370: X(i) = 0.291279954: Y(i) = 0.303222713
    i = i + 1: t(i) = 8380: X(i) = 0.291191457: Y(i) = 0.303132906
    i = i + 1: t(i) = 8390: X(i) = 0.291103218: Y(i) = 0.303043315
    i = i + 1: t(i) = 8400: X(i) = 0.291015234: Y(i) = 0.30295394
    i = i + 1: t(i) = 8410: X(i) = 0.290927506: Y(i) = 0.302864781
    i = i + 1: t(i) = 8420: X(i) = 0.290840031: Y(i) = 0.302775836
    i = i + 1: t(i) = 8430: X(i) = 0.290752809: Y(i) = 0.302687106
    i = i + 1: t(i) = 8440: X(i) = 0.290665839: Y(i) = 0.302598588
    i = i + 1: t(i) = 8450: X(i) = 0.29057912: Y(i) = 0.302510284
    i = i + 1: t(i) = 8460: X(i) = 0.290492651: Y(i) = 0.302422191
    i = i + 1: t(i) = 8470: X(i) = 0.29040643: Y(i) = 0.302334309
    i = i + 1: t(i) = 8480: X(i) = 0.290320458: Y(i) = 0.302246639
    i = i + 1: t(i) = 8490: X(i) = 0.290234733: Y(i) = 0.302159178
    i = i + 1: t(i) = 8500: X(i) = 0.290149253: Y(i) = 0.302071927
    i = i + 1: t(i) = 8510: X(i) = 0.290064019: Y(i) = 0.301984884
    i = i + 1: t(i) = 8520: X(i) = 0.289979029: Y(i) = 0.301898049
    i = i + 1: t(i) = 8530: X(i) = 0.289894282: Y(i) = 0.301811422
    i = i + 1: t(i) = 8540: X(i) = 0.289809776: Y(i) = 0.301725002
    i = i + 1: t(i) = 8550: X(i) = 0.289725513: Y(i) = 0.301638788
    i = i + 1: t(i) = 8560: X(i) = 0.289641489: Y(i) = 0.301552779
    i = i + 1: t(i) = 8570: X(i) = 0.289557705: Y(i) = 0.301466975
    i = i + 1: t(i) = 8580: X(i) = 0.289474159: Y(i) = 0.301381376
    i = i + 1: t(i) = 8590: X(i) = 0.28939085: Y(i) = 0.30129598
    i = i + 1: t(i) = 8600: X(i) = 0.289307778: Y(i) = 0.301210787
    i = i + 1: t(i) = 8610: X(i) = 0.289224942: Y(i) = 0.301125796
    i = i + 1: t(i) = 8620: X(i) = 0.289142341: Y(i) = 0.301041007
    i = i + 1: t(i) = 8630: X(i) = 0.289059973: Y(i) = 0.300956419
    i = i + 1: t(i) = 8640: X(i) = 0.288977838: Y(i) = 0.300872032
    i = i + 1: t(i) = 8650: X(i) = 0.288895935: Y(i) = 0.300787844
    i = i + 1: t(i) = 8660: X(i) = 0.288814263: Y(i) = 0.300703856
    i = i + 1: t(i) = 8670: X(i) = 0.288732821: Y(i) = 0.300620066
    i = i + 1: t(i) = 8680: X(i) = 0.288651608: Y(i) = 0.300536474
    i = i + 1: t(i) = 8690: X(i) = 0.288570624: Y(i) = 0.30045308
    i = i + 1: t(i) = 8700: X(i) = 0.288489868: Y(i) = 0.300369882
    i = i + 1: t(i) = 8710: X(i) = 0.288409338: Y(i) = 0.300286881
    i = i + 1: t(i) = 8720: X(i) = 0.288329033: Y(i) = 0.300204075
    i = i + 1: t(i) = 8730: X(i) = 0.288248954: Y(i) = 0.300121465
    i = i + 1: t(i) = 8740: X(i) = 0.288169099: Y(i) = 0.300039048
    i = i + 1: t(i) = 8750: X(i) = 0.288089467: Y(i) = 0.299956826
    i = i + 1: t(i) = 8760: X(i) = 0.288010057: Y(i) = 0.299874796
    i = i + 1: t(i) = 8770: X(i) = 0.287930868: Y(i) = 0.299792959
    i = i + 1: t(i) = 8780: X(i) = 0.287851901: Y(i) = 0.299711315
    i = i + 1: t(i) = 8790: X(i) = 0.287773153: Y(i) = 0.299629861
    i = i + 1: t(i) = 8800: X(i) = 0.287694623: Y(i) = 0.299548599
    i = i + 1: t(i) = 8810: X(i) = 0.287616312: Y(i) = 0.299467526
    i = i + 1: t(i) = 8820: X(i) = 0.287538219: Y(i) = 0.299386644
    i = i + 1: t(i) = 8830: X(i) = 0.287460341: Y(i) = 0.29930595
    i = i + 1: t(i) = 8840: X(i) = 0.287382679: Y(i) = 0.299225445
    i = i + 1: t(i) = 8850: X(i) = 0.287305232: Y(i) = 0.299145128
    i = i + 1: t(i) = 8860: X(i) = 0.287227999: Y(i) = 0.299064998
    i = i + 1: t(i) = 8870: X(i) = 0.28715098: Y(i) = 0.298985055
    i = i + 1: t(i) = 8880: X(i) = 0.287074172: Y(i) = 0.298905298
    i = i + 1: t(i) = 8890: X(i) = 0.286997576: Y(i) = 0.298825727
    i = i + 1: t(i) = 8900: X(i) = 0.286921191: Y(i) = 0.29874634
    i = i + 1: t(i) = 8910: X(i) = 0.286845015: Y(i) = 0.298667139
    i = i + 1: t(i) = 8920: X(i) = 0.286769049: Y(i) = 0.298588121
    i = i + 1: t(i) = 8930: X(i) = 0.286693291: Y(i) = 0.298509287
    i = i + 1: t(i) = 8940: X(i) = 0.286617741: Y(i) = 0.298430635
    i = i + 1: t(i) = 8950: X(i) = 0.286542397: Y(i) = 0.298352166
    i = i + 1: t(i) = 8960: X(i) = 0.286467259: Y(i) = 0.298273878
    i = i + 1: t(i) = 8970: X(i) = 0.286392327: Y(i) = 0.298195771
    i = i + 1: t(i) = 8980: X(i) = 0.286317599: Y(i) = 0.298117845
    i = i + 1: t(i) = 8990: X(i) = 0.286243075: Y(i) = 0.2980401
    i = i + 1: t(i) = 9000: X(i) = 0.286168753: Y(i) = 0.297962533
    i = i + 1: t(i) = 9010: X(i) = 0.286094634: Y(i) = 0.297885146
    i = i + 1: t(i) = 9020: X(i) = 0.286020716: Y(i) = 0.297807937
    i = i + 1: t(i) = 9030: X(i) = 0.285946999: Y(i) = 0.297730906
    i = i + 1: t(i) = 9040: X(i) = 0.285873482: Y(i) = 0.297654052
    i = i + 1: t(i) = 9050: X(i) = 0.285800164: Y(i) = 0.297577375
    i = i + 1: t(i) = 9060: X(i) = 0.285727044: Y(i) = 0.297500874
    i = i + 1: t(i) = 9070: X(i) = 0.285654122: Y(i) = 0.297424549
    i = i + 1: t(i) = 9080: X(i) = 0.285581397: Y(i) = 0.297348399
    i = i + 1: t(i) = 9090: X(i) = 0.285508868: Y(i) = 0.297272423
    i = i + 1: t(i) = 9100: X(i) = 0.285436534: Y(i) = 0.297196622
    i = i + 1: t(i) = 9110: X(i) = 0.285364395: Y(i) = 0.297120995
    i = i + 1: t(i) = 9120: X(i) = 0.285292451: Y(i) = 0.29704554
    i = i + 1: t(i) = 9130: X(i) = 0.285220699: Y(i) = 0.296970258
    i = i + 1: t(i) = 9140: X(i) = 0.28514914: Y(i) = 0.296895148
    i = i + 1: t(i) = 9150: X(i) = 0.285077773: Y(i) = 0.29682021
    i = i + 1: t(i) = 9160: X(i) = 0.285006597: Y(i) = 0.296745442
    i = i + 1: t(i) = 9170: X(i) = 0.284935611: Y(i) = 0.296670845
    i = i + 1: t(i) = 9180: X(i) = 0.284864816: Y(i) = 0.296596418
    i = i + 1: t(i) = 9190: X(i) = 0.284794209: Y(i) = 0.29652216
    i = i + 1: t(i) = 9200: X(i) = 0.28472379: Y(i) = 0.296448072
    i = i + 1: t(i) = 9210: X(i) = 0.28465356: Y(i) = 0.296374151
    i = i + 1: t(i) = 9220: X(i) = 0.284583516: Y(i) = 0.296300399
    i = i + 1: t(i) = 9230: X(i) = 0.284513658: Y(i) = 0.296226814
    i = i + 1: t(i) = 9240: X(i) = 0.284443986: Y(i) = 0.296153396
    i = i + 1: t(i) = 9250: X(i) = 0.284374499: Y(i) = 0.296080144
    i = i + 1: t(i) = 9260: X(i) = 0.284305196: Y(i) = 0.296007059
    i = i + 1: t(i) = 9270: X(i) = 0.284236077: Y(i) = 0.295934138
    i = i + 1: t(i) = 9280: X(i) = 0.28416714: Y(i) = 0.295861383
    i = i + 1: t(i) = 9290: X(i) = 0.284098386: Y(i) = 0.295788792
    i = i + 1: t(i) = 9300: X(i) = 0.284029813: Y(i) = 0.295716364
    i = i + 1: t(i) = 9310: X(i) = 0.283961421: Y(i) = 0.295644101
    i = i + 1: t(i) = 9320: X(i) = 0.28389321: Y(i) = 0.295572
    i = i + 1: t(i) = 9330: X(i) = 0.283825178: Y(i) = 0.295500062
    i = i + 1: t(i) = 9340: X(i) = 0.283757324: Y(i) = 0.295428285
    i = i + 1: t(i) = 9350: X(i) = 0.283689649: Y(i) = 0.29535667
    i = i + 1: t(i) = 9360: X(i) = 0.283622152: Y(i) = 0.295285216
    i = i + 1: t(i) = 9370: X(i) = 0.283554832: Y(i) = 0.295213923
    i = i + 1: t(i) = 9380: X(i) = 0.283487688: Y(i) = 0.295142789
    i = i + 1: t(i) = 9390: X(i) = 0.283420719: Y(i) = 0.295071816
    i = i + 1: t(i) = 9400: X(i) = 0.283353926: Y(i) = 0.295001001
    i = i + 1: t(i) = 9410: X(i) = 0.283287307: Y(i) = 0.294930345
    i = i + 1: t(i) = 9420: X(i) = 0.283220862: Y(i) = 0.294859847
    i = i + 1: t(i) = 9430: X(i) = 0.28315459: Y(i) = 0.294789506
    i = i + 1: t(i) = 9440: X(i) = 0.28308849: Y(i) = 0.294719323
    i = i + 1: t(i) = 9450: X(i) = 0.283022563: Y(i) = 0.294649296
    i = i + 1: t(i) = 9460: X(i) = 0.282956807: Y(i) = 0.294579426
    i = i + 1: t(i) = 9470: X(i) = 0.282891221: Y(i) = 0.294509712
    i = i + 1: t(i) = 9480: X(i) = 0.282825806: Y(i) = 0.294440153
    i = i + 1: t(i) = 9490: X(i) = 0.282760559: Y(i) = 0.294370748
    i = i + 1: t(i) = 9500: X(i) = 0.282695482: Y(i) = 0.294301498
    i = i + 1: t(i) = 9510: X(i) = 0.282630573: Y(i) = 0.294232402
    i = i + 1: t(i) = 9520: X(i) = 0.282565832: Y(i) = 0.29416346
    i = i + 1: t(i) = 9530: X(i) = 0.282501257: Y(i) = 0.29409467
    i = i + 1: t(i) = 9540: X(i) = 0.282436849: Y(i) = 0.294026034
    i = i + 1: t(i) = 9550: X(i) = 0.282372607: Y(i) = 0.293957549
    i = i + 1: t(i) = 9560: X(i) = 0.28230853: Y(i) = 0.293889216
    i = i + 1: t(i) = 9570: X(i) = 0.282244618: Y(i) = 0.293821034
    i = i + 1: t(i) = 9580: X(i) = 0.28218087: Y(i) = 0.293753003
    i = i + 1: t(i) = 9590: X(i) = 0.282117286: Y(i) = 0.293685122
    i = i + 1: t(i) = 9600: X(i) = 0.282053864: Y(i) = 0.293617391
    i = i + 1: t(i) = 9610: X(i) = 0.281990604: Y(i) = 0.29354981
    i = i + 1: t(i) = 9620: X(i) = 0.281927507: Y(i) = 0.293482377
    i = i + 1: t(i) = 9630: X(i) = 0.28186457: Y(i) = 0.293415093
    i = i + 1: t(i) = 9640: X(i) = 0.281801794: Y(i) = 0.293347958
    i = i + 1: t(i) = 9650: X(i) = 0.281739179: Y(i) = 0.29328097
    i = i + 1: t(i) = 9660: X(i) = 0.281676722: Y(i) = 0.293214129
    i = i + 1: t(i) = 9670: X(i) = 0.281614425: Y(i) = 0.293147435
    i = i + 1: t(i) = 9680: X(i) = 0.281552286: Y(i) = 0.293080887
    i = i + 1: t(i) = 9690: X(i) = 0.281490304: Y(i) = 0.293014486
    i = i + 1: t(i) = 9700: X(i) = 0.28142848: Y(i) = 0.29294823
    i = i + 1: t(i) = 9710: X(i) = 0.281366813: Y(i) = 0.292882118
    i = i + 1: t(i) = 9720: X(i) = 0.281305301: Y(i) = 0.292816152
    i = i + 1: t(i) = 9730: X(i) = 0.281243946: Y(i) = 0.29275033
    i = i + 1: t(i) = 9740: X(i) = 0.281182745: Y(i) = 0.292684652
    i = i + 1: t(i) = 9750: X(i) = 0.281121699: Y(i) = 0.292619117
    i = i + 1: t(i) = 9760: X(i) = 0.281060806: Y(i) = 0.292553725
    i = i + 1: t(i) = 9770: X(i) = 0.281000068: Y(i) = 0.292488476
    i = i + 1: t(i) = 9780: X(i) = 0.280939482: Y(i) = 0.292423368
    i = i + 1: t(i) = 9790: X(i) = 0.280879048: Y(i) = 0.292358403
    i = i + 1: t(i) = 9800: X(i) = 0.280818766: Y(i) = 0.292293579
    i = i + 1: t(i) = 9810: X(i) = 0.280758635: Y(i) = 0.292228895
    i = i + 1: t(i) = 9820: X(i) = 0.280698656: Y(i) = 0.292164353
    i = i + 1: t(i) = 9830: X(i) = 0.280638826: Y(i) = 0.29209995
    i = i + 1: t(i) = 9840: X(i) = 0.280579146: Y(i) = 0.292035687
    i = i + 1: t(i) = 9850: X(i) = 0.280519615: Y(i) = 0.291971563
    i = i + 1: t(i) = 9860: X(i) = 0.280460233: Y(i) = 0.291907578
    i = i + 1: t(i) = 9870: X(i) = 0.280400999: Y(i) = 0.291843732
    i = i + 1: t(i) = 9880: X(i) = 0.280341913: Y(i) = 0.291780023
    i = i + 1: t(i) = 9890: X(i) = 0.280282974: Y(i) = 0.291716453
    i = i + 1: t(i) = 9900: X(i) = 0.280224181: Y(i) = 0.291653019
    i = i + 1: t(i) = 9910: X(i) = 0.280165535: Y(i) = 0.291589723
    i = i + 1: t(i) = 9920: X(i) = 0.280107034: Y(i) = 0.291526562
    i = i + 1: t(i) = 9930: X(i) = 0.280048678: Y(i) = 0.291463538
    i = i + 1: t(i) = 9940: X(i) = 0.279990467: Y(i) = 0.29140065
    i = i + 1: t(i) = 9950: X(i) = 0.279932399: Y(i) = 0.291337896
    i = i + 1: t(i) = 9960: X(i) = 0.279874476: Y(i) = 0.291275278
    i = i + 1: t(i) = 9970: X(i) = 0.279816695: Y(i) = 0.291212794
    i = i + 1: t(i) = 9980: X(i) = 0.279759058: Y(i) = 0.291150444
    i = i + 1: t(i) = 9990: X(i) = 0.279701562: Y(i) = 0.291088228
    i = i + 1: t(i) = 10000: X(i) = 0.279644208: Y(i) = 0.291026146

    
    loadCCTxyTable1964 = i
    
End Function

Private Function loadCMF1931(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double
    
    i = i + 0: L(i) = 360: X(i) = 0.00013: Y(i) = 0.000004: Z(i) = 0.000606
    i = i + 1: L(i) = 365: X(i) = 0.000232: Y(i) = 0.000007: Z(i) = 0.001086
    i = i + 1: L(i) = 370: X(i) = 0.000415: Y(i) = 0.000012: Z(i) = 0.001946
    i = i + 1: L(i) = 375: X(i) = 0.000742: Y(i) = 0.000022: Z(i) = 0.003486
    i = i + 1: L(i) = 380: X(i) = 0.001368: Y(i) = 0.000039: Z(i) = 0.00645
    i = i + 1: L(i) = 385: X(i) = 0.002236: Y(i) = 0.000064: Z(i) = 0.01055
    i = i + 1: L(i) = 390: X(i) = 0.004243: Y(i) = 0.00012: Z(i) = 0.02005
    i = i + 1: L(i) = 395: X(i) = 0.00765: Y(i) = 0.000217: Z(i) = 0.03621
    i = i + 1: L(i) = 400: X(i) = 0.01431: Y(i) = 0.000396: Z(i) = 0.06785
    i = i + 1: L(i) = 405: X(i) = 0.02319: Y(i) = 0.00064: Z(i) = 0.1102
    i = i + 1: L(i) = 410: X(i) = 0.04351: Y(i) = 0.00121: Z(i) = 0.2074
    i = i + 1: L(i) = 415: X(i) = 0.07763: Y(i) = 0.00218: Z(i) = 0.3713
    i = i + 1: L(i) = 420: X(i) = 0.13438: Y(i) = 0.004: Z(i) = 0.6456
    i = i + 1: L(i) = 425: X(i) = 0.21477: Y(i) = 0.0073: Z(i) = 1.03905
    i = i + 1: L(i) = 430: X(i) = 0.2839: Y(i) = 0.0116: Z(i) = 1.3856
    i = i + 1: L(i) = 435: X(i) = 0.3285: Y(i) = 0.01684: Z(i) = 1.62296
    i = i + 1: L(i) = 440: X(i) = 0.34828: Y(i) = 0.023: Z(i) = 1.74706
    i = i + 1: L(i) = 445: X(i) = 0.34806: Y(i) = 0.0298: Z(i) = 1.7826
    i = i + 1: L(i) = 450: X(i) = 0.3362: Y(i) = 0.038: Z(i) = 1.77211
    i = i + 1: L(i) = 455: X(i) = 0.3187: Y(i) = 0.048: Z(i) = 1.7441
    i = i + 1: L(i) = 460: X(i) = 0.2908: Y(i) = 0.06: Z(i) = 1.6692
    i = i + 1: L(i) = 465: X(i) = 0.2511: Y(i) = 0.0739: Z(i) = 1.5281
    i = i + 1: L(i) = 470: X(i) = 0.19536: Y(i) = 0.09098: Z(i) = 1.28764
    i = i + 1: L(i) = 475: X(i) = 0.1421: Y(i) = 0.1126: Z(i) = 1.0419
    i = i + 1: L(i) = 480: X(i) = 0.09564: Y(i) = 0.13902: Z(i) = 0.81295
    i = i + 1: L(i) = 485: X(i) = 0.05795: Y(i) = 0.1693: Z(i) = 0.6162
    i = i + 1: L(i) = 490: X(i) = 0.03201: Y(i) = 0.20802: Z(i) = 0.46518
    i = i + 1: L(i) = 495: X(i) = 0.0147: Y(i) = 0.2586: Z(i) = 0.3533
    i = i + 1: L(i) = 500: X(i) = 0.0049: Y(i) = 0.323: Z(i) = 0.272
    i = i + 1: L(i) = 505: X(i) = 0.0024: Y(i) = 0.4073: Z(i) = 0.2123
    i = i + 1: L(i) = 510: X(i) = 0.0093: Y(i) = 0.503: Z(i) = 0.1582
    i = i + 1: L(i) = 515: X(i) = 0.0291: Y(i) = 0.6082: Z(i) = 0.1117
    i = i + 1: L(i) = 520: X(i) = 0.06327: Y(i) = 0.71: Z(i) = 0.07825
    i = i + 1: L(i) = 525: X(i) = 0.1096: Y(i) = 0.7932: Z(i) = 0.05725
    i = i + 1: L(i) = 530: X(i) = 0.1655: Y(i) = 0.862: Z(i) = 0.04216
    i = i + 1: L(i) = 535: X(i) = 0.22575: Y(i) = 0.91485: Z(i) = 0.02984
    i = i + 1: L(i) = 540: X(i) = 0.2904: Y(i) = 0.954: Z(i) = 0.0203
    i = i + 1: L(i) = 545: X(i) = 0.3597: Y(i) = 0.9803: Z(i) = 0.0134
    i = i + 1: L(i) = 550: X(i) = 0.43345: Y(i) = 0.99495: Z(i) = 0.00875
    i = i + 1: L(i) = 555: X(i) = 0.51205: Y(i) = 1#: Z(i) = 0.00575
    i = i + 1: L(i) = 560: X(i) = 0.5945: Y(i) = 0.995: Z(i) = 0.0039
    i = i + 1: L(i) = 565: X(i) = 0.6784: Y(i) = 0.9786: Z(i) = 0.00275
    i = i + 1: L(i) = 570: X(i) = 0.7621: Y(i) = 0.952: Z(i) = 0.0021
    i = i + 1: L(i) = 575: X(i) = 0.8425: Y(i) = 0.9154: Z(i) = 0.0018
    i = i + 1: L(i) = 580: X(i) = 0.9163: Y(i) = 0.87: Z(i) = 0.00165
    i = i + 1: L(i) = 585: X(i) = 0.9786: Y(i) = 0.8163: Z(i) = 0.0014
    i = i + 1: L(i) = 590: X(i) = 1.0263: Y(i) = 0.757: Z(i) = 0.0011
    i = i + 1: L(i) = 595: X(i) = 1.0567: Y(i) = 0.6949: Z(i) = 0.001
    i = i + 1: L(i) = 600: X(i) = 1.0622: Y(i) = 0.631: Z(i) = 0.0008
    i = i + 1: L(i) = 605: X(i) = 1.0456: Y(i) = 0.5668: Z(i) = 0.0006
    i = i + 1: L(i) = 610: X(i) = 1.0026: Y(i) = 0.503: Z(i) = 0.00034
    i = i + 1: L(i) = 615: X(i) = 0.9384: Y(i) = 0.4412: Z(i) = 0.00024
    i = i + 1: L(i) = 620: X(i) = 0.85445: Y(i) = 0.381: Z(i) = 0.00019
    i = i + 1: L(i) = 625: X(i) = 0.7514: Y(i) = 0.321: Z(i) = 0.0001
    i = i + 1: L(i) = 630: X(i) = 0.6424: Y(i) = 0.265: Z(i) = 0.00005
    i = i + 1: L(i) = 635: X(i) = 0.5419: Y(i) = 0.217: Z(i) = 0.00003
    i = i + 1: L(i) = 640: X(i) = 0.4479: Y(i) = 0.175: Z(i) = 0.00002
    i = i + 1: L(i) = 645: X(i) = 0.3608: Y(i) = 0.1382: Z(i) = 0.00001
    i = i + 1: L(i) = 650: X(i) = 0.2835: Y(i) = 0.107: Z(i) = 0#
    i = i + 1: L(i) = 655: X(i) = 0.2187: Y(i) = 0.0816: Z(i) = 0#
    i = i + 1: L(i) = 660: X(i) = 0.1649: Y(i) = 0.061: Z(i) = 0#
    i = i + 1: L(i) = 665: X(i) = 0.1212: Y(i) = 0.04458: Z(i) = 0#
    i = i + 1: L(i) = 670: X(i) = 0.0874: Y(i) = 0.032: Z(i) = 0#
    i = i + 1: L(i) = 675: X(i) = 0.0636: Y(i) = 0.0232: Z(i) = 0#
    i = i + 1: L(i) = 680: X(i) = 0.04677: Y(i) = 0.017: Z(i) = 0#
    i = i + 1: L(i) = 685: X(i) = 0.0329: Y(i) = 0.01192: Z(i) = 0#
    i = i + 1: L(i) = 690: X(i) = 0.0227: Y(i) = 0.00821: Z(i) = 0#
    i = i + 1: L(i) = 695: X(i) = 0.01584: Y(i) = 0.005723: Z(i) = 0#
    i = i + 1: L(i) = 700: X(i) = 0.011359: Y(i) = 0.004102: Z(i) = 0#
    i = i + 1: L(i) = 705: X(i) = 0.008111: Y(i) = 0.002929: Z(i) = 0#
    i = i + 1: L(i) = 710: X(i) = 0.00579: Y(i) = 0.002091: Z(i) = 0#
    i = i + 1: L(i) = 715: X(i) = 0.004109: Y(i) = 0.001484: Z(i) = 0#
    i = i + 1: L(i) = 720: X(i) = 0.002899: Y(i) = 0.001047: Z(i) = 0#
    i = i + 1: L(i) = 725: X(i) = 0.002049: Y(i) = 0.00074: Z(i) = 0#
    i = i + 1: L(i) = 730: X(i) = 0.00144: Y(i) = 0.00052: Z(i) = 0#
    i = i + 1: L(i) = 735: X(i) = 0.001: Y(i) = 0.000361: Z(i) = 0#
    i = i + 1: L(i) = 740: X(i) = 0.00069: Y(i) = 0.000249: Z(i) = 0#
    i = i + 1: L(i) = 745: X(i) = 0.000476: Y(i) = 0.000172: Z(i) = 0#
    i = i + 1: L(i) = 750: X(i) = 0.000332: Y(i) = 0.00012: Z(i) = 0#
    i = i + 1: L(i) = 755: X(i) = 0.000235: Y(i) = 0.000085: Z(i) = 0#
    i = i + 1: L(i) = 760: X(i) = 0.000166: Y(i) = 0.00006: Z(i) = 0#
    i = i + 1: L(i) = 765: X(i) = 0.000117: Y(i) = 0.000042: Z(i) = 0#
    i = i + 1: L(i) = 770: X(i) = 0.000083: Y(i) = 0.00003: Z(i) = 0#
    i = i + 1: L(i) = 775: X(i) = 0.000059: Y(i) = 0.000021: Z(i) = 0#
    i = i + 1: L(i) = 780: X(i) = 0.000042: Y(i) = 0.000015: Z(i) = 0#
    i = i + 1: L(i) = 785: X(i) = 0.000029: Y(i) = 0.000011: Z(i) = 0#
    i = i + 1: L(i) = 790: X(i) = 0.000021: Y(i) = 0.000007: Z(i) = 0#
    i = i + 1: L(i) = 795: X(i) = 0.000015: Y(i) = 0.000005: Z(i) = 0#
    i = i + 1: L(i) = 800: X(i) = 0.00001: Y(i) = 0.000004: Z(i) = 0#
    i = i + 1: L(i) = 805: X(i) = 0.000007: Y(i) = 0.000003: Z(i) = 0#
    i = i + 1: L(i) = 810: X(i) = 0.000005: Y(i) = 0.000002: Z(i) = 0#
    i = i + 1: L(i) = 815: X(i) = 0.000004: Y(i) = 0.000001: Z(i) = 0#
    i = i + 1: L(i) = 820: X(i) = 0.000003: Y(i) = 0.000001: Z(i) = 0#
    i = i + 1: L(i) = 825: X(i) = 0.000002: Y(i) = 0.000001: Z(i) = 0#
    i = i + 1: L(i) = 830: X(i) = 0.000001: Y(i) = 0#: Z(i) = 0#
    
    loadCMF1931 = i
    
End Function

Private Function loadCMF1964(X() As Double, Y() As Double, Z() As Double) As Integer
    Dim i As Integer: i = 0
    Dim L(94) As Double
    
    i = i + 0: L(i) = 360: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 365: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 370: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 375: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 380: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 385: X(i) = 0#: Y(i) = 0#: Z(i) = 0#
    i = i + 1: L(i) = 390: X(i) = 0.00295: Y(i) = 0.000408: Z(i) = 0.0132
    i = i + 1: L(i) = 395: X(i) = 0.00764: Y(i) = 0.00108: Z(i) = 0.0342
    i = i + 1: L(i) = 400: X(i) = 0.0188: Y(i) = 0.00259: Z(i) = 0.0851
    i = i + 1: L(i) = 405: X(i) = 0.042: Y(i) = 0.00547: Z(i) = 0.193
    i = i + 1: L(i) = 410: X(i) = 0.0828: Y(i) = 0.0104: Z(i) = 0.383
    i = i + 1: L(i) = 415: X(i) = 0.14: Y(i) = 0.0171: Z(i) = 0.657
    i = i + 1: L(i) = 420: X(i) = 0.208: Y(i) = 0.0258: Z(i) = 0.993
    i = i + 1: L(i) = 425: X(i) = 0.269: Y(i) = 0.0353: Z(i) = 1.31
    i = i + 1: L(i) = 430: X(i) = 0.328: Y(i) = 0.047: Z(i) = 1.62
    i = i + 1: L(i) = 435: X(i) = 0.369: Y(i) = 0.0605: Z(i) = 1.87
    i = i + 1: L(i) = 440: X(i) = 0.403: Y(i) = 0.0747: Z(i) = 2.08
    i = i + 1: L(i) = 445: X(i) = 0.404: Y(i) = 0.0882: Z(i) = 2.13
    i = i + 1: L(i) = 450: X(i) = 0.393: Y(i) = 0.104: Z(i) = 2.13
    i = i + 1: L(i) = 455: X(i) = 0.348: Y(i) = 0.12: Z(i) = 1.95
    i = i + 1: L(i) = 460: X(i) = 0.301: Y(i) = 0.141: Z(i) = 1.77
    i = i + 1: L(i) = 465: X(i) = 0.253: Y(i) = 0.17: Z(i) = 1.58
    i = i + 1: L(i) = 470: X(i) = 0.191: Y(i) = 0.2: Z(i) = 1.31
    i = i + 1: L(i) = 475: X(i) = 0.128: Y(i) = 0.231: Z(i) = 1.01
    i = i + 1: L(i) = 480: X(i) = 0.0759: Y(i) = 0.268: Z(i) = 0.752
    i = i + 1: L(i) = 485: X(i) = 0.0384: Y(i) = 0.311: Z(i) = 0.555
    i = i + 1: L(i) = 490: X(i) = 0.014: Y(i) = 0.355: Z(i) = 0.398
    i = i + 1: L(i) = 495: X(i) = 0.00345: Y(i) = 0.415: Z(i) = 0.291
    i = i + 1: L(i) = 500: X(i) = 0.00565: Y(i) = 0.478: Z(i) = 0.208
    i = i + 1: L(i) = 505: X(i) = 0.0156: Y(i) = 0.549: Z(i) = 0.139
    i = i + 1: L(i) = 510: X(i) = 0.0378: Y(i) = 0.625: Z(i) = 0.0885
    i = i + 1: L(i) = 515: X(i) = 0.0754: Y(i) = 0.701: Z(i) = 0.0582
    i = i + 1: L(i) = 520: X(i) = 0.12: Y(i) = 0.779: Z(i) = 0.0378
    i = i + 1: L(i) = 525: X(i) = 0.176: Y(i) = 0.838: Z(i) = 0.0243
    i = i + 1: L(i) = 530: X(i) = 0.238: Y(i) = 0.883: Z(i) = 0.0154
    i = i + 1: L(i) = 535: X(i) = 0.305: Y(i) = 0.923: Z(i) = 0.00975
    i = i + 1: L(i) = 540: X(i) = 0.384: Y(i) = 0.967: Z(i) = 0.00608
    i = i + 1: L(i) = 545: X(i) = 0.463: Y(i) = 0.989: Z(i) = 0.00377
    i = i + 1: L(i) = 550: X(i) = 0.537: Y(i) = 0.991: Z(i) = 0.00232
    i = i + 1: L(i) = 555: X(i) = 0.623: Y(i) = 1#: Z(i) = 0.00143
    i = i + 1: L(i) = 560: X(i) = 0.712: Y(i) = 0.994: Z(i) = 0.000878
    i = i + 1: L(i) = 565: X(i) = 0.802: Y(i) = 0.985: Z(i) = 0.000541
    i = i + 1: L(i) = 570: X(i) = 0.893: Y(i) = 0.964: Z(i) = 0.000334
    i = i + 1: L(i) = 575: X(i) = 0.972: Y(i) = 0.929: Z(i) = 0.000208
    i = i + 1: L(i) = 580: X(i) = 1.03: Y(i) = 0.878: Z(i) = 0.00013
    i = i + 1: L(i) = 585: X(i) = 1.11: Y(i) = 0.837: Z(i) = 0.0000818
    i = i + 1: L(i) = 590: X(i) = 1.15: Y(i) = 0.787: Z(i) = 0.0000521
    i = i + 1: L(i) = 595: X(i) = 1.16: Y(i) = 0.727: Z(i) = 0.0000335
    i = i + 1: L(i) = 600: X(i) = 1.15: Y(i) = 0.663: Z(i) = 0.0000218
    i = i + 1: L(i) = 605: X(i) = 1.11: Y(i) = 0.597: Z(i) = 0.0000143
    i = i + 1: L(i) = 610: X(i) = 1.05: Y(i) = 0.528: Z(i) = 0.00000953
    i = i + 1: L(i) = 615: X(i) = 0.962: Y(i) = 0.46: Z(i) = 0.00000643
    i = i + 1: L(i) = 620: X(i) = 0.863: Y(i) = 0.395: Z(i) = 0#
    i = i + 1: L(i) = 625: X(i) = 0.76: Y(i) = 0.335: Z(i) = 0#
    i = i + 1: L(i) = 630: X(i) = 0.641: Y(i) = 0.275: Z(i) = 0#
    i = i + 1: L(i) = 635: X(i) = 0.529: Y(i) = 0.222: Z(i) = 0#
    i = i + 1: L(i) = 640: X(i) = 0.432: Y(i) = 0.178: Z(i) = 0#
    i = i + 1: L(i) = 645: X(i) = 0.35: Y(i) = 0.141: Z(i) = 0#
    i = i + 1: L(i) = 650: X(i) = 0.271: Y(i) = 0.108: Z(i) = 0#
    i = i + 1: L(i) = 655: X(i) = 0.206: Y(i) = 0.0814: Z(i) = 0#
    i = i + 1: L(i) = 660: X(i) = 0.154: Y(i) = 0.0603: Z(i) = 0#
    i = i + 1: L(i) = 665: X(i) = 0.114: Y(i) = 0.0443: Z(i) = 0#
    i = i + 1: L(i) = 670: X(i) = 0.0828: Y(i) = 0.0321: Z(i) = 0#
    i = i + 1: L(i) = 675: X(i) = 0.0595: Y(i) = 0.023: Z(i) = 0#
    i = i + 1: L(i) = 680: X(i) = 0.0422: Y(i) = 0.0163: Z(i) = 0#
    i = i + 1: L(i) = 685: X(i) = 0.0295: Y(i) = 0.0114: Z(i) = 0#
    i = i + 1: L(i) = 690: X(i) = 0.0203: Y(i) = 0.0078: Z(i) = 0#
    i = i + 1: L(i) = 695: X(i) = 0.0141: Y(i) = 0.00543: Z(i) = 0#
    i = i + 1: L(i) = 700: X(i) = 0.00982: Y(i) = 0.00378: Z(i) = 0#
    i = i + 1: L(i) = 705: X(i) = 0.00681: Y(i) = 0.00262: Z(i) = 0#
    i = i + 1: L(i) = 710: X(i) = 0.00467: Y(i) = 0.0018: Z(i) = 0#
    i = i + 1: L(i) = 715: X(i) = 0.00319: Y(i) = 0.00123: Z(i) = 0#
    i = i + 1: L(i) = 720: X(i) = 0.00221: Y(i) = 0.00085: Z(i) = 0#
    i = i + 1: L(i) = 725: X(i) = 0.00152: Y(i) = 0.000588: Z(i) = 0#
    i = i + 1: L(i) = 730: X(i) = 0.00106: Y(i) = 0.00041: Z(i) = 0#
    i = i + 1: L(i) = 735: X(i) = 0.00074: Y(i) = 0.000286: Z(i) = 0#
    i = i + 1: L(i) = 740: X(i) = 0.000515: Y(i) = 0.000199: Z(i) = 0#
    i = i + 1: L(i) = 745: X(i) = 0.000363: Y(i) = 0.000141: Z(i) = 0#
    i = i + 1: L(i) = 750: X(i) = 0.000256: Y(i) = 0.0000993: Z(i) = 0#
    i = i + 1: L(i) = 755: X(i) = 0.000181: Y(i) = 0.0000704: Z(i) = 0#
    i = i + 1: L(i) = 760: X(i) = 0.000129: Y(i) = 0.0000502: Z(i) = 0#
    i = i + 1: L(i) = 765: X(i) = 0.0000917: Y(i) = 0.0000358: Z(i) = 0#
    i = i + 1: L(i) = 770: X(i) = 0.0000658: Y(i) = 0.0000257: Z(i) = 0#
    i = i + 1: L(i) = 775: X(i) = 0.0000471: Y(i) = 0.0000185: Z(i) = 0#
    i = i + 1: L(i) = 780: X(i) = 0.0000341: Y(i) = 0.0000134: Z(i) = 0#
    i = i + 1: L(i) = 785: X(i) = 0.0000247: Y(i) = 0.00000972: Z(i) = 0#
    i = i + 1: L(i) = 790: X(i) = 0.0000179: Y(i) = 0.00000707: Z(i) = 0#
    i = i + 1: L(i) = 795: X(i) = 0.0000131: Y(i) = 0.00000516: Z(i) = 0#
    i = i + 1: L(i) = 800: X(i) = 0.00000957: Y(i) = 0.00000379: Z(i) = 0#
    i = i + 1: L(i) = 805: X(i) = 0.00000704: Y(i) = 0.00000279: Z(i) = 0#
    i = i + 1: L(i) = 810: X(i) = 0.00000517: Y(i) = 0.00000206: Z(i) = 0#
    i = i + 1: L(i) = 815: X(i) = 0.00000382: Y(i) = 0.00000152: Z(i) = 0#
    i = i + 1: L(i) = 820: X(i) = 0.00000284: Y(i) = 0.00000114: Z(i) = 0#
    i = i + 1: L(i) = 825: X(i) = 0.00000211: Y(i) = 0.000000848: Z(i) = 0#
    i = i + 1: L(i) = 830: X(i) = 0.00000158: Y(i) = 0.000000635: Z(i) = 0#
    
    loadCMF1964 = i
    
End Function

Public Function getPlanckianLocusX(t As Integer) As Double
    'http://en.wikipedia.org/wiki/Planckian_locus#Approximation
    Const c0 As Double = -0.2661239
    Const c1 As Double = -0.234358
    Const c2 As Double = 0.8776956
    Const c3 As Double = 0.17991
    Const c10 As Double = -3.0258469
    Const c11 As Double = 2.1070379
    Const c12 As Double = 0.2226347
    Const c13 As Double = 0.24039
    
    If t < 4000 Then
        getPlanckianLocusX = c0 * (1000 / t) ^ 3 + c1 * (1000 / t) ^ 2 + c2 * (1000 / t) ^ 1 + c3
    Else
        getPlanckianLocusX = c10 * (1000 / t) ^ 3 + c11 * (1000 / t) ^ 2 + c12 * (1000 / t) ^ 1 + c13
    End If
End Function

Public Function getPlanckianLocusY(t As Integer) As Double
    'http://en.wikipedia.org/wiki/Planckian_locus#Approximation
    Const c0 As Double = -1.1063814
    Const c1 As Double = -1.3481102
    Const c2 As Double = 2.18555832
    Const c3 As Double = -0.20219683
    Const c10 As Double = -0.9549476
    Const c11 As Double = -1.37418593
    Const c12 As Double = 2.09137015
    Const c13 As Double = -0.16748867
    Const c20 As Double = 3.081758
    Const c21 As Double = -5.8733867
    Const c22 As Double = 3.75112997
    Const c23 As Double = -0.37001483
    
    Dim X As Double: X = getPlanckianLocusX(t)
    
    If t < 2222 Then
        getPlanckianLocusY = c0 * X ^ 3 + c1 * X ^ 2 + c2 * X ^ 1 + c3
    Else
        If t < 4000 Then
            getPlanckianLocusY = c10 * X ^ 3 + c11 * X ^ 2 + c12 * X ^ 1 + c13
        Else
            getPlanckianLocusY = c20 * X ^ 3 + c21 * X ^ 2 + c22 * X ^ 1 + c23
        End If
    End If
End Function





