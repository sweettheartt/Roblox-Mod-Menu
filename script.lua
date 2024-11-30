-- Importando a biblioteca de UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7yhx/kwargs_Ui_Library/main/source.lua"))()

-- Criando a janela principal
local Window = Library:CreateWindow("Roblox Mod Menu")

-- Criando uma aba para as funcionalidades
local Tab = Window:CreateTab("Funções")

-- Variáveis de configuração
local ESPEnabled = false
local speedMultiplier = 2
local superJumpPower = 100
local noClipEnabled = false

-- Função para ativar/desativar ESP
Tab:CreateToggle("Ativar ESP", function(state)
    ESPEnabled = state
    if ESPEnabled then
        createESP() -- Chame a função de criação de ESP aqui
    end
end)

-- Controle de velocidade
Tab:CreateSlider("Multiplicador de Velocidade", 1, 10, function(value)
    speedMultiplier = value
    setSpeed() -- Chame a função de configuração de velocidade aqui
end)

-- Controle de Super Jump
Tab:CreateSlider("Poder de Super Jump", 50, 200, function(value)
    superJumpPower = value
    superJump() -- Chame a função de super jump aqui
end)

-- Atalhos para ativar/desativar No Clip
Tab:CreateToggle("Ativar No Clip", function(state)
    noClipEnabled = state
    toggleNoClip() -- Chame a função de toggle de No Clip aqui
end)

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
Window:Show()