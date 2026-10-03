--==================================================
-- 🇦🇷 S0MBRA 2.4 - KEY SYSTEM & ADVANCED GUI
-- MOVIMIENTO / VISUALES / COMBAT / TP / AJUSTES
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")

local LP = Players.LocalPlayer

--==================================================
-- CONFIGURACIÓN DE LA PALABRA CLAVE Y LÍMITE DE USOS
--==================================================

local CORRECT_KEY = "SOMBRA" -- Palabra clave (acepta minúsculas o mayúsculas)
local MAX_USES = 20          -- Límite total de usos de la clave
local CurrentUses = 0        -- Contador de usos actuales en la sesión
local DISCORD_INVITE = "https://discord.gg/48qJqZEPmY" -- Enlace de Discord oficial

--==================================================
-- LIMPIEZA DE GUI PREVIA
--==================================================

local oldGui = LP.PlayerGui:FindFirstChild("S0mbra_2_4")
if oldGui then
    oldGui:Destroy()
end

local Gui = Instance.new("ScreenGui")
Gui.Name = "S0mbra_2_4"
Gui.ResetOnSpawn = false
Gui.Parent = LP.PlayerGui

--==================================================
-- PANEL DE LOGIN / PALABRA CLAVE (KEY SYSTEM)
--==================================================

local KeyFrame = Instance.new("Frame")
KeyFrame.Name = "KeySystem"
KeyFrame.Size = UDim2.new(0, 380, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -190, 0.5, -125)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = Gui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 10)
KeyCorner.Parent = KeyFrame

local KeyTopArgentina = Instance.new("Frame")
KeyTopArgentina.Size = UDim2.new(1, 0, 0, 4)
KeyTopArgentina.BackgroundColor3 = Color3.fromRGB(116, 190, 230)
KeyTopArgentina.BorderSizePixel = 0
KeyTopArgentina.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 35)
KeyTitle.Position = UDim2.new(0, 0, 0, 10)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🇦🇷 S0MBRA 2.4 - ACCESO"
KeyTitle.TextColor3 = Color3.fromRGB(235, 235, 235)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -40, 0, 40)
KeyBox.Position = UDim2.new(0, 20, 0, 50)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyBox.PlaceholderText = "Ingresa la Palabra Clave..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
KeyBox.TextSize = 13
KeyBox.Font = Enum.Font.Gotham
KeyBox.BorderSizePixel = 0
KeyBox.Parent = KeyFrame

local KeyBoxCorner = Instance.new("UICorner")
KeyBoxCorner.CornerRadius = UDim.new(0, 6)
KeyBoxCorner.Parent = KeyBox

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -40, 0, 20)
StatusLabel.Position = UDim2.new(0, 20, 0, 95)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Usos disponibles: " .. (MAX_USES - CurrentUses) .. "/" .. MAX_USES
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Parent = KeyFrame

local VerifyBtn = Instance.new("TextButton")
VerifyBtn.Size = UDim2.new(0.45, -5, 0, 40)
VerifyBtn.Position = UDim2.new(0, 20, 0, 125)
VerifyBtn.BackgroundColor3 = Color3.fromRGB(30, 110, 55)
VerifyBtn.Text = "🔑 Verificar"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 13
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.BorderSizePixel = 0
VerifyBtn.Parent = KeyFrame

local VerifyCorner = Instance.new("UICorner")
VerifyCorner.CornerRadius = UDim.new(0, 6)
VerifyCorner.Parent = VerifyBtn

local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Size = UDim2.new(0.45, -5, 0, 40)
DiscordBtn.Position = UDim2.new(0.55, -15, 0, 125)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "💬 Logear / Discord"
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.TextSize = 12
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.BorderSizePixel = 0
DiscordBtn.Parent = KeyFrame

local DiscordCorner = Instance.new("UICorner")
DiscordCorner.CornerRadius = UDim.new(0, 6)
DiscordCorner.Parent = DiscordBtn

local KeyClose = Instance.new("TextButton")
KeyClose.Size = UDim2.new(0, 30, 0, 30)
KeyClose.Position = UDim2.new(1, -35, 0, 5)
KeyClose.BackgroundTransparency = 1
KeyClose.Text = "X"
KeyClose.TextColor3 = Color3.fromRGB(200, 50, 50)
KeyClose.TextSize = 16
KeyClose.Font = Enum.Font.GothamBold
KeyClose.Parent = KeyFrame

KeyClose.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_INVITE)
        StatusLabel.TextColor3 = Color3.fromRGB(116, 190, 230)
        StatusLabel.Text = "Link de Discord copiado al portapapeles"
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        StatusLabel.Text = "Discord: " .. DISCORD_INVITE
    end
end)

--==================================================
-- PANEL PRINCIPAL (OCULTO HASTA VALIDAR KEY)
--==================================================

local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(.5, -260, .5, -190)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,10)
Corner.Parent = Main

local TopArgentina = Instance.new("Frame")
TopArgentina.Size = UDim2.new(1,0,0,4)
TopArgentina.BackgroundColor3 = Color3.fromRGB(116,190,230)
TopArgentina.BorderSizePixel = 0
TopArgentina.Parent = Main

local BottomArgentina = Instance.new("Frame")
BottomArgentina.Size = UDim2.new(1,0,0,4)
BottomArgentina.Position = UDim2.new(0,0,1,-4)
BottomArgentina.BackgroundColor3 = Color3.fromRGB(116,190,230)
BottomArgentina.BorderSizePixel = 0
BottomArgentina.Parent = Main

-- VALIDACIÓN DE CLAVE Y CONTROL DE USOS
VerifyBtn.MouseButton1Click:Connect(function()
    if CurrentUses >= MAX_USES then
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "❌ Límite alcanzado (20/20 usos consumidos)"
        return
    end

    local inputKey = string.upper(KeyBox.Text)
    if inputKey == CORRECT_KEY then
        CurrentUses = CurrentUses + 1
        KeyFrame:Destroy()
        Main.Visible = true
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
        StatusLabel.Text = "❌ Palabra clave incorrecta"
    end
end)

--==================================================
-- CONFIGURACIÓN DE FUNCIONES INTERNAS
--==================================================

local SpeedEnabled = false
local JumpEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local ESPEnabled = false
local SelfHighlightEnabled = true

local SpeedValue = 16
local JumpValue = 50
local FlySpeed = 50
local ESPDistance = 100

-- COMBAT CONFIG
local AutoAimEnabled = false
local TargetIndicatorEnabled = false
local AimMaxDistance = 100

local SelectedPlayer = nil

-- AUDIO CONFIG
local MusicVolume = 0.5
local UISfxEnabled = true
local CurrentTrackIndex = 1

local MusicPlaylist = {
    {Name = "Phonk Chill / Drive", Id = "rbxassetid://9043887091"},
    {Name = "Cyberpunk Synthwave", Id = "rbxassetid://1837849270"},
    {Name = "Electronic Gaming", Id = "rbxassetid://1839843807"},
    {Name = "Lo-Fi Beats", Id = "rbxassetid://9048375035"}
}

--==================================================
-- AUDIO PLAYER INSTANCE
--==================================================

local BGM = Instance.new("Sound")
BGM.Name = "S0mbra_BGM"
BGM.Looped = true
BGM.Volume = MusicVolume
BGM.Parent = SoundService

local ClickSFX = Instance.new("Sound")
ClickSFX.Name = "S0mbra_ClickSFX"
ClickSFX.SoundId = "rbxassetid://6895079853"
ClickSFX.Volume = 0.3
ClickSFX.Parent = SoundService

local function PlayClick()
    if UISfxEnabled then
        ClickSFX:Play()
    end
end

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(25,25,25)
Top.BorderSizePixel = 0
Top.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,12,0,0)
Title.BackgroundTransparency = 1
Title.Text = "🇦🇷 S0MBRA 2.4"
Title.TextColor3 = Color3.fromRGB(235,235,235)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,35,0,30)
Minimize.Position = UDim2.new(1,-75,0,5)
Minimize.BackgroundColor3 = Color3.fromRGB(40,40,40)
Minimize.Text = "—"
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.TextSize = 20
Minimize.Font = Enum.Font.GothamBold
Minimize.Parent = Top

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,35,0,30)
Close.Position = UDim2.new(1,-38,0,5)
Close.BackgroundColor3 = Color3.fromRGB(120,35,35)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 15
Close.Font = Enum.Font.GothamBold
Close.Parent = Top

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart, startPos

Top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

--==================================================
-- TABS & PAGES
--==================================================

local Tabs = Instance.new("Frame")
Tabs.Size = UDim2.new(0,135,1,-48)
Tabs.Position = UDim2.new(0,5,0,43)
Tabs.BackgroundColor3 = Color3.fromRGB(20,20,20)
Tabs.BorderSizePixel = 0
Tabs.Parent = Main

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0,5)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = Tabs

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1,-150,1,-48)
Pages.Position = UDim2.new(0,145,0,43)
Pages.BackgroundTransparency = 1
Pages.Parent = Main

local function NewPage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1,0,1,0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0,0,0,0)
    Page.Parent = Pages

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0,8)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.Parent = Page

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 15)
    end)

    return Page
end

local PagesList = {}

local function NewTab(text)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-10,0,42)
    Button.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(220,220,220)
    Button.TextSize = 13
    Button.Font = Enum.Font.GothamBold
    Button.BorderSizePixel = 0
    Button.Parent = Tabs

    local Page = NewPage()
    table.insert(PagesList,{Button,Page})

    Button.MouseButton1Click:Connect(function()
        PlayClick()
        for _,v in ipairs(PagesList) do
            v[2].Visible = false
            v[1].BackgroundColor3 = Color3.fromRGB(30,30,30)
        end
        Page.Visible = true
        Button.BackgroundColor3 = Color3.fromRGB(55,55,55)
    end)

    return Page
end

local MovePage = NewTab("🇦🇷 MOVIMIENTO")
local VisualPage = NewTab("👁 VISUALES")
local CombatPage = NewTab("⚔ COMBAT")
local TPPage = NewTab("📍 TP")
local SettingsPage = NewTab("⚙ AJUSTES")

PagesList[1][2].Visible = true
PagesList[1][1].BackgroundColor3 = Color3.fromRGB(55,55,55)

--==================================================
-- HELPERS DE INTERFAZ
--==================================================

local function Label(parent,text)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1,-20,0,28)
    L.BackgroundTransparency = 1
    L.Text = text
    L.TextColor3 = Color3.fromRGB(220,220,220)
    L.TextSize = 14
    L.Font = Enum.Font.GothamBold
    L.TextXAlignment = Enum.TextXAlignment.Left
    L.Parent = parent
    return L
end

local function Toggle(parent,text,callback)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1,-20,0,38)
    B.BackgroundColor3 = Color3.fromRGB(35,35,35)
    B.Text = text.."  [OFF]"
    B.TextColor3 = Color3.fromRGB(230,230,230)
    B.TextSize = 13
    B.Font = Enum.Font.GothamBold
    B.BorderSizePixel = 0
    B.Parent = parent

    local enabled = false

    B.MouseButton1Click:Connect(function()
        PlayClick()
        enabled = not enabled
        if enabled then
            B.Text = text.."  [ON]"
            B.BackgroundColor3 = Color3.fromRGB(30,110,55)
        else
            B.Text = text.."  [OFF]"
            B.BackgroundColor3 = Color3.fromRGB(35,35,35)
        end
        callback(enabled)
    end)

    return B
end

local function Slider(parent,text,min,max,default,callback)
    local Holder = Instance.new("Frame")
    Holder.Size = UDim2.new(1,-20,0,55)
    Holder.BackgroundTransparency = 1
    Holder.Parent = parent

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1,0,0,22)
    Text.BackgroundTransparency = 1
    Text.Text = text..": "..math.floor(default)
    Text.TextColor3 = Color3.fromRGB(220,220,220)
    Text.TextSize = 13
    Text.Font = Enum.Font.Gotham
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.Parent = Holder

    local Bar = Instance.new("Frame")
    Bar.Size = UDim2.new(1,0,0,7)
    Bar.Position = UDim2.new(0,0,0,35)
    Bar.BackgroundColor3 = Color3.fromRGB(55,55,55)
    Bar.BorderSizePixel = 0
    Bar.Parent = Holder

    local BarCorner = Instance.new("UICorner")
    BarCorner.CornerRadius = UDim.new(1,0)
    BarCorner.Parent = Bar

    local Knob = Instance.new("TextButton")
    Knob.Size = UDim2.new(0,16,0,16)
    Knob.AnchorPoint = Vector2.new(.5,.5)
    Knob.Position = UDim2.new((default-min)/(max-min),0,.5,0)
    Knob.BackgroundColor3 = Color3.fromRGB(116,190,230)
    Knob.Text = ""
    Knob.BorderSizePixel = 0
    Knob.Parent = Bar

    local draggingSlider = false

    local function SetValue(x)
        local percent = math.clamp((x-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X, 0, 1)
        local value = min + (max-min)*percent
        Knob.Position = UDim2.new(percent,0,.5,0)
        Text.Text = text..": "..math.floor(value)
        callback(value)
    end

    Knob.MouseButton1Down:Connect(function() draggingSlider = true end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then draggingSlider = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            SetValue(input.Position.X)
        end
    end)

    return Holder
end

--==================================================
-- MOVIMIENTO
--==================================================

Label(MovePage,"MOVIMIENTO")
Toggle(MovePage,"⚡ SPEED",function(v) SpeedEnabled = v end)
Slider(MovePage,"Velocidad",0,100,SpeedValue,function(v) SpeedValue = v end)
Toggle(MovePage,"🦘 JUMP",function(v) JumpEnabled = v end)
Slider(MovePage,"Salto",0,200,JumpValue,function(v) JumpValue = v end)
Toggle(MovePage,"🕊 FLY",function(v) FlyEnabled = v end)
Slider(MovePage,"Velocidad Fly",1,150,FlySpeed,function(v) FlySpeed = v end)
Toggle(MovePage,"👻 NOCLIP",function(v) NoclipEnabled = v end)

Label(MovePage,"Fly: WASD / joystick • SPACE subir • CTRL bajar")

--==================================================
-- VISUALES
--==================================================

Label(VisualPage,"ESP DE JUGADORES")
Toggle(VisualPage,"👁 ESP",function(v) ESPEnabled = v end)
Slider(VisualPage,"Distancia ESP",10,300,ESPDistance,function(v) ESPDistance = v end)

Toggle(VisualPage,"🔴 Marcar mi personaje",function(v)
    SelfHighlightEnabled = v
    local char = LP.Character
    if not char then return end
    local old = char:FindFirstChild("S0mbraSelfHighlight")
    if v then
        if not old then
            local H = Instance.new("Highlight")
            H.Name = "S0mbraSelfHighlight"
            H.FillColor = Color3.fromRGB(255,0,0)
            H.OutlineColor = Color3.fromRGB(255,0,0)
            H.FillTransparency = .65
            H.OutlineTransparency = 0
            H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            H.Parent = char
        end
    else
        if old then old:Destroy() end
    end
end)

Label(VisualPage,"🔴 Jugadores detectados = rojo")
Label(VisualPage,"🟢 Línea desde vos hasta el jugador")

--==================================================
-- COMBAT
--==================================================

Label(CombatPage,"⚔ APUNTADO AUTOMÁTICO")
Toggle(CombatPage,"🎯 Auto LookAt Cercano",function(v) AutoAimEnabled = v end)
Toggle(CombatPage,"🟡 Marcar Target Cercano",function(v) TargetIndicatorEnabled = v end)
Slider(CombatPage,"Rango Máximo",10,300,AimMaxDistance,function(v) AimMaxDistance = v end)

Label(CombatPage,"Gira automáticamente hacia el jugador")
Label(CombatPage,"más cercano dentro del rango.")

local function GetClosestPlayer()
    local myChar = LP.Character
    if not myChar then return nil end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closestPlr = nil
    local shortestDistance = AimMaxDistance

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character then
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            if root and hum and hum.Health > 0 then
                local dist = (root.Position - myRoot.Position).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    closestPlr = plr
                end
            end
        end
    end

    return closestPlr
end

--==================================================
-- TELETRANSPORTE (TP)
--==================================================

Label(TPPage,"🇦🇷 TELETRANSPORTE")

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1,-20,0,135)
PlayerList.BackgroundColor3 = Color3.fromRGB(20,20,20)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 4
PlayerList.Parent = TPPage

local PlayerLayout = Instance.new("UIListLayout")
PlayerLayout.Padding = UDim.new(0,4)
PlayerLayout.Parent = PlayerList

PlayerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, PlayerLayout.AbsoluteContentSize.Y + 5)
end)

local function RefreshPlayerList()
    for _,v in ipairs(PlayerList:GetChildren()) do
        if v:IsA("TextButton") then v:Destroy() end
    end

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local B = Instance.new("TextButton")
            B.Size = UDim2.new(1,-5,0,35)
            B.BackgroundColor3 = (SelectedPlayer == plr) and Color3.fromRGB(30,100,60) or Color3.fromRGB(35,35,35)
            B.Text = "👤 "..plr.DisplayName.."  @"..plr.Name
            B.TextColor3 = Color3.fromRGB(225,225,225)
            B.TextSize = 12
            B.Font = Enum.Font.Gotham
            B.BorderSizePixel = 0
            B.Parent = PlayerList

            B.MouseButton1Click:Connect(function()
                PlayClick()
                SelectedPlayer = plr
                for _,x in ipairs(PlayerList:GetChildren()) do
                    if x:IsA("TextButton") then x.BackgroundColor3 = Color3.fromRGB(35,35,35) end
                end
                B.BackgroundColor3 = Color3.fromRGB(30,100,60)
            end)
        end
    end
end

RefreshPlayerList()

Players.PlayerAdded:Connect(function() task.wait(.5) RefreshPlayerList() end)
Players.PlayerRemoving:Connect(function(plr)
    if SelectedPlayer == plr then SelectedPlayer = nil end
    RefreshPlayerList()
end)

local function TPToCharacter(character,offset)
    if not character then return end
    local targetRoot = character:FindFirstChild("HumanoidRootPart")
    local myChar = LP.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if targetRoot and myRoot then myRoot.CFrame = targetRoot.CFrame * offset end
end

local function TPButton(text,callback)
    local B = Instance.new("TextButton")
    B.Size = UDim2.new(1,-20,0,40)
    B.BackgroundColor3 = Color3.fromRGB(35,35,35)
    B.Text = text
    B.TextColor3 = Color3.fromRGB(230,230,230)
    B.TextSize = 13
    B.Font = Enum.Font.GothamBold
    B.BorderSizePixel = 0
    B.Parent = TPPage

    B.MouseButton1Click:Connect(function()
        PlayClick()
        callback()
    end)
    return B
end

TPButton("📍 TP al jugador seleccionado",function()
    if SelectedPlayer and SelectedPlayer.Character then TPToCharacter(SelectedPlayer.Character, CFrame.new(0,0,-3)) end
end)

TPButton("↩ TP detrás",function()
    if SelectedPlayer and SelectedPlayer.Character then TPToCharacter(SelectedPlayer.Character, CFrame.new(0,0,4)) end
end)

TPButton("⬆ TP encima",function()
    if SelectedPlayer and SelectedPlayer.Character then TPToCharacter(SelectedPlayer.Character, CFrame.new(0,6,0)) end
end)

TPButton("🎯 TP al jugador más cercano",function()
    local closest = GetClosestPlayer()
    if closest and closest.Character then
        SelectedPlayer = closest
        RefreshPlayerList()
        TPToCharacter(closest.Character, CFrame.new(0,0,-3))
    end
end)

--==================================================
-- AJUSTES Y MÚSICA DE FONDO
--==================================================

Label(SettingsPage,"🎵 REPRODUCTOR DE MÚSICA")

local TrackLabel = Instance.new("TextLabel")
TrackLabel.Size = UDim2.new(1,-20,0,22)
TrackLabel.BackgroundTransparency = 1
TrackLabel.Text = "Pista: "..MusicPlaylist[CurrentTrackIndex].Name
TrackLabel.TextColor3 = Color3.fromRGB(116,190,230)
TrackLabel.TextSize = 13
TrackLabel.Font = Enum.Font.GothamBold
TrackLabel.TextXAlignment = Enum.TextXAlignment.Left
TrackLabel.Parent = SettingsPage

local AudioControls = Instance.new("Frame")
AudioControls.Size = UDim2.new(1,-20,0,38)
AudioControls.BackgroundTransparency = 1
AudioControls.Parent = SettingsPage

local AudioLayout = Instance.new("UIListLayout")
AudioLayout.FillDirection = Enum.FillDirection.Horizontal
AudioLayout.Padding = UDim.new(0,6)
AudioLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
AudioLayout.Parent = AudioControls

local PlayBtn = Instance.new("TextButton")
PlayBtn.Size = UDim2.new(0,100,1,0)
PlayBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
PlayBtn.Text = "▶ Play"
PlayBtn.TextColor3 = Color3.fromRGB(230,230,230)
PlayBtn.TextSize = 13
PlayBtn.Font = Enum.Font.GothamBold
PlayBtn.BorderSizePixel = 0
PlayBtn.Parent = AudioControls

local PauseBtn = Instance.new("TextButton")
PauseBtn.Size = UDim2.new(0,100,1,0)
PauseBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
PauseBtn.Text = "⏸ Pausa"
PauseBtn.TextColor3 = Color3.fromRGB(230,230,230)
PauseBtn.TextSize = 13
PauseBtn.Font = Enum.Font.GothamBold
PauseBtn.BorderSizePixel = 0
PauseBtn.Parent = AudioControls

local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0,110,1,0)
NextBtn.BackgroundColor3 = Color3.fromRGB(35,35,35)
NextBtn.Text = "⏭ Siguiente"
NextBtn.TextColor3 = Color3.fromRGB(230,230,230)
NextBtn.TextSize = 13
NextBtn.Font = Enum.Font.GothamBold
NextBtn.BorderSizePixel = 0
NextBtn.Parent = AudioControls

local function LoadTrack(index)
    CurrentTrackIndex = index
    BGM.SoundId = MusicPlaylist[index].Id
    TrackLabel.Text = "Pista: "..MusicPlaylist[index].Name
end

LoadTrack(CurrentTrackIndex)

PlayBtn.MouseButton1Click:Connect(function() PlayClick() BGM:Play() end)
PauseBtn.MouseButton1Click:Connect(function() PlayClick() BGM:Pause() end)
NextBtn.MouseButton1Click:Connect(function()
    PlayClick()
    local nextIndex = CurrentTrackIndex + 1
    if nextIndex > #MusicPlaylist then nextIndex = 1 end
    LoadTrack(nextIndex)
    BGM:Play()
end)

Slider(SettingsPage,"Volumen Música",0,100,MusicVolume * 100,function(v)
    MusicVolume = v / 100
    BGM.Volume = MusicVolume
end)

Label(SettingsPage,"⚙ CONFIGURACIÓN GENERAL")
Toggle(SettingsPage,"🔊 Efectos de Sonido (UI SFX)",function(v) UISfxEnabled = v end)

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1,-20,0,90)
Info.BackgroundTransparency = 1
Info.Text = "🇦🇷 S0MBRA 2.4 - Sistema Completo\n\n• Visuales: ESP rojo con trazado de líneas\n• Combat: Auto LookAt & Target Marker\n• Audio: Reproductor de BGM integrado\n• Versión de interfaz: 2.4"
Info.TextColor3 = Color3.fromRGB(180,180,180)
Info.TextSize = 12
Info.Font = Enum.Font.Gotham
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.TextYAlignment = Enum.TextYAlignment.Top
Info.Parent = SettingsPage

--==================================================
-- ESP SISTEMA
--==================================================

local ESPData = {}

local function RemoveESP(plr)
    local data = ESPData[plr]
    if not data then return end
    if data.Highlight then data.Highlight:Destroy() end
    if data.Billboard then data.Billboard:Destroy() end
    if data.Attachment0 then data.Attachment0:Destroy() end
    if data.Attachment1 then data.Attachment1:Destroy() end
    if data.Beam then data.Beam:Destroy() end
    ESPData[plr] = nil
end

local function CreateESP(plr)
    if plr == LP then return end
    local char = plr.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local myChar = LP.Character
    if not root or not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local data = ESPData[plr]
    if data and data.Character == char then return end

    RemoveESP(plr)

    local Highlight = Instance.new("Highlight")
    Highlight.Name = "S0mbraDetected"
    Highlight.FillColor = Color3.fromRGB(255,0,0)
    Highlight.OutlineColor = Color3.fromRGB(255,0,0)
    Highlight.FillTransparency = .45
    Highlight.OutlineTransparency = 0
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Highlight.Adornee = char
    Highlight.Parent = char

    local Billboard = Instance.new("BillboardGui")
    Billboard.Name = "S0mbraName"
    Billboard.Adornee = root
    Billboard.Size = UDim2.new(0,220,0,55)
    Billboard.StudsOffset = Vector3.new(0,3.5,0)
    Billboard.AlwaysOnTop = true
    Billboard.MaxDistance = ESPDistance
    Billboard.Parent = root

    local Text = Instance.new("TextLabel")
    Text.Size = UDim2.new(1,0,1,0)
    Text.BackgroundTransparency = 1
    Text.TextColor3 = Color3.fromRGB(255,170,170)
    Text.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    Text.TextStrokeTransparency = 0
    Text.TextSize = 13
    Text.Font = Enum.Font.GothamBold
    Text.TextWrapped = true
    Text.Parent = Billboard

    local Attachment0 = Instance.new("Attachment")
    Attachment0.Parent = myRoot
    local Attachment1 = Instance.new("Attachment")
    Attachment1.Parent = root

    local Beam = Instance.new("Beam")
    Beam.Attachment0 = Attachment0
    Beam.Attachment1 = Attachment1
    Beam.Width0 = .10
    Beam.Width1 = .10
    Beam.Color = ColorSequence.new(Color3.fromRGB(0,255,70))
    Beam.Transparency = NumberSequence.new(0)
    Beam.FaceCamera = true
    Beam.LightEmission = 1
    Beam.Segments = 1
    Beam.Parent = myRoot

    ESPData[plr] = {
        Character = char,
        Highlight = Highlight,
        Billboard = Billboard,
        Text = Text,
        Attachment0 = Attachment0,
        Attachment1 = Attachment1,
        Beam = Beam
    }
end

local function UpdateESP()
    local myChar = LP.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    if not ESPEnabled then
        for plr in pairs(ESPData) do RemoveESP(plr) end
        return
    end

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local distance = (root.Position-myRoot.Position).Magnitude
                if distance <= ESPDistance then
                    CreateESP(plr)
                    local data = ESPData[plr]
                    if data then
                        data.Text.Text = "🔴 "..plr.DisplayName.."\n@"..plr.Name.." ["..math.floor(distance).."m]"
                        data.Billboard.MaxDistance = ESPDistance
                        data.Beam.Enabled = true
                        data.Highlight.Enabled = true
                    end
                else
                    local data = ESPData[plr]
                    if data then
                        data.Beam.Enabled = false
                        data.Highlight.Enabled = false
                        data.Billboard.Enabled = false
                    end
                end
            else
                RemoveESP(plr)
            end
        end
    end
end

task.spawn(function()
    while Gui.Parent do
        UpdateESP()
        task.wait(.15)
    end
end)

Players.PlayerRemoving:Connect(function(plr) RemoveESP(plr) end)

--==================================================
-- LOOP PRINCIPAL (COMBAT Y MOVIMIENTO)
--==================================================

local activeTargetHighlight = nil

RunService.Heartbeat:Connect(function()
    local char = LP.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not hum or not myRoot then return end

    if SpeedEnabled then hum.WalkSpeed = SpeedValue else hum.WalkSpeed = 16 end
    if JumpEnabled then hum.UseJumpPower = true hum.JumpPower = JumpValue else hum.UseJumpPower = true hum.JumpPower = 50 end

    if NoclipEnabled then
        for _,part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end

    local closestPlr = GetClosestPlayer()

    if TargetIndicatorEnabled and closestPlr and closestPlr.Character then
        local tChar = closestPlr.Character
        if activeTargetHighlight and activeTargetHighlight.Parent ~= tChar then
            activeTargetHighlight:Destroy()
            activeTargetHighlight = nil
        end

        if not activeTargetHighlight then
            local H = Instance.new("Highlight")
            H.Name = "S0mbraClosestHighlight"
            H.FillColor = Color3.fromRGB(255,215,0)
            H.OutlineColor = Color3.fromRGB(255,255,255)
            H.FillTransparency = .5
            H.OutlineTransparency = 0
            H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            H.Parent = tChar
            activeTargetHighlight = H
        end
    else
        if activeTargetHighlight then
            activeTargetHighlight:Destroy()
            activeTargetHighlight = nil
        end
    end

    if AutoAimEnabled and closestPlr and closestPlr.Character then
        local tRoot = closestPlr.Character:FindFirstChild("HumanoidRootPart")
        if tRoot then
            local targetPos = Vector3.new(tRoot.Position.X, myRoot.Position.Y, tRoot.Position.Z)
            myRoot.CFrame = CFrame.new(myRoot.Position, targetPos)
        end
    end
end)

--==================================================
-- FLY LOOP
--==================================================

RunService.RenderStepped:Connect(function()
    if not FlyEnabled then return end
    local char = LP.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    local cam = workspace.CurrentCamera
    if not root or not hum or not cam then return end

    local move = Vector3.zero
    if hum.MoveDirection.Magnitude > 0 then
        move = cam.CFrame.LookVector * hum.MoveDirection.Z + cam.CFrame.RightVector * hum.MoveDirection.X
    end

    if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move += Vector3.new(0,-1,0) end

    if move.Magnitude > 0 then
        root.AssemblyLinearVelocity = move.Unit * FlySpeed
    else
        root.AssemblyLinearVelocity = Vector3.zero
    end
end)

--==================================================
-- RESPAWN & SELF HIGHLIGHT
--==================================================

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    if SelfHighlightEnabled then
        local old = char:FindFirstChild("S0mbraSelfHighlight")
        if not old then
            local H = Instance.new("Highlight")
            H.Name = "S0mbraSelfHighlight"
            H.FillColor = Color3.fromRGB(255,0,0)
            H.OutlineColor = Color3.fromRGB(255,0,0)
            H.FillTransparency = .65
            H.OutlineTransparency = 0
            H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            H.Parent = char
        end
    end
end)

--==================================================
-- MINIMIZAR Y CERRAR
--==================================================

local minimized = false
local normalSize = Main.Size

Minimize.MouseButton1Click:Connect(function()
    PlayClick()
    minimized = not minimized
    if minimized then
        Main.Size = UDim2.new(0,520,0,40)
        Tabs.Visible = false
        Pages.Visible = false
        BottomArgentina.Visible = false
    else
        Main.Size = normalSize
        Tabs.Visible = true
        Pages.Visible = true
        BottomArgentina.Visible = true
    end
end)

Close.MouseButton1Click:Connect(function()
    PlayClick()
    BGM:Destroy()
    ClickSFX:Destroy()
    Gui:Destroy()
end)
