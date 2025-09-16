-- init.lua
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "D3fc0n"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Crear Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 400)
frame.Position = UDim2.new(0.5, -125, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Función para crear botones
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 220, 0, 30)
    btn.Position = UDim2.new(0, 15, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
end

-- Función para crear toggle On/Off
local function createToggle(labelText, yPos)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 120, 0, 30)
    label.Position = UDim2.new(0, 15, 0, yPos)
    label.Text = labelText
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 30)
    toggle.Position = UDim2.new(0, 150, 0, yPos)
    toggle.Text = "OFF"
    toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    toggle.Parent = frame

    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggle.Text = "ON"
            toggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            toggle.Text = "OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
        end
    end)

    return toggle
end

-- Función para crear slider
local function createSlider(labelText, yPos, minVal, maxVal)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 220, 0, 20)
    label.Position = UDim2.new(0, 15, 0, yPos)
    label.Text = labelText .. ": " .. minVal
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.BackgroundTransparency = 1
    label.Parent = frame

    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0, 220, 0, 10)
    sliderFrame.Position = UDim2.new(0, 15, 0, yPos + 25)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderFrame.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0.5, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
    fill.Parent = sliderFrame

    local value = minVal

    local function updateSlider(input)
        local x = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(x, 0, 1, 0)
        value = math.floor(minVal + x * (maxVal - minVal))
        label.Text = labelText .. ": " .. value
    end

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            updateSlider(input)
            local conn
            conn = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    conn:Disconnect()
                else
                    updateSlider(input)
                end
            end)
        end
    end)
    sliderFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    return function() return value end
end

-- Botón cerrar (X)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Ocultar/mostrar menú con tecla H
local menuVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.H then
        menuVisible = not menuVisible
        frame.Visible = menuVisible
    end
end)

-- Cargar módulos de botones desde GitHub
local function importModule(url)
    local ok, mod = pcall(function() return loadstring(game:HttpGet(url))() end)
    if ok then return mod else warn("Error cargando:", url, mod) return nil end
end

local modules = {
    Aimbot = importModule("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Aimbot.lua"),
    ESP = importModule("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton2.lua"),
    SKEL = importModule("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton3.lua"),
    Noclip = importModule("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Noclip.lua"),
    Velocidad = importModule("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Velocidad.lua")
}

-- Crear botones y toggles
createButton("Aimbot Pro", 40, function() if modules.Aimbot then modules.Aimbot:Run() end end)
local headToggle = createToggle("Head", 80)
local bodyToggle = createToggle("Body", 120)

local espToggle = createToggle("ESP", 160)
local skelToggle = createToggle("SKEL", 200)
local noclipToggle = createToggle("Noclip", 240)

local velocidadSliderGetter = createSlider("Velocidad", 280, 0, 100)
createButton("Activar Velocidad", 320, function()
    local val = velocidadSliderGetter()
    print("Velocidad activada en:", val)
    if modules.Velocidad then modules.Velocidad:Run(val) end
end)

local minimapToggle = createToggle("Minimap", 360)
local teleportToggle = createToggle("Teleport", 400)
local flyToggle = createToggle("Volar", 440)
