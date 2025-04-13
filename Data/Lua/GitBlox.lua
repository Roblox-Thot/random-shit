--[[
    Studio script to clone a git repo
]]--

setToParent = game.Lighting
githubUser = "Roblox-Thot"
githubRepo = "random-shit"
auth = ''

local HttpService=game:GetService('HttpService')
local toJson=function(str)return HttpService:JSONDecode(str) end
local request=function(dict) dict['Headers'] ={Authorization='Bearer '..auth} return HttpService:RequestAsync(dict)end

local function createFolderHierarchy(path)
	local folders = path:split("/")
	local currentParent = setToParent

	-- Skip the last item
	local endIndex = #folders - 1

	for i = 1, endIndex do
		local folderName = folders[i]
		local folder = currentParent:FindFirstChild(folderName)
		if not folder then
			folder = Instance.new("Folder")
			folder.Name = folderName
			folder.Parent = currentParent
		end
		currentParent = folder
	end
	return currentParent, folders[#folders]
end

function from_base64(data)
	local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
	data = string.gsub(data, '[^'..b..'=]', '')
	return (data:gsub('.', function(x)
		if (x == '=') then return '' end
		local r,f='',(b:find(x)-1)
		for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
		return r;
	end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
		if (#x ~= 8) then return '' end
		local c=0
		for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
		return string.char(c)
	end))
end

data = toJson(request({Url="https://api.github.com/repos/"..githubUser.."/"..githubRepo.."/git/trees/main?recursive=1",Method="GET"}).Body)

for _,v in data.tree do
	if v.type == "blob" then
		folder, name = createFolderHierarchy(v.path)
		--print(v.path,v.url,a)
		print(folder, name)
		newScript = Instance.new("Script",folder)
		newScript.Name = name
		sourceData = toJson(request({Method="GET",Url=v.url}).Body)
		newScript.Source = from_base64(sourceData.content)
	end
end
