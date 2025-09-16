-- init.lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Crear ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "D3fc0n"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Crear Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 450)
frame.Position = UDim2.new(0.5, -125, 0.5, -225)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Función para agregar UICorner
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
end

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "D3fc0n Cheat"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(3, 182, 252)
title.BackgroundTransparency = 1
title.Parent = frame

-- Función para crear un toggle tipo switch/bullet
local function createSwitch(yPos, labelText, mutuallyExclusiveWith)
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 25)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.BackgroundTransparency = 1
    label.Parent = frame

    -- Contenedor switch
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(0, 50, 0, 25)
    container.Position = UDim2.new(0.7, 0, 0, yPos)
    container.BackgroundColor3 = Color3.fromRGB(100,100,100)
    container.Text = ""
    container.Parent = frame
    createUICorner(container, 12)

    -- Bolita
    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 23, 0, 23)
    circle.Position = UDim2.new(0, 1, 0, 1)
    circle.BackgroundColor3 = Color3.fromRGB(255,255,255)
    circle.Parent = container
    createUICorner(circle, 12)

    local isOn = false
    local function toggle()
        isOn = not isOn
        if mutuallyExclusiveWith and isOn then
            mutuallyExclusiveWith:Set(false)
        end
        local goal = {}
        if isOn then
            goal.Position = UDim2.new(0, 26, 0, 1)
            container.BackgroundColor3 = Color3.fromRGB(0,255,0)
        else
            goal.Position = UDim2.new(0, 1, 0, 1)
            container.BackgroundColor3 = Color3.fromRGB(100,100,100)
        end
        TweenService:Create(circle, TweenInfo.new(0.2), goal):Play()
    end

    container.MouseButton1Click:Connect(toggle)

    local switchAPI = {}
    function switchAPI:Set(state)
        if isOn ~= state then
            toggle()
        end
    end
    return switchAPI
end

-- ====== Toggles ======
-- Aimbot encabezado (no interactivo)
local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Size = UDim2.new(1, 0, 0, 25)
aimbotLabel.Position = UDim2.new(0, 0, 0, 50)
aimbotLabel.Text = "Aimbot Pro"
aimbotLabel.Font = Enum.Font.GothamBold
aimbotLabel.TextSize = 16
aimbotLabel.TextColor3 = Color3.fromRGB(3,182,252)
aimbotLabel.BackgroundTransparency = 1
aimbotLabel.Parent = frame

-- Head/Body toggles mutuamente excluyentes
local bodySwitch
local headSwitch = createSwitch(80, "Head", function() bodySwitch:Set(false) end)
bodySwitch = createSwitch(120, "Body", function() headSwitch:Set(false) end)

-- Otros toggles
local espSwitch = createSwitch(160, "ESP")
local skelSwitch = createSwitch(200, "SKEL")
local noclipSwitch = createSwitch(240, "Noclip")
local minimapSwitch = createSwitch(320, "Minimap")
local teleportSwitch = createSwitch(360, "Teleport")
local flySwitch = createSwitch(400, "Volar")

-- Slider Velocidad
local velocidadLabel = Instance.new("TextLabel")
velocidadLabel.Size = UDim2.new(0.6, 0, 0, 25)
velocidadLabel.Position = UDim2.new(0,10,0,280)
velocidadLabel.Text = "Velocidad: 50"
velocidadLabel.TextColor3 = Color3.fromRGB(255,255,255)
velocidadLabel.Font = Enum.Font.Gotham
velocidadLabel.TextSize = 14
velocidadLabel.BackgroundTransparency = 1
velocidadLabel.Parent = frame

local velocidadSlider = Instance.new("Frame")
velocidadSlider.Size = UDim2.new(0, 100, 0, 10)
velocidadSlider.Position = UDim2.new(0.7, 0, 0, 285)
velocidadSlider.BackgroundColor3 = Color3.fromRGB(60,60,60)
velocidadSlider.Parent = frame
createUICorner(velocidadSlider, 5)

local velocidadFill = Instance.new("Frame")
velocidadFill.Size = UDim2.new(0.5,0,1,0)
velocidadFill.Position = UDim2.new(0,0,0,0)
velocidadFill.BackgroundColor3 = Color3.fromRGB(3,182,252)
velocidadFill.Parent = velocidadSlider
createUICorner(velocidadFill,5)

local velocidadValue = 50
velocidadSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = input.Changed:Connect(function()
            local mouseX = UserInputService:GetMouseLocation().X
            local relativeX = math.clamp(mouseX - velocidadSlider.AbsolutePosition.X, 0, velocidadSlider.AbsoluteSize.X)
            velocidadValue = math.floor(relativeX / velocidadSlider.AbsoluteSize.X * 100)
            velocidadFill.Size = UDim2.new(relativeX/velocidadSlider.AbsoluteSize.X,0,1,0)
            velocidadLabel.Text = "Velocidad: "..velocidadValue
            if input.UserInputState == Enum.UserInputState.End then
                connection:Disconnect()
            end
        end)
    end
end)

local velocidadBtn = Instance.new("TextButton")
velocidadBtn.Size = UDim2.new(0,50,0,25)
velocidadBtn.Position = UDim2.new(0.7,0,0,310)
velocidadBtn.Text = "Activar"
velocidadBtn.Font = Enum.Font.GothamBold
velocidadBtn.TextSize = 14
velocidadBtn.BackgroundColor3 = Color3.fromRGB(3,182,252)
velocidadBtn.TextColor3 = Color3.fromRGB(0,0,0)
velocidadBtn.Parent = frame
createUICorner(velocidadBtn,8)

local velocidadActive = false
velocidadBtn.MouseButton1Click:Connect(function()
    velocidadActive = not velocidadActive
    velocidadBtn.Text = velocidadActive and "Desactivar" or "Activar"
    velocidadBtn.BackgroundColor3 = velocidadActive and Color3.fromRGB(0,255,0) or Color3.fromRGB(3,182,252)
end)

-- Botón cerrar X
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,30,0,30)
closeBtn.Position = UDim2.new(1,-35,0,5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200,0,0)
closeBtn.Parent = frame
createUICorner(closeBtn,6)

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Ocultar/mostrar menú con tecla H
local menuVisible
