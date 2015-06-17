VERSION 5.00
Begin VB.Form frmSimpleRGB 
   Caption         =   "Chroma Meter"
   ClientHeight    =   9090
   ClientLeft      =   225
   ClientTop       =   870
   ClientWidth     =   10140
   Icon            =   "frmSimpleRGB.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   9090
   ScaleWidth      =   10140
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame frmBars 
      Height          =   9045
      Left            =   2100
      TabIndex        =   45
      Top             =   0
      Visible         =   0   'False
      Width           =   7995
      Begin SimpleRGB.ucBarGraph ucBarGraph_sRGB 
         Height          =   2295
         Left            =   120
         TabIndex        =   69
         Top             =   4560
         Width           =   7815
         _ExtentX        =   13785
         _ExtentY        =   4048
      End
      Begin VB.Frame Frame11 
         Caption         =   "sRGB"
         Height          =   1095
         Left            =   2640
         TabIndex        =   65
         Top             =   6840
         Width           =   735
         Begin VB.Label lblSrgbVal 
            Caption         =   "BLU"
            Height          =   255
            Index           =   2
            Left            =   120
            TabIndex        =   68
            Top             =   720
            Width           =   375
         End
         Begin VB.Label lblSrgbVal 
            Caption         =   "GRN"
            Height          =   255
            Index           =   1
            Left            =   120
            TabIndex        =   67
            Top             =   480
            Width           =   375
         End
         Begin VB.Label lblSrgbVal 
            Caption         =   "RED"
            Height          =   255
            Index           =   0
            Left            =   120
            TabIndex        =   66
            Top             =   240
            Width           =   375
         End
      End
      Begin VB.Frame Frame10 
         Caption         =   "Graph Scale"
         Height          =   735
         Left            =   120
         TabIndex        =   60
         Top             =   6840
         Width           =   2415
         Begin VB.CommandButton cmbGraphRangeOnce 
            Caption         =   "Rescale"
            Height          =   375
            Left            =   1200
            TabIndex        =   62
            Top             =   240
            Width           =   1095
         End
         Begin VB.CheckBox cbGraphAutoLock 
            Caption         =   "Auto Range"
            Height          =   375
            Left            =   120
            Style           =   1  'Graphical
            TabIndex        =   61
            Top             =   240
            Width           =   1095
         End
      End
      Begin VB.Frame Frame9 
         Caption         =   "RGB Codes"
         Height          =   2055
         Left            =   120
         TabIndex        =   53
         Top             =   240
         Width           =   7695
         Begin VB.PictureBox picRGB 
            BackColor       =   &H000000FF&
            Height          =   375
            Index           =   0
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   56
            Top             =   480
            Width           =   7340
         End
         Begin VB.PictureBox picRGB 
            BackColor       =   &H0000FF00&
            Height          =   375
            Index           =   1
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   55
            Top             =   960
            Width           =   7340
         End
         Begin VB.PictureBox picRGB 
            BackColor       =   &H00FF0000&
            Height          =   375
            Index           =   2
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   54
            Top             =   1440
            Width           =   7340
         End
         Begin VB.Label lblRGB 
            Alignment       =   2  'Center
            Caption         =   "100k"
            Height          =   255
            Index           =   0
            Left            =   7260
            TabIndex        =   59
            Top             =   120
            Width           =   375
         End
         Begin VB.Label lblRGB 
            Alignment       =   2  'Center
            Caption         =   "50k"
            Height          =   255
            Index           =   1
            Left            =   3590
            TabIndex        =   58
            Top             =   120
            Width           =   375
         End
         Begin VB.Label lblRGB 
            Alignment       =   2  'Center
            Caption         =   "20k"
            Height          =   255
            Index           =   2
            Left            =   1388
            TabIndex        =   57
            Top             =   120
            Width           =   375
         End
         Begin VB.Line lnRGB 
            BorderWidth     =   2
            Index           =   0
            X1              =   7460
            X2              =   7460
            Y1              =   1920
            Y2              =   120
         End
         Begin VB.Line lnRGB 
            BorderWidth     =   2
            Index           =   1
            X1              =   3790
            X2              =   3790
            Y1              =   1920
            Y2              =   120
         End
         Begin VB.Line lnRGB 
            BorderWidth     =   2
            Index           =   2
            X1              =   1588
            X2              =   1588
            Y1              =   1920
            Y2              =   120
         End
      End
      Begin VB.Frame Frame8 
         Caption         =   "XYZ"
         Height          =   2055
         Left            =   120
         TabIndex        =   46
         Top             =   2400
         Width           =   7695
         Begin VB.PictureBox picXYZ 
            BackColor       =   &H00FF0000&
            Height          =   375
            Index           =   2
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   49
            Top             =   1440
            Width           =   7340
         End
         Begin VB.PictureBox picXYZ 
            BackColor       =   &H0000FF00&
            Height          =   375
            Index           =   1
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   48
            Top             =   960
            Width           =   7340
         End
         Begin VB.PictureBox picXYZ 
            BackColor       =   &H000000FF&
            Height          =   375
            Index           =   0
            Left            =   120
            ScaleHeight     =   315
            ScaleWidth      =   7275
            TabIndex        =   47
            Top             =   480
            Width           =   7340
         End
         Begin VB.Label lblXYZ 
            Alignment       =   2  'Center
            Caption         =   "20k"
            Height          =   255
            Index           =   2
            Left            =   1388
            TabIndex        =   52
            Top             =   120
            Width           =   375
         End
         Begin VB.Line lnXYZ 
            BorderWidth     =   2
            Index           =   2
            X1              =   1588
            X2              =   1588
            Y1              =   1920
            Y2              =   120
         End
         Begin VB.Label lblXYZ 
            Alignment       =   2  'Center
            Caption         =   "50k"
            Height          =   255
            Index           =   1
            Left            =   3590
            TabIndex        =   51
            Top             =   120
            Width           =   375
         End
         Begin VB.Line lnXYZ 
            BorderWidth     =   2
            Index           =   1
            X1              =   3790
            X2              =   3790
            Y1              =   1920
            Y2              =   120
         End
         Begin VB.Label lblXYZ 
            Alignment       =   2  'Center
            Caption         =   "100k"
            Height          =   255
            Index           =   0
            Left            =   7260
            TabIndex        =   50
            Top             =   120
            Width           =   375
         End
         Begin VB.Line lnXYZ 
            BorderWidth     =   2
            Index           =   0
            X1              =   7460
            X2              =   7460
            Y1              =   1920
            Y2              =   120
         End
      End
      Begin VB.Label lblLux 
         Caption         =   "Lux(Y)=1000"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   120
         TabIndex        =   64
         Top             =   8400
         Width           =   3495
      End
      Begin VB.Label lblCCT 
         Caption         =   "CCT=2800"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   18
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   120
         TabIndex        =   63
         Top             =   7800
         Width           =   3495
      End
   End
   Begin VB.Frame Frame7 
      BorderStyle     =   0  'None
      Height          =   975
      Left            =   0
      TabIndex        =   36
      Top             =   6840
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Blue Noise"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   19
         Left            =   120
         TabIndex        =   39
         ToolTipText     =   "Red Noise (%/value)"
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Green Noise"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   18
         Left            =   120
         TabIndex        =   38
         ToolTipText     =   "Green Noise (%/value)"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Red Noise"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   17
         Left            =   120
         TabIndex        =   37
         ToolTipText     =   "Red Noise (%/value)"
         Top             =   120
         Width           =   1935
      End
   End
   Begin VB.Frame Frame6 
      BorderStyle     =   0  'None
      Height          =   855
      Left            =   0
      TabIndex        =   31
      Top             =   5880
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Raw Blue"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   16
         Left            =   120
         TabIndex        =   34
         ToolTipText     =   "Blue Conversion Code"
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Raw Green"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   15
         Left            =   120
         TabIndex        =   33
         ToolTipText     =   "Green Conversion Code"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Raw Red"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   14
         Left            =   120
         TabIndex        =   32
         ToolTipText     =   "Red Conversion Code"
         Top             =   120
         Width           =   1935
      End
   End
   Begin VB.CheckBox cbHold 
      Caption         =   "Run"
      Height          =   255
      Left            =   120
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "Run/Hold"
      Top             =   0
      Width           =   1935
   End
   Begin VB.Frame Frame5 
      BorderStyle     =   0  'None
      Caption         =   "Frame5"
      Height          =   855
      Left            =   0
      TabIndex        =   23
      Top             =   5040
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Lux"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   10
         Left            =   120
         TabIndex        =   24
         ToolTipText     =   "Corrected Lux Measured (using state selected equation)"
         Top             =   120
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "CCT"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   6
         Left            =   120
         TabIndex        =   25
         ToolTipText     =   "CCT"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "duv"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   9
         Left            =   120
         TabIndex        =   26
         ToolTipText     =   "Duv (distance from Plankian Locus: <0.05)"
         Top             =   600
         Width           =   1935
      End
   End
   Begin VB.Frame Frame4 
      BorderStyle     =   0  'None
      Caption         =   "Frame4"
      Height          =   1095
      Left            =   0
      TabIndex        =   18
      Top             =   3960
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "x"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   4
         Left            =   120
         TabIndex        =   20
         ToolTipText     =   "Corrected x"
         Top             =   120
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "y"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   5
         Left            =   120
         TabIndex        =   19
         ToolTipText     =   "Corrected y"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "u"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   22
         ToolTipText     =   "Duv (distance from Plankian Locus: <0.05)"
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "v"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   8
         Left            =   120
         TabIndex        =   21
         ToolTipText     =   "Duv (distance from Plankian Locus: <0.05)"
         Top             =   840
         Width           =   1935
      End
   End
   Begin VB.Frame Frame3 
      BorderStyle     =   0  'None
      Caption         =   "Frame3"
      Height          =   855
      Left            =   0
      TabIndex        =   14
      Top             =   3120
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "X"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   11
         Left            =   120
         TabIndex        =   15
         ToolTipText     =   "Corrected Lux Measured (using state selected equation)"
         Top             =   120
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Y"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   12
         Left            =   120
         TabIndex        =   16
         ToolTipText     =   "Corrected Lux Measured (using state selected equation)"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Z"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   13
         Left            =   120
         TabIndex        =   17
         ToolTipText     =   "Corrected Lux Measured (using state selected equation)"
         Top             =   600
         Width           =   1935
      End
   End
   Begin VB.Frame Frame2 
      BorderStyle     =   0  'None
      Caption         =   "Frame2"
      Height          =   1335
      Left            =   0
      TabIndex        =   9
      Top             =   1800
      Width           =   2055
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Red"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   13
         ToolTipText     =   "Raw red"
         Top             =   120
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Green"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   120
         TabIndex        =   12
         ToolTipText     =   "Raw Green"
         Top             =   360
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Blue"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   120
         TabIndex        =   11
         ToolTipText     =   "Raw Blue"
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Clear"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   3
         Left            =   120
         TabIndex        =   10
         ToolTipText     =   "Clear (dComp/Comp)"
         Top             =   840
         Visible         =   0   'False
         Width           =   1935
      End
      Begin VB.Label lblValue 
         BorderStyle     =   1  'Fixed Single
         Caption         =   "IR"
         BeginProperty Font 
            Name            =   "Courier New"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   22
         Left            =   120
         TabIndex        =   43
         ToolTipText     =   "Clear (dComp/Comp)"
         Top             =   1080
         Visible         =   0   'False
         Width           =   1935
      End
   End
   Begin VB.Frame Frame1 
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      Height          =   1575
      Left            =   0
      TabIndex        =   3
      Top             =   240
      Width           =   2055
      Begin VB.CheckBox cbXyUv 
         Caption         =   "xy"
         Height          =   255
         Left            =   1440
         Style           =   1  'Graphical
         TabIndex        =   4
         ToolTipText     =   "xy/uv Display Select"
         Top             =   1080
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.ComboBox cmbDisplay 
         Height          =   315
         ItemData        =   "frmSimpleRGB.frx":0CCA
         Left            =   720
         List            =   "frmSimpleRGB.frx":0CD7
         TabIndex        =   44
         Text            =   "Bars"
         ToolTipText     =   "Select Display"
         Top             =   480
         Width           =   735
      End
      Begin VB.CheckBox cbFilter 
         Caption         =   "1"
         Height          =   255
         Left            =   1440
         Style           =   1  'Graphical
         TabIndex        =   35
         ToolTipText     =   "#/values averaged"
         Top             =   840
         Width           =   615
      End
      Begin VB.CheckBox cbSensitivity 
         Caption         =   "Norm"
         Height          =   255
         Left            =   1440
         Style           =   1  'Graphical
         TabIndex        =   30
         ToolTipText     =   "Sensitivity"
         Top             =   600
         Width           =   615
      End
      Begin VB.HScrollBar hscrGainAdjust 
         Height          =   135
         LargeChange     =   10
         Left            =   0
         Max             =   5000
         Min             =   -1000
         TabIndex        =   28
         Top             =   1440
         Width           =   2055
      End
      Begin VB.CheckBox cbAutoRng 
         Caption         =   "High"
         Enabled         =   0   'False
         Height          =   255
         Index           =   1
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   7
         ToolTipText     =   "Range: 300/4k Lux"
         Top             =   360
         Width           =   735
      End
      Begin VB.CheckBox cbAutoRng 
         Caption         =   "Auto"
         Height          =   255
         Index           =   0
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   8
         ToolTipText     =   "Auto/Manual Range Control"
         Top             =   120
         Width           =   735
      End
      Begin VB.TextBox txtComp 
         Alignment       =   1  'Right Justify
         Height          =   285
         Left            =   720
         MultiLine       =   -1  'True
         TabIndex        =   6
         Text            =   "frmSimpleRGB.frx":0CE9
         ToolTipText     =   "Compensation: 0-127"
         Top             =   120
         Width           =   735
      End
      Begin VB.HScrollBar hscrComp 
         Height          =   135
         Left            =   720
         Max             =   127
         TabIndex        =   5
         Top             =   360
         Width           =   735
      End
      Begin VB.CheckBox cbCCMselect 
         Caption         =   "CCM: CCT"
         Enabled         =   0   'False
         Height          =   315
         Left            =   0
         Style           =   1  'Graphical
         TabIndex        =   70
         Top             =   780
         Width           =   1455
      End
      Begin VB.Label lblGainAdjust 
         Alignment       =   1  'Right Justify
         Caption         =   "0.00%"
         Height          =   255
         Left            =   0
         TabIndex        =   27
         Top             =   1140
         Width           =   675
      End
   End
   Begin VB.PictureBox picChroma 
      Height          =   8985
      Left            =   2100
      Picture         =   "frmSimpleRGB.frx":0CED
      ScaleHeight     =   8925
      ScaleWidth      =   7935
      TabIndex        =   1
      Top             =   60
      Width           =   7995
   End
   Begin VB.Timer tmrRead 
      Interval        =   330
      Left            =   6000
      Top             =   1440
   End
   Begin VB.PictureBox picUVspace 
      Height          =   6180
      Left            =   2100
      Picture         =   "frmSimpleRGB.frx":1F55C
      ScaleHeight     =   6120
      ScaleWidth      =   13665
      TabIndex        =   2
      Top             =   60
      Visible         =   0   'False
      Width           =   13725
   End
   Begin VB.Frame fmSpeedCtrl 
      Caption         =   "Speed=1x"
      Height          =   495
      Left            =   120
      TabIndex        =   29
      ToolTipText     =   "Res,CT = {16,100ms; 16,25ms; 12,6ms; 12,1.5ms; 8,400us; 8,100us"
      Top             =   8520
      Width           =   1935
      Begin VB.HScrollBar sldrSpeedCtrl 
         Height          =   135
         Left            =   120
         Max             =   5
         TabIndex        =   40
         Top             =   240
         Width           =   1695
      End
   End
   Begin VB.Label lblValue 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Full Scale"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   20
      Left            =   120
      TabIndex        =   41
      ToolTipText     =   "Full Scale"
      Top             =   7920
      Width           =   1935
   End
   Begin VB.Label lblValue 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "DUT Full Scale"
      BeginProperty Font 
         Name            =   "Courier New"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   21
      Left            =   120
      TabIndex        =   42
      ToolTipText     =   "DUT Full Scale"
      Top             =   8160
      Width           =   1935
   End
   Begin VB.Menu mnu_EEprom 
      Caption         =   "CCM"
   End
   Begin VB.Menu mnu_WP 
      Caption         =   "sRGB"
   End
End
Attribute VB_Name = "frmSimpleRGB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim calConst As modRGBdrv.calValues

Dim redMPA As clsMPA
Dim greenMPA As clsMPA
Dim blueMPA As clsMPA

Dim whitePoint As Long

Dim meas(values.vCount - 1) As Double

Dim nominalComp As Long
Const nominalDelta As Long = 10
Const deltaIRcctTrigger As Double = 15 ' %/value
Const validIRwindow = 0.01 ' Ratio
Const duvMax = 0.07 ' recommended is .05

Const loRngSwitchLevelDefault As Double = 90#
Const hiRngSwitchLevelDefault As Double = 200#
Const loRangeFSnomDefault As Double = 375

Const loRngSwitchLevelDefaultHS As Double = 40#
Const hiRngSwitchLevelDefaultHS As Double = 80#
Const loRangeFSnomDefaultHS As Double = 155

Const hiRangeFSnomDefault As Double = 10250

Dim loRngSwitchLevel As Double
Dim hiRngSwitchLevel As Double
Dim loRangeFSnom As Double
Dim hiRangeFSnom As Double

Const enableDir As Boolean = False
Dim irValid As Boolean, cctValid As Boolean
Dim modeRBG As Boolean, modeCompNormal As Boolean, lowRangeEnabled As Boolean

Dim width_ As Integer, height_ As Integer
Dim measState As Integer

Dim range, resolution As Long


Dim formLoaded As Boolean
Dim gainAdjust As Double
Dim luxAdjust As Double

Dim VersionNumber As String
Dim AppDateTime As Date
Dim DllDateTime As Date
Dim EEpromDateTime As Date
Const drivername As String = "registerDriver.dll"

Public hideDebug As Boolean

Dim EEprom As clsEEprom

Dim frmSimpleRGB_Height As Integer, frmSimpleRGB_Width As Integer

Dim picXYZ_Width As Integer, picXYZ_Left As Integer, lblXYZ_Left As Integer

Dim xyxBarGraph As clsUpdateBarGraphs, rgbBarGraph As clsUpdateBarGraphs
Dim graphAutoRangeCounter As Integer: Const graphAutoRangeCounterReset As Integer = 10

Dim sRGBmtrx2(2, 3) As Double

Public Sub setMPAtrip(trip As Double)
    redMPA.setAvgTrip trip
    greenMPA.setAvgTrip trip
    blueMPA.setAvgTrip trip
End Sub
Public Sub resetMPAtrip()
    redMPA.resetAvgTrip
    greenMPA.resetAvgTrip
    blueMPA.resetAvgTrip
End Sub

Public Sub setSrgbMtrx2(mtrxIn() As Double)
    Dim xyz As Integer, RGB As Integer
    For xyz = 0 To 2: For RGB = 0 To 3
        sRGBmtrx2(xyz, RGB) = mtrxIn(xyz, RGB)
    Next RGB: Next xyz
End Sub

Public Sub clrSrgbMtrx2()
    Dim xyz As Integer, RGB As Integer
    For xyz = 0 To 2: For RGB = 0 To 3
        If xyz = RGB Then
            sRGBmtrx2(xyz, RGB) = 1
        Else
            sRGBmtrx2(xyz, RGB) = 0
        End If
    Next RGB: Next xyz
End Sub

Sub loadDefaultSrgb()
    Dim xyz As Integer, RGB As Integer
    
    clrSrgbMtrx2
    
    sRGBmtrx2(xyz, RGB) = 0.031986551:  RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = 0.01168329:   RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = 0.010195619:  RGB = 0: xyz = xyz + 1
    sRGBmtrx2(xyz, RGB) = 0.001163933:  RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = 0.047129122:  RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = -0.010300622: RGB = 0: xyz = xyz + 1
    sRGBmtrx2(xyz, RGB) = -0.009064751: RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = -0.014937825: RGB = RGB + 1: sRGBmtrx2(xyz, RGB) = 0.081607197
    
End Sub

Public Function getMeas(Index As Integer) As Double
    getMeas = meas(Index)
End Function

Public Sub loadCalibration(Optional Page As Integer = 0)
    Dim X As Integer, Y As Integer
    
    On Error Resume Next
    
    EEpromDateTime = EEprom.getEEpromDate
    VersionNumber = EEprom.getEEpromVersion
    
    If VersionNumber = 3 Then
        frmEEprom.cmdFuse2Reg_Enable 0 ' clears the Reg (gain trim values) for mistaken behavior
    Else
        frmEEprom.cmdFuse2Reg_Enable
    End If
    
    For Y = 0 To 2: For X = 0 To 3
        calConst.CCM(Page, X, Y) = EEprom.getTransform(Page, X, Y)
    Next X: Next Y
    
    For X = 0 To UBound(calConst.ranges)
        calConst.comp(X) = EEprom.getCompensation(Page)
    Next X
    
    For X = 0 To UBound(calConst.ranges)
        calConst.ranges(X) = EEprom.getRange(Page, X)
    Next X
    
    calConst.sysGain(Page) = EEprom.getCardGain(Page)
    
    gainAdjust = 1 'calConst.sysGain
    
    modRGBdrv.loadXYZcoeff calConst, True
    
    txtComp.text = calConst.comp(range) & vbCr

End Sub

Private Sub wait(Optional Interval As Integer = -1)

    Dim enabled As Boolean
    
    enabled = tmrRead.enabled
    If Interval < 0 Then Interval = tmrRead.Interval
    
    tmrRead.enabled = False
    Sleep (Interval)
    tmrRead.enabled = enabled
    
End Sub

Private Sub cbEvManual_Click()
    If cbEvManual.value = vbChecked Then
        cbEvManual.caption = "Manual"
        cmbEvCoeff.enabled = True
    Else
        cbEvManual.caption = "Auto"
        cmbEvCoeff.enabled = False
    End If
End Sub

Private Sub cbCCMselect_Click()
    If cbCCMselect.value = vbChecked Then
        cbCCMselect.caption = "CCM: sRGB"
    Else
        cbCCMselect.caption = "CCM: CCT"
    End If
    lblCCT.Visible = Not (cbCCMselect.value = vbChecked)
    lblLux.Visible = Not (cbCCMselect.value = vbChecked)
End Sub

Private Sub cbFilter_Click()

    If cbFilter.value = vbChecked Then
        cbFilter.caption = "32"
    Else
        cbFilter.caption = "1"
    End If
    
End Sub

Private Sub cbInvComp_Click()

    If cbInvComp.value = vbChecked Then
        cbInvComp.caption = "On"
        invertCompMSB = &H40
    Else
        cbInvComp.caption = "Off"
        invertCompMSB = 0
    End If
    
    txtComp.text = txtComp.text & vbCr
    
End Sub

Private Sub cbRunCal_Click()
    If cbRunCal.value = vbChecked Then
        cbRunCal.caption = "Cal"
        lblValue(values.vX).BackColor = vbRed: lblValue(values.vY).BackColor = vbRed
    Else
        cbRunCal.caption = "Run"
        lblValue(values.vX).BackColor = vbButtonFace: lblValue(values.vY).BackColor = vbButtonFace
    End If
End Sub

Private Sub cbSensitivity_Change()
    cbSensitivity_Click
End Sub

Private Sub cbGraphAutoLock_Click()
    If cbGraphAutoLock.value Then
        cbGraphAutoLock.caption = "Fixed Range"
    Else
        cbGraphAutoLock.caption = "Auto Range"
    End If
End Sub

Private Sub cbGraphScaleAbsRel_Click()
    If cbGraphScaleAbsRel.value Then
        cbGraphScaleAbsRel.caption = "Relative Scale"
    Else
        cbGraphScaleAbsRel.caption = "Absolute Scale"
    End If
End Sub

Private Sub cbSensitivity_Click()
    If cbSensitivity.value = vbChecked Then
        cbSensitivity.caption = "High"
    Else
        cbSensitivity.caption = "Norm"
    End If
    
    If cbSensitivity.value = vbChecked And lowRangeEnabled Then
        loRngSwitchLevel = loRngSwitchLevelDefaultHS
        hiRngSwitchLevel = hiRngSwitchLevelDefaultHS
        loRangeFSnom = loRangeFSnomDefaultHS
        
        loRangeMultiplier = highSensitivityMultiplierDefault
    Else
        loRngSwitchLevel = loRngSwitchLevelDefault
        hiRngSwitchLevel = hiRngSwitchLevelDefault
        loRangeFSnom = loRangeFSnomDefault
        
        hiRangeFSnom = hiRangeFSnomDefault
        loRangeMultiplier = loRangeMultiplierDefault
    End If
    
    enableLowRange lowRangeEnabled
End Sub

Private Sub cmbDisplay_Click()
    
    Static cmbDisplay_ListIndex As Integer
    
    If cmbDisplay.ListIndex <> cmbDisplay_ListIndex Then
    
        cmbDisplay_ListIndex = cmbDisplay.ListIndex
    
        Select Case cmbDisplay.ListIndex
            Case 0: cbXyUv.value = vbChecked ' uv
            Case 1: cbXyUv.value = vbUnchecked 'xy
            Case 2: cbXyUv.value = vbUnchecked 'xy
        End Select
        
        cbXyUv_Click
        
    End If
    
End Sub

Private Sub cbXyUv_Click()

        If cbXyUv.value = vbChecked Then 'uv
            cbXyUv.caption = "uv"
            picChroma.Visible = False
            width_ = frmSimpleRGB_Width + picUVspace.Width - picChroma.Width: height_ = frmSimpleRGB_Height: Form_Resize
            picUVspace.Visible = True
        Else                             'xy
            cbXyUv.caption = "xy"
            picUVspace.Visible = False
            width_ = frmSimpleRGB_Width: height_ = frmSimpleRGB_Height: Form_Resize
            picChroma.Visible = True
        End If
        
    If cmbDisplay.ListIndex = 2 Then
        picChroma.Visible = False
        picUVspace.Visible = False
        frmBars.Visible = True
    Else
        frmBars.Visible = False
        If cbXyUv.value Then
            cmbDisplay.ListIndex = 0
        Else
            cmbDisplay.ListIndex = 1
        End If
        cmbDisplay_Click
    End If
    
End Sub

Private Sub cmbEvCoeff_Click()

    measState = cmbEvCoeff.ListIndex

End Sub

Private Sub cmbXform_Click()
    setTransform cmbXform.ListIndex
End Sub

Private Sub cmdDir_Click()
    irValid = False
    enableRGB False
    enableComp True, nominalDelta
    wait
End Sub

Private Function getDir(dIR As Double) As Boolean
    '
    ' look for a series of 4 consecutive measurements
    '   Where: 0&1 are repeatable withing 'validIRwindow' @ comp=0
    '        & 2&3 are repeatable withing 'validIRwindow' @ comp=nominalDelta
    ' return true with valid value when sequence completes successfully
    ' otherwise return last valid lux measurement @ comp=nominalDelta
    ' this requires a minimum of 4 aquisition cycles
    
    Static dirCount As Long, dirMeas(4) As Double
    Dim value As Double, cmpVal As Double, dCmpVal As Double
    
    On Error GoTo onError
    
    If Not enableDir Then
        getDir = True
        enableComp True
        enableRGB True
        txtComp.text = calConst.comp(range) & vbCr
        Exit Function
    End If
    
    getDir = False
    
    als.dGetGreen value
    
    Select Case dirCount
        Case 0, 2: dirMeas(dirCount) = value: dirCount = dirCount + 1
        Case 1, 3:
            If Abs(value / dirMeas(dirCount - 1) - 1) < validIRwindow Then ' match pass
            
                If dirCount = 1 Then enableComp False                       ' switch to deltaComp
                dirMeas(dirCount) = value: dirCount = dirCount + 1          ' increment
            
            Else                                                          ' match fail
                If dirCount = 1 Then                                        ' first pair (normalComp)
                    dirMeas(dirCount - 1) = value                               ' save value, try again for match
                Else
                    enableComp True, nominalDelta                                ' restart
                    dirCount = 0
                End If
            End If
    End Select
    
    Select Case dirCount
        Case 1: dIR = dirMeas(0)                                          ' return lux, 1st meas
        Case 2, 3: dIR = (dirMeas(0) + dirMeas(1)) / 2                    ' return lux, avg of 1st 2 meas
        Case 4: cmpVal = (dirMeas(0) + dirMeas(1)) / 2
                dCmpVal = (dirMeas(2) + dirMeas(3)) / 2
                dIR = (dCmpVal / cmpVal - 1) / nominalDelta
                getDir = True                                             ' completion, return dIR
                enableComp True
                dirCount = 0
    End Select
    
    If getDir Then
        lblValue(values.vClear).BackColor = vbGreen
    Else
        lblValue(values.vClear).BackColor = vbRed
    End If
    
    enableRGB getDir
    
    If getDir Then Debug.Print 3, dirMeas(3): Debug.Print
    If dirCount Then Debug.Print dirCount - 1, dirMeas(dirCount - 1)
    
    GoTo endFunction
onError:

    dirCount = 0
    getDir = False
    
endFunction: End Function

Private Sub checkRange()

    Dim min As Double, max As Double, i As Integer
    
    If cbAutoRng(0).value = vbUnchecked Then
    
        min = meas(values.vRed): max = min
        
        For i = values.vGreen To values.vBlue
            If min > meas(i) Then min = meas(i)
            If max < meas(i) Then max = meas(i)
        Next i
        
        If max < loRngSwitchLevel Then
            enableLowRange True
            cbAutoRng(1).value = vbChecked
        Else
            If max > hiRngSwitchLevel Then
                enableLowRange False
                cbAutoRng(1).value = vbUnchecked
            End If
        End If
        
    Else
        If cbAutoRng(1).value = vbUnchecked Then
            enableLowRange False
        Else
            enableLowRange True
        End If
    End If
    
End Sub

Private Sub enableLowRange(mode As Boolean)
    
    Static lastRange As Long
    
    lowRangeEnabled = mode
    
    If Not lowRangeEnabled Then
        range = 1
    Else
        If cbSensitivity.value = vbChecked Then
            range = 2
        Else
            range = 0
        End If
    End If
    
    If range <> lastRange Then
        als.dSetRange range
        lastRange = range
    End If
    
End Sub

Private Sub enableComp(mode As Boolean, Optional value As Integer = -1)

    If value < 0 Then value = nominalComp
    
    modeCompNormal = mode
    
    If modeCompNormal Then
        setIRcomp value
    Else
        setIRcomp 0
    End If
    
End Sub

Private Sub enableRGB(mode As Boolean)

    Dim Index As Integer

    If modeRBG <> mode Then
    
        als.dSetInputSelect 0 ' OFF={OFF,ALS,RGB}
        
        If mode Then
            als.dSetInputSelect 2 ' RGB={OFF,ALS,RGB}
        Else
            als.dSetInputSelect 1 ' ALS={OFF,ALS,RGB}
        End If
        
        modeRBG = mode
        
        wait
        
    End If
    
    For Index = values.vRed To values.vBlue
    
        If modeRBG Then
            Select Case Index
             Case values.vRed To values.vBlue: lblValue(Index).BackColor = vbYellow
            End Select
        Else
            Select Case Index
             Case values.vGreen: lblValue(Index).BackColor = vbYellow
             Case values.vRed, values.vBlue: lblValue(Index).BackColor = vbButtonFace
            End Select
        End If
        
    Next Index
    
End Sub

Private Sub cbAutoRng_Change(Index As Integer)
    cbAutoRng_Click Index
End Sub
Private Sub cbAutoRng_Click(Index As Integer)
    If cbAutoRng(Index).value = vbChecked Then
        If Index Then ' high/low
            cbAutoRng(Index).caption = "Low"
            cbSensitivity.enabled = True
        Else ' auto/fixed
            cbAutoRng(Index).caption = "Fixed"
            cbAutoRng(1).enabled = True
        End If
    Else
        If Index Then ' high/low
            cbAutoRng(Index).caption = "High"
            cbSensitivity.enabled = False
        Else ' auto/fixed
            cbAutoRng(Index).caption = "Auto"
            cbAutoRng(1).enabled = False
        End If
    End If
End Sub




Private Sub cbHold_Click()
    If cbHold.value = vbChecked Then
        tmrRead.enabled = False
        cbHold.caption = "Hold"
    Else
        reWriteRegisters
        tmrRead.enabled = True
        cbHold.caption = "Run"
    End If
End Sub

Private Sub cmbGraphRangeOnce_Click()
    graphAutoRangeCounter = graphAutoRangeCounterReset
End Sub

Private Sub Form_Resize()
    
    If WindowState = vbNormal Then
    
        If formLoaded Then
            Width = width_: Height = height_
        Else
            width_ = Width: height_ = Height
            formLoaded = True
        End If
    
    End If

End Sub

Private Sub Form_Load()

    Dim XYcoeff As String, EVcoeff As String, XYZcoeff As String, coeffDir As String
    
    loRngSwitchLevel = loRngSwitchLevelDefault
    hiRngSwitchLevel = hiRngSwitchLevelDefault
    loRangeFSnom = loRangeFSnomDefault
    hiRangeFSnom = hiRangeFSnomDefault
    loRangeMultiplier = loRangeMultiplierDefault
    
    tmrRead.enabled = False
    
    Dim i As Integer
    For i = 0 To values.vCount - 1: lblValue(i).caption = "": Next i
    
    als.init
    
    enableLowRange True: enableLowRange False
    
    enableRGB True: enableRGB False
    
    coeffDir = Environ("coeffDir")
    If coeffDir = "" Then coeffDir = "."
    
    On Error GoTo skipLoad
    
    If Not hideDebug Then
    
        XYcoeff = coeffDir & "\xyDefault." & gRGBdev & ".txt": loadXYcoeff XYcoeff
        EVcoeff = coeffDir & "\evDefault." & gRGBdev & ".txt": loadEVcoeff EVcoeff
        
    End If
    If gRGBdev <> "" Then
        XYZcoeff = coeffDir & "\XYZdefault." & gRGBdev & ".txt": loadXYZcoeff XYZcoeff
    Else
        XYZcoeff = coeffDir & "\XYZdefault.txt": loadXYZcoeff XYZcoeff
    End If
    
skipLoad:

    hscrComp.value = nominalComp
    irValid = False
    enableComp True, nominalDelta ' start for dIR
    
'    cmbXform.ListIndex = eTransforms.xy

    tmrRead.Interval = 100
    wait
    tmrRead.enabled = True
    
'    mnu_loadXYcoeffs.Visible = Not hideDebug
'    mnu_loadEVcoeffs.Visible = Not hideDebug
'    mnu_loadXYZcoeffs.Visible = Not hideDebug
'    cbEvManual.Visible = Not hideDebug
'    cmbEvCoeff.Visible = Not hideDebug
'    cmbXform.Visible = Not hideDebug
'    cbRunCal.Visible = Not hideDebug
'    cbInvComp.Visible = Not hideDebug
'    cmdDir.Visible = Not hideDebug
'    If hideDebug Then cmbXform.ListIndex = eTransforms.xyz
    
    getRevs
    
    '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
    
    Set EEprom = als.getEEpromObj            ' get object
    Load frmEEprom
    frmEEprom.setCallBackForm Me             ' for loadCalibration call from external form
    frmEEprom.init EEprom
    
    als.resetAddr
    
    '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

    Set redMPA = New clsMPA
    Set greenMPA = New clsMPA
    Set blueMPA = New clsMPA

    sldrSpeedCtrl_Click

    'lblValue(values.vClear).Visible = enableDir
    
    frmSimpleRGB_Height = frmSimpleRGB.Height
    frmSimpleRGB_Width = frmSimpleRGB.Width
    picXYZ_Width = picXYZ(0).Width
    picXYZ_Left = picXYZ(0).Left
    lblXYZ_Left = lnXYZ(0).x1 - lblXYZ(0).Left
    
    Set xyxBarGraph = New clsUpdateBarGraphs: xyxBarGraph.init picXYZ, lblXYZ, lnXYZ, _
                                              picXYZ_Width, picXYZ_Left, lblXYZ_Left
    Set rgbBarGraph = New clsUpdateBarGraphs: rgbBarGraph.init picRGB, lblRGB, lnRGB, _
                                              picXYZ_Width, picXYZ_Left, lblXYZ_Left
    
    cmbDisplay.ListIndex = 2: cmbDisplay_Click ' set startup panel to BarGraph
    graphAutoRangeCounter = graphAutoRangeCounterReset
    cbGraphAutoLock.value = vbChecked: cbGraphAutoLock_Click
    
    ucBarGraph_sRGB.setCaption "sRGB"
    
    loadDefaultSrgb
    
endSub: End Sub

Private Sub getRevs()

    VersionNumber = App.Major & "." & App.Minor & "." & App.Revision
    AppDateTime = getExeDateTime(App.EXEName & ".exe")
    DllDateTime = getExeDateTime(drivername)
    frmSimpleRGB.caption = frmSimpleRGB.caption & ": " & VersionNumber & "::" & AppDateTime & "::" & DllDateTime
    
End Sub

Private Sub updatePlot(Index As Integer)
    If cbXyUv.value = vbChecked Then 'uv
        updateUVplot Index
    Else                             'xy
        updateXYplot Index
    End If

End Sub

Private Sub updateXYplot(Index As Integer)

    Dim x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer
    Dim xM As Double, yM As Double, xB As Double, yB As Double
    
    On Error GoTo endSub
    
    If irValid Then
    
        ' from image: 533px-PlanckianLocus.jpg
        Const cX As Integer = 533, cY As Integer = 599  ' image size
        Const cx0 As Integer = 46, cy0 As Integer = 548 ' image scale offset
        Const cx8 As Integer = 515, cy9 As Integer = 19  ' high scale
        
        x0 = picChroma.Width: y0 = picChroma.Height ' picture box (15x image)
        
        xM = (cx8 - cx0) / 0.8 / cX * x0: yM = (cy9 - cy0) / 0.9 / cY * y0
        xB = cx0 / cX * x0: yB = cy0 / cY * y0
        
        x1 = meas(values.vX) * xM + xB: y1 = meas(values.vY) * yM + yB
        
        picChroma.Cls: picChroma.Line (0, y1)-(x0, y1): picChroma.Line (x1, 0)-(x1, y0)
        
        
        If cbCCMselect.value = vbChecked Then
            ' draw sRGB
            '         x       y
            'Red   0.6400  0.3300
            'Green 0.3000  0.6000
            'Blue  0.1500  0.0600
            x0 = 0.64 * xM + xB: y0 = 0.33 * yM + yB
            x1 = 0.3 * xM + xB: y1 = 0.6 * yM + yB
            picChroma.Line (x0, y0)-(x1, y1) ' red to green
            
            x0 = x1: y0 = y1
            x1 = 0.15 * xM + xB: y1 = 0.06 * yM + yB
            picChroma.Line (x0, y0)-(x1, y1) ' green to blue
        
            x0 = x1: y0 = y1
            x1 = 0.64 * xM + xB: y1 = 0.33 * yM + yB
            picChroma.Line (x0, y0)-(x1, y1) ' blue to red
        End If
    
    End If
    
endSub: End Sub

Private Sub updateUVplot(Index As Integer)

    Dim x0 As Integer, y0 As Integer, x1 As Integer, y1 As Integer
    Dim xM As Double, yM As Double, xB As Double, yB As Double
    Dim u As Double, v As Double
    
    On Error GoTo endSub
    
    If irValid Then
    
        ' from image: uvPlanckianLocus915x412.jpg
        Const cX As Integer = 915, cY As Integer = 412     ' image size
        Const cx0 As Integer = 47, cy0 As Integer = 372    ' image scale offset
        Const cx_35 As Integer = 895, cy_15 As Integer = 9 ' high scale
        
        x0 = picUVspace.Width: y0 = picUVspace.Height ' picture box (15x image)
        
        xM = (cx_35 - cx0) / 0.35 / cX * x0: yM = (cy_15 - cy0) / 0.15 / cY * y0
        xB = cx0 * 15 - xM * 0.1: yB = cy0 * 15 - yM * 0.25
        
        x1 = meas(values.vU) * xM + xB: y1 = meas(values.vV) * yM + yB
        
        picUVspace.Cls
        picUVspace.Line (0, y1)-(x0, y1)
        picUVspace.Line (x1, 0)-(x1, y0)
    
    End If
    
endSub: End Sub

Private Sub updateDisplay(ByVal Index As Integer, ByVal value As Double)

    On Error Resume Next
    
    Dim str As String
    
    meas(Index) = value
    
    If Index >= values.vLux And Index < values.vRedCode Then
        value = value * (1 + luxAdjust / 100)
        value = value * gainAdjust
    End If
    
    ' Prefix
    Select Case Index
     Case values.vRed:   str = "Red=    "
     Case values.vGreen: str = "Green=  "
     Case values.vBlue:  str = "Blue=   "
     Case values.vClear: str = "Clear=    "
     Case values.vX:     str = "x=      "
     Case values.vY:     str = "y=      "
     Case values.vU:     str = "u=      "
     Case values.vV:     str = "v=      "
     Case values.vCCT:   str = "CCT=    "
     Case values.vDuv:   str = "Duv=    "
     Case values.vLux:   str = "Lux=    "
     Case values.vXX:    str = "X=      "
     Case values.vYY:    str = "Y=      "
     Case values.vZZ:    str = "Z=      "
     Case values.vRedCode:   str = "Raw Red=    "
     Case values.vGreenCode: str = "Raw Green=  "
     Case values.vBlueCode:  str = "Raw Blue=   "
     Case values.vRedNoise:   str = "Red Noise=   "
     Case values.vGreenNoise: str = "Green Noise= "
     Case values.vBlueNoise:  str = "Blue Noise=  "
     Case values.vFullScale:  str = "Card FSR="
     Case values.vDUTfullScale:  str = "DUT FSR=  "
    End Select
    
    ' Value
    Select Case Index
     Case values.vRed To values.vBlue:
        If value < 1 Then
                str = str & Format(value, "####.000")
        Else
            If value < 10 Then
                str = str & Format(value, "####.00")
            Else
                str = str & Format(value, "####.0")
            End If
        End If
     Case values.vX, values.vY, values.vU To values.vDuv: str = str & Format(value, "###.0000")
     Case values.vClear: str = str & Format(value * 100, "###.00")
     Case values.vCCT: str = str & Format(value, "####")
     Case values.vRedCode To values.vBlueCode: str = str & Format(value, "####0")
     Case values.vRedNoise To values.vBlueNoise: str = str & Format(value, "##0.0")
     Case values.vDUTfullScale, values.vFullScale: str = str & Format(value, "######.0")
     Case Else: str = str & Format(value, "####.0")
    End Select
    
    ' Suffix
    Select Case Index
     Case values.vClear, values.vRedNoise To values.vBlueNoise: str = str & " %/value"
    End Select
    
    lblValue(Index).caption = str
    
    Select Case Index
        Case values.vCCT: lblCCT.caption = lblValue(Index).caption
        Case values.vLux: lblLux.caption = lblValue(Index).caption
    End Select
    
'    If cctValid Then ' enable always
'        lblValue(values.vCCT).BackColor = whitePoint 'vbGreen
'    Else
'        lblValue(values.vCCT).BackColor = whitePoint 'vbRed
'    End If

'    If lowRangeEnabled Then
'        lblValue(values.vLux).BackColor = vbMagenta
'    Else
'        lblValue(values.vLux).BackColor = vbCyan
'    End If
    
    If Index = values.vX Or Index = values.vX Then updatePlot Index
    
    ' =================
    Dim i As Integer, r As Integer, G As Integer, B As Integer, maxValue As Single: maxValue = 0
    
    For i = values.vXX To values.vZZ
        If maxValue < meas(i) Then maxValue = meas(i)
    Next i
    frmWhitePoint.setWhitePointBackColor meas(values.vX), meas(values.vY), False, True
    r = 255 * meas(values.vXX) / maxValue: G = 255 * meas(values.vYY) / maxValue: B = 255 * meas(values.vZZ) / maxValue
    whitePoint = B * (2 ^ 16) + G * (2 ^ 8) + r
    
End Sub

Sub getLux()

    Dim state As Integer, FSCode As Single
    
    On Error Resume Next
    
    If cbEvManual.value = vbChecked Then
        state = measState
    Else
    
        If cctValid Then
            If irValid Then
                state = 3
            Else
                state = 2
            End If
        Else
            If irValid Then
                state = 1
            Else
                state = 0
            End If
        End If
        
        cmbEvCoeff.ListIndex = state
        
    End If
    
    range = als.dGetRange
    
    meas(values.vLux) = meas(values.vYY)
    updateDisplay values.vLux, meas(values.vLux)
    
    ' calculate fullscale based on saturation point
    FSCode = meas(values.vRedCode)
    If FSCode < meas(values.vGreenCode) Then FSCode = meas(values.vGreenCode)
    If FSCode < meas(values.vBlueCode) Then FSCode = meas(values.vBlueCode)
    FSCode = FSCode / resolution
    meas(values.vFullScale) = meas(values.vLux) / FSCode
    updateDisplay values.vFullScale, meas(values.vFullScale)
    meas(values.vDUTfullScale) = meas(values.vFullScale) / calConst.sysGain(range)
    updateDisplay values.vDUTfullScale, meas(values.vDUTfullScale)
    
    
End Sub

Sub readRGB()
    
    Dim value As Double, code As Long, valRGB(2) As Double
    Dim mean As Double, noise As Double
    Dim range As Long, nRange As Long, rangeN As Long, rangeList() As Long
    Dim nResolution As Long, resolutionN As Long, resolutionList() As Long
    
    On Error Resume Next
    
    resetAddr
    
    nRange = als.dGetNrange
    ReDim rangeList(nRange - 1)
    als.dGetRangeList rangeList(0)
    rangeN = als.dGetRange
    range = rangeList(rangeN)
    
    
    nResolution = als.dGetNresolution
    ReDim resolutionList(nResolution - 1)
    als.dGetResolutionList resolutionList(0)
    resolutionN = als.dGetResolution
    resolution = resolutionList(resolutionN)
    
    als.dGetRed value: redMPA.setValue value, mean, noise
    If cbFilter.value Then value = mean
    code = resolution * value / range: valRGB(0) = code
    updateDisplay values.vRed, value
    updateDisplay values.vRedNoise, noise
    updateDisplay values.vRedCode, code
    
    als.dGetGreen value: greenMPA.setValue value, mean, noise
    If cbFilter.value Then value = mean
    code = resolution * value / range: valRGB(1) = code
    updateDisplay values.vGreen, value
    updateDisplay values.vGreenNoise, noise
    updateDisplay values.vGreenCode, code
    
    als.dGetBlue value: blueMPA.setValue value, mean, noise
    If cbFilter.value Then value = mean
    code = resolution * value / range: valRGB(2) = code
    updateDisplay values.vBlueNoise, noise
    updateDisplay values.vBlue, value
    updateDisplay values.vBlueCode, code
    
    If graphAutoRangeCounter > 0 Then
        rgbBarGraph.updateBarGraphs valRGB, True
    Else
        rgbBarGraph.updateBarGraphs valRGB, cbGraphAutoLock.value = vbUnchecked
    End If

    checkRange
    cbSensitivity_Click
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    
    End
    
End Sub

Private Sub hscrGainAdjust_Change()
    
    luxAdjust = hscrGainAdjust.value / 10#
    lblGainAdjust.caption = Format(Abs(luxAdjust), "##0.0")
    
    If luxAdjust > 0 Then
        lblGainAdjust.caption = "+" & lblGainAdjust.caption
    Else
        If luxAdjust < 0 Then lblGainAdjust.caption = "-" & lblGainAdjust.caption

    End If
    
    lblGainAdjust.caption = lblGainAdjust.caption & "%"

End Sub

Private Sub mnu_EEprom_Click()
    Load frmEEprom
    frmEEprom.Show '0, Me
    frmEEprom.setCallBackForm Me
    frmEEprom.init EEprom
    frmEEprom.ReadFile
End Sub

Private Sub mnu_WP_Click()
    frmWhitePoint.Show
    frmWhitePoint.setWhitePointBackColor meas(values.vX), meas(values.vY)
End Sub

Private Sub sldrSpeedCtrl_Change()
    sldrSpeedCtrl_Click
End Sub

Private Sub sldrSpeedCtrl_Click()
    
    fmSpeedCtrl.caption = "Speed="
    
    Select Case sldrSpeedCtrl.value
    Case 0: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "1x"
            als.dEnable4x 0: als.dSetResolution 0
    Case 1: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "4x"
            als.dEnable4x 1: als.dSetResolution 0
    Case 2: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "16x"
            als.dEnable4x 0: als.dSetResolution 1
    Case 3: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "64x"
            als.dEnable4x 1: als.dSetResolution 1
    Case 4: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "256x"
            als.dEnable4x 0: als.dSetResolution 2
    Case 5: fmSpeedCtrl.caption = fmSpeedCtrl.caption & "1024x"
            als.dEnable4x 1: als.dSetResolution 2
    End Select
    
End Sub

Private Sub tmrRead_Timer()

    Dim value(2) As Double, range As Long, sRGB(2) As Double
    
    Dim val2(2), c(2, 3) As Double, d(2, 3) As Double, i As Integer, j As Integer
    
    Static cctBase As Double
    
    On Error Resume Next
    
    If irValid Then
    
        readRGB
        
        ' RBG --> xy
'        If cbRunCal.value = vbChecked Then
'            value = meas(values.vRed) / (meas(values.vRed) + meas(values.vGreen) + meas(values.vBlue))
'            updateDisplay values.vX, value
'            value = meas(values.vGreen) / (meas(values.vRed) + meas(values.vGreen) + meas(values.vBlue))
'            updateDisplay values.vY, value
'
'        Else
        
        range = als.dGetRange
        If cbCCMselect.value = vbUnchecked Then
            value(0) = getXYZfromRGB(meas(values.vRed), meas(values.vGreen), meas(values.vBlue), 0, range)
            value(1) = getXYZfromRGB(meas(values.vRed), meas(values.vGreen), meas(values.vBlue), 1, range)
            value(2) = getXYZfromRGB(meas(values.vRed), meas(values.vGreen), meas(values.vBlue), 2, range)
        Else
'            ' Chroma Meter Calibration
'            If 0 Then
'                ' from excel calibration, raw linest (reversed)
'                ' 1.016398757  1.10902461   2.782742419  0.050797794
'                '-0.362031042  4.009674934  0.479858867 -0.237695768
'                ' 8.298101411 -1.645842555 -0.29740823   0.262776496
'                c(i, j) = 2.782742419: j = j + 1: c(i, j) = 1.10902461: j = j + 1
'                c(i, j) = 1.016398757: j = j + 1: c(i, j) = 0.050797794
'
'                i = i + 1: j = 0
'                c(i, j) = 0.479858867: j = j + 1: c(i, j) = 4.009674934: j = j + 1
'                c(i, j) = -0.362031042: j = j + 1: c(i, j) = -0.237695768
'
'                i = i + 1: j = 0
'                c(i, j) = -0.29740823: j = j + 1: c(i, j) = -1.645842555: j = j + 1
'                c(i, j) = 8.298101411: j = j + 1: c(i, j) = 0.262776496
'            Else
'                ' from excel calibration, raw linest (reversed)
'                ' 1.024724109  1.108663229  2.786545467 0
'                '-0.400987475  4.011365929  0.462063443 0
'                ' 8.341168375 -1.647711977 -0.277735102 0
'                c(i, j) = 2.786545467: j = j + 1: c(i, j) = 1.108663229: j = j + 1
'                c(i, j) = 1.024724109: j = j + 1: c(i, j) = 0
'
'                i = i + 1: j = 0
'                c(i, j) = 0.462063443: j = j + 1: c(i, j) = 4.011365929: j = j + 1
'                c(i, j) = -0.400987475: j = j + 1: c(i, j) = 0
'
'                i = i + 1: j = 0
'                c(i, j) = -0.277735102: j = j + 1: c(i, j) = -1.647711977: j = j + 1
'                c(i, j) = 8.341168375: j = j + 1: c(i, j) = 0
'            End If
'
'            For i = 0 To 2
'                For j = 0 To 2
'                    value(i) = value(i) + c(i, j) * meas(values.vRed + j)
'                Next j
'                value(i) = value(i) + c(i, j): val2(i) = value(i)
'            Next i
            
'            If 0 Then ' secondary monitor only calibration
'                ' from excel calibration, raw linest (reversed)
'                '0.089662181 -0.026149328    1.071300958 0
'                '0            1              0           0
'                '1.688255631 -0.021384253    0.053710815 0
'                d(i, j) = 1.071300958: j = j + 1: d(i, j) = -0.026149328: j = j + 1
'                d(i, j) = 0.089662181: j = j + 1: d(i, j) = 0
'
'                i = i + 1: j = 0
'                d(i, j) = 0: j = j + 1: d(i, j) = 0: j = j + 1
'                d(i, j) = 0: j = j + 1: d(i, j) = 0
'
'                i = i + 1: j = 0
'                d(i, j) = 0.053710815: j = j + 1: d(i, j) = -0.021384253: j = j + 1
'                d(i, j) = 1.688255631: j = j + 1: d(i, j) = 0
'
'                For i = 0 To 2
'                    For j = 0 To 2
'                        value(i) = value(i) + d(i, j) * val2(j)
'                    Next j
'                    value(i) = value(i) + d(i, j)
'                Next i
'            Else
'                For i = 0 To 2
'                    For j = 0 To 2
'                        value(i) = value(i) + sRGBmtrx2(i, j) * val2(j)
'                    Next j
'                    value(i) = value(i) + sRGBmtrx2(i, j)
'                Next i
'            End If
            
            For i = 0 To 2: value(i) = 0
                For j = 0 To 2
                    value(i) = value(i) + sRGBmtrx2(i, j) * meas(values.vRed + j)
                Next j
                value(i) = value(i) + sRGBmtrx2(i, j) ' for offset
                value(i) = value(i) * 1000
            Next i
            
        End If
        
        For i = 0 To 2
            updateDisplay values.vXX + i, value(i)
        Next i
        
        If graphAutoRangeCounter > 0 Then
            xyxBarGraph.updateBarGraphs value, True
            ucBarGraph_sRGB.setBackColor (XYZ2sRGB(value, sRGB))
            ucBarGraph_sRGB.updateBarGraphs sRGB, True
            graphAutoRangeCounter = graphAutoRangeCounter - 1
        Else
            xyxBarGraph.updateBarGraphs value, cbGraphAutoLock.value = vbUnchecked
            ucBarGraph_sRGB.setBackColor (XYZ2sRGB(value, sRGB))
            ucBarGraph_sRGB.updateBarGraphs sRGB, cbGraphAutoLock.value = vbUnchecked
        End If
        
        For i = 0 To 2: lblSrgbVal(i).caption = sRGB(i): Next i
        
        value(0) = meas(values.vXX) / (meas(values.vXX) + meas(values.vYY) + meas(values.vZZ))
        updateDisplay values.vX, value(0)
        value(1) = meas(values.vYY) / (meas(values.vXX) + meas(values.vYY) + meas(values.vZZ))
        updateDisplay values.vY, value(1)
        
        If cbCCMselect.value = vbUnchecked Then
            ucBarGraph_sRGB.setCaption "sRGB"
        Else
            ucBarGraph_sRGB.setCaption "sRGB: " & guessColor(value(0), value(1))
        End If
        
            
        
'        End If
        
        'xy --> uv
        value(0) = getUVfromXY(meas(values.vX), meas(values.vY), 0)
        updateDisplay values.vU, value(0)
        value(0) = getUVfromXY(meas(values.vX), meas(values.vY), 1)
        updateDisplay values.vV, value(0)
        
        'xy --> CCT/Duv
        value(0) = getCCTfromXY(meas(values.vX), meas(values.vY), 0)
        updateDisplay values.vCCT, value(0)
        value(0) = getCCTfromXY(meas(values.vX), meas(values.vY), 1)
        updateDisplay values.vDuv, value(0)
        
        getLux
        
        If Abs(cctBase) < 3 Then
            If cctBase = 2 Then
                cctBase = meas(values.vCCT) ' keep the 3rd measurement
            Else
                cctBase = cctBase + 1
            End If
        Else
            If Abs(cctBase / meas(values.vCCT) - 1) > deltaIRcctTrigger Then ' reacquire..
                irValid = False
                cctValid = False
                cctBase = 0
                enableRGB False
            Else
                If Abs(meas(values.vDuv)) < duvMax Then  ' looking at gray scale?
                    cctValid = True
                Else
                    cctValid = False
                End If
            End If
        End If
        
    Else
    
        irValid = getDir(value(0))
        
        If irValid Then
            updateDisplay values.vClear, value(0)
        Else
            updateDisplay values.vGreen, value(0)
        End If
        
    End If
End Sub

Function guessColor(X As Double, Y As Double) As String
    'https://en.wikipedia.org/wiki/SRGB#The_sRGB_gamut
    'http://www.avsforum.com/forum/139-display-calibration/852536-basic-guide-color-calibration-using-cms-updated-enhanced.html
    'Rec. 709
    '     x         y         Y
    'R    0.6400    0.3300    0.2126
    'G    0.3000    0.6000    0.7152
    'B    0.1500    0.0600    0.0722
    'C    0.2246    0.3287    0.7874
    'M    0.3209    0.1542    0.2848
    'Y    0.4193    0.5053    0.9278
    'W    0.3127    0.3290    1.0000
    
    Dim error As Double, minErr As Double, guess As String
    
    If 1 Then
    
        guessColor = "Red": minErr = ((X - 0.64) ^ 2 + (Y - 0.33) ^ 2) ^ 0.5
        
        guess = "Green": error = ((X - 0.3) ^ 2 + (Y - 0.6) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guess = "Blue": error = ((X - 0.15) ^ 2 + (Y - 0.06) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guess = "Cyan": error = ((X - 0.2246) ^ 2 + (Y - 0.3287) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guess = "Magenta": error = ((X - 0.3209) ^ 2 + (Y - 0.1542) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guess = "Yellow": error = ((X - 0.4193) ^ 2 + (Y - 0.5053) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guess = "Grey": error = ((X - 0.3127) ^ 2 + (Y - 0.329) ^ 2) ^ 0.5
        If minErr > error Then minErr = error: guessColor = guess
        
        guessColor = guessColor & " dxy=" & Format(minErr, "0.00")
    
    Else
        Dim c As Integer
        Dim x0 As Double, y0 As Double, XX As Double, YY As Double, ZZ As Double
        
        For c = 0 To 6
            Select Case c
                Case 0: x0 = 0.64:   y0 = 0.33:   YY = 0.2126 ' red
                Case 0: x0 = 0.3:    y0 = 0.6:    YY = 0.7152 ' green
                Case 0: x0 = 0.15:   y0 = 0.06:   YY = 0.0722 ' blue
                Case 0: x0 = 0.2246: y0 = 0.3287: YY = 0.7874 ' cyan
                Case 0: x0 = 0.3209: y0 = 0.1542: YY = 0.2848 ' magenta
                Case 0: x0 = 0.4193: y0 = 0.5053: YY = 0.9278 ' yellow
                Case 0: x0 = 0.3127: y0 = 0.329:  YY = 1      ' white point
            End Select
            XX = YY * x0 / y0: ZZ = YY * (1 - x0 - y0)
        Next c
    End If
    
End Function

Sub loadXYcoeff(fileName As String)

    Dim c(1, 2) As Double, i As Integer, j As Integer
    
    On Error GoTo onError
    
    If fileName <> "" Then
        Open fileName For Input As #1
        Input #1, nominalComp
        For i = 0 To 1: For j = 0 To 2
            Input #1, c(i, j)
        Next j: Next i
    End If
    
    Call modRGBdrv.loadXYcoeff(c(), True)
    setIRcomp nominalComp

onError: Close #1
End Sub

Private Sub mnu_loadXYcoeffs_Click()
    
    CommonDialog1.fileName = "xy*.txt"
    
    CommonDialog1.ShowOpen
    
    If CommonDialog1.fileName <> "" Then loadXYcoeff CommonDialog1.fileName

End Sub

Private Sub mnu_loadEVcoeffs_Click()
    
    CommonDialog1.fileName = "ev*.txt"
    
    CommonDialog1.ShowOpen
    
    If CommonDialog1.fileName <> "" Then loadEVcoeff CommonDialog1.fileName

End Sub

Sub loadEVcoeff(fileName As String)

    Dim c(3, 4) As Double, i As Integer, j As Integer
    
    On Error GoTo onError
    
    If fileName <> "" Then
        Open fileName For Input As #1
        For j = 0 To 3: For i = 0 To 4
            Input #1, c(j, i)
        Next i: Next j
    End If
    
    Call modRGBdrv.loadEVcoeff(c(), True)

onError: Close #1
End Sub

Private Sub mnu_loadXYZcoeffs_Click()
    
    CommonDialog1.fileName = "XYZ*.txt"
    
    CommonDialog1.ShowOpen
    
    If CommonDialog1.fileName <> "" Then loadXYZcoeff CommonDialog1.fileName

End Sub

Sub loadXYZcoeff(fileName As String)

'    Dim c(3, 2) As Double, i As Integer, j As Integer
'
'    On Error GoTo onError
'
'    If fileName <> "" Then
'        Open fileName For Input As #1
'
'        For j = 0 To 3: For i = 0 To 2
'            Input #1, c(j, i)
'        Next i: Next j
'        Input #1, gainAdjust
'    End If
'
'    Call modRGBdrv.loadXYZcoeff(c(), True)
'
'    nominalComp = c(3, 0): txtComp.text = nominalComp & vbCr
'
'onError: Close #1
End Sub

Private Sub setIRcomp(ByVal value As Integer)
    txtComp.text = CStr(value) & vbCr
End Sub

Private Sub txtComp_Change()

    Dim value As Long
    
    On Error GoTo onError
    
    If enterText(txtComp.text) Then
    
        value = txtComp.text
        
        If value < hscrComp.min Then
            value = hscrComp.min
        Else
            If value > hscrComp.max Then value = hscrComp.max
        End If
        
        als.dSetIRcomp value
        
        txtComp.text = str(value)
        
        hscrComp.value = txtComp.text
        
        If irValid Then
            nominalComp = hscrComp.value
        End If
    
    End If
    
    GoTo endSub
        
onError:

    als.dGetIRcomp value
    txtComp.text = str(value)
    
endSub: End Sub

Private Sub hscrComp_Change()
    txtComp.text = str(hscrComp.value) & vbCr
End Sub

Private Sub reWriteRegisters()

    Dim org(2) As Integer
    ' panel settings
    org(0) = cbAutoRng(0).value
    org(1) = cbAutoRng(1).value
    org(2) = cbSensitivity.value
    
    ' goto fixed
    cbAutoRng(0).value = 1 ' Fixed/Auto
    
    cbAutoRng(1).value = 1 - org(1) ' toggle HI/LO
        If org(1) = 1 Then
            cbSensitivity.value = 1 - org(2) ' if LO toggle sensitivity
            cbSensitivity.value = org(2)
        End If
    cbAutoRng(1).value = org(1)
        If org(1) = 0 Then
            cbSensitivity.value = 1 - org(2) ' if LO toggle (Norm/HS)
            cbSensitivity.value = org(2)
        End If
    
    ' goto panel set
    cbAutoRng(0).value = org(0) ' Fixed/Auto
    
    txtComp.text = txtComp.text & vbCr
    
End Sub

Private Sub picChroma_MouseDown(Button As Integer, shift As Integer, X As Single, Y As Single)

    Dim x0 As Integer, y0 As Integer, x1 As Single, y1 As Single
    Dim xM As Double, yM As Double, xB As Double, yB As Double
    
    ' from image: 533px-PlanckianLocus.jpg
    Const cX As Integer = 533, cY As Integer = 599  ' image size
    Const cx0 As Integer = 46, cy0 As Integer = 548 ' image scale offset
    Const cx8 As Integer = 515, cy9 As Integer = 19  ' high scale
    
    x0 = picChroma.Width: y0 = picChroma.Height ' picture box (15x image)
    
    xM = (cx8 - cx0) / 0.8 / cX * x0: yM = (cy9 - cy0) / 0.9 / cY * y0
    xB = cx0 / cX * x0: yB = cy0 / cY * y0
    
    x1 = (X - xB) / xM: y1 = (Y - yB) / yM
    
    frmWhitePoint.setWhitePointBackColor x1, y1
    
End Sub

Private Sub picUVspace_MouseDown(Button As Integer, shift As Integer, X As Single, Y As Single)

    Dim x0 As Integer, y0 As Integer, x1 As Single, y1 As Single, z1 As Single
    Dim xM As Double, yM As Double, xB As Double, yB As Double
    Dim u As Double, v As Double
    
    ' from image: uvPlanckianLocus915x412.jpg
    Const cX As Integer = 915, cY As Integer = 412     ' image size
    Const cx0 As Integer = 47, cy0 As Integer = 372    ' image scale offset
    Const cx_35 As Integer = 895, cy_15 As Integer = 9 ' high scale
    
    x0 = picUVspace.Width: y0 = picUVspace.Height ' picture box (15x image)
    
    xM = (cx_35 - cx0) / 0.35 / cX * x0: yM = (cy_15 - cy0) / 0.15 / cY * y0
    xB = cx0 * 15 - xM * 0.1: yB = cy0 * 15 - yM * 0.25
    
    x1 = (X - xB) / xM: y1 = (Y - yB) / yM
    
    frmWhitePoint.setWhitePointBackColor x1, y1, True
    
End Sub


