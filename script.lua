-- Importando a biblioteca de UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()

-- Criando a interface do usuário
local UI = Library:Create{
    Theme = "Dark", -- ou qualquer outro tema
    Size = UDim2.new(0, 555, 0, 400) -- tamanho padrão
}

-- Criando uma aba para as funcionalidades
local Main = UI:Tab{
    Name = "Funções"
}

-- Divisores para organizar a GUI
local ESPDivider = Main:Divider{
    Name = "ESP e Movimentação"
}

local NoClipDivider = Main:Divider{
    Name = "No Clip"
}

-- Função para ativar/desativar ESP
ESPDivider:Toggle{
    Name = "Ativar ESP",
    Description = "Ativa ou desativa o ESP.",
    Callback = function(state)
        if state then
            createESP() -- Chame a função de criação de ESP aqui
        else
            removeESP() -- Função para remover ESP, se necessário
        end
    end
}

-- Controle de velocidade
ESPDivider:Slider{
    Name = "Multiplicador de Velocidade",
    Min = 1,
    Max = 10,
    Default = 2,
    Callback = function(value)
        speedMultiplier = value
        setSpeed() -- Chame a função de configuração de velocidade aqui
    end
}

-- Controle de Super Jump
ESPDivider:Slider{
    Name = "Poder de Super Jump",
    Min = 50,
    Max = 200,
    Default = 100,
    Callback = function(value)
        superJumpPower = value
        superJump() -- Chame a função de super jump aqui
    end
}

-- Atalhos para ativar/desativar No Clip
NoClipDivider:Toggle{
    Name = "Ativar No Clip",
    Description = "Ativa ou desativa o No Clip.",
    Callback = function(state)
        noClipEnabled = state
        toggleNoClip() -- Chame a função de toggle de No Clip aqui
    end
}

-- Funções de funcionalidade
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local function createESP()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= player.Name then
            local highlight = Instance.new("Highlight", v)
            highlight.FillColor = Color3.new(1, 0, 0) -- Cor do ESP
            highlight.OutlineColor = Color3.new(0, 0, 0) -- Cor da borda
        end
    end
end

local function removeESP()
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Highlight") then
            v.Highlight:Destroy() -- Remove o ESP
        end
    end
end

local function setSpeed()
    humanoid.WalkSpeed = 16 * speedMultiplier
end

local function superJump()
    humanoid.JumpPower = superJumpPower
end

local function toggleNoClip()
    noClipEnabled = not noClipEnabled
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noClipEnabled
        end
    end
end

-- Inicializando a GUI
UI:Show()