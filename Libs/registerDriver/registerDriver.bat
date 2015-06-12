set path=%path%;%cd%\..\..\output\Debug\bin
set dir=%CD%
cd ../..
set ISL_SWDEVEL_ROOT=%CD%
cd %dir%
start registerDriver.sln
