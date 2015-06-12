VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsUpdateBarGraphs"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim pbPtr As Variant, lblPtr As Variant, linePtr As Variant
Dim picXYZ_Width As Integer, picXYZ_Left As Integer, lblXYZ_Left As Integer

Dim digMult(1, 2) As Double, maxRng As Double ' for fixed range

Public Sub init(pbPtrIn As Variant, lblPtrIn As Variant, linePtrIn As Variant, _
                picXYZ_WidthIn As Integer, picXYZ_LeftIn As Integer, lblXYZ_LeftIn As Integer)
    picXYZ_Width = picXYZ_WidthIn
    picXYZ_Left = picXYZ_LeftIn
    lblXYZ_Left = lblXYZ_LeftIn
    Set pbPtr = pbPtrIn
    Set lblPtr = lblPtrIn
    Set linePtr = linePtrIn
End Sub

Public Sub updateBarGraphs(value() As Double, Optional ByVal autoRangeOn As Boolean = False)

    Dim maxVal As Double
    Dim mult As Integer, digit As Double
    Dim i As Integer
    
    
    ' Bar graph XYZ
    If autoRangeOn Or maxRng = 0 Then ' |||| Auto range ||||
        maxVal = value(0)
        If maxVal < value(1) Then maxVal = value(1)
        If maxVal < value(2) Then maxVal = value(2)
        
        mult = 0: digit = 5
        digMult(0, 0) = 1: digMult(0, 1) = 2 ' prime
        digMult(1, 0) = 0: digMult(1, 1) = 0
        
        Do
        
            If digit = 5 Then
                mult = mult + 1: digit = 1
            Else
                If digit = 1 Then
                    digit = 2
                Else
                    digit = 5
                End If
            End If
            
            ' push into stack
            digMult(0, 0) = digMult(0, 1): digMult(0, 1) = digMult(0, 2)
            digMult(1, 0) = digMult(1, 1): digMult(1, 1) = digMult(1, 2)
            digMult(0, 2) = digit: digMult(1, 2) = mult
        
            maxRng = digit * 10 ^ mult
            
        Loop Until maxVal < maxRng
    
        ' adjust lines/labels
        If digit = 5 Then
            i = picXYZ_Left + picXYZ_Width * 2 / 5
            linePtr(1).x1 = i: linePtr(1).X2 = i
            i = picXYZ_Left + picXYZ_Width / 5
            linePtr(2).x1 = i: linePtr(2).X2 = i
        Else
            i = picXYZ_Left + picXYZ_Width / 2
            linePtr(1).x1 = i: linePtr(1).X2 = i
            If digit = 2 Then
                i = picXYZ_Left + picXYZ_Width / 4
                linePtr(2).x1 = i: linePtr(2).X2 = i
            Else
                i = picXYZ_Left + picXYZ_Width / 5
                linePtr(2).x1 = i: linePtr(2).X2 = i
            End If
        End If
        
        lblPtr(1).Left = linePtr(1).x1 - lblXYZ_Left
        lblPtr(2).Left = linePtr(2).x1 - lblXYZ_Left
    
        For i = 0 To 2
        
            If digMult(1, i) >= 3 Then ' labels are indexed from high to low
                lblPtr(2 - i).caption = digMult(0, i) * 10 ^ (digMult(1, i) - 3) & "k"
            Else
                lblPtr(2 - i).caption = digMult(0, i) * 10 ^ (digMult(1, i) - 0)
            End If
        
        Next i
    
        
    End If '|||| End Auto Range ||||
    
    For i = 0 To 2
        
        If value(i) < 0 Then value(i) = 0
        pbPtr(i).Width = picXYZ_Width * value(i) / maxRng
        
    Next i
    
    ' END Bar graph

End Sub


