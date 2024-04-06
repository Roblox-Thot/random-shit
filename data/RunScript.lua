--[[
    Plugin to run currently open Roblox script
]]

local Toolbar = plugin:CreateToolbar("Script Runner")
local runButton = Toolbar:CreateButton("Run Server", "Runs open script as server", "rbxassetid://0")
local ChangeHistoryService = game:GetService("ChangeHistoryService")
local StudioService = game:GetService("StudioService")

runButton.ClickableWhenViewportHidden = true

local format = [[return {pcall(function()
	%s
end)}]]

runButton.Click:Connect(function()
	if StudioService.ActiveScript == nil then warn('No script open') return end

	ChangeHistoryService:SetWaypoint("Running script")
	local host = Instance.new('ModuleScript')
	host.Source = format:format(StudioService.ActiveScript.Source)

	local runSuccess, runErr
	local compileSuccess, compileErr = pcall(function()
		runSuccess, runErr = unpack(require(host))
	end)

	host:Destroy()

	ChangeHistoryService:SetWaypoint("Run script")

	if compileSuccess then
		if runSuccess == false then
			warn("Runtime error in script:", runErr)
		end
	else
		print("Compile error in script:", compileErr)
	end
end)