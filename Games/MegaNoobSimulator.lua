--[[
  Basic auto farm but has a lot of bugs
  https://www.roblox.com/games/4543144283/NEW-ITEMS-Mega-Noob-Simulator
]]--

local Character = game.Players.LocalPlayer.Character
local Punch = game:GetService("ReplicatedStorage").Remotes.Punch

Character.HumanoidRootPart.Anchored = true
while task.wait() do 
    theNoob = workspace.Areas["Main Island"].EnemyHolder.Bacon

    -- Skips loop if the HRP is just missing (which happens because yes)
    if not Character:FindFirstChild("HumanoidRootPart") then continue end
    Character.HumanoidRootPart.CFrame  = theNoob.Head.CFrame + Vector3.new(-5,10,0)
    Punch:FireServer(theNoob)

    -- Removes the noob if its dead to skip it
    if theNoob.Humanoid.Health == 0 then
        theNoob:Destroy()
    end
end