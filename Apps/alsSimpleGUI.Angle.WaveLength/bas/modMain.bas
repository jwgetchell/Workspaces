Attribute VB_Name = "modMain"
Option Explicit

Public Sub plotData(frm As Form)

    If frm.cmbSweep.ListIndex = nm Then
    Else
        If frm.cmbSweep.ListIndex = deg Then
        Else
            If frm.cmbSweep.ListIndex = mm Then
                Call mmTest(frm)
            Else
                If frm.cmbSweep.ListIndex = nm_deg Then
                Else
                    If frm.cmbSweep.ListIndex = nm_comp Then
                    Else
                        MsgBox ("Undefined Sweep Type")
                    End If
                End If
            End If
        End If
    End If
    

End Sub

Function mmTest(frm As Form) As Boolean
    Static irdr As Long
    Dim v As Long, nIrdr As Long
    mmTest = True
    Call frm.ucALSusb1.dGetNirdr(nIrdr)
    If gPartNumber > 0 Then
        Call frm.ucALSusb1.dGetData(1, v)
        Call frmPlot.plotData(pdProx, v / 256#, irdr + 1)
        If irdr > nIrdr - 2 Then
            irdr = 0
            If Not frmThorlabsAPT.ucThorlabsAPT1(0).done Then
                frmThorlabsAPT.ucThorlabsAPT1(0).next_
            Else
                mmTest = False
            End If
        Else
            irdr = irdr + 1
        End If
        Call frm.ucALSusb1.dSetIrdr(irdr)
        If gPartNumber = 29038 Then
            Select Case irdr
            Case 0: Call frm.ucALSusb1.dSetProxOffset(2) '27
            Case 1: Call frm.ucALSusb1.dSetProxOffset(4) '55
            Case 2: Call frm.ucALSusb1.dSetProxOffset(8) '110
            Case 3: Call frm.ucALSusb1.dSetProxOffset(14) '220
            End Select
        End If
    'Else: tmrProximity.Enabled = False
    End If
End Function
