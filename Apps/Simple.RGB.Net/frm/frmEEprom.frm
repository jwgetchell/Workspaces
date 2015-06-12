VERSION 5.00
Begin VB.Form frmEEprom 
   Caption         =   "EEprom"
   ClientHeight    =   3405
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8565
   ControlBox      =   0   'False
   Icon            =   "frmEEprom.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3405
   ScaleWidth      =   8565
   ShowInTaskbar   =   0   'False
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   6
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   19
      Top             =   5640
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   5
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   18
      Top             =   5280
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   4
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   17
      Top             =   4920
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   3
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   16
      Top             =   4560
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   2
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   10
      Top             =   4200
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.Frame frmHdw 
      Caption         =   "Hardware:None"
      Height          =   1095
      Left            =   0
      TabIndex        =   5
      Top             =   840
      Width           =   2415
      Begin VB.CheckBox cbByteAddr 
         Caption         =   "Addr:Word"
         Height          =   315
         Left            =   960
         Style           =   1  'Graphical
         TabIndex        =   15
         Top             =   600
         Width           =   975
      End
      Begin VB.CommandButton cmdEEpromIO 
         Caption         =   "Write"
         Enabled         =   0   'False
         Height          =   315
         Index           =   4
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   735
      End
      Begin VB.ComboBox cmbAddr 
         Height          =   315
         Left            =   960
         TabIndex        =   8
         Text            =   "0x00"
         Top             =   240
         Width           =   975
      End
      Begin VB.CommandButton cmdEEpromIO 
         Caption         =   "Read"
         Enabled         =   0   'False
         Height          =   315
         Index           =   3
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame frmFile 
      Caption         =   "File"
      Height          =   3375
      Left            =   2520
      TabIndex        =   2
      Top             =   0
      Width           =   6015
      Begin VB.CommandButton cmdEEpromIO 
         Caption         =   "Delete"
         Height          =   315
         Index           =   5
         Left            =   960
         TabIndex        =   21
         ToolTipText     =   "Delete Selected File"
         Top             =   3000
         Width           =   735
      End
      Begin VB.TextBox tbFile 
         Height          =   285
         Left            =   1800
         MultiLine       =   -1  'True
         TabIndex        =   20
         Text            =   "frmEEprom.frx":1CCA
         ToolTipText     =   "Calibration File Name"
         Top             =   3000
         Width           =   4095
      End
      Begin VB.FileListBox File1 
         Height          =   1845
         Left            =   3120
         TabIndex        =   13
         Top             =   600
         Width           =   2775
      End
      Begin VB.DirListBox Dir1 
         Height          =   1890
         Left            =   120
         TabIndex        =   12
         Top             =   600
         Width           =   2895
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   120
         TabIndex        =   11
         Top             =   240
         Width           =   5775
      End
      Begin VB.CommandButton cmdEEpromIO 
         Caption         =   "Write"
         Enabled         =   0   'False
         Height          =   315
         Index           =   2
         Left            =   120
         TabIndex        =   4
         Top             =   3000
         Width           =   735
      End
      Begin VB.CommandButton cmdEEpromIO 
         Caption         =   "Read"
         Height          =   315
         Index           =   1
         Left            =   120
         TabIndex        =   3
         Top             =   2640
         Width           =   735
      End
      Begin VB.Label lblDirectory 
         Caption         =   "01234567890123456789012345678901234567890123456789012345678901234567890123456789"
         Height          =   195
         Left            =   960
         TabIndex        =   14
         Top             =   2640
         Width           =   4935
      End
   End
   Begin VB.CommandButton cmdEEpromIO 
      Caption         =   "New"
      Height          =   615
      Index           =   0
      Left            =   0
      TabIndex        =   1
      Top             =   120
      Width           =   2415
   End
   Begin VB.TextBox txtEEprom 
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Index           =   1
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   0
      Top             =   3840
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.TextBox txtEEprom 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Index           =   0
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   9
      Top             =   3480
      Visible         =   0   'False
      Width           =   8535
   End
   Begin VB.Frame frmEMUdebug 
      Caption         =   "Gain Trim(s)"
      Height          =   1455
      Left            =   0
      TabIndex        =   22
      Top             =   1920
      Visible         =   0   'False
      Width           =   2415
      Begin VB.CommandButton cmdFuse2Reg 
         Caption         =   "Fuse --> Reg"
         Height          =   255
         Left            =   1200
         TabIndex        =   24
         Top             =   240
         Width           =   1095
      End
      Begin VB.CheckBox cbFuseReg 
         Caption         =   "Fuse"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   23
         Top             =   240
         Width           =   1095
      End
      Begin VB.Frame Frame2 
         Caption         =   "Red/Blue"
         Height          =   615
         Left            =   1200
         TabIndex        =   27
         Top             =   480
         Width           =   1095
         Begin VB.ComboBox cmbRB 
            Enabled         =   0   'False
            Height          =   315
            ItemData        =   "frmEEprom.frx":1CD6
            Left            =   120
            List            =   "frmEEprom.frx":1D0A
            TabIndex        =   28
            Text            =   "88"
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.Frame Frame1 
         Caption         =   "ALL"
         Height          =   615
         Left            =   120
         TabIndex        =   25
         Top             =   480
         Width           =   975
         Begin VB.ComboBox cmbAll 
            Enabled         =   0   'False
            Height          =   315
            ItemData        =   "frmEEprom.frx":1D44
            Left            =   120
            List            =   "frmEEprom.frx":1D78
            TabIndex        =   26
            Text            =   "88"
            Top             =   240
            Width           =   735
         End
      End
   End
End
Attribute VB_Name = "frmEEprom"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim EEprom As clsEEprom

Dim widthMin As Integer
Dim heightMin As Integer
Dim widthText As Integer
Dim heightText As Integer
Dim topFirst As Integer
Dim heightMenu As Integer

Enum eepromButtons
    cmdNew
    cmdReadFile
    cmdWriteFile
    cmdReadHdw
    cmdWriteHdw
    cmdDeleteFile
    cmdNcmds
End Enum

Dim CallBackForm As Form

Const tbTwipOffset As Integer = 70
Const tbTwipPerLineMin As Integer = 275 ' height = tbTwipPerLineMin * #/lines + tbTwipOffset
Dim tbTwipSpace As Integer
'Dim nRecords As Integer, lines() As Integer

Dim fileDrive As String
Dim fileDirectory As String
Dim fileName As String

Const ShowEMUdebug As Boolean = True
Const newDefault As Integer = eePromRevs.E004

Private Sub setFile()
    ChDir fileDirectory
    File1.Path = fileDirectory
    
    lblDirectory.caption = fileDirectory & "\"
    
    If Len(lblDirectory.caption) > 50 Then
        lblDirectory.Alignment = vbRightJustify
    Else
        lblDirectory.Alignment = vbLeftJustify
    End If
    
    If dIR(lblDirectory.caption & fileName) <> "" Then
        tbFile.text = fileName
    Else
        tbFile.text = ""
    End If

End Sub


Private Sub Drive1_Change()
    Dim parse() As String, directory As String
    parse = Split(Drive1.Drive, ":")
    fileDrive = parse(0) & ":"
    ChDir fileDrive
    Dir1.Path = fileDrive
    Dir1_Change
End Sub

Private Sub Dir1_Change()
    fileDirectory = Dir1.Path
    setFile
End Sub

Private Sub File1_Click()
    fileName = File1.fileName
    setFile
End Sub

Private Sub File1_DblClick()
    File1_Click
    cmdEEpromIO_Click eepromButtons.cmdReadFile
End Sub

Private Sub cbByteAddr_Click()
    If cbByteAddr.value = vbChecked Then
        cbByteAddr.caption = "Addr:Byte"
        EEprom.setI2c2ByteAddr True
    Else
        cbByteAddr.caption = "Addr:Word"
        EEprom.setI2c2ByteAddr False
    End If
End Sub

Public Sub setCallBackForm(cbForm As Form)
    Set CallBackForm = cbForm
End Sub

Public Sub init(prom As clsEEprom)
    Dim i As Integer, parse() As String
    
    On Error Resume Next
    
    Set EEprom = prom
    
    ' start with a default version
    EEprom.newEEprom 2
    EEprom.setTBobj txtEEprom(0)
    EEprom.setTBobj txtEEprom(1), 1
    
    i = EEprom.getI2c
    
    If i > 0 Then
        cmbAddr.text = "0x" & Hex$(i)
        cmdEEpromIO_Click eepromButtons.cmdReadHdw
        If EEprom.getEEpromVersion > 0 Then
            cmbAddr_Click
            Exit Sub ' Successful preset
        End If
    Else ' try to scan
        For i = 0 To cmbAddr.ListCount ' 1 extra (eval byte mode)
            If i = 0 Then
                cmbAddr.ListIndex = i
                cbByteAddr.value = vbChecked: cbByteAddr_Click
            Else
                cmbAddr.ListIndex = i - 1
                cbByteAddr.value = vbUnchecked: cbByteAddr_Click
            End If
            parse = Split(cmbAddr.text, "x")
            
            EEprom.setI2c "&H" & parse(1)
            cmdEEpromIO_Click eepromButtons.cmdReadHdw
            If EEprom.getEEpromVersion > 0 Then
                If EEprom.getCardGain(0) > 0 Then
                    cmbAddr_Click
                    If ShowEMUdebug Then
                        readEMU
                    End If
                    Exit Sub ' Successful scan
                End If
            End If
        Next i
    End If
    
    EEprom.getFile "", Me: loadCalibration
    
    cmbAddr.text = "0x00" ' no EEprom found
    parse = Split(frmHdw.caption, ":")
    frmHdw.caption = parse(0) & ":None"
    
End Sub

Private Sub cmbAddr_Click()

    Dim parse() As String, addr As Integer
    
    parse = Split(cmbAddr.text, "x")
    addr = "&H" & parse(1)
    
    parse = Split(frmHdw.caption, ":")
    
    frmHdw.caption = parse(0) & ":"
    
    Select Case addr
        Case eePromAddrs.evaluationCard: frmHdw.caption = frmHdw.caption & "Evaluation Card"
        Case eePromAddrs.paletteCard: frmHdw.caption = frmHdw.caption & "Palette Card"
        Case eePromAddrs.systemCard: frmHdw.caption = frmHdw.caption & "System I/O Card"
    End Select
    
    EEprom.setI2c addr
    
    enableReadWrites

End Sub

Public Sub setEEpromObjs()
    Dim i As Integer
    nRec = EEprom.getNrecords
    For i = 0 To nRec - 1
        EEprom.setTBobj txtEEprom(i), i
    Next i
End Sub

Private Sub enableReadWrites()

    Dim i As Integer, nRec As Integer

    If EEprom.getI2c Then
        cmdEEpromIO(eepromButtons.cmdReadHdw).enabled = True
    End If
    
    If EEprom.getEEpromVersion Then
    
        cmdEEpromIO(eepromButtons.cmdWriteFile).enabled = True
        
        If EEprom.getI2c Then
            cmdEEpromIO(eepromButtons.cmdWriteHdw).enabled = True
        End If
        
        Form_Resize
        
        setEEpromObjs
    
    End If
    
End Sub

Private Sub loadCalibration()
    Dim i As Integer, dummy As calValues
    For i = 0 To UBound(dummy.CCM)
        CallBackForm.loadCalibration i
    Next i
End Sub

Private Sub cmdEEpromIO_Click(Index As Integer)

    'Dim i As Integer, nRec As Integer, dummy As calValues
    
    On Error Resume Next

    Select Case Index
        Case eepromButtons.cmdNew: EEprom.newEEprom newDefault 'InputBox("Select Version between 1 and " & eePromRevs.Last - 1)
        Case eepromButtons.cmdReadFile: If tbFile.text <> "" Then EEprom.getFile lblDirectory.caption & tbFile.text, Me
        Case eepromButtons.cmdWriteFile: If tbFile.text <> "" Then EEprom.setFile lblDirectory.caption & tbFile.text: File1.Refresh
        Case eepromButtons.cmdReadHdw: EEprom.getEEprom Me
        Case eepromButtons.cmdWriteHdw: EEprom.setEEprom
        Case eepromButtons.cmdDeleteFile: Kill lblDirectory.caption & tbFile.text: tbFile.text = "" & vbCr: File1.Refresh
    End Select
    
    enableReadWrites
    
    loadCalibration
    
'    For i = 0 To UBound(dummy.CCM)
'        CallBackForm.loadCalibration i
'    Next i
    
End Sub

Private Function getHeightText(lines As Integer) As Integer
    getHeightText = tbTwipOffset + lines * tbTwipPerLine
End Function

Private Sub setTBtopHeight(tb As TextBox, lines As Integer)

    If tb.Index = 0 Then
        tb.Top = txtEEprom(tb.Index - 1).Top + txtEEprom(tb.Index - 1).Height
    Else
        tb.Top = topFirst
    End If
    
    If tbTwipPerLine < tbTwipPerLineMin Then tbTwipPerLine = tbTwipPerLineMin

    tb.Height = lines * tbTwipPerLine + tbTwipOffset

End Sub

Public Sub ReadFile()

    If cmbAddr.text = "0x00" Then cmdEEpromIO_Click eepromButtons.cmdReadFile
    
End Sub

Private Sub Form_Load()
    Dim i As Integer, lines As Integer
    widthMin = Width
    widthText = Width - txtEEprom(0).Width
    topFirst = txtEEprom(0).Top
    tbTwipSpace = txtEEprom(1).Top - (txtEEprom(0).Top + txtEEprom(0).Height)
    
    tbTwipPerLine = tbTwipPerLineMin
    
    For i = txtEEprom.LBound To txtEEprom.UBound
        txtEEprom(i).text = ""
        lines = lines + (txtEEprom(i).Height - tbTwipOffset) / tbTwipPerLine
    Next i
    
    heightText = Height - getHeightText(lines)
    heightMin = heightText
    heightMin = Height
    heightMenu = Height - frmFile.Height
    
    '--------------------------------
    fileDrive = Left(Drive1.Drive, 2)
    If dIR(Dir1.Path & "\CCMfiles\*") <> "" Then ChDir Dir1.Path & "\CCMfiles": Dir1.Path = CurDir
    fileDirectory = Dir1.Path
    fileName = tbFile.text 'File1.fileName
    File1.fileName = "*.txt"
    setFile
    '--------------------------------
    
    cmbAddr.AddItem "0x" & Hex$(eePromAddrs.evaluationCard)
    cmbAddr.AddItem "0x" & Hex$(eePromAddrs.paletteCard)
    cmbAddr.AddItem "0x" & Hex$(eePromAddrs.systemCard)
    
    frmEMUdebug.Visible = ShowEMUdebug
    
End Sub

Private Sub enterTM()
    als.writeField 0, 0, &HFF, &H89
    als.writeField 0, 0, &HFF, &HC9
End Sub

Private Sub exitTM()
    als.writeField 0, 0, &HFF, 0
End Sub

Private Function invertNibLsb(nibble As Byte)
    If nibble > 7 Then
        invertNibLsb = nibble
    Else
        invertNibLsb = nibble Xor 7
    End If
End Function

Private Sub readEMU()
    Dim emu As Byte
    
    enterTM
    
    emu = als.readField(&H19, 6, 1) ' read emu bit set
    
    als.writeField &H19, 6, 1, 0 ' set to fuse
    
    cmbAll.text = invertNibLsb(als.readField(&H1D, 4, &HF)) ' read coarse (all)
    cmbRB.text = invertNibLsb(als.readField(&H1D, 0, &HF)) ' read fine (R&B)
    
    als.writeField &H19, 6, 1, emu ' reset to emu value
    
    exitTM
    
End Sub

Private Sub cbFuseReg_Click()
    If cbFuseReg.value = vbChecked Then
        cbFuseReg.caption = "Reg"
        enterTM
        als.writeField &H19, 6, 1, 1 ' set to reg
        cmbAll.enabled = True
        cmbRB.enabled = True
    Else
        cbFuseReg.caption = "Fuse"
        enterTM
        als.writeField &H19, 6, 1, 0 ' set to fuse
        cmbAll.enabled = False
        cmbRB.enabled = False
    End If
    
    cmbAll.text = invertNibLsb(als.readField(&H1D, 4, &HF)) ' read coarse (all)
    cmbRB.text = invertNibLsb(als.readField(&H1D, 0, &HF)) ' read fine (R&B)
    exitTM
    
End Sub

Private Sub cmbAll_Click()
    On Error Resume Next
    enterTM
    als.writeField &H1B, 4, &HF, invertNibLsb(cmbAll.ListIndex)
    cbFuseReg_Click
End Sub

Private Sub cmbRB_Click()
    On Error Resume Next
    enterTM
    als.writeField &H1B, 0, &HF, invertNibLsb(cmbRB.ListIndex)
    cbFuseReg_Click
End Sub

Public Sub cmdFuse2Reg_Enable(Optional enable As Integer = 1)

    Dim cbFuseReg_value As Integer: cbFuseReg_value = cbFuseReg.value
    Dim trimValue As Byte
    
    If enable <> 0 Then enable = 1
    
    cbFuseReg.value = vbUnchecked: cbFuseReg_Click ' set to Fuse
    enterTM
    trimValue = als.readField(&H1D, 0, &HFF)
    als.writeField &H19, 6, 1, 1 ' set to reg
    als.writeField &H1B, 0, &HFF, trimValue * enable ' write fuse value into reg
    cbFuseReg.value = cbFuseReg_value: cbFuseReg_Click ' reset to original

End Sub

Private Sub cmdFuse2Reg_Click()

    cmdFuse2Reg_Enable

End Sub

Private Sub Form_Terminate()
    cmbAddr.clear
End Sub


Private Sub Form_Resize()

    On Error Resume Next

    If WindowState <> vbMinimized Then
    
        Dim nRecords As Integer, linesPerTB() As Integer, i As Integer
        
        If Not EEprom Is Nothing Then
            nRecords = EEprom.getNrecords
            If nRecords > 0 Then
                ReDim linesPerTB(nRecords - 1) As Integer
                EEprom.getTBlines linesPerTB
            End If
        End If

        If nRecords = 0 Then ' if there is no data lock the window size to design default
            Width = widthMin
            Height = heightMin
        Else
            If Width < widthMin Then Width = widthMin
            For i = 0 To nRecords - 1
                txtEEprom(i).Visible = True
                txtEEprom(i).Width = Width - widthText
                txtEEprom(i).Height = linesPerTB(i) * tbTwipPerLineMin + tbTwipOffset
                If i > 0 Then
                    txtEEprom(i).Top = txtEEprom(i - 1).Top + txtEEprom(i - 1).Height + tbTwipSpace
                End If
            Next i
            
            If nRecords > 0 Then
                Height = txtEEprom(nRecords - 1).Top + txtEEprom(nRecords - 1).Height + tbTwipSpace + heightMenu
            Else
                Height = heightMin
            End If
            
        End If
    
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set EEprom = Nothing
End Sub

Private Sub tbFile_Change()
    If enterText(tbFile.text) Then
        tbFile.text = Left(tbFile.text, Len(tbFile.text) - 1)
        fileName = tbFile.text
    End If
End Sub
