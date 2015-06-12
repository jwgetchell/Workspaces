Attribute VB_Name = "modGeneric"
'-----------------------------------------------------------------------------
' modGeneric.bas
'-----------------------------------------------------------------------------
' Copyright 2010 Intersil, Inc.
' http://www.intersil.com
'
' Program Description:
'
' Project specific declarations.
'
' Project Name:   I2C Debugger
'
'
' Release 1.0
'   -100803 Initial Revision (Tushar Mazumder)
'
' Update PID and product string in this file.

Public Const DEFAULT_VENDOR_ID As Long = &H9AA
Public Const DEFAULT_PRODUCT_ID As Long = &H2019
Public Const PRODUCT_NAME As String = "generic"
Public Const DEFAULT_SLAVE_ADDRESS As Byte = &HE8
Public preventTxtI2CaddressPause As Boolean    'flag to prevent pause from running in txtI2Caddress_Change when txtI2Caddress_Change is called indirectly, otherwise cmdScanI2Caddress_Click runs too slow
Public preventChk As Boolean    'flag to prevent checkbox handler from being called when its value is changed by another procedure rather than by user
Public Const explicit_report_id = True 'set this flag to true if you're explicitly defining the report IDs in the HID
