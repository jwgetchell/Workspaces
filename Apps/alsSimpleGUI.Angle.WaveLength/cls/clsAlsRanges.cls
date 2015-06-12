VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsAlsRanges"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim frm As frmMain
Dim plt As frmPlot
Dim fltr As ucMonochromator
Dim als As ucALSusb
Dim tst As frmTest

Dim testInProgress As Boolean

Dim nRange As Long
Dim nMeas As Long
Dim measN As Long

Const debugPrint_ As Boolean = True

Public Interval As Integer

'Names
Dim comp38 As Long
Dim rngFw(3) As Long

Private Sub Class_Initialize()

    Dim i As Integer
    
    On Error Resume Next
    

    Set frm = frmMain
    Set plt = frmPlot
    Set als = frm.ucALSusb1
    'Set fltr = frmMonochromator.ucMonochromator1
    Set tst = frmTest
    
    Call als.dGetNrange(0, nRange)
    
    nMeas = 5
    
    ' read Name values from Excel
'    comp38 = modDSP.getExcelName("comp38", "Parameters")
'    For i = 0 To nRange - 1
'        rngFw(i) = modDSP.getExcelName("rng" & i & "Fw", "Parameters")
'        If i > 0 Then
'            If rngFw(i) <> rngFw(i - 1) Then
'                nMeas = nMeas + nRange - i
'            End If
'        End If
'    Next i

    Interval = 3000
    
End Sub

Public Sub arm()
    
    If Not testInProgress Then
    
        frm.tmrPlot.enabled = False
        
        plt.setPlotSize pdALS, nMeas, 1
        
        plt.cbPlotOnOff.value = vbUnchecked
    
        If debugPrint_ Then debugPrint "<<<< START >>>>"
        testInProgress = True
        
        measN = 0
    
    End If
    
    RangeN = 0
    Call als.dSetRange(0, nRange - 1)
    Call als.dSetRange(0, RangeN)
    Call als.dSetInputSelect(0, 1)
    Call als.dSetInputSelect(0, 0)
    Call als.dSetIRcomp(31 - comp38)
    Call als.dSetIRcomp(comp38)
    'Call fltr.setFilterWheel(0, rngFw(0))
    
End Sub

Public Function done() As Boolean
    Dim error As Double
    
    done = measN >= nMeas
    
    If done Then
    
        If testInProgress Then
        
            Call als.dSetRange(0, 0) ' Lo range
            Call als.dSetInputSelect(0, 0) ' ALS
            'Call fltr.setFilterWheel(0, rngFw(0))
    
            plt.cbPlotOnOff.value = vbChecked
            frm.tmrPlot.enabled = True
            
            If debugPrint_ Then debugPrint "<<< DONE >>>>"
            
            testInProgress = False
            
        End If
        
    End If
    
End Function

Public Function next_(Optional idx As Integer = -1) As Single
    
    Static count As Integer, lastALS As Double
    
    If frm.lblDataStats(2).BackColor = vbGreen Or count > 3 Then
    
        frm.send2plot pdALS, frm.meanLux, 1: lastALS = frm.meanLux
        If debugPrint_ Then debugPrint "ALS=", format(frm.meanLux, "###.0")
        
        measN = measN + 1
        
        If Not done Then
        
            If nRange = 2 Then
                Select Case measN
                Case Is < nRange:   Call als.dSetRange(0, measN)
                Case Is = nRange:   Call als.dSetInputSelect(0, 1)
                                    frm.send2plot pdALS, lastALS, 1 ' pair of dummy writes
                                    frm.send2plot pdALS, lastALS, 1 ' for non-existant ranges
                                    measN = measN + 2
                Case 5:             Call als.dSetInputSelect(0, 0)
                                    Call als.dSetRange(0, 1)
                                    Call fltr.setFilterWheel(0, rngFw(1))
                Case 7, 8:          Call als.dSetRange(0, measN - 5)
                End Select
            End If
            
            If nRange = 4 Then
                Select Case measN
                Case Is < nRange:   Call als.dSetRange(0, measN)
                Case Is = nRange:   Call als.dSetInputSelect(0, 1)
                Case 5:             Call als.dSetInputSelect(0, 0)
                                    Call als.dSetRange(0, 1)
                                    Call fltr.setFilterWheel(0, rngFw(1))
                Case 6, 7:          Call als.dSetRange(0, measN - 5)
                Case 8:             Call als.dSetRange(0, 2)
                                    Call fltr.setFilterWheel(0, rngFw(2))
                Case 9:            Call als.dSetRange(0, 3)
                Case 10:            Call fltr.setFilterWheel(0, rngFw(3))
                End Select
            End If
        
        End If
        
        GoTo skip
        If Not done Then
            If measN < nRange Then
                Call als.dSetRange(0, measN)
            Else
                Call als.dSetInputSelect(0, 1) ' IR
                If nRange < 4 Then
                    frm.send2plot pdALS, lastALS, 1 ' pair of dummy writes
                    frm.send2plot pdALS, lastALS, 1 ' for non-existant ranges
                    measN = measN + 2
                End If
            End If
        End If
skip:
        
        count = 0
    Else
    
        count = count + 1
    
    End If
    
    next_ = measN / nMeas
    
End Function


