-- Biblioteca de GUI personalizada
local GUI = {}

-- Função para criar a interface do usuário
function GUI:CreateUI()
    -- Criando a tela principal
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "FunçõesGUI"
    self.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Criando um quadro para a GUI
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Size = UDim2.new(0, 555, 0, 400)
    self.MainFrame.Position = UDim2.new(0.5, -277.5, 0.5, -200)
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    self.MainFrame.Parent = self.ScreenGui

    -- Criando um título
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 50)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.Text = "Funções"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Parent = self.MainFrame

    -- Criando uma aba para ESP e Movimentação
    self.ESPFrame = Instance.new("Frame")
    self.ESPFrame.Size = UDim2.new(1, 0, 0, 350)
    self.ESPFrame.Position = UDim2.new(0, 0, 0, 50)
    self.ESPFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    self.ESPFrame.Parent = self.MainFrame

    -- Criando um divisor para ESP e Movimentação
    local espLabel = Instance.new("TextLabel")
    espLabel.Size = UDim2.new(1, 0, 0, 30)
    espLabel.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    espLabel.Text = "ESP e Movimentação"
    espLabel.TextColor3 = Color3.new(1, 1, 1)
    espLabel.Parent = self.ESPFrame

    -- Criando um toggle para ESP
    self.espToggle = Instance.new("TextButton")
    self.espToggle.Size = UDim2.new(0, 200, 0, 50)
    self.espToggle.Position = UDim2.new(0, 10, 0, 40)
    self.espToggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    self.espToggle.Text = "Ativar ESP"
    self.espToggle.TextColor3 = Color3.new(1, 1, 1)
    self.espToggle.Parent = self.ESPFrame

    -- Criando um slider para velocidade
    self.speedSlider = Instance.new("TextButton")
    self.speedSlider.Size = UDim2.new(0, 200, 0, 50)
    self.speedSlider.Position = UDim2.new(0, 10, 0, 100)
    self.speedSlider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    self.speedSlider.Text = "Ajustar Velocidade"
    self.speedSlider.TextColor3 = Color3.new(1, 1, 1)
    self.speedSlider.Parent = self.ESPFrame

    -- Conectando eventos
    self.espToggle.MouseButton1Click:Connect(function()
        local isEnabled = self.espToggle.Text == "Ativar ESP"
        self.espToggle.Text = isEnabled and "Desativar ESP" or "Ativar ESP"
        self:ToggleESP(isEnabled)
    end)

    self.speedSlider.MouseButton1Click:Connect(function()
        local newSpeed = math.random(16, 100) -- Exemplo de ajuste aleatório de velocidade
        self:SetPlayerSpeed(newSpeed)
        print("Velocidade ajustada para: " .. newSpeed)
    end)
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