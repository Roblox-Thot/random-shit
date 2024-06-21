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

Test("HttpRbxApiService\0", "PostAsync")
Test("HttpRbxApiService\0", "PostAsyncFullUrl")
Test("HttpRbxApiService\0", "GetAsync")
Test("HttpRbxApiService\0", "GetAsyncFullUrl")
Test("HttpRbxApiService\0", "RequestAsync")

Print("HttpRbxApiService")

Test("HttpRbxApiService\0", "AddCoreScriptLocal")

Print("HttpRbxApiService")

Test("HttpRbxApiService\0", "EmitHybridEvent")
Test("BrowserService\0", "ExecuteJavaScript")
Test("BrowserService\0", "OpenBrowserWindow")
Test("BrowserService\0", "OpenNativeOverlay")
Test("BrowserService\0", "ReturnToJavaScript")
Test("BrowserService\0", "SendCommand")

Print("MarketplaceService")

Test("MarketplaceService\0", "GetRobuxBalance")
Test("MarketplaceService\0", "PerformPurchase")
Test("MarketplaceService\0", "PerformPurchaseV2")
Test("MarketplaceService\0", "PromptBundlePurchase")
Test("MarketplaceService\0", "PromptGamePassPurchase")
Test("MarketplaceService\0", "PromptProductPurchase")
Test("MarketplaceService\0", "PromptPurchase")
Test("MarketplaceService\0", "PromptRobloxPurchase")
Test("MarketplaceService\0", "PromptThirdPartyPurchase")

Print("HttpService")

Test("HttpService\0", "RequestInternal")

Test("GuiService\0", "RequestInternal")

Test("GuiService\0", "OpenBrowserWindow")
Test("GuiService\0", "OpenNativeOverlay")

Print("OpenCloudService")

Test("OpenCloudService\0", "HttpRequestAsync")

Print("OpenCloudService")

Test("CoreGui\0", "TakeScreenshot")
Test("CoreGui\0", "ToggleRecording")

Print("MessageBusService")

Test("MessageBusService\0", "Call")
Test("MessageBusService\0", "GetLast")
Test("MessageBusService\0", "GetMessageId")
Test("MessageBusService\0", "GetProtocolMethodRequestMessageId")
Test("MessageBusService\0", "GetProtocolMethodResponseMessageId")
Test("MessageBusService\0", "MakeRequest")
Test("MessageBusService\0", "Publish")
Test("MessageBusService\0", "PublishProtocolMethodRequest")
Test("MessageBusService\0", "PublishProtocolMethodResponse")
Test("MessageBusService\0", "Subscribe")
Test("MessageBusService\0", "SubscribeToProtocolMethodRequest")
Test("MessageBusService\0", "SubscribeToProtocolMethodResponse")

Print("DataModel")

Test("DataModel\0", "Load")
Test("DataModel\0", "OpenScreenshotsFolder")
Test("CoreGui\0", "OpenVideosFolder")

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
