$url = "https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe"
$downloadPath = "$env:TEMP\VencordInstallerCli.exe"
Invoke-WebRequest -Uri $url -OutFile $downloadPath
cls
& $downloadPath
Remove-Item -Path $downloadPath -Force
