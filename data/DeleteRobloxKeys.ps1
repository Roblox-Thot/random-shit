# Cleans Roblox studio data

# This deletes all saved Roblox credentials from
# "Control Panel\User Accounts\Credential Manager"'s windows credential manager
cmdkey /list | ForEach-Object { if ($_ -like "*roblox*") { cmdkey /del:($_ -replace '^[^=]+',"" -replace "=","") } }

# Delete logged in users
reg delete HKCU\Software\Roblox\RobloxStudio\LoggedInUsersStore /f

# Delete tracking data
reg delete HKCU\Software\Roblox\RobloxStudio\RobloxStudioLaunchTrackingGuid /f
reg delete HKCU\Software\Roblox\RobloxStudio\Retention
