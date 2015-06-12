Attribute VB_Name = "modGlobals"
Option Explicit

' Kernel
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
Public Declare Function GetTickCount Lib "kernel32" () As Long

' Types

Type reg38
    a As Long
    s As Byte
    m As Byte
End Type

Type IOreg
    i2cadd As Byte
    devAddr As Byte
    value As Long
End Type

Type IOfield
    regIdx As Integer
    shift As Integer
    Mask As Integer
End Type

' Enum
Enum plotDataType
    pdALS
    pdIR
    pdProx
End Enum

Enum cmbSweepListIndex
    nm
    deg
    mm
    nm_deg
    nm_comp
End Enum

Enum eMeasure ' Assignment must match frmTest.optMeas.Index
    mDUT
    mDVM
    mOPM
    mLM
    mCM
    mRBG
        mALS
        mIR
        mProx
        mProx30
End Enum

Type t38ProxOffset
    minMeas As Double
    minVal As Long
    maxMeas As Double
    maxVal As Long
End Type

' variables
Public gPartNumber As Long
Public gPartFamily As Long
Public gSweepType As cmbSweepListIndex
Public gSetWaveLength As Single
Public gSetAngle As Single
Public gSetDistance As Single
Public g38ProxOffset(3) As t38ProxOffset


