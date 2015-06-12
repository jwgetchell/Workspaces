; -- LuxMeter.iss --
;
[Setup]
AppName=Intersil Lux Meter
AppVerName=Intersil Lux Meter 1.0.0.00
DefaultDirName={pf}\Intersil\Lux Meter
DefaultGroupName=Intersil\Lux Meter
UninstallDisplayIcon={app}\LuxMeter.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=Lux.Meter.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]
Source: "..\..\..\output\Debug\bin\LuxMeter.exe"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}"
;Source: "..\..\..\output\Release\bin\alsUSB.dll"; DestDir: "{app}"
;Source: "..\..\..\output\Release\bin\Interop.IWshRuntimeLibrary.dll"; DestDir: "{app}"

Source: "..\doc\ANxxxx.LuxMeter.UserManual.pdf"; DestDir: "{app}\doc"
Source: "..\doc\isl29035_ds.pdf"; DestDir: "{app}\doc"

Source: ..\doc\simpleCalibration.34.35.xlsx; DestDir: "{app}\doc"
;Source: ..\doc\simple.sequence.xlsm; DestDir: "{app}\doc"


[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\Lux Meter"; Filename: "{app}\LuxMeter.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

Name: "{group}\User Guide"; Filename: "{app}\doc\ANxxxx.LuxMeter.UserManual.pdf";WorkingDir: "{app}"
Name: "{group}\ISL29035 Datasheet"; Filename: "{app}\doc\isl29035_ds.pdf";WorkingDir: "{app}"

Name: "{group}\Calibration Worksheet"; Filename: "{app}\doc\simpleCalibration.34.35.xlsx";WorkingDir: "{app}"
;Name: "{group}\Simple Sequence"; Filename: "{app}\doc\simple.sequence.xlsm";WorkingDir: "{app}"

[Run]
;Filename: "{dotnet20}\RegAsm.exe"; Parameters: alsUSB.dll /tlb:alsUSB.tlb /codebase; WorkingDir: "{app}"
Filename: "{app}\LuxMeter.exe"; Description: "Launch application"; Flags: postinstall nowait skipifsilent