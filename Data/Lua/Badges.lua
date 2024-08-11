-- Prints all badge IDs for games

local game = workspace.Parent
local HttpService = game:GetService("HttpService")
local badgeUrl = "https://badges.roblox.com/v1/universes/"..game.GameId.."/badges?limit=100&sortOrder=Asc&cursor="
local cursor = ""

repeat
   local response = game:HttpGet(badgeUrl..cursor)
   local data = HttpService:JSONDecode(response)
   cursor = data.nextPageCursor
   
   for _, badge in ipairs(data.data) do
       print(badge.id)
   end
until not cursor
