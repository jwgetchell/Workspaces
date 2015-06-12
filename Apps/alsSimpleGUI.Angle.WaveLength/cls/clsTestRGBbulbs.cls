VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRGBbulbs"
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

'Enum color ' order matches address
'    red
'    blue
'    green
'End Enum

Dim colorN As Integer

'Excel Names
Dim RangeN As Long
Dim comp38 As Long
Dim inv125Comp As Long
Dim aryRGBcoeff(8) As Double

Private Sub Class_Initialize()

    Dim drvErr As Long

    ' read Name values from Excel
    RangeN = modDSP.getExcelName("RangeN")
    comp38 = modDSP.getExcelName("comp38")
    inv125Comp = modDSP.getExcelName("inv125Comp")
    
    If inv125Comp > 0 Then
        inv125Comp = &H40
    Else
        inv125Comp = 0
    End If
    
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
'    If gPartNumber = 29125 Then
'        If modDSP.getRGBcoeff(aryRGBcoeff) Then
'            If als.dLoadRgbCoeff(aryRGBcoeff) Then MsgBox (als.getError)
'        Else
'            If als.dClearRgbCoeff Then MsgBox (als.getError)
'        End If
'    End If

End Sub

Public Sub arm()

    Dim i As Integer, nRange As Long
    
    If Not testInProgress Then
    
        Call als.dGetPartFamily(gPartFamily)
        
        nMeas = 12: start_ = 0: stop_ = nMeas - 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas, 1
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        plt.ucPlot1(0).XaxisLabel = "meas #"
        
        ' set Range
'        als.dGetNrange 0, nRange
'        als.dSetRange 0, nRange - RangeN
'        als.dSetRange 0, RangeN
        als.dSetRange 0, 1: als.dSetRange 0, 0
        
        ' set Comp
'        If gPartNumber = 29125 Then
'            als.dSetIRcomp 127 - comp38
'        Else
'            als.dSetIRcomp 31 - comp38
'        End If
'        als.dSetIRcomp comp38
        setIRcomp 127: setIRcomp 0
                
        Sleep 300
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
    End If
    
End Sub

Sub setIRcomp(ByVal comp As Long)
    als.dSetIRcomp comp Xor inv125Comp
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
    
    If measInc = 0 Or measInc = 6 Then
    
        For i = 0 To 2
            frm.send2plot plotDataType.pdALS, value(i): measInc = measInc + 1
        Next i
        
        setIRcomp 63
        
    Else
    
        frm.send2plot plotDataType.pdALS, value(1)
        
        Select Case measInc
            Case 3, 9: setIRcomp 64
            Case 4, 10: setIRcomp comp38
            Case 5, 11: setIRcomp 0
        End Select
        
        Select Case measInc
            Case 5: als.dSetRange 0, 1
            Case 11: als.dSetRange 0, 0
        End Select
        
        measInc = measInc + 1
        
    End If
    
    next_ = measInc / nMeas

End Function

Public Function getPreTestPrompt() As String

    getPreTestPrompt = "1) set Xtrite to desired light source" & vbCr & _
                       "2) set Plot:row/column start to match spreadsheet data"

endFunction: End Function



