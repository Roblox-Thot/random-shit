$url = "https://github.com/Equicord/Equilotl/releases/latest/download/EquilotlCli.exe"
$downloadPath = "$env:TEMP\EquilotlCli.exe"
Invoke-WebRequest -Uri $url -OutFile $downloadPath
cls
& $downloadPath
Remove-Item -Path $downloadPath -Force
