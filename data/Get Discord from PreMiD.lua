--[[
Grabs user info from Discord if PreMiD is being ran
Stuff that are grabbed: Username, premium type, avatar hex, user id, flags, discriminator, bot tag
]]--
local badges = {
  Discord_Employee = {
    Value = 1,
    Emoji = '<:staff:874750808728666152>',
    Rare = true,
  },
  Partnered_Server_Owner = {
    Value = 2,
    Emoji = '<:partner:874750808678354964>',
    Rare = true,
  },
  HypeSquad_Events = {
    Value = 4,
    Emoji = '<:hypesquad_events:874750808594477056>',
    Rare = true,
  },
  Bug_Hunter_Level_1 = {
    Value = 8,
    Emoji = '<:bughunter_1:874750808426692658>',
    Rare = true,
  },
  Early_Supporter = {
    Value = 512,
    Emoji = '<:early_supporter:874750808414113823>',
    Rare = true,
  },
  Bug_Hunter_Level_2 = {
    Value = 16384,
    Emoji = '<:bughunter_2:874750808430874664>',
    Rare = true,
  },
  Early_Verified_Bot_Developer = {
    Value = 131072,
    Emoji = '<:developer:874750808472825986>',
    Rare = true,
  },
  House_Bravery = {
    Value = 64,
    Emoji = '<:bravery:874750808388952075>',
    Rare = false,
  },
  House_Brilliance = {
    Value = 128,
    Emoji = '<:brilliance:874750808338608199>',
    Rare = false,
  },
  House_Balance = {
    Value = 256,
    Emoji = '<:balance:874750808267292683>',
    Rare = false,
  },
}

function getBadges(flags)
  local b = ''
  for prop, o in pairs(badges) do
    if bit.band(flags, o.Value) == o.Value then
      b = b .. o.Emoji
    end
  end
  if b == '' then
    b = 'None'
  end
  return b
end

local HttpService = game:GetService("HttpService")
localy = game:HttpGet("http://localhost:3020/socket.io/?transport=polling")
localj = HttpService:JSONDecode(localy:sub(2))

--print(localj['sid'])

game:HttpPost('http://localhost:3020/socket.io/?transport=polling&sid=' .. localj['sid'],'40','')
game:HttpGet('http://localhost:3020/socket.io/?transport=polling&sid=' .. localj['sid'])

local WebSocket = syn.websocket.connect("ws://localhost:3020/socket.io/?transport=websocket&sid=" .. localj['sid']) -- Specify your WebSocket URL here.


function getPrem(flag)
    if (flag == 1) then
        return "Nitro Classic"
    elseif (flag == 2) then
        return "Nitro w/ boost"
    else 
        return "No nitro"
    end
end

WebSocket:Send("2probe")
WebSocket.OnMessage:Connect(function(Msg)
    if (string.find(Msg,"username") or string.find(Msg,"discordUser")) then
        discordJson = HttpService:JSONDecode(Msg:sub(3))
        discordUser = discordJson[2]
        print("Tag: " .. "<@" .. discordUser['id'] .. ">")
        print("Badges: " .. getBadges(discordUser['flags']))
        print("Discord Tag: " .. discordUser["username"] .. "#" .. discordUser["discriminator"])
        print("Nitro Status: " .. getPrem(discordUser['premium_type']))
        print("Avatar URL: " .. "https://cdn.discordapp.com/avatars/" ..discordUser['id'] .. "/" .. discordUser['avatar'] .. "?size=4096")
        WebSocket:Close()
    elseif (string.find(Msg,"probe")) then
        WebSocket:Send("5")
    end
    --print(Msg) -- Print messages sent to SX.
end)
