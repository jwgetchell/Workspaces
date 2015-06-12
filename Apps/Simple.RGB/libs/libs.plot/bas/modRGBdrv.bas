Attribute VB_Name = "modRGBdrv"
Option Explicit

'
' This file contains example RGB functions
'
'   Public
'       getXYfromRGB        returns either x or y from built in or passed constants
'       getUVfromXY         returns either u or v
'       getCCTfromXY        returns either CCT or Duv
'       getLux              returns lux using built in or passed constants
'
'   Private
'       getPlanckianLocus   returns either x or y Planckian locus coordinates (CIE 1931)
'

Type calValues
    comp(4) As Integer
    sysGain(4) As Single ' 5 ranges
    ranges(4) As Single
    CCM(4, 2, 3) As Single ' page,x,y
End Type

Enum eTransforms
    off
    xy
    XYZ
    BOTH
End Enum

Dim xyCoeffLoaded As Boolean, evCoeffLoaded As Boolean, xyzCoeffLoaded As Boolean
Dim XYZc As calValues

Dim transformEnable As eTransforms

Public Sub setTransform(ByVal transform As eTransforms)
    transformEnable = transform
End Sub

Public Function getXYZfromRGB(ByVal R As Double, ByVal G As Double, ByVal B As Double, _
                              ByVal XYZ As Integer, Optional ByVal range As Integer = 0) As Double
                            
    If Not xyzCoeffLoaded Then loadXYZcoeff XYZc
    
    If range < 0 Then
        range = 0
    Else
        If range > 2 Then
            range = 2
        End If
    End If
    
    getXYZfromRGB = XYZc.sysGain(range) * XYZc.ranges(range) * _
                   (XYZc.CCM(range, XYZ, 0) * R + XYZc.CCM(range, XYZ, 1) * G + XYZc.CCM(range, XYZ, 2) * B)
                   
    If getXYZfromRGB < 0 Then getXYZfromRGB = 0
    
End Function

Public Function getXYfromRGB(ByVal R As Double, ByVal G As Double, ByVal B As Double, _
                             ByVal XorY As Integer, Optional xc As range, Optional yc As range) _
                             As Double
    '
    'R:    Red measured from detector
    'G:    Green measured from detector
    'B:    Blue measured from detector
    '   NOTE:   R, G & B values must be in the same unit, though the actual unit is not important
    '           since the X & Y values are unitless, based on a ratio
    '
    'XorY: return value select
    '       XorY=0:  return X value
    '       XorY<>0: return Y value
    '
    
    On Error Resume Next
    
    Static c(1, 2) As Double: If Not xyCoeffLoaded Then loadXYcoeff c
    If Not xyzCoeffLoaded Then loadXYZcoeff XYZc
    
    Dim x As Double, y As Double, d As Double
    Dim XX As Double, YY As Double, ZZ As Double
    
    If transformEnable = BOTH Or transformEnable = XYZ Then
    
        XX = getXYZfromRGB(R, G, B, 0)
        YY = getXYZfromRGB(R, G, B, 1)
        ZZ = getXYZfromRGB(R, G, B, 2)
        
        R = XX: G = YY: B = ZZ
    
    End If
    
    d = (R + G + B)
    
    If d <> 0 Then
        x = R / d: y = G / d
    Else
        x = 0: y = 0
    End If
    
    On Error GoTo useFixedConstants
    
    ' use Range data, xc & yc
    
    Dim s As Integer
    s = UBound(xc.Value2): If s <> 3 Then GoTo useFixedConstants
    s = UBound(yc.Value2): If s <> 3 Then GoTo useFixedConstants
    
        If XorY Then
            getXYfromRGB = yc.Value2(1, 1) * x + yc.Value2(2, 1) * y + yc.Value2(3, 1)
        Else
            getXYfromRGB = xc.Value2(1, 1) * x + xc.Value2(2, 1) * y + xc.Value2(3, 1)
        End If
        
    GoTo endFunction
    
useFixedConstants:

    If transformEnable = BOTH Or transformEnable = xy Then
    
        If XorY Then ' return y value
            getXYfromRGB = c(1, 0) * x + c(1, 1) * y + c(1, 2)
        Else ' return x value
            getXYfromRGB = c(0, 0) * x + c(0, 1) * y + c(0, 2)
        End If
        
    Else
    
        If XorY Then ' return y value
            getXYfromRGB = y
        Else ' return x value
            getXYfromRGB = x
        End If
        
    End If
    
endFunction: End Function

Private Function getPlanckianLocusXY(ByVal t As Integer, ByVal XorY As Integer) As Double
    '
    'Reference: http://en.wikipedia.org/wiki/Planckian_locus#Approximation
    '
    'T:    color temperature in K
    'XorY: return value select
    '       XorY=0:  return X coordinate
    '       XorY<>0: return Y coordinate
    
    Const c000 As Double = -0.2661239
    Const c001 As Double = -0.234358
    Const c002 As Double = 0.8776956
    Const c003 As Double = 0.17991
    Const c010 As Double = -3.0258469
    Const c011 As Double = 2.1070379
    Const c012 As Double = 0.2226347
    Const c013 As Double = 0.24039
    
    If t < 4000 Then
        getPlanckianLocusXY = c000 * (1000 / t) ^ 3 + c001 * (1000 / t) ^ 2 + c002 * (1000 / t) ^ 1 + c003
    Else
        getPlanckianLocusXY = c010 * (1000 / t) ^ 3 + c011 * (1000 / t) ^ 2 + c012 * (1000 / t) ^ 1 + c013
    End If
    
    If XorY Then
    
        Const c100 As Double = -1.1063814
        Const c101 As Double = -1.3481102
        Const c102 As Double = 2.18555832
        Const c103 As Double = -0.20219683
        Const c110 As Double = -0.9549476
        Const c111 As Double = -1.37418593
        Const c112 As Double = 2.09137015
        Const c113 As Double = -0.16748867
        Const c120 As Double = 3.081758
        Const c121 As Double = -5.8733867
        Const c122 As Double = 3.75112997
        Const c123 As Double = -0.37001483
        
        Dim x As Double: x = getPlanckianLocusXY
        
        If t < 2222 Then
            getPlanckianLocusXY = c100 * x ^ 3 + c101 * x ^ 2 + c102 * x ^ 1 + c103
        Else
            If t < 4000 Then
                getPlanckianLocusXY = c110 * x ^ 3 + c111 * x ^ 2 + c112 * x ^ 1 + c113
            Else
                getPlanckianLocusXY = c120 * x ^ 3 + c121 * x ^ 2 + c122 * x ^ 1 + c123
            End If
        End If
    
    End If
    
End Function

Private Function getPlanckianLocus(ByVal t As Integer, ByVal XorY As Integer) As Double
    getPlanckianLocus = getPlanckianLocusUV(t, XorY)
End Function

Private Function getPlanckianLocusUV(ByVal t As Integer, ByVal UorV As Integer) As Double
    '
    'Reference: http://en.wikipedia.org/wiki/Planckian_locus#Approximation
    '
    'T:    color temperature in K
    'UorV: return value select
    '       UorV=0:  return u coordinate
    '       UorV<>0: return v coordinate
    
    Const c00 As Double = 0.860117757
    Const c01 As Double = 1.54118254
    Const c02 As Double = 1.28641212
    Const c03 As Double = 8.42420235
    Const c04 As Double = 7.08145163
    
    Const c10 As Double = 0.317398726
    Const c11 As Double = 4.22806245
    Const c12 As Double = 4.20481691
    Const c13 As Double = -2.89741816
    Const c14 As Double = 1.61456053
    
    Dim u As Double, v As Double
    
    If UorV = 0 Then
    
        u = (c00 + c01 * 10 ^ -4 * t + c02 * 10 ^ -7 * t ^ 2) / _
            (1 + c03 * 10 ^ -4 * t + c04 * 10 ^ -7 * t ^ 2)
            
        getPlanckianLocusUV = u
        
    Else
    
        v = (c10 + c11 * 10 ^ -5 * t + c11 * 10 ^ -8 * t ^ 2) / _
            (1 + c13 * 10 ^ -5 * t + c14 * 10 ^ -7 * t ^ 2)
        
        getPlanckianLocusUV = v
        
    End If
    
End Function

Public Function getUVfromXY(ByVal x As Double, ByVal y As Double, ByVal UorV As Integer) As Double
    '
    'Reference: http://en.wikipedia.org/wiki/Color_temperature#Calculation
    '
    'x:    x value from x,y chromaticity space
    'y:    y value from x,y chromaticity space
    'UorV: return value select
    '       UorV=0:  return u coordinate
    '       UorV<>0: return v coordinate
    
    If UorV Then ' V
        getUVfromXY = 6 * y / (-2 * x + 12 * y + 3)
    Else ' U
        getUVfromXY = 4 * x / (-2 * x + 12 * y + 3)
    End If
End Function

Public Function getCCTfromXY(ByVal x As Double, ByVal y As Double, Optional getDuv As Integer = 0) As Double
    '
    'x:    x value from x,y chromaticity space
    'y:    y value from x,y chromaticity space
    'getDuv: return value select
    '       getDuv=0:  return CCT in K
    '       getDuv<>0: return duv in MacAdam's "uniform chromaticity scale"
    '
    '   NOTE: CCT is only valid if |duv| < 0.05
    '

    On Error Resume Next

    Dim res As Double: res = 1#
    Const base As Double = 1500#
    Const limit As Double = 15000#
    
    Dim u As Double, v As Double, u0 As Double, v0 As Double
    Dim x0 As Double, y0 As Double
    Dim d0 As Double, d1
    Dim i As Double: i = 0
    Dim n As Double
    Dim delta As Double: delta = (limit - base) / 2
    Dim bit As Integer: bit = Int(delta / res)
    
    u = getUVfromXY(x, y, 0): v = getUVfromXY(x, y, 1)
    
    While bit > 0
    
        u0 = getPlanckianLocus(base + res * (i + bit), 0): v0 = getPlanckianLocus(base + res * (i + bit), 1)
        
        d1 = (u - u0) ^ 2 + (v - v0) ^ 2
        
        u0 = getPlanckianLocus(base + res * (i + bit - 1), 0): v0 = getPlanckianLocus(base + res * (i + bit - 1), 1)
        
        d0 = (u - u0) ^ 2 + (v - v0) ^ 2
        
        If d1 <= d0 Then
            i = i + bit: d0 = d1
        End If
        
        delta = delta / 2: bit = Int(delta / res + 0.5)
        
    Wend
    
    If getDuv Then
        getCCTfromXY = d0 ^ 0.5 * Sgn(u0 - u)
    Else
        getCCTfromXY = i * res + base
        ' if out of range return negative
        If getCCTfromXY = base Or getCCTfromXY = limit Then getCCTfromXY = -getCCTfromXY
        
        ' ||||==== McCamy ====||||
        ' http://en.wikipedia.org/wiki/Color_temperature#Approximation
        ' CCT(x, y) = -449n3 + 3525n2 - 6823.3n + 5520.33
        ' n = (x - xe)/(y - ye); (xe = 0.3320, ye = 0.1858)
        If 0 Then
            n = (x - 0.332) / (y - 0.1858)
            getCCTfromXY = -449 * n ^ 3 + 3525 * n ^ 2 - 6823.3 * n + 5520.33
        End If
        
    End If

End Function

Public Function getLux(ByVal s As Integer, ByVal R As Integer, ByVal G As Double, ByVal ir As Double, ByVal x As Double, ByVal y As Double, _
                       Optional c As range) As Double
    '
    's:    state: 2 bit word: msb=cctValid,lsb=irValid
    'r:    range (0-1)={lo,hi}
    'G:    Green measured from detector
    'ir:   delta g per compensation bit relative to level at compensation=0
    'x:    x value from x,y chromaticity space
    'y:    y value from x,y chromaticity space
    '
    
    Static c0(3, 4) As Double:
    
    On Error GoTo useFixedConstants: If Not evCoeffLoaded Then loadEVcoeff c0
    
    ' use Range data : Excel data uses same gain multiplier for lo&hi ranges
    
    Dim d As Integer
    d = UBound(c.Value2): If d <> 4 Then GoTo useFixedConstants
    
    getLux = c.Value2(1, 1) * G * (1 + c.Value2(2, 1) * ir + c.Value2(3, 1) * x + c.Value2(4, 1) * y)
            
    GoTo endFunction
    
useFixedConstants:

    getLux = c0(s, R) * G * (1 + c0(s, 2) * ir + c0(s, 3) * x + c0(s, 4) * y)

endFunction: End Function

Public Sub loadXYcoeff(c1() As Double, Optional writeValue As Boolean = False)
    Static initDone As Boolean, c0(1, 2) As Double
    Dim i As Integer, j As Integer
    
    If Not initDone Then
        ' Constants  based on characterization measurements
        ' Current values are passthru.
        ' They will be updated with no-glass 124/125 average values from A,D65 & F1-3 Illuminants
        c0(0, 0) = 1#
        c0(0, 1) = 0#
        c0(0, 2) = 0#
        c0(1, 0) = 0#
        c0(1, 1) = 1#
        c0(1, 2) = 0#
        initDone = True
    End If
    
    If writeValue Then
        For i = 0 To 1: For j = 0 To 2
            c0(i, j) = c1(i, j)
        Next j: Next i
        xyCoeffLoaded = False
    Else
        For i = 0 To 1: For j = 0 To 2
            c1(i, j) = c0(i, j)
        Next j: Next i
        xyCoeffLoaded = True
    End If
    
End Sub

Public Sub loadEVcoeff(c1() As Double, Optional writeValue As Boolean = False)
    Static initDone As Boolean, c0(3, 4) As Double
    Dim i As Integer, j As Integer
    
    If Not initDone Then
        ' Constants based on characterization measurements
        ' Current values are passthru.
        ' They will be updated with no-glass 124/125 average values from A,D65 & F1-3 Illuminants
        c0(0, 0) = 1.0811 ' range0
        c0(0, 1) = 0.8658 ' range1
        c0(0, 2) = 0#   ' dIR
        c0(0, 3) = 0#   ' x
        c0(0, 4) = 0#   ' y
        
        For j = 1 To 3: For i = 0 To 4
            c0(j, i) = c0(0, i)
        Next i: Next j
        
        initDone = True
    End If
    
    If writeValue Then
        For j = 0 To 3: For i = 0 To 4
            c0(j, i) = c1(j, i)
        Next i: Next j
        evCoeffLoaded = False
    Else
        For j = 0 To 3: For i = 0 To 4
            c1(j, i) = c0(j, i)
        Next i: Next j
        evCoeffLoaded = True
    End If
    
End Sub

Public Sub loadXYZcoeff(c1 As calValues, Optional writeValue As Boolean = False)
    Static initDone As Boolean, c0 As calValues
    Dim x As Integer, y As Integer, p As Integer
    
    If Not initDone Then
    
        ' Default is OFF (diagonal=1 with background a of zeros), gains are 1, comp=0
        For p = 0 To UBound(c0.CCM, 3)
            For y = 0 To UBound(c0.CCM, 2): For x = 0 To UBound(c0.CCM)
                If x = y Then
                    c0.CCM(x, y, p) = 1
                Else
                    c0.CCM(x, y, p) = 0
                End If
            Next x: Next y
        Next p
        
        For x = 0 To UBound(c0.comp)
            c0.comp(x) = 0
        Next x
        
        For x = 0 To UBound(c0.sysGain)
            c0.sysGain(x) = 1
        Next x
        
        For x = 0 To UBound(c0.ranges)
            c0.ranges(x) = 1
        Next x
        
        initDone = True
    End If
    
    If writeValue Then
        c0 = c1
    Else
        c1 = c0
    End If
    
    xyzCoeffLoaded = Not writeValue
    
End Sub


