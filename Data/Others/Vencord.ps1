$url = "https://github.com/Vencord/Installer/releases/latest/download/VencordInstallerCli.exe"
$downloadPath = "$env:TEMP\VencordInstallerCli.exe"
Invoke-WebRequest -Uri $url -OutFile $downloadPath
cls 
echo "Control+c to exit and delete installer."
& $downloadPath
Remove-Item -Path $downloadPath -Force
