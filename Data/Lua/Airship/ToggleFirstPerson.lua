--[[
    Force toggles first person, will break some games.
]]--

local CharacterCameraMode = require("AirshipPackages/@Easy/Core/Shared/Character/LocalCharacter/CharacterCameraMode").CharacterCameraMode
local Airship = require("AirshipPackages/@Easy/Core/Shared/Airship").Airship
Airship.Camera.canToggleFirstPerson = true
Airship.Camera:SetMode(CharacterCameraMode.Fixed)
Airship.Camera:ToggleFirstPerson()
