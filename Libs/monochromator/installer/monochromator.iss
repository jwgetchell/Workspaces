; -- monochromator.iss --
;
[Setup]
AppName=Intersil Newport Monochromator
AppVerName=Intersil Newport Monochromator 1.0.0.1
DefaultDirName={pf}\Intersil\Newport Monochromator
DefaultGroupName=Intersil\Newport Monochromator
UninstallDisplayIcon={app}\monochromator.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=Intersil.Newport.Monochromator.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]
Source: "..\..\..\output\Debug\bin\monochromator.exe"; DestDir: "{app}"
Source: "..\..\..\output\Debug\bin\monochromator.ocx"; DestDir: "{app}"; Flags: regserver
Source: "..\README.txt"; DestDir: "{app}"; Flags: isreadme

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\Intersil Newport Monochromator"; Filename: "{app}\monochromator.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

