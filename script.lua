 -- Importando a nova biblioteca de UI
 local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/weakhoes/Roblox-UI-Libs/refs/heads/main/Cerberus%20Lib/Cerberus%20Lib%20Source.lua"))()
 
 -- Criando a interface do usuário
 local UI = Library:Create{
     Name = "Funções", -- Nome da aba
     Size = UDim2.new(0, 555, 0, 400) -- Tamanho padrão
 }
 
 -- Criando uma aba para as funcionalidades
 local Main = UI:Tab{
     Name = "Funções"
 }
 
 --- Divisores para organizar a GUI
 local ESPDivider = Main:Divider{
    Name = "ESP e Movimentação"
}

local NoClipDivider = Main:Divider{
    Name = "No Clip"
}

-- Exemplo de toggle para ESP dentro do divisor correspondente
local espToggle = Main:Toggle{
    Name = "Ativar ESP",
    Default = false, -- Estado inicial
    Callback = function(value)
        toggleESP(value) -- Chama a função toggleESP
    end
}

-- Exemplo de slider para velocidade dentro do divisor correspondente
local speedSlider = Main:Slider{
    Name = "Velocidade",
    Min = 16, -- Valor mínimo
    Max = 100, -- Valor máximo
    Default = 50, -- Valor padrão
    Callback = function(value)
        setPlayerSpeed(value) -- Chama a função setPlayerSpeed
    end
}

 -- Função para ativar/desativar ESP
 local function toggleESP(enabled)
    if enabled then
        -- Lógica para ativar ESP
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local highlight = Instance.new("Highlight")
                highlight.Adornee = player.Character or player.CharacterAdded:Wait()
                highlight.FillColor = Color3.new(1, 0, 0) -- Cor do ESP
                highlight.FillTransparency = 0.5 -- Transparência do ESP
                highlight.Parent = player.Character
            end
        end
    else
        -- Lógica para desativar ESP
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
local function setPlayerSpeed(speed)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end

-- Conectando as funções aos callbacks dos toggles e sliders
espToggle.Callback = function(value)
    toggleESP(value) -- Chama a função toggleESP
end

speedSlider.Callback = function(value)
    setPlayerSpeed(value) -- Chama a função setPlayerSpeed
end