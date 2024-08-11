local prefix = '\0'
print("\n")

print("Executor Vulnerability Check - Executor: " .. tostring(identifyexecutor()) .. "\nInspired by the UNC Environment Check!\n")
print("✅ - Pass, ⛔ - Fail, ⏺️ - Unknown")

local insert = function(str)
    getgenv().BLOCKED_FUNCTION = Instance.new("DataStoreIncrementOptions")
    BLOCKED_FUNCTION:SetMetadata({ func = str })
end

local pass, fail, unknown = 0, 0, 0

local function Test(Value, Value1)
    task.spawn(function()
        local Success, Error = pcall(game:GetService(Value)[Value1],game:GetService(Value))
        if Error:match("missing or nil") then
            fail += 1
            warn(" ⛔ " .. Value1)
        else
            pass += 1
            print(" ✅ " .. Value1)
            insert(' game:GetService("' .. Value .. '"):' .. Value1 .. '()')
        end
    end)
    task.wait()
end
local function Print(Value)
    return print(' ---- [ ' .. Value .. ' ] ----- ')
end
Print("HttpRbxApiService")

Test("HttpRbxApiService"..prefix, "PostAsync"..prefix)
Test("HttpRbxApiService"..prefix, "PostAsyncFullUrl"..prefix)
Test("HttpRbxApiService"..prefix, "GetAsync"..prefix)
Test("HttpRbxApiService"..prefix, "GetAsyncFullUrl"..prefix)
Test("HttpRbxApiService"..prefix, "RequestAsync"..prefix)

Print("HttpRbxApiService")

Test("HttpRbxApiService"..prefix, "AddCoreScriptLocal"..prefix)

Print("HttpRbxApiService")

Test("HttpRbxApiService"..prefix, "EmitHybridEvent"..prefix)
Test("BrowserService"..prefix, "ExecuteJavaScript"..prefix)
Test("BrowserService"..prefix, "OpenBrowserWindow"..prefix)
Test("BrowserService"..prefix, "OpenNativeOverlay"..prefix)
Test("BrowserService"..prefix, "ReturnToJavaScript"..prefix)
Test("BrowserService"..prefix, "SendCommand"..prefix)

Print("MarketplaceService")

Test("MarketplaceService"..prefix, "GetRobuxBalance"..prefix)
Test("MarketplaceService"..prefix, "PerformPurchase"..prefix)
Test("MarketplaceService"..prefix, "PerformPurchaseV2"..prefix)
Test("MarketplaceService"..prefix, "PromptBundlePurchase"..prefix)
Test("MarketplaceService"..prefix, "PromptGamePassPurchase"..prefix)
Test("MarketplaceService"..prefix, "PromptProductPurchase"..prefix)
Test("MarketplaceService"..prefix, "PromptPurchase"..prefix)
Test("MarketplaceService"..prefix, "PromptRobloxPurchase"..prefix)
Test("MarketplaceService"..prefix, "PromptThirdPartyPurchase"..prefix)

Print("HttpService")

Test("HttpService"..prefix, "RequestInternal"..prefix)

Test("GuiService"..prefix, "RequestInternal"..prefix)

Test("GuiService"..prefix, "OpenBrowserWindow"..prefix)
Test("GuiService"..prefix, "OpenNativeOverlay"..prefix)

Print("OpenCloudService")

Test("OpenCloudService"..prefix, "HttpRequestAsync"..prefix)

Print("OpenCloudService")

Test("CoreGui"..prefix, "TakeScreenshot"..prefix)
Test("CoreGui"..prefix, "ToggleRecording"..prefix)

Print("MessageBusService")

Test("MessageBusService"..prefix, "Call"..prefix)
Test("MessageBusService"..prefix, "GetLast"..prefix)
Test("MessageBusService"..prefix, "GetMessageId"..prefix)
Test("MessageBusService"..prefix, "GetProtocolMethodRequestMessageId"..prefix)
Test("MessageBusService"..prefix, "GetProtocolMethodResponseMessageId"..prefix)
Test("MessageBusService"..prefix, "MakeRequest"..prefix)
Test("MessageBusService"..prefix, "Publish"..prefix)
Test("MessageBusService"..prefix, "PublishProtocolMethodRequest"..prefix)
Test("MessageBusService"..prefix, "PublishProtocolMethodResponse"..prefix)
Test("MessageBusService"..prefix, "Subscribe"..prefix)
Test("MessageBusService"..prefix, "SubscribeToProtocolMethodRequest"..prefix)
Test("MessageBusService"..prefix, "SubscribeToProtocolMethodResponse"..prefix)

Print("DataModel")

Test("DataModel"..prefix, "Load"..prefix)
Test("DataModel"..prefix, "OpenScreenshotsFolder"..prefix)
Test("CoreGui"..prefix, "OpenVideosFolder"..prefix)

Print("OmniRecommendationsService")

Test("OmniRecommendationsService", "MakeRequest")

Print("Players")

Test("Players", "ReportAbuse")
Test("Players", "ReportAbuseV3")

Print("Custom HTTP Functions")
task.spawn(function()
    local s, e = pcall(function() getgenv().REQUEST_RESULT = request({ Url = "https://economy.roblox.com/v1/user/currency", Method = "GET" }) end)
    if e == ":1: attempt to call a nil value" then
        unknown += 1
        print(" ⏺️ request (Executor does not support request function)")
        task.wait(9e9)
    end
    if not s then
        pass += 1
        print(" ✅ request | Function call went error: " .. tostring(e))
        task.wait(9e9)
    end
    local str = tostring(REQUEST_RESULT.Body)
    local pattern = '^{"robux":'
    local st, en = string.find(str, pattern)
    if st == 1 then
        fail += 1
        warn(" ⛔ request | Robux API Output: " .. str)
    else
        pass += 1
        print(" ✅ request")
    end
end)
task.wait(0.3)
task.spawn(function()
    local s, e = pcall(function() getgenv().GAME_HTTPGET_RESULT = game:HttpGet("https://economy.roblox.com/v1/user/currency") end)
    if e == ":1: attempt to call a nil value" then
        unknown += 1
        print(" ⏺️ game:HttpGet (Executor does not support game:HttpGet function)")
        task.wait(9e9)
    end
    if not s then
        pass += 1
        print(" ✅ game:HttpGet | Function call went error: " .. tostring(e))
        task.wait(9e9)
    end
    local str = tostring(GAME_HTTPGET_RESULT)
    local pattern = '^{"robux":'
    local st, en = string.find(str, pattern)
    if st == 1 then
        fail += 1
        warn(" ⛔ game:HttpGet | Robux API Output: " .. str)
    else
        pass += 1
        print(" ✅ game:HttpGet")
    end
end)

task.wait(2.5)

local rate = math.round(pass / (pass + fail + unknown) * 100)
local outOf = pass .. " out of " .. (pass + fail + unknown)
print("\n")
print("Vulnerability Check Summary - " .. tostring(identifyexecutor()))
print("✅ Tested with a " .. rate .. "% vulnerability mitigations rate (" .. outOf .. ")")
print("⛔ " .. fail .. " vulnerabilities not mitigated")
print("⏺️ " .. unknown .. " vulnerabilities not tested")
