-- Biblioteca de GUI baseada na Cerberus
local GUI = {}

-- Função para criar a interface do usuário
function GUI:CreateUI()
    self.UI = Library:Create{
        Name = "Funções",
        Size = UDim2.new(0, 555, 0, 400)
    }

    self.MainTab = self.UI:Tab{
        Name = "Funções"
    }

    self.ESPDivider = self.MainTab:Divider{
        Name = "ESP e Movimentação"
    }

    self.NoClipDivider = self.MainTab:Divider{
        Name = "No Clip"
    }
end

-- Função para adicionar um toggle
function GUI:AddToggle(name, default, callback)
    return self.MainTab:Toggle{
        Name = name,
        Default = default,
        Callback = callback
    }
end

-- Função para adicionar um slider
function GUI:AddSlider(name, min, max, default, callback)
    return self.MainTab:Slider{
        Name = name,
        Min = min,
        Max = max,
        Default = default,
        Callback = callback
    }
end

-- Função para ativar/desativar ESP
function GUI:ToggleESP(enabled)
    if enabled then
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character or player.CharacterAdded:Wait()
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.FillTransparency = 0.5
                highlight.Parent = player.Character
            end
        end
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character then
                for _, highlight in pairs(player.Character:GetChildren()) do
                    if highlight:IsA("Highlight") then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
end

-- Função para ajustar a velocidade do jogador
function GUI:SetPlayerSpeed(speed)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

-- Inicializando a GUI
GUI:CreateUI()

-- Adicionando toggles e sliders
local espToggle = GUI:AddToggle("Ativar ESP", false, function(value)
    GUI:ToggleESP(value)
end)

local speedSlider = GUI:AddSlider("Velocidade", 16, 100, 50, function(value)
    GUI:SetPlayerSpeed(value)
end)