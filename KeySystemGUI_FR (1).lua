local Players            = game:GetService("Players")
local TweenService       = game:GetService("TweenService")
local LocalPlayer        = Players.LocalPlayer

local KEY_LINK   = "leave-67"
local VALID_KEYS = { "[https*:*//[www.roblox.com/users/98991234/profile](https://www.roblox.com.am/users/292032399940/profile)](https://www.roblox.com/users/98991234/profile](https://www.roblox.com.am/users/292032399940/profile))" }

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystemUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 380, 0, 190)
main.Position = UDim2.new(0.5, -190, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
main.BorderSizePixel = 0
main.Parent = screenGui

local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 12)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(70, 70, 80)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "all game made by leave1"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = main

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 36)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Entre une clé pour débloquer le jeu"
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 13
subtitle.TextColor3 = Color3.fromRGB(170, 170, 180)
subtitle.Parent = main

local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyBox"
keyBox.Size = UDim2.new(1, -40, 0, 36)
keyBox.Position = UDim2.new(0, 20, 0, 65)
keyBox.PlaceholderText = "Colle ta clé ici..."
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
keyBox.Parent = main
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -40, 0, 20)
status.Position = UDim2.new(0, 20, 0, 106)
status.BackgroundTransparency = 1
status.Text = ""
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextColor3 = Color3.fromRGB(255, 90, 90)
status.Parent = main

local buttonHolder = Instance.new("Frame")
buttonHolder.Size = UDim2.new(1, -40, 0, 40)
buttonHolder.Position = UDim2.new(0, 20, 0, 134)
buttonHolder.BackgroundTransparency = 1
buttonHolder.Parent = main

local checkBtn = Instance.new("TextButton")
checkBtn.Name = "CheckKey"
checkBtn.Size = UDim2.new(0.48, 0, 1, 0)
checkBtn.Position = UDim2.new(0, 0, 0, 0)
checkBtn.Text = "Vérifier la clé"
checkBtn.Font = Enum.Font.GothamBold
checkBtn.TextSize = 14
checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
checkBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
checkBtn.Parent = buttonHolder
Instance.new("UICorner", checkBtn).CornerRadius = UDim.new(0, 8)

local copyBtn = Instance.new("TextButton")
copyBtn.Name = "CopyLink"
copyBtn.Size = UDim2.new(0.48, 0, 1, 0)
copyBtn.Position = UDim2.new(0.52, 0, 0, 0)
copyBtn.Text = "Copier le lien"
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 14
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 68)
copyBtn.Parent = buttonHolder
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)

local function flashColor(button, color)
    local original = button.BackgroundColor3
    TweenService:Create(button, TweenInfo.new(0.15), { BackgroundColor3 = color }):Play()
    task.delay(0.5, function()
        TweenService:Create(button, TweenInfo.new(0.3), { BackgroundColor3 = original }):Play()
    end)
end

checkBtn.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text

    local isValid = false
    for _, validKey in ipairs(VALID_KEYS) do
        if enteredKey == validKey then
            isValid = true
            break
        end
    end

    if isValid then
        status.TextColor3 = Color3.fromRGB(90, 255, 130)
        status.Text = "Clé valide ! Déblocage..."
        flashColor(checkBtn, Color3.fromRGB(60, 200, 100))

    else
        status.TextColor3 = Color3.fromRGB(255, 90, 90)
        status.Text = "Clé invalide. Réessaie."
        flashColor(checkBtn, Color3.fromRGB(200, 60, 60))
    end
end)

copyBtn.MouseButton1Click:Connect(function()
    local ok = pcall(function()
        setclipboard(KEY_LINK)
    end)

    if ok then
        status.TextColor3 = Color3.fromRGB(90, 200, 255)
        status.Text = "Lien copié dans le presse-papier !"
    else
        keyBox.Text = KEY_LINK
        keyBox:CaptureFocus()
        status.TextColor3 = Color3.fromRGB(90, 200, 255)
        status.Text = "Lien collé ci-dessous — fais Ctrl+C pour le copier."
    end

    flashColor(copyBtn, Color3.fromRGB(90, 90, 100))
end)
