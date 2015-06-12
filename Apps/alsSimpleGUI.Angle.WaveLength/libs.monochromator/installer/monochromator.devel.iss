; -- alsSimpleGUI.devel.iss --
;
[Setup]
AppName=alsSimpleGUI
AppVerName=ALS Simple GUI 1.0.0.1
DefaultDirName={pf}\Intersil\Workspace
DefaultGroupName=Intersil\alsSimpleGUI
UninstallDisplayIcon={app}\alsSimpleGUI.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=alsSimpleGUI.devel.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}\apps\alsSimpleGUI

[Files]
Source: C:\WINDOWS\system32\comdlg32.ocx; DestDir: {sys}; Flags: restartreplace sharedfile regserver

Source: "..\..\..\output\Debug\bin\alsSimpleGUI.exe"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Debug\bin\registerDriver.dll"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Debug\bin\wd_utils.dll"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Debug\bin\plotUserControl.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver
Source: "..\..\..\output\Debug\bin\jungoUsb.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver
Source: "..\..\..\output\Debug\bin\alsDrv.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver

Source: "..\alsSimpleGUI.bat"; DestDir: "{app}\apps\alsSimpleGUI"
Source: "..\alsSimpleGUI.vbp"; DestDir: "{app}\apps\alsSimpleGUI"
Source: "..\README.txt"; DestDir: "{app}\apps\alsSimpleGUI"; Flags: isreadme

Source: "..\bas\dllCallBackFunction.bas"; DestDir: "{app}\apps\alsSimpleGUI\bas"

Source: "..\frm\frmMain.frm"; DestDir: "{app}\apps\alsSimpleGUI\frm"
Source: "..\frm\frmMain.frx"; DestDir: "{app}\apps\alsSimpleGUI\frm"
Source: "..\frm\Intersil.ico"; DestDir: "{app}\apps\alsSimpleGUI\frm"

Source: "..\installer\alsSimpleGUI.devel.iss"; DestDir: "{app}\apps\alsSimpleGUI\installer"

[UninstallDelete]
Type: filesandordirs; Name: "{app}\apps\alsSimpleGUI"
Type: files;          Name: "{app}\output\Debug\bin\plotUserControl.oca"
Type: files;          Name: "{app}\output\Debug\bin\jungoUsb.oca"
Type: files;          Name: "{app}\output\Debug\bin\alsDrv.oca"

[Icons]
Name: "{group}\ALS Simple Gui"; Filename: "{app}\output\Debug\bin\alsSimpleGUI.exe";WorkingDir: "{app}\output\Debug\bin"
Name: "{group}\VB Project"; Filename: "{app}\apps\alsSimpleGUI\alsSimpleGUI.bat";WorkingDir: "{app}\apps\alsSimpleGUI"
Name: "{group}\uninstall"; Filename: "{app}\apps\alsSimpleGUI\unins000.exe";WorkingDir: "{app}"

