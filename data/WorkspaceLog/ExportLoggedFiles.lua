local logFileName = "out.txt"
local outFolder = "export"

--------------------------------------

-- make output folder if not there
if not isfolder(outFolder) then makefolder(outFolder) end

local fileData = readfile(logFileName)
local jsonData = game:GetService("HttpService"):JSONDecode(fileData)
for name, data in pairs(jsonData) do
    local splitName = name:split("\\")
    if #splitName > 1 then
        folderPath = outFolder.."/"
        for i = 1, #splitName - 1 do
            folderPath = folderPath .. splitName[i].."/"
            if not isfolder(splitName[i]) then
                makefolder(folderPath)
            end
        end
    end
    writefile(outFolder.."/"..name,data)
end
