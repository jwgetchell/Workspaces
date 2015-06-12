VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "tabctl32.ocx"
Begin VB.Form frmThorlabsAPT 
   Caption         =   "Thorlabs APT"
   ClientHeight    =   6435
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7035
   Icon            =   "frmThorlabsAPT.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6435
   ScaleWidth      =   7035
   StartUpPosition =   3  'Windows Default
   Begin Application.ucNPXPS ucNPXPS1 
      Height          =   3015
      Left            =   5640
      TabIndex        =   11
      Top             =   120
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   5318
   End
   Begin Application.ucThorlabsAPT ucThorlabsAPT1 
      Height          =   5175
      Index           =   2
      Left            =   120
      TabIndex        =   8
      Top             =   1080
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   9128
   End
   Begin Application.ucThorlabsAPT ucThorlabsAPT1 
      Height          =   5175
      Index           =   1
      Left            =   120
      TabIndex        =   7
      Top             =   1080
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   9128
   End
   Begin Application.ucThorlabsAPT ucThorlabsAPT1 
      Height          =   5175
      Index           =   0
      Left            =   120
      TabIndex        =   6
      Top             =   1080
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   9128
   End
   Begin VB.Frame fmApp 
      Caption         =   "Program"
      Height          =   615
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   5535
      Begin VB.Frame fmArmXY 
         BackColor       =   &H000000FF&
         Height          =   435
         Left            =   3120
         TabIndex        =   9
         Top             =   120
         Visible         =   0   'False
         Width           =   2295
         Begin VB.ComboBox cmbDut 
            Height          =   315
            ItemData        =   "frmThorlabsAPT.frx":0CCA
            Left            =   840
            List            =   "frmThorlabsAPT.frx":0D2E
            TabIndex        =   13
            Text            =   "0"
            Top             =   140
            Width           =   615
         End
         Begin VB.CommandButton cmdNextDut 
            Caption         =   "Next"
            Height          =   255
            Left            =   1440
            TabIndex        =   12
            Top             =   140
            Width           =   855
         End
         Begin VB.CommandButton cmdArmSR 
            Caption         =   "ArmXY"
            Height          =   255
            Left            =   60
            TabIndex        =   10
            Top             =   140
            Width           =   735
         End
      End
      Begin VB.CommandButton cmdLoop 
         Caption         =   "Run Loop"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   240
         Width           =   975
      End
      Begin VB.ComboBox cmbNapt 
         Height          =   315
         ItemData        =   "frmThorlabsAPT.frx":0DA8
         Left            =   2040
         List            =   "frmThorlabsAPT.frx":0DB5
         TabIndex        =   2
         Text            =   "APT"
         Top             =   240
         Width           =   975
      End
      Begin VB.Label lblStepRepeat 
         Height          =   255
         Left            =   4200
         TabIndex        =   5
         Top             =   240
         Width           =   975
      End
      Begin VB.Label lblControlSel 
         Caption         =   "Controllers"
         Height          =   255
         Left            =   1200
         TabIndex        =   4
         Top             =   240
         Width           =   855
      End
   End
   Begin VB.Timer tmrLoop 
      Enabled         =   0   'False
      Interval        =   300
      Left            =   7320
      Top             =   0
   End
   Begin TabDlg.SSTab SSTabAPTSel 
      Height          =   5655
      Left            =   0
      TabIndex        =   0
      Top             =   720
      Width           =   5415
      _ExtentX        =   9551
      _ExtentY        =   9975
      _Version        =   393216
      TabHeight       =   520
      TabCaption(0)   =   "APT"
      TabPicture(0)   =   "frmThorlabsAPT.frx":0DCA
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).ControlCount=   0
      TabCaption(1)   =   "X"
      TabPicture(1)   =   "frmThorlabsAPT.frx":0DE6
      Tab(1).ControlEnabled=   0   'False
      Tab(1).ControlCount=   0
      TabCaption(2)   =   "Y"
      TabPicture(2)   =   "frmThorlabsAPT.frx":0E02
      Tab(2).ControlEnabled=   0   'False
      Tab(2).ControlCount=   0
   End
End
Attribute VB_Name = "frmThorlabsAPT"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim ucThorlabsAPT1_Height As Integer, ucThorlabsAPT1_Width As Integer
Dim gPosition As Double, gStart As Double, gStop As Double, gStep As Double
Dim fastSweepEnabled As Integer
Dim gSweepStartTick

Enum APTSel
    apt
    xy
    APT_XY
End Enum

Dim xIdx As Integer, yIdx As Integer, dnum As Integer

Const nDuts As Integer = 32
Dim pi As Double
Dim sr(nDuts - 1) As srPath

Public pSR As clsLoopSR
Public pAPTx As clsLoopTrans
Public pAPTy As clsLoopTrans
Public pSwp As Object

Public Sub setXYoffset(x As Single, y As Single)
    If x + y > 0 Then
        If cmbNapt.ListIndex = xy Or cmbNapt.ListIndex = APT_XY Then
            Dim xCtrl As Integer: xCtrl = cmbNapt.ListIndex - xy
            ucThorlabsAPT1(xCtrl + 0).setOffset x
            ucThorlabsAPT1(xCtrl + 1).setOffset y
        End If
    End If
End Sub

Public Sub armSR(Optional location As Integer = -1)
    If 0 <= location And location < nDuts Then
        dnum = location
    Else
        dnum = 0
    End If
    
    cmbDut.ListIndex = dnum
    tmrLoop_Timer
    
    fmArmXY.BackColor = vbGreen
End Sub

Public Function nextSR(Optional location As Integer = -1) As Single
    If 0 <= location And location < nDuts Then dnum = location
    tmrLoop_Timer
    nextSR = (dnum + 1) / nDuts
End Function

Public Function done() As Boolean
    done = (dnum >= nDuts)
    If done Then fmArmXY.BackColor = vbRed
End Function

Public Function srEnabled() As Boolean
    srEnabled = fmArmXY.Visible
End Function

Public Sub cmdArmSR_Click()
    armSR
End Sub

Private Sub cmdNextDut_Click()
    cmbDut.ListIndex = frmEtIo.getNextEnabled(cmbDut.ListIndex)
    nextSR cmbDut.ListIndex
End Sub

Private Sub cmbDut_Click()
    Dim dut As Integer
    dut = cmbDut.ListIndex - 1: If dut < 0 Then dut = 31
    dut = frmEtIo.getNextEnabled(dut)
    cmbDut.ListIndex = dut
    nextSR dut
End Sub

Private Sub Form_Load()
    Dim i As Integer, x As Integer, y As Integer
    
    ucThorlabsAPT1_Height = Height - ucThorlabsAPT1(0).Height
    ucThorlabsAPT1_Width = Width - ucThorlabsAPT1(0).Width
    
    Set pSR = New clsLoopSR
    Set pAPTx = New clsLoopTrans: pAPTx.init (0)
    Set pAPTy = New clsLoopTrans: pAPTy.init (1)
    
    If ucNPXPS1.enabled Then
        Set pSwp = ucNPXPS1
    Else
        ucNPXPS1.Visible = False
        Set pSwp = New clsLoopTrans: pSwp.init (0)
    End If
    
    pi = 4# * Atn(1)
    
    'GoTo sCurve
thao: ' normal scan, skips leds
    sr(i).x = 0: sr(i).y = 0: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 0: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 0: sr(i).y = 2: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    '-----
    sr(i).x = 0: sr(i).y = 3: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 0: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 0: sr(i).y = 5: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    '====
    sr(i).x = 3: sr(i).y = 0: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 3: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 3: sr(i).y = 2: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    '-----
    sr(i).x = 3: sr(i).y = 3: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 3: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 3: sr(i).y = 5: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    '====
    GoTo endSub
original:
    sr(i).x = 0: sr(i).y = 0: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    sr(i).x = 0: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    sr(i).x = 0: sr(i).y = 2: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    sr(i).x = 0: sr(i).y = 3: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    sr(i).x = 0: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    sr(i).x = 0: sr(i).y = 5: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
        
    GoTo endSub
sCurve:
    
    sr(i).x = 2: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 0: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 0: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 2: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = x: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 0: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 5: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 1: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 2: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 5: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 4: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 3: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    
    sr(i).x = x: sr(i).y = 2: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 5: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 0: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 4: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = 3: sr(i).y = y: x = sr(i).x: y = sr(i).y: i = i + 1
    sr(i).x = x: sr(i).y = 1: x = sr(i).x: y = sr(i).y: i = i + 1
    
endSub:
    
End Sub

Private Sub Form_Resize()
    If (Height - ucThorlabsAPT1_Height) > 0 Then ucThorlabsAPT1(0).Height = Height - ucThorlabsAPT1_Height
    If (Width - ucThorlabsAPT1_Width) > 0 Then ucThorlabsAPT1(0).Width = Width - ucThorlabsAPT1_Width
End Sub

Private Sub cmdLoop_Click()
    Dim i As Integer
    
    fastSweepEnabled = ucThorlabsAPT1(0).getFastSweepEnabled
    
    For i = 0 To SSTabAPTSel.Tabs - 1
        ucThorlabsAPT1(i).arm
    Next i
    
    tmrLoop.enabled = True
    xIdx = 0: yIdx = 0: dnum = 0
End Sub

Private Sub cart2polar(ByVal x As Single, ByVal y As Single, m As Single, t As Single)

    ' t: +/- 180 degrees
    
    m = (x * x + y * y) ^ 0.5
    If y <> 0 Then
        t = Atn(y / x) * 180 / pi ' +/- 90
        If x < 0 Then
            If y < 0 Then
                t = t - 180
            Else
                t = t + 180
            End If
        End If
    Else
        If x < 0 Then
            t = -180
        Else
            t = 0
        End If
    End If
    
End Sub

Private Sub polar2cart(ByVal m As Single, ByVal t As Single, x As Single, y As Single)
    t = t * pi / 180
    y = m * Sin(t)
    x = m * Cos(t)
End Sub

Private Sub setSRxy(ByVal x As Single, ByVal y As Single)

    Dim m As Single, t As Single
    Dim x0 As Single, y0 As Single, m0 As Single, t0 As Single
    Dim x1 As Single, y1 As Single
    Dim xSpan As Single, ySpan As Single
    Dim dY As Single, dX As Single
    Dim rot(0) As Single
    Dim xCtrl As Integer: xCtrl = cmbNapt.ListIndex - xy
    
    If xCtrl > 0 Then ' adjust for angular
    
        rot(0) = -ucThorlabsAPT1(0).getValue(rot) ' JWG new CR1-Z7 opposite rotation Feb 4,13
    
        xSpan = ucThorlabsAPT1(xCtrl + 0).getStop - ucThorlabsAPT1(xCtrl + 0).getStart
        ySpan = ucThorlabsAPT1(xCtrl + 1).getStop - ucThorlabsAPT1(xCtrl + 1).getStart
        
        ' xy relative to center of rotation
        x = x - xSpan / 2
        y = y - ySpan / 2
        Call cart2polar(x, y, m, t)
        Call polar2cart(m, t - rot(0), dX, dY)
        dX = dX - x: dY = dY - y
        
        If 0 Then
            ' offset relative to center of rotation
            x0 = ucThorlabsAPT1(xCtrl + 0).getOffset + xSpan / 2
            y0 = ucThorlabsAPT1(xCtrl + 1).getOffset + ySpan / 2
            Call cart2polar(x0, y0, m0, t0)
            Call polar2cart(m0, t0 + rot(0), x1, y1)
            dX = dX - (x1 - x0): dY = dY - (y1 - y0)
        End If
        
        x = x + dX + xSpan / 2: y = y + dY + xSpan / 2
        If x < 0 Then
            x = 0
        Else
            If x > 50 Then x = 50
        End If
        If y < 0 Then
            y = 0
        Else
            If y > 50 Then y = 50
        End If
        ucThorlabsAPT1(xCtrl + 0).setPosition (x)
        ucThorlabsAPT1(xCtrl + 1).setPosition (y)
    Else
        ucThorlabsAPT1(xCtrl + 0).setPosition (x)
        ucThorlabsAPT1(xCtrl + 1).setPosition (y)
    End If
    
    
End Sub

Private Sub tmrLoop_Timer()
    Static pos(0) As Single, lpos As Single
    
    If cmbNapt.ListIndex = apt Then
    
        lblStepRepeat.caption = ""
    
        If ucThorlabsAPT1(0).done Then
            tmrLoop.enabled = False
            lpos = 0
        Else
            If fastSweepEnabled Then
                pos(0) = ucThorlabsAPT1(0).getValue(pos)
                If lpos Then
                    debugPrint pos(0), pos(0) - lpos
                Else
                    debugPrint pos(0)
                End If
                lpos = pos(0)
            End If
            ucThorlabsAPT1(0).next_
        End If
    
    Else
        If cmbNapt.ListIndex = xy Or cmbNapt.ListIndex = APT_XY Then
        
            Dim xCtrl As Integer: xCtrl = cmbNapt.ListIndex - xy
            
            If 0 Then ' conventional
            
            
                If ucThorlabsAPT1(0).done Then
                    If ucThorlabsAPT1(xCtrl + 1).done Then
                        tmrLoop.enabled = False
                        ucThorlabsAPT1(xCtrl + 0).arm: xIdx = 0
                        ucThorlabsAPT1(xCtrl + 1).arm: xIdx = 0
                    Else
                        ucThorlabsAPT1(xCtrl + 0).arm: xIdx = 0
                        ucThorlabsAPT1(xCtrl + 1).next_: yIdx = yIdx + 1
                    End If
                Else
                    ucThorlabsAPT1(xCtrl + 0).next_: xIdx = xIdx + 1
                End If
            
            Else ' twisted
            
                If dnum < nDuts Then
                    xIdx = sr(dnum).x: yIdx = sr(dnum).y
                    cmbDut.ListIndex = dnum
                    Call setSRxy(ucThorlabsAPT1(xCtrl + 0).getStep * xIdx, ucThorlabsAPT1(xCtrl + 1).getStep * yIdx)
                    dnum = dnum + 1
                Else
                    tmrLoop.enabled = False
                End If
            
            End If
            
            lblStepRepeat.caption = dnum - 1 & ":" & xIdx & "," & yIdx

        End If
    End If
    
End Sub

Private Sub SSTabAPTSel_Click(Index As Integer)
    Dim i As Integer
    For i = 0 To 2: ucThorlabsAPT1(i).Visible = False: Next i
    ucThorlabsAPT1(SSTabAPTSel.Tab).Visible = True
End Sub

Private Sub cmbNapt_Click()
    
    SSTabAPTSel.Tabs = 3
    
    If cmbNapt.ListIndex = xy Then
        SSTabAPTSel.Tab = 0: SSTabAPTSel.caption = "X"
        SSTabAPTSel.Tab = 1: SSTabAPTSel.caption = "Y"
    Else
        SSTabAPTSel.Tab = 0: SSTabAPTSel.caption = "APT"
        SSTabAPTSel.Tab = 1: SSTabAPTSel.caption = "X"
        SSTabAPTSel.Tab = 2: SSTabAPTSel.caption = "Y"
    End If
    
    SSTabAPTSel.Tabs = cmbNapt.ListIndex + 1
    
    fmArmXY.Visible = (cmbNapt.ListIndex <> apt)

End Sub

' +__________________+
' | Palette Controls |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+



' +________+
' | Script |
' +¯¯¯¯¯¯¯¯+

Public Sub script(value As String)
    Dim widget As String
    Dim error As Long, iVal As Long
    Dim idx As Integer
        
repeat:    widget = lineArgs(value)
        
    Select Case widget
    
    Case "Controllers": setNapt (value)
    
    Case "0", "1", "2": idx = widget: 'GoTo repeat
    
    Case "Sn": iVal = val(value): ucThorlabsAPT1(idx).setHWSerialNum (iVal)
    Case "Start": iVal = val(value): ucThorlabsAPT1(idx).setStart (iVal)
    Case "Stop": iVal = val(value): ucThorlabsAPT1(idx).setStop (iVal)
    Case "Step": iVal = val(value): ucThorlabsAPT1(idx).setStep (iVal)
    
    Case "FastSweep": iVal = val(value): ucThorlabsAPT1(idx).setFastSweepEnabled iVal = 1
    Case "Arm": ucThorlabsAPT1(idx).arm
    
    Case "", "#":
    Case Else: MsgBox ("??Script: ThorlabsAPT " & widget & " " & value)
    
    End Select
    
End Sub

Function lineArgs(line As String) As String
    Dim spacePos As Integer
    spacePos = InStr(line, " ")
    If (spacePos) Then
        lineArgs = Mid(line, 1, spacePos - 1)
        line = Mid(line, spacePos + 1, Len(line))
    End If
End Function

Function setCmb(cmb As ComboBox, value As String) As Boolean
    Dim i As Integer
    
    For i = 0 To cmb.ListCount
        If value = cmb.list(i) Then
            cmb.ListIndex = i
            i = cmb.ListCount
            setCmb = True
        End If
    Next i
    
    If Not setCmb Then MsgBox ("value=" & value & " not found")

End Function

Sub setNapt(value As String)
    If setCmb(cmbNapt, value) Then cmbNapt_Click
End Sub



