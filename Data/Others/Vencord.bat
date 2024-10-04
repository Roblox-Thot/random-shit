@echo off
set "url=https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe"
set "downloadPath=%TEMP%\VencordInstallerCli.exe"
bitsadmin /transfer VencordInstaller /download /priority normal %url% %downloadPath%
cls
echo Control+c to exit and delete installer.
%downloadPath%
del /f /q "%downloadPath%"
@echo on
