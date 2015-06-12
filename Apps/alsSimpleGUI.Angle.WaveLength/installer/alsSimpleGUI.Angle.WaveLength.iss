; -- alsSimpleGUI.Angle.WaveLength.iss --
;
[Setup]
AppName=Intersil ALS Swept Measurements
AppVerName=Intersil ALS Swept Measurements 1.0.0.1
DefaultDirName={pf}\Intersil\ALS Swept Measurements
DefaultGroupName=Intersil\ALS Swept Measurements
UninstallDisplayIcon={app}\alsSimpleGUI.Angle.WaveLength.exe

Compression=lzma
SolidCompression=yes

OutputBaseFilename=alsSimpleGUI.Angle.WaveLength.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}

[Files]
Source: C:\WINDOWS\system32\comdlg32.ocx; DestDir: {sys}; Flags: restartreplace sharedfile regserver
Source: "..\..\..\output\Debug\bin\wd_utils.dll"; DestDir: "{app}"
Source: "..\..\..\output\Debug\bin\XPS_C8_drivers.dll"; DestDir: "{app}"

Source: "..\..\..\output\Debug\bin\alsSimpleGUI.Angle.WaveLength.exe"; DestDir: "{app}"
;Source: "..\..\..\output\Debug\bin\thorlabsAPT.exe"; DestDir: "{app}"
;Source: "..\..\..\output\Debug\bin\monochromator.exe"; DestDir: "{app}"
;Source: "..\..\..\output\Debug\bin\alsUSB.exe"; DestDir: "{app}"

;Source: "..\..\..\output\Debug\bin\thorlabsAPT.ocx"; DestDir: "{app}"; Flags: regserver
;Source: "..\..\..\output\Debug\bin\plotUserControl.ocx"; DestDir: "{app}"; Flags: regserver
;Source: "..\..\..\output\Debug\bin\monochromator.ocx"; DestDir: "{app}"; Flags: regserver

;Source: "..\..\..\output\Debug\bin\alsUSB.ocx"; DestDir: "{app}"; Flags: regserver

Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}"
Source: "..\..\..\output\Release\bin\registerEmulator.dll"; DestDir: "{app}"

Source: "..\README.html"; DestDir: "{app}"; Flags: isreadme

; _________________
; Development Files
; ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

;Source: "..\bas\modCalibration.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modFileSave.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modGlobals.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modMain.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modPlot.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modPowerCalibration.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modScript.bas"; DestDir: "{app}\bas"
;Source: "..\bas\modTestDefs.bas"; DestDir: "{app}\bas"
;
;Source: "..\cls\clsAlsSweep.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsAngleSweep.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsAoutSweep.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsProxSweep.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestComp.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestProxAR.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestProxAR.vsDelay.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestProxAR0.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestProxAR1.cls"; DestDir: "{app}\cls"
;Source: "..\cls\clsTestProxOffset.cls"; DestDir: "{app}\cls"
;
;Source: "..\frm\38special.ico"; DestDir: "{app}\frm"
;Source: "..\frm\alsEt.ico"; DestDir: "{app}\frm"
;Source: "..\frm\frm2771.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frm2771.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frm29038.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frm29038.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmAbout.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmAbout.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmDeviceEnable.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmEtIo.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmEtIo.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmMain.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmMain.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmPlot.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmPlot.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmPrompt.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmPwrCal.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmPwrCal.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmTest.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmTest.frx"; DestDir: "{app}\frm"
;Source: "..\frm\Intersil.ico"; DestDir: "{app}\frm"
;Source: "..\frm\Newport.ico"; DestDir: "{app}\frm"
;Source: "..\frm\plot.ico"; DestDir: "{app}\frm"
;Source: "..\frm\taos.ico"; DestDir: "{app}\frm"
;Source: "..\frm\thorlabs.ico"; DestDir: "{app}\frm"
;
;
;Source: "..\libs.thorlabsAPT\bas\thorlabsAPT.bas"; DestDir: "{app}\libs.thorlabsAPT\bas"
;
;Source: "..\libs.plot\bas\modPlot.bas"; DestDir: "{app}\libs.plot\bas"
;Source: "..\libs.plot\bas\modRadiation.bas"; DestDir: "{app}\libs.plot\bas"
;Source: "..\libs.plot\bas\modRadiationResponse.bas"; DestDir: "{app}\libs.plot\bas"
;Source: "..\libs.plot\bas\modResponse.bas"; DestDir: "{app}\libs.plot\bas"
;
;Source: "..\libs.plot\ctl\ucPlot.ctl"; DestDir: "{app}\libs.plot\ctl"
;Source: "..\libs.plot\ctl\ucPlot.ctx"; DestDir: "{app}\libs.plot\ctl"
;
;Source: "..\frm\frmAbout.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmAbout.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmMain.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmMain.frx"; DestDir: "{app}\frm"
;Source: "..\frm\frmPlot.frm"; DestDir: "{app}\frm"
;Source: "..\frm\frmPlot.frx"; DestDir: "{app}\frm"
;Source: "..\frm\Intersil.ico"; DestDir: "{app}\frm"
;Source: "..\frm\Newport.ico"; DestDir: "{app}\frm"
;Source: "..\frm\plot.ico"; DestDir: "{app}\frm"
;Source: "..\frm\thorlabs.ico"; DestDir: "{app}\frm"
;Source: "..\alsSimpleGUI.Angle.WaveLength.alsUSB.vbp"; DestDir: "{app}"


[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Icons]
Name: "{group}\Intersil ALS Swept Measurements"; Filename: "{app}\alsSimpleGUI.Angle.WaveLength.exe";WorkingDir: "{app}"
;Name: "{group}\Intersil ALS Swept Measurements VB6 prj"; Filename: "{app}\alsSimpleGUI.Angle.WaveLength.alsUSB.vbp";WorkingDir: "{app}"
;Name: "{group}\Thorlabs APT"; Filename: "{app}\thorlabsAPT.exe";WorkingDir: "{app}"
;Name: "{group}\Newport Monochromator"; Filename: "{app}\monochromator.exe";WorkingDir: "{app}"
;Name: "{group}\Intersil ALS"; Filename: "{app}\alsUSB.exe";WorkingDir: "{app}"
Name: "{group}\uninstall"; Filename: "{app}\unins000.exe";WorkingDir: "{app}"

