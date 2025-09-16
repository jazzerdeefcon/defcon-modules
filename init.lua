local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "D3fc0n"
gui.ResetOnSpawn = false

-- Crear Frame principal
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 150)
frame.Position = UDim2.new(0.5, -100, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Parent = gui

-- Función para crear botones
local function createButton(text, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(3, 182, 252)
    btn.Parent = frame
    btn.MouseButton1Click:Connect(callback)
end

-- Función para cargar módulos desde GitHub
local function import(url)
    local ok, res = pcall(function()
        return loadstring(game:HttpGet(url))()
    end)
    if ok then return res else print("Error cargando:", url, res) end
end

-- Cargar módulos
local Button1 = import("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton1.lua")
local Button2 = import("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton2.lua")
local Button3 = import("https://raw.githubusercontent.com/jazzerdeefcon/defcon-modules/main/Boton3.lua")

-- Crear botones
createButton("Botón 1", 10, function() Button1:Run() end)
createButton("Botón 2", 50, function() Button2:Run() end)
createButton("Botón 3", 90, function() Button3:Run() end)
