@ECHO OFF

tree /a > files.txt
cloc * >> files.txt

set h=___

set d=BAS
call :clocList

set d=CLS
call :clocList

set d=FRM
call :clocList

set h=___________
set d=LIBS.ALSUSB
call :clocList

set h=__________________
set d=LIBS.MONOCHROMATOR
call :clocList

set h=__________
set d=LIBS.NPXPS
call :clocList

set h=_________
set d=LIBS.PLOT
call :clocList

set h=________________
set d=LIBS.THORLABSAPT
call :clocList



tree /f /a >> files.txt

start files.txt

goto EOF

:clocList
echo %h% >> files.txt
echo %d% >> files.txt
cloc %d% >> files.txt

:EOF
