--[[
    Code taken from narwhalhacks.xyz its just to prevent it from being lost tbh
    OG thread: https://v3rmillion.net/showthread.php?tid=976061&pid=6882206
]]--

function Notify(a, b, c)
    local d = Instance.new("ScreenGui")
    local e = Instance.new("ImageLabel")
    local f = Instance.new("ImageLabel")
    local g = Instance.new("TextLabel")
    local h = Instance.new("TextLabel")
    d.Name = "NotificationUI"
    d.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    e.Name = "MainFrame"
    e.Parent = d
    e.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    e.BackgroundTransparency = 1.000
    e.Position = UDim2.new(2, 0, 0.835243583, 0)
    e.Size = UDim2.new(0.161191657, 0, 0.107163362, 0)
    e.Image = "rbxassetid://3570695787"
    e.ImageColor3 = Color3.fromRGB(63, 63, 63)
    e.ScaleType = Enum.ScaleType.Slice
    e.SliceCenter = Rect.new(100, 100, 100, 100)
    e.SliceScale = 0.120
    f.Name = "TopFrame"
    f.Parent = e
    f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    f.BackgroundTransparency = 1.000
    f.Position = UDim2.new(-6.28033958e-05, 0, -0.00246180478, 0)
    f.Size = UDim2.new(1.00006318, 0, 0.302558541, 0)
    f.Image = "rbxassetid://3570695787"
    f.ImageColor3 = Color3.fromRGB(43, 43, 43)
    f.ScaleType = Enum.ScaleType.Slice
    f.SliceCenter = Rect.new(100, 100, 100, 100)
    f.SliceScale = 0.120
    g.Name = "Title"
    g.Parent = f
    g.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    g.BackgroundTransparency = 1.000
    g.Position = UDim2.new(0, 0, 0.00813662354, 0)
    g.Size = UDim2.new(1, 0, 1, 0)
    g.Font = Enum.Font.SourceSans
    g.Text = a
    g.TextColor3 = Color3.fromRGB(255, 255, 255)
    g.TextScaled = true
    g.TextSize = 14.000
    g.TextWrapped = true
    h.Name = "Text"
    h.Parent = e
    h.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    h.BackgroundTransparency = 1.000
    h.Position = UDim2.new(0.035, 0, 0.303, 0)
    h.Size = UDim2.new(0.929, 0, 0.6, 0)
    h.Font = Enum.Font.SourceSans
    h.Text = b
    h.TextColor3 = Color3.fromRGB(255, 255, 255)
    h.TextScaled = true
    h.TextSize = 14.000
    h.TextWrapped = true
    wait(0.1)
    e:TweenPosition(UDim2.fromScale(0.83816427, 0.835243583))
    wait(c)
    e:TweenPosition(UDim2.fromScale(2, 0.835))
    wait(1)
    d:Destroy()
end
--[[
    loadstring(game:HttpGet("https://github.com/Roblox-Thot/scripts/raw/main/libs/alerts.lua", true))()
    Notify('Title','bottom txt', 5)
]]--