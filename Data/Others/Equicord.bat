@echo off
set "url=https://github.com/Equicord/Equilotl/releases/latest/download/EquilotlCli.exe"
set "downloadPath=%TEMP%\EquilotlCli.exe"
bitsadmin /transfer EquicordInstaller /download /priority normal %url% %downloadPath%
cls
%downloadPath%
del /f /q "%downloadPath%"
@echo on
