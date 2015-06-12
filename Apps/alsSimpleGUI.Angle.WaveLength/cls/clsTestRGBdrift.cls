VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsTestRGBdrift"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim etio As frmEtIo
Dim tst As frmTest
Dim luxMeter As clsLuxMeter
Dim apt As ucThorlabsAPT
Dim msr As clsIloop
Dim row As Integer

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Const nIrdr As Integer = 4

Public Interval As Integer

Dim startTick As Long

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set apt = frmThorlabsAPT.ucThorlabsAPT1(0)
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set tst = frmTest
    Set msr = frmTest.pMeasure
    
    Set luxMeter = New clsLuxMeter
    startTick = GetTickCount ' JWG ||||||| get initial start time
    
    ' read Name values from Excel
    '    PswpStart = modDSP.getExcelName("PswpStart")
    '    PswpStop = modDSP.getExcelName("PswpStop")
    '    PswpStep = modDSP.getExcelName("PswpStep")
    
    Interval = 1000
    
    row = 1
    
End Sub

Public Sub arm()

    Dim i As Integer
    Dim nRng As Long, nChn As Long
    Dim value(0) As Single
    
    If Not testInProgress Then
    
        ' setup device
        als.dSetEnable 0, 0: als.dSetEnable 0, 1
        als.dSetInputSelect 0, 0: als.dSetInputSelect 0, 2 ' RGB Mode
        als.dSetRange 0, 2: als.dSetRange 0, 0 ' Range=LO (to start)
        
        nMeas = 3 * 3 + 2 ' RGB x 3 ranges, Lux & Time
        measInc = 0
        
        ' setup plot
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        plt.setPlotSize pdALS, nMeas, 1
        plt.ucPlot1(0).XaxisDataMin = 0
        plt.ucPlot1(0).XaxisDataMax = nMeas - 1
        plt.ucPlot1(0).XaxisLabel = "Meas #"
        '-------------------
        
        If debugPrint_ Then debugPrint "<<<< START >>>>"
    
        testInProgress = True
    
    End If
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measInc >= nMeas
    
    If done Then
    
        If testInProgress Then
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            Call als.dSetEnable(1, 0) ' JWG good for 2 channel devices only
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
            If tst.getDnum = 31 Then ' restart
                plt.send2excel
                If row < 32767 - nMeas Then
                    row = row + nMeas
                    plt.VScrExcelRow(0).value = row
                    tst.cmdTest_Click
                End If
            End If
    
        End If
        
    End If
    
End Function

Public Function next_(Optional id As Integer = eMeasure.mALS) As Single
    Dim i As Long, param As Long, value(5) As Single, time As Double

    
    If measInc < 2 Then
            ' record Lux
        luxMeter.getValue value, 0: frm.send2plot pdALS, value(0)
        ' record Hours since start
        time = (GetTickCount - startTick) / (1000# * 60# * 60#) ' hours
        frm.send2plot pdALS, time
        measInc = 2
    Else
        msr.getValue value, id

        For i = 0 To 2
            frm.send2plot plotDataType.pdALS, value(i)
        Next i
        
        measInc = measInc + 3
        
        If Not done Then
            als.dSetRange 0, (measInc - 2) / 3
        Else
            als.dSetRange 0, 0
        End If
        
    End If
    
    next_ = measInc / nMeas

End Function


