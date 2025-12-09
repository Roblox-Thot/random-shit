--[[
    Dumps all of the scripts in an Airship game.
]]--

local Game = require("AirshipPackages/@Easy/Core/Shared/Game").Game
local ChatColor = require("AirshipPackages/@Easy/Core/Shared/Util/ChatColor").ChatColor
local outFolder = Game.gameId -- :shrug: just game id ig

local function decompPrint(message)
    if not message then return end
    if type(message) == "table" then
        message = table.concat(message, " ")
    end
    message = tostring(message)
    print("Decomp:", message)
    message = ChatColor.Red("Decomp: ")..message
    Game:BroadcastMessage(message)
end

local getscriptbytecode = getscriptbytecode or function(script)
    local t = {}
    local bytes = script.m_bytes
    for i = 1, #bytes do
        t[i] = string.char(bytes[i])
    end
    return table.concat(t)
end

local decompile = decompile or function(script)
    local bytecode = getscriptbytecode(script)
    if not bytecode then
        return "-- Error: Could not get bytecode for script: " .. tostring(script.m_path)
    end
    local S,data = pcall(function()
        return request({
            Url = "http://127.0.0.1:8080/decompile",
            Body = crypt.base64encode(bytecode),  -- The base64 encoded bytecode
            Method = "POST",
            Headers = {
                ["Content-Type"] = "text/plain"
            },
        }).Body
    end)
    return S and data or "-- Error: "..tostring(data)
end

--------------------------------------

local function makeFolders(path)
    local splitName = path:split("/")
    local endPath = table.concat(splitName,"/",1, #splitName-1)
    
    if isfolder(outFolder.."/"..endPath) then return end
    
    if #splitName > 1 then
        folderPath = outFolder.."/"
        for i = 1, #splitName - 1 do
            task.wait()
            folderPath = folderPath .. splitName[i].."/"
            if not isfolder(folderPath ) then
                decompPrint("created folder" .. folderPath)
                makefolder(folderPath)
            end
        end
    end
end

-- make output folder if not there
if not isfolder(outFolder) then makefolder(outFolder) end

for _,v in getscripts(true) do
    path = tostring(v.m_path)
    if string.find(path,"@easy/core") then continue end -- @easy/core is saved in code.zip which is in appdata
    makeFolders(path)
    
    writefile(outFolder.."/"..path, decompile(v))
    writefile(outFolder.."/"..path..".dat", getscriptbytecode(v)) -- Save the bytecode as well just incase for later use
    decompPrint("Decompiled: " .. path)
end
decompPrint("Done")
