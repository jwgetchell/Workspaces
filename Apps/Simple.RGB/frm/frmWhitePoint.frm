VERSION 5.00
Begin VB.Form frmWhitePoint 
   Caption         =   "sRGB:Source"
   ClientHeight    =   4290
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4695
   Icon            =   "frmWhitePoint.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   4290
   ScaleWidth      =   4695
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdSetGrey 
      Caption         =   "Set Grey"
      Height          =   255
      Left            =   0
      TabIndex        =   20
      Top             =   720
      Width           =   1095
   End
   Begin VB.CommandButton cmdCalibrate 
      Caption         =   "Calibrate"
      Height          =   255
      Left            =   0
      TabIndex        =   19
      Top             =   480
      Width           =   1095
   End
   Begin VB.Frame Frame2 
      Caption         =   "Hidden"
      Height          =   1695
      Left            =   1920
      TabIndex        =   16
      Top             =   1800
      Visible         =   0   'False
      Width           =   1575
      Begin VB.Timer tmrCalRGB 
         Enabled         =   0   'False
         Interval        =   1000
         Left            =   840
         Top             =   840
      End
      Begin VB.CheckBox cbFromDut 
         Caption         =   "DUT:OFF"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   18
         Top             =   480
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.TextBox tbRGB 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   3
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   17
         Text            =   "frmWhitePoint.frx":324A
         Top             =   240
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Timer tmrLoopSrgb 
         Enabled         =   0   'False
         Interval        =   10
         Left            =   240
         Top             =   840
      End
   End
   Begin VB.CheckBox cbLoopBorder 
      Caption         =   "Loop:OFF"
      Height          =   255
      Left            =   0
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   240
      Width           =   1095
   End
   Begin VB.Frame Frame1 
      Caption         =   "Colors"
      Height          =   2295
      Left            =   0
      TabIndex        =   7
      Top             =   960
      Width           =   1095
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H007A7A7A&
         Caption         =   "Grey"
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   21
         Top             =   1920
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H00FFFFFF&
         Caption         =   "White"
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   14
         Top             =   1680
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H0000FFFF&
         Caption         =   "Yellow"
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   13
         Top             =   1440
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H00FF00FF&
         Caption         =   "Magenta"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   12
         Top             =   1200
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H00FFFF00&
         Caption         =   "Cyan"
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   11
         Top             =   960
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H00FF0000&
         Caption         =   "Blue"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   10
         Top             =   720
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H0000FF00&
         Caption         =   "Green"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   9
         Top             =   480
         Width           =   855
      End
      Begin VB.CommandButton cmdSetColor 
         BackColor       =   &H000000FF&
         Caption         =   "Red"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   8
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.HScrollBar hscRGB 
      Height          =   135
      Index           =   3
      LargeChange     =   50
      Left            =   1080
      Max             =   1000
      TabIndex        =   6
      Top             =   360
      Visible         =   0   'False
      Width           =   3615
   End
   Begin VB.HScrollBar hscRGB 
      Height          =   135
      Index           =   2
      LargeChange     =   16
      Left            =   1080
      Max             =   255
      TabIndex        =   5
      Top             =   240
      Width           =   3615
   End
   Begin VB.HScrollBar hscRGB 
      Height          =   135
      Index           =   1
      LargeChange     =   16
      Left            =   1080
      Max             =   255
      TabIndex        =   4
      Top             =   120
      Width           =   3615
   End
   Begin VB.HScrollBar hscRGB 
      Height          =   135
      Index           =   0
      LargeChange     =   16
      Left            =   1080
      Max             =   255
      TabIndex        =   3
      Top             =   0
      Width           =   3615
   End
   Begin VB.TextBox tbRGB 
      Alignment       =   2  'Center
      Height          =   285
      Index           =   2
      Left            =   720
      MultiLine       =   -1  'True
      TabIndex        =   2
      Text            =   "frmWhitePoint.frx":324E
      Top             =   0
      Width           =   375
   End
   Begin VB.TextBox tbRGB 
      Alignment       =   2  'Center
      Height          =   285
      Index           =   1
      Left            =   360
      MultiLine       =   -1  'True
      TabIndex        =   1
      Text            =   "frmWhitePoint.frx":3252
      Top             =   0
      Width           =   375
   End
   Begin VB.TextBox tbRGB 
      Alignment       =   2  'Center
      Height          =   285
      Index           =   0
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "frmWhitePoint.frx":3256
      Top             =   0
      Width           =   375
   End
End
Attribute VB_Name = "frmWhitePoint"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim form_width As Integer
Dim luminance As Single
Dim xLast As Single, yLast As Single, uvLast As Boolean

Public oExcel As Excel.Application
Public oBook As Excel.Workbook
Public oSheet As Excel.Worksheet

Dim leg As Integer

Private Sub cmdSetGrey_Click()
    Dim xyz(2) As Double, RGB(2) As Double, i As Integer
    
    XYZ2sRGB xyz, RGB, 0 'clear 1st (zero values)
    cmdSetColor_Click 7
    
    For i = 0 To 31
        Sleep 100: DoEvents
    Next i
    
    For i = 0 To 2
        xyz(i) = frmSimpleRGB.getMeas(values.vXX + i)
    Next i
    
    XYZ2sRGB xyz, RGB, 1 ' set
    
End Sub

Private Sub Form_Load()
    form_width = Width - hscRGB(0).Width
    luminance = 1#
    tbRGB(3).text = luminance & vbCr
    
End Sub

Private Sub cbFromDut_Click()
    If cbFromDut.value = vbChecked Then
        cbFromDut.caption = "DUT:ON"
    Else
        cbFromDut.caption = "DUT:OFF"
    End If
End Sub

Private Sub cbLoopBorder_Click()
    If cbLoopBorder.value = vbChecked Then
        cbLoopBorder.caption = "Loop:ON"
        leg = 0: cmdSetColor_Click 0
        frmSimpleRGB.setMPAtrip 20
        tmrLoopSrgb.enabled = True
    Else
        cbLoopBorder.caption = "Loop:OFF"
        frmSimpleRGB.resetMPAtrip
        tmrLoopSrgb.enabled = False
    End If
End Sub

Private Sub cmdSetColor_Click(Index As Integer)
    Dim colorIn As Long: colorIn = cmdSetColor(Index).BackColor
    hscRGB(0).value = colorIn And &HFF: colorIn = (colorIn - hscRGB(0).value) / 256
    hscRGB(1).value = colorIn And &HFF: colorIn = (colorIn - hscRGB(1).value) / 256
    hscRGB(2).value = colorIn And &HFF
    'frmWhitePoint.BackColor = cmdSetColor(Index).BackColor
End Sub

Private Sub Form_Resize()
    Dim i As Integer
    For i = 0 To 3
        hscRGB(i).Width = Width - form_width
    Next i
End Sub

Public Sub setWhitePointBackColor(ByVal X As Single, ByVal Y As Single, Optional ByVal useUV As Boolean = False, Optional ByVal fromDUT As Boolean = False)

    Dim x0 As Single, y0 As Single, Z As Single
    
    On Error Resume Next
    
    xLast = X: yLast = Y: uvLast = useUV
    
    If fromDUT And cbFromDut.value = vbUnchecked Then Exit Sub
    
    If useUV Then ' convert to xy
        x0 = getXfromUV(X, Y): y0 = getYfromUV(X, Y)
        X = x0: Y = y0
    End If
    
    x0 = getXYZ(50, X, Y, 0): y0 = getXYZ(50, X, Y, 1): Z = getXYZ(50, X, Y, 2)
    X = x0: Y = y0
    
    If X >= 0 And Y >= 0 And Z >= 0 Then
    
        Dim i As Integer, max As Single, r As Integer, G As Integer, B As Integer
        Dim matrix(2, 3) As Single, row(2) As Single, col(2) As Single
        
        col(0) = X: col(1) = Y: col(2) = Z
        
        Select Case 2
            Case 0: For i = 0 To 2: matrix(i, i) = 1: Next i
            Case 1: get_sRGBD50_XYZtoRGB matrix
            Case 2: get_sRGBD65_XYZtoRGB matrix
            Case 3: get_panel_XYZtoRGB matrix
        End Select
        
        matrixMultiply row, col, matrix
        
        
        ' scale to fullscale
        max = row(0)
        If max < row(1) Then max = row(1)
        If max < row(2) Then max = row(2)
        
        For i = 0 To 2
            If row(i) < 0 Then
                row(i) = 0
            Else
                row(i) = row(i) / max
            End If
            row(i) = 255 * (1.055 * row(i) ^ (1 / 2.4) - 0.055)
            tbRGB(i).text = row(i) & vbCr
        Next i
        
'        ' adjust power based on luminance
'        For i = 0 To 2
'            row(i) = Int(255 * row(i) * luminance ^ 0.5 / max)
'            tbRGB(i).text = row(i) & vbCr
'        Next i
        
    End If
    
    
End Sub

Private Sub hscRGB_Change(Index As Integer)

    Dim max As Integer, i As Integer
    
    If Index < 3 Then
        tbRGB(Index).text = hscRGB(Index).value
        frmWhitePoint.BackColor = hscRGB(0).value + hscRGB(1).value * (2 ^ 8) + hscRGB(2).value * (2 ^ 16)
        
'        max = hscRGB(0).value
'        For i = 1 To 2
'            If max < hscRGB(i).value Then max = hscRGB(i).value
'        Next i
'        luminance = (max / 255) ^ 2: tbRGB(3).text = luminance & vbCr
        
    Else
        tbRGB(Index).text = Format(hscRGB(Index).value / 1000#, ".000")
        luminance = val(tbRGB(Index).text)
        setWhitePointBackColor xLast, yLast, uvLast
    End If

End Sub

Private Sub tbRGB_Change(Index As Integer)
    
If enterText(tbRGB(Index).text) Then

        On Error GoTo onError
        
        If Index < 3 Then
            hscRGB(Index).value = val(tbRGB(Index).text)
        Else
            hscRGB(Index).value = val(tbRGB(Index).text) * 1000
        End If
    
    'GoTo endSub
    
onError:

    If Index < 3 Then
        tbRGB(Index).text = hscRGB(Index).value
    Else
        tbRGB(Index).text = Format(hscRGB(Index).value / 1000#, ".000")
    End If
    
    End If

endSub: End Sub

Private Sub cmdCalibrate_Click()

    Set oExcel = New Excel.Application
    Set oBook = oExcel.Workbooks.Add
    Set oSheet = oBook.Worksheets(1)

    frmSimpleRGB.clrSrgbMtrx2
    cmdSetColor_Click 0
    cbLoopBorder.value = vbUnchecked: cbLoopBorder_Click
    frmSimpleRGB.cbCCMselect = vbChecked
    frmSimpleRGB.cbFilter = vbChecked
    tmrCalRGB.Interval = 5000
    tmrCalRGB.enabled = True
End Sub

Private Sub tmrCalRGB_Timer()

    Static calColor As Integer, m(2, 3) As Double
    Dim X As Double, Y As Double, Z As Double, x0 As Double, y0 As Double
    Dim cX As Variant, cY As Variant, cZ As Variant
    Dim i As Integer
    
    ' measured values
    For i = 0 To 2
        oSheet.Cells(calColor + 1, 4 + i) = frmSimpleRGB.getMeas(values.vRed + i)
    Next i
    
    ' target values
    '0.6400  0.3300 Red
    '0.3000  0.6000 Green
    '0.1500  0.0600 Blue
    '0.2246  0.3287 Cyan
    '0.3209  0.1542 Magenta
    '0.4193  0.5053 Yellow
    '0.3127  0.3290 Grey
    
    Select Case calColor
    
    Case 0: x0 = 0.64:   y0 = 0.33:   Y = 0.2126
    Case 1: x0 = 0.3:    y0 = 0.6:    Y = 0.7152
    Case 2: x0 = 0.15:   y0 = 0.06:   Y = 0.0722
    
    Case 3: x0 = 0.2246: y0 = 0.3287: Y = 0.7874
    Case 4: x0 = 0.3209: y0 = 0.1542: Y = 0.2848
    Case 5: x0 = 0.4193: y0 = 0.5053: Y = 0.9278
    
    Case 6: x0 = 0.3127: y0 = 0.329:  Y = 1
    
    End Select
    
    X = Y * x0 / y0
    Z = Y * (1 - x0 - y0) / y0
    
    oSheet.Cells(calColor + 1, 1) = X
    oSheet.Cells(calColor + 1, 2) = Y
    oSheet.Cells(calColor + 1, 3) = Z
    
    ' next
    calColor = calColor + 1
    cmdSetColor_Click calColor
    
    If calColor = 7 Then
        ' stop (Grey)
        cmdSetColor_Click calColor
        tmrCalRGB.enabled = False
        calColor = 0
        ' result
        cX = Application.LinEst(oSheet.range("A1:A7"), oSheet.range("D1:F7"), False, False)
        cY = Application.LinEst(oSheet.range("B1:B7"), oSheet.range("D1:F7"), False, False)
        cZ = Application.LinEst(oSheet.range("C1:C7"), oSheet.range("D1:F7"), False, False)
        For i = 0 To 2
            m(0, i) = cX(3 - i): m(1, i) = cY(3 - i): m(2, i) = cZ(3 - i)
        Next i
        m(0, i) = cX(i + 1): m(1, i) = cY(i + 1): m(2, i) = cZ(i + 1)
        frmSimpleRGB.setSrgbMtrx2 m
        oExcel.Application.DisplayAlerts = False
        'oBook.SaveAs ("C:\CVSROOT\ALS_(ambient_light_sensors)\Software\Workspaces.devel\Apps\Simple.RGB\junk.xls")
        Set Sheet = Nothing: Set oBook = Nothing
        oExcel.ActiveWorkbook.Close: Set oExcel = Nothing
        cmdSetGrey_Click
        cbLoopBorder.value = vbChecked: cbLoopBorder_Click
        frmSimpleRGB.cmbDisplay.ListIndex = 1
        'frmSimpleRGB.cbCCMselect.enabled = True
        frmSimpleRGB.ucBarGraph_sRGB_setCaption = "sRGB"
        frmSimpleRGB.ucBarGraph_sRGB.setCaption frmSimpleRGB.ucBarGraph_sRGB_setCaption
    End If
End Sub

Private Sub tmrLoopSrgb_Timer()
    ' start: red
    ' goto green: increase green,decrease red
    ' goto blue:increase blue,decrease green
    ' goto red:increase red, decrease blue
    Static Index As Integer, inc As Integer, stp As Integer
    
    On Error Resume Next
    
    If stp = 0 Then stp = 3
    If inc = 0 Then inc = 1
    tmrLoopSrgb.Interval = 200
    
    Select Case leg
        Case 0: Index = 2: inc = 1  'red to magenta:  increase blue
        Case 1: Index = 0: inc = -1 'magenta to blue: decrease red
        Case 2: Index = 1: inc = 1  'blue to yellow:  increase green
        Case 3: Index = 2: inc = -1 'yellow to green: decrease blue
        Case 4: Index = 0: inc = 1  'green to cyan:   increase red
        Case 5: Index = 1: inc = -1 'cyan to red:     decrease green
    End Select
    
    
    hscRGB(Index).value = hscRGB(Index).value + inc * stp
    If inc < 0 And hscRGB(Index).value = hscRGB(Index).min Then leg = (leg + 1) Mod 6
    If inc > 0 And hscRGB(Index).value = hscRGB(Index).max Then leg = (leg + 1) Mod 6
        
End Sub
