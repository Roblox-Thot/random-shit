--[[
    PiShock Library made by Roblox Thot
    Discord: @Roblox_Thot
    Telegram: @Roblox_Thot
    GitHub: Roblox-Thot
    
    
    How to use:

    shockAPI = loadstring(game:HttpGet('url here'))
    shocker = shockAPI('RT','Roblox','ShareCode','ApiKey')
    shocker(50,2,'shock')
]]--

local HttpRequest = http and http.request or http_request or request

local function shockAPI(username: StringValue, app_name: StringValue, sharecode: StringValue, api_key: StringValue)
    local self = {
        username = username,
        app_name = app_name,
        sharecode = sharecode,
        api_key = api_key
    }

    local operations = {
        shock = 0,
        vibrate = 1,
        beep = 2
    }

    return function(intensity: IntValue, duration: IntValue, operation: StringValue)
        if operation == nil then operation = "vibrate" end
        if operations[string.lower(operation)] == nil then warn("Not a valid operation") return "Failed" end
        if intensity < 1 or intensity > 100 then warn("intensity range is 1-100") return "Failed" end
        if duration < 1 or duration > 15 then warn("duration range is 1-100") return "Failed" end

        local body = {
            Username = self.username,
            Name = self.app_name,
            Code = self.sharecode,
            Intensity = intensity,
            Duration = duration,
            Apikey = self.api_key,
            Op = operations[operation]
        }

        local response = HttpRequest({
            Url = "https://do.pishock.com/api/apioperate/",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode(body)
        })

        return response.Body
    end
end

return shockAPI
