# Cleans Roblox studio data in credential manager and registry
# Deleting the Roblox studio folder(s) and changing your MAC address will guarantee to not be linked

# This deletes all saved Roblox credentials from
# "Control Panel\User Accounts\Credential Manager"'s windows credential manager
cmdkey /list | ForEach-Object { if ($_ -like "*roblox*") { cmdkey /del:($_ -replace '^[^=]+',"" -replace "=","") } }

# Delete logged in users
reg delete HKCU\Software\Roblox\RobloxStudio\LoggedInUsersStore /f

# Delete tracking data
reg delete HKCU\Software\Roblox\RobloxStudio\RobloxStudioLaunchTrackingGuid /f
reg delete HKCU\Software\Roblox\RobloxStudio\Retention /f
reg delete HKCU\Software\Roblox\Retention /f
