VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmRGBscan 
   Caption         =   "RGB Scan"
   ClientHeight    =   5625
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   10545
   LinkTopic       =   "Form1"
   ScaleHeight     =   5625
   ScaleWidth      =   10545
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame fmLux 
      Caption         =   "CCT"
      Height          =   1815
      Index           =   4
      Left            =   0
      TabIndex        =   155
      Top             =   3720
      Width           =   5175
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   159
         Left            =   4320
         TabIndex        =   187
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   158
         Left            =   4320
         TabIndex        =   186
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   157
         Left            =   4320
         TabIndex        =   185
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   156
         Left            =   3480
         TabIndex        =   184
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   155
         Left            =   3480
         TabIndex        =   183
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   154
         Left            =   2640
         TabIndex        =   182
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   153
         Left            =   2640
         TabIndex        =   181
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   152
         Left            =   2640
         TabIndex        =   180
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   151
         Left            =   1800
         TabIndex        =   179
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   150
         Left            =   1800
         TabIndex        =   178
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   149
         Left            =   1800
         TabIndex        =   177
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   148
         Left            =   960
         TabIndex        =   176
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   147
         Left            =   960
         TabIndex        =   175
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   146
         Left            =   120
         TabIndex        =   174
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   145
         Left            =   120
         TabIndex        =   173
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   144
         Left            =   120
         TabIndex        =   172
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   143
         Left            =   4320
         TabIndex        =   171
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   142
         Left            =   4320
         TabIndex        =   170
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   141
         Left            =   4320
         TabIndex        =   169
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   140
         Left            =   3480
         TabIndex        =   168
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   139
         Left            =   3480
         TabIndex        =   167
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   138
         Left            =   2640
         TabIndex        =   166
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   137
         Left            =   2640
         TabIndex        =   165
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   136
         Left            =   2640
         TabIndex        =   164
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   135
         Left            =   1800
         TabIndex        =   163
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   134
         Left            =   1800
         TabIndex        =   162
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   133
         Left            =   1800
         TabIndex        =   161
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   132
         Left            =   960
         TabIndex        =   160
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   131
         Left            =   960
         TabIndex        =   159
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   130
         Left            =   120
         TabIndex        =   158
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   129
         Left            =   120
         TabIndex        =   157
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   128
         Left            =   120
         TabIndex        =   156
         Top             =   1440
         Width           =   735
      End
   End
   Begin VB.Frame fmLux 
      Caption         =   "Red"
      Height          =   1815
      Index           =   1
      Left            =   5280
      TabIndex        =   56
      Top             =   120
      Width           =   5175
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   32
         Left            =   120
         TabIndex        =   88
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   33
         Left            =   120
         TabIndex        =   87
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   34
         Left            =   120
         TabIndex        =   86
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   35
         Left            =   960
         TabIndex        =   85
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   36
         Left            =   960
         TabIndex        =   84
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   37
         Left            =   1800
         TabIndex        =   83
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   38
         Left            =   1800
         TabIndex        =   82
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   39
         Left            =   1800
         TabIndex        =   81
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   40
         Left            =   2640
         TabIndex        =   80
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   41
         Left            =   2640
         TabIndex        =   79
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   42
         Left            =   2640
         TabIndex        =   78
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   43
         Left            =   3480
         TabIndex        =   77
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   44
         Left            =   3480
         TabIndex        =   76
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   45
         Left            =   4320
         TabIndex        =   75
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   46
         Left            =   4320
         TabIndex        =   74
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   47
         Left            =   4320
         TabIndex        =   73
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   48
         Left            =   120
         TabIndex        =   72
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   49
         Left            =   120
         TabIndex        =   71
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   50
         Left            =   120
         TabIndex        =   70
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   51
         Left            =   960
         TabIndex        =   69
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   52
         Left            =   960
         TabIndex        =   68
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   53
         Left            =   1800
         TabIndex        =   67
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   54
         Left            =   1800
         TabIndex        =   66
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   55
         Left            =   1800
         TabIndex        =   65
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   56
         Left            =   2640
         TabIndex        =   64
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   57
         Left            =   2640
         TabIndex        =   63
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   58
         Left            =   2640
         TabIndex        =   62
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   59
         Left            =   3480
         TabIndex        =   61
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   60
         Left            =   3480
         TabIndex        =   60
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   61
         Left            =   4320
         TabIndex        =   59
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   62
         Left            =   4320
         TabIndex        =   58
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   63
         Left            =   4320
         TabIndex        =   57
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame Frame4 
      Height          =   855
      Left            =   0
      TabIndex        =   52
      Top             =   0
      Width           =   5175
      Begin VB.CommandButton cmdClrStack 
         Caption         =   "Clear"
         Height          =   255
         Left            =   4200
         TabIndex        =   192
         Top             =   360
         Width           =   855
      End
      Begin VB.CheckBox cbScan 
         Caption         =   "Scan:Off"
         Height          =   255
         Left            =   4200
         Style           =   1  'Graphical
         TabIndex        =   53
         Top             =   120
         Width           =   855
      End
      Begin VB.Label lblStats 
         Caption         =   "Blue"
         Height          =   255
         Index           =   3
         Left            =   2160
         TabIndex        =   191
         Top             =   360
         Width           =   1920
      End
      Begin VB.Label lblStats 
         Caption         =   "Red"
         Height          =   255
         Index           =   1
         Left            =   2160
         TabIndex        =   190
         Top             =   120
         Width           =   1920
      End
      Begin VB.Label lblStats 
         Caption         =   "CCT"
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   189
         Top             =   360
         Width           =   1920
      End
      Begin VB.Label lblStats 
         Caption         =   "Lux"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   188
         Top             =   120
         Width           =   1920
      End
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   4800
      Top             =   840
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Timer tmrRGBscan 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   4800
      Top             =   1440
   End
   Begin VB.Frame fmLux 
      Caption         =   "Lux/ UnCorrected Green"
      Height          =   1815
      Index           =   0
      Left            =   0
      TabIndex        =   19
      Top             =   1920
      Width           =   5175
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   31
         Left            =   4320
         TabIndex        =   51
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   30
         Left            =   4320
         TabIndex        =   50
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   29
         Left            =   4320
         TabIndex        =   49
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   28
         Left            =   3480
         TabIndex        =   48
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   27
         Left            =   3480
         TabIndex        =   47
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   26
         Left            =   2640
         TabIndex        =   46
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   25
         Left            =   2640
         TabIndex        =   45
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   24
         Left            =   2640
         TabIndex        =   44
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   23
         Left            =   1800
         TabIndex        =   43
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   22
         Left            =   1800
         TabIndex        =   42
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   21
         Left            =   1800
         TabIndex        =   41
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   20
         Left            =   960
         TabIndex        =   40
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   19
         Left            =   960
         TabIndex        =   39
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   18
         Left            =   120
         TabIndex        =   38
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   17
         Left            =   120
         TabIndex        =   37
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   16
         Left            =   120
         TabIndex        =   36
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   15
         Left            =   4320
         TabIndex        =   35
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   14
         Left            =   4320
         TabIndex        =   34
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   13
         Left            =   4320
         TabIndex        =   33
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   12
         Left            =   3480
         TabIndex        =   32
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   11
         Left            =   3480
         TabIndex        =   31
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   10
         Left            =   2640
         TabIndex        =   30
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   9
         Left            =   2640
         TabIndex        =   29
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   8
         Left            =   2640
         TabIndex        =   28
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   7
         Left            =   1800
         TabIndex        =   27
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   6
         Left            =   1800
         TabIndex        =   26
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   5
         Left            =   1800
         TabIndex        =   25
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   4
         Left            =   960
         TabIndex        =   24
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   3
         Left            =   960
         TabIndex        =   23
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   22
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   21
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   20
         Top             =   1440
         Width           =   735
      End
   End
   Begin VB.Frame fmCoef 
      Caption         =   "Coefficients"
      Height          =   1095
      Left            =   0
      TabIndex        =   0
      Top             =   840
      Width           =   4695
      Begin VB.CheckBox cbCoeffEn 
         Caption         =   "Disabled"
         Height          =   255
         Left            =   3840
         Style           =   1  'Graphical
         TabIndex        =   55
         Top             =   480
         Width           =   735
      End
      Begin VB.CommandButton cmdLoadCoeff 
         Caption         =   "Load"
         Height          =   255
         Left            =   3840
         TabIndex        =   54
         Top             =   240
         Width           =   495
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   8
         Left            =   3000
         MultiLine       =   -1  'True
         TabIndex        =   13
         Text            =   "frmRGBscan.frx":0000
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   7
         Left            =   3000
         MultiLine       =   -1  'True
         TabIndex        =   12
         Text            =   "frmRGBscan.frx":0009
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   6
         Left            =   3000
         MultiLine       =   -1  'True
         TabIndex        =   11
         Text            =   "frmRGBscan.frx":0012
         Top             =   240
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   5
         Left            =   1800
         MultiLine       =   -1  'True
         TabIndex        =   10
         Text            =   "frmRGBscan.frx":001B
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   4
         Left            =   1800
         MultiLine       =   -1  'True
         TabIndex        =   9
         Text            =   "frmRGBscan.frx":0024
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   3
         Left            =   1800
         MultiLine       =   -1  'True
         TabIndex        =   8
         Text            =   "frmRGBscan.frx":002D
         Top             =   240
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   2
         Left            =   600
         MultiLine       =   -1  'True
         TabIndex        =   3
         Text            =   "frmRGBscan.frx":0036
         Top             =   720
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   1
         Left            =   600
         MultiLine       =   -1  'True
         TabIndex        =   2
         Text            =   "frmRGBscan.frx":003F
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox tbCoef 
         Height          =   285
         Index           =   0
         Left            =   600
         MultiLine       =   -1  'True
         TabIndex        =   1
         Text            =   "frmRGBscan.frx":0048
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Kbg"
         Height          =   285
         Index           =   8
         Left            =   2520
         TabIndex        =   18
         Top             =   720
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Kbr"
         Height          =   285
         Index           =   7
         Left            =   2520
         TabIndex        =   17
         Top             =   480
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Kgb"
         Height          =   285
         Index           =   6
         Left            =   2520
         TabIndex        =   16
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Kgr"
         Height          =   285
         Index           =   5
         Left            =   1320
         TabIndex        =   15
         Top             =   720
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Krb"
         Height          =   285
         Index           =   4
         Left            =   1320
         TabIndex        =   14
         Top             =   480
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "Krg"
         Height          =   285
         Index           =   3
         Left            =   1320
         TabIndex        =   7
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "g"
         BeginProperty Font 
            Name            =   "Symbol"
            Size            =   12
            Charset         =   2
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   2
         Left            =   120
         TabIndex        =   6
         Top             =   720
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "b"
         BeginProperty Font 
            Name            =   "Symbol"
            Size            =   12
            Charset         =   2
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Top             =   480
         Width           =   375
      End
      Begin VB.Label lblCoef 
         Alignment       =   1  'Right Justify
         Caption         =   "a"
         BeginProperty Font 
            Name            =   "Symbol"
            Size            =   12
            Charset         =   2
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   240
         Width           =   375
      End
   End
   Begin VB.Frame fmLux 
      Caption         =   "Blue"
      Height          =   1815
      Index           =   3
      Left            =   5280
      TabIndex        =   122
      Top             =   3720
      Width           =   5175
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   96
         Left            =   120
         TabIndex        =   154
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   97
         Left            =   120
         TabIndex        =   153
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   98
         Left            =   120
         TabIndex        =   152
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   99
         Left            =   960
         TabIndex        =   151
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   100
         Left            =   960
         TabIndex        =   150
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   101
         Left            =   1800
         TabIndex        =   149
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   102
         Left            =   1800
         TabIndex        =   148
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   103
         Left            =   1800
         TabIndex        =   147
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   104
         Left            =   2640
         TabIndex        =   146
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   105
         Left            =   2640
         TabIndex        =   145
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   106
         Left            =   2640
         TabIndex        =   144
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   107
         Left            =   3480
         TabIndex        =   143
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   108
         Left            =   3480
         TabIndex        =   142
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   109
         Left            =   4320
         TabIndex        =   141
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   110
         Left            =   4320
         TabIndex        =   140
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   111
         Left            =   4320
         TabIndex        =   139
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   112
         Left            =   120
         TabIndex        =   138
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   113
         Left            =   120
         TabIndex        =   137
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   114
         Left            =   120
         TabIndex        =   136
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   115
         Left            =   960
         TabIndex        =   135
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   116
         Left            =   960
         TabIndex        =   134
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   117
         Left            =   1800
         TabIndex        =   133
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   118
         Left            =   1800
         TabIndex        =   132
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   119
         Left            =   1800
         TabIndex        =   131
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   120
         Left            =   2640
         TabIndex        =   130
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   121
         Left            =   2640
         TabIndex        =   129
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   122
         Left            =   2640
         TabIndex        =   128
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   123
         Left            =   3480
         TabIndex        =   127
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   124
         Left            =   3480
         TabIndex        =   126
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   125
         Left            =   4320
         TabIndex        =   125
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   126
         Left            =   4320
         TabIndex        =   124
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   127
         Left            =   4320
         TabIndex        =   123
         Top             =   240
         Width           =   735
      End
   End
   Begin VB.Frame fmLux 
      Caption         =   "Green"
      Height          =   1815
      Index           =   2
      Left            =   5280
      TabIndex        =   89
      Top             =   1920
      Width           =   5175
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   95
         Left            =   4320
         TabIndex        =   121
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   94
         Left            =   4320
         TabIndex        =   120
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   93
         Left            =   4320
         TabIndex        =   119
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   92
         Left            =   3480
         TabIndex        =   118
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   91
         Left            =   3480
         TabIndex        =   117
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   90
         Left            =   2640
         TabIndex        =   116
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   89
         Left            =   2640
         TabIndex        =   115
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   88
         Left            =   2640
         TabIndex        =   114
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   87
         Left            =   1800
         TabIndex        =   113
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   86
         Left            =   1800
         TabIndex        =   112
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   85
         Left            =   1800
         TabIndex        =   111
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   84
         Left            =   960
         TabIndex        =   110
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   83
         Left            =   960
         TabIndex        =   109
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   82
         Left            =   120
         TabIndex        =   108
         Top             =   240
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   81
         Left            =   120
         TabIndex        =   107
         Top             =   480
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   80
         Left            =   120
         TabIndex        =   106
         Top             =   720
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   79
         Left            =   4320
         TabIndex        =   105
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   78
         Left            =   4320
         TabIndex        =   104
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   77
         Left            =   4320
         TabIndex        =   103
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   76
         Left            =   3480
         TabIndex        =   102
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   75
         Left            =   3480
         TabIndex        =   101
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   74
         Left            =   2640
         TabIndex        =   100
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   73
         Left            =   2640
         TabIndex        =   99
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   72
         Left            =   2640
         TabIndex        =   98
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   71
         Left            =   1800
         TabIndex        =   97
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   70
         Left            =   1800
         TabIndex        =   96
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   69
         Left            =   1800
         TabIndex        =   95
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   68
         Left            =   960
         TabIndex        =   94
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   67
         Left            =   960
         TabIndex        =   93
         Top             =   1440
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   66
         Left            =   120
         TabIndex        =   92
         Top             =   960
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   65
         Left            =   120
         TabIndex        =   91
         Top             =   1200
         Width           =   735
      End
      Begin VB.Label lblLux 
         Alignment       =   1  'Right Justify
         Caption         =   "88888.88"
         Height          =   255
         Index           =   64
         Left            =   120
         TabIndex        =   90
         Top             =   1440
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmRGBscan"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Enum rgbCo
    Alpha
    Beta
    Gamma
    Krg
    Krb
    Kgr
    Kgb
    Kbr
    Kbg
End Enum

Private Type rgbData
    red As Double
    green As Double
    blue As Double
    lux As Double
    cct As Double
End Type

Private etio As frmEtIo
Private dut As ucALSusb

Private rgbConst(8) As Double
Private rgbD(31) As rgbData

Private firstDnum As Integer
Private dnum As Integer
Private lastDnum As Integer
Private clr As Integer

Private Type stats
    last As Double
    mean As Double
    stdev As Double
End Type

Private Type pixelStats
    red As stats
    green As stats
    blue As stats
End Type

Private measData As pixelStats

Public pRGB As clsRGBmeasure

Dim nDev As Integer

Public Function getRBGdata(index As Integer, Optional stdev As Single, Optional getSingle As Boolean = True) As Single
    If getSingle Then
        Select Case index
        Case 0: getRBGdata = measData.red.last: stdev = measData.red.stdev
        Case 1: getRBGdata = measData.green.last: stdev = measData.green.stdev
        Case 2: getRBGdata = measData.blue.last: stdev = measData.blue.stdev
        End Select
    Else
        Select Case index
        Case 0: getRBGdata = measData.red.mean: stdev = measData.red.stdev
        Case 1: getRBGdata = measData.green.mean: stdev = measData.green.stdev
        Case 2: getRBGdata = measData.blue.mean: stdev = measData.blue.stdev
        End Select
    End If
End Function

Public Sub resetStack()
    updateLabel 0, 0, "", True
End Sub

Private Sub cbCoeffEn_Click()

    If cbCoeffEn.value = vbChecked Then
        cbCoeffEn.caption = "Enabled"
        Call dut.dSetRgbCoeffEnable(1)
    Else
        cbCoeffEn.caption = "Disabled"
        Call dut.dSetRgbCoeffEnable(0)
    End If
    
    If cbScan.value = vbChecked Then
        cbScan_Click
        cbScan_Click
    Else
        resetStack
    End If
    
End Sub

Private Sub cbScan_Click()
    
    If cbScan.value = vbChecked Then
        cbScan.caption = "Scan:on"
        dnum = 0: lastDnum = dnum
        resetStack
    Else
        cbScan.caption = "Scan:off"
    End If

End Sub

Private Sub loadRgbCoeff()
    If gPartNumber = 29125 Then
        Call dut.dLoadRgbCoeff(rgbConst)
    End If
    For i = 0 To 8: tbCoef(i).text = rgbConst(i): Next i
End Sub

Private Sub cmdClrStack_Click()
    resetStack
End Sub

Private Sub cmdLoadCoeff_Click()
    Dim data(8) As Double
    CommonDialog1.ShowOpen
    On Error GoTo exitSub
    Open CommonDialog1.fileName For Input As #1
    For i = 0 To 8
        If Not EOF(1) Then
            Input #1, data(i)
        Else
            i = 10 ' error
        End If
    Next i
    
    Close #1
    
    If i = 9 Then
        For i = 0 To 8
            rgbConst(i) = data(i)
        Next i
    Else
        MsgBox ("Error reading:" & CommonDialog1.fileName)
    End If
    
    cbCoeffEn.value = vbChecked: cbCoeffEn_Click
    loadRgbCoeff
    
exitSub:
    
End Sub

Private Sub mnuFile_Click()
    Dim data(8) As Double
    CommonDialog1.ShowOpen
    Open CommonDialog1.fileName For Input As #1
    For i = 0 To 8
        If Not EOF(1) Then
            Input #1, data(i)
        Else
            i = 10 ' error
        End If
    Next i
    
    Close #1
    
    If i = 9 Then
        For i = 0 To 8
            rgbConst(i) = data(i)
        Next i
    Else
        MsgBox ("Error reading:" & CommonDialog1.fileName)
    End If
    
    loadRgbCoeff
    
End Sub

Sub updateLabel(ByVal idx As Integer, val As Double, fmt As String, Optional clrAvg As Boolean = False)

    Static sumAry(4, 31) As Double, sum2Ary(4, 31) As Double
    Static sum(4) As Double, sum2(4) As Double
    Static Count As Integer, stopCount As Boolean
    Static pointer As Integer
    
    Dim mean As Double, stdev As Double
    Dim i As Integer, j As Integer
    
    On Error GoTo exitSub
    
    If clrAvg Then
    
        For i = 0 To 4
        
            For j = 0 To 31
                sumAry(i, j) = 0: sum2Ary(i, j) = 0
                lblLux(j + i * 32).caption = ""
            Next j
            
            sum(i) = 0: sum2(i) = 0: Count = 0: stopCount = False: pointer = 31
            
            dnum = etio.getNextEnabled(31)
            
        Next i
        
    Else
        If val < 100000 Then
        'If cbScan.value = vbChecked Then 'And val < 10000 Then
        
            If lastDnum > dnum Or _
                            (cbScan.value = vbUnchecked And Count >= nDev) Or _
                            (cbScan.value = vbChecked And Count >= 32) _
                            Then ' rollover
                stopCount = True
            Else
                If Not stopCount And idx = 0 Then Count = Count + 1
            End If
            
            If Count < nDev Then Count = Count + 1 ' <<<<<<<<<<<< JWG
            
            If cbScan.value = vbChecked Then
                pointer = dnum
            Else
                If idx = 0 Then pointer = (pointer + 1) Mod 31
            End If
            
            sum(idx) = sum(idx) - sumAry(idx, pointer): sumAry(idx, pointer) = val: sum(idx) = sum(idx) + val
            sum2(idx) = sum2(idx) - sum2Ary(idx, pointer): sum2Ary(idx, pointer) = val * val: sum2(idx) = sum2(idx) + val * val
            
            If Count > 0 Then
                mean = sum(idx) / Count
            Else
                mean = 0
            End If
            
            If mean > 0 Then
                stdev = 150 * (Abs(sum2(idx) / Count - mean * mean) ^ 0.5) / mean ' 1.5stdev as %/value
            Else
                stdev = 0
            End If
            
            Select Case idx
                Case 0: lblStats(idx).caption = "Lux=" & format(mean, "####.0") & " +/-" & format(stdev, "###.0") & "%"
                        measData.green.mean = mean: measData.green.stdev = stdev
                Case 1: lblStats(idx).caption = "Red=" & format(mean, "####.0") & " +/-" & format(stdev, "###.0") & "%"
                        measData.red.mean = mean: measData.red.stdev = stdev
                Case 3: lblStats(idx).caption = "Blue=" & format(mean, "####.0") & " +/-" & format(stdev, "###.0") & "%"
                        measData.blue.mean = mean: measData.blue.stdev = stdev
                Case 4: lblStats(idx).caption = "CCT=" & format(mean, "####.0") & " +/-" & format(stdev, "###.0") & "%"
            End Select
            
        End If
    
        idx = idx * 32
        lblLux(dnum + idx).BackColor = vbGreen
        lblLux(dnum + idx) = format(val, fmt)
        lblLux(lastDnum + idx).BackColor = vbButtonFace
    End If
exitSub:
End Sub

Private Sub tmrRGBscan_Timer()

    Dim value As Double, thisDnum As Integer
    Dim blue As Double, red As Double
    Dim x As Double, y As Double, n As Double
    Dim range As Long, fs As Double
    Static luxSum As Double, lux2sum As Double
    Static cctSum As Double, cct2sum As Double
    Static Count As Integer
    Dim i As Integer
    Dim irComp As Long
    
    On errror GoTo endSub
    
    If gPartNumber = 29125 Then
        Call dut.dGetRed(rgbD(dnum).red): measData.red.last = rgbD(dnum).red
        Call dut.dGetGreen(rgbD(dnum).green): measData.green.last = rgbD(dnum).green
        Call dut.dGetBlue(rgbD(dnum).blue): measData.blue.last = rgbD(dnum).blue
        Call dut.dGetCCT(rgbD(dnum).cct)
        Call dut.dGetLux(rgbD(dnum).lux)
        Call dut.dGetIRcomp(irComp)
    Else
    
        Call dut.dGetLux(value)
        
        dnum = etio.getSelectedClock
        
        ' record raw value
        Select Case clr
        Case 0: rgbD(dnum).red = value
        Case 1: rgbD(dnum).green = value
        Case 2: rgbD(dnum).blue = value
        End Select
    
    End If
    
    Call dut.dGetRange(0, range) '          Set range
    
    If gPartNumber <> 29125 Then
        fs = 1600 * (1 + 4 * range)
    Else
        Select Case range
        Case 0: fs = 330
        Case 1: fs = 1600
        End Select
    End If
    
    Call dut.dSetRange(0, 2 - range)
    Call dut.dSetRange(0, range)
    
    Call dut.dSetIRcomp(irComp Xor &HFF) '   Set Compensation
    Call dut.dSetIRcomp(irComp)
        
    ' apply coefficients to completed RGB values
    If (rgbD(dnum).red * rgbD(dnum).green * rgbD(dnum).blue) + 1 > 0 Then
    
        If gPartNumber <> 29125 Then
    
            red = rgbConst(rgbCo.Alpha) * ( _
                                                   rgbD(dnum).red + _
                             rgbConst(rgbCo.Krg) * rgbD(dnum).green + _
                             rgbConst(rgbCo.Krb) * rgbD(dnum).blue)
                             
            rgbD(dnum).lux = rgbConst(rgbCo.Beta) * ( _
                             rgbConst(rgbCo.Kgr) * rgbD(dnum).red + _
                                                   rgbD(dnum).green + _
                             rgbConst(rgbCo.Kgb) * rgbD(dnum).blue)
    
            blue = rgbConst(rgbCo.Gamma) * ( _
                             rgbConst(rgbCo.Kbr) * rgbD(dnum).red + _
                             rgbConst(rgbCo.Kbg) * rgbD(dnum).green + _
                                                   rgbD(dnum).blue)
                             
        
            x = red / (red + rgbD(dnum).lux + blue)
            y = rgbD(dnum).lux / (red + rgbD(dnum).lux + blue)
            n = (x - 0.332) / (y - 0.1858)
        
            rgbD(dnum).cct = -449 * n ^ 3 + 3525 * n ^ 2 - 6823.3 * n + 5520.33
            
        End If
        
        Call updateLabel(0, rgbD(dnum).lux, "#####.00")
        Call updateLabel(1, rgbD(dnum).red, "#####.00")
        Call updateLabel(2, rgbD(dnum).green, "#####.00")
        Call updateLabel(3, rgbD(dnum).blue, "#####.00")
        Call updateLabel(4, rgbD(dnum).cct, "####.0")
        
        ' Highlight saturated values
        If rgbD(dnum).red = fs Or rgbD(dnum).green = fs Or rgbD(dnum).blue = fs Then
            For i = 0 To 4
                lblLux(dnum + i * 32).BackColor = vbRed
            Next i
        End If
    Else
        For i = 0 To 4
            lblLux(dnum + i * 32).BackColor = vbCyan
        Next i
    End If
    
    If gPartNumber <> 29125 Then
        
        ' next color
        Select Case clr ' 120/121 shuffle
        Case 0: Call dut.dSetInputSelect(0, 2)
        Case 1: Call dut.dSetInputSelect(0, 1)
        Case 2: Call dut.dSetInputSelect(0, 0)
        End Select
        
    End If
    
    If cbScan.value = vbChecked Then
    
        tmrRGBscan.Interval = 100
    
        thisDnum = dnum
        lastDnum = dnum
        dnum = etio.getNextEnabled(dnum):
        etio.selectDevice (dnum)
        
        If dnum < thisDnum Then
            clr = (clr + 1) Mod 3
            
            If Count > 0 Then
                On Error GoTo skipError
                luxSum = luxSum / Count
                lblLuxStats.caption = "Lux_Mean= " & format(luxSum, "#####.00")
                
                If luxSum <> 0 Then
                    lux2sum = 100 * (Abs((lux2sum / Count - luxSum * luxSum)) ^ 0.5) / luxSum
                Else
                    lux2sum = 0
                End If
                
                lblLuxStats.caption = lblLuxStats.caption & _
                    " +/- " & format(lux2sum, "#####.00") & " %"
                
                cctSum = cctSum / Count
                lblCctStats.caption = "CCT_Mean= " & format(cctSum, "#####.00")
                
                If cctSum <> 0 Then
                    cct2sum = 100 * (Abs((cct2sum / Count - cctSum * cctSum)) ^ 0.5) / cctSum
                Else
                    cctSum = 0
                End If
                
                lblCctStats.caption = lblCctStats.caption & _
                    " +/- " & format(cct2sum, "#####.00") & " %"
                    
                Debug.Print lblLuxStats.caption, " ", lblCctStats.caption
skipError:
                luxSum = 0: lux2sum = 0
                cctSum = 0: cct2sum = 0
                Count = 0
            End If
        Else
        
            If dnum > thisDnum + 1 Then
                For i = thisDnum + 1 To dnum - 1
                    For j = 0 To 4
                        lblLux(i + j * 32).caption = ""
                    Next j
                Next i
            End If
            
            luxSum = luxSum + rgbD(thisDnum).lux
            'lux2sum = lux2sum + rgbD(thisDnum).lux * rgbD(thisDnum).lux
            cctSum = cctSum + rgbD(thisDnum).cct
            cct2sum = cct2sum + rgbD(thisDnum).cct * rgbD(thisDnum).cct
            Count = Count + 1
        End If
        
    Else
        clr = (clr + 1) Mod 3
        tmrRGBscan.Interval = 400
    End If
    
endSub: End Sub

Private Sub loadConstants()
    
    Dim i As Integer

    rgbConst(rgbCo.Alpha) = 0.66074358
    rgbConst(rgbCo.Beta) = 1.165203992
    rgbConst(rgbCo.Gamma) = 1.813961241
    rgbConst(rgbCo.Krg) = 0.596955505
    rgbConst(rgbCo.Krb) = -0.096484902
    rgbConst(rgbCo.Kgr) = 0.141201269
    rgbConst(rgbCo.Kgb) = -0.459269119
    rgbConst(rgbCo.Kbr) = -0.103456125
    rgbConst(rgbCo.Kbg) = -0.262359828
    
    For i = 0 To 8
        tbCoef(i).text = rgbConst(i) & Chr$(13)
    Next i
End Sub

Private Sub clearDisplay()

    Dim i As Integer, j As Integer
    
    For i = 0 To 31
        For j = 0 To 4
            lblLux(i + j * 32).caption = ""
        Next j
        
        rgbD(i).red = 0
        rgbD(i).green = 0
        rgbD(i).blue = 0
    Next i

End Sub

Private Sub Form_Load()

    Dim i As Integer

    loadConstants
    clearDisplay
    
    Set etio = frmEtIo
    Set dut = frmMain.ucALSusb1
    Set pRGB = New clsRGBmeasure
    
    firstDnum = etio.getNextEnabled(31)
    dnum = firstDnum
    clr = 0
    
    tmrRGBscan.enabled = True
    
    nDev = 1
    
    While etio.getNextEnabled(dnum) > dnum
        dnum = etio.getNextEnabled(dnum)
        nDev = nDev + 1
    Wend
    
    resetStack
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    tmrRGBscan.enabled = False
    etio.selectDevice firstDnum
    
End Sub

Private Sub tbCoef_Change(index As Integer)

    If enterText(tbCoef(index).text) Then
        rgbConst(index) = val(tbCoef(index).text)
        tbCoef(index).text = format(rgbConst(index), "##.#####")
    Else
    End If
    
End Sub

