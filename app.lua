-- Nars Edv | Plugin app
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local executorEnv = getfenv()

local function resolveHost()
    local getHiddenUi = executorEnv.gethui or executorEnv.get_hidden_gui
    if type(getHiddenUi) == "function" then
        local ok, hidden = pcall(getHiddenUi)
        if ok and typeof(hidden) == "Instance" then
            return hidden
        end
    end
    local okCore, coreGui = pcall(function()
        return game:GetService("CoreGui")
    end)
    if okCore and typeof(coreGui) == "Instance" then
        local testFolder = Instance.new("Folder")
        local canParent = pcall(function()
            testFolder.Parent = coreGui
            testFolder.Parent = nil
            testFolder:Destroy()
        end)
        if canParent then
            return coreGui
        end
    end
    local player = Players.LocalPlayer
    if not player then
        pcall(function()
            Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
            player = Players.LocalPlayer
        end)
    end
    if player then
        local pGui = player:FindFirstChild("PlayerGui") or player:WaitForChild("PlayerGui", 5)
        if pGui then
            return pGui
        end
    end
    return game:GetService("CoreGui")
end

local host = resolveHost()
local GUI = {}

local function generateName()
    local bytes = {}
    for i = 1, 32 do
        bytes[i] = string.char(math.random(65, 90))
    end
    return "_NarsEdv_" .. table.concat(bytes)
end

pcall(function()
    for _, child in ipairs(host:GetChildren()) do
        if child.Name:sub(1, 9) == "_NarsEdv_" or child.Name:sub(1, 6) == "_Lyth_" or child.Name == "NARS_Coverflow" then
            child:Destroy()
        end
    end
end)

local function SafeFont(name)
    local ok, font = pcall(function()
        return Enum.Font[name]
    end)
    return ok and font or Enum.Font.GothamMedium
end

local Medium = SafeFont("GothamMedium")

local Assets = {
    ArrowLeft = "rbxassetid://73780377692148",
    ArrowRight = "rbxassetid://92473583511724",
    Banner = "rbxassetid://123479937842693",
    Close = "rbxassetid://84895399304975",
    Open = "rbxassetid://100744567525223",
    Discord = "rbxassetid://109798031608756"
}

local Plugins = {
    {
        Name = "Store Roblox Asset",
        Description = "Search asset store all Category Roblox models, audios, animations and assets.",
        Version = "1.4.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Store.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(16, 185, 129),
            Color3.fromRGB(5, 100, 70),
            Color3.fromRGB(3, 40, 28)
        },
        ButtonColor = Color3.fromRGB(52, 211, 153),
        ButtonTextColor = Color3.fromRGB(4, 30, 20)
    },
    {
        Name = "Terrain Editor",
        Description = "Voxel terrain sculpting, procedural biome generation and brush tools.",
        Version = "2.1.0",
        Url = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/terrain2.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(34, 197, 94),
            Color3.fromRGB(21, 128, 61),
            Color3.fromRGB(15, 60, 30)
        },
        ButtonColor = Color3.fromRGB(74, 222, 128),
        ButtonTextColor = Color3.fromRGB(5, 35, 15)
    },
    {
        Name = "Ecode Editor",
        Description = "Lightweight code editor for Lua/Luau script development with syntax auto-complete.",
        Version = "4.2.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Ecode.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(168, 85, 247),
            Color3.fromRGB(88, 28, 135),
            Color3.fromRGB(28, 12, 48)
        },
        ButtonColor = Color3.fromRGB(216, 180, 254),
        ButtonTextColor = Color3.fromRGB(25, 10, 42)
    },
    {
        Name = "FlyCameraFocus",
        Description = "FlyCameraFokus controller with target anchor focus.",
        Version = "1.2.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/FlyCameraFokus.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(99, 102, 241),
            Color3.fromRGB(49, 46, 129),
            Color3.fromRGB(15, 23, 42)
        },
        ButtonColor = Color3.fromRGB(165, 180, 252),
        ButtonTextColor = Color3.fromRGB(15, 23, 42)
    },
    {
        Name = "FlyGui",
        Description = "Fly caracter utility with speed controls.",
        Version = "2.0.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/FlyCaracter.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(245, 158, 11),
            Color3.fromRGB(146, 64, 14),
            Color3.fromRGB(48, 22, 6)
        },
        ButtonColor = Color3.fromRGB(252, 211, 77),
        ButtonTextColor = Color3.fromRGB(36, 18, 4)
    },
    {
        Name = "File Importer",
        Description = "Directly import and parse model data from .rbxm, .rbxl, and .rbxlx files.",
        Version = "1.5.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Importer.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(249, 115, 22),
            Color3.fromRGB(154, 52, 18),
            Color3.fromRGB(55, 19, 9)
        },
        ButtonColor = Color3.fromRGB(253, 186, 116),
        ButtonTextColor = Color3.fromRGB(40, 15, 5)
    },
    {
        Name = "Lucide Icon",
        Description = "Search and insert 1000+ vector Lucide icons directly into Roblox UI.",
        Version = "1.1.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/lucideIcons.lua",
        Thumbnail = "rbxassetid://123479937842693",
        Colors = {
            Color3.fromRGB(244, 63, 94),
            Color3.fromRGB(159, 18, 57),
            Color3.fromRGB(60, 8, 22)
        },
        ButtonColor = Color3.fromRGB(253, 164, 175),
        ButtonTextColor = Color3.fromRGB(38, 5, 14)
    }
}

local function applyCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.Name = "UICorner"
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function applyShadow(parent, blurRadius, offset, transparency)
    local ok, shadow = pcall(function()
        local s = Instance.new("UIShadow")
        s.Name = "UIShadow"
        s.ZIndex = -1
        s.BlurRadius = UDim.new(0, blurRadius or 12)
        s.Color = Color3.fromRGB(0, 0, 0)
        s.Enabled = true
        s.Offset = offset or UDim2.fromOffset(0, 4)
        s.Spread = UDim2.fromScale(0, 0)
        s.Transparency = transparency or 0.5
        s.Parent = parent
        return s
    end)
    if not ok or not shadow then
        pcall(function()
            local img = Instance.new("ImageLabel")
            img.Name = generateName()
            img.AnchorPoint = Vector2.new(0.5, 0.5)
            img.Position = UDim2.new(0.5, 0, 0.5, 3)
            img.Size = UDim2.new(1, 24, 1, 24)
            img.BackgroundTransparency = 1
            img.Image = "rbxassetid://1316045217"
            img.ImageColor3 = Color3.fromRGB(0, 0, 0)
            img.ImageTransparency = transparency or 0.5
            img.ScaleType = Enum.ScaleType.Slice
            img.SliceCenter = Rect.new(10, 10, 118, 118)
            img.ZIndex = math.max(0, (parent.ZIndex or 1) - 1)
            img.Parent = parent.Parent
        end)
    end
end

local function applyGradient(parent, colors, rotation)
    local grad = Instance.new("UIGradient")
    grad.Name = generateName()
    grad.Rotation = rotation or 135
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, colors[1]),
        ColorSequenceKeypoint.new(0.5, colors[2]),
        ColorSequenceKeypoint.new(1, colors[3])
    })
    grad.Parent = parent
    return grad
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = generateName()
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local parented = pcall(function()
    ScreenGui.Parent = host
end)
if not parented then
    pcall(function()
        local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
        ScreenGui.Parent = player:WaitForChild("PlayerGui")
    end)
end

local Main = Instance.new("Frame")
Main.Name = generateName()
Main.Size = UDim2.new(0, 420, 0, 320)
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(13, 14, 18)
Main.BackgroundTransparency = 0.05
Main.BorderSizePixel = 0
Main.ClipsDescendants = false
Main.Parent = ScreenGui

applyCorner(Main, 14)
applyShadow(Main, 16, UDim2.fromOffset(0, 6), 0.45)

local MainScale = Instance.new("UIScale")
MainScale.Name = generateName()
MainScale.Scale = 1.0
MainScale.Parent = Main

local userScaleFactor = 1.0
local currentTargetScale = 1.0
local IsOpen = true

local function recalculateScale()
    local cam = workspace.CurrentCamera
    local responsiveScale = 1.0
    if cam and cam.ViewportSize and cam.ViewportSize.X > 0 and cam.ViewportSize.Y > 0 then
        local vp = cam.ViewportSize
        local minFit = math.min(vp.X / 460, vp.Y / 360)
        if minFit < 1.0 then
            responsiveScale = math.clamp(minFit, 0.6, 1.0)
        else
            responsiveScale = 1.0
        end
    end
    currentTargetScale = responsiveScale * userScaleFactor
    MainScale.Scale = currentTargetScale
end

pcall(function()
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(recalculateScale)
end)
recalculateScale()

local MainBanner = Instance.new("ImageLabel")
MainBanner.Name = generateName()
MainBanner.Size = UDim2.new(1, 0, 1, 0)
MainBanner.BackgroundTransparency = 1
MainBanner.Image = Assets.Banner
MainBanner.ImageTransparency = 0.58
MainBanner.ScaleType = Enum.ScaleType.Crop
MainBanner.ZIndex = 0
MainBanner.Parent = Main
applyCorner(MainBanner, 14)

local Overlay = Instance.new("Frame")
Overlay.Name = generateName()
Overlay.Size = UDim2.new(1, 0, 1, 0)
Overlay.BackgroundColor3 = Color3.fromRGB(10, 11, 15)
Overlay.BackgroundTransparency = 0.22
Overlay.BorderSizePixel = 0
Overlay.ZIndex = 1
Overlay.Parent = Main
applyCorner(Overlay, 14)

applyGradient(Overlay, {
    Color3.fromRGB(28, 30, 40),
    Color3.fromRGB(13, 14, 18),
    Color3.fromRGB(8, 9, 12)
}, 90)

local Header = Instance.new("Frame")
Header.Name = generateName()
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundTransparency = 1
Header.ZIndex = 10
Header.Parent = Main

local TitleContainer = Instance.new("Frame")
TitleContainer.Name = generateName()
TitleContainer.Size = UDim2.new(1, -210, 1, 0)
TitleContainer.Position = UDim2.fromOffset(12, 0)
TitleContainer.BackgroundTransparency = 1
TitleContainer.ZIndex = 11
TitleContainer.Parent = Header

local TitleLayout = Instance.new("UIListLayout")
TitleLayout.Name = generateName()
TitleLayout.FillDirection = Enum.FillDirection.Horizontal
TitleLayout.SortOrder = Enum.SortOrder.LayoutOrder
TitleLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TitleLayout.Padding = UDim.new(0, 5)
TitleLayout.Parent = TitleContainer

local TitleMain = Instance.new("TextLabel")
TitleMain.Name = generateName()
TitleMain.LayoutOrder = 1
TitleMain.AutomaticSize = Enum.AutomaticSize.X
TitleMain.Size = UDim2.fromOffset(0, 38)
TitleMain.BackgroundTransparency = 1
TitleMain.Text = "NarsEdv"
TitleMain.TextColor3 = Color3.fromRGB(245, 246, 250)
TitleMain.TextSize = 14
TitleMain.Font = Medium
TitleMain.TextXAlignment = Enum.TextXAlignment.Left
TitleMain.ZIndex = 11
TitleMain.Parent = TitleContainer

local TitleDivider = Instance.new("Frame")
TitleDivider.Name = generateName()
TitleDivider.LayoutOrder = 2
TitleDivider.Size = UDim2.fromOffset(1, 13)
TitleDivider.BackgroundColor3 = Color3.fromRGB(110, 115, 135)
TitleDivider.BackgroundTransparency = 0.35
TitleDivider.BorderSizePixel = 0
TitleDivider.ZIndex = 11
TitleDivider.Parent = TitleContainer

local TitleSub = Instance.new("TextLabel")
TitleSub.Name = generateName()
TitleSub.LayoutOrder = 3
TitleSub.AutomaticSize = Enum.AutomaticSize.X
TitleSub.Size = UDim2.fromOffset(0, 38)
TitleSub.BackgroundTransparency = 1
TitleSub.Text = "Plugin"
TitleSub.TextColor3 = Color3.fromRGB(180, 185, 200)
TitleSub.TextSize = 14
TitleSub.Font = Medium
TitleSub.TextXAlignment = Enum.TextXAlignment.Left
TitleSub.ZIndex = 11
TitleSub.Parent = TitleContainer

local DiscordButton = Instance.new("ImageButton")
DiscordButton.Name = generateName()
DiscordButton.AnchorPoint = Vector2.new(1, 0.5)
DiscordButton.Position = UDim2.new(1, -38, 0.5, 0)
DiscordButton.Size = UDim2.fromOffset(140, 22)
DiscordButton.BackgroundColor3 = Color3.fromRGB(59, 130, 246)
DiscordButton.BorderSizePixel = 0
DiscordButton.AutoButtonColor = false
DiscordButton.ZIndex = 12
DiscordButton.Parent = Header
applyCorner(DiscordButton, 6)

local DiscordGradient = Instance.new("UIGradient")
DiscordGradient.Name = generateName()
DiscordGradient.Rotation = 90
DiscordGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(59, 130, 246)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 92, 246))
})
DiscordGradient.Parent = DiscordButton

local DiscordPadding = Instance.new("UIPadding")
DiscordPadding.Name = generateName()
DiscordPadding.PaddingLeft = UDim.new(0, 8)
DiscordPadding.PaddingRight = UDim.new(0, 8)
DiscordPadding.Parent = DiscordButton

local DiscordLayout = Instance.new("UIListLayout")
DiscordLayout.Name = generateName()
DiscordLayout.FillDirection = Enum.FillDirection.Horizontal
DiscordLayout.SortOrder = Enum.SortOrder.LayoutOrder
DiscordLayout.VerticalAlignment = Enum.VerticalAlignment.Center
DiscordLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
DiscordLayout.Padding = UDim.new(0, 6)
DiscordLayout.Parent = DiscordButton

local DiscordIcon = Instance.new("ImageLabel")
DiscordIcon.Name = generateName()
DiscordIcon.LayoutOrder = 1
DiscordIcon.Size = UDim2.fromOffset(14, 14)
DiscordIcon.BackgroundTransparency = 1
DiscordIcon.Image = Assets.Discord
DiscordIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
DiscordIcon.ScaleType = Enum.ScaleType.Fit
DiscordIcon.ZIndex = 13
DiscordIcon.Parent = DiscordButton

local DiscordText = Instance.new("TextLabel")
DiscordText.Name = generateName()
DiscordText.LayoutOrder = 2
DiscordText.Size = UDim2.fromOffset(0, 22)
DiscordText.AutomaticSize = Enum.AutomaticSize.X
DiscordText.BackgroundTransparency = 1
DiscordText.Text = "discord.gg/NarsEdv"
DiscordText.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordText.TextSize = 11
DiscordText.Font = Medium
DiscordText.ZIndex = 13
DiscordText.Parent = DiscordButton

local discordInviteUrl = "https://discord.gg/6GmpsmNvY"

DiscordButton.MouseEnter:Connect(function()
    TweenService:Create(DiscordButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(142, 23)
    }):Play()
end)

DiscordButton.MouseLeave:Connect(function()
    TweenService:Create(DiscordButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(140, 22)
    }):Play()
end)

DiscordButton.MouseButton1Click:Connect(function()
    local setClipboard = executorEnv.setclipboard or executorEnv.toclipboard or executorEnv.set_clipboard
    if not setClipboard and type(executorEnv.Clipboard) == "table" then
        setClipboard = executorEnv.Clipboard.set
    end

    if type(setClipboard) == "function" then
        pcall(setClipboard, discordInviteUrl)
    end

    local original = DiscordText.Text
    DiscordText.Text = "COPIED INVITE!"
    task.delay(1.5, function()
        if DiscordText.Parent then
            DiscordText.Text = original
        end
    end)
end)

local CloseButton = Instance.new("ImageButton")
CloseButton.Name = generateName()
CloseButton.AnchorPoint = Vector2.new(0, 0.5)
CloseButton.Size = UDim2.fromOffset(20, 20)
CloseButton.Position = UDim2.new(1, -30, 0.5, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(13, 14, 18)
CloseButton.BackgroundTransparency = 0
CloseButton.Image = Assets.Close
CloseButton.ImageColor3 = Color3.fromRGB(210, 212, 225)
CloseButton.ScaleType = Enum.ScaleType.Fit
CloseButton.ZIndex = 12
CloseButton.Parent = Header
applyCorner(CloseButton, 6)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(225, 29, 72),
        ImageColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(13, 14, 18),
        ImageColor3 = Color3.fromRGB(210, 212, 225)
    }):Play()
end)

local Stage = Instance.new("Frame")
Stage.Name = generateName()
Stage.Size = UDim2.new(1, -16, 0, 246)
Stage.Position = UDim2.fromOffset(8, 42)
Stage.BackgroundTransparency = 1
Stage.BorderSizePixel = 0
Stage.ClipsDescendants = true
Stage.ZIndex = 2
Stage.Parent = Main

local Current = 1
local Cards = {}
local ActiveTweens = {}

local function createPluginCard(index, plugin)
    local Card = Instance.new("Frame")
    Card.Name = generateName()
    Card.Size = UDim2.fromOffset(180, 236)
    Card.AnchorPoint = Vector2.new(0.5, 0.5)
    Card.Position = UDim2.new(0.5, 0, 0.5, 0)
    Card.BackgroundColor3 = plugin.Colors[2]
    Card.BorderSizePixel = 0
    Card.ClipsDescendants = true
    Card.ZIndex = 2
    Card.Parent = Stage

    applyCorner(Card, 10)
    applyGradient(Card, plugin.Colors, 140)
    applyShadow(Card, 12, UDim2.fromOffset(0, 5), 0.45)

    local Thumbnail = Instance.new("ImageLabel")
    Thumbnail.Name = generateName()
    Thumbnail.Size = UDim2.new(1, 0, 0, 108)
    Thumbnail.Position = UDim2.fromOffset(0, 0)
    Thumbnail.BackgroundColor3 = Color3.fromRGB(15, 17, 23)
    Thumbnail.BackgroundTransparency = 0.2
    Thumbnail.BorderSizePixel = 0
    Thumbnail.Image = plugin.Thumbnail or Assets.Banner
    Thumbnail.ScaleType = Enum.ScaleType.Crop
    Thumbnail.ZIndex = 3
    Thumbnail.Parent = Card

    local ThumbCorner = Instance.new("UICorner")
    ThumbCorner.Name = "UICorner"
    ThumbCorner.CornerRadius = UDim.new(0, 10)
    pcall(function()
        ThumbCorner.TopLeftRadius = UDim.new(0, 10)
        ThumbCorner.TopRightRadius = UDim.new(0, 10)
        ThumbCorner.BottomLeftRadius = UDim.new(0, 0)
        ThumbCorner.BottomRightRadius = UDim.new(0, 0)
    end)
    ThumbCorner.Parent = Thumbnail

    local ThumbOverlay = Instance.new("Frame")
    ThumbOverlay.Name = generateName()
    ThumbOverlay.Size = UDim2.new(1, 0, 0, 28)
    ThumbOverlay.Position = UDim2.new(0, 0, 1, -28)
    ThumbOverlay.BackgroundColor3 = plugin.Colors[3]
    ThumbOverlay.BackgroundTransparency = 0.55
    ThumbOverlay.BorderSizePixel = 0
    ThumbOverlay.ZIndex = 3
    ThumbOverlay.Parent = Thumbnail

    local ThumbGradient = Instance.new("UIGradient")
    ThumbGradient.Rotation = 90
    ThumbGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.75),
        NumberSequenceKeypoint.new(1, 0.55)
    })
    ThumbGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, plugin.Colors[1]),
        ColorSequenceKeypoint.new(1, plugin.Colors[3])
    })
    ThumbGradient.Parent = ThumbOverlay

    local Name = Instance.new("TextLabel")
    Name.Name = generateName()
    Name.Size = UDim2.new(1, -20, 0, 20)
    Name.Position = UDim2.fromOffset(10, 114)
    Name.BackgroundTransparency = 1
    Name.Text = plugin.Name
    Name.TextColor3 = Color3.fromRGB(255, 255, 255)
    Name.TextSize = 13
    Name.Font = Medium
    Name.TextXAlignment = Enum.TextXAlignment.Left
    Name.TextTruncate = Enum.TextTruncate.AtEnd
    Name.ZIndex = 4
    Name.Parent = Card

    local Desc = Instance.new("TextLabel")
    Desc.Name = generateName()
    Desc.Size = UDim2.new(1, -20, 0, 34)
    Desc.Position = UDim2.fromOffset(10, 136)
    Desc.BackgroundTransparency = 1
    Desc.Text = plugin.Description
    Desc.TextColor3 = Color3.fromRGB(168, 174, 192)
    Desc.TextSize = 12
    Desc.Font = Medium
    Desc.TextWrapped = true
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.ZIndex = 4
    Desc.Parent = Card

    local Ver = Instance.new("TextLabel")
    Ver.Name = generateName()
    Ver.Size = UDim2.new(1, -20, 0, 14)
    Ver.Position = UDim2.fromOffset(10, 172)
    Ver.BackgroundTransparency = 1
    Ver.Text = "BUILD " .. plugin.Version
    Ver.TextColor3 = Color3.fromRGB(130, 136, 154)
    Ver.TextSize = 10
    Ver.Font = Medium
    Ver.TextXAlignment = Enum.TextXAlignment.Left
    Ver.ZIndex = 4
    Ver.Parent = Card

    local Execute = Instance.new("TextButton")
    Execute.Name = generateName()
    Execute.Size = UDim2.new(1, -20, 0, 26)
    Execute.Position = UDim2.new(0, 10, 1, -36)
    Execute.BackgroundColor3 = plugin.ButtonColor or Color3.fromRGB(240, 242, 248)
    Execute.BorderSizePixel = 0
    Execute.Text = "EXECUTE"
    Execute.TextColor3 = plugin.ButtonTextColor or Color3.fromRGB(15, 17, 23)
    Execute.TextSize = 12
    Execute.Font = Medium
    Execute.AutoButtonColor = false
    Execute.ZIndex = 6
    Execute.Parent = Card
    applyCorner(Execute, 6)

    Card.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if Current ~= index then
                GUI:GoTo(index)
            end
        end
    end)

    Execute.MouseEnter:Connect(function()
        TweenService:Create(Execute, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)

    Execute.MouseLeave:Connect(function()
        TweenService:Create(Execute, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = plugin.ButtonColor or Color3.fromRGB(240, 242, 248)
        }):Play()
    end)

    Execute.MouseButton1Click:Connect(function()
        TweenService:Create(Execute, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, -24, 0, 24),
            Position = UDim2.new(0, 12, 1, -35)
        }):Play()
        task.delay(0.08, function()
            if Execute.Parent then
                TweenService:Create(Execute, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(1, -20, 0, 26),
                    Position = UDim2.new(0, 10, 1, -36)
                }):Play()
            end
        end)

        if not plugin.Url or plugin.Url == "" then
            Execute.Text = "NO URL"
            task.delay(1.5, function()
                if Execute.Parent then
                    Execute.Text = "EXECUTE"
                end
            end)
            return
        end

        Execute.Text = "EXECUTING..."
        task.spawn(function()
            local success, result = pcall(function()
                assert(type(loadstring) == "function", "loadstring unavailable")
                local source = game:HttpGet(plugin.Url)
                local compiled, compileErr = loadstring(source)
                assert(compiled, compileErr or "Compile failed")
                return compiled()
            end)

            if success then
                Execute.Text = "SUCCESS"
            else
                warn("[NarsEdv ERROR] " .. tostring(plugin.Name) .. ": " .. tostring(result))
                Execute.Text = "FAILED"
            end

            task.wait(1.8)
            if Execute.Parent then
                Execute.Text = "EXECUTE"
            end
        end)
    end)

    Cards[index] = Card
end

for i, plugin in ipairs(Plugins) do
    createPluginCard(i, plugin)
end

local Footer = Instance.new("Frame")
Footer.Name = generateName()
Footer.Size = UDim2.new(1, 0, 0, 30)
Footer.Position = UDim2.new(0, 0, 1, -30)
Footer.BackgroundTransparency = 1
Footer.ZIndex = 8
Footer.Parent = Main

local Counter = Instance.new("TextLabel")
Counter.Name = generateName()
Counter.Size = UDim2.fromOffset(90, 20)
Counter.Position = UDim2.new(0.5, 0, 0.5, 0)
Counter.AnchorPoint = Vector2.new(0.5, 0.5)
Counter.BackgroundTransparency = 1
Counter.TextColor3 = Color3.fromRGB(180, 185, 200)
Counter.TextSize = 12
Counter.Font = Medium
Counter.ZIndex = 9
Counter.Parent = Footer

local function updateCounter()
    Counter.Text = string.format("%02d  /  %02d", Current, #Plugins)
end

local function getOffset(index)
    local total = #Plugins
    return ((index - Current + math.floor(total / 2)) % total) - math.floor(total / 2)
end

local function updateCarousel(animated)
    for i, Card in ipairs(Cards) do
        local offset = getOffset(i)
        local distance = math.abs(offset)

        if ActiveTweens[Card] then
            ActiveTweens[Card]:Cancel()
            ActiveTweens[Card] = nil
        end

        if distance > 2 then
            if animated and Card.Visible then
                local hideTween = TweenService:Create(
                    Card,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    { BackgroundTransparency = 1 }
                )
                hideTween:Play()
                hideTween.Completed:Connect(function()
                    if math.abs(getOffset(i)) > 2 then
                        Card.Visible = false
                    end
                end)
            else
                Card.Visible = false
            end
        else
            Card.Visible = true

            local width = offset == 0 and 180 or (distance == 1 and 148 or 118)
            local height = offset == 0 and 236 or (distance == 1 and 194 or 156)
            local xOffset = offset * 110
            local rotation = offset * 11
            local zIndex = 25 - distance * 5
            local transparency = offset == 0 and 0 or (distance == 1 and 0.12 or 0.38)

            Card.ZIndex = zIndex
            for _, child in ipairs(Card:GetChildren()) do
                if child:IsA("GuiObject") and child.Name ~= "UIShadow" then
                    child.ZIndex = zIndex + 1
                end
            end

            local targetProps = {
                Position = UDim2.new(0.5, xOffset, 0.5, 0),
                Size = UDim2.fromOffset(width, height),
                Rotation = rotation,
                BackgroundTransparency = transparency
            }

            if animated then
                local tween = TweenService:Create(
                    Card,
                    TweenInfo.new(0.42, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out),
                    targetProps
                )
                ActiveTweens[Card] = tween
                tween:Play()
                tween.Completed:Connect(function()
                    if ActiveTweens[Card] == tween then
                        ActiveTweens[Card] = nil
                    end
                end)
            else
                Card.Position = targetProps.Position
                Card.Size = targetProps.Size
                Card.Rotation = targetProps.Rotation
                Card.BackgroundTransparency = targetProps.BackgroundTransparency
            end
        end
    end
end

local function navigate(direction)
    Current = ((Current - 1 + direction) % #Plugins) + 1
    updateCarousel(true)
    updateCounter()
end

local function createArrow(name, image, position, direction)
    local Button = Instance.new("ImageButton")
    Button.Name = generateName()
    Button.Size = UDim2.fromOffset(22, 22)
    Button.Position = position
    Button.AnchorPoint = Vector2.new(0.5, 0.5)
    Button.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
    Button.BackgroundTransparency = 0.5
    Button.Image = image
    Button.ImageColor3 = Color3.fromRGB(240, 242, 250)
    Button.ScaleType = Enum.ScaleType.Fit
    Button.ZIndex = 45
    Button.Parent = Stage
    applyCorner(Button, 999)

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(38, 42, 58),
            BackgroundTransparency = 0.2,
            ImageColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(20, 22, 30),
            BackgroundTransparency = 0.5,
            ImageColor3 = Color3.fromRGB(240, 242, 250)
        }):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(19, 19)
        }):Play()
        task.delay(0.08, function()
            if Button.Parent then
                TweenService:Create(Button, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.fromOffset(22, 22)
                }):Play()
            end
        end)
        navigate(direction)
    end)

    return Button
end

createArrow("Prev", Assets.ArrowLeft, UDim2.new(0, 16, 0.5, 0), -1)
createArrow("Next", Assets.ArrowRight, UDim2.new(1, -16, 0.5, 0), 1)

local OpenButton = Instance.new("ImageButton")
OpenButton.Name = generateName()
OpenButton.Size = UDim2.fromOffset(30, 30)
OpenButton.Position = UDim2.new(0, 20, 0.5, 0)
OpenButton.AnchorPoint = Vector2.new(0, 0.5)
OpenButton.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
OpenButton.BackgroundTransparency = 0.1
OpenButton.Image = Assets.Open
OpenButton.ImageColor3 = Color3.fromRGB(245, 246, 250)
OpenButton.ScaleType = Enum.ScaleType.Fit
OpenButton.Visible = false
OpenButton.ZIndex = 60
OpenButton.Parent = ScreenGui

applyCorner(OpenButton, 8)
applyShadow(OpenButton, 10, UDim2.fromOffset(0, 3), 0.5)

local function setOpen(state)
    IsOpen = state
    if state then
        Main.Visible = true
        Main.Position = UDim2.new(0.5, 0, 0.5, 15)
        Main.BackgroundTransparency = 1
        MainScale.Scale = currentTargetScale

        TweenService:Create(Main, TweenInfo.new(0.24, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 0.05
        }):Play()

        TweenService:Create(OpenButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1,
            BackgroundTransparency = 1
        }):Play()
        task.delay(0.18, function()
            OpenButton.Visible = false
            OpenButton.ImageTransparency = 0
            OpenButton.BackgroundTransparency = 0.1
        end)
    else
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 0.5, 15),
            BackgroundTransparency = 1
        }):Play()

        task.delay(0.2, function()
            Main.Visible = false
            OpenButton.Visible = true
            OpenButton.BackgroundTransparency = 1
            OpenButton.ImageTransparency = 1
            TweenService:Create(OpenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.1,
                ImageTransparency = 0
            }):Play()
        end)
    end
end

CloseButton.MouseButton1Click:Connect(function()
    setOpen(false)
end)

local OpenDragging = false
local OpenDragStart = nil
local OpenStartPosition = nil
local OpenDragInput = nil
local OpenDragMoved = false

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        OpenDragging = true
        OpenDragMoved = false
        OpenDragStart = input.Position
        OpenStartPosition = OpenButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                OpenDragging = false
            end
        end)
    end
end)

OpenButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        OpenDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if OpenDragging and input == OpenDragInput and OpenDragStart and OpenStartPosition then
        local delta = input.Position - OpenDragStart
        if math.abs(delta.X) > 4 or math.abs(delta.Y) > 4 then
            OpenDragMoved = true
        end
        OpenButton.Position = UDim2.new(
            OpenStartPosition.X.Scale,
            OpenStartPosition.X.Offset + delta.X,
            OpenStartPosition.Y.Scale,
            OpenStartPosition.Y.Offset + delta.Y
        )
    end
end)

OpenButton.MouseButton1Click:Connect(function()
    if not OpenDragMoved then
        setOpen(true)
    end
end)

local MainDragging = false
local MainDragStart = nil
local MainStartPosition = nil
local MainDragInput = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        MainDragging = true
        MainDragStart = input.Position
        MainStartPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                MainDragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        MainDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if MainDragging and input == MainDragInput and MainDragStart and MainStartPosition then
        local delta = input.Position - MainDragStart
        Main.Position = UDim2.new(
            MainStartPosition.X.Scale,
            MainStartPosition.X.Offset + delta.X,
            MainStartPosition.Y.Scale,
            MainStartPosition.Y.Offset + delta.Y
        )
    end
end)

function GUI:GoTo(index)
    Current = math.clamp(index, 1, #Plugins)
    updateCarousel(true)
    updateCounter()
end

function GUI:Next()
    navigate(1)
end

function GUI:Previous()
    navigate(-1)
end

function GUI:Toggle()
    setOpen(not IsOpen)
end

function GUI:SetScale(scaleMultiplier)
    userScaleFactor = math.clamp(scaleMultiplier, 0.5, 2.0)
    recalculateScale()
end

function GUI:Destroy()
    pcall(function()
        ScreenGui:Destroy()
    end)
end

updateCarousel(false)
updateCounter()

return GUI
