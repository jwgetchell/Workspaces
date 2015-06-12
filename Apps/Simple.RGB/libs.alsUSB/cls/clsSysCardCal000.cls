VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSysCardCal000"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Dim size As Integer

Private Type linearEqStruct
    m As Single
    B As Single
End Type
    
Private Type sysCardCalStruct
    dac(9) As linearEqStruct
End Type

Dim sysCardCal As sysCardCalStruct

Private Sub Class_Initialize()
    size = Len(sysCardCal)
End Sub

Function getSize() As Integer
    getSize = size
End Function

