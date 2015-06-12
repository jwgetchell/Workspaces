Attribute VB_Name = "modCalibration"
Option Explicit

Type monoCal
    start As Double
    stop_ As Double
    step As Double
    data555 As Double
    data() As Double
End Type

Dim gMonoCal As monoCal

Public gCalLedVal(0) As Single
Public gCalFwVal(0) As Single

Public Function getCalibratedLux(ByVal lux As Double, Optional normalize As Boolean = True) As Double
    getCalibratedLux = lux
    If gSweepType = nm Then getCalibratedLux = getCalibratedLux / getWaveLengthCalAdjust(gSetWaveLength, normalize)
End Function

Public Function getWaveLengthCalAdjust(ByVal wavelength As Double, Optional normalize As Boolean = True) As Double
    Dim i As Integer
    On Error GoTo subExit
    
    If gMonoCal.data555 = 0 Then readMonoCalDefault
    
    If wavelength > gMonoCal.start Then
        If wavelength > gMonoCal.stop_ Then
            i = UBound(gMonoCal.data)
        Else
            i = (wavelength - gMonoCal.start) / gMonoCal.step
        End If
    End If
   
    If normalize Then
        getWaveLengthCalAdjust = gMonoCal.data(i) / gMonoCal.data555
    Else
        getWaveLengthCalAdjust = gMonoCal.data(i)
    End If

subExit:
End Function

Private Sub getCalMax()

End Sub

Public Sub readMonoCalFile(FileName As String)
    Dim i As Integer, nm As String, w As String
    Dim first As Double, increment As Double
    Dim Size As Integer
    
    'scan
    On Error GoTo scanDone
    Open FileName For Input As 1
    Input #1, nm, w ' header
    Input #1, gMonoCal.start, w
    Input #1, gMonoCal.step, w: gMonoCal.step = gMonoCal.step - gMonoCal.start
    While (1)
        i = i + 1
        Input #1, gMonoCal.stop_, w
    Wend
scanDone:
    On Error GoTo errorExit
    Close #1: Open FileName For Input As 1
    Size = (gMonoCal.stop_ - gMonoCal.start) / gMonoCal.step
    ReDim gMonoCal.data(Size)

    Input #1, nm, w ' header
    For i = 0 To Size
        Input #1, nm, w
        gMonoCal.data(i) = val(w)
    Next i
    
    i = (555 - gMonoCal.start) / gMonoCal.step
    gMonoCal.data555 = gMonoCal.data(i)
    
    GoTo subExit
errorExit: readMonoCalDefault
subExit: Close #1: End Sub

Private Sub readMonoCalDefault()
    Dim i As Integer
    
    gMonoCal.start = 300
    gMonoCal.stop_ = 1100
    gMonoCal.step = 1
    
    ReDim gMonoCal.data((gMonoCal.stop_ - gMonoCal.start) / gMonoCal.step)
    
    i = i + 0: gMonoCal.data(i) = 0.00000198
    i = i + 1: gMonoCal.data(i) = 0.00000198
    i = i + 1: gMonoCal.data(i) = 0.00000373
    i = i + 1: gMonoCal.data(i) = 0.00000374
    i = i + 1: gMonoCal.data(i) = 0.0000038
    i = i + 1: gMonoCal.data(i) = 0.00000393
    i = i + 1: gMonoCal.data(i) = 0.00000402
    i = i + 1: gMonoCal.data(i) = 0.00000415
    i = i + 1: gMonoCal.data(i) = 0.00000428
    i = i + 1: gMonoCal.data(i) = 0.00000431
    i = i + 1: gMonoCal.data(i) = 0.00000451
    i = i + 1: gMonoCal.data(i) = 0.00000455
    i = i + 1: gMonoCal.data(i) = 0.0000047
    i = i + 1: gMonoCal.data(i) = 0.00000481
    i = i + 1: gMonoCal.data(i) = 0.00000495
    i = i + 1: gMonoCal.data(i) = 0.00000514
    i = i + 1: gMonoCal.data(i) = 0.00000525
    i = i + 1: gMonoCal.data(i) = 0.00000536
    i = i + 1: gMonoCal.data(i) = 0.00000556
    i = i + 1: gMonoCal.data(i) = 0.00000567
    i = i + 1: gMonoCal.data(i) = 0.00000583
    i = i + 1: gMonoCal.data(i) = 0.00000603
    i = i + 1: gMonoCal.data(i) = 0.00000625
    i = i + 1: gMonoCal.data(i) = 0.00000641
    i = i + 1: gMonoCal.data(i) = 0.00000657
    i = i + 1: gMonoCal.data(i) = 0.00000681
    i = i + 1: gMonoCal.data(i) = 0.000007
    i = i + 1: gMonoCal.data(i) = 0.00000713
    i = i + 1: gMonoCal.data(i) = 0.0000074
    i = i + 1: gMonoCal.data(i) = 0.00000763
    i = i + 1: gMonoCal.data(i) = 0.00000787
    i = i + 1: gMonoCal.data(i) = 0.00000801
    i = i + 1: gMonoCal.data(i) = 0.00000824
    i = i + 1: gMonoCal.data(i) = 0.00000853
    i = i + 1: gMonoCal.data(i) = 0.00000879
    i = i + 1: gMonoCal.data(i) = 0.000009
    i = i + 1: gMonoCal.data(i) = 0.00000935
    i = i + 1: gMonoCal.data(i) = 0.00000951
    i = i + 1: gMonoCal.data(i) = 0.00000976
    i = i + 1: gMonoCal.data(i) = 0.00001
    i = i + 1: gMonoCal.data(i) = 0.0000104
    i = i + 1: gMonoCal.data(i) = 0.0000106
    i = i + 1: gMonoCal.data(i) = 0.0000109
    i = i + 1: gMonoCal.data(i) = 0.0000113
    i = i + 1: gMonoCal.data(i) = 0.0000116
    i = i + 1: gMonoCal.data(i) = 0.0000119
    i = i + 1: gMonoCal.data(i) = 0.0000122
    i = i + 1: gMonoCal.data(i) = 0.0000125
    i = i + 1: gMonoCal.data(i) = 0.0000128
    i = i + 1: gMonoCal.data(i) = 0.0000132
    i = i + 1: gMonoCal.data(i) = 0.0000132
    i = i + 1: gMonoCal.data(i) = 0.0000139
    i = i + 1: gMonoCal.data(i) = 0.0000143
    i = i + 1: gMonoCal.data(i) = 0.0000148
    i = i + 1: gMonoCal.data(i) = 0.000015
    i = i + 1: gMonoCal.data(i) = 0.0000154
    i = i + 1: gMonoCal.data(i) = 0.0000159
    i = i + 1: gMonoCal.data(i) = 0.0000162
    i = i + 1: gMonoCal.data(i) = 0.0000167
    i = i + 1: gMonoCal.data(i) = 0.0000171
    i = i + 1: gMonoCal.data(i) = 0.0000176
    i = i + 1: gMonoCal.data(i) = 0.0000178
    i = i + 1: gMonoCal.data(i) = 0.0000182
    i = i + 1: gMonoCal.data(i) = 0.0000187
    i = i + 1: gMonoCal.data(i) = 0.0000191
    i = i + 1: gMonoCal.data(i) = 0.0000196
    i = i + 1: gMonoCal.data(i) = 0.0000199
    i = i + 1: gMonoCal.data(i) = 0.0000205
    i = i + 1: gMonoCal.data(i) = 0.0000211
    i = i + 1: gMonoCal.data(i) = 0.0000216
    i = i + 1: gMonoCal.data(i) = 0.0000221
    i = i + 1: gMonoCal.data(i) = 0.0000224
    i = i + 1: gMonoCal.data(i) = 0.0000229
    i = i + 1: gMonoCal.data(i) = 0.0000236
    i = i + 1: gMonoCal.data(i) = 0.0000238
    i = i + 1: gMonoCal.data(i) = 0.0000245
    i = i + 1: gMonoCal.data(i) = 0.000025
    i = i + 1: gMonoCal.data(i) = 0.0000255
    i = i + 1: gMonoCal.data(i) = 0.0000259
    i = i + 1: gMonoCal.data(i) = 0.0000269
    i = i + 1: gMonoCal.data(i) = 0.0000272
    i = i + 1: gMonoCal.data(i) = 0.0000278
    i = i + 1: gMonoCal.data(i) = 0.0000281
    i = i + 1: gMonoCal.data(i) = 0.0000291
    i = i + 1: gMonoCal.data(i) = 0.0000292
    i = i + 1: gMonoCal.data(i) = 0.0000297
    i = i + 1: gMonoCal.data(i) = 0.0000305
    i = i + 1: gMonoCal.data(i) = 0.000031
    i = i + 1: gMonoCal.data(i) = 0.0000316
    i = i + 1: gMonoCal.data(i) = 0.0000319
    i = i + 1: gMonoCal.data(i) = 0.0000326
    i = i + 1: gMonoCal.data(i) = 0.0000334
    i = i + 1: gMonoCal.data(i) = 0.0000339
    i = i + 1: gMonoCal.data(i) = 0.0000348
    i = i + 1: gMonoCal.data(i) = 0.0000349
    i = i + 1: gMonoCal.data(i) = 0.0000356
    i = i + 1: gMonoCal.data(i) = 0.0000365
    i = i + 1: gMonoCal.data(i) = 0.0000366
    i = i + 1: gMonoCal.data(i) = 0.0000374
    i = i + 1: gMonoCal.data(i) = 0.000038
    i = i + 1: gMonoCal.data(i) = 0.0000388
    i = i + 1: gMonoCal.data(i) = 0.0000397
    i = i + 1: gMonoCal.data(i) = 0.00004
    i = i + 1: gMonoCal.data(i) = 0.0000408
    i = i + 1: gMonoCal.data(i) = 0.0000414
    i = i + 1: gMonoCal.data(i) = 0.0000426
    i = i + 1: gMonoCal.data(i) = 0.000043
    i = i + 1: gMonoCal.data(i) = 0.0000438
    i = i + 1: gMonoCal.data(i) = 0.0000441
    i = i + 1: gMonoCal.data(i) = 0.0000452
    i = i + 1: gMonoCal.data(i) = 0.000046
    i = i + 1: gMonoCal.data(i) = 0.0000464
    i = i + 1: gMonoCal.data(i) = 0.0000473
    i = i + 1: gMonoCal.data(i) = 0.0000481
    i = i + 1: gMonoCal.data(i) = 0.0000485
    i = i + 1: gMonoCal.data(i) = 0.0000499
    i = i + 1: gMonoCal.data(i) = 0.0000503
    i = i + 1: gMonoCal.data(i) = 0.0000509
    i = i + 1: gMonoCal.data(i) = 0.0000519
    i = i + 1: gMonoCal.data(i) = 0.0000522
    i = i + 1: gMonoCal.data(i) = 0.0000533
    i = i + 1: gMonoCal.data(i) = 0.0000542
    i = i + 1: gMonoCal.data(i) = 0.0000549
    i = i + 1: gMonoCal.data(i) = 0.0000559
    i = i + 1: gMonoCal.data(i) = 0.000056
    i = i + 1: gMonoCal.data(i) = 0.0000567
    i = i + 1: gMonoCal.data(i) = 0.0000576
    i = i + 1: gMonoCal.data(i) = 0.0000583
    i = i + 1: gMonoCal.data(i) = 0.0000593
    i = i + 1: gMonoCal.data(i) = 0.0000602
    i = i + 1: gMonoCal.data(i) = 0.0000604
    i = i + 1: gMonoCal.data(i) = 0.0000617
    i = i + 1: gMonoCal.data(i) = 0.0000618
    i = i + 1: gMonoCal.data(i) = 0.0000626
    i = i + 1: gMonoCal.data(i) = 0.0000634
    i = i + 1: gMonoCal.data(i) = 0.0000642
    i = i + 1: gMonoCal.data(i) = 0.0000646
    i = i + 1: gMonoCal.data(i) = 0.000066
    i = i + 1: gMonoCal.data(i) = 0.0000662
    i = i + 1: gMonoCal.data(i) = 0.0000669
    i = i + 1: gMonoCal.data(i) = 0.0000676
    i = i + 1: gMonoCal.data(i) = 0.0000689
    i = i + 1: gMonoCal.data(i) = 0.0000692
    i = i + 1: gMonoCal.data(i) = 0.0000702
    i = i + 1: gMonoCal.data(i) = 0.0000708
    i = i + 1: gMonoCal.data(i) = 0.0000717
    i = i + 1: gMonoCal.data(i) = 0.0000721
    i = i + 1: gMonoCal.data(i) = 0.0000728
    i = i + 1: gMonoCal.data(i) = 0.0000741
    i = i + 1: gMonoCal.data(i) = 0.0000745
    i = i + 1: gMonoCal.data(i) = 0.000075
    i = i + 1: gMonoCal.data(i) = 0.0000764
    i = i + 1: gMonoCal.data(i) = 0.0000766
    i = i + 1: gMonoCal.data(i) = 0.0000772
    i = i + 1: gMonoCal.data(i) = 0.0000781
    i = i + 1: gMonoCal.data(i) = 0.0000786
    i = i + 1: gMonoCal.data(i) = 0.0000798
    i = i + 1: gMonoCal.data(i) = 0.0000803
    i = i + 1: gMonoCal.data(i) = 0.0000811
    i = i + 1: gMonoCal.data(i) = 0.0000819
    i = i + 1: gMonoCal.data(i) = 0.0000823
    i = i + 1: gMonoCal.data(i) = 0.0000837
    i = i + 1: gMonoCal.data(i) = 0.0000837
    i = i + 1: gMonoCal.data(i) = 0.0000782
    i = i + 1: gMonoCal.data(i) = 0.0000855
    i = i + 1: gMonoCal.data(i) = 0.0000863
    i = i + 1: gMonoCal.data(i) = 0.0000871
    i = i + 1: gMonoCal.data(i) = 0.0000882
    i = i + 1: gMonoCal.data(i) = 0.0000888
    i = i + 1: gMonoCal.data(i) = 0.0000896
    i = i + 1: gMonoCal.data(i) = 0.00009
    i = i + 1: gMonoCal.data(i) = 0.0000914
    i = i + 1: gMonoCal.data(i) = 0.0000917
    i = i + 1: gMonoCal.data(i) = 0.0000921
    i = i + 1: gMonoCal.data(i) = 0.0000932
    i = i + 1: gMonoCal.data(i) = 0.0000934
    i = i + 1: gMonoCal.data(i) = 0.0000944
    i = i + 1: gMonoCal.data(i) = 0.0000954
    i = i + 1: gMonoCal.data(i) = 0.000096
    i = i + 1: gMonoCal.data(i) = 0.0000972
    i = i + 1: gMonoCal.data(i) = 0.0000977
    i = i + 1: gMonoCal.data(i) = 0.0000988
    i = i + 1: gMonoCal.data(i) = 0.000099
    i = i + 1: gMonoCal.data(i) = 0.0001004
    i = i + 1: gMonoCal.data(i) = 0.000101498
    i = i + 1: gMonoCal.data(i) = 0.000102497
    i = i + 1: gMonoCal.data(i) = 0.000102298
    i = i + 1: gMonoCal.data(i) = 0.000102997
    i = i + 1: gMonoCal.data(i) = 0.000104595
    i = i + 1: gMonoCal.data(i) = 0.000105494
    i = i + 1: gMonoCal.data(i) = 0.000106094
    i = i + 1: gMonoCal.data(i) = 0.000106893
    i = i + 1: gMonoCal.data(i) = 0.000108391
    i = i + 1: gMonoCal.data(i) = 0.000108391
    i = i + 1: gMonoCal.data(i) = 0.00010999
    i = i + 1: gMonoCal.data(i) = 0.00011009
    i = i + 1: gMonoCal.data(i) = 0.000111788
    i = i + 1: gMonoCal.data(i) = 0.000111888
    i = i + 1: gMonoCal.data(i) = 0.000112587
    i = i + 1: gMonoCal.data(i) = 0.000113287
    i = i + 1: gMonoCal.data(i) = 0.000113686
    i = i + 1: gMonoCal.data(i) = 0.000114685
    i = i + 1: gMonoCal.data(i) = 0.000115784
    i = i + 1: gMonoCal.data(i) = 0.000116683
    i = i + 1: gMonoCal.data(i) = 0.000117482
    i = i + 1: gMonoCal.data(i) = 0.000118481
    i = i + 1: gMonoCal.data(i) = 0.000119081
    i = i + 1: gMonoCal.data(i) = 0.00012008
    i = i + 1: gMonoCal.data(i) = 0.000121179
    i = i + 1: gMonoCal.data(i) = 0.000121578
    i = i + 1: gMonoCal.data(i) = 0.000121578
    i = i + 1: gMonoCal.data(i) = 0.000122777
    i = i + 1: gMonoCal.data(i) = 0.000122977
    i = i + 1: gMonoCal.data(i) = 0.000124775
    i = i + 1: gMonoCal.data(i) = 0.000124276
    i = i + 1: gMonoCal.data(i) = 0.000125774
    i = i + 1: gMonoCal.data(i) = 0.000125874
    i = i + 1: gMonoCal.data(i) = 0.000127073
    i = i + 1: gMonoCal.data(i) = 0.000127472
    i = i + 1: gMonoCal.data(i) = 0.000128571
    i = i + 1: gMonoCal.data(i) = 0.000129171
    i = i + 1: gMonoCal.data(i) = 0.00012977
    i = i + 1: gMonoCal.data(i) = 0.000131169
    i = i + 1: gMonoCal.data(i) = 0.000131568
    i = i + 1: gMonoCal.data(i) = 0.000132967
    i = i + 1: gMonoCal.data(i) = 0.000132368
    i = i + 1: gMonoCal.data(i) = 0.000133366
    i = i + 1: gMonoCal.data(i) = 0.000134266
    i = i + 1: gMonoCal.data(i) = 0.000135065
    i = i + 1: gMonoCal.data(i) = 0.000136064
    i = i + 1: gMonoCal.data(i) = 0.000137163
    i = i + 1: gMonoCal.data(i) = 0.000137263
    i = i + 1: gMonoCal.data(i) = 0.000137462
    i = i + 1: gMonoCal.data(i) = 0.000138262
    i = i + 1: gMonoCal.data(i) = 0.00013976
    i = i + 1: gMonoCal.data(i) = 0.00013946
    i = i + 1: gMonoCal.data(i) = 0.00013996
    i = i + 1: gMonoCal.data(i) = 0.000141758
    i = i + 1: gMonoCal.data(i) = 0.000142158
    i = i + 1: gMonoCal.data(i) = 0.000142258
    i = i + 1: gMonoCal.data(i) = 0.000142457
    i = i + 1: gMonoCal.data(i) = 0.000143956
    i = i + 1: gMonoCal.data(i) = 0.000144056
    i = i + 1: gMonoCal.data(i) = 0.000144455
    i = i + 1: gMonoCal.data(i) = 0.000144355
    i = i + 1: gMonoCal.data(i) = 0.000145355
    i = i + 1: gMonoCal.data(i) = 0.000146653
    i = i + 1: gMonoCal.data(i) = 0.000146453
    i = i + 1: gMonoCal.data(i) = 0.000147552
    i = i + 1: gMonoCal.data(i) = 0.000148651
    i = i + 1: gMonoCal.data(i) = 0.000148152
    i = i + 1: gMonoCal.data(i) = 0.000148851
    i = i + 1: gMonoCal.data(i) = 0.00014965
    i = i + 1: gMonoCal.data(i) = 0.000150749
    i = i + 1: gMonoCal.data(i) = 0.000151149
    i = i + 1: gMonoCal.data(i) = 0.000150849
    i = i + 1: gMonoCal.data(i) = 0.000151448
    i = i + 1: gMonoCal.data(i) = 0.000151948
    i = i + 1: gMonoCal.data(i) = 0.000152947
    i = i + 1: gMonoCal.data(i) = 0.000154246
    i = i + 1: gMonoCal.data(i) = 0.000154945
    i = i + 1: gMonoCal.data(i) = 0.000154146
    i = i + 1: gMonoCal.data(i) = 0.000154745
    i = i + 1: gMonoCal.data(i) = 0.000155345
    i = i + 1: gMonoCal.data(i) = 0.000156343
    i = i + 1: gMonoCal.data(i) = 0.000156343
    i = i + 1: gMonoCal.data(i) = 0.000157942
    i = i + 1: gMonoCal.data(i) = 0.000157143
    i = i + 1: gMonoCal.data(i) = 0.000157942
    i = i + 1: gMonoCal.data(i) = 0.000158541
    i = i + 1: gMonoCal.data(i) = 0.000158441
    i = i + 1: gMonoCal.data(i) = 0.00015974
    i = i + 1: gMonoCal.data(i) = 0.00016024
    i = i + 1: gMonoCal.data(i) = 0.000160639
    i = i + 1: gMonoCal.data(i) = 0.00016024
    i = i + 1: gMonoCal.data(i) = 0.000160939
    i = i + 1: gMonoCal.data(i) = 0.000161838
    i = i + 1: gMonoCal.data(i) = 0.000162338
    i = i + 1: gMonoCal.data(i) = 0.000162737
    i = i + 1: gMonoCal.data(i) = 0.000163037
    i = i + 1: gMonoCal.data(i) = 0.000162537
    i = i + 1: gMonoCal.data(i) = 0.000163237
    i = i + 1: gMonoCal.data(i) = 0.000163436
    i = i + 1: gMonoCal.data(i) = 0.000164136
    i = i + 1: gMonoCal.data(i) = 0.000165334
    i = i + 1: gMonoCal.data(i) = 0.000165434
    i = i + 1: gMonoCal.data(i) = 0.000165734
    i = i + 1: gMonoCal.data(i) = 0.000165934
    i = i + 1: gMonoCal.data(i) = 0.000166533
    i = i + 1: gMonoCal.data(i) = 0.000166633
    i = i + 1: gMonoCal.data(i) = 0.000165634
    i = i + 1: gMonoCal.data(i) = 0.000166234
    i = i + 1: gMonoCal.data(i) = 0.000167632
    i = i + 1: gMonoCal.data(i) = 0.000166533
    i = i + 1: gMonoCal.data(i) = 0.000166933
    i = i + 1: gMonoCal.data(i) = 0.000167632
    i = i + 1: gMonoCal.data(i) = 0.000167432
    i = i + 1: gMonoCal.data(i) = 0.000168531
    i = i + 1: gMonoCal.data(i) = 0.000168831
    i = i + 1: gMonoCal.data(i) = 0.000169031
    i = i + 1: gMonoCal.data(i) = 0.00016933
    i = i + 1: gMonoCal.data(i) = 0.000169131
    i = i + 1: gMonoCal.data(i) = 0.00016973
    i = i + 1: gMonoCal.data(i) = 0.00016943
    i = i + 1: gMonoCal.data(i) = 0.000169231
    i = i + 1: gMonoCal.data(i) = 0.00016973
    i = i + 1: gMonoCal.data(i) = 0.00016933
    i = i + 1: gMonoCal.data(i) = 0.00016933
    i = i + 1: gMonoCal.data(i) = 0.00017013
    i = i + 1: gMonoCal.data(i) = 0.00017003
    i = i + 1: gMonoCal.data(i) = 0.000170529
    i = i + 1: gMonoCal.data(i) = 0.000171129
    i = i + 1: gMonoCal.data(i) = 0.000170429
    i = i + 1: gMonoCal.data(i) = 0.000170629
    i = i + 1: gMonoCal.data(i) = 0.00017033
    i = i + 1: gMonoCal.data(i) = 0.000170929
    i = i + 1: gMonoCal.data(i) = 0.000170829
    i = i + 1: gMonoCal.data(i) = 0.000170529
    i = i + 1: gMonoCal.data(i) = 0.000170829
    i = i + 1: gMonoCal.data(i) = 0.000171428
    i = i + 1: gMonoCal.data(i) = 0.000171229
    i = i + 1: gMonoCal.data(i) = 0.000171528
    i = i + 1: gMonoCal.data(i) = 0.000172228
    i = i + 1: gMonoCal.data(i) = 0.000170729
    i = i + 1: gMonoCal.data(i) = 0.000171129
    i = i + 1: gMonoCal.data(i) = 0.000170929
    i = i + 1: gMonoCal.data(i) = 0.000172128
    i = i + 1: gMonoCal.data(i) = 0.000171628
    i = i + 1: gMonoCal.data(i) = 0.000171928
    i = i + 1: gMonoCal.data(i) = 0.000171328
    i = i + 1: gMonoCal.data(i) = 0.000170629
    i = i + 1: gMonoCal.data(i) = 0.000170429
    i = i + 1: gMonoCal.data(i) = 0.000170529
    i = i + 1: gMonoCal.data(i) = 0.000170729
    i = i + 1: gMonoCal.data(i) = 0.00017033
    i = i + 1: gMonoCal.data(i) = 0.00016983
    i = i + 1: gMonoCal.data(i) = 0.000171129
    i = i + 1: gMonoCal.data(i) = 0.00017033
    i = i + 1: gMonoCal.data(i) = 0.00016973
    i = i + 1: gMonoCal.data(i) = 0.00017013
    i = i + 1: gMonoCal.data(i) = 0.00016973
    i = i + 1: gMonoCal.data(i) = 0.00016993
    i = i + 1: gMonoCal.data(i) = 0.000168531
    i = i + 1: gMonoCal.data(i) = 0.000168232
    i = i + 1: gMonoCal.data(i) = 0.000167932
    i = i + 1: gMonoCal.data(i) = 0.000167432
    i = i + 1: gMonoCal.data(i) = 0.000167332
    i = i + 1: gMonoCal.data(i) = 0.000166633
    i = i + 1: gMonoCal.data(i) = 0.000166733
    i = i + 1: gMonoCal.data(i) = 0.000165534
    i = i + 1: gMonoCal.data(i) = 0.000165834
    i = i + 1: gMonoCal.data(i) = 0.000164635
    i = i + 1: gMonoCal.data(i) = 0.000163936
    i = i + 1: gMonoCal.data(i) = 0.000162437
    i = i + 1: gMonoCal.data(i) = 0.000162138
    i = i + 1: gMonoCal.data(i) = 0.000160639
    i = i + 1: gMonoCal.data(i) = 0.00016024
    i = i + 1: gMonoCal.data(i) = 0.00015994
    i = i + 1: gMonoCal.data(i) = 0.00015974
    i = i + 1: gMonoCal.data(i) = 0.000159141
    i = i + 1: gMonoCal.data(i) = 0.000159241
    i = i + 1: gMonoCal.data(i) = 0.000159041
    i = i + 1: gMonoCal.data(i) = 0.00015984
    i = i + 1: gMonoCal.data(i) = 0.000160739
    i = i + 1: gMonoCal.data(i) = 0.000161538
    i = i + 1: gMonoCal.data(i) = 0.000162837
    i = i + 1: gMonoCal.data(i) = 0.000164136
    i = i + 1: gMonoCal.data(i) = 0.000165834
    i = i + 1: gMonoCal.data(i) = 0.000168032
    i = i + 1: gMonoCal.data(i) = 0.000168931
    i = i + 1: gMonoCal.data(i) = 0.000170429
    i = i + 1: gMonoCal.data(i) = 0.000173027
    i = i + 1: gMonoCal.data(i) = 0.000172727
    i = i + 1: gMonoCal.data(i) = 0.000176723
    i = i + 1: gMonoCal.data(i) = 0.000178521
    i = i + 1: gMonoCal.data(i) = 0.00018022
    i = i + 1: gMonoCal.data(i) = 0.000181618
    i = i + 1: gMonoCal.data(i) = 0.000184216
    i = i + 1: gMonoCal.data(i) = 0.000185414
    i = i + 1: gMonoCal.data(i) = 0.000186513
    i = i + 1: gMonoCal.data(i) = 0.000188411
    i = i + 1: gMonoCal.data(i) = 0.00019011
    i = i + 1: gMonoCal.data(i) = 0.000191408
    i = i + 1: gMonoCal.data(i) = 0.000192907
    i = i + 1: gMonoCal.data(i) = 0.000194305
    i = i + 1: gMonoCal.data(i) = 0.000195404
    i = i + 1: gMonoCal.data(i) = 0.000197502
    i = i + 1: gMonoCal.data(i) = 0.000198002
    i = i + 1: gMonoCal.data(i) = 0.000198901
    i = i + 1: gMonoCal.data(i) = 0.0001998
    i = i + 1: gMonoCal.data(i) = 0.000200999
    i = i + 1: gMonoCal.data(i) = 0.000201299
    i = i + 1: gMonoCal.data(i) = 0.000202597
    i = i + 1: gMonoCal.data(i) = 0.000202997
    i = i + 1: gMonoCal.data(i) = 0.000204395
    i = i + 1: gMonoCal.data(i) = 0.000204495
    i = i + 1: gMonoCal.data(i) = 0.000204695
    i = i + 1: gMonoCal.data(i) = 0.000205594
    i = i + 1: gMonoCal.data(i) = 0.000205894
    i = i + 1: gMonoCal.data(i) = 0.000205594
    i = i + 1: gMonoCal.data(i) = 0.000206393
    i = i + 1: gMonoCal.data(i) = 0.000206294
    i = i + 1: gMonoCal.data(i) = 0.000206693
    i = i + 1: gMonoCal.data(i) = 0.000207392
    i = i + 1: gMonoCal.data(i) = 0.000207892
    i = i + 1: gMonoCal.data(i) = 0.000207592
    i = i + 1: gMonoCal.data(i) = 0.000206493
    i = i + 1: gMonoCal.data(i) = 0.000206693
    i = i + 1: gMonoCal.data(i) = 0.000207292
    i = i + 1: gMonoCal.data(i) = 0.000207093
    i = i + 1: gMonoCal.data(i) = 0.000206693
    i = i + 1: gMonoCal.data(i) = 0.000206693
    i = i + 1: gMonoCal.data(i) = 0.000206493
    i = i + 1: gMonoCal.data(i) = 0.000206194
    i = i + 1: gMonoCal.data(i) = 0.000205594
    i = i + 1: gMonoCal.data(i) = 0.000204695
    i = i + 1: gMonoCal.data(i) = 0.000205394
    i = i + 1: gMonoCal.data(i) = 0.000205294
    i = i + 1: gMonoCal.data(i) = 0.000203496
    i = i + 1: gMonoCal.data(i) = 0.000202597
    i = i + 1: gMonoCal.data(i) = 0.000203696
    i = i + 1: gMonoCal.data(i) = 0.000203097
    i = i + 1: gMonoCal.data(i) = 0.000201898
    i = i + 1: gMonoCal.data(i) = 0.000202098
    i = i + 1: gMonoCal.data(i) = 0.000201898
    i = i + 1: gMonoCal.data(i) = 0.000200699
    i = i + 1: gMonoCal.data(i) = 0.0001998
    i = i + 1: gMonoCal.data(i) = 0.0001998
    i = i + 1: gMonoCal.data(i) = 0.000199301
    i = i + 1: gMonoCal.data(i) = 0.000198601
    i = i + 1: gMonoCal.data(i) = 0.000198601
    i = i + 1: gMonoCal.data(i) = 0.000197702
    i = i + 1: gMonoCal.data(i) = 0.000196903
    i = i + 1: gMonoCal.data(i) = 0.000196004
    i = i + 1: gMonoCal.data(i) = 0.000195704
    i = i + 1: gMonoCal.data(i) = 0.000195205
    i = i + 1: gMonoCal.data(i) = 0.000194505
    i = i + 1: gMonoCal.data(i) = 0.000194305
    i = i + 1: gMonoCal.data(i) = 0.000192907
    i = i + 1: gMonoCal.data(i) = 0.000192807
    i = i + 1: gMonoCal.data(i) = 0.000192307
    i = i + 1: gMonoCal.data(i) = 0.000191109
    i = i + 1: gMonoCal.data(i) = 0.000191009
    i = i + 1: gMonoCal.data(i) = 0.000190709
    i = i + 1: gMonoCal.data(i) = 0.000189111
    i = i + 1: gMonoCal.data(i) = 0.000188311
    i = i + 1: gMonoCal.data(i) = 0.000188611
    i = i + 1: gMonoCal.data(i) = 0.000187912
    i = i + 1: gMonoCal.data(i) = 0.000187013
    i = i + 1: gMonoCal.data(i) = 0.000185614
    i = i + 1: gMonoCal.data(i) = 0.000185514
    i = i + 1: gMonoCal.data(i) = 0.000184915
    i = i + 1: gMonoCal.data(i) = 0.000184016
    i = i + 1: gMonoCal.data(i) = 0.000182617
    i = i + 1: gMonoCal.data(i) = 0.000182018
    i = i + 1: gMonoCal.data(i) = 0.000181718
    i = i + 1: gMonoCal.data(i) = 0.000180519
    i = i + 1: gMonoCal.data(i) = 0.00017962
    i = i + 1: gMonoCal.data(i) = 0.000178921
    i = i + 1: gMonoCal.data(i) = 0.000179221
    i = i + 1: gMonoCal.data(i) = 0.000178222
    i = i + 1: gMonoCal.data(i) = 0.000176423
    i = i + 1: gMonoCal.data(i) = 0.000176024
    i = i + 1: gMonoCal.data(i) = 0.000176124
    i = i + 1: gMonoCal.data(i) = 0.000174126
    i = i + 1: gMonoCal.data(i) = 0.000174425
    i = i + 1: gMonoCal.data(i) = 0.000172727
    i = i + 1: gMonoCal.data(i) = 0.000172527
    i = i + 1: gMonoCal.data(i) = 0.000172028
    i = i + 1: gMonoCal.data(i) = 0.00017033
    i = i + 1: gMonoCal.data(i) = 0.000170429
    i = i + 1: gMonoCal.data(i) = 0.000169231
    i = i + 1: gMonoCal.data(i) = 0.000168332
    i = i + 1: gMonoCal.data(i) = 0.000168132
    i = i + 1: gMonoCal.data(i) = 0.000166733
    i = i + 1: gMonoCal.data(i) = 0.000166034
    i = i + 1: gMonoCal.data(i) = 0.000165834
    i = i + 1: gMonoCal.data(i) = 0.000164835
    i = i + 1: gMonoCal.data(i) = 0.000163836
    i = i + 1: gMonoCal.data(i) = 0.000163237
    i = i + 1: gMonoCal.data(i) = 0.000162637
    i = i + 1: gMonoCal.data(i) = 0.000162338
    i = i + 1: gMonoCal.data(i) = 0.000160639
    i = i + 1: gMonoCal.data(i) = 0.000160439
    i = i + 1: gMonoCal.data(i) = 0.000159341
    i = i + 1: gMonoCal.data(i) = 0.000158541
    i = i + 1: gMonoCal.data(i) = 0.000158142
    i = i + 1: gMonoCal.data(i) = 0.000156743
    i = i + 1: gMonoCal.data(i) = 0.000156044
    i = i + 1: gMonoCal.data(i) = 0.000156244
    i = i + 1: gMonoCal.data(i) = 0.000155145
    i = i + 1: gMonoCal.data(i) = 0.000154146
    i = i + 1: gMonoCal.data(i) = 0.000153347
    i = i + 1: gMonoCal.data(i) = 0.000152747
    i = i + 1: gMonoCal.data(i) = 0.000152347
    i = i + 1: gMonoCal.data(i) = 0.000151448
    i = i + 1: gMonoCal.data(i) = 0.000151249
    i = i + 1: gMonoCal.data(i) = 0.000150549
    i = i + 1: gMonoCal.data(i) = 0.00015025
    i = i + 1: gMonoCal.data(i) = 0.000148851
    i = i + 1: gMonoCal.data(i) = 0.000148451
    i = i + 1: gMonoCal.data(i) = 0.000147552
    i = i + 1: gMonoCal.data(i) = 0.000147552
    i = i + 1: gMonoCal.data(i) = 0.000147452
    i = i + 1: gMonoCal.data(i) = 0.000146353
    i = i + 1: gMonoCal.data(i) = 0.000145954
    i = i + 1: gMonoCal.data(i) = 0.000145155
    i = i + 1: gMonoCal.data(i) = 0.000144355
    i = i + 1: gMonoCal.data(i) = 0.000144056
    i = i + 1: gMonoCal.data(i) = 0.000143157
    i = i + 1: gMonoCal.data(i) = 0.000142957
    i = i + 1: gMonoCal.data(i) = 0.000142757
    i = i + 1: gMonoCal.data(i) = 0.000142158
    i = i + 1: gMonoCal.data(i) = 0.000141558
    i = i + 1: gMonoCal.data(i) = 0.000141458
    i = i + 1: gMonoCal.data(i) = 0.000140859
    i = i + 1: gMonoCal.data(i) = 0.00014016
    i = i + 1: gMonoCal.data(i) = 0.00013996
    i = i + 1: gMonoCal.data(i) = 0.000139261
    i = i + 1: gMonoCal.data(i) = 0.00013996
    i = i + 1: gMonoCal.data(i) = 0.000139161
    i = i + 1: gMonoCal.data(i) = 0.000139161
    i = i + 1: gMonoCal.data(i) = 0.000138661
    i = i + 1: gMonoCal.data(i) = 0.000138561
    i = i + 1: gMonoCal.data(i) = 0.000138362
    i = i + 1: gMonoCal.data(i) = 0.000138461
    i = i + 1: gMonoCal.data(i) = 0.000137762
    i = i + 1: gMonoCal.data(i) = 0.000137662
    i = i + 1: gMonoCal.data(i) = 0.000137462
    i = i + 1: gMonoCal.data(i) = 0.000137462
    i = i + 1: gMonoCal.data(i) = 0.000136963
    i = i + 1: gMonoCal.data(i) = 0.000137562
    i = i + 1: gMonoCal.data(i) = 0.000137263
    i = i + 1: gMonoCal.data(i) = 0.000137362
    i = i + 1: gMonoCal.data(i) = 0.000136663
    i = i + 1: gMonoCal.data(i) = 0.000137163
    i = i + 1: gMonoCal.data(i) = 0.000137063
    i = i + 1: gMonoCal.data(i) = 0.000137362
    i = i + 1: gMonoCal.data(i) = 0.000137063
    i = i + 1: gMonoCal.data(i) = 0.000137063
    i = i + 1: gMonoCal.data(i) = 0.000137163
    i = i + 1: gMonoCal.data(i) = 0.000137562
    i = i + 1: gMonoCal.data(i) = 0.000137862
    i = i + 1: gMonoCal.data(i) = 0.000137762
    i = i + 1: gMonoCal.data(i) = 0.000138162
    i = i + 1: gMonoCal.data(i) = 0.000138162
    i = i + 1: gMonoCal.data(i) = 0.000138262
    i = i + 1: gMonoCal.data(i) = 0.000138262
    i = i + 1: gMonoCal.data(i) = 0.000139261
    i = i + 1: gMonoCal.data(i) = 0.000139061
    i = i + 1: gMonoCal.data(i) = 0.00013986
    i = i + 1: gMonoCal.data(i) = 0.00014026
    i = i + 1: gMonoCal.data(i) = 0.000140659
    i = i + 1: gMonoCal.data(i) = 0.000140859
    i = i + 1: gMonoCal.data(i) = 0.000140959
    i = i + 1: gMonoCal.data(i) = 0.000140959
    i = i + 1: gMonoCal.data(i) = 0.000141259
    i = i + 1: gMonoCal.data(i) = 0.000141958
    i = i + 1: gMonoCal.data(i) = 0.000142158
    i = i + 1: gMonoCal.data(i) = 0.000142857
    i = i + 1: gMonoCal.data(i) = 0.000143856
    i = i + 1: gMonoCal.data(i) = 0.000143456
    i = i + 1: gMonoCal.data(i) = 0.000144955
    i = i + 1: gMonoCal.data(i) = 0.000144855
    i = i + 1: gMonoCal.data(i) = 0.000145654
    i = i + 1: gMonoCal.data(i) = 0.000145954
    i = i + 1: gMonoCal.data(i) = 0.000146353
    i = i + 1: gMonoCal.data(i) = 0.000146853
    i = i + 1: gMonoCal.data(i) = 0.000148052
    i = i + 1: gMonoCal.data(i) = 0.000147652
    i = i + 1: gMonoCal.data(i) = 0.000148851
    i = i + 1: gMonoCal.data(i) = 0.000149351
    i = i + 1: gMonoCal.data(i) = 0.00014955
    i = i + 1: gMonoCal.data(i) = 0.00015025
    i = i + 1: gMonoCal.data(i) = 0.000150849
    i = i + 1: gMonoCal.data(i) = 0.000151548
    i = i + 1: gMonoCal.data(i) = 0.000152347
    i = i + 1: gMonoCal.data(i) = 0.000152847
    i = i + 1: gMonoCal.data(i) = 0.000153347
    i = i + 1: gMonoCal.data(i) = 0.000154046
    i = i + 1: gMonoCal.data(i) = 0.000154345
    i = i + 1: gMonoCal.data(i) = 0.000155644
    i = i + 1: gMonoCal.data(i) = 0.000156343
    i = i + 1: gMonoCal.data(i) = 0.000156443
    i = i + 1: gMonoCal.data(i) = 0.000157043
    i = i + 1: gMonoCal.data(i) = 0.000157642
    i = i + 1: gMonoCal.data(i) = 0.000158741
    i = i + 1: gMonoCal.data(i) = 0.000159041
    i = i + 1: gMonoCal.data(i) = 0.00015964
    i = i + 1: gMonoCal.data(i) = 0.00016014
    i = i + 1: gMonoCal.data(i) = 0.000161139
    i = i + 1: gMonoCal.data(i) = 0.000161438
    i = i + 1: gMonoCal.data(i) = 0.000162437
    i = i + 1: gMonoCal.data(i) = 0.000163237
    i = i + 1: gMonoCal.data(i) = 0.000163836
    i = i + 1: gMonoCal.data(i) = 0.000164336
    i = i + 1: gMonoCal.data(i) = 0.000165135
    i = i + 1: gMonoCal.data(i) = 0.000165334
    i = i + 1: gMonoCal.data(i) = 0.000166134
    i = i + 1: gMonoCal.data(i) = 0.000166933
    i = i + 1: gMonoCal.data(i) = 0.000167432
    i = i + 1: gMonoCal.data(i) = 0.000167932
    i = i + 1: gMonoCal.data(i) = 0.000167932
    i = i + 1: gMonoCal.data(i) = 0.000169231
    i = i + 1: gMonoCal.data(i) = 0.00016983
    i = i + 1: gMonoCal.data(i) = 0.00017023
    i = i + 1: gMonoCal.data(i) = 0.000170829
    i = i + 1: gMonoCal.data(i) = 0.000171628
    i = i + 1: gMonoCal.data(i) = 0.000171428
    i = i + 1: gMonoCal.data(i) = 0.000172527
    i = i + 1: gMonoCal.data(i) = 0.000173227
    i = i + 1: gMonoCal.data(i) = 0.000173227
    i = i + 1: gMonoCal.data(i) = 0.000174226
    i = i + 1: gMonoCal.data(i) = 0.000174825
    i = i + 1: gMonoCal.data(i) = 0.000174925
    i = i + 1: gMonoCal.data(i) = 0.000175624
    i = i + 1: gMonoCal.data(i) = 0.000175924
    i = i + 1: gMonoCal.data(i) = 0.000176324
    i = i + 1: gMonoCal.data(i) = 0.000176623
    i = i + 1: gMonoCal.data(i) = 0.000177822
    i = i + 1: gMonoCal.data(i) = 0.000177922
    i = i + 1: gMonoCal.data(i) = 0.000178521
    i = i + 1: gMonoCal.data(i) = 0.000178621
    i = i + 1: gMonoCal.data(i) = 0.00017952
    i = i + 1: gMonoCal.data(i) = 0.00018012
    i = i + 1: gMonoCal.data(i) = 0.00017982
    i = i + 1: gMonoCal.data(i) = 0.00018022
    i = i + 1: gMonoCal.data(i) = 0.000180819
    i = i + 1: gMonoCal.data(i) = 0.000180919
    i = i + 1: gMonoCal.data(i) = 0.000181318
    i = i + 1: gMonoCal.data(i) = 0.000181618
    i = i + 1: gMonoCal.data(i) = 0.000181818
    i = i + 1: gMonoCal.data(i) = 0.000183117
    i = i + 1: gMonoCal.data(i) = 0.000182717
    i = i + 1: gMonoCal.data(i) = 0.000183616
    i = i + 1: gMonoCal.data(i) = 0.000183616
    i = i + 1: gMonoCal.data(i) = 0.000184315
    i = i + 1: gMonoCal.data(i) = 0.000184016
    i = i + 1: gMonoCal.data(i) = 0.000184515
    i = i + 1: gMonoCal.data(i) = 0.000184216
    i = i + 1: gMonoCal.data(i) = 0.000184515
    i = i + 1: gMonoCal.data(i) = 0.000185315
    i = i + 1: gMonoCal.data(i) = 0.000185414
    i = i + 1: gMonoCal.data(i) = 0.000186014
    i = i + 1: gMonoCal.data(i) = 0.000185814
    i = i + 1: gMonoCal.data(i) = 0.000186014
    i = i + 1: gMonoCal.data(i) = 0.000186413
    i = i + 1: gMonoCal.data(i) = 0.000186913
    i = i + 1: gMonoCal.data(i) = 0.000186613
    i = i + 1: gMonoCal.data(i) = 0.000187013
    i = i + 1: gMonoCal.data(i) = 0.000187812
    i = i + 1: gMonoCal.data(i) = 0.000187213
    i = i + 1: gMonoCal.data(i) = 0.000187712
    i = i + 1: gMonoCal.data(i) = 0.000188112
    i = i + 1: gMonoCal.data(i) = 0.000188511
    i = i + 1: gMonoCal.data(i) = 0.000188711
    i = i + 1: gMonoCal.data(i) = 0.000189311
    i = i + 1: gMonoCal.data(i) = 0.000188811
    i = i + 1: gMonoCal.data(i) = 0.000189211
    i = i + 1: gMonoCal.data(i) = 0.00018961
    i = i + 1: gMonoCal.data(i) = 0.000189211
    i = i + 1: gMonoCal.data(i) = 0.000189111
    i = i + 1: gMonoCal.data(i) = 0.00018951
    i = i + 1: gMonoCal.data(i) = 0.00018951
    i = i + 1: gMonoCal.data(i) = 0.00018971
    i = i + 1: gMonoCal.data(i) = 0.00018981
    i = i + 1: gMonoCal.data(i) = 0.000190309
    i = i + 1: gMonoCal.data(i) = 0.00018991
    i = i + 1: gMonoCal.data(i) = 0.000190409
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.000190709
    i = i + 1: gMonoCal.data(i) = 0.000190609
    i = i + 1: gMonoCal.data(i) = 0.000190709
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.000190909
    i = i + 1: gMonoCal.data(i) = 0.000190409
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.000190909
    i = i + 1: gMonoCal.data(i) = 0.000190709
    i = i + 1: gMonoCal.data(i) = 0.00018991
    i = i + 1: gMonoCal.data(i) = 0.000190309
    i = i + 1: gMonoCal.data(i) = 0.000190909
    i = i + 1: gMonoCal.data(i) = 0.00019011
    i = i + 1: gMonoCal.data(i) = 0.000190509
    i = i + 1: gMonoCal.data(i) = 0.00019021
    i = i + 1: gMonoCal.data(i) = 0.000190609
    i = i + 1: gMonoCal.data(i) = 0.000190409
    i = i + 1: gMonoCal.data(i) = 0.00018981
    i = i + 1: gMonoCal.data(i) = 0.00018981
    i = i + 1: gMonoCal.data(i) = 0.00019001
    i = i + 1: gMonoCal.data(i) = 0.00018971
    i = i + 1: gMonoCal.data(i) = 0.000190509
    i = i + 1: gMonoCal.data(i) = 0.00019001
    i = i + 1: gMonoCal.data(i) = 0.00018981
    i = i + 1: gMonoCal.data(i) = 0.00018951
    i = i + 1: gMonoCal.data(i) = 0.00018961
    i = i + 1: gMonoCal.data(i) = 0.000189311
    i = i + 1: gMonoCal.data(i) = 0.000189011
    i = i + 1: gMonoCal.data(i) = 0.000188511
    i = i + 1: gMonoCal.data(i) = 0.00018951
    i = i + 1: gMonoCal.data(i) = 0.000189211
    i = i + 1: gMonoCal.data(i) = 0.000188212
    i = i + 1: gMonoCal.data(i) = 0.000188212
    i = i + 1: gMonoCal.data(i) = 0.000188012
    i = i + 1: gMonoCal.data(i) = 0.000187313
    i = i + 1: gMonoCal.data(i) = 0.000188311
    i = i + 1: gMonoCal.data(i) = 0.000187213
    i = i + 1: gMonoCal.data(i) = 0.000186014
    i = i + 1: gMonoCal.data(i) = 0.000185914
    i = i + 1: gMonoCal.data(i) = 0.000187313
    i = i + 1: gMonoCal.data(i) = 0.000185514
    i = i + 1: gMonoCal.data(i) = 0.000187013
    i = i + 1: gMonoCal.data(i) = 0.000185414
    i = i + 1: gMonoCal.data(i) = 0.000186513
    i = i + 1: gMonoCal.data(i) = 0.000184515
    i = i + 1: gMonoCal.data(i) = 0.000184415
    i = i + 1: gMonoCal.data(i) = 0.000183916
    i = i + 1: gMonoCal.data(i) = 0.000184116
    i = i + 1: gMonoCal.data(i) = 0.000184415
    i = i + 1: gMonoCal.data(i) = 0.000183416
    i = i + 1: gMonoCal.data(i) = 0.000184016
    i = i + 1: gMonoCal.data(i) = 0.000184415
    i = i + 1: gMonoCal.data(i) = 0.000183416
    i = i + 1: gMonoCal.data(i) = 0.000183117
    i = i + 1: gMonoCal.data(i) = 0.000183017
    i = i + 1: gMonoCal.data(i) = 0.000182517
    i = i + 1: gMonoCal.data(i) = 0.000180419
    i = i + 1: gMonoCal.data(i) = 0.000180519
    i = i + 1: gMonoCal.data(i) = 0.00018012
    i = i + 1: gMonoCal.data(i) = 0.000181019
    i = i + 1: gMonoCal.data(i) = 0.000181119
    i = i + 1: gMonoCal.data(i) = 0.000179021
    i = i + 1: gMonoCal.data(i) = 0.000178721
    i = i + 1: gMonoCal.data(i) = 0.00018022
    i = i + 1: gMonoCal.data(i) = 0.000177822
    i = i + 1: gMonoCal.data(i) = 0.000177422
    i = i + 1: gMonoCal.data(i) = 0.000177322
    i = i + 1: gMonoCal.data(i) = 0.000179221
    i = i + 1: gMonoCal.data(i) = 0.000175924
    i = i + 1: gMonoCal.data(i) = 0.000175524
    i = i + 1: gMonoCal.data(i) = 0.000175025
    i = i + 1: gMonoCal.data(i) = 0.000177422
    i = i + 1: gMonoCal.data(i) = 0.000174725
    i = i + 1: gMonoCal.data(i) = 0.000174126
    i = i + 1: gMonoCal.data(i) = 0.000176423
    i = i + 1: gMonoCal.data(i) = 0.000175824
    i = i + 1: gMonoCal.data(i) = 0.000176324
    i = i + 1: gMonoCal.data(i) = 0.000175125
    i = i + 1: gMonoCal.data(i) = 0.000175324
    i = i + 1: gMonoCal.data(i) = 0.000174725
    i = i + 1: gMonoCal.data(i) = 0.000171129
    i = i + 1: gMonoCal.data(i) = 0.000174026
    i = i + 1: gMonoCal.data(i) = 0.000174026
    i = i + 1: gMonoCal.data(i) = 0.00017003
    i = i + 1: gMonoCal.data(i) = 0.000173027
    i = i + 1: gMonoCal.data(i) = 0.00016983
    i = i + 1: gMonoCal.data(i) = 0.000172328
    i = i + 1: gMonoCal.data(i) = 0.000169031
    i = i + 1: gMonoCal.data(i) = 0.000172028
    i = i + 1: gMonoCal.data(i) = 0.000167732
    i = i + 1: gMonoCal.data(i) = 0.000170529
    i = i + 1: gMonoCal.data(i) = 0.00016943
    i = i + 1: gMonoCal.data(i) = 0.000166433
    i = i + 1: gMonoCal.data(i) = 0.000168731
    i = i + 1: gMonoCal.data(i) = 0.000169031
    i = i + 1: gMonoCal.data(i) = 0.000168731
    i = i + 1: gMonoCal.data(i) = 0.000168931
    i = i + 1: gMonoCal.data(i) = 0.000165534
    i = i + 1: gMonoCal.data(i) = 0.000169131
    i = i + 1: gMonoCal.data(i) = 0.000166533
    i = i + 1: gMonoCal.data(i) = 0.000168332
    i = i + 1: gMonoCal.data(i) = 0.000165135
    i = i + 1: gMonoCal.data(i) = 0.000165334
    i = i + 1: gMonoCal.data(i) = 0.000167832
    i = i + 1: gMonoCal.data(i) = 0.000167332
    i = i + 1: gMonoCal.data(i) = 0.000164136
    i = i + 1: gMonoCal.data(i) = 0.000166933
    i = i + 1: gMonoCal.data(i) = 0.000166733
    i = i + 1: gMonoCal.data(i) = 0.000163936
    i = i + 1: gMonoCal.data(i) = 0.000163436
    i = i + 1: gMonoCal.data(i) = 0.000165434
    i = i + 1: gMonoCal.data(i) = 0.000165235
    i = i + 1: gMonoCal.data(i) = 0.000162138
    i = i + 1: gMonoCal.data(i) = 0.000161738
    i = i + 1: gMonoCal.data(i) = 0.000164036
    i = i + 1: gMonoCal.data(i) = 0.000163936
    i = i + 1: gMonoCal.data(i) = 0.000163436
    i = i + 1: gMonoCal.data(i) = 0.000163936
    i = i + 1: gMonoCal.data(i) = 0.000163037
    i = i + 1: gMonoCal.data(i) = 0.000162737
    i = i + 1: gMonoCal.data(i) = 0.000162537
    i = i + 1: gMonoCal.data(i) = 0.000161938
    i = i + 1: gMonoCal.data(i) = 0.000158741
    i = i + 1: gMonoCal.data(i) = 0.000158042
    i = i + 1: gMonoCal.data(i) = 0.000161338
    i = i + 1: gMonoCal.data(i) = 0.000160539
    i = i + 1: gMonoCal.data(i) = 0.000157043
    i = i + 1: gMonoCal.data(i) = 0.00015994
    i = i + 1: gMonoCal.data(i) = 0.00016024
    
    i = (555 - gMonoCal.start) / gMonoCal.step
    gMonoCal.data555 = gMonoCal.data(i)

End Sub

