-- init.lua
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DefconMenu"
screenGui.Parent = playerGui

-- Crear Frame (ventana principal)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = screenGui

-- Crear función auxiliar para botones
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
    btn.Parent = frame

    btn.MouseButton1Click:Connect(callback)
end

-- Cargar módulos
local Button1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton1.lua"))()
local Button2 = loadstring(game:HttpGet("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton2.lua"))()
local Button3 = loadstring(game:HttpGet("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton3.lua"))()

-- Crear botones
createButton("Botón 1", 10, function() Button1:Run() end)
createButton("Botón 2", 50, function() Button2:Run() end)
createButton("Botón 3", 90, function() Button3:Run() end)
