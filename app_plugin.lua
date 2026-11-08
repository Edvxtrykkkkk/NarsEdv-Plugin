-- Nars Edv | Plugin app
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local executorEnv = getfenv()
local sharedEnv = executorEnv
if type(executorEnv.getgenv) == "function" then
    local okEnv, genv = pcall(executorEnv.getgenv)
    if okEnv and type(genv) == "table" then
        sharedEnv = genv
    end
end
local registryKey = "__plugin_app_gui"

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

local nameRanges = { { 48, 57 }, { 65, 90 }, { 97, 122 } }

local function generateName()
    local length = math.random(18, 32)
    local bytes = {}
    for i = 1, length do
        local range = nameRanges[math.random(1, #nameRanges)]
        bytes[i] = string.char(math.random(range[1], range[2]))
    end
    return table.concat(bytes)
end

pcall(function()
    local previous = sharedEnv[registryKey]
    if typeof(previous) == "Instance" then
        previous:Destroy()
    end
    sharedEnv[registryKey] = nil
end)

pcall(function()
    for _, child in ipairs(host:GetChildren()) do
        if child.Name:sub(1, 9) == "_NarsEdv_" or child.Name:sub(1, 6) == "_Lyth_" or child.Name == "NARS_Coverflow" then
            child:Destroy()
        end
    end
end)

local function make(class, props, parent)
    local instance = Instance.new(class)
    instance.Name = generateName()
    if instance:IsA("GuiObject") then
        instance.BorderSizePixel = 0
    end
    for key, value in pairs(props) do
        instance[key] = value
    end
    instance.Parent = parent
    return instance
end

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

local PlaceId = 10959918411
local ThumbnailApi = "https://thumbnails.roblox.com/v1/places/gameicons?placeIds="

local Plugins = {
    {
        Name = "Store Roblox Asset",
        Description = "Search asset store all Category Roblox models, audios, animations and assets.",
        Version = "1.4.0",
        Url = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Store.lua",
        Icon = "rbxassetid://135675846264061",
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
        Icon = "rbxassetid://105315495740588",
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
        Icon = "rbxassetid://106783148545356",
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
        Icon = "rbxassetid://134967053164645",
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
        Icon = "rbxassetid://114551690399915",
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
        Icon = "rbxassetid://121435581993566",
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
        Icon = "rbxassetid://130721982350900",
        Colors = {
            Color3.fromRGB(244, 63, 94),
            Color3.fromRGB(159, 18, 57),
            Color3.fromRGB(60, 8, 22)
        },
        ButtonColor = Color3.fromRGB(253, 164, 175),
        ButtonTextColor = Color3.fromRGB(38, 5, 14)
    }
}

local CardWidth = 180
local CardHeight = 196
local SlotSpacing = 110
local White = Color3.fromRGB(255, 255, 255)

local LoopTweens = {}

local function tweenProps(instance, info, props)
    local ok, tween = pcall(TweenService.Create, TweenService, instance, info, props)
    if ok and tween then
        tween:Play()
        return tween
    end
    for key, value in pairs(props) do
        pcall(function()
            instance[key] = value
        end)
    end
    return nil
end

local function loopTween(instance, duration, props)
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        props
    )
    tween:Play()
    table.insert(LoopTweens, tween)
    return tween
end

local function applyCorner(parent, radius)
    return make("UICorner", { CornerRadius = UDim.new(0, radius or 8) }, parent)
end

local function applyShadow(parent, blurRadius, offset, transparency, color)
    local ok, shadow = pcall(function()
        local s = Instance.new("UIShadow")
        s.Name = generateName()
        s.ZIndex = -1
        s.BlurRadius = UDim.new(0, blurRadius or 12)
        s.Color = color or Color3.fromRGB(0, 0, 0)
        s.Enabled = true
        s.Offset = offset or UDim2.fromOffset(0, 4)
        s.Spread = UDim2.fromScale(0, 0)
        s.Transparency = transparency or 0.5
        s.Parent = parent
        return s
    end)
    if ok then
        return shadow
    end
    return nil
end

local function applyGradient(parent, colors, rotation)
    return make("UIGradient", {
        Rotation = rotation or 135,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, colors[1]),
            ColorSequenceKeypoint.new(0.5, colors[2]),
            ColorSequenceKeypoint.new(1, colors[3])
        })
    }, parent)
end

local function bindInteract(button, hoverScale, pressScale)
    local scale = make("UIScale", { Scale = 1 }, button)
    local hovering = false
    local function to(value, duration, style)
        TweenService:Create(scale, TweenInfo.new(duration, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = value
        }):Play()
    end
    button.MouseEnter:Connect(function()
        hovering = true
        to(hoverScale, 0.18)
    end)
    button.MouseLeave:Connect(function()
        hovering = false
        to(1, 0.18)
    end)
    button.MouseButton1Down:Connect(function()
        to(pressScale, 0.08)
    end)
    button.MouseButton1Up:Connect(function()
        to(hovering and hoverScale or 1, 0.16, Enum.EasingStyle.Back)
    end)
    return scale
end

local ThumbCache = {}

local function resolveThumbnail(placeId, callback)
    local entry = ThumbCache[placeId]
    if entry then
        if entry.Done then
            callback(entry.Asset)
        else
            table.insert(entry.Waiters, callback)
        end
        return
    end
    entry = { Done = false, Asset = Assets.Banner, Waiters = { callback } }
    ThumbCache[placeId] = entry
    task.spawn(function()
        for _ = 1, 3 do
            local resolved = nil
            pcall(function()
                local body = game:HttpGet(ThumbnailApi .. placeId .. "&returnPolicy=PlaceHolder&size=512x512&format=Png&isCircular=false")
                local decoded = HttpService:JSONDecode(body)
                local item = decoded and decoded.data and decoded.data[1]
                if item and type(item.imageUrl) == "string" and item.imageUrl ~= "" then
                    local bytes = game:HttpGet(item.imageUrl)
                    local writeFile = executorEnv.writefile
                    local getAsset = executorEnv.getcustomasset or executorEnv.getsynasset
                    if type(writeFile) == "function" and type(getAsset) == "function" then
                        local fileName = "place_thumb_" .. tostring(placeId) .. ".png"
                        writeFile(fileName, bytes)
                        resolved = getAsset(fileName)
                    end
                end
            end)
            if resolved and resolved ~= "" then
                entry.Asset = resolved
                break
            end
            task.wait(1)
        end
        entry.Done = true
        for _, waiter in ipairs(entry.Waiters) do
            pcall(waiter, entry.Asset)
        end
        entry.Waiters = {}
    end)
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
sharedEnv[registryKey] = ScreenGui

local Main = make("Frame", {
    Size = UDim2.fromOffset(420, 292),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(13, 14, 18),
    BackgroundTransparency = 0.05,
    ClipsDescendants = false
}, ScreenGui)

applyCorner(Main, 14)
applyShadow(Main, 16, UDim2.fromOffset(0, 6), 0.45)

local MainScale = make("UIScale", { Scale = 1 }, Main)

local userScaleFactor = 1.0
local currentTargetScale = 1.0
local IsOpen = true

local function recalculateScale()
    local cam = workspace.CurrentCamera
    local responsiveScale = 1.0
    if cam and cam.ViewportSize and cam.ViewportSize.X > 0 and cam.ViewportSize.Y > 0 then
        local vp = cam.ViewportSize
        local minFit = math.min(vp.X / 460, vp.Y / 330)
        if minFit < 1.0 then
            responsiveScale = math.clamp(minFit, 0.6, 1.0)
        end
    end
    currentTargetScale = responsiveScale * userScaleFactor
    MainScale.Scale = currentTargetScale
end

pcall(function()
    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(recalculateScale)
end)
recalculateScale()

local MainBanner = make("ImageLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Image = Assets.Banner,
    ImageTransparency = 0.58,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 0
}, Main)
applyCorner(MainBanner, 14)

local Overlay = make("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(10, 11, 15),
    BackgroundTransparency = 0.22,
    ZIndex = 1
}, Main)
applyCorner(Overlay, 14)

applyGradient(Overlay, {
    Color3.fromRGB(28, 30, 40),
    Color3.fromRGB(13, 14, 18),
    Color3.fromRGB(8, 9, 12)
}, 90)

local Header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 38),
    BackgroundTransparency = 1,
    ZIndex = 10
}, Main)

local TitleContainer = make("Frame", {
    Size = UDim2.new(1, -210, 1, 0),
    Position = UDim2.fromOffset(12, 0),
    BackgroundTransparency = 1,
    ZIndex = 11
}, Header)

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    Padding = UDim.new(0, 6)
}, TitleContainer)

local LogoHolder = make("Frame", {
    LayoutOrder = 1,
    Size = UDim2.fromOffset(20, 38),
    BackgroundTransparency = 1,
    ZIndex = 11
}, TitleContainer)

local Logo = make("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(18, 18),
    BackgroundTransparency = 1,
    Image = Assets.Open,
    ImageColor3 = White,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 12
}, LogoHolder)

loopTween(Logo, 1.1, { Position = UDim2.new(0.5, 0, 0.5, -3) })

local TitleMain = make("TextLabel", {
    LayoutOrder = 2,
    AutomaticSize = Enum.AutomaticSize.X,
    Size = UDim2.fromOffset(0, 38),
    BackgroundTransparency = 1,
    Text = "Nars Edv",
    TextColor3 = White,
    TextSize = 14,
    Font = Medium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11
}, TitleContainer)

loopTween(TitleMain, 1.3, { TextTransparency = 0.55 })

local TitleSub = make("TextLabel", {
    LayoutOrder = 3,
    AutomaticSize = Enum.AutomaticSize.X,
    Size = UDim2.fromOffset(0, 38),
    BackgroundTransparency = 1,
    Text = "Plugin",
    TextColor3 = White,
    TextSize = 14,
    Font = Medium,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 11
}, TitleContainer)

make("UIGradient", {
    Rotation = 0,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(56, 189, 248)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(167, 139, 250)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(244, 114, 182))
    })
}, TitleSub)

local DiscordButton = make("ImageButton", {
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -38, 0.5, 0),
    Size = UDim2.fromOffset(140, 22),
    BackgroundColor3 = Color3.fromRGB(59, 130, 246),
    AutoButtonColor = false,
    ZIndex = 12
}, Header)
applyCorner(DiscordButton, 6)

make("UIGradient", {
    Rotation = 90,
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(59, 130, 246)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(139, 92, 246))
    })
}, DiscordButton)

make("UIPadding", {
    PaddingLeft = UDim.new(0, 8),
    PaddingRight = UDim.new(0, 8)
}, DiscordButton)

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Padding = UDim.new(0, 6)
}, DiscordButton)

make("ImageLabel", {
    LayoutOrder = 1,
    Size = UDim2.fromOffset(14, 14),
    BackgroundTransparency = 1,
    Image = Assets.Discord,
    ImageColor3 = White,
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 13
}, DiscordButton)

local DiscordText = make("TextLabel", {
    LayoutOrder = 2,
    Size = UDim2.fromOffset(0, 22),
    AutomaticSize = Enum.AutomaticSize.X,
    BackgroundTransparency = 1,
    Text = "discord.gg/NarsEdv",
    TextColor3 = White,
    TextSize = 11,
    Font = Medium,
    ZIndex = 13
}, DiscordButton)

local discordInviteUrl = "https://discord.gg/6GmpsmNvY"

bindInteract(DiscordButton, 1.03, 0.96)

DiscordButton.MouseButton1Click:Connect(function()
    local setClipboard = executorEnv.setclipboard or executorEnv.toclipboard or executorEnv.set_clipboard
    if not setClipboard and type(executorEnv.Clipboard) == "table" then
        setClipboard = executorEnv.Clipboard.set
    end

    if type(setClipboard) == "function" then
        pcall(setClipboard, discordInviteUrl)
    end

    local original = "discord.gg/NarsEdv"
    DiscordText.Text = "COPIED INVITE!"
    task.delay(1.5, function()
        if DiscordText.Parent then
            DiscordText.Text = original
        end
    end)
end)

local CloseButton = make("ImageButton", {
    AnchorPoint = Vector2.new(0, 0.5),
    Size = UDim2.fromOffset(20, 20),
    Position = UDim2.new(1, -30, 0.5, 0),
    BackgroundColor3 = Color3.fromRGB(13, 14, 18),
    BackgroundTransparency = 0,
    Image = Assets.Close,
    ImageColor3 = Color3.fromRGB(210, 212, 225),
    ScaleType = Enum.ScaleType.Fit,
    AutoButtonColor = false,
    ZIndex = 12
}, Header)
applyCorner(CloseButton, 6)
bindInteract(CloseButton, 1.1, 0.9)

CloseButton.MouseEnter:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(225, 29, 72),
        ImageColor3 = White
    }):Play()
end)

CloseButton.MouseLeave:Connect(function()
    TweenService:Create(CloseButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(13, 14, 18),
        ImageColor3 = Color3.fromRGB(210, 212, 225)
    }):Play()
end)

local Stage = make("Frame", {
    Size = UDim2.new(1, -16, 0, 226),
    Position = UDim2.fromOffset(8, 38),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 2
}, Main)

local Current = 1
local Cards = {}
local Dots = {}
local ActiveTweens = {}

local function createPluginCard(index, plugin)
    local Card = make("Frame", {
        Size = UDim2.fromOffset(CardWidth, CardHeight),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = plugin.Colors[2],
        ClipsDescendants = true,
        ZIndex = 2
    }, Stage)

    applyCorner(Card, 10)
    applyGradient(Card, plugin.Colors, 140)
    local CardScale = make("UIScale", { Scale = 1 }, Card)
    local CardShadow = applyShadow(Card, 14, UDim2.fromOffset(0, 5), 1, plugin.Colors[1])

    local Thumbnail = make("ImageLabel", {
        Size = UDim2.new(1, 0, 0, 84),
        Position = UDim2.fromOffset(0, 0),
        BackgroundColor3 = Color3.fromRGB(15, 17, 23),
        BackgroundTransparency = 0.2,
        Image = "",
        ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Crop,
        ZIndex = 3
    }, Card)

    local ThumbCorner = make("UICorner", { CornerRadius = UDim.new(0, 10) }, nil)
    pcall(function()
        ThumbCorner.TopLeftRadius = UDim.new(0, 10)
        ThumbCorner.TopRightRadius = UDim.new(0, 10)
        ThumbCorner.BottomLeftRadius = UDim.new(0, 0)
        ThumbCorner.BottomRightRadius = UDim.new(0, 0)
    end)
    ThumbCorner.Parent = Thumbnail

    local ThumbOverlay = make("Frame", {
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 1, -24),
        BackgroundColor3 = plugin.Colors[3],
        BackgroundTransparency = 0.55,
        ZIndex = 4
    }, Thumbnail)

    make("UIGradient", {
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.5, 0.75),
            NumberSequenceKeypoint.new(1, 0.55)
        }),
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, plugin.Colors[1]),
            ColorSequenceKeypoint.new(1, plugin.Colors[3])
        })
    }, ThumbOverlay)

    resolveThumbnail(plugin.PlaceId or PlaceId, function(asset)
        if Thumbnail.Parent then
            Thumbnail.Image = asset
            tweenProps(Thumbnail, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ImageTransparency = 0
            })
        end
    end)

    local hasIcon = type(plugin.Icon) == "string" and plugin.Icon ~= ""
    local nameX = 10

    if hasIcon then
        make("ImageLabel", {
            Size = UDim2.fromOffset(14, 14),
            Position = UDim2.fromOffset(10, 93),
            BackgroundTransparency = 1,
            Image = plugin.Icon,
            ImageColor3 = White,
            ScaleType = Enum.ScaleType.Fit,
            ZIndex = 5
        }, Card)
        nameX = 30
    end

    make("TextLabel", {
        Size = UDim2.new(1, -(nameX + 10), 0, 20),
        Position = UDim2.fromOffset(nameX, 90),
        BackgroundTransparency = 1,
        Text = plugin.Name,
        TextColor3 = White,
        TextSize = 13,
        Font = Medium,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 5
    }, Card)

    make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 28),
        Position = UDim2.fromOffset(10, 112),
        BackgroundTransparency = 1,
        Text = plugin.Description,
        TextColor3 = Color3.fromRGB(168, 174, 192),
        TextSize = 11,
        Font = Medium,
        TextWrapped = true,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        ZIndex = 5
    }, Card)

    make("TextLabel", {
        Size = UDim2.new(1, -20, 0, 14),
        Position = UDim2.fromOffset(10, 142),
        BackgroundTransparency = 1,
        Text = "BUILD " .. plugin.Version,
        TextColor3 = Color3.fromRGB(130, 136, 154),
        TextSize = 10,
        Font = Medium,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 5
    }, Card)

    local Execute = make("TextButton", {
        Size = UDim2.new(1, -20, 0, 26),
        Position = UDim2.new(0, 10, 1, -36),
        BackgroundColor3 = plugin.ButtonColor or Color3.fromRGB(240, 242, 248),
        Text = "EXECUTE",
        TextColor3 = plugin.ButtonTextColor or Color3.fromRGB(15, 17, 23),
        TextSize = 12,
        Font = Medium,
        AutoButtonColor = false,
        ZIndex = 6
    }, Card)
    applyCorner(Execute, 6)
    bindInteract(Execute, 1.03, 0.95)

    Card.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if Current ~= index then
                GUI:GoTo(index)
            end
        end
    end)

    Execute.MouseEnter:Connect(function()
        TweenService:Create(Execute, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = White
        }):Play()
    end)

    Execute.MouseLeave:Connect(function()
        TweenService:Create(Execute, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = plugin.ButtonColor or Color3.fromRGB(240, 242, 248)
        }):Play()
    end)

    local busy = false

    Execute.MouseButton1Click:Connect(function()
        if busy then
            return
        end
        busy = true

        if not plugin.Url or plugin.Url == "" then
            Execute.Text = "NO URL"
            task.delay(1.5, function()
                busy = false
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
                warn("[server] " .. tostring(plugin.Name) .. ": " .. tostring(result))
                Execute.Text = "FAILED"
            end

            task.wait(1.8)
            busy = false
            if Execute.Parent then
                Execute.Text = "EXECUTE"
            end
        end)
    end)

    Cards[index] = {
        Frame = Card,
        Scale = CardScale,
        Shadow = CardShadow
    }
end

for i, plugin in ipairs(Plugins) do
    createPluginCard(i, plugin)
end

local Footer = make("Frame", {
    Size = UDim2.new(1, 0, 0, 28),
    Position = UDim2.new(0, 0, 1, -28),
    BackgroundTransparency = 1,
    ZIndex = 8
}, Main)

make("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    SortOrder = Enum.SortOrder.LayoutOrder,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    Padding = UDim.new(0, 6)
}, Footer)

local DotIdle = Color3.fromRGB(200, 205, 220)

for i, plugin in ipairs(Plugins) do
    local Dot = make("TextButton", {
        LayoutOrder = i,
        Size = UDim2.fromOffset(6, 6),
        BackgroundColor3 = DotIdle,
        BackgroundTransparency = 0.78,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 9
    }, Footer)
    applyCorner(Dot, 999)
    Dot.MouseButton1Click:Connect(function()
        if Current ~= i then
            GUI:GoTo(i)
        end
    end)
    Dots[i] = Dot
end

local function updateDots()
    for i, Dot in ipairs(Dots) do
        local active = i == Current
        TweenService:Create(Dot, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = active and UDim2.fromOffset(18, 6) or UDim2.fromOffset(6, 6),
            BackgroundColor3 = active and (Plugins[i].ButtonColor or White) or DotIdle,
            BackgroundTransparency = active and 0 or 0.78
        }):Play()
    end
end

local function getOffset(index)
    local total = #Plugins
    return ((index - Current + math.floor(total / 2)) % total) - math.floor(total / 2)
end

local function updateCarousel(animated)
    for i, data in ipairs(Cards) do
        local card = data.Frame
        local offset = getOffset(i)
        local distance = math.abs(offset)
        local hidden = distance > 2
        local sign = offset < 0 and -1 or 1
        local slot = hidden and 3 * sign or offset

        local running = ActiveTweens[i]
        if running then
            for _, tween in ipairs(running) do
                tween:Cancel()
            end
        end
        ActiveTweens[i] = nil

        local target = {
            Position = UDim2.new(0.5, slot * SlotSpacing, 0.5, 0),
            Rotation = slot * 11,
            BackgroundTransparency = hidden and 1 or (offset == 0 and 0 or (distance == 1 and 0.12 or 0.38))
        }
        local scaleTarget = hidden and 0.5 or (offset == 0 and 1 or (distance == 1 and 0.82 or 0.66))
        local shadowTarget = offset == 0 and 0.35 or 1

        card.ZIndex = hidden and 1 or (25 - distance * 5)

        if animated and (card.Visible or not hidden) then
            card.Visible = true
            local info = TweenInfo.new(0.42, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            local tweens = {}
            local mainTween = tweenProps(card, info, target)
            if mainTween then
                table.insert(tweens, mainTween)
                if hidden then
                    mainTween.Completed:Connect(function(state)
                        if state == Enum.PlaybackState.Completed and math.abs(getOffset(i)) > 2 then
                            card.Visible = false
                        end
                    end)
                end
            end
            local scaleTween = tweenProps(data.Scale, info, { Scale = scaleTarget })
            if scaleTween then
                table.insert(tweens, scaleTween)
            end
            if data.Shadow then
                local shadowTween = tweenProps(data.Shadow, TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = shadowTarget
                })
                if shadowTween then
                    table.insert(tweens, shadowTween)
                end
            end
            ActiveTweens[i] = tweens
        else
            card.Position = target.Position
            card.Rotation = target.Rotation
            card.BackgroundTransparency = target.BackgroundTransparency
            data.Scale.Scale = scaleTarget
            if data.Shadow then
                data.Shadow.Transparency = shadowTarget
            end
            card.Visible = not hidden
        end
    end
end

local function refresh(animated)
    updateCarousel(animated)
    updateDots()
end

local function navigate(direction)
    Current = ((Current - 1 + direction) % #Plugins) + 1
    refresh(true)
end

local function createArrow(image, position, direction)
    local Button = make("ImageButton", {
        Size = UDim2.fromOffset(22, 22),
        Position = position,
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(20, 22, 30),
        BackgroundTransparency = 0.5,
        Image = image,
        ImageColor3 = Color3.fromRGB(240, 242, 250),
        ScaleType = Enum.ScaleType.Fit,
        AutoButtonColor = false,
        ZIndex = 45
    }, Stage)
    applyCorner(Button, 999)
    bindInteract(Button, 1.12, 0.88)

    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = Color3.fromRGB(38, 42, 58),
            BackgroundTransparency = 0.2,
            ImageColor3 = White
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
        navigate(direction)
    end)

    return Button
end

createArrow(Assets.ArrowLeft, UDim2.new(0, 16, 0.5, 0), -1)
createArrow(Assets.ArrowRight, UDim2.new(1, -16, 0.5, 0), 1)

local OpenButton = make("ImageButton", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.new(0, 20, 0.5, 0),
    AnchorPoint = Vector2.new(0, 0.5),
    BackgroundColor3 = Color3.fromRGB(20, 22, 30),
    BackgroundTransparency = 0.1,
    AutoButtonColor = false,
    Visible = false,
    ZIndex = 60
}, ScreenGui)

applyCorner(OpenButton, 8)
applyShadow(OpenButton, 10, UDim2.fromOffset(0, 3), 0.5)
bindInteract(OpenButton, 1.08, 0.92)

local OpenIcon = make("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.fromOffset(20, 20),
    BackgroundTransparency = 1,
    Image = Assets.Open,
    ImageColor3 = Color3.fromRGB(245, 246, 250),
    ScaleType = Enum.ScaleType.Fit,
    ZIndex = 61
}, OpenButton)

loopTween(OpenIcon, 1.0, { Position = UDim2.new(0.5, 0, 0.5, -3) })

task.spawn(function()
    while ScreenGui.Parent do
        task.wait(3.5)
        if OpenButton.Visible and OpenIcon.Parent then
            local half = TweenService:Create(OpenIcon, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Size = UDim2.fromOffset(0, 20)
            })
            half:Play()
            half.Completed:Wait()
            if not OpenIcon.Parent then
                break
            end
            local back = TweenService:Create(OpenIcon, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.fromOffset(20, 20)
            })
            back:Play()
            back.Completed:Wait()
        end
    end
end)

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
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(OpenIcon, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play()
        task.delay(0.18, function()
            if IsOpen then
                OpenButton.Visible = false
                OpenIcon.ImageTransparency = 0
                OpenButton.BackgroundTransparency = 0.1
            end
        end)
    else
        TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, 0, 0.5, 15),
            BackgroundTransparency = 1
        }):Play()

        task.delay(0.2, function()
            if IsOpen then
                return
            end
            Main.Visible = false
            OpenButton.Visible = true
            OpenButton.BackgroundTransparency = 1
            OpenIcon.ImageTransparency = 1
            TweenService:Create(OpenButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0.1
            }):Play()
            TweenService:Create(OpenIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
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
    refresh(true)
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
    for _, tween in ipairs(LoopTweens) do
        pcall(function()
            tween:Cancel()
        end)
    end
    pcall(function()
        ScreenGui:Destroy()
    end)
    if sharedEnv[registryKey] == ScreenGui then
        sharedEnv[registryKey] = nil
    end
end

refresh(false)

return GUI
