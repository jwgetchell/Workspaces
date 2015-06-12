; -- ISL29020.xlsm.iss --
;
[Setup]
AppName=Intersil ISL29020 Excel VBA
AppVerName=Intersil ISL29020 Excel VBA 1.0.0
DefaultDirName={pf}\Intersil\ISL29020 Excel VBA
DefaultGroupName=Intersil\ISL29020 Excel VBA
UninstallDisplayIcon={app}\ISL29020_xlsm.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=ISL29020_xlsm_setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]

Source: "..\excelVBA\ISL29020.xlsm"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\alsUSB.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\Interop.IWshRuntimeLibrary.dll"; DestDir: "{app}"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\ISL29020 Excel VBA"; Filename: "{app}\ISL29020.xlsm";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

[Run]
Filename: "{dotnet20}\RegAsm.exe"; Parameters: alsUSB.dll /tlb:alsUSB.tlb /codebase; WorkingDir: "{app}"
