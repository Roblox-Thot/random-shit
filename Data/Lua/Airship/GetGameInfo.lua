--[[
    Gets the game info from the Airship servers, good for getting the name.
]]--
local Game = require("AirshipPackages/@Easy/Core/Shared/Game").Game
local GameDataUrl = `{AirshipPlatformUrl.contentService}/games/game-id/{Game.gameId}`
print(GameDataUrl)
Data = request({
    Url = GameDataUrl,
    Method = "GET",
})
Data = json.decode(Data.Body)
print(Data)
