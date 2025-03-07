-- Referências das bibliotecas
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Camera = game.Workspace.CurrentCamera
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Mouse = Player:GetMouse()

-- Criando a interface com Orion
local Window = OrionLib:MakeWindow({
    Name = "BrasilHub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "BrasilHub"
})

-- Aba principal
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://6031068431",
    PremiumOnly = false
})

-- Função Auto Farm
local AutoFarmEnabled = false
MainTab:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(value)
        AutoFarmEnabled = value
        while AutoFarmEnabled do
            wait(1)
            local closestEnemy = nil
            local shortestDistance = math.huge

            -- Encontrar o inimigo mais próximo
            for _, mob in pairs(Workspace:GetChildren()) do
                if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local dist = (Player.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDistance then
                        closestEnemy = mob
                        shortestDistance = dist
                    end
                end
            end

            -- Atacar o inimigo mais próximo
            if closestEnemy then
                -- Simula o ataque ao inimigo
                local attack = Player.Character:FindFirstChildOfClass("Tool")
                if attack then
                    -- Se houver uma ferramenta equipada, usa ela
                    attack:Activate()
                end
            end
        end
    end
})

-- Função ESP
local ESPEnabled = false
local ESPObjects = {}
MainTab:AddToggle({
    Name = "ESP",
    Default = false,
    Callback = function(value)
        ESPEnabled = value
        if ESPEnabled then
            -- Ativar ESP
            for _, object in pairs(Workspace:GetChildren()) do
                if object:IsA("Model") and object:FindFirstChild("HumanoidRootPart") then
                    local espBox = Instance.new("BoxHandleAdornment")
                    espBox.Adornee = object
                    espBox.Size = object:GetModelSize()
                    espBox.Color3 = Color3.fromRGB(255, 0, 0)  -- Cor para ESP
                    espBox.AlwaysOnTop = true
                    espBox.ZIndex = 10
                    espBox.Parent = Player.Character
                    table.insert(ESPObjects, espBox)
                end
            end
        else
            -- Desativar ESP
            for _, espBox in pairs(ESPObjects) do
                espBox:Destroy()
            end
            ESPObjects = {}
        end
    end
})

-- Função Teleport para Ilhas
local TeleportLocations = {
    {name = "Island 1", position = Vector3.new(100, 10, 200)},
    {name = "Island 2", position = Vector3.new(500, 10, 800)},
    -- Adicionar mais ilhas conforme necessário
}

MainTab:AddDropdown({
    Name = "Teleport para Ilha",
    Options = {"Island 1", "Island 2"},
    Callback = function(selected)
        for _, location in pairs(TeleportLocations) do
            if location.name == selected then
                -- Teleportando para a ilha selecionada
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(location.position)
                break
            end
        end
    end
})

-- Função Ultra Fast Attack
local UltraFastAttackEnabled = false
MainTab:AddToggle({
    Name = "Ultra Fast Attack",
    Default = false,
    Callback = function(value)
        UltraFastAttackEnabled = value
        while UltraFastAttackEnabled do
            wait(0.1)  -- Ajuste o intervalo para mais velocidade
            local attack = Player.Character:FindFirstChildOfClass("Tool")
            if attack then
                -- Ativar o ataque ultra rápido
                attack:Activate()
            end
        end
    end
})

-- Inicia o Orion
OrionLib:Init()
