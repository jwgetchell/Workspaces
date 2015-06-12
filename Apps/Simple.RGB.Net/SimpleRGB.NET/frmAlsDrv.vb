Option Strict Off
Option Explicit On
Friend Class frmAlsDrv
	Inherits System.Windows.Forms.Form
	Public enableInvert As Short
	
	Private Sub frmAlsDrv_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		'als.invertCompMSB = enableInvert * &H40
	End Sub
End Class