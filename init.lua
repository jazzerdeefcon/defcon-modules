-- init.lua
-- Ventana con 3 botones que llaman módulos separados

local Button1 = require(script.Button1)
local Button2 = require(script.Button2)
local Button3 = require(script.Button3)

-- Creamos ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Parent = ScreenGui

-- Función para crear botones
local function createButton(text, posY, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
    btn.Parent = MainFrame

    btn.MouseButton1Click:Connect(callback)
end

-- Botón 1
createButton("Botón 1", 10, function()
    Button1:Run()
end)

-- Botón 2
createButton("Botón 2", 50, function()
    Button2:Run()
end)

-- Botón 3
createButton("Botón 3", 90, function()
    Button3:Run()
end)
