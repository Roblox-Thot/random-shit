# random-shit
Random scripts and shit that don't require their own repo but I don't want to use gist since it's not great.

## Javascript

<!-- GetAuthTicket.js -->
<details>
  <summary>GetAuthTicket.js</summary>
  <blockquote>
    <a href="Data/Javascript/GetAuthTicket.js">Source link</a><br>
    JavaScript to get a auth ticket on the Roblox website.
  </blockquote>
</details>

<!-- GetAuthTicketRoblox.js -->
<details>
  <summary>GetAuthTicketRoblox.js</summary>
  <blockquote>
    <a href="Data/Javascript/GetAuthTicketRoblox.js">Source link</a><br>
    JavaScript that gets the auth ticket but useing the Roblox library loaded when the site loads, so it will always work. (until they change the function name)
  </blockquote>
</details>

<!-- RobloxSourceMaps.js -->
<details>
  <summary>RobloxSourceMaps.js</summary>
  <blockquote>
    <a href="Data/Javascript/RobloxSourceMaps.js">Source link</a><br>
    JavaScript to grab all source maps from Roblox.com.<br>
    To use just run it in a browser's console.
  </blockquote>
</details>

## Lua

<!-- Badges.lua -->
<details>
  <summary>Badges.lua</summary>
  <blockquote>
    <a href="Data/Lua/Badges.lua">Source link</a><br>
    Roblox script to grab all the Roblox badge ids in the current game.
  </blockquote>
</details>

<!-- ExtractZip.lua -->
<details>
  <summary>ExtractZip.lua</summary>
  <blockquote>
    <a href="Data/Lua/ExtractZip.lua">Source link</a><br>
    Extracts a zip from a url into the workspace folder of the user.<br>
    Uses a edited version of 0x5eal's <a href="https://github.com/0x5eal/luau-unzip">luau-unzip</a> to work in Roblox scripting utils.
  </blockquote>
</details>

<!-- GetDiscordFromPreMiD.lua -->
<details>
  <summary>GetDiscordFromPreMiD.lua</summary>
  <blockquote>
    <a href="Data/Lua/GetDiscordFromPreMiD.lua">Source link</a><br>
    <b>The PreMiD app is no longer used so this isn't useful</b><br><br>
    If the user has PreMiD installed then it will print/grab some user info.<br>
    Example:<br>
    <img width=690 alt="image" src="https://user-images.githubusercontent.com/67937010/208335348-84c2de5d-c9a8-42f1-832a-af556241ccd8.png">
  </blockquote>
</details>

<!-- GitBlox.lua -->
<details>
  <summary>GitBlox.lua</summary>
  <blockquote>
    <a href="Data/Lua/GitBlox.lua">Source link</a><br>
    Roblox Studio script to clone a github repo into the game<br>
    An auth token is recommended as you WILL be ratelimited other wise in most cases
  </blockquote>
</details>

<!-- LogFilesInWorkspace.lua -->
<details>
  <summary>LogFilesInWorkspace.lua</summary>
  <blockquote>
    <a href="Data/Lua/WorkspaceLog/LogFilesInWorkspace.lua">Source link</a><br>
    Will save to file any whitelisted files to a file.<br>
    To export saved data use this <a href="Data/Lua/WorkspaceLog/ExportLoggedFiles.lua">Luau script</a> or <a href="Data/Lua/WorkspaceLog/ExportLoggedFiles.py">Python script</a>.<br>
  </blockquote>
</details>

<!-- PiShock.lua -->
<details>
  <summary>PiShock.lua</summary>
  <blockquote>
    <a href="Libraries/PiShock.lua">Source link</a><br>
    Library for PiShock<br>
    <img height=420 src="https://github.com/Roblox-Thot/random-shit/assets/67937010/38e66160-8e98-4f05-8d98-ec04bb777873">
  </blockquote>
</details>

<!-- RunScript.lua -->
<details>
  <summary>RunScript.lua</summary>
  <blockquote>
    <a href="Data/Lua/RunScript.lua">Source link</a><br>
    Roblox Studio plugin to allow running the currently open script.<br>
    Just place the Lua file in "%localappdata%/Roblox/Plugins"
  </blockquote>
</details>

<!-- VulnCheck.lua + VulnCheckNul.lua -->
<details>
  <summary>VulnCheck.lua + VulnCheckNul.lua</summary>
  <blockquote>
    <a href="Data/Lua/VulnCheck.lua">VulnCheck.lua</a> <a href="Data/Lua/VulnCheckNul.lua">VulnCheckNul.lua</a><br>
    (Do note this test is shit with not checking for bypasses too)<br>
    Runs a basic check for functions that can be abused, VulnCheckNul adds Null to the end of functions which can bypass some blocks.
  </blockquote>
</details>

## Powershell

<!-- DeleteRobloxKeys.ps1 -->
<details>
  <summary>DeleteRobloxKeys.ps1</summary>
  <blockquote>
    <a href="Data/Powershell/DeleteRobloxKeys.ps1">Source link</a><br>
    Powershell script to remove any Roblox keys from Windows Credential manager tab.
  </blockquote>
</details>

<!-- Equicord.ps1 -->
<details>
  <summary>Equicord.ps1</summary>
  <blockquote>
    <a href="Data/Powershell/Equicord.ps1">Source link</a><br>
    Powershell script to download and run the Equicord CLI installer..<br>
    irm "https://roblox-thot.github.io/random-shit/Data/Powershell/Equicord.ps1" | iex
  </blockquote>
</details>

<!-- Vencord.ps1 -->
<details>
  <summary>Vencord.ps1</summary>
  <blockquote>
    <a href="Data/Powershell/Vencord.ps1">Source link</a><br>
    Powershell script to download and run the Vencord CLI installer..<br>
    irm "https://roblox-thot.github.io/random-shit/Data/Powershell/Vencord.ps1" | iex
  </blockquote>
</details>

## Python 

<!-- AddEmails.py -->
<details>
  <summary>AddEmails.py</summary>
  <blockquote>
    <a href="Data/Python/AddEmails.py">Source link</a><br>
    Python script to add a random email to your Roblox account.<br>
    You do require a domain with email forwarding to somewhere you can read all the emails.
  </blockquote>
</details>

<!-- AvatarChangeLogs.py -->
<details>
  <summary>AvatarChangeLogs.py</summary>
  <blockquote>
    <a href="Data/Python/AvatarChangeLogs.py">Source link</a><br>
    Python to log roblox avatar changes to a Discord webhook<br>
    <a href='https://i.imgur.com/lcu7yFf.png'><img height=420 src='https://i.imgur.com/lcu7yFf.png'></a>
  </blockquote>
</details>

<!-- DiscordRobloxConnection.py -->
<details>
  <summary>DiscordRobloxConnection.py</summary>
  <blockquote>
    <a href="Data/Python/DiscordRobloxConnection.py">Source link</a><br>
    Python script to host a site to allow mass authenticating Roblox accounts for Discord.<br>
    Recommended method is to use <a href=https://github.com/ic3w0lf22/Roblox-Account-Manager>ic3w0lf22/Roblox-Account-Manager</a> and click the "Open URL" with "http://127.0.0.1/"<br>
    <a href='https://i.imgur.com/bXELV3Z.png'><img height=200 src='https://i.imgur.com/bXELV3Z.png'></a>
  </blockquote>
</details>

<!-- GithubUpdateLogs.py -->
<details>
  <summary>GithubUpdateLogs.py</summary>
  <blockquote>
    <a href="Data/Lua/GithubUpdateLogs.py">Source link</a><br>
    Checks for new github repo updates and pushes it to a discord webhook
  </blockquote>
</details>

<!-- RobloxUnwarn.py -->
<details>
  <summary>RobloxUnwarn.py</summary>
  <blockquote>
    <a href="Data/Python/RobloxUnwarn.py">Source link</a><br>
    Python script to show a way to restore a Roblox account after a warn or waited out ban.
  </blockquote>
</details>

<!-- SeprateColors.py -->
<details>
  <summary>SeprateColors.py</summary>
  <blockquote>
    <a href="Data/Python/SeprateColors.py">Source link</a><br>
    Python script to simplify an image int X amount of colors then make an image for each layer.
  </blockquote>
</details>

## Userscripts

<!-- CloudflareTurnstile.user.js -->
<details>
  <summary>CloudflareTurnstile.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/CFTurnstileClicker.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/CFTurnstileClicker.user.js">Install</a><br>
    Auto clicks the Cloudflare turnstile checkbox once it loads to auto solve it.
  </blockquote>
</details>

<!-- MinibloxAdblock.user.js -->
<details>
  <summary>MinibloxAdblock.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/MinibloxAdblock.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/MinibloxAdblock.user.js">Install</a><br>
    Tells Miniblox to disable ads then starts running it, won't be updated if they ever fix it though.
  </blockquote>
</details>

<!-- ReCaptchaClicker.user.js -->
<details>
  <summary>ReCaptchaClicker.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/ReCaptchaClicker.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/ReCaptchaClicker.user.js">Install</a><br>
    Auto clicks the ReCaptcha checkbox once it loads to solve it, but may not be as nice compaired to CF Turnstile since there may be a required solve.
  </blockquote>
</details>

<!-- RobloxDarkMode.user.js -->
<details>
  <summary>RobloxDarkMode.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/RobloxDarkMode.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/RobloxDarkMode.user.js">Install</a><br>
    Turns on Roblox's dark mode by default on any logged in or made account to protect eyes.
  </blockquote>
</details>

<!-- SourceMapGrabber.user.js -->
<details>
  <summary>SourceMapGrabber.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/SourceMapGrabber.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/SourceMapGrabber.user.js">Install</a><br>
    Tamper monkey script to scrape the source map links off the current page and add a button to the extention popout to print them to page.<br>
    (Shit but works some of the time)
  </blockquote>

<!-- YoutubeDisable.user.js -->
<details>
  <summary>YoutubeDisable.user.js</summary>
  <blockquote>
    <a href="Data/Javascript/Userscripts/YoutubeDisable.user.js">Source link</a><br>
    <a href="https://roblox-thot.github.io/random-shit/Data/Javascript/Userscripts/YoutubeDisable.user.js">Install</a><br>
    Disables the arrow keys and numbers to preven seeking on YouTube by mistake.<br>
  </blockquote>
</details>
