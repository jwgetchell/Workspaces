; -- alsUSB.iss --
;
[Setup]
AppName=Intersil ALS USB
AppVerName=Intersil ALS USB 1.0.0.1
DefaultDirName={pf}\Intersil\ALS USB
DefaultGroupName=Intersil\ALS USB (Devel)
UninstallDisplayIcon={app}\alsUSB.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=Intersil.alsUSB.setup
;OutputDir=..\..\..\output\setup
OutputDir=..\..\..\Distribution\Alpha
UninstallFilesDir={app}

[Files]
Source: "..\bas\kernel32.bas"; DestDir: "{app}\bas"
Source: "..\frm\frmMain.frm"; DestDir: "{app}\frm"
Source: "..\frm\frmMain.frx"; DestDir: "{app}\frm"
Source: "..\frm\Intersil.ico"; DestDir: "{app}\frm"
Source: "..\alsUSB.devel.vbp"; DestDir: "{app}"

Source: "..\..\..\output\Debug\bin\wd_utils.dll"; DestDir: "{app}"

Source: "..\..\..\output\Debug\bin\alsUSB.exe"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerEmulator.dll"; DestDir: "{app}"
;Source: "..\..\..\output\Debug\bin\alsUSB.ocx"; DestDir: "{app}"; Flags: regserver
Source: "..\README.txt"; DestDir: "{app}"; Flags: isreadme

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\Intersil ALS USB"; Filename: "{app}\alsUSB.exe";WorkingDir: "{app}"
Name: "{group}\Intersil ALS USB VB6 prj"; Filename: "{app}\alsUSB.devel.vbp";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

