# Deletes all Roblox credentials from
# "Control Panel\User Accounts\Credential Manager"'s windows credential manager

# Just run this in a powershell window
cmdkey /list | ForEach-Object { if ($_ -like "*roblox*") { cmdkey /del:($_ -replace '^[^=]+',"" -replace "=","") } }

# This clears the Roblox Studio Registry which will clear any other logged in accounts
reg delete HKCU\Software\Roblox\RobloxStudio /f
