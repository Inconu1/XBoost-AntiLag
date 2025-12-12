-- Ultra Boost Anti-Lag GUI with Player Name Display
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XBoostGUI"
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.05, 0, 0.05, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, -20, 0, 40)
PlayerNameLabel.Position = UDim2.new(0, 10, 0, 10)
PlayerNameLabel.BackgroundTransparency = 1
PlayerNameLabel.Text = "Player: abdossk1y"
PlayerNameLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
PlayerNameLabel.Font = Enum.Font.GothamBold
PlayerNameLabel.TextScaled = true
PlayerNameLabel.Parent = Frame

local function createButton(text, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextScaled = true
    btn.Parent = Frame
    return btn
end

local ButtonBoost = createButton("تشغيل إزالة اللاغ", 60)
local ButtonHide = createButton("إخفاء الواجهة", 110)

local function cleanObject(obj)
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") then
        obj.Enabled = false
    end
    if obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
        obj.Enabled = false
    end
    if obj:IsA("MeshPart") then
        obj.RenderFidelity = Enum.RenderFidelity.Performance
    end
    if obj:IsA("BasePart") then
        obj.CastShadow = false
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
    end
    if obj:IsA("Texture") or obj:IsA("Decal") then
        obj.Transparency = 1
    end
end

local function antiLag()
    for _, obj in pairs(workspace:GetDescendants()) do
        cleanObject(obj)
    end
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end

antiLag()
workspace.DescendantAdded:Connect(cleanObject)

ButtonBoost.MouseButton1Click:Connect(antiLag)
ButtonHide.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)
