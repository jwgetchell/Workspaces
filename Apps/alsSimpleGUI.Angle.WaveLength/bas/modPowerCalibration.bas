Attribute VB_Name = "modPowerCalibration"
Dim gCalLedVal(0) As Single, gCalFwVal(35) As Single

Public Function getFWset(attn As Single) As Integer

    Dim i As Integer, j As Integer
    If gCalFwVal(35) <> 0 Then GoTo skipLoad
    
i = i + 0: gCalFwVal(i) = 1
i = i + 1: gCalFwVal(i) = 0.824778583
i = i + 1: gCalFwVal(i) = 0.688182517
i = i + 1: gCalFwVal(i) = 0.568622109
i = i + 1: gCalFwVal(i) = 0.419165149
i = i + 1: gCalFwVal(i) = 0.314606017
i = i + 1: gCalFwVal(i) = 0.252455577
i = i + 1: gCalFwVal(i) = 0.208087364
i = i + 1: gCalFwVal(i) = 0.173676068
i = i + 1: gCalFwVal(i) = 0.143368928
i = i + 1: gCalFwVal(i) = 0.10537608
i = i + 1: gCalFwVal(i) = 0.094693444
i = i + 1: gCalFwVal(i) = 0.079142446
i = i + 1: gCalFwVal(i) = 0.078171126
i = i + 1: gCalFwVal(i) = 0.065167456
i = i + 1: gCalFwVal(i) = 0.053730521
i = i + 1: gCalFwVal(i) = 0.039513614
i = i + 1: gCalFwVal(i) = 0.029781149
i = i + 1: gCalFwVal(i) = 0.006540357
i = i + 1: gCalFwVal(i) = 0.005390012
i = i + 1: gCalFwVal(i) = 0.004499047
i = i + 1: gCalFwVal(i) = 0.003716979
i = i + 1: gCalFwVal(i) = 0.002725685
i = i + 1: gCalFwVal(i) = 0.002058314
i = i + 1: gCalFwVal(i) = 0.000672543
i = i + 1: gCalFwVal(i) = 0.000553051
i = i + 1: gCalFwVal(i) = 0.000460975
i = i + 1: gCalFwVal(i) = 0.00038012
i = i + 1: gCalFwVal(i) = 0.000277988
i = i + 1: gCalFwVal(i) = 0.000207946
i = i + 1: gCalFwVal(i) = 0.000046245
i = i + 1: gCalFwVal(i) = 0.0000369697
i = i + 1: gCalFwVal(i) = 0.0000298434
i = i + 1: gCalFwVal(i) = 0.0000235959
i = i + 1: gCalFwVal(i) = 0.0000156804
i = i + 1: gCalFwVal(i) = 0.0000102405

skipLoad:
    i = 0: j = UBound(gCalFwVal) / 2
    While j > 0
        If attn < gCalFwVal(i + j) Then i = i + j
        j = j / 2
    Wend
    getFWset = i
    attn = attn / gCalFwVal(i)
    
End Function

Public Function getVLEDset(attn As Single, Optional LargeChange As Integer = 1) As Single

    Dim i As Integer, j As Integer
    Dim f As Single
    
    If LargeChange < 1 Then LargeChange = 1
    
    If gCalLedVal(UBound(gCalLedVal)) <> 0 Then GoTo skipLoad
    
'i = i + 0: gCalLedVal(i) = 0.393815427
'i = i + 1: gCalLedVal(i) = 0.399998186
'i = i + 1: gCalLedVal(i) = 0.405240471
'i = i + 1: gCalLedVal(i) = 0.409839403
'i = i + 1: gCalLedVal(i) = 0.414198863
'i = i + 1: gCalLedVal(i) = 0.418651087
'i = i + 1: gCalLedVal(i) = 0.422939284
'i = i + 1: gCalLedVal(i) = 0.42724772
'i = i + 1: gCalLedVal(i) = 0.431552727
'i = i + 1: gCalLedVal(i) = 0.436022075
'i = i + 1: gCalLedVal(i) = 0.440347731
'i = i + 1: gCalLedVal(i) = 0.444706863
'i = i + 1: gCalLedVal(i) = 0.44903475
'i = i + 1: gCalLedVal(i) = 0.453534801
'i = i + 1: gCalLedVal(i) = 0.457876711
'i = i + 1: gCalLedVal(i) = 0.462211355
'i = i + 1: gCalLedVal(i) = 0.466523957
'i = i + 1: gCalLedVal(i) = 0.470978871
'i = i + 1: gCalLedVal(i) = 0.475268298
'i = i + 1: gCalLedVal(i) = 0.479546326
'i = i + 1: gCalLedVal(i) = 0.483793946
'i = i + 1: gCalLedVal(i) = 0.488151339
'i = i + 1: gCalLedVal(i) = 0.492368223
'i = i + 1: gCalLedVal(i) = 0.496548533
'i = i + 1: gCalLedVal(i) = 0.500722774
'i = i + 1: gCalLedVal(i) = 0.504989764
'i = i + 1: gCalLedVal(i) = 0.509150901
'i = i + 1: gCalLedVal(i) = 0.513247909
'i = i + 1: gCalLedVal(i) = 0.517348165
'i = i + 1: gCalLedVal(i) = 0.521546139
'i = i + 1: gCalLedVal(i) = 0.525614035
'i = i + 1: gCalLedVal(i) = 0.529670664
'i = i + 1: gCalLedVal(i) = 0.533705069
'i = i + 1: gCalLedVal(i) = 0.537859366
'i = i + 1: gCalLedVal(i) = 0.54185372
'i = i + 1: gCalLedVal(i) = 0.545846368
'i = i + 1: gCalLedVal(i) = 0.549818022
'i = i + 1: gCalLedVal(i) = 0.55389607
'i = i + 1: gCalLedVal(i) = 0.557824278
'i = i + 1: gCalLedVal(i) = 0.561776234
i = i + 1: gCalLedVal(i) = 0.565692502
i = i + 1: gCalLedVal(i) = 0.569732434
i = i + 1: gCalLedVal(i) = 0.573624855
i = i + 1: gCalLedVal(i) = 0.577511994
i = i + 1: gCalLedVal(i) = 0.581397001
i = i + 1: gCalLedVal(i) = 0.585403409
i = i + 1: gCalLedVal(i) = 0.589280248
i = i + 1: gCalLedVal(i) = 0.593152676
i = i + 1: gCalLedVal(i) = 0.597056774
i = i + 1: gCalLedVal(i) = 0.601144925
i = i + 1: gCalLedVal(i) = 0.606691189
i = i + 1: gCalLedVal(i) = 0.6124157
i = i + 1: gCalLedVal(i) = 0.619755692
i = i + 1: gCalLedVal(i) = 0.621678399
i = i + 1: gCalLedVal(i) = 0.622792021
i = i + 1: gCalLedVal(i) = 0.626385416
i = i + 1: gCalLedVal(i) = 0.630471517
i = i + 1: gCalLedVal(i) = 0.634870536
i = i + 1: gCalLedVal(i) = 0.638949093
i = i + 1: gCalLedVal(i) = 0.643122088
i = i + 1: gCalLedVal(i) = 0.647194068
i = i + 1: gCalLedVal(i) = 0.651437752
i = i + 1: gCalLedVal(i) = 0.655408472
i = i + 1: gCalLedVal(i) = 0.659344781
i = i + 1: gCalLedVal(i) = 0.663247534
i = i + 1: gCalLedVal(i) = 0.667304393
i = i + 1: gCalLedVal(i) = 0.671061684
i = i + 1: gCalLedVal(i) = 0.674820812
i = i + 1: gCalLedVal(i) = 0.67860592
i = i + 1: gCalLedVal(i) = 0.682516758
i = i + 1: gCalLedVal(i) = 0.686119944
i = i + 1: gCalLedVal(i) = 0.689654688
i = i + 1: gCalLedVal(i) = 0.693295859
i = i + 1: gCalLedVal(i) = 0.697016642
i = i + 1: gCalLedVal(i) = 0.700610446
i = i + 1: gCalLedVal(i) = 0.704013456
i = i + 1: gCalLedVal(i) = 0.707485679
i = i + 1: gCalLedVal(i) = 0.711107529
i = i + 1: gCalLedVal(i) = 0.714469815
i = i + 1: gCalLedVal(i) = 0.717928146
i = i + 1: gCalLedVal(i) = 0.721279951
i = i + 1: gCalLedVal(i) = 0.724600447
i = i + 1: gCalLedVal(i) = 0.728033996
i = i + 1: gCalLedVal(i) = 0.731354295
i = i + 1: gCalLedVal(i) = 0.734701754
i = i + 1: gCalLedVal(i) = 0.737966256
i = i + 1: gCalLedVal(i) = 0.741138305
i = i + 1: gCalLedVal(i) = 0.744369972
i = i + 1: gCalLedVal(i) = 0.747540725
i = i + 1: gCalLedVal(i) = 0.750868699
i = i + 1: gCalLedVal(i) = 0.753924316
i = i + 1: gCalLedVal(i) = 0.757041995
i = i + 1: gCalLedVal(i) = 0.760083229
i = i + 1: gCalLedVal(i) = 0.763285144
i = i + 1: gCalLedVal(i) = 0.766338973
i = i + 1: gCalLedVal(i) = 0.769314651
i = i + 1: gCalLedVal(i) = 0.772442253
i = i + 1: gCalLedVal(i) = 0.775586092
i = i + 1: gCalLedVal(i) = 0.778512697
i = i + 1: gCalLedVal(i) = 0.781434087
i = i + 1: gCalLedVal(i) = 0.784466578
i = i + 1: gCalLedVal(i) = 0.787468006
i = i + 1: gCalLedVal(i) = 0.790410603
i = i + 1: gCalLedVal(i) = 0.793429104
i = i + 1: gCalLedVal(i) = 0.796263748
i = i + 1: gCalLedVal(i) = 0.799224452
i = i + 1: gCalLedVal(i) = 0.802115139
i = i + 1: gCalLedVal(i) = 0.804961625
i = i + 1: gCalLedVal(i) = 0.807804716
i = i + 1: gCalLedVal(i) = 0.81072581
i = i + 1: gCalLedVal(i) = 0.813514056
i = i + 1: gCalLedVal(i) = 0.816207453
i = i + 1: gCalLedVal(i) = 0.818990139
i = i + 1: gCalLedVal(i) = 0.82188796
i = i + 1: gCalLedVal(i) = 0.82458613
i = i + 1: gCalLedVal(i) = 0.827245479
i = i + 1: gCalLedVal(i) = 0.829957672
i = i + 1: gCalLedVal(i) = 0.832646346
i = i + 1: gCalLedVal(i) = 0.835200006
i = i + 1: gCalLedVal(i) = 0.837844102
i = i + 1: gCalLedVal(i) = 0.840468008
i = i + 1: gCalLedVal(i) = 0.843091372
i = i + 1: gCalLedVal(i) = 0.845576967
i = i + 1: gCalLedVal(i) = 0.848040224
i = i + 1: gCalLedVal(i) = 0.85049605
i = i + 1: gCalLedVal(i) = 0.853014464
i = i + 1: gCalLedVal(i) = 0.854966136
i = i + 1: gCalLedVal(i) = 0.857240287
i = i + 1: gCalLedVal(i) = 0.859429365
i = i + 1: gCalLedVal(i) = 0.861563287
i = i + 1: gCalLedVal(i) = 0.863274026
i = i + 1: gCalLedVal(i) = 0.864831332
i = i + 1: gCalLedVal(i) = 0.866373713
i = i + 1: gCalLedVal(i) = 0.867991391
i = i + 1: gCalLedVal(i) = 0.869669934
i = i + 1: gCalLedVal(i) = 0.871677206
i = i + 1: gCalLedVal(i) = 0.87407435
i = i + 1: gCalLedVal(i) = 0.876551104
i = i + 1: gCalLedVal(i) = 0.879137665
i = i + 1: gCalLedVal(i) = 0.881759766
i = i + 1: gCalLedVal(i) = 0.884478848
i = i + 1: gCalLedVal(i) = 0.887470566
i = i + 1: gCalLedVal(i) = 0.890360236
i = i + 1: gCalLedVal(i) = 0.893414377
i = i + 1: gCalLedVal(i) = 0.896398272
i = i + 1: gCalLedVal(i) = 0.899601368
i = i + 1: gCalLedVal(i) = 0.902511786
i = i + 1: gCalLedVal(i) = 0.905444099
i = i + 1: gCalLedVal(i) = 0.908339083
i = i + 1: gCalLedVal(i) = 0.911297671
i = i + 1: gCalLedVal(i) = 0.913981343
i = i + 1: gCalLedVal(i) = 0.916676069
i = i + 1: gCalLedVal(i) = 0.919313177
i = i + 1: gCalLedVal(i) = 0.921798444
i = i + 1: gCalLedVal(i) = 0.924278955
i = i + 1: gCalLedVal(i) = 0.926652546
i = i + 1: gCalLedVal(i) = 0.928840083
i = i + 1: gCalLedVal(i) = 0.931222203
i = i + 1: gCalLedVal(i) = 0.933486054
i = i + 1: gCalLedVal(i) = 0.935698636
i = i + 1: gCalLedVal(i) = 0.937924092
i = i + 1: gCalLedVal(i) = 0.940240935
i = i + 1: gCalLedVal(i) = 0.942362031
i = i + 1: gCalLedVal(i) = 0.944543122
i = i + 1: gCalLedVal(i) = 0.946697971
i = i + 1: gCalLedVal(i) = 0.948915768
i = i + 1: gCalLedVal(i) = 0.950892599
i = i + 1: gCalLedVal(i) = 0.953201603
i = i + 1: gCalLedVal(i) = 0.955110845
i = i + 1: gCalLedVal(i) = 0.957182147
i = i + 1: gCalLedVal(i) = 0.959206754
i = i + 1: gCalLedVal(i) = 0.961186702
i = i + 1: gCalLedVal(i) = 0.963224496
i = i + 1: gCalLedVal(i) = 0.965225059
i = i + 1: gCalLedVal(i) = 0.967071813
i = i + 1: gCalLedVal(i) = 0.968967179
i = i + 1: gCalLedVal(i) = 0.970723546
i = i + 1: gCalLedVal(i) = 0.972588423
i = i + 1: gCalLedVal(i) = 0.974239544
i = i + 1: gCalLedVal(i) = 0.97592883
i = i + 1: gCalLedVal(i) = 0.977640093
i = i + 1: gCalLedVal(i) = 0.979332217
i = i + 1: gCalLedVal(i) = 0.980990095
i = i + 1: gCalLedVal(i) = 0.982566442
i = i + 1: gCalLedVal(i) = 0.984179758
i = i + 1: gCalLedVal(i) = 0.985878688
i = i + 1: gCalLedVal(i) = 0.987609453
i = i + 1: gCalLedVal(i) = 0.989192935
i = i + 1: gCalLedVal(i) = 0.990373097
i = i + 1: gCalLedVal(i) = 0.991417046
i = i + 1: gCalLedVal(i) = 0.992109274
i = i + 1: gCalLedVal(i) = 0.993359894
i = i + 1: gCalLedVal(i) = 0.994522966
i = i + 1: gCalLedVal(i) = 0.995806815
i = i + 1: gCalLedVal(i) = 0.997204407
i = i + 1: gCalLedVal(i) = 0.99812994
i = i + 1: gCalLedVal(i) = 0.998721235
i = i + 1: gCalLedVal(i) = 0.998694862
i = i + 1: gCalLedVal(i) = 0.999107662
i = i + 1: gCalLedVal(i) = 0.999553831
i = i + 1: gCalLedVal(i) = 1

skipLoad:
    i = 0: j = (UBound(gCalLedVal)) / 2 + 1
    While (j > 0)
        If attn >= gCalLedVal(i + j) Then i = i + j
        j = j / 2
    Wend
    
    If LargeChange = 1 Then
        getVLEDset = i
    Else
        If i < UBound(gCalLedVal) Then ' interpolate
        
            If (gCalLedVal(i + 1) - gCalLedVal(i)) <> 0 Then
                f = (attn - gCalLedVal(i)) / (gCalLedVal(i + 1) - gCalLedVal(i))
            Else
                f = 1
            End If
            
            If f > 1 Then f = 1
            If f < 0 Then f = 0
            f = f + i
            getVLEDset = f * LargeChange
        Else
            getVLEDset = i * LargeChange
        End If
    End If
    
End Function

