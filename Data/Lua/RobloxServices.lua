--[[
	#Lazy
]]--

getgenv().Services = setmetatable({},{
	__index = function(self, ServiceName)
		suc, serivce = pcall(function() return game:GetService(ServiceName)end)
		if suc then
			return serivce
		else
			return nil
		end
	end
})
