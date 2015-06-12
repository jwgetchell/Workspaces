___________
Description

This creates an alsUSB.ocx which combines the ALS driver & USB drivers into a single component
_________
Versions:
Current: Development

_____________
Dependancies:

alsDrv.ocx
jungoUSB.ocx
HIDusb.ocx
emuUSB.ocx
registerDriver.dll

_________
Projects:

alsUSB.devel: EXE - ctl & frm
alsUSB: OCX only
alsUSB.test: EXE - frm & OCX

_____________________
Project Installation:
Create Directory tree: ..\Workspace\Libs\registerDriver
Such that <registerDriver> is this directory (which contains README.txt)
Use registerDrive.bat to start the solution
It sets the enviroment such that the compiled files appear in the 'output' directory shown below.

..\Workspace\                     
	+---Apps                  
	+---Libs                  
	|   +---alsDrv
	|   |   alsDrv.bat
	|   |   alsDrv.vbp
	|   |   alsDrv.vbw
	|   |   README.txt
	|   |
	|   \---ctl
	|           ucALSdrv.ctl
	|
	\---output                
	    \---Debug             
	        +---bin           
	        \---lib           

The bin & lib directories are common to all Apps & Libs
	        