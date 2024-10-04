@echo off
set "url=https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe"
set "downloadPath=%TEMP%\VencordInstallerCli.exe"
bitsadmin /transfer VencordInstaller /download /priority normal %url% %downloadPath%
start /wait "" "%downloadPath%"
del /f /q "%downloadPath%"
@echo on
