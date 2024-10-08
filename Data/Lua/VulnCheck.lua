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
        local Success, Error = pcall(workspace.Parent:GetService(Value)[Value1],workspace.Parent:GetService(Value))
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

Test("HttpRbxApiService", "PostAsync")
Test("HttpRbxApiService", "PostAsyncFullUrl")
Test("HttpRbxApiService", "GetAsync")
Test("HttpRbxApiService", "GetAsyncFullUrl")
Test("HttpRbxApiService", "RequestAsync")

Print("HttpRbxApiService")

Test("HttpRbxApiService", "AddCoreScriptLocal")

Print("HttpRbxApiService")

Test("HttpRbxApiService", "EmitHybridEvent")
Test("BrowserService", "ExecuteJavaScript")
Test("BrowserService", "OpenBrowserWindow")
Test("BrowserService", "OpenNativeOverlay")
Test("BrowserService", "ReturnToJavaScript")
Test("BrowserService", "SendCommand")

Print("MarketplaceService")

Test("MarketplaceService", "GetRobuxBalance")
Test("MarketplaceService", "PerformPurchase")
Test("MarketplaceService", "PerformPurchaseV2")
Test("MarketplaceService", "PromptBundlePurchase")
Test("MarketplaceService", "PromptGamePassPurchase")
Test("MarketplaceService", "PromptProductPurchase")
Test("MarketplaceService", "PromptPurchase")
Test("MarketplaceService", "PromptRobloxPurchase")
Test("MarketplaceService", "PromptThirdPartyPurchase")

Print("HttpService")

Test("HttpService", "RequestInternal")

Test("GuiService", "RequestInternal")

Test("GuiService", "OpenBrowserWindow")
Test("GuiService", "OpenNativeOverlay")

Print("OpenCloudService")

Test("OpenCloudService", "HttpRequestAsync")

Print("OpenCloudService")

Test("CoreGui", "TakeScreenshot")
Test("CoreGui", "ToggleRecording")

Print("MessageBusService")

Test("MessageBusService", "Call")
Test("MessageBusService", "GetLast")
Test("MessageBusService", "GetMessageId")
Test("MessageBusService", "GetProtocolMethodRequestMessageId")
Test("MessageBusService", "GetProtocolMethodResponseMessageId")
Test("MessageBusService", "MakeRequest")
Test("MessageBusService", "Publish")
Test("MessageBusService", "PublishProtocolMethodRequest")
Test("MessageBusService", "PublishProtocolMethodResponse")
Test("MessageBusService", "Subscribe")
Test("MessageBusService", "SubscribeToProtocolMethodRequest")
Test("MessageBusService", "SubscribeToProtocolMethodResponse")

Print("DataModel")

Test("DataModel", "Load")
Test("DataModel", "OpenScreenshotsFolder")
Test("CoreGui", "OpenVideosFolder")

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
