VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsEEpromS001"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim header As clsHeader000
Dim sysCardCal As clsSysCardCal000
Dim size As Integer

Dim tb(1) As TextBox

Public Sub setTBobj(tb0 As TextBox, tb1 As TextBox)
    Set tb(0) = tb0
    Set tb(1) = tb1
End Sub

Function getSize() As Integer
    getSize = size
End Function

Private Sub Class_Initialize()
    Set header = New clsHeader000
    Set sysCardCal = New clsSysCardCal000
    
    size = header.getSize
    size = size + sysCardCal.getSize
End Sub
