; -- thorlabsAPT.iss --
;
[Setup]
AppName=thorlabsAPT
AppVerName=thorlabsAPT 1.0.0.1
DefaultDirName={pf}\Intersil\thorlabsAPT
DefaultGroupName=Intersil\thorlabsAPT
UninstallDisplayIcon={app}\thorlabsAPT.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=thorlabsAPT.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]
Source: "..\..\..\output\Debug\bin\thorlabsAPT.exe"; DestDir: "{app}"
Source: "..\..\..\output\Debug\bin\thorlabsAPT.ocx"; DestDir: "{app}"; Flags: regserver

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\thorlabsAPT"; Filename: "{app}\thorlabsAPT.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

