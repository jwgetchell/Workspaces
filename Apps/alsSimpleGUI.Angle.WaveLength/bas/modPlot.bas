Attribute VB_Name = "modPlot"
Public gPlotSize As Integer
Public pBuf0() As Double, pBuf1() As Double

Const chartRecord As Boolean = True

Public Sub plot(plot As ucPlot, p As Double, Optional Index As Integer = 0)
    Static i0 As Integer, i1 As Integer, sz As Integer
    
    If sz <> gPlotSize Then
        sz = gPlotSize
        ReDim pBuf0(2 * sz - 1), pBuf1(2 * sz - 1)
        For i0 = 0 To sz - 1
            pBuf0(i0 * 2) = i0: pBuf1(i0 * 2) = i0
        Next i0
        
        If chartRecord Then
            i0 = 0
        Else
            i0 = i0 - 1
        End If
        
        i1 = i0: gPlotInitDone = True
    End If
    
    If (Index) Then
        pBuf1(i1 * 2 + 1) = p
        Call plot.SetData(pBuf1, sz)
    Else
        pBuf0(i0 * 2 + 1) = p
        Call plot.SetData(pBuf0, sz)
    End If
    
    plot.Draw True
    
    If chartRecord Then
        If (Index) Then
            i1 = i1 + 1: If i1 = sz Then i1 = 0
        Else
            i0 = i0 + 1: If i0 = sz Then i0 = 0
        End If
    Else
        If (Index) Then
            i1 = i1 - 1: If i1 = 0 Then i1 = sz - 1
        Else
            i0 = i0 - 1: If i0 = 0 Then i0 = sz - 1
        End If
    End If

End Sub


