local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Szivárvány szín generátor
local function rainbowColor(speed, offset)
    local hue = (tick() * speed + offset) % 1
    return Color3.fromHSV(hue, 1, 1)
end

-- SpectraMenu létrehozása (KÜLÖN UI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpectraMenu"
ScreenGui.Parent = game.CoreGui

local Window = Instance.new("Frame")
Window.Size = UDim2.new(0, 400, 0, 300)
Window.Position = UDim2.new(0.5, -200, 0.5, -150)
Window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Window.BorderSizePixel = 0
Window.Active = true
Window.Draggable = true
Window.Parent = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 10)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BorderSizePixel = 0
Header.Parent = Window
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 10)

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -40, 1, 0)
HeaderText.Position = UDim2.new(0, 10, 0, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "Spectra Menu"
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextScaled = true
HeaderText.TextColor3 = Color3.fromRGB(255, 255, 255)
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 1, 0)
CloseButton.Position = UDim2.new(1, -35, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Parent = Header
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Oldalsáv
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 120, 1, -35)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Window
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

local Buttons = {}
local function createMenuButton(text, yPos)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, -20, 0, 36)
    Btn.Position = UDim2.new(0, 10, 0, yPos)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 18
    Btn.Font = Enum.Font.GothamBold
    Btn.Text = text
    Btn.Parent = Sidebar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    table.insert(Buttons, Btn)
    return Btn
end

-- Fő tartalom (Page-ek)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -140, 1, -45)
MainFrame.Position = UDim2.new(0, 130, 0, 40)
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = Window

local Pages = {}
local function createPage(name)
    local Page = Instance.new("Frame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.Visible = false
    Page.Parent = MainFrame
    Pages[name] = Page
    return Page
end

local function showPage(name)
    for k, v in pairs(Pages) do
        v.Visible = (k == name)
    end
end

-- Create pages
local HomePage = createPage("Home")
local CheatsPage = createPage("Cheats")
local ESPPage = createPage("ESP")

-- Home label
local HomeLabel = Instance.new("TextLabel")
HomeLabel.Text = "Welcome to Spectra Menu!\nChoose a category."
HomeLabel.Size = UDim2.new(1, 0, 0, 80)
HomeLabel.Position = UDim2.new(0, 0, 0, 0)
HomeLabel.BackgroundTransparency = 1
HomeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeLabel.Font = Enum.Font.GothamBold
HomeLabel.TextScaled = true
HomeLabel.TextWrapped = true
HomeLabel.Parent = HomePage

-- CheatsPage UI Elements --

local speedEnabled = false
local jumpEnabled = false
local aimbotEnabled = false

local speedValue = 100
local jumpPowerValue = 100

-- Speedhack toggle
local speedToggle = Instance.new("TextButton")
speedToggle.Size = UDim2.new(0.7, 0, 0, 40)
speedToggle.Position = UDim2.new(0.15, 0, 0.1, 0)
speedToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
speedToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
speedToggle.Font = Enum.Font.GothamBold
speedToggle.TextScaled = true
speedToggle.Text = "Speedhack: OFF"
speedToggle.Parent = CheatsPage
Instance.new("UICorner", speedToggle).CornerRadius = UDim.new(0, 6)

speedToggle.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedToggle.Text = "Speedhack: " .. (speedEnabled and "ON" or "OFF")
end)

-- Jumphack toggle
local jumpToggle = Instance.new("TextButton")
jumpToggle.Size = UDim2.new(0.7, 0, 0, 40)
jumpToggle.Position = UDim2.new(0.15, 0, 0.3, 0)
jumpToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
jumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpToggle.Font = Enum.Font.GothamBold
jumpToggle.TextScaled = true
jumpToggle.Text = "Jumphack: OFF"
jumpToggle.Parent = CheatsPage
Instance.new("UICorner", jumpToggle).CornerRadius = UDim.new(0, 6)

jumpToggle.MouseButton1Click:Connect(function()
    jumpEnabled = not jumpEnabled
    jumpToggle.Text = "Jumphack: " .. (jumpEnabled and "ON" or "OFF")
end)

-- Aimbot toggle
local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(0.7, 0, 0, 40)
aimbotToggle.Position = UDim2.new(0.15, 0, 0.5, 0)
aimbotToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
aimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotToggle.Font = Enum.Font.GothamBold
aimbotToggle.TextScaled = true
aimbotToggle.Text = "Aimbot: OFF"
aimbotToggle.Parent = CheatsPage
Instance.new("UICorner", aimbotToggle).CornerRadius = UDim.new(0, 6)

aimbotToggle.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotToggle.Text = "Aimbot: " .. (aimbotEnabled and "ON" or "OFF")
end)

-- ESP toggle
local espEnabled = false

local espToggle = Instance.new("TextButton")
espToggle.Size = UDim2.new(0.7, 0, 0, 40)
espToggle.Position = UDim2.new(0.15, 0, 0.1, 0)
espToggle.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
espToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
espToggle.Font = Enum.Font.GothamBold
espToggle.TextScaled = true
espToggle.Text = "ESP: OFF"
espToggle.Parent = ESPPage
Instance.new("UICorner", espToggle).CornerRadius = UDim.new(0, 6)

espToggle.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espToggle.Text = "ESP: " .. (espEnabled and "ON" or "OFF")
end)

-- Pages buttons
local btnHome = createMenuButton("Home", 60)
btnHome.MouseButton1Click:Connect(function()
    showPage("Home")
end)

local btnCheats = createMenuButton("Cheats", 110)
btnCheats.MouseButton1Click:Connect(function()
    showPage("Cheats")
end)

local btnESP = createMenuButton("ESP", 160)
btnESP.MouseButton1Click:Connect(function()
    showPage("ESP")
end)

showPage("Home")

-- Speedhack implementation
local speedValue = 100
local defaultWalkSpeed = 16

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if speedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = speedValue
        else
            LocalPlayer.Character.Humanoid.WalkSpeed = defaultWalkSpeed
        end
    end
end)


-- Jumphack implementation
UserInputService.JumpRequest:Connect(function()
    if jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 100
        LocalPlayer.Character.Humanoid.Jump = true
    end
end)

-- Reset jump power when disabled
RunService.RenderStepped:Connect(function()
    if not jumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 50 -- default
    end
end)

-- Simple aimbot implementation

local function getClosestTarget()
    local closestPlayer = nil
    local shortestDistance = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local screenPos, onScreen = Camera:WorldToViewportPoint(player.Character.Head.Position)
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                if dist < shortestDistance and dist < 100 then -- max distance 100 px
                    closestPlayer = player
                    shortestDistance = dist
                end
            end
        end
    end
    return closestPlayer
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local target = getClosestTarget()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            local headPos = target.Character.Head.Position
            local cameraPos = Camera.CFrame.Position
            local direction = (headPos - cameraPos).Unit
            local targetCFrame = CFrame.new(cameraPos, cameraPos + direction)
            
            -- Lerpezés a célponthoz (0.2 az érzékenység, állítható)
            Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, 0.1)
        end
    end
end)

-- ESP implementation

local espBoxes = {}

local function createEspBox(player)
    local box = Drawing.new("Square")
    box.Visible = false
    box.Color = Color3.fromRGB(0, 255, 0)
    box.Thickness = 2
    box.Filled = false
    return box
end

local function updateEsp()
    if not espEnabled then
        for _, box in pairs(espBoxes) do
            box.Visible = false
        end
        return
    end

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local rootPart = player.Character.HumanoidRootPart
            local pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
            local box = espBoxes[player]

            if not box then
                box = createEspBox(player)
                espBoxes[player] = box
            end

            if onScreen then
                box.Visible = true
                local size = 50
                box.Position = Vector2.new(pos.X - size/2, pos.Y - size/2)
                box.Size = Vector2.new(size, size)
            else
                box.Visible = false
            end
        else
            if espBoxes[player] then
                espBoxes[player].Visible = false
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    updateEsp()
end)

-- Szivárvány effekt a header-re és sidebar gombokra
RunService.RenderStepped:Connect(function()
    local col = rainbowColor(0.15, 0)
    Header.BackgroundColor3 = col
    for _, btn in ipairs(Buttons) do
        btn.TextColor3 = col
    end
end)
