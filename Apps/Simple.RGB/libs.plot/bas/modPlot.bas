Attribute VB_Name = "modPlot"
' _____
' EXCEL
' ¯¯¯¯¯
Public oExcel As Excel.Application
Public oBook As Excel.Workbook
Public oSheet As Excel.Worksheet

Public gExcelFile As String
Public gDeviceNumber As Integer
Public gExcelLeft As Integer ' column of 1st device (0 based)
Public gExcelTop As Integer ' row

Public Const cExcelLeft As Integer = 1 ' column of 1st device (0 based)
Public Const cExcelTop As Integer = 2 ' row

Public pBuf0() As Double, pBuf1() As Double
Public gNplots

Const chartRecord As Boolean = True

Public Sub setXlables(min As Double, max As Double, label As String)
    Dim i As Integer
    For i = 0 To gNplots - 1
        frmPlot.ucPlot1(i).XaxisDataMin = min
        frmPlot.ucPlot1(i).XaxisDataMax = max
        frmPlot.ucPlot1(i).XaxisLabel = label
    Next i
End Sub

Public Sub setPlotSize(size As Integer)
    Dim i As Integer
    Static ssize As Integer
    If ssize <> size Then
        For i = 0 To gNplots - 1:    frmPlot.ucPlot1(i).setPlotSize (size): Next i
        ssize = size
    End If
End Sub

Public Sub plotSub(plot As ucPlot, p As Double, Optional Index As Integer = 0)
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
        'Call plot.setData(pBuf1, sz)
    Else
        pBuf0(i0 * 2 + 1) = p
        'Call plot.setData(pBuf0, sz)
    End If
    
    'plot.draw True
    
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

Public Sub openXY(file As String)
On Error GoTo errorExit
    Dim i As Integer, x As Integer, y As Integer
    Dim str As String
    
    Open file For Input As #1
    
    Input #1, str, str ' header
    '_______________
    'scan for #/rows
    '===============
    For i = 0 To 1000 ' largest..
        If EOF(1) Then
            rowVec.step = (rowVec.stop_ - rowVec.start) / (rowVec.size - 1)
            i = 1000
        Else
            Input #1, x, y
            If i = 0 Then
                rowVec.start = x
            Else
                rowVec.stop_ = x
                rowVec.size = i + 1
            End If
        End If
    Next i
    Close #1
    '_________
    'read data
    '=========
    Open file For Input As #1
    ReDim pnt(1, rowVec.size - 1)
    Input #1, str, str ' header
    For i = 0 To rowVec.size
        Input #1, pnt(0, i), pnt(1, i)
    Next i
errorExit:
    Close #1
End Sub


