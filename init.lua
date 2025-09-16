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

-- Crear Frame principal (más ancho para slider)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 520) -- ancho y alto aumentado
frame.Position = UDim2.new(0.5, -200, 0.5, -260) -- centrado
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Función para agregar UICorner
local function createUICorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
end

-- #################### LOGO ####################
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0, 120, 0, 180)
logo.Position = UDim2.new(0.45, -40, 0, 10) -- centrado horizontal
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://72346618462507" -- reemplaza con tu assetId
logo.ScaleType = Enum.ScaleType.Fit -- mantiene proporciones
logo.Parent = frame
createUICorner(logo, 10)

-- Título
-- local title = Instance.new("TextLabel")
-- title.Size = UDim2.new(1, 0, 0, 40)
-- title.Position = UDim2.new(0, 0, 0, 0)
-- title.Text = "D3fc0n Cheat"
-- title.Font = Enum.Font.GothamBold
-- title.TextSize = 20
-- title.TextColor3 = Color3.fromRGB(3, 182, 252)
-- title.BackgroundTransparency = 1
-- title.Parent = frame

-- Función para crear switch estilo bullet
local function createSwitch(yPos, labelText)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0, 25)
    label.Position = UDim2.new(0, 10, 0, yPos)
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.BackgroundTransparency = 1
    label.Parent = frame

    local container = Instance.new("TextButton")
    container.Size = UDim2.new(0, 50, 0, 25)
    container.Position = UDim2.new(0.75, 0, 0, yPos)
    container.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    container.Text = ""
    container.Parent = frame
    createUICorner(container, 12)

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 23, 0, 23)
    circle.Position = UDim2.new(0, 1, 0, 1)
    circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    circle.Parent = container
    createUICorner(circle, 12)

    local isOn = false
    local toggleCallback = nil

    local function toggle(state)
        if state ~= nil then
            isOn = state
        else
            isOn = not isOn
        end

        local goal = {}
        if isOn then
            goal.Position = UDim2.new(0, 26, 0, 1)
            container.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            goal.Position = UDim2.new(0, 1, 0, 1)
            container.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
        TweenService:Create(circle, TweenInfo.new(0.2), goal):Play()

        if toggleCallback then toggleCallback(isOn) end
    end

    container.MouseButton1Click:Connect(function()
        toggle()
    end)

    local switchAPI = {
        Set = function(state)
            if isOn ~= state then toggle(state) end
        end,
        Get = function() return isOn end,
        ToggleCallback = function(callback) toggleCallback = callback end
    }

    return switchAPI
end

-- ====== Toggles ======
-- Aimbot encabezado
local aimbotLabel = Instance.new("TextLabel")
aimbotLabel.Size = UDim2.new(1, 0, 0, 25)
aimbotLabel.Position = UDim2.new(0, 0, 0, 110)
aimbotLabel.Text = "Aimbot Pro"
aimbotLabel.Font = Enum.Font.GothamBold
aimbotLabel.TextSize = 16
aimbotLabel.TextColor3 = Color3.fromRGB(3, 182, 252)
aimbotLabel.BackgroundTransparency = 1
aimbotLabel.Parent = frame

-- Head/Body switches mutuamente excluyentes
local headSwitch = createSwitch(140, "Head")
local bodySwitch = createSwitch(180, "Body")

headSwitch.ToggleCallback(function(state)
    if state then bodySwitch:Set(false) end
end)
bodySwitch.ToggleCallback(function(state)
    if state then headSwitch:Set(false) end
end)

-- Otros toggles
local espSwitch = createSwitch(220, "ESP")
local skelSwitch = createSwitch(260, "SKEL")
local noclipSwitch = createSwitch(300, "Noclip")
local minimapSwitch = createSwitch(340, "Minimap")
local teleportSwitch = createSwitch(380, "Teleport")
local flySwitch = createSwitch(420, "Volar")

-- Slider Velocidad
local velocidadLabel = Instance.new("TextLabel")
velocidadLabel.Size = UDim2.new(0.6, 0, 0, 25)
velocidadLabel.Position = UDim2.new(0, 10, 0, 460)
velocidadLabel.Text = "Velocidad: 50"
velocidadLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
velocidadLabel.Font = Enum.Font.Gotham
velocidadLabel.TextSize = 14
velocidadLabel.BackgroundTransparency = 1
velocidadLabel.Parent = frame

local velocidadSlider = Instance.new("Frame")
velocidadSlider.Size = UDim2.new(0, 250, 0, 10) -- ancho mayor para caber en frame
velocidadSlider.Position = UDim2.new(0.7, 0, 0, 465)
velocidadSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
velocidadSlider.Parent = frame
createUICorner(velocidadSlider, 5)

local velocidadFill = Instance.new("Frame")
velocidadFill.Size = UDim2.new(0.5, 0, 1, 0)
velocidadFill.Position = UDim2.new(0, 0, 0, 0)
velocidadFill.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
velocidadFill.Parent = velocidadSlider
createUICorner(velocidadFill, 5)

local velocidadValue = 50
local dragging = false
velocidadSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = UserInputService:GetMouseLocation().X
        local relativeX = math.clamp(mouseX - velocidadSlider.AbsolutePosition.X, 0, velocidadSlider.AbsoluteSize.X)
        velocidadValue = math.floor(relativeX / velocidadSlider.AbsoluteSize.X * 100)
        velocidadFill.Size = UDim2.new(relativeX / velocidadSlider.AbsoluteSize.X, 0, 1, 0)
        velocidadLabel.Text = "Velocidad: " .. velocidadValue
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Botón activar/desactivar velocidad
local velocidadBtn = Instance.new("TextButton")
velocidadBtn.Size = UDim2.new(0, 70, 0, 25)
velocidadBtn.Position = UDim2.new(0.7, 0, 0, 485)
velocidadBtn.Text = "Activar"
velocidadBtn.Font = Enum.Font.GothamBold
velocidadBtn.TextSize = 14
velocidadBtn.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
velocidadBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
velocidadBtn.Parent = frame
createUICorner(velocidadBtn, 8)

local velocidadActive = false
velocidadBtn.MouseButton1Click:Connect(function()
    velocidadActive = not velocidadActive
    velocidadBtn.Text = velocidadActive and "Desactivar" or "Activar"
    velocidadBtn.BackgroundColor3 = velocidadActive and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(3, 182, 252)
end)

-- Botón cerrar X
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Parent = frame
createUICorner(closeBtn, 6)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Tecla H para ocultar/mostrar menú
local menuVisible = true
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.H then
        menuVisible = not menuVisible
        frame.Visible = menuVisible
    end
end)
