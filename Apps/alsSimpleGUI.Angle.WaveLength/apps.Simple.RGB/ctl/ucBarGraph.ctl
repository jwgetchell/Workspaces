VERSION 5.00
Begin VB.UserControl ucBarGraph 
   ClientHeight    =   2175
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7695
   ScaleHeight     =   2175
   ScaleWidth      =   7695
   Begin VB.Frame frmLabel 
      Caption         =   "Bar Graph"
      Height          =   2175
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   7695
      Begin VB.PictureBox picRGB 
         BackColor       =   &H00FF0000&
         Height          =   375
         Index           =   2
         Left            =   120
         ScaleHeight     =   315
         ScaleWidth      =   7275
         TabIndex        =   3
         Top             =   1560
         Width           =   7340
      End
      Begin VB.PictureBox picRGB 
         BackColor       =   &H0000FF00&
         Height          =   375
         Index           =   1
         Left            =   120
         ScaleHeight     =   315
         ScaleWidth      =   7275
         TabIndex        =   2
         Top             =   1080
         Width           =   7340
      End
      Begin VB.PictureBox picRGB 
         BackColor       =   &H000000FF&
         Height          =   375
         Index           =   0
         Left            =   120
         ScaleHeight     =   315
         ScaleWidth      =   7275
         TabIndex        =   1
         Top             =   600
         Width           =   7340
      End
      Begin VB.Label lblRGB 
         Alignment       =   2  'Center
         Caption         =   "100k"
         Height          =   255
         Index           =   0
         Left            =   7260
         TabIndex        =   4
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblRGB 
         Alignment       =   2  'Center
         Caption         =   "50k"
         Height          =   255
         Index           =   1
         Left            =   3585
         TabIndex        =   5
         Top             =   240
         Width           =   375
      End
      Begin VB.Label lblRGB 
         Alignment       =   2  'Center
         Caption         =   "20k"
         Height          =   255
         Index           =   2
         Left            =   1395
         TabIndex        =   6
         Top             =   240
         Width           =   375
      End
      Begin VB.Line lnRGB 
         BorderWidth     =   2
         Index           =   2
         X1              =   1590
         X2              =   1590
         Y1              =   2040
         Y2              =   240
      End
      Begin VB.Line lnRGB 
         BorderWidth     =   2
         Index           =   1
         X1              =   3795
         X2              =   3795
         Y1              =   2040
         Y2              =   240
      End
      Begin VB.Line lnRGB 
         BorderWidth     =   2
         Index           =   0
         X1              =   7455
         X2              =   7455
         Y1              =   2040
         Y2              =   240
      End
   End
End
Attribute VB_Name = "ucBarGraph"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim digMult(1, 2) As Double, maxRng As Double ' for fixed range
Dim picRGB_Width As Integer, picRGB_Left As Integer, lblRGB_Left As Integer

Private Sub UserControl_Initialize()
    picRGB_Width = picRGB(0).Width
    picRGB_Left = picRGB(0).Left
    lblRGB_Left = lnRGB(0).x1 - lblRGB(0).Left
End Sub

Public Sub setCaption(lbl As String)
    frmLabel.caption = lbl
End Sub

Public Sub setBackColor(RGB As Long)
    frmLabel.BackColor = RGB
End Sub

Public Sub updateBarGraphs(value() As Double, Optional ByVal autoRangeOn As Boolean = False)

    Dim maxVal As Double
    Dim mult As Integer, digit As Double
    Dim i As Integer
    
    On Error Resume Next
    
    ' Bar graph RGB
    If autoRangeOn Or maxRng = 0 Then ' |||| Auto range ||||
        maxVal = value(0)
        If maxVal < value(1) Then maxVal = value(1)
        If maxVal < value(2) Then maxVal = value(2)
        
        mult = 0: digit = 5
        digMult(0, 0) = 1: digMult(0, 1) = 2 ' prime
        digMult(1, 0) = 0: digMult(1, 1) = 0
        
        Do
        
            If digit = 5 Then
                mult = mult + 1: digit = 1
            Else
                If digit = 1 Then
                    digit = 2
                Else
                    digit = 5
                End If
            End If
            
            ' push into stack
            digMult(0, 0) = digMult(0, 1): digMult(0, 1) = digMult(0, 2)
            digMult(1, 0) = digMult(1, 1): digMult(1, 1) = digMult(1, 2)
            digMult(0, 2) = digit: digMult(1, 2) = mult
        
            maxRng = digit * 10 ^ mult
            
        Loop Until maxVal < maxRng
    
        ' adjust lines/labels
        If digit = 5 Then
            i = picRGB_Left + picRGB_Width * 2 / 5
            lnRGB(1).x1 = i: lnRGB(1).X2 = i
            i = picRGB_Left + picRGB_Width / 5
            lnRGB(2).x1 = i: lnRGB(2).X2 = i
        Else
            i = picRGB_Left + picRGB_Width / 2
            lnRGB(1).x1 = i: lnRGB(1).X2 = i
            If digit = 2 Then
                i = picRGB_Left + picRGB_Width / 4
                lnRGB(2).x1 = i: lnRGB(2).X2 = i
            Else
                i = picRGB_Left + picRGB_Width / 5
                lnRGB(2).x1 = i: lnRGB(2).X2 = i
            End If
        End If
        
        lblRGB(1).Left = lnRGB(1).x1 - lblRGB_Left
        lblRGB(2).Left = lnRGB(2).x1 - lblRGB_Left
    
        For i = 0 To 2
        
            If digMult(1, i) >= 3 Then ' labels are indexed from high to low
                lblRGB(2 - i).caption = digMult(0, i) * 10 ^ (digMult(1, i) - 3) & "k"
            Else
                lblRGB(2 - i).caption = digMult(0, i) * 10 ^ (digMult(1, i) - 0)
            End If
        
        Next i
    
        
    End If '|||| End Auto Range ||||
    
    For i = 0 To 2
        
        If value(i) < 0 Then value(i) = 0
        picRGB(i).Width = picRGB_Width * value(i) / maxRng
        
    Next i
    
    ' END Bar graph

End Sub




