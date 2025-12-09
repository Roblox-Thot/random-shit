--[[
    A basic fly enabler, won't work on some games for obvious reasons.
]]--

local Game = require("AirshipPackages/@Easy/Core/Shared/Game").Game
local CharacterMovement = Game.localPlayer.character.gameObject:GetComponent('CharacterMovement')
local isFlying = CharacterMovement:IsFlying()
CharacterMovement:SetFlying(not isFlying)
