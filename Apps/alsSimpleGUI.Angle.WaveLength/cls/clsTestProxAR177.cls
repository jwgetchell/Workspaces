VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestProxAR177"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim FW As ucMonochromator
Dim als As ucALSusb
Dim etio As frmEtIo

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim LUT(7) As Integer, setValue(7), offset(7) As Double
Dim prxMPA As clsMPA, ambMPA As clsMPA
Dim wheel As Integer
    
Dim timerInterval As Integer
Public Interval As Integer


Function setOffset(ByVal value As Integer) As Double
    Dim x As Long: x = value
    als.dSetProxOffset x
    setOffset = x / 255
End Function

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set FW = frmMonochromator.ucMonochromator1
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    
    Set prxMPA = New clsMPA
    Set ambMPA = New clsMPA
    
    Interval = 1000
    
    For i = 0 To 7
        LUT(i) = modDSP.getExcelName("LUT_" & i)
    Next i
    
    als.dSetPrxRngOffCmpEn 1 ' use compressed offset adjust
    
End Sub

Public Sub arm()
    testInProgress = False
    If Not testInProgress Then
    
        wheel = 0
        FW.setFilterWheel 1, 0  ' open unused wheel
        FW.setFilterWheel 0, 3  ' min level (high wheel)
        etio.shutterClosed True ' close shutter
        als.dSetSleep 4         ' 25ms sleep
        als.dSetIrdr 0          ' min IRDR
        setOffset LUT(0)        ' set to initial LUT value
        als.dSetEnable 1, 1     ' enable device
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        ' 5 levels, 8 Irdr Prox + Amb
        nMeas = 5 * 9
        plt.setPlotSize plotDataType.pdALS, nMeas
        
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        measInc = 0
    
        testInProgress = True
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
        
            als.dSetEnable 1, 0 ' dut off
            als.dSetIrdr 0      ' back to min irdr
            setOffset 0         ' min offset
            etio.shutterClosed True ' close shutter
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_(Optional idx As Integer = -1) As Single
    
    Dim i As Integer, data As Long
    Dim pVal As Double, amb As Double, pValAvg As Double, ambAvg As Double
    Static offsetTick(7) As Long
    
    For irdr = 0 To 7
        If wheel = 0 Then ' adjust offset, measure reference (wheel 0 is shutter closed)
        
            For i = 0 To LUT(irdr) ' increase until zero
                offsetTick(irdr) = LUT(irdr) + i
                offset(irdr) = setOffset(offsetTick(irdr))
                Sleep 25: DoEvents
                als.dGetProximity pVal
                If pVal < 0.02 Then Exit For
            Next i
            
            For i = i To -LUT(irdr) Step -1 ' decrease until > zero
                offsetTick(irdr) = LUT(irdr) + i
                offset(irdr) = setOffset(offsetTick(irdr))
                Sleep 25: DoEvents
                als.dGetProximity pVal
                If pVal > 0.02 Then Exit For
            Next i
        Else
            offset(irdr) = setOffset(offsetTick(irdr))
        End If
        
        For i = 0 To 31
            Sleep 25: DoEvents
            als.dGetProximity pVal
            prxMPA.setValue pVal, pValAvg
            If irdr = 0 Then
                als.dGetProxIR amb
                als.dReadI2cWord &H88, &H8, data: amb = (data And &H7F) / 127#
                ambMPA.setValue amb, ambAvg
            End If
        Next i
        
        If irdr = 0 Then
            frm.send2plot plotDataType.pdALS, ambAvg
            measInc = measInc + 1
        End If
        frm.send2plot plotDataType.pdALS, pValAvg + offset(irdr)
        measInc = measInc + 1
        
        If irdr < 7 Then
            als.dSetIrdr irdr + 1 ' set for next loop
            setOffset offsetTick(irdr + 1)
        Else
            als.dSetIrdr 0
            setOffset offsetTick(0)
        End If
    Next irdr
    
    If Not done Then
        If wheel = 0 Then etio.shutterClosed False
        wheel = wheel + 1
        FW.setFilterWheel 0, 4 - wheel
    End If
    
    next_ = measInc / nMeas

End Function


