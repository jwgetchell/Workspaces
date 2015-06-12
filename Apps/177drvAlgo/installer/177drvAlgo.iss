; -- 177drvAlgo.iss --
;
[Setup]
AppName=ISL29177 Driver Test
AppVerName=ISL29177 Driver Test 1.5.0
DefaultDirName={pf}\Intersil\ISL29177 Driver Test
DefaultGroupName=Intersil\ISL29177 Driver Test
UninstallDisplayIcon={app}\177drvAlgo.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=177drvAlgo.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]
Source: C:\CVSROOT\ALS_(ambient_light_sensors)\Software\Workspaces.devel\output\Debug\bin\177drvAlgo.exe; DestDir: "{app}"
Source: C:\CVSROOT\ALS_(ambient_light_sensors)\Software\Workspaces.devel\output\Release\bin\registerDriver.dll; DestDir: "{app}"
Source: "..\doc\177drvAlgo.UserGuide.pdf"; DestDir: "{app}\doc"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\ISL29177 Driver Test"; Filename: "{app}\177drvAlgo.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"
Name: "{group}\User Guide"; Filename: "{app}\doc\177drvAlgo.UserGuide.pdf";WorkingDir: "{app}"

[Run]
Filename: "{app}\177drvAlgo.exe"; Description: "Launch application"; Flags: postinstall nowait skipifsilent