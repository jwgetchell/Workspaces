; -- alsEvalGui.devl.iss --

[Setup]
AppName=ALS_Eval_GUI
AppVerName=ALS_Eval_GUI 0.1.0.2

; {app} = DefaultDirName
DefaultDirName={pf}\Intersil\Workspace

DefaultGroupName=Intersil\alsEvalGUI
UninstallDisplayIcon={app}\alsEvalGUI.exe
Compression=lzma
SolidCompression=yes
OutputBaseFilename=alsEvalGUI.devl.setup
OutputDir=..\..\output\Debug\setup
UninstallFilesDir={app}\apps\alsEvalGUI

[Files]
Source: C:\WINDOWS\system32\comdlg32.ocx; DestDir: {sys}; Flags: restartreplace sharedfile regserver

; binaries
Source: "..\..\output\Debug\bin\alsEvalGUI.exe"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\output\Debug\bin\registerDriver.dll"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\output\Debug\bin\wd_utils.dll"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\output\Debug\bin\plotUserControl.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver
Source: "..\..\output\Debug\bin\jungoUsb.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver
Source: "..\..\output\Debug\bin\alsDrv.ocx"; DestDir: "{app}\output\Debug\bin"; Flags: regserver

Source: "README.txt"; DestDir: "{app}\apps\alsEvalGUI"; Flags: isreadme

; source code

Source: "alsEvalGUI.bat"; DestDir: "{app}\apps\alsEvalGUI"
Source: "alsEvalGUI.vbp"; DestDir: "{app}\apps\alsEvalGUI"

Source: "bas\dllCallBackFunction.bas"; DestDir: "{app}\apps\alsEvalGUI\bas"

Source: "frm\frmTest.frm"; DestDir: "{app}\apps\alsEvalGUI\frm"
Source: "frm\frmTest.frx"; DestDir: "{app}\apps\alsEvalGUI\frm"
Source: "frm\Intersil.ico"; DestDir: "{app}\apps\alsEvalGUI\frm"

Source: "alsEvalGUI.devel.iss"; DestDir: "{app}\apps\alsEvalGUI"

[UninstallDelete]
Type: filesandordirs; Name: "{app}\apps\alsEvalGUI"

[Icons]
Name: "{group}\ALS Eval Gui"; Filename: "{app}\output\Debug\bin\alsEvalGUI.exe";WorkingDir: "{app}\output\Debug\bin"
Name: "{group}\VB Project"; Filename: "{app}\apps\alsEvalGUI\alsEvalGUI.bat";WorkingDir: "{app}\apps\alsEvalGUI"
Name: "{group}\uninstall"; Filename: "{app}\apps\alsEvalGUI\unins000.exe"

