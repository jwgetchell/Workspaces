VERSION 5.00
Begin VB.Form frmEtIo 
   Caption         =   "ALS ET I/O Card"
   ClientHeight    =   8790
   ClientLeft      =   1785
   ClientTop       =   1410
   ClientWidth     =   11130
   Icon            =   "frmEtIo.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   8790
   ScaleWidth      =   11130
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   7320
      TabIndex        =   190
      Top             =   7080
      Width           =   1095
   End
   Begin VB.Frame Frame5 
      Caption         =   "Color Temp."
      Height          =   615
      Left            =   3720
      TabIndex        =   188
      Top             =   8160
      Width           =   1695
      Begin VB.ComboBox cmbColorTemp 
         Height          =   315
         ItemData        =   "frmEtIo.frx":0CCA
         Left            =   120
         List            =   "frmEtIo.frx":0CD7
         TabIndex        =   189
         Text            =   "Lo:QTH"
         Top             =   240
         Width           =   1335
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Solar Shutter"
      Height          =   615
      Left            =   1440
      TabIndex        =   186
      Top             =   8160
      Width           =   1215
      Begin VB.CheckBox cbSolarShutter 
         Caption         =   "Closed"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   187
         Top             =   240
         Value           =   1  'Checked
         Width           =   975
      End
   End
   Begin VB.CheckBox cbQthPled 
      Caption         =   "QTH"
      Height          =   375
      Left            =   2760
      Style           =   1  'Graphical
      TabIndex        =   185
      Top             =   8280
      Width           =   735
   End
   Begin VB.CheckBox cbCpkg 
      Caption         =   "2 in 1"
      Height          =   375
      Left            =   5760
      Style           =   1  'Graphical
      TabIndex        =   174
      Top             =   6840
      Width           =   975
   End
   Begin VB.Frame Frame3 
      Height          =   6495
      Left            =   5640
      TabIndex        =   44
      Top             =   120
      Width           =   5415
      Begin VB.Frame fmProximity 
         Caption         =   "Proximity"
         Height          =   2895
         Left            =   2760
         TabIndex        =   140
         Top             =   3480
         Width           =   2535
         Begin VB.CheckBox cbScan 
            Caption         =   "Scan:Off"
            Height          =   495
            Index           =   1
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   141
            Top             =   240
            Width           =   2295
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   31
            Left            =   1920
            TabIndex        =   173
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   30
            Left            =   1920
            TabIndex        =   172
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   29
            Left            =   1920
            TabIndex        =   171
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   28
            Left            =   1920
            TabIndex        =   170
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   27
            Left            =   1920
            TabIndex        =   169
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   26
            Left            =   1920
            TabIndex        =   168
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   25
            Left            =   1920
            TabIndex        =   167
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   24
            Left            =   1920
            TabIndex        =   166
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   23
            Left            =   1320
            TabIndex        =   165
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   22
            Left            =   1320
            TabIndex        =   164
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   21
            Left            =   1320
            TabIndex        =   163
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   20
            Left            =   1320
            TabIndex        =   162
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   19
            Left            =   1320
            TabIndex        =   161
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   18
            Left            =   1320
            TabIndex        =   160
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   17
            Left            =   1320
            TabIndex        =   159
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   16
            Left            =   1320
            TabIndex        =   158
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   15
            Left            =   720
            TabIndex        =   157
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   14
            Left            =   720
            TabIndex        =   156
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   13
            Left            =   720
            TabIndex        =   155
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   12
            Left            =   720
            TabIndex        =   154
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   11
            Left            =   720
            TabIndex        =   153
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   10
            Left            =   720
            TabIndex        =   152
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   9
            Left            =   720
            TabIndex        =   151
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   8
            Left            =   720
            TabIndex        =   150
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   7
            Left            =   120
            TabIndex        =   149
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   6
            Left            =   120
            TabIndex        =   148
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   147
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   4
            Left            =   120
            TabIndex        =   146
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   145
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   144
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   143
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblProx 
            Alignment       =   1  'Right Justify
            Caption         =   "0.0000"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   142
            Top             =   840
            Width           =   495
         End
      End
      Begin VB.Frame fmDUTenable 
         Caption         =   "DUT Enable"
         Height          =   3255
         Left            =   120
         TabIndex        =   89
         Top             =   120
         Width           =   2775
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   0
            Left            =   600
            TabIndex        =   138
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   1
            Left            =   600
            TabIndex        =   137
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   2
            Left            =   600
            TabIndex        =   136
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   3
            Left            =   960
            TabIndex        =   135
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   4
            Left            =   960
            TabIndex        =   134
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   5
            Left            =   1320
            TabIndex        =   133
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   6
            Left            =   1320
            TabIndex        =   132
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   7
            Left            =   1320
            TabIndex        =   131
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   8
            Left            =   1680
            TabIndex        =   130
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   9
            Left            =   1680
            TabIndex        =   129
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   10
            Left            =   1680
            TabIndex        =   128
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   11
            Left            =   2040
            TabIndex        =   127
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   12
            Left            =   2040
            TabIndex        =   126
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   13
            Left            =   2400
            TabIndex        =   125
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   14
            Left            =   2400
            TabIndex        =   124
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   15
            Left            =   2400
            TabIndex        =   123
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   16
            Left            =   600
            TabIndex        =   122
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   17
            Left            =   600
            TabIndex        =   121
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   18
            Left            =   600
            TabIndex        =   120
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   19
            Left            =   960
            TabIndex        =   119
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   20
            Left            =   960
            TabIndex        =   118
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   21
            Left            =   1320
            TabIndex        =   117
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   22
            Left            =   1320
            TabIndex        =   116
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   23
            Left            =   1320
            TabIndex        =   115
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   24
            Left            =   1680
            TabIndex        =   114
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   25
            Left            =   1680
            TabIndex        =   113
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   26
            Left            =   1680
            TabIndex        =   112
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   27
            Left            =   2040
            TabIndex        =   111
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   28
            Left            =   2040
            TabIndex        =   110
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   29
            Left            =   2400
            TabIndex        =   109
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   30
            Left            =   2400
            TabIndex        =   108
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutEnable 
            Height          =   195
            Index           =   31
            Left            =   2400
            TabIndex        =   107
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   106
            Top             =   2520
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   1
            Left            =   120
            TabIndex        =   105
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   2
            Left            =   120
            TabIndex        =   104
            Top             =   1800
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   3
            Left            =   120
            TabIndex        =   103
            Top             =   1440
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   4
            Left            =   120
            TabIndex        =   102
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutRowEnable 
            Height          =   195
            Index           =   5
            Left            =   120
            TabIndex        =   101
            Top             =   720
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   0
            Left            =   600
            TabIndex        =   100
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   1
            Left            =   960
            TabIndex        =   99
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   2
            Left            =   1320
            TabIndex        =   98
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   3
            Left            =   1680
            TabIndex        =   97
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   4
            Left            =   2040
            TabIndex        =   96
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutColEnable 
            Height          =   195
            Index           =   5
            Left            =   2400
            TabIndex        =   95
            Top             =   240
            Width           =   195
         End
         Begin VB.CheckBox cbDutCellEnable 
            Height          =   195
            Index           =   0
            Left            =   960
            Style           =   1  'Graphical
            TabIndex        =   94
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutCellEnable 
            Height          =   195
            Index           =   1
            Left            =   2040
            Style           =   1  'Graphical
            TabIndex        =   93
            Top             =   2160
            Width           =   195
         End
         Begin VB.CheckBox cbDutCellEnable 
            Height          =   195
            Index           =   2
            Left            =   960
            Style           =   1  'Graphical
            TabIndex        =   92
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutCellEnable 
            Height          =   195
            Index           =   3
            Left            =   2040
            Style           =   1  'Graphical
            TabIndex        =   91
            Top             =   1080
            Width           =   195
         End
         Begin VB.CheckBox cbDutAllEnable 
            Height          =   195
            Left            =   120
            TabIndex        =   90
            Top             =   240
            Width           =   195
         End
         Begin VB.Label Label1 
            Caption         =   "ISL29028/30/38"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   13.5
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Height          =   375
            Left            =   480
            TabIndex        =   139
            Top             =   2760
            Width           =   2175
         End
         Begin VB.Line Line1 
            X1              =   480
            X2              =   2640
            Y1              =   600
            Y2              =   600
         End
         Begin VB.Line Line2 
            X1              =   480
            X2              =   480
            Y1              =   2760
            Y2              =   600
         End
      End
      Begin VB.Frame fmALS 
         Caption         =   "ALS"
         Height          =   2895
         Left            =   120
         TabIndex        =   55
         Top             =   3480
         Width           =   2535
         Begin VB.CheckBox cbScan 
            Caption         =   "Scan:Off"
            Height          =   495
            Index           =   0
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   56
            Top             =   240
            Width           =   2295
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   88
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   87
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   86
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   3
            Left            =   120
            TabIndex        =   85
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   4
            Left            =   120
            TabIndex        =   84
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   5
            Left            =   120
            TabIndex        =   83
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   6
            Left            =   120
            TabIndex        =   82
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   7
            Left            =   120
            TabIndex        =   81
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   8
            Left            =   720
            TabIndex        =   80
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   9
            Left            =   720
            TabIndex        =   79
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   10
            Left            =   720
            TabIndex        =   78
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   11
            Left            =   720
            TabIndex        =   77
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   12
            Left            =   720
            TabIndex        =   76
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   13
            Left            =   720
            TabIndex        =   75
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   14
            Left            =   720
            TabIndex        =   74
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   15
            Left            =   720
            TabIndex        =   73
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   16
            Left            =   1320
            TabIndex        =   72
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   17
            Left            =   1320
            TabIndex        =   71
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   18
            Left            =   1320
            TabIndex        =   70
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   19
            Left            =   1320
            TabIndex        =   69
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   20
            Left            =   1320
            TabIndex        =   68
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   21
            Left            =   1320
            TabIndex        =   67
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   22
            Left            =   1320
            TabIndex        =   66
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   23
            Left            =   1320
            TabIndex        =   65
            Top             =   2520
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   24
            Left            =   1920
            TabIndex        =   64
            Top             =   840
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   25
            Left            =   1920
            TabIndex        =   63
            Top             =   1080
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   26
            Left            =   1920
            TabIndex        =   62
            Top             =   1320
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   27
            Left            =   1920
            TabIndex        =   61
            Top             =   1560
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   28
            Left            =   1920
            TabIndex        =   60
            Top             =   1800
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   29
            Left            =   1920
            TabIndex        =   59
            Top             =   2040
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   30
            Left            =   1920
            TabIndex        =   58
            Top             =   2280
            Width           =   495
         End
         Begin VB.Label lblLux 
            Alignment       =   1  'Right Justify
            Caption         =   "0000.0"
            Height          =   255
            Index           =   31
            Left            =   1920
            TabIndex        =   57
            Top             =   2520
            Width           =   495
         End
      End
      Begin VB.Frame Frame2 
         Height          =   3255
         Left            =   3000
         TabIndex        =   45
         Top             =   120
         Width           =   2295
         Begin VB.Timer tmrScan 
            Enabled         =   0   'False
            Interval        =   15
            Left            =   120
            Top             =   1560
         End
         Begin VB.Timer tmrInit0 
            Enabled         =   0   'False
            Interval        =   100
            Left            =   120
            Top             =   1080
         End
         Begin VB.CheckBox cbLoopScan 
            Caption         =   "Loop Scan"
            Height          =   255
            Left            =   240
            TabIndex        =   51
            Top             =   2520
            Width           =   1695
         End
         Begin VB.Timer tmrFpgaMon 
            Enabled         =   0   'False
            Interval        =   100
            Left            =   120
            Top             =   2040
         End
         Begin VB.OptionButton optFpgaMon 
            Alignment       =   1  'Right Justify
            Caption         =   "FPGA"
            Enabled         =   0   'False
            Height          =   375
            Left            =   840
            TabIndex        =   50
            Top             =   2160
            Width           =   975
         End
         Begin VB.Frame Frame1 
            Caption         =   "Port/Bit/Value"
            Height          =   615
            Left            =   720
            TabIndex        =   46
            Top             =   1440
            Width           =   1335
            Begin VB.CheckBox cbPort 
               Caption         =   "0"
               Height          =   255
               Left            =   120
               Style           =   1  'Graphical
               TabIndex        =   49
               Top             =   240
               Width           =   255
            End
            Begin VB.ComboBox cmbBit 
               Height          =   315
               ItemData        =   "frmEtIo.frx":0CF7
               Left            =   360
               List            =   "frmEtIo.frx":0D13
               TabIndex        =   48
               Text            =   "0"
               Top             =   240
               Width           =   615
            End
            Begin VB.CheckBox cbValue 
               Caption         =   "0"
               Height          =   255
               Left            =   960
               Style           =   1  'Graphical
               TabIndex        =   47
               Top             =   240
               Width           =   255
            End
         End
         Begin VB.CheckBox cbSRscan 
            Caption         =   "Run S&R with Scan"
            Height          =   495
            Left            =   240
            TabIndex        =   54
            Top             =   2640
            Width           =   1695
         End
         Begin VB.CommandButton cmdReset 
            Caption         =   "Reset"
            Height          =   375
            Left            =   120
            TabIndex        =   52
            Top             =   600
            Width           =   975
         End
         Begin VB.CheckBox cbRunTest 
            Caption         =   "Run Test"
            Height          =   375
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   53
            Top             =   240
            Width           =   975
         End
      End
   End
   Begin VB.Timer tmrInit 
      Interval        =   100
      Left            =   6000
      Top             =   7920
   End
   Begin VB.Timer tmrTest 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   6480
      Top             =   7920
   End
   Begin VB.CheckBox cbTest 
      Caption         =   "Test Stopped"
      Height          =   375
      Left            =   5520
      Style           =   1  'Graphical
      TabIndex        =   39
      Top             =   8280
      Width           =   1335
   End
   Begin VB.Frame fmDacs 
      Caption         =   "VAUX(555nm)"
      Height          =   615
      Index           =   11
      Left            =   120
      TabIndex        =   37
      Top             =   2160
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   11
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   199
         Text            =   "frmEtIo.frx":0D2F
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   11
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   183
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   11
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   38
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmQthShutter 
      Caption         =   "Qth Shutter"
      Height          =   615
      Left            =   120
      TabIndex        =   35
      Top             =   8160
      Width           =   1215
      Begin VB.CheckBox cbShutterEnable 
         Height          =   255
         Left            =   840
         Style           =   1  'Graphical
         TabIndex        =   184
         Top             =   240
         Width           =   255
      End
      Begin VB.CheckBox cbQthShutter 
         Caption         =   "Open"
         Height          =   255
         Left            =   120
         Style           =   1  'Graphical
         TabIndex        =   36
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame fmDevice 
      Caption         =   "Device:Cell:Unit"
      Height          =   855
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5295
      Begin VB.CheckBox cbCal 
         Caption         =   "Test"
         Height          =   255
         Left            =   4440
         Style           =   1  'Graphical
         TabIndex        =   31
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox cbCoPkg 
         Caption         =   "Ext LED"
         Height          =   255
         Left            =   3720
         Style           =   1  'Graphical
         TabIndex        =   5
         Top             =   480
         Width           =   735
      End
      Begin VB.HScrollBar HScrUnit 
         Height          =   255
         Left            =   1320
         Max             =   7
         TabIndex        =   3
         Top             =   480
         Width           =   2410
      End
      Begin VB.HScrollBar HScrCell 
         Height          =   255
         Left            =   120
         Max             =   3
         TabIndex        =   2
         Top             =   480
         Width           =   1205
      End
      Begin VB.CheckBox cbImeas 
         Caption         =   "I:Off"
         Height          =   255
         Left            =   4440
         Style           =   1  'Graphical
         TabIndex        =   34
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbALL 
         Caption         =   "0:0:0"
         Enabled         =   0   'False
         Height          =   255
         Left            =   3720
         Style           =   1  'Graphical
         TabIndex        =   4
         Top             =   240
         Width           =   735
      End
      Begin VB.HScrollBar HScrDevice 
         Height          =   255
         Left            =   120
         Max             =   31
         TabIndex        =   1
         Top             =   240
         Width           =   3615
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "445nm"
      Height          =   615
      Index           =   0
      Left            =   120
      TabIndex        =   6
      Top             =   960
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   0
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   191
         Text            =   "frmEtIo.frx":0D36
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   0
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   175
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   0
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   7
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "525nm"
      Height          =   615
      Index           =   1
      Left            =   120
      TabIndex        =   8
      Top             =   1560
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   1
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   192
         Text            =   "frmEtIo.frx":0D3D
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   1
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   176
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   1
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   9
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "594nm"
      Height          =   615
      Index           =   2
      Left            =   120
      TabIndex        =   10
      Top             =   2760
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   2
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   193
         Text            =   "frmEtIo.frx":0D44
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   2
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   177
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   2
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   11
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "615nm"
      Height          =   615
      Index           =   3
      Left            =   120
      TabIndex        =   12
      Top             =   3360
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   3
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   194
         Text            =   "frmEtIo.frx":0D4B
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   3
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   178
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   3
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   13
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "660nm"
      Height          =   615
      Index           =   4
      Left            =   120
      TabIndex        =   14
      Top             =   3960
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   4
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   195
         Text            =   "frmEtIo.frx":0D52
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   4
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   179
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   4
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   15
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "850nm"
      Height          =   615
      Index           =   5
      Left            =   120
      TabIndex        =   16
      Top             =   4560
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   5
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   196
         Text            =   "frmEtIo.frx":0D59
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   5
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   180
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   5
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   17
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "940nm"
      Height          =   615
      Index           =   6
      Left            =   120
      TabIndex        =   18
      Top             =   5160
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   6
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   197
         Text            =   "frmEtIo.frx":0D60
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   6
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   181
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   6
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   19
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "6500K"
      Height          =   615
      Index           =   7
      Left            =   120
      TabIndex        =   20
      Top             =   5760
      Width           =   5295
      Begin VB.TextBox tbDacs 
         Alignment       =   2  'Center
         Height          =   285
         Index           =   7
         Left            =   4440
         MultiLine       =   -1  'True
         TabIndex        =   198
         Text            =   "frmEtIo.frx":0D67
         Top             =   240
         Width           =   735
      End
      Begin VB.CheckBox cbDacs 
         Height          =   255
         Index           =   7
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   182
         Top             =   240
         Width           =   255
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   7
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25000
         TabIndex        =   21
         Top             =   240
         Value           =   -25000
         Width           =   4095
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "VDD"
      Height          =   615
      Index           =   8
      Left            =   120
      TabIndex        =   22
      Top             =   6360
      Width           =   5295
      Begin VB.CheckBox cbOnOff 
         Caption         =   "OFF"
         Height          =   255
         Index           =   0
         Left            =   3360
         Style           =   1  'Graphical
         TabIndex        =   40
         Top             =   240
         Width           =   495
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   8
         LargeChange     =   100
         Left            =   120
         Max             =   10000
         Min             =   -10001
         TabIndex        =   23
         Top             =   240
         Value           =   -10000
         Width           =   3255
      End
      Begin VB.Label lblAdcs 
         Alignment       =   1  'Right Justify
         Caption         =   "000.00u"
         Height          =   255
         Index           =   0
         Left            =   4560
         TabIndex        =   32
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblDacs 
         Caption         =   "0.0000"
         Height          =   255
         Index           =   8
         Left            =   3960
         TabIndex        =   24
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "VLED"
      Height          =   615
      Index           =   9
      Left            =   120
      TabIndex        =   25
      Top             =   6960
      Width           =   5295
      Begin VB.CheckBox cbOnOff 
         Caption         =   "OFF"
         Height          =   255
         Index           =   1
         Left            =   3360
         Style           =   1  'Graphical
         TabIndex        =   41
         Top             =   240
         Width           =   495
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   9
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25001
         TabIndex        =   26
         Top             =   240
         Value           =   -20001
         Width           =   3255
      End
      Begin VB.Label lblAdcs 
         Alignment       =   1  'Right Justify
         Caption         =   "000.00u"
         Height          =   255
         Index           =   1
         Left            =   4560
         TabIndex        =   33
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblDacs 
         Caption         =   "0.0000"
         Height          =   255
         Index           =   9
         Left            =   3960
         TabIndex        =   27
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Frame fmDacs 
      Caption         =   "VPROX"
      Height          =   615
      Index           =   10
      Left            =   120
      TabIndex        =   28
      Top             =   7560
      Width           =   5295
      Begin VB.CheckBox cbOnOff 
         Caption         =   "OFF"
         Height          =   255
         Index           =   2
         Left            =   3360
         Style           =   1  'Graphical
         TabIndex        =   42
         Top             =   240
         Width           =   495
      End
      Begin VB.HScrollBar HScrDacs 
         Height          =   255
         Index           =   10
         LargeChange     =   100
         Left            =   120
         Max             =   25000
         Min             =   -25001
         TabIndex        =   29
         Top             =   240
         Value           =   -20001
         Width           =   3255
      End
      Begin VB.Label lblDacs 
         Caption         =   "0.0000"
         Height          =   255
         Index           =   10
         Left            =   3960
         TabIndex        =   30
         Top             =   240
         Width           =   495
      End
   End
   Begin VB.Timer tmrAdcs 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   5520
      Top             =   7920
   End
   Begin VB.Label lblPosition 
      Caption         =   "Vertical"
      Height          =   255
      Left            =   5760
      TabIndex        =   43
      Top             =   7320
      Width           =   855
   End
End
Attribute VB_Name = "frmEtIo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const disableDeviceScan As Boolean = False

Dim pDrv As ucALSusb
'Dim pg As ucMonochromator

Enum AER
    LED445
    LED525
    LED594
    LED615
    LED660
    LED850
    LED940
    LED6500K
    
    VDD
    vled
    VPROX
    AUX
    
    IDDADC
    ILEDADC
    
    IOPROM
    PCPROM
    
    FPGAMUX
    FPGAENABLE
    FPGASTATUS
    FPGADUTI2C
    
    TESTREG
    NAER
End Enum

Enum FPGA_FIELD
    cal
    cp
    All
    
    cell
    CELLDUT
    dut
    
    vddEnable
    ledEnable
    prxEnable
    
    shutterEnable
    filterEnable ' Probably going to be a wheel
    int0
    int1
    int2
    int3
    pos
    
    duti2c
    
    TESTFIELD
    NFPGA_FIELD
End Enum

Enum ColorTemp
    K3000
    K4500
    K5500
End Enum

Dim devI2cBase As Byte

Dim register(NAER - 1) As IOreg
Dim FPGAfield(NFPGA_FIELD - 1) As IOfield
Dim devCellUnit As String

Const cDacFS As Double = 4.096
Const cLedDacFS As Double = cDacFS * 5 / 2.5
Const cVirLedFS As Double = cDacFS * 4 / 2.5
Const cVddFS As Double = cDacFS * 2 / 2.5
Const cVproxFS As Double = cDacFS * 4 / 2.5

Const debugPrint_ As Boolean = False

Const manualShutter As Boolean = True


' +______________+
' | DUT Controls |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
Const maxDuts As Integer = 32
Const maxRowCol As Integer = 6
Const cellSize As Integer = 8

Dim x As Integer, y As Integer
Dim rowDuts(maxRowCol - 1, maxRowCol - 1) As Integer
Dim colDuts(maxRowCol - 1, maxRowCol - 1) As Integer
Dim cellDuts(maxDuts / cellSize - 1, cellSize - 1) As Integer

Dim proxScanEnable As Boolean
Dim alsScanEnable As Boolean

'Dim pAls As ucALSusb
'Dim pSR As frmThorlabsAPT
'Dim pPlt As frmPlot

Public pDUT As clsLoopETclk

Dim dnum As Integer
Dim scroll(11) As Integer

' +_____________+
' | Public APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯+

Public Sub selectDevice(Device As Integer)
    If HScrDevice.min <= Device And Device <= HScrDevice.max Then HScrDevice.value = Device
End Sub

Public Sub setProxLevel(volts As Double)
    On Error GoTo endSub
    If 0 <= volts And volts <= 6.5 Then
        HScrDacs(AER.VPROX).value = (volts - 4) * 10000
        frmMonochromator.ucMonochromator1.setPgVih volts
    End If
endSub:
End Sub

Public Sub setLEDvolts(ByVal led As Integer, ByVal volts As Single)
    If 0 <= led And led <= 8 Then
        If volts < 0 Then
            volts = 0
        Else
            If volts > 5 Then
                volts = 5
            End If
        End If
        HScrDacs(led).value = (volts - 2.5) * 10000
    End If
End Sub

Public Sub setLedEnable(ByVal led As Integer, ByVal enable As Boolean)

    If led < 8 Or led = 11 Then
        If enable Then
            cbDacs(led).value = vbChecked
        Else
            cbDacs(led).value = vbUnchecked
        End If
        cbDacs_Click led
    End If
    
End Sub


Public Sub shutterClosed(ByVal state As Boolean)

    If state <> (cbQthShutter.value = 0) Then
        cbQthShutter.value = 1 - cbQthShutter.value
        cbQthShutter_Click
        If manualShutter = False Then
            If state Then
                MsgBox "Shutter Open"
            Else
                MsgBox "Shutter Close"
            End If
        End If
    End If
    
End Sub

Public Sub setColorTemp(temp As ColorTemp)
    cmbColorTemp.ListIndex = temp
    cmbColorTemp_Click
End Sub







' +______________+
' | Private APIs |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯+

Private Function bs(word As Long) As Long
    bs = (word And &HFF00) / 256
    bs = (bs Or ((word And &HFF) * 256))
End Function

Private Sub cbCpkg_Click()
    Dim data As Byte
    
    If cbCpkg.value = vbChecked Then
        cbCpkg.caption = "3 in 1"
        data = 1
    Else
        cbCpkg.caption = "2 in 1"
        data = 1
    End If
    
    Call writeI2cField(FPGAfield(FPGA_FIELD.cp), data)
    
End Sub

Private Sub cbDacs_Click(Index As Integer)
    
    Static lastValue(11) As Integer
    
    If cbDacs(Index).value = vbChecked Then ' turning on
        HScrDacs(Index).value = scroll(Index) ' set to saved value
    Else ' turning off
        scroll(Index) = HScrDacs(Index).value ' save value
        HScrDacs(Index).value = HScrDacs(Index).min ' set to min (off)
    End If
        
End Sub

Private Sub tbDacs_Change(Index As Integer)

    On Error GoTo endSub
    
    Dim value As Double
    
    If enterText(tbDacs(Index).text) Then
    
        value = val(tbDacs(Index).text)
        
        If value > 5 Then
            value = 5
        Else
            If value < 0 Then value = 0
        End If
        
        scroll(Index) = (value - 2.5) * 10 ^ 4
        
        If value = 0 Then
            cbDacs(Index).value = vbUnchecked
        Else
            cbDacs(Index).value = vbChecked
        End If
        
        cbDacs_Click Index
        
    End If
    
endSub: End Sub

Private Sub HScrDacs_Change(field As Integer)

    Dim volts As Double, lword As Long
    
    Select Case field
    
    ' 0 < LEDxxx < 5
    Case AER.LED445 To AER.LED6500K, AER.AUX: volts = 2.5 + HScrDacs(field).value / 10000#: lword = volts / cLedDacFS * 65535
    
    ' 2.25 < VDD < 4.25
    Case AER.VDD: volts = 3.25 + HScrDacs(field).value / 10000#: lword = 0 + 37300 * (4.25 - volts) / 2
    
    ' 1.5 < VLED < 6.5
    Case AER.vled: volts = 4 + HScrDacs(field).value / 10000#: lword = 950 + 37300 * (6.5 - volts) / 5
    
    ' 1.5 < VPROX < 6.5
    Case AER.VPROX: volts = 4 + HScrDacs(field).value / 10000#: lword = 950 + 37300 * (6.5 - volts) / 5
    
    End Select
    
    
    'Shut off
    Select Case field
    Case AER.VDD: If lword > 35700 Then lword = 35700: volts = 0
    Case AER.vled: If lword > 38250 Then lword = 38250: volts = 0
    Case AER.VPROX: If lword > 38250 Then lword = 38250: volts = 0
    End Select
    
    If field < 8 Or field = 11 Then
        tbDacs(field).text = format(volts, "0.0000")
    Else
        lblDacs(field).caption = format(volts, "0.0000")
    End If
    
    register(field).value = lword And &HFFFF
    
    If debugPrint_ Then debugPrint register(field).value
    
    Call dWriteI2cWord(register(field).i2cadd, register(field).devAddr, bs(register(field).value))

End Sub

Private Sub cbOnOff_Click(Index As Integer)
    Dim data As Byte
    
    If cbOnOff(Index).value = vbChecked Then
        cbOnOff(Index).caption = "ON"
        data = 1
    Else
        cbOnOff(Index).caption = "OFF"
        data = 0
    End If
    
    Select Case Index
    Case 0: Call writeI2cField(FPGAfield(FPGA_FIELD.vddEnable), data)
    Case 1: Call writeI2cField(FPGAfield(FPGA_FIELD.ledEnable), data)
    Case 2: Call writeI2cField(FPGAfield(FPGA_FIELD.prxEnable), data)
    End Select
    
End Sub

' +________________+
' | Shutters & LED |
' +¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯+
Public Sub setQthPledEnable(enable As Boolean)
    If enable Then
        cbQthPled.value = vbUnchecked
    Else
        cbQthPled.value = vbChecked
    End If
    cbQthPled_Click
End Sub

Private Sub cbQthPled_Click()

    If cbQthPled.value = vbChecked Then
        cbQthPled.caption = "PLED"
    Else
        cbQthPled.caption = "QTH"
    End If
    
    cbQthShutter.value = cbQthPled.value
    cbDacs(AER.LED6500K).value = cbQthPled.value
    
End Sub

Private Sub cbQthShutter_Click()
    If cbQthShutter.value = vbChecked Then
        cbQthShutter.caption = "Closed"
    Else
        cbQthShutter.caption = "Open"
    End If
    If cbShutterEnable.value = vbChecked Then
        Call writeI2cField(FPGAfield(FPGA_FIELD.shutterEnable), 0)
        Call writeI2cField(FPGAfield(FPGA_FIELD.shutterEnable), 1)
    End If
End Sub

Private Sub cbSolarShutter_Click()
    
    If cbSolarShutter.value = vbChecked Then
        Call writeI2cField(FPGAfield(FPGA_FIELD.filterEnable), 0)
        cbSolarShutter.caption = "Open"
    Else
        Call writeI2cField(FPGAfield(FPGA_FIELD.filterEnable), 1)
        cbSolarShutter.caption = "Closed"
    End If

End Sub

Private Sub cmbColorTemp_Click()

    Select Case cmbColorTemp.ListIndex
    'QTH
    Case 0: cbQthPled.value = vbUnchecked: cbSolarShutter.value = vbUnchecked
    'LED
    Case 1: cbQthPled.value = vbChecked: cbSolarShutter.value = vbUnchecked
    'Solar
    Case 2: cbQthPled.value = vbChecked: cbSolarShutter.value = vbChecked
    End Select
    
    cbQthPled_Click
    cbSolarShutter_Click
    
    If cbSolarShutter.value = vbChecked Then
        cbDacs(AER.LED6500K).value = vbUnchecked
    End If
    
End Sub

Private Sub cbTest_Click()
    If cbTest.value = vbChecked Then
        cbTest.caption = "Test Looping"
        tmrTest.enabled = True
    Else
        cbTest.caption = "Test Stopped"
        tmrTest.enabled = False
    End If
End Sub

Private Sub tmrInit_Timer()
    ' turn on VDD
    Const Index As Integer = 0
    HScrDacs(AER.VDD).value = 0: HScrDacs(AER.VDD).value = 210 ' set VDD to 3.3
    'HScrDacs(AER.VDD).value = HScrDacs(AER.VDD).max ' JWG temp
    cbOnOff(Index).value = vbUnchecked: cbOnOff(Index).value = vbChecked ' turn on
    
    tmrInit.enabled = False
    
    tmrInit0.enabled = True
End Sub

Private Sub tmrTest_Timer()
    register(AER.VDD).value = register(AER.VDD).value Xor &H5555
    Call dWriteI2cWord(register(AER.VDD).i2cadd, register(AER.VDD).devAddr, register(AER.VDD).value)
    Call dWriteI2cWord(register(AER.VDD).i2cadd, register(AER.VDD).devAddr, register(AER.VDD).value)
End Sub

Private Sub Form_Load()

    Dim field As Integer, i2cadd As Long
    Dim z As Integer, i As Integer
    
    On Error GoTo exitSub
    
    
    '
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    'FPGA |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    '  0  | CAL |  CP | ALL |   CELL    |       DUT       | MUX
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    '  1  |                 | FLT | SHT | PRX | LED | VDD | ENABLE
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    '  2  |               DUTI2C                    |     | DUTI2C
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    '  3  |                 | POS | INT3| INT2| INT1| INT0| STATUS
    '-----+-----+-----+-----+-----+-----+-----+-----+-----+
    
    
    ' function verified
    i2cadd = &H82
    register(AER.vled).i2cadd = i2cadd: register(AER.vled).devAddr = &H31
    register(AER.VPROX).i2cadd = i2cadd: register(AER.VPROX).devAddr = &H32
    register(AER.VDD).i2cadd = i2cadd: register(AER.VDD).devAddr = &H33
    register(AER.AUX).i2cadd = i2cadd: register(AER.AUX).devAddr = &H30
    
    register(AER.LED445).i2cadd = &H80: register(AER.LED445).devAddr = &H30
    register(AER.LED525).i2cadd = &H80: register(AER.LED525).devAddr = &H31
    register(AER.LED594).i2cadd = &H80: register(AER.LED594).devAddr = &H32
    register(AER.LED615).i2cadd = &H80: register(AER.LED615).devAddr = &H33
    register(AER.LED660).i2cadd = &H64: register(AER.LED660).devAddr = &H30
    register(AER.LED850).i2cadd = &H64: register(AER.LED850).devAddr = &H31
    register(AER.LED940).i2cadd = &H64: register(AER.LED940).devAddr = &H32
    register(AER.LED6500K).i2cadd = &H64: register(AER.LED6500K).devAddr = &H33
    
    register(AER.IDDADC).i2cadd = &H28 ' needs checkout
    register(AER.ILEDADC).i2cadd = &HA8
    
    register(AER.FPGAMUX).i2cadd = &H50
    register(AER.FPGAENABLE).i2cadd = &H50:: register(AER.FPGAENABLE).devAddr = 1
    register(AER.FPGADUTI2C).i2cadd = &H50:: register(AER.FPGADUTI2C).devAddr = 2
    register(AER.FPGASTATUS).i2cadd = &H50:: register(AER.FPGASTATUS).devAddr = 3
    
    field = FPGA_FIELD.duti2c
    FPGAfield(field).regIdx = AER.FPGADUTI2C
    FPGAfield(field).mask = &H7F
    FPGAfield(field).shift = 1
    
    field = FPGA_FIELD.cal
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = 1
    FPGAfield(field).shift = 7
    
    field = FPGA_FIELD.cp
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = 1
    FPGAfield(field).shift = 6
    
    field = FPGA_FIELD.All
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = 1
    FPGAfield(field).shift = 5
    
    field = FPGA_FIELD.cell
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = 3
    FPGAfield(field).shift = 3
    
    field = FPGA_FIELD.dut
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = &H1F
    
    field = FPGA_FIELD.CELLDUT
    FPGAfield(field).regIdx = AER.FPGAMUX
    FPGAfield(field).mask = 7
    
    field = FPGA_FIELD.vddEnable
    FPGAfield(field).regIdx = AER.FPGAENABLE
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.ledEnable
    FPGAfield(field).regIdx = AER.FPGAENABLE
    FPGAfield(field).shift = 1
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.prxEnable
    FPGAfield(field).regIdx = AER.FPGAENABLE
    FPGAfield(field).shift = 2
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.shutterEnable
    FPGAfield(field).regIdx = AER.FPGAENABLE
    FPGAfield(field).shift = 3
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.filterEnable
    FPGAfield(field).regIdx = AER.FPGAENABLE
    FPGAfield(field).shift = 4
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.int0
    FPGAfield(field).regIdx = AER.FPGASTATUS
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.int1
    FPGAfield(field).regIdx = AER.FPGASTATUS
    FPGAfield(field).shift = 1
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.int2
    FPGAfield(field).regIdx = AER.FPGASTATUS
    FPGAfield(field).shift = 2
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.int3
    FPGAfield(field).regIdx = AER.FPGASTATUS
    FPGAfield(field).shift = 3
    FPGAfield(field).mask = 1
    
    field = FPGA_FIELD.pos
    FPGAfield(field).regIdx = AER.FPGASTATUS
    FPGAfield(field).shift = 4
    FPGAfield(field).mask = 1
    
    
    ' garbage for card bring up
    register(AER.TESTREG).i2cadd = &H88:: register(AER.TESTREG).devAddr = 2
    field = FPGA_FIELD.TESTFIELD
    FPGAfield(field).regIdx = AER.TESTREG
    FPGAfield(field).mask = 1
    FPGAfield(field).shift = 2
    
    register(AER.IOPROM).i2cadd = &HA0 ' needs code address word write
    register(AER.PCPROM).i2cadd = &HA2
    
    devCellUnit = "0:0:0"
    
    Set pDUT = New clsLoopETclk
    
    Set pDrv = frmMain.ucALSusb1
    Call pDrv.dSetConversionTime(0, 10)
    resetFpga
    
    Dim data As Long, addr As Long
    addr = pDrv.getDUTi2c
    setDeviceI2cAddress (addr)  ' JWG temp patch
    Call writeI2cField(FPGAfield(FPGA_FIELD.duti2c), addr / 2)
    pDrv.dSetByteIoOnly 1
    
    ' Set DACs to Internal Reference
    Call pDrv.dReadI2cWord(register(AER.FPGAMUX).i2cadd, 0, data): data = 0
    
    'addr = &HF5  ' pwr Down
    addr = &HF6  ' internal Ref
    Call pDrv.dWriteI2c(register(AER.AUX).i2cadd, addr, data)
    Call pDrv.dWriteI2c(register(AER.LED445).i2cadd, addr, data)
    Call pDrv.dWriteI2c(register(AER.LED660).i2cadd, addr, data)
    
    'eepromTest
    readPalettePosition
    
    cbDutAllEnable.value = vbChecked: cbDutAllEnable_Click
    
    ' initialize row pattern
    y = 0: rowDuts(y, 0) = 0:  rowDuts(y, 1) = 3:  rowDuts(y, 2) = 5
           rowDuts(y, 3) = 8:  rowDuts(y, 4) = 11: rowDuts(y, 5) = 13
    y = 1: rowDuts(y, 0) = 1:  rowDuts(y, 1) = -1: rowDuts(y, 2) = 6
           rowDuts(y, 3) = 9:  rowDuts(y, 4) = -1: rowDuts(y, 5) = 14
    y = 2: rowDuts(y, 0) = 2:  rowDuts(y, 1) = 4:  rowDuts(y, 2) = 7
           rowDuts(y, 3) = 10: rowDuts(y, 4) = 12: rowDuts(y, 5) = 15
    y = 3: rowDuts(y, 0) = 16: rowDuts(y, 1) = 19: rowDuts(y, 2) = 21
           rowDuts(y, 3) = 24: rowDuts(y, 4) = 27: rowDuts(y, 5) = 29
    y = 4: rowDuts(y, 0) = 17: rowDuts(y, 1) = -1: rowDuts(y, 2) = 22
           rowDuts(y, 3) = 25: rowDuts(y, 4) = -1: rowDuts(y, 5) = 30
    y = 5: rowDuts(y, 0) = 18: rowDuts(y, 1) = 20: rowDuts(y, 2) = 23
           rowDuts(y, 3) = 26: rowDuts(y, 4) = 28: rowDuts(y, 5) = 31
   
    ' transpose column pattern
    For x = 0 To maxRowCol - 1
        For y = 0 To maxRowCol - 1
            colDuts(x, y) = rowDuts(y, x)
        Next y
    Next x
    
    ' cell patterns
    For x = 0 To maxDuts / cellSize - 1
        For y = 0 To cellSize - 1
            cellDuts(x, y) = x * cellSize + y
        Next y
    Next x
    
    For i = 0 To 31
        cbDutEnable(i).ToolTipText = "U" & i + 1
    Next i
    
    cbSRscan.caption = "Run S&R with Scan"
    
    tmrInit.enabled = True
    
exitSub:
End Sub

Public Sub resetFpga()
    Call pDrv.writeHIDuCportBit(0, 7, 0)
    Call pDrv.writeHIDuCportBit(0, 7, 1)
End Sub

Private Function readPalettePosition() As Byte

    Call readI2cField(FPGAfield(FPGA_FIELD.pos), readPalettePosition)
    
    If readPalettePosition > 0 Then
        lblPosition.caption = "Vertical"
    Else
        lblPosition.caption = "Horizontal"
    End If
    
End Function

Public Sub setDeviceI2cAddress(ByVal addr As Byte)
    devI2cBase = addr
End Sub






Private Sub resetI2cToDevice()
    Dim dummy As Long
    'Call pDrv.dReadI2cWord(devI2cBase, 0, dummy)
End Sub

Private Sub dWriteI2c(ByVal i2cAddr As Byte, ByVal addr As Byte, ByVal data As Byte)
    Call pDrv.dWriteI2c(i2cAddr, addr, data)
    resetI2cToDevice
End Sub

Private Sub dReadI2c(ByVal i2cAddr As Byte, ByVal addr As Byte, ByVal data As Byte)
    Call pDrv.dReadI2c(i2cAddr, addr, data)
    resetI2cToDevice
End Sub

Private Sub dReadI2cWord(ByVal i2cAddr As Byte, ByVal addr As Byte, data As Long)
    Call pDrv.dReadI2cWord(i2cAddr, addr, data)
    resetI2cToDevice
End Sub

Private Sub dWriteI2cWord(ByVal i2cAddr As Byte, ByVal addr As Byte, ByVal data As Long)
    Call pDrv.dWriteI2cWord(i2cAddr, addr, data)
    resetI2cToDevice
End Sub











Private Sub writeI2cField(field As IOfield, ByVal value As Byte)

    Dim cmpMask As Integer: cmpMask = &HFFFF - 2 ^ field.shift * field.mask
    
    register(field.regIdx).value = (register(field.regIdx).value And cmpMask) + 2 ^ field.shift * (value And field.mask)
    Call dWriteI2c(register(field.regIdx).i2cadd, register(field.regIdx).devAddr, register(field.regIdx).value And &HFF)
    
End Sub

Private Sub readI2cField(field As IOfield, value As Byte)

    Call dReadI2c(register(field.regIdx).i2cadd, register(field.regIdx).devAddr, register(field.regIdx).value)
    value = (register(field.regIdx).value / (2 ^ field.shift)) And field.mask
    
End Sub




Private Sub cbALL_Click()

    Dim field As Integer: field = FPGA_FIELD.All
    
    If cbALL.value = vbChecked Then
        cbALL.caption = "ALL"
    Else
        cbALL.caption = devCellUnit
    End If
    
    'Call writeI2cField(FPGAfield(field), cbALL.value)
    
End Sub

Private Sub cbCoPkg_Click()
    
    Dim field As Integer: field = FPGA_FIELD.cp
    
    If cbCoPkg.value = vbChecked Then
        cbCoPkg.caption = "Co-pkg"
    Else
        cbCoPkg.caption = "Ext LED"
    End If

    Call writeI2cField(FPGAfield(field), cbCoPkg.value)

End Sub

Private Sub cbCal_Click()
    
    Dim field As Integer: field = FPGA_FIELD.cal
    
    If cbCal.value = vbChecked Then
        cbCal.caption = "CAL"
    Else
        cbCal.caption = "Test"
    End If
    
    Call writeI2cField(FPGAfield(field), cbCal.value)

End Sub

Private Sub HScrCell_Change()
    HScrDevice.value = (HScrDevice.value And 7) + 8 * HScrCell.value
End Sub

Private Sub HScrUnit_Change()
    HScrDevice.value = (HScrDevice.value And &H18) + HScrUnit.value
End Sub

Private Sub HScrDevice_Change()

    Dim field As Integer: field = FPGA_FIELD.dut
    
    HScrCell.value = (HScrDevice.value And &H18) / 8
    HScrUnit.value = HScrDevice.value And 7
    
    Call writeI2cField(FPGAfield(field), HScrDevice.value)
    
    devCellUnit = HScrDevice.value & ":" & HScrCell.value & ":" & HScrUnit.value: cbALL_Click
    
End Sub

Private Sub cbImeas_Click()
    If cbImeas.value = vbChecked Then
        cbImeas.caption = "I:On"
        tmrAdcs.enabled = True
    Else
        cbImeas.caption = "I:Off"
        tmrAdcs.enabled = False
    End If
End Sub

Private Sub eepromTest()
    Dim reg As AER, address As Long, data As Long
    GoTo endSub
    reg = IOPROM: address = &H0
    Call pDrv.dReadI2cWord(register(reg).i2cadd, address, data)
    data = data Xor (&H55)
    Call pDrv.dWriteI2cWord(register(reg).i2cadd, address, data)
    data = 0
    Call pDrv.dReadI2cWord(register(reg).i2cadd, address, data)
endSub:
End Sub

Private Sub tmrAdcs_Timer()
    Dim reg As AER
    On Error GoTo subExit
    reg = IDDADC
    Call pDrv.dReadI2cWord(register(reg).i2cadd, register(reg).devAddr, register(reg).value)
    lblAdcs(0).caption = register(reg).value

    reg = ILEDADC
    Call pDrv.dReadI2cWord(register(reg).i2cadd, register(reg).devAddr, register(reg).value)
    lblAdcs(1).caption = register(reg).value
subExit:
End Sub

Public Function getNextEnabled(ByVal current As Integer) As Integer

    Dim valueFound As Boolean
    
    On Error GoTo endFunction

    getNextEnabled = 0
    current = (current + 1) Mod 32
    
    For x = current To maxDuts - 1
        If cbDutEnable(x).value = vbChecked Then
            getNextEnabled = x
            x = maxDuts - 1
            valueFound = True
        End If
    Next x
    
    If getNextEnabled = 0 And Not valueFound Then getNextEnabled = getNextEnabled(getNextEnabled)
    
endFunction: End Function

Public Function getSelectedClock() As Integer
    getSelectedClock = HScrDevice.value
End Function



Private Sub cbDutEnable_Click(Index As Integer)
    If cbDutEnable(Index) = vbChecked Then
        If lblLux(Index).caption = "" Then
            lblLux(Index).caption = "0000.0"
        End If
        If lblProx(Index).caption = "" Then
            lblProx(Index).caption = "0000.0"
        End If
    Else
        lblLux(Index).caption = ""
        lblProx(Index).caption = ""
    End If
End Sub



Private Sub cbDutAllEnable_Click()
    For x = 0 To maxDuts - 1
        cbDutEnable(x).value = cbDutAllEnable.value
        cbDutEnable_Click x
    Next x
End Sub

Private Sub cbDutCellEnable_Click(Index As Integer)
    For x = 0 To cellSize - 1
        cbDutEnable(cellDuts(Index, x)).value = cbDutCellEnable(Index).value
        cbDutEnable_Click cellDuts(Index, x)
    Next x
End Sub

Private Sub cbDutRowEnable_Click(Index As Integer)
    For y = 0 To maxRowCol - 1
        If rowDuts(Index, y) >= 0 Then
            cbDutEnable(rowDuts(Index, y)).value = cbDutRowEnable(Index).value
            cbDutEnable_Click rowDuts(Index, y)
        End If
    Next y
End Sub

Private Sub cbDutColEnable_Click(Index As Integer)
    For x = 0 To maxRowCol - 1
        If colDuts(Index, x) >= 0 Then
            cbDutEnable(colDuts(Index, x)).value = cbDutColEnable(Index).value
            cbDutEnable_Click colDuts(Index, x)
        End If
    Next x
End Sub







Private Sub cbPort_Click()
    If cbPort.value = vbChecked Then
        cbPort.caption = "1"
    Else
        cbPort.caption = "0"
    End If
End Sub

Private Sub cbValue_Click()
    Dim port As Integer: port = cbPort.caption
    Dim bit As Integer: bit = cmbBit.text
    Dim value As Integer
    
    If cbValue.value = vbChecked Then
        cbValue.caption = "1"
    Else
        cbValue.caption = "0"
    End If
    
    value = cbValue.caption
    
    Call pDrv.writeHIDuCportBit(port, bit, value)
    
End Sub

Private Sub cbRunTest_Click()
    If cbRunTest.value = vbChecked Then
        cbRunTest.caption = "Running"
    Else
        cbRunTest.caption = "Run Test"
    End If
End Sub

Private Sub cbScan_Click(Index As Integer)
    
    If cbScan(Index).value = vbChecked Then
    
        cbScan(Index).caption = "Scan:On"
        
        If Index Then
            proxScanEnable = True
        Else
            alsScanEnable = True
        End If
        
    Else
        
        cbScan(Index).caption = "Scan:Off"
        
        If Index Then
            proxScanEnable = False
        Else
            alsScanEnable = False
        End If
        
    End If
    
    tmrScan.enabled = alsScanEnable Or proxScanEnable
    
End Sub

Private Sub cmdReset_Click()
    cbScan(0).value = vbUnchecked: cbScan_Click 0
    cbScan(1).value = vbUnchecked: cbScan_Click 1
    dnum = 0
    'pSR.cmdArmSR_Click
End Sub

Private Sub tmrFpgaMon_Timer()
    Dim data As Byte
    Call pDrv.dReadI2c(&H50, 1, data)
    optFpgaMon.value = (data > 0)
    tmrFpgaMon.enabled = optFpgaMon.value
    tmrScan.enabled = tmrFpgaMon.enabled
    'If Not optFpgaMon.value Then MsgBox "FPGA has failed"
End Sub

Private Sub tmrInit0_Timer()
    
    If Not disableDeviceScan Then scanForDevices

    'cbScan(0).value = vbChecked: cbScan_Click 0
    tmrInit0.enabled = False
    tmrFpgaMon.enabled = True
End Sub

Private Sub tmrScan_Timer()
    Static zeroCount As Integer, lastLux As Double
    Dim lux As Double, prox As Double
    Dim idx As Integer
    
    If disableDeviceScan Then tmrScan.enabled = False: GoTo endSub
    
    If cbDutEnable(dnum).value = vbChecked Then
    
        If cbRunTest.value Then
            If Not frmTest.testDone Then frmTest.runTest
        Else
    
            If alsScanEnable Then
                Call pDrv.dGetLux(lux)
                lblLux(dnum).caption = format(lux, "0000.0")
                If lux = 0 Then
                    zeroCount = zeroCount + 1
                    If zeroCount > 31 Then
                        cbScan(0).value = vbUnchecked
                        cbScan_Click 0
                        zeroCount = 0
                    End If
                Else
                    zeroCount = 0
                    
                    If lux < lastLux / 2 Then
                        lblLux(dnum).BackColor = vbRed
                    Else
                        lblLux(dnum).BackColor = &H8000000F
                    End If
                    lastLux = lux
                End If
            Else
            End If
            
            If proxScanEnable Then
                Call pDrv.dSetEnable(1, 1)
                Call pDrv.dGetProximity(prox)
                Call pDrv.dSetEnable(1, 0)
                lblProx(dnum).caption = format(prox, "0.0000")
            Else
            End If
        
        End If
        
    End If
    
    
    If (cbRunTest.value = vbChecked And frmTest.testDone) Or cbRunTest.value = vbUnchecked Then
        idx = getNextEnabled(dnum)
        'If cbRunTest.value = vbChecked Then pPlt.send2Excel dnum
        If cbLoopScan.value = vbChecked Or idx > dnum Then
            dnum = idx
            frmEtIo.selectDevice dnum
            'If pSR.srEnabled And cbSRscan.value = vbChecked Then pSR.nextSR thao(dnum)
            If cbRunTest.value = vbChecked Then frmTest.runTest
        Else
            tmrScan.enabled = False
        End If
    End If
    
endSub: End Sub

Private Function thao(ByVal pradeep As Integer) As Integer

    thao = pradeep + 1: GoTo endFunction
        
    Select Case pradeep
    Case 0: thao = 1
    Case 1: thao = 4
    Case 2: thao = 6
    Case 3: thao = 2
    Case 4: thao = 7
    Case 5: thao = 3
    Case 6: thao = 5
    Case 7: thao = 8
    End Select
    
endFunction:
    
    thao = thao - 1 ' reference designator is one based
    
End Function

Private Sub scanForDevices()
    Dim Index As Integer, B As Byte, nChan As Long
    
    If disableDeviceScan Then cbDutEnable(0).value = 1: GoTo endSub
    
    frmEtIo.selectDevice (31)
    
    Call pDrv.dGetNchannel(nChan)
    
    For Index = 0 To 31
    
        frmEtIo.selectDevice (Index)
        
        If nChan = 1 Then ' must be an 11
        
            ' force interupt
            Call pDrv.dWriteI2cWord(&H88, &H4, &HFF) ' low treshold
            Call pDrv.dWriteI2cWord(&H88, &H6, &H0) ' hi treshold
            Call pDrv.dSetInputSelect(0, 0) ' als
            Call pDrv.dSetEnable(0, 0): Call pDrv.dSetEnable(0, 1)
            Call pDrv.dSetRange(0, 0): Call pDrv.dSetRange(0, 3)
            Call pDrv.dSetResolution(0, 2) ' 8 bit
            Sleep 100
            '                    a, s, m, d
            Call pDrv.dReadField(0, 2, 1, B)
            Call pDrv.dSetResolution(0, 0) ' 16 bit
            
            If B = 0 Then
                cbDutEnable(Index).value = 0
                lblLux(Index).caption = ""
            Else
                Call pDrv.dSetResolution(0, 0) ' 16 bit
                ' disable interrupt
                Call pDrv.dWriteI2cWord(&H88, &H4, &H0) ' low treshold
                Call pDrv.dWriteI2cWord(&H88, &H6, &HFF) ' hi treshold
            End If
                
        Else
        
            Call pDrv.dReadField(0, 0, &HFF, B)
            
            If B = 0 Then
                cbDutEnable(Index).value = 0
                lblLux(Index).caption = ""
            Else
                cbDutEnable(Index).value = 1
                Call pDrv.dSetEnable(0, 1)
                Call pDrv.dSetRange(0, 2)
                Call pDrv.dSetIrdr(3)
                Call pDrv.dSetSleep(7)
            End If
        
        End If
        
    Next Index
    
    frmEtIo.selectDevice (getNextEnabled(31))
    
endSub: End Sub


Private Sub Form_Load0()
End Sub


