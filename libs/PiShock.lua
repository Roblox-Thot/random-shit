--Library for PiShock--

local function shockAPI(username: StringValue, app_name: StringValue, sharecode: StringValue, api_key: StringValue)
    local HttpRequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request

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
        if operations[operation] == nil then warn("Not a valid operation") return "Failed" end
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

        return response
    end
end

return shockAPI
