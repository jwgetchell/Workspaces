VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsProxSweep"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim f38 As frm29038
Dim msg As frmPrompt
Dim als As ucALSusb
Dim apt As ucThorlabsAPT
Dim etio As frmEtIo
Dim tst As frmTest

Dim measInc As Integer
Dim testInProgress As Boolean

Const debugPrint_ As Boolean = True

Dim nMeas As Integer
Dim nIrdr As Integer

Public Interval As Integer
Dim start_, stop_, step_ As Single

'Names
Dim PswpStart As Single
Dim PswpStop As Single
Dim PswpStep As Single

Private Sub Class_Initialize()

    Set frm = frmMain
    Set f38 = frm29038
    Set plt = frmPlot
    Set msg = frmPrompt
    Set apt = frmThorlabsAPT.ucThorlabsAPT1(0)
    Set als = frm.ucALSusb1
    Set etio = frmEtIo
    Set tst = frmTest
    
    ' read Name values from Excel
    PswpStart = modDSP.getExcelName("PswpStart")
    PswpStop = modDSP.getExcelName("PswpStop")
    PswpStep = modDSP.getExcelName("PswpStep")
    
    Interval = 100
    
End Sub

Public Sub arm()

    Dim i As Integer
    Dim nRng As Long, nChn As Long
    
    If Not testInProgress Then
        
        If PswpStop * PswpStep Then
            apt.setStart PswpStart
            apt.setStop PswpStop
            apt.setStep PswpStep
        End If
        
        start_ = apt.getStart
        stop_ = apt.getStop
        step_ = apt.getStep
        nMeas = (stop_ - start_) / step_ + 1
        
        frm.tmrPlot.enabled = False
        plt.cbPlotOnOff.value = vbUnchecked
        
        If frm.incIRDR Then
            nIrdr = frm.nIrdr
        Else
            nIrdr = 1
        End If
        
        For i = 0 To nIrdr - 1
            plt.setPlotSize pdProx, nMeas + 5, i + 1 ' JWG add 1 for rev, 4 for offset
            plt.ucPlot1(i).XaxisDataMin = start_
            plt.ucPlot1(i).XaxisDataMax = stop_
            'plt.ucPlot1(i).caption
            plt.ucPlot1(i).XaxisLabel = "mm"
        Next i
        
        Call als.dGetNchannel(nChn)
        If nChn > 1 Then
            Call als.dSetEnable(1, 1) ' enable proximity
            Call als.dGetNrange(0, nRng)
            If nRng > 2 Then
                measProxOffset ' must be `38
                Call als.dSetSleep(0): Call als.dSetSleep(4)
            End If
        End If
        
        apt.arm
    
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
            
            Call als.dSetEnable(1, 0) ' JWG good for 2 channel devices only
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
End Function

Public Function next_(Optional idx As Integer = -1) As Single
    Dim i As Integer, valid As Boolean: valid = True
    
    If Not apt.done Then
    
        For i = 0 To nIrdr - 1
            valid = frm.getMeasProxValid(i) And valid
        Next i
    
        If valid Then
        
            For i = 0 To nIrdr - 1
                If nIrdr = 1 Then
                    frm.send2plot plotDataType.pdProx, frm.measSprox, 1
                    frm.send2plot plotDataType.pdALS, frm.meanLux, 1
                Else
                    frm.send2plot pdProx, frm.getMeasProx(i), nIrdr - i
                End If
                Call frm.setMeasProxValid(nIrdr - 1 - i, False)
            Next i
            
            measInc = measInc + 1
            
            apt.next_
            
        End If
        
    Else
    
        If Not done Then
            
            For i = 0 To nIrdr - 1
            
                If nIrdr = 1 Then
                    frm.send2plot pdProx, frm.measSprox, 1
                    
                    frm.send2plot pdProx, f38.readRevOption / 128#, 1
            
                    frm.send2plot pdProx, g38ProxOffset(3).maxMeas, 1
                    frm.send2plot pdProx, g38ProxOffset(3).maxVal / 1000, 1
                    frm.send2plot pdProx, g38ProxOffset(3).minMeas, 1
                    frm.send2plot pdProx, g38ProxOffset(3).minVal / 1000, 1
                    
                
                Else
                    frm.send2plot pdProx, frm.getMeasProx(i), nIrdr - i
                    
                    frm.send2plot pdProx, f38.readRevOption / 128#, nIrdr - i
                
                    frm.send2plot pdProx, g38ProxOffset(i).maxMeas, nIrdr - i
                    frm.send2plot pdProx, g38ProxOffset(i).maxVal / 1000, nIrdr - i
                    frm.send2plot pdProx, g38ProxOffset(i).minMeas, nIrdr - i
                    frm.send2plot pdProx, g38ProxOffset(i).minVal / 1000, nIrdr - i
                
                End If
                
                
                Call frm.setMeasProxValid(nIrdr - 1 - i, False)
                
            Next i
            
            measInc = nMeas
        
        End If
        
    End If
    
    next_ = measInc / nMeas

End Function

Sub measProxOffset()
    Dim i As Long, o As Long
    Dim p As Double
    
    If tst.getPoffEn Then
    
        als.dSetSleep 7 ' continuous
        If stop_ > 50 Then
            apt.moveTo stop_ ' FAR
        Else
            apt.moveTo 150 ' FAR
        End If
        
        For i = 0 To nIrdr - 1
        
            If Not frm.incIRDR Then i = 3 'test at max
            
            g38ProxOffset(i).maxMeas = 0
            g38ProxOffset(i).maxVal = 0
            g38ProxOffset(i).minMeas = 0
            g38ProxOffset(i).minVal = 0
            
            als.dSetIrdr i
            als.dSetProxOffset 0
            Sleep 15
            
            For o = 0 To 15
            
                als.dSetProxOffset o
                Sleep 15
                als.dGetProximity p
                
                ' save 1st non-saturated value
                If g38ProxOffset(i).minMeas = 0 And p < 0.9 Then
                    g38ProxOffset(i).minMeas = p
                    g38ProxOffset(i).minVal = o
                End If
                
                If p > 0 Then g38ProxOffset(i).maxMeas = p
                
                If p = 0 Then
                    If o > 0 Then
                        g38ProxOffset(i).maxVal = o - 1
                    Else
                        g38ProxOffset(i).maxVal = 0
                    End If
                    als.dSetProxOffset g38ProxOffset(i).maxVal
                    o = 15 ' terminate loop
                Else
                    If o = 15 Then
                        g38ProxOffset(i).maxVal = 15 'max if no zero found
                    End If
                End If
            
            Next o
        
        Next i
        
    Else
        For i = 0 To 3
            g38ProxOffset(i).maxVal = 0
        Next i
    End If
    
End Sub


