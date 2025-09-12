--[[
    Randomly moves the player and makes it look in random directions.
]]--

local Game = require("AirshipPackages/@Easy/Core/Shared/Game").Game
local CharacterMovement = Game.localPlayer.character.gameObject:GetComponent('CharacterMovement')
local SetInterval = require("AirshipPackages/@Easy/Core/Shared/Util/Timer").SetInterval

local randDirectionComponent = function()
	local r = math.random()
	if r < 1 / 3 then
		return -1
	elseif r < 2 / 3 then
		return 0
	else
		return 1
	end
end

local doMove = function()
	local direction = Vector3.new(randDirectionComponent(), 0, randDirectionComponent())
	CharacterMovement:SetMoveInput(direction, math.random() < 0.2, math.random() < 0.5, math.random() < 0.2, 1)
	local lookVec = Vector3.new(randDirectionComponent() * math.random(), randDirectionComponent() * math.random(), randDirectionComponent() * math.random())
	CharacterMovement:SetLookVector(lookVec)
end

SetInterval(0.1, function()
    doMove()
end)
