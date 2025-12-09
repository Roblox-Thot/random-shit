--[[
    case insensitive
    Log only the whitelisted terms

    Ex: whitelisting "lua"
    can save a file called  "6872274481.Lua"
]]--

local whitelistedTypes = {
    "lua",
    "txt"
}

--[[
    CaSe sEnSiTiVe
    Don't log files that have the string in the name

    Ex: blocking "profile"
    can block a file called "test.vapeprofile.txt"
]]
local blacklistedInNames = {
    "profile"
}

local outFileName = "out.txt"

--------------------------

-- Just here to not log the out file over and over lol
table.insert(blacklistedInNames, outFileName)

local files = {}
local home = listfiles('')
local folders = {}

function createfile(files)
    local dick = {}
    for index, content in pairs(files) do
        local data = readfile(files[index])
        dick[files[index]]=data
    end
    writefile(outFileName,  game:GetService("HttpService"):JSONEncode(dick))
end

function whitelistFTCheck(str)
    type = str:split(".")
    for i, CType in ipairs(whitelistedTypes) do
        if CType == type[#type]:lower() then
            return true
        end
    end
    return false
end

function blacklistedTerms(str)
    for i, CType in ipairs(blacklistedInNames) do
        if string.match(str, CType) then
            return false
        end
    end
    return true
end

function doTheChecks(file)
    if isfolder(file) then 
        table.insert(folders, file)
    else
        if whitelistFTCheck(file) and blacklistedTerms(file) then
            table.insert(files, file)
        end
    end
end

for i,file in pairs(home) do
    doTheChecks(file)
end

while #folders ~= 0 do
    local curfolders = folders
    folders = {}
    for i,folder in pairs(curfolders) do
        local a = listfiles(folder)
        for i,file in pairs(a) do
            doTheChecks(file)
        end
    end
end

createfile(files)
