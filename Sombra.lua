--==================================================
-- 🇦🇷 S0MBRA 3.0 - ADVANCED UI (FIXED)
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")

local LP = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

--==================================================
-- CONFIGURACIÓN Y ESTILO
--==================================================

local CORRECT_KEY = "SOMBRA"
local MAX_USES = 20          
local CurrentUses = 0        
local DISCORD_INVITE = "https://discord.gg/48qJqZEPmY" 

local Theme = {
    Background = Color3.fromRGB(12, 10, 12),
    Sidebar = Color3.fromRGB(18, 14, 18),
    Header = Color3.fromRGB(22, 16, 22),
    Card = Color3.fromRGB(25, 20, 26),
    Accent = Color3.fromRGB(215, 35, 55),
    AccentGlow = Color3.fromRGB(255, 60, 80),
    Text = Color3.fromRGB(240, 240, 240),
    TextMuted = Color3.fromRGB(150, 140, 150),
    Border = Color3.fromRGB(45, 30, 45)
}

local FastTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local SmoothTweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local PopTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

local function Tween(instance, info, properties)
    local tween = TweenService:Create(instance, info, properties)
    tween:Play()
    return tween
end

--==================================================
-- LIMPIEZA DE GUI PREVIA
--==================================================

local oldGui = LP.PlayerGui:FindFirstChild("S0mbra_3_0")
if oldGui then oldGui:Destroy() end

local Gui = Instance.new("ScreenGui")
Gui.Name = "S0mbra_3_0"
Gui.ResetOnSpawn = false
Gui.Parent = LP.PlayerGui

--==================================================
-- PANEL DE LOGEO (KEY SYSTEM)
--==================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeySystem"
KeyFrame.Size = UDim2.new(0, 380, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -190, 0.4, -125)
KeyFrame.BackgroundColor3 = Theme.Background
KeyFrame.BorderSizePixel = 0
KeyFrame.BackgroundTransparency = 1
KeyFrame.Parent = Gui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Theme.Border
KeyStroke.Thickness = 1.5
KeyStroke.Parent = KeyFrame

local KeyTopLine = Instance.new("Frame")
KeyTopLine.Size = UDim2.new(1, 0, 0, 3)
KeyTopLine.BackgroundColor3 = Theme.Accent
KeyTopLine.BorderSizePixel = 0
KeyTopLine.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🇦🇷 S0MBRA v3.0 — LOGIN"
KeyTitle.TextColor3 = Theme.Text
KeyTitle.TextSize = 15
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 40)
KeyBox.Position = UDim2.new(0, 20, 0, 55)
KeyBox.BackgroundColor3 = Theme.Card
KeyBox.PlaceholderText = "Ingrese Key de Acceso..."
KeyBox.Text = ""
KeyBox.TextColor3 = Theme.Text
KeyBox.PlaceholderColor3 = Theme.TextMuted
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.Gotham
KeyBox.BorderSizePixel = 0
KeyBox.Parent = KeyFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 6)
KeyBoxCorner.Parent = KeyBox

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 20)
StatusLabel.Position = UDim2.new(0, 20, 0, 100)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Usos restantes: " .. (MAX_USES - CurrentUses) .. "/" .. MAX_USES
StatusLabel.TextColor3 = Theme.TextMuted
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyFrame

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.45, -5, 0, 40)
VerifyBtn.Position = UDim2.new(0, 20, 0, 130)
VerifyBtn.BackgroundColor3 = Theme.Accent
VerifyBtn.Text = "🔑 Verificar"
VerifyBtn.TextColor3 = Theme.Text
VerifyBtn.TextSize = 13
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Parent = KeyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 6)
VerifyCorner.Parent = VerifyBtn

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.45, -5, 0, 40)
DiscordBtn.Position = UDim2.new(0.55, -15, 0, 130)
DiscordBtn.BackgroundColor3 = Theme.Card
DiscordBtn.Text = "💬 Discord"
DiscordBtn.TextColor3 = Theme.Text
DiscordBtn.TextSize = 12
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Parent = KeyFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBtn

Tween(KeyFrame, PopTweenInfo, {Position = UDim2.new(0.5, -190, 0.5, -125), BackgroundTransparency = 0})

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
        StatusLabel.TextColor3 = Theme.AccentGlow
        StatusLabel.Text = "Link copiado al portapapeles"
    else
        StatusLabel.Text = "Discord: " .. DISCORD_INVITE
    end
end)

--==================================================
-- PANEL PRINCIPAL
--==================================================

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 650, 0, 420)
Main.Position = UDim2.new(0.5, -325, 0.5, -210)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.Visible = false
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Theme.Border
MainStroke.Thickness = 1.5
MainStroke.Parent = Main

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 42)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 140, 1, 0)
HeaderTitle.Position = UDim2.new(0, 12, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "S0MBRA v3.0"
HeaderTitle.TextColor3 = Theme.AccentGlow
HeaderTitle.TextSize = 16
HeaderTitle.Font = Enum.Font.GothamBold
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local TelemetryLbl = Instance.new("TextLabel")
TelemetryLbl.Size = UDim2.new(0, 160, 1, 0)
TelemetryLbl.Position = UDim2.new(0, 130, 0, 0)
TelemetryLbl.BackgroundTransparency = 1
TelemetryLbl.Text = "FPS: -- | PING: --"
TelemetryLbl.TextColor3 = Theme.TextMuted
TelemetryLbl.TextSize = 11
TelemetryLbl.Font = Enum.Font.Code
TelemetryLbl.Parent = Header

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(0, 180, 0, 26)
SearchBox.Position = UDim2.new(1, -260, 0, 8)
SearchBox.BackgroundColor3 = Theme.Card
SearchBox.PlaceholderText = "Search..."
SearchBox.Text = ""
SearchBox.TextColor3 = Theme.Text
SearchBox.PlaceholderColor3 = Theme.TextMuted
SearchBox.TextSize = 11
SearchBox.Font = Enum.Font.Gotham
SearchBox.BorderSizePixel = 0
SearchBox.Parent = Header

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 13)
SearchCorner.Parent = SearchBox

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 28, 0, 28)
MinimizeBtn.Position = UDim2.new(1, -68, 0, 7)
MinimizeBtn.BackgroundColor3 = Theme.Card
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = Theme.Text
MinimizeBtn.TextSize = 14
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = Header

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -34, 0, 7)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 40)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.TextSize = 12
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

local frameCount = 0
local lastFpsUpdate = tick()
RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = tick()
    if now - lastFpsUpdate >= 1 then
        local fps = math.floor(frameCount / (now - lastFpsUpdate))
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        TelemetryLbl.Text = string.format("FPS: %d  PING: %dms", fps, ping)
        frameCount = 0
        lastFpsUpdate = now
    end
end)

VerifyBtn.MouseButton1Click:Connect(function()
    if string.upper(KeyBox.Text) == CORRECT_KEY then
        local tw = Tween(KeyFrame, FastTweenInfo, {Position = UDim2.new(0.5, -190, 0.6, -125), BackgroundTransparency = 1})
        tw.Completed:Connect(function()
            KeyFrame:Destroy()
            Main.Visible = true
            Main.Size = UDim2.new(0, 0, 0, 0)
            Main.Position = UDim2.new(0.5, 0, 0.5, 0)
            Tween(Main, PopTweenInfo, {Size = UDim2.new(0, 650, 0, 420), Position = UDim2.new(0.5, -325, 0.5, -210)})
        end)
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "❌ Key Incorrecta"
    end
end)

local dragging, dragStart, startPos = false, nil, nil
Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        Tween(Main, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {Position = targetPos})
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--==================================================
-- PESTAÑAS
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 8)
SidebarPadding.Parent = Sidebar

local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -140, 1, -42)
ContentArea.Position = UDim2.new(0, 140, 0, 42)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = Main

local PagesList = {}
local ActivePage = nil

local function NewPage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.Parent = ContentArea

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 6)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.Parent = Page

    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.Parent = Page

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 20)
    end)

    return Page
end

local function NewTab(text)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -16, 0, 32)
    Button.BackgroundColor3 = Theme.Sidebar
    Button.Text = "  " .. text
    Button.TextColor3 = Theme.TextMuted
    Button.TextSize = 11
    Button.Font = Enum.Font.GothamBold
    Button.TextXAlignment = Enum.TextXAlignment.Left
    Button.BorderSizePixel = 0
    Button.Parent = Sidebar

    local CornerBtn = Instance.new("UICorner")
    CornerBtn.CornerRadius = UDim.new(0, 5)
    CornerBtn.Parent = Button

    local Page = NewPage()
    table.insert(PagesList, {Button = Button, Page = Page, Name = text:lower()})

    Button.MouseEnter:Connect(function()
        if ActivePage ~= Page then
            Tween(Button, FastTweenInfo, {BackgroundColor3 = Theme.Card, TextColor3 = Theme.Text})
        end
    end)

    Button.MouseLeave:Connect(function()
        if ActivePage ~= Page then
            Tween(Button, FastTweenInfo, {BackgroundColor3 = Theme.Sidebar, TextColor3 = Theme.TextMuted})
        end
    end)

    Button.MouseButton1Click:Connect(function()
        for _, v in ipairs(PagesList) do
            v.Page.Visible = false
            Tween(v.Button, FastTweenInfo, {BackgroundColor3 = Theme.Sidebar, TextColor3 = Theme.TextMuted})
        end
        ActivePage = Page
        Page.Visible = true
        Page.Position = UDim2.new(0, 10, 0, 0)
        Tween(Page, SmoothTweenInfo, {Position = UDim2.new(0, 0, 0, 0)})
        Tween(Button, FastTweenInfo, {BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text})
    end)

    return Page
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    if ActivePage then
        for _, child in ipairs(ActivePage:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then
                local label = child:FindFirstChildOfClass("TextLabel")
                local text = label and label.Text or (child:IsA("TextButton") and child.Text or "")
                if query == "" or text:lower():find(query) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end
end)

local MovePage = NewTab("Movimiento")
local VisualPage = NewTab("ESP Visuales")
local CombatPage = NewTab("Combat & Aim")
local AsesinoPage = NewTab("Asesino MM2")
local TPPage = NewTab("Teleport & Cam")
local SettingsPage = NewTab("Ajustes UI")

PagesList[1].Page.Visible = true
ActivePage = PagesList[1].Page
PagesList[1].Button.BackgroundColor3 = Theme.Accent
PagesList[1].Button.TextColor3 = Theme.Text

--==================================================
-- COMPONENTES INTERACTIVOS
--==================================================

local function Label(parent, text)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 24)
    Frame.BackgroundTransparency = 1
    Frame.Parent = parent

    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, 0, 1, 0)
    L.BackgroundTransparency = 1
    L.Text = text:upper()
    L.TextColor3 = Theme.AccentGlow
    L.TextSize = 10
    L.Font = Enum.Font.GothamBold
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = Frame
    return Frame
end

local function Toggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 36)
    Frame.BackgroundColor3 = Theme.Card
    Frame.BorderSizePixel = 0
    Frame.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Frame

    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(0.7, 0, 1, 0)
    L.Position = UDim2.new(0, 10, 0, 0)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = Theme.Text
    L.TextSize = 11
    L.Font = Enum.Font.Gotham
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = Frame

    local SwitchBg = Instance.new("Frame")
    SwitchBg.Size = UDim2.new(0, 36, 0, 18)
    SwitchBg.Position = UDim2.new(1, -44, 0.5, -9)
    SwitchBg.BackgroundColor3 = Theme.Border
    SwitchBg.BorderSizePixel = 0
    SwitchBg.Parent = Frame

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBg

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 14, 0, 14)
    Knob.Position = UDim2.new(0, 2, 0.5, -7)
    Knob.BackgroundColor3 = Theme.Text
    Knob.BorderSizePixel = 0
    Knob.Parent = SwitchBg

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.BackgroundTransparency = 1
    Button.Text = ""
    Button.Parent = Frame

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Tween(SwitchBg, FastTweenInfo, {BackgroundColor3 = Theme.Accent})
            Tween(Knob, PopTweenInfo, {Position = UDim2.new(1, -16, 0.5, -7)})
        else
            Tween(SwitchBg, FastTweenInfo, {BackgroundColor3 = Theme.Border})
            Tween(Knob, PopTweenInfo, {Position = UDim2.new(0, 2, 0.5, -7)})
        end
        callback(enabled)
    end)

    return Frame
end

local function Slider(parent, text, min, max, default, callback)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1, -20, 0, 46)
    Holder.BackgroundColor3 = Theme.Card
    Holder.Parent = parent

    local HolderCorner = Instance.new("UICorner")
    HolderCorner.CornerRadius = UDim.new(0, 6)
    HolderCorner.Parent = Holder

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1, -20, 0, 20)
    Text.Position = UDim2.new(0, 10, 0, 4)
    Text.BackgroundTransparency = 1
    Text.Text = text .. ": " .. math.floor(default)
    Text.TextColor3 = Theme.Text
    Text.TextSize = 11
    Text.Font = Enum.Font.Gotham
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Holder

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1, -20, 0, 4)
    Bar.Position = UDim2.new(0, 10, 0, 30)
    Bar.BackgroundColor3 = Theme.Border
    Bar.BorderSizePixel = 0
    Bar.Parent = Holder

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(0, 2)
    BarCorner.Parent = Bar

    local Fill = Instance.new("Frame")
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Accent
    Fill.BorderSizePixel = 0
    Fill.Parent = Bar

    local FillCorner = Instance.new("UICorner")
    FillCorner.CornerRadius = UDim.new(0, 2)
    FillCorner.Parent = Fill

    local draggingSlider = false
    local function SetValue(x)
        local percent = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local value = min + (max - min) * percent
        Tween(Fill, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Size = UDim2.new(percent, 0, 1, 0)})
        Text.Text = text .. ": " .. math.floor(value)
        callback(value)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
            SetValue(input.Position.X)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            SetValue(input.Position.X)
        end
    end)

    return Holder
end

--==================================================
-- VARIABLES & LÓGICA DE JUEGO
--==================================================

local SpeedEnabled, NoclipEnabled, ESPEnabled = false, false, false
local SpeedValue, ESPDistance = 16, 500
local AutoAimEnabled, AimMaxDistance = false, 100
local AutoKillActive, AutoEquipWeapon = false, false
local JumpEnabled, InfiniteJumpEnabled = false, false
local JumpValue = 50

local ESPInfoEnabled, ESPTracersEnabled = false, false
local Tracers = {}

local function CheckItemName(itemName)
    itemName = itemName:lower()
    if itemName:find("knife") or itemName:find("cuchillo") or itemName:find("blade") or itemName:find("murderer") or itemName:find("asesino") then
        return "Asesino", Color3.fromRGB(255, 50, 60)
    elseif itemName:find("gun") or itemName:find("pistol") or itemName:find("revolver") or itemName:find("sheriff") or itemName:find("hero") then
        return "Sheriff", Color3.fromRGB(60, 140, 255)
    end
    return nil
end

local function GetPlayerRole(player)
    if not player then return "Inocente", Color3.fromRGB(60, 220, 100) end
    if player.Character then
        for _, child in ipairs(player.Character:GetChildren()) do
            if child:IsA("Tool") then
                local role, color = CheckItemName(child.Name)
                if role then return role, color end
            end
        end
    end
    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, child in ipairs(backpack:GetChildren()) do
            if child:IsA("Tool") then
                local role, color = CheckItemName(child.Name)
                if role then return role, color end
            end
        end
    end
    return "Inocente", Color3.fromRGB(60, 220, 100)
end

local function GetAnyWeapon()
    local Character = LP.Character
    if not Character then return nil end

    for _, Tool in ipairs(Character:GetChildren()) do
        if Tool:IsA("Tool") then return Tool end
    end

    local Backpack = LP:FindFirstChildOfClass("Backpack")
    if Backpack then
        for _, Tool in ipairs(Backpack:GetChildren()) do
            if Tool:IsA("Tool") then
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then 
                    Humanoid:EquipTool(Tool)
                    task.wait(0.05)
                end
                return Tool
            end
        end
    end
    return nil
end

--==================================================
-- LLENADO DE OPCIONES POR PESTAÑA
--==================================================

-- MOVIMIENTO
Label(MovePage, "Controles de Velocidad")
Toggle(MovePage, "Velocidad Modificada", function(v) SpeedEnabled = v end)
Slider(MovePage, "Valor de Velocidad", 16, 120, SpeedValue, function(v) SpeedValue = v end)
Toggle(MovePage, "Noclip (Atravesar Paredes)", function(v) NoclipEnabled = v end)

Label(MovePage, "Físicas de Salto")
Toggle(MovePage, "Salto Aumentado", function(v)
    JumpEnabled = v
    local Hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if Hum then Hum.UseJumpPower = true Hum.JumpPower = JumpEnabled and JumpValue or 50 end
end)
Slider(MovePage, "Potencia de Salto", 50, 200, JumpValue, function(v)
    JumpValue = v
    local Hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if Hum and JumpEnabled then Hum.JumpPower = JumpValue end
end)
Toggle(MovePage, "Salto Infinito", function(v) InfiniteJumpEnabled = v end)

-- VISUALES ESP
Label(VisualPage, "Configuración ESP")
Toggle(VisualPage, "ESP Highlight (Chams)", function(v) ESPEnabled = v end)
Toggle(VisualPage, "ESP Etiquetas (Rol / Salud / Dist)", function(v) ESPInfoEnabled = v end)
Toggle(VisualPage, "ESP Líneas (Tracers)", function(v)
    ESPTracersEnabled = v
    if not v then
        for _, line in pairs(Tracers) do
            if line then
                line.Visible = false
                pcall(function() line:Remove() end)
            end
        end
        Tracers = {}
    end
end)
Slider(VisualPage, "Distancia de Renderizado", 100, 1500, ESPDistance, function(v) ESPDistance = v end)

-- COMBAT
Label(CombatPage, "Asistencia de Apuntado")
Toggle(CombatPage, "Aimbot Auto LookAt", function(v) AutoAimEnabled = v end)
Slider(CombatPage, "Radio de Apuntado", 20, 300, AimMaxDistance, function(v) AimMaxDistance = v end)

-- ASESINO
Label(AsesinoPage, "Opciones MM2 / Murderer")
Toggle(AsesinoPage, "Auto Equipar Arma", function(v) AutoEquipWeapon = v end)
Toggle(AsesinoPage, "Auto TP + Attack Bucle", function(v)
    AutoKillActive = v
    if AutoKillActive then
        task.spawn(function()
            while AutoKillActive do
                local MyRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                if MyRoot then
                    for _, Target in ipairs(Players:GetPlayers()) do
                        if not AutoKillActive then break end
                        if Target ~= LP and Target.Character then
                            local TargetRoot = Target.Character:FindFirstChild("HumanoidRootPart")
                            local TargetHum = Target.Character:FindFirstChildOfClass("Humanoid")
                            if TargetRoot and TargetHum and TargetHum.Health > 0 then
                                MyRoot.CFrame = TargetRoot.CFrame * CFrame.new(0, 0, 2)
                                local Weapon = GetAnyWeapon()
                                if Weapon then Weapon:Activate() end
                                task.wait(0.1)
                            end
                        end
                    end
                end
                task.wait(0.15)
            end
        end)
    end
end)

-- TELEPORT & CAM
Label(TPPage, "Controles de Cámara")
local ResetCamBtn = Instance.new("TextButton")
ResetCamBtn.Size = UDim2.new(1, -20, 0, 32)
ResetCamBtn.BackgroundColor3 = Theme.Accent
ResetCamBtn.Text = "🎥 Resetear Cámara"
ResetCamBtn.TextColor3 = Theme.Text
ResetCamBtn.Font = Enum.Font.GothamBold
ResetCamBtn.TextSize = 11
ResetCamBtn.BorderSizePixel = 0
ResetCamBtn.Parent = TPPage

local ResetCamCorner = Instance.new("UICorner")
ResetCamCorner.CornerRadius = UDim.new(0, 6)
ResetCamCorner.Parent = ResetCamBtn

ResetCamBtn.MouseButton1Click:Connect(function()
    local char = LP.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        Camera.CameraType = Enum.CameraType.Custom
        Camera.CameraSubject = char:FindFirstChildOfClass("Humanoid")
    end
end)

Label(TPPage, "Lista de Jugadores")
local TPContainer = Instance.new("Frame")
TPContainer.Size = UDim2.new(1, -20, 0, 200)
TPContainer.BackgroundTransparency = 1
TPContainer.Parent = TPPage

local TPLayout = Instance.new("UIListLayout")
TPLayout.Padding = UDim.new(0, 4)
TPLayout.Parent = TPContainer

local function UpdateTPList()
    for _, c in ipairs(TPContainer:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then
            local Item = Instance.new("Frame")
            Item.Size = UDim2.new(1, 0, 0, 28)
            Item.BackgroundColor3 = Theme.Card
            Item.BorderSizePixel = 0
            Item.Parent = TPContainer

            local ItemCorner = Instance.new("UICorner")
            ItemCorner.CornerRadius = UDim.new(0, 4)
            ItemCorner.Parent = Item

            local Name = Instance.new("TextLabel")
            Name.Size = UDim2.new(0.5, 0, 1, 0)
            Name.Position = UDim2.new(0, 8, 0, 0)
            Name.BackgroundTransparency = 1
            Name.Text = p.DisplayName
            Name.TextColor3 = Theme.Text
            Name.Font = Enum.Font.Gotham
            Name.TextSize = 11
            Name.TextXAlignment = Enum.TextXAlignment.Left
            Name.Parent = Item

            local TPBtn = Instance.new("TextButton")
            TPBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
            TPBtn.Position = UDim2.new(0.55, 0, 0.15, 0)
            TPBtn.BackgroundColor3 = Theme.Accent
            TPBtn.Text = "TP"
            TPBtn.TextColor3 = Theme.Text
            TPBtn.Font = Enum.Font.GothamBold
            TPBtn.TextSize = 10
            TPBtn.BorderSizePixel = 0
            TPBtn.Parent = Item

            local TPCorner = Instance.new("UICorner")
            TPCorner.CornerRadius = UDim.new(0, 4)
            TPCorner.Parent = TPBtn

            local ViewBtn = Instance.new("TextButton")
            ViewBtn.Size = UDim2.new(0.2, 0, 0.7, 0)
            ViewBtn.Position = UDim2.new(0.77, 0, 0.15, 0)
            ViewBtn.BackgroundColor3 = Theme.Border
            ViewBtn.Text = "Ver"
            ViewBtn.TextColor3 = Theme.Text
            ViewBtn.Font = Enum.Font.GothamBold
            ViewBtn.TextSize = 10
            ViewBtn.BorderSizePixel = 0
            ViewBtn.Parent = Item

            local ViewCorner = Instance.new("UICorner")
            ViewCorner.CornerRadius = UDim.new(0, 4)
            ViewCorner.Parent = ViewBtn

            TPBtn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
                    LP.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                end
            end)

            ViewBtn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
                    Camera.CameraType = Enum.CameraType.Custom
                    Camera.CameraSubject = p.Character:FindFirstChildOfClass("Humanoid")
                end
            end)
        end
    end
end
Players.PlayerAdded:Connect(UpdateTPList)
Players.PlayerRemoving:Connect(UpdateTPList)
UpdateTPList()

-- AJUSTES
Label(SettingsPage, "Personalización")
Slider(SettingsPage, "Ancho de la Ventana", 550, 750, 650, function(v)
    Main.Size = UDim2.new(0, v, 0, Main.Size.Y.Offset)
end)
Slider(SettingsPage, "Alto de la Ventana", 350, 500, 420, function(v)
    Main.Size = UDim2.new(0, Main.Size.X.Offset, 0, v)
end)

Label(SettingsPage, "Atajos de Teclado")
Label(SettingsPage, "Ocultar/Mostrar Menú: [RightControl]")

--==================================================
-- BUCLE RENDERSTEPPED Y HEARTBEAT
--==================================================

UIS.JumpRequest:Connect(function()
    local Hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if Hum and InfiniteJumpEnabled then
        Hum.UseJumpPower = true
        Hum.JumpPower = JumpEnabled and JumpValue or 50
        Hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.RenderStepped:Connect(function()
    local myChar = LP.Character
    local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local targetRoot = p.Character:FindFirstChild("HumanoidRootPart")
            local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
            local role, roleColor = GetPlayerRole(p)

            -- ESP HighLight
            local highlight = p.Character:FindFirstChild("S0mbra_Highlight")
            if ESPEnabled and targetRoot then
                local dist = myRoot and (myRoot.Position - targetRoot.Position).Magnitude or 0
                if dist <= ESPDistance then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "S0mbra_Highlight"
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.OutlineTransparency = 0.2
                        highlight.FillTransparency = 0.4
                        highlight.Parent = p.Character
                    end
                    highlight.FillColor = roleColor
                elseif highlight then highlight:Destroy() end
            elseif highlight then highlight:Destroy() end

            -- ESP Tags
            local tag = p.Character:FindFirstChild("S0mbra_Tag")
            if ESPInfoEnabled and targetRoot and targetHum then
                local dist = myRoot and math.floor((myRoot.Position - targetRoot.Position).Magnitude) or 0
                if dist <= ESPDistance then
                    if not tag then
                        tag = Instance.new("BillboardGui")
                        tag.Name = "S0mbra_Tag"
                        tag.Size = UDim2.new(0, 160, 0, 40)
                        tag.AlwaysOnTop = true
                        tag.ExtentsOffset = Vector3.new(0, 3, 0)
                        tag.Parent = p.Character

                        local lbl = Instance.new("TextLabel")
                        lbl.Name = "Info"
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 1
                        lbl.TextSize = 10
                        lbl.Font = Enum.Font.GothamBold
                        lbl.Parent = tag
                    end
                    tag.Info.TextColor3 = roleColor
                    tag.Info.Text = string.format("[%s] %s\nHP: %d | Dist: %dm", role:upper(), p.DisplayName, math.floor(targetHum.Health), dist)
                elseif tag then tag:Destroy() end
            elseif tag then tag:Destroy() end

            -- ESP Tracers
            if ESPTracersEnabled and targetRoot and targetHum and targetHum.Health > 0 and Drawing then
                local dist = myRoot and (myRoot.Position - targetRoot.Position).Magnitude or 0
                if dist <= ESPDistance then
                    local screenPos, vis = Camera:WorldToViewportPoint(targetRoot.Position)
                    if vis then
                        if not Tracers[p] then
                            pcall(function()
                                local line = Drawing.new("Line")
                                line.Thickness = 1.2
                                line.Transparency = 0.8
                                Tracers[p] = line
                            end)
                        end
                        if Tracers[p] then
                            Tracers[p].Color = roleColor
                            Tracers[p].From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                            Tracers[p].To = Vector2.new(screenPos.X, screenPos.Y)
                            Tracers[p].Visible = true
                        end
                    elseif Tracers[p] then Tracers[p].Visible = false end
                elseif Tracers[p] then Tracers[p].Visible = false end
            elseif Tracers[p] then Tracers[p].Visible = false end
        elseif Tracers[p] then Tracers[p].Visible = false end
    end
end)

RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not hum or not myRoot then return end

    if AutoEquipWeapon then GetAnyWeapon() end
    if SpeedEnabled then hum.WalkSpeed = SpeedValue else hum.WalkSpeed = 16 end

    if NoclipEnabled then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    if AutoAimEnabled then
        local closest, closestDist = nil, AimMaxDistance
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
                if targetHum and targetHum.Health > 0 then
                    local dist = (myRoot.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < closestDist then
                        closestDist = dist
                        closest = p.Character.HumanoidRootPart
                    end
                end
            end
        end
        if closest then
            myRoot.CFrame = CFrame.new(myRoot.Position, Vector3.new(closest.Position.X, myRoot.Position.Y, closest.Position.Z))
        end
    end
end)

--==================================================
-- CONTROLES DE VENTANA
--==================================================

local isMinimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Sidebar.Visible = false
        ContentArea.Visible = false
        Tween(Main, FastTweenInfo, {Size = UDim2.new(0, Main.Size.X.Offset, 0, 42)})
    else
        local tw = Tween(Main, SmoothTweenInfo, {Size = UDim2.new(0, Main.Size.X.Offset, 0, 420)})
        tw.Completed:Connect(function()
            if not isMinimized then
                Sidebar.Visible = true
                ContentArea.Visible = true
            end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    for _, line in pairs(Tracers) do 
        if line and line.Remove then 
            pcall(function() line:Remove() end) 
        end 
    end
    local tw = Tween(Main, PopTweenInfo, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)})
    tw.Completed:Connect(function()
        Gui:Destroy()
    end)
end)

UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
        Main.Visible = not Main.Visible
    end
end)
