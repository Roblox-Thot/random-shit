--[[
    A very janky way to get items in the game like you could with Roblox.
    for example print(game.Forest2.Canvas.WorldName.item)

    If you wish to use this properly then I recommend making it a proxy
    or something so paths don't get leaked to the game.
]]--

if game == nil then
    game = require("AirshipPackages/@Easy/Core/Shared/Game").Game or {}
end

local function findKid(parent,name)
    if type(parent) ~= "table" then
        tParent = parent.transform
        for i = 0, tParent.childCount - 1 do
            local kid = tParent:GetChild(i)
            if kid.name == name then
                return kid
            end
        end
    end

    for _, kid in (parent) do
        if kid.name == name then
            return kid
        end
    end
    error("Kid with name '" .. name .. "' not found")
end

game = {}
local mt
mt = {
    __index = function(self, key)
        -- Build the new path string
        local parent = rawget(self, "item") or workspace
        local newPath = findKid(parent, key)

        -- Create a new subtable that knows its path
        local newtbl = setmetatable({ item = newPath }, mt)

        rawset(self, key, newtbl)
        return newtbl
    end
}

local t = setmetatable(game, mt)
