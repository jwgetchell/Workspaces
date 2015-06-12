VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRGBsweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim mct As ucMonochromator
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

Enum color ' order matches address
    red
    blue
    green
End Enum

Dim colorN As Integer

'Names
Dim RangeN As Long
Dim comp38 As Long
Dim aryRGBcoeff(8) As Double

Private Sub Class_Initialize()

    Dim drvErr As Long

    ' read Name values from Excel
    RangeN = modDSP.getExcelName("RangeN")
    comp38 = modDSP.getExcelName("comp38")
    
    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set mct = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Set src = frmTest.pSource
    Set msr = frmTest.pMeasure
    
    Interval = 200
    
    ' spread sheet needs `useRGBCoeff` set to `1`
    ' coefficients saved in named range `aryRGBcoeff`
    If gPartNumber = 29125 Then
        If modDSP.getRGBcoeff(aryRGBcoeff) Then
            If als.dLoadRgbCoeff(aryRGBcoeff) Then MsgBox (als.getError)
        Else
            If als.dClearRgbCoeff Then MsgBox (als.getError)
        End If
    End If

End Sub

Public Sub arm()

    Dim i As Integer, nRange As Long
    
    If Not testInProgress Then
    
        Call als.dGetPartFamily(gPartFamily)
        
        start_ = mct.getStart
        stop_ = mct.getStop
        step_ = mct.getStep
        nMeas = ((stop_ - start_) / step_ + 1)
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        plt.setPlotSize pdALS, nMeas, 1
        plt.ucPlot1(0).XaxisDataMin = start_
        plt.ucPlot1(0).XaxisDataMax = stop_
        plt.ucPlot1(0).XaxisLabel = "nm"
        
        plt.setPlotSize pdALS, nMeas, 2
        plt.ucPlot1(1).XaxisDataMin = start_
        plt.ucPlot1(1).XaxisDataMax = stop_
        plt.ucPlot1(1).XaxisLabel = "nm"
        
        plt.setPlotSize pdALS, nMeas, 3
        plt.ucPlot1(2).XaxisDataMin = start_
        plt.ucPlot1(2).XaxisDataMax = stop_
        plt.ucPlot1(2).XaxisLabel = "nm"
        
        nMeas = nMeas * 3 ' RGB
        
        mct.arm
        
        colorN = color.red
        If gPartNumber = 29125 Then
            als.dSetInputSelect 0, 2 ' Input = {OFF, ALS, RGB}
        Else
            als.dSetInputSelect 0, colorN
        End If
        
        ' set Range
        als.dGetNrange 0, nRange
        als.dSetRange 0, nRange - RangeN
        als.dSetRange 0, RangeN
        
        ' set Comp
        If gPartNumber = 29125 Then
            als.dSetIRcomp 127 - comp38
        Else
            als.dSetIRcomp 31 - comp38
        End If
        als.dSetIRcomp comp38
                
        Sleep 3000
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
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
    Dim i As Integer, dbl As Double, value(0) As Single
    
    Dim plotInstance As Integer
    
    Select Case colorN
    Case color.red:   plotInstance = 1
    Case color.blue:  plotInstance = 3
    Case color.green: plotInstance = 2
    End Select
    
    If Not mct.done Then
    
        If gPartFamily <> 29125 Then
            msr.getValue value, id
        Else
            Select Case colorN
            Case color.red:   Call als.dGetRed(dbl)
            Case color.blue:  Call als.dGetBlue(dbl)
            Case color.green: Call als.dGetGreen(dbl)
            End Select
            value(0) = dbl
        End If
        
        Select Case id
            Case eMeasure.mALS: frm.send2plot plotDataType.pdALS, value(0), plotInstance
            Case eMeasure.mIR, measIn.prox30_: frm.send2plot plotDataType.pdIR, value(0)
            Case eMeasure.mProx: frm.send2plot plotDataType.pdProx, value(0)
        End Select
        
        colorN = (colorN + 1) Mod 3
        
        If gPartFamily <> 29125 Then als.dSetInputSelect 0, colorN
    
        measInc = measInc + 1
        
        If colorN = color.red Then mct.nextStep
                
    Else
    
        measInc = nMeas
        
    End If
    
    next_ = measInc / nMeas

End Function



