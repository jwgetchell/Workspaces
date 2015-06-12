VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRotation3d"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim test As frmTest

Dim src As clsIloop
Dim src1 As clsIloop
Dim msr As clsIloop

Dim etio As frmEtIo
Dim eep As frmEEprom

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single
Dim start1, stop1, step1 As Single

Dim nChan As Long, InputN As Long

'Names
Dim rangeN As Long
Dim comp38 As Long
Dim Comp35en As Long
Dim Ninput As Long
Dim irdr As Long

Private Sub Class_Initialize()

    ' read Name values from Excel
    ' Names must be listed in modDSP
    rangeN = modDSP.getExcelName("RangeN")
    comp38 = modDSP.getExcelName("comp38")
    Comp35en = modDSP.getExcelName("Comp35en")
    Ninput = modDSP.getExcelName("Ninputs"): If Ninput = 0 Then Ninput = 1
    irdr = modDSP.getExcelName("Irdr")
    ' ---------------------------
    
    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set test = frmTest
    
    Set src = frmTest.pSource
    Set src1 = frmTest.pSource1
    Set msr = frmTest.pMeasure
    
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set eep = frmEEprom
    
    Interval = 400
    
End Sub

Public Sub arm()

    Dim i As Integer, nMeasP As Integer
    
    If Not testInProgress Then
    
        InputN = 0 ' channel 0
        
        start_ = src.getStart ' Polar
        stop_ = src.getStop
        step_ = src.getStep
        start1 = src1.getStart ' azimuth
        stop1 = src1.getStop
        step1 = src1.getStep
        
        If step_ > 0 Then
            nMeasP = ((stop_ - start_) / step_ + 1)
            nMeas = nMeasP * ((stop1 - start1) / step1 + 1)
        Else
            nMeas = ((stop1 - start1) / step1 + 1)
            nMeasP = nMeas
        End If
        
        nMeas = nMeas * Ninput
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        For i = 0 To 3
        
            plt.setPlotSize plotDataType.pdALS, nMeasP, i + 1
            plt.setPlotSize plotDataType.pdProx, nMeasP, i + 1
            plt.setPlotSize plotDataType.pdIR, nMeasP, i + 1
        
            plt.ucPlot1(i).XaxisDataMin = start_
            plt.ucPlot1(i).XaxisDataMax = stop_
            plt.ucPlot1(i).XaxisLabel = "deg"
        
        Next i
        
        src.arm
        src1.arm: test.rePositionDUT
        
        dSetIRcomp 0 '(eep.getCmpVal(plt.getDnum))
        
        Sleep 3000
    
        Call als.dGetNchannel(nChan)
        If nChan > 1 Then Call als.dSetEnable(1, 1)
        
        dSetIRcomp comp38 ' G10 compensation
        Call als.dSetRange(0, rangeN)
        
        If irdr > 0 Then
            Call als.dSetEnable(1, 1) ' enable proximity
            Call als.dSetIrdr(irdr - 1) ' zero based
        End If
        
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
        measInc = 0
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc > nMeas
    
    If done Then
    
        If testInProgress Then
    
            'plt.cbPlotOnOff.value = vbChecked
            'frm.tmrPlot.enabled = True
            
            Call als.dSetEnable(1, 0) ' disable proximity
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Function dSetIRcomp(ByVal value As Long) As Long

    If value >= 0 Then
    
        dSetIRcomp = als.dSetIRcomp(value) ' try 38 interface
        
        If dSetIRcomp > 0 And Comp35en > 0 Then ' use 34/35 test mode
            If value > 0 Then
                Call als.dWriteField(&HE, 0, &HFF, &H38) ' disable test mode compensation
            Else
                Call als.dWriteField(&HE, 0, &HFF, &H89) ' disable compensation
                Call als.dWriteField(&H8, 0, &HFF, &H80)
            End If
        End If
        
    End If
    
End Function

Public Sub recordValue(id As Integer)
    Dim value(5) As Single
        
    If msr.getValue(value(), id) Then
    
        Select Case id
        Case eMeasure.mProx: frm.send2plot plotDataType.pdProx, value(0), InputN + 1
        Case eMeasure.mRBG:
                            frm.send2plot plotDataType.pdALS, value(0), 1
                            frm.send2plot plotDataType.pdALS, value(1), 2
                            frm.send2plot plotDataType.pdALS, value(2), 3
        Case Else: frm.send2plot plotDataType.pdALS, value(0), InputN + 1
        End Select
    
    End If

End Sub

Public Sub nextDevice()
    src.arm
    send2excel
    src1.next_: test.rePositionDUT
End Sub

Private Sub send2excel()
    Dim i As Integer
                
    For i = 0 To 2 'Ninput - 1
        plt.setSheetNumber i, i * 100 + src1.getIndex
    Next i
    
    test.send2excel
    
End Sub

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Integer, value(5) As Single
    
    If Not done Then
    
        recordValue id
        
        If src.done Then ' large stage (polar)
                    
            If src1.done Then ' small stage (azimuth)
                
                send2excel
            
            Else
                nextDevice
            End If
            
        Else
        
            If InputN >= (Ninput - 1) Then src.next_

            InputN = (InputN + 1) Mod Ninput
            
            If gPartNumber <> 29125 Then
                Select Case InputN
                    Case 0: als.dSetInputSelect 0, InputN
                    Case 1: als.dSetInputSelect 0, InputN + 1
                    Case 2: als.dSetInputSelect 0, InputN - 1
                End Select
            End If
            
        End If
        
        measInc = measInc + 1
        
        If done Then
            next_ = 1
        Else
            next_ = measInc / nMeas
        End If
        
    End If

End Function



