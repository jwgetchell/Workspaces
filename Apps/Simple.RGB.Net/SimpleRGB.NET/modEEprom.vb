Option Strict Off
Option Explicit On
Module modEEprom
	'|||||||||||||||||||||||||||||||||||||||||||||||||||||
	Enum eePromAddrs '(MSB justified)
		paletteCard = &HA2
		systemCard = &HA0
		evaluationCard = &HA4 ' TBD
	End Enum
	'|||||||||||||||||||||||||||||||||||||||||||||||||||||
	Enum eePromRevs
		S001 = 1 ' System Card
		E002 ' RGB: 3x3 transform
		E003 ' RGB: 6 x (3x4 transform) - clear trim reg (error)
		E004 ' RGB: 6 x (3x4 transform) with full header
		Last
	End Enum
	'|||||||||||||||||||||||||||||||||||||||||||||||||||||
End Module