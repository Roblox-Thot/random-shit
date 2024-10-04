$url = "https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe"
$downloadPath = "$env:TEMP\VencordInstallerCli.exe"
Invoke-WebRequest -Uri $url -OutFile $downloadPath
Start-Process -FilePath $downloadPath -Wait
Remove-Item -Path $downloadPath -Force
