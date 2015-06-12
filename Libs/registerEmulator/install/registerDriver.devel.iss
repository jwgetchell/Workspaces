; -- registerDriver.devel.iss --

[Setup]
AppName=ALS_Register_Driver
AppVerName=ALS_Register_Driver 0.1.0.0

; {app} = DefaultDirName
DefaultDirName={pf}\Intersil\Workspace

DefaultGroupName=Intersil\registerDriver
UninstallDisplayIcon={app}\registerDriver.exe
Compression=lzma
SolidCompression=yes
OutputBaseFilename=registerDriver.devel.setup
OutputDir=..\..\..\output\setup
UninstallFilesDir={app}\libs\registerDriver

[Files]

Source: "..\README.txt"; DestDir: "{app}\libs\registerDriver"; Flags: isreadme
Source: "..\doc\SoftwareFunctionalSpecification.txt"; DestDir: "{app}\libs\registerDriver\doc"
Source: "..\doc\ReferenceManual.pdf"; DestDir: "{app}\libs\registerDriver\doc"

; binaries
;Source: "..\..\..\output\Debug\bin\driverTest.exe"; DestDir: "{app}\output\Debug\bin"
;Source: "..\..\..\output\Debug\bin\driverTest.cpp.exe"; DestDir: "{app}\output\Debug\bin"
;Source: "..\..\..\output\Debug\bin\registerDriver.dll"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Release\bin\driverTest.exe"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Release\bin\driverTest.cpp.exe"; DestDir: "{app}\output\Debug\bin"
Source: "..\..\..\output\Release\bin\registerDriver.dll"; DestDir: "{app}\output\Debug\bin"

;Source: "..\..\..\output\setup\registerDriver.devel.setup.exe"; DestDir: "{app}\output\setup"

; source code

Source: "..\registerDriver.bat";               DestDir: "{app}\libs\registerDriver"
Source: "..\registerDriver.sln";               DestDir: "{app}\libs\registerDriver"
Source: "..\registerDriver.vcproj";            DestDir: "{app}\libs\registerDriver"
Source: "..\driverTest.vcproj";                DestDir: "{app}\libs\registerDriver"
Source: "..\install\registerDriver.devel.iss"; DestDir: "{app}\libs\registerDriver\install"

Source: "..\source\ALSbaseClass.cpp";  DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ALSbaseClass.h";    DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\alsPrxI2cIo.cpp";   DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\alsPrxI2cIo.h";     DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\alsPrxTypes.h";     DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\avgStats.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\avgStats.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\cApi.cpp";          DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\cApi.h";            DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\driverTest.c";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\emulator.c";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\emulator.h";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29011.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29011.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29020.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29020.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29023.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29023.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29025.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29025.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29028.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29028.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29033.cpp";      DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\ISL29033.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\islIoctl.c";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\islIoctl.h";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\registerDriver.def";DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\resMgr.cpp";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\resMgr.h";          DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\stateMachine.cpp";  DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\stateMachine.h";    DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\stdafx.cpp";        DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\stdafx.h";          DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\targetver.h";       DestDir: "{app}\libs\registerDriver\source"
Source: "..\source\test.cpp";          DestDir: "{app}\libs\registerDriver\source"
;Source: "..\source\test.TSL2771.cpp";  DestDir: "{app}\libs\registerDriver\source"
;Source: "..\source\TSL2771.cpp";       DestDir: "{app}\libs\registerDriver\source"
;Source: "..\source\TSL2771.h";         DestDir: "{app}\libs\registerDriver\source"
;Source: "..\source\resMgr.TSL2771.cpp";DestDir: "{app}\libs\registerDriver\source"

Source: "..\driverTest\driverTest.vcproj";     DestDir: "{app}\libs\registerDriver\driverTest"
;Source: "..\driverTest\driverTest.c";          DestDir: "{app}\libs\registerDriver\driverTest"
;Source: "..\driverTest\driverTest.cpp.vcproj"; DestDir: "{app}\libs\registerDriver\driverTest"
;Source: "..\driverTest\driverTest.cpp";        DestDir: "{app}\libs\registerDriver\driverTest"

Source: "..\driverTest\stdafx.cpp";            DestDir: "{app}\libs\registerDriver\driverTest"
Source: "..\driverTest\stdafx.h";              DestDir: "{app}\libs\registerDriver\driverTest"
Source: "..\driverTest\targetver.h";           DestDir: "{app}\libs\registerDriver\driverTest"

Source: "..\source\Debug\makefile";            DestDir: "{app}\libs\registerDriver\source\Debug"
Source: "..\source\Debug\objects.mk";          DestDir: "{app}\libs\registerDriver\source\Debug"
Source: "..\source\Debug\sources.mk";          DestDir: "{app}\libs\registerDriver\source\Debug"
Source: "..\source\Debug\subdir.mk";           DestDir: "{app}\libs\registerDriver\source\Debug"

[UninstallDelete]
Type: filesandordirs; Name: "{app}\libs\registerDriver"
Type: files;          Name: "{app}\output\Debug\bin\registerDriver.*"
Type: files;          Name: "{app}\output\Debug\lib\registerDriver.*"
Type: files;          Name: "{app}\output\Debug\bin\driverTest.*"
Type: files;          Name: "{app}\output\Debug\lib\driverTest.*"
Type: files;          Name: "{app}\setup\registerDriver.devel.setup.exe"
Type: filesandordirs; Name: "{app}\output\Debug\registerDriver"
Type: filesandordirs; Name: "{app}\output\Debug\driverTest"
Type: filesandordirs; Name: "{app}\output\Debug\driverTest.cpp"

[Icons]
Name: "{group}\VS Project"; Filename: "{app}\libs\registerDriver\registerDriver.bat";WorkingDir: "{app}\libs\registerDriver"
Name: "{group}\uninstall"; Filename: "{app}\libs\registerDriver\unins000.exe"

