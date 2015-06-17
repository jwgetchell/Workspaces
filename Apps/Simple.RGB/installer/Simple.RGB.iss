; -- Simple.RGB.iss --
;
[Setup]
AppName=Intersil RGB Chroma Meter
AppVerName=Intersil RGB Chroma Meter 1.8.0
DefaultDirName={pf}\Intersil\RGB Chroma Meter
DefaultGroupName=Intersil\RGB Chroma Meter
UninstallDisplayIcon={app}\Simple.RGB.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=RGB.chroma.Meter.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]

Source: "..\..\..\output\Debug\bin\Simple.RGB.exe"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\alsUSB.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\Interop.IWshRuntimeLibrary.dll"; DestDir: "{app}"

Source: "..\CCMfiles\default.txt"; DestDir: "{app}\CCMfiles"
Source: "..\libs.alsUSB.NET\Test\simple.ALS.drv.xlsm"; DestDir: "{app}\CCMfiles"
Source: "..\libs.alsUSB.NET\Test\simple.ALS.drv.IR.xlsm"; DestDir: "{app}\CCMfiles"
Source: "..\doc\XYuvTables.xlsm"; DestDir: "{app}\doc"

; APP NOTES
; Enhancing RGB Sensitivity and Conversion Time
Source: "..\doc\AN1910.pdf"; DestDir: "{app}\doc"

; Chroma Meter Calibration: Optimizing CMF Accuracy for Realistic Lighting Situations
;Source: "..\doc\AN1911.pdf"; DestDir: "{app}\doc"
Source: "..\doc\ChromaMeter.UserGuide.pdf"; DestDir: "{app}\doc"

; Evaluation Hardware/Software User Manual for RGB Sensor
Source: "..\doc\AN1914.pdf"; DestDir: "{app}\doc"
; Digital Red, Green and Blue Color Light Sensor with IR Blocking Filter
Source: "..\doc\FN8424.pdf"; DestDir: "{app}\doc"
; RGB presentation
Source: C:\CVSROOT\ALS_(ambient_light_sensors)\Evaluations\DataArchive\alsSimpleGUI.Angle.WaveLength\Test.setups\Test.RGB.pdf; DestDir: "{app}\doc"

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\Chroma Meter"; Filename: "{app}\Simple.RGB.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

Name: "{group}\User Guide"; Filename: "{app}\doc\AN1914.pdf";WorkingDir: "{app}"

;Name: "{group}\Calibration App Note"; Filename: "{app}\doc\AN1911.pdf";WorkingDir: "{app}"
Name: "{group}\Calibration App Note"; Filename: "{app}\doc\ChromaMeter.UserGuide.pdf";WorkingDir: "{app}"

Name: "{group}\High Sensitivity App Note"; Filename: "{app}\doc\AN1910.pdf";WorkingDir: "{app}"
Name: "{group}\ISL29125 Datasheet"; Filename: "{app}\doc\FN8424.pdf";WorkingDir: "{app}"

Name: "{group}\xy-uv Tables"; Filename: "{app}\doc\XYuvTables.xlsm";WorkingDir: "{app}"
Name: "{group}\Presentation"; Filename: "{app}\doc\Test.RGB.pdf";WorkingDir: "{app}"

Name: "{group}\CCM Calibration Worksheet"; Filename: "{app}\CCMfiles\simple.ALS.drv.xlsm";WorkingDir: "{app}"
Name: "{group}\Clear Channel Cal (Alpha)"; Filename: "{app}\CCMfiles\simple.ALS.drv.IR.xlsm";WorkingDir: "{app}"
Name: "{group}\default calibration file"; Filename: "{app}\CCMfiles\default.txt";WorkingDir: "{app}"

[Run]
Filename: "{dotnet20}\RegAsm.exe"; Parameters: alsUSB.dll /tlb:alsUSB.tlb /codebase; WorkingDir: "{app}"
Filename: "{app}\Simple.RGB.exe"; Description: "Launch application"; Flags: postinstall nowait skipifsilent