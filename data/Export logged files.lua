local logFileName = "out.txt"

--------------------------------------

local fileData = readfile(logFileName)
local jsonData = Game:GetService("HttpService"):JSONDecode(fileData)
for name, data in pairs(jsonData) do
    local splitName = name:split("\\")
    if #splitName > 1 then
        folderPath = ""
        for i = 1, #splitName - 1 do
            folderPath = folderPath .. splitName[i].."/"
            if not isfolder(splitName[i]) then
                makefolder(folderPath)
            end
        end
    end
    writefile(name,data)
end
