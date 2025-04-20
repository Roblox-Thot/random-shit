local zip = loadstring(game:HttpGet("https://raw.githubusercontent.com/RobloxThot/luau-unzip/main/lib/init.luau", true))()

-- Read the ZIP file
local file = game:HttpGet('https://github.com/Roblox-Thot/random-shit/archive/refs/heads/main.zip')

-- Load the ZIP archive
local reader = zip.load(buffer.fromstring(file))

function writetofile(filepath, data)
    local splitName = filepath:split("\\")
    if #splitName > 1 then
        folderPath = ''
        for i = 1, #splitName - 1 do
            folderPath = folderPath .. splitName[i].."/"
            if not isfolder(splitName[i]) then
                makefolder(folderPath)
            end
        end
    end
    writefile(filepath,data)
    print("Wrote "..filepath)
end

-- Print directory structure
reader:walk(function(entry, depth)
    if not entry.isDirectory then
        data = reader:extract(entry, { type = "text" }) :: string
        writetofile(entry.name , data)
    end
    task.wait()
end)