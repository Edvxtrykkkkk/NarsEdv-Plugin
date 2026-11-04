local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local executorEnv = getfenv()

local function warnError(message)
	warn("[server] " .. tostring(message))
end

local function generateName()
	local bytes = {}
	for i = 1, 32 do
		bytes[i] = string.char(math.random(0, 255))
	end
	return "_AppNarsEdv_" .. table.concat(bytes)
end

local function randomizeGuiNames(root)
	for _, instance in ipairs(root:GetDescendants()) do
		pcall(function()
			instance.Name = generateName()
		end)
	end
	pcall(function()
		root.Name = generateName()
	end)
end

local function resolveHost()
	local getHiddenUi = executorEnv.gethui or executorEnv.get_hidden_gui

	if type(getHiddenUi) == "function" then
		local ok, hidden = pcall(getHiddenUi)
		if ok and typeof(hidden) == "Instance" then
			return hidden
		end
	end

	local ok, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if ok and typeof(coreGui) == "Instance" then
		return coreGui
	end

	return Players.LocalPlayer:WaitForChild("PlayerGui")
end

local function addShadow(parent, transparency)
	pcall(function()
		local shadow = Instance.new("UIShadow")
		shadow.Name = "UIShadow"
		shadow.ZIndex = -1
		shadow.BlurRadius = UDim.new(0, 12)
		shadow.Color = Color3.fromRGB(0, 0, 0)
		shadow.Enabled = true
		shadow.Offset = UDim2.fromOffset(0, 4)
		shadow.Spread = UDim2.fromScale(0, 0)
		shadow.Transparency = transparency
		shadow.Parent = parent
	end)
end

-- ===== THEME (MONOKROM) =====

local THEME = {
	Background = Color3.fromRGB(17, 17, 17),
	Bar = Color3.fromRGB(22, 22, 22),
	Card = Color3.fromRGB(26, 26, 26),
	Text = Color3.fromRGB(235, 235, 235),
	Icon = Color3.fromRGB(210, 210, 210),
	Black = Color3.fromRGB(0, 0, 0),
	White = Color3.fromRGB(255, 255, 255),
}

-- ===== APP LIST =====

local AppList = {
	{
		App = "TERRAIN",
		Icon = "rbxassetid://129361331543944",
		TextLabel = "TERRAIN",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/terrain2.lua",
	},
	{
		App = "ECODE",
		Icon = "rbxassetid://130150477351734",
		TextLabel = "ECODE",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Ecode.lua",
	},
	{
		App = "LUCIDE",
		Icon = "rbxassetid://130721982350900",
		TextLabel = "LUCIDE ICONS",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/lucide.lua",
	},
	{
		App = "FLY CAMERA",
		Icon = "rbxassetid://80451686744860",
		TextLabel = "FLY CAMERA",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/FlyCameraFokus.lua",
	},
	{
		App = "FLY GUI",
		Icon = "rbxassetid://126428723702595",
		TextLabel = "FLY GUI",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/FlyCaracter.lua",
	},
	{
		App = "STORE",
		Icon = "rbxassetid://79190391061047",
		TextLabel = "STORE",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/store.lua",
	},
	{
		App = "IMPORT FILE",
		Icon = "rbxassetid://93307473217005",
		TextLabel = "IMPORT FILE",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/Importer.lua",
	},
}

-- ===== UI =====

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScreenGui"
ScreenGui.DisplayOrder = 999
ScreenGui.Enabled = true
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Tombol Open
local Open = Instance.new("TextButton")
Open.Name = "Open"
Open.AnchorPoint = Vector2.new(0.5, 0)
Open.Size = UDim2.fromOffset(55, 24)
Open.Position = UDim2.new(0.5, 0, 0, 2)
Open.BackgroundColor3 = THEME.Background
Open.BackgroundTransparency = 0
Open.BorderSizePixel = 0
Open.Active = true
Open.ZIndex = 1
Open.Text = "N'EDV"
Open.TextColor3 = THEME.White
Open.TextSize = 12
Open.TextScaled = false
Open.TextWrapped = true
Open.TextTransparency = 0
Open.Font = Enum.Font.GothamMedium
Open.TextXAlignment = Enum.TextXAlignment.Center
Open.TextYAlignment = Enum.TextYAlignment.Center
Open.RichText = false
Open.AutoButtonColor = true
Open.BorderColor3 = THEME.Black
Open.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.Name = "UICorner"
OpenCorner.BottomLeftRadius = UDim.new(0, 0)
OpenCorner.BottomRightRadius = UDim.new(0, 0)
OpenCorner.TopLeftRadius = UDim.new(0, 3)
OpenCorner.TopRightRadius = UDim.new(0, 3)
OpenCorner.Parent = Open

addShadow(Open, 0.5)

-- Panel utama
local CanvasGroup = Instance.new("CanvasGroup")
CanvasGroup.Name = "CanvasGroup"
CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
CanvasGroup.Size = UDim2.fromOffset(222, 180)
CanvasGroup.Position = UDim2.new(0.5, 0, 0, 24)
CanvasGroup.BackgroundColor3 = THEME.Background
CanvasGroup.BackgroundTransparency = 0
CanvasGroup.BorderSizePixel = 0
CanvasGroup.ClipsDescendants = true
CanvasGroup.GroupColor3 = THEME.White
CanvasGroup.GroupTransparency = 0
CanvasGroup.Active = true
CanvasGroup.ZIndex = 1
CanvasGroup.BorderColor3 = THEME.Black
CanvasGroup.Parent = Open

local CanvasCorner = Instance.new("UICorner")
CanvasCorner.Name = "UICorner"
CanvasCorner.BottomLeftRadius = UDim.new(0, 5)
CanvasCorner.BottomRightRadius = UDim.new(0, 5)
CanvasCorner.TopLeftRadius = UDim.new(0, 3)
CanvasCorner.TopRightRadius = UDim.new(0, 5)
CanvasCorner.Parent = CanvasGroup

local CanvasScale = Instance.new("UIScale")
CanvasScale.Name = "UIScale"
CanvasScale.Scale = 1
CanvasScale.Parent = CanvasGroup

addShadow(CanvasGroup, 0.5)

-- Bar bawah
local Bottbar = Instance.new("Frame")
Bottbar.Name = "Bottbar"
Bottbar.AnchorPoint = Vector2.new(0, 0)
Bottbar.Size = UDim2.fromOffset(222, 24)
Bottbar.Position = UDim2.fromOffset(0, 156)
Bottbar.BackgroundColor3 = THEME.Bar
Bottbar.BackgroundTransparency = 0
Bottbar.BorderSizePixel = 0
Bottbar.ClipsDescendants = false
Bottbar.Active = true
Bottbar.ZIndex = 2
Bottbar.BorderColor3 = THEME.Black
Bottbar.Parent = CanvasGroup

addShadow(Bottbar, 0.8)

-- Tombol Setting (tanpa fungsi)
local SettingBtn = Instance.new("ImageButton")
SettingBtn.Name = "SettingBtn"
SettingBtn.AnchorPoint = Vector2.new(0, 0)
SettingBtn.Size = UDim2.fromOffset(16, 16)
SettingBtn.Position = UDim2.fromOffset(178, 4)
SettingBtn.BackgroundColor3 = THEME.Bar
SettingBtn.BackgroundTransparency = 0
SettingBtn.BorderSizePixel = 0
SettingBtn.Active = true
SettingBtn.ZIndex = 3
SettingBtn.AutoButtonColor = true
SettingBtn.Image = "rbxassetid://97764716713536"
SettingBtn.ImageColor3 = THEME.Icon
SettingBtn.ImageTransparency = 0
SettingBtn.ScaleType = Enum.ScaleType.Stretch
SettingBtn.BorderColor3 = THEME.Black
SettingBtn.Parent = Bottbar

-- Tombol Info (tanpa fungsi)
local InfoBtn = Instance.new("ImageButton")
InfoBtn.Name = "InfoBtn"
InfoBtn.AnchorPoint = Vector2.new(0, 0)
InfoBtn.Size = UDim2.fromOffset(16, 16)
InfoBtn.Position = UDim2.fromOffset(200, 4)
InfoBtn.BackgroundColor3 = THEME.Bar
InfoBtn.BackgroundTransparency = 0
InfoBtn.BorderSizePixel = 0
InfoBtn.Active = true
InfoBtn.ZIndex = 3
InfoBtn.AutoButtonColor = true
InfoBtn.Image = "rbxassetid://88424087003035"
InfoBtn.ImageColor3 = THEME.Icon
InfoBtn.ImageTransparency = 0
InfoBtn.ScaleType = Enum.ScaleType.Stretch
InfoBtn.BorderColor3 = THEME.Black
InfoBtn.Parent = Bottbar

-- Area list app
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
ScrollingFrame.Size = UDim2.fromOffset(222, 150)
ScrollingFrame.Position = UDim2.fromOffset(0, 5)
ScrollingFrame.CanvasSize = UDim2.fromScale(0, 2)
ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.BackgroundColor3 = THEME.Background
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ClipsDescendants = true
ScrollingFrame.Active = true
ScrollingFrame.ZIndex = 1
ScrollingFrame.BorderColor3 = THEME.Black
ScrollingFrame.Parent = CanvasGroup

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.Name = "UIPadding"
ScrollPadding.PaddingTop = UDim.new(0, 2)
ScrollPadding.PaddingBottom = UDim.new(0, 5)
ScrollPadding.PaddingLeft = UDim.new(0, 8)
ScrollPadding.PaddingRight = UDim.new(0, 0)
ScrollPadding.Parent = ScrollingFrame

local Grid = Instance.new("UIGridLayout")
Grid.Name = "UIGridLayout"
Grid.CellPadding = UDim2.fromOffset(5, 5)
Grid.CellSize = UDim2.fromOffset(66, 66)
Grid.FillDirection = Enum.FillDirection.Horizontal
Grid.HorizontalAlignment = Enum.HorizontalAlignment.Left
Grid.VerticalAlignment = Enum.VerticalAlignment.Top
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = ScrollingFrame

-- Kartu app (icon + teks konsisten)
local function createApp(data, index)
	local App = Instance.new("TextButton")
	App.Name = "App"
	App.AnchorPoint = Vector2.new(0, 0)
	App.Size = UDim2.fromOffset(66, 66)
	App.BackgroundColor3 = THEME.Card
	App.BackgroundTransparency = 0
	App.BorderSizePixel = 0
	App.Active = true
	App.ZIndex = 1
	App.LayoutOrder = index
	App.Text = ""
	App.TextColor3 = THEME.White
	App.TextSize = 10
	App.TextScaled = false
	App.TextWrapped = true
	App.TextTransparency = 0
	App.Font = Enum.Font.GothamMedium
	App.TextXAlignment = Enum.TextXAlignment.Center
	App.TextYAlignment = Enum.TextYAlignment.Bottom
	App.RichText = false
	App.AutoButtonColor = true
	App.BorderColor3 = THEME.Black

	local Corner = Instance.new("UICorner")
	Corner.Name = "UICorner"
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = App

	local Icon = Instance.new("ImageLabel")
	Icon.Name = "Icon"
	Icon.AnchorPoint = Vector2.new(0.5, 0)
	Icon.Size = UDim2.fromOffset(36, 36)
	Icon.Position = UDim2.new(0.5, 0, 0, 7)
	Icon.BackgroundColor3 = THEME.White
	Icon.BackgroundTransparency = 1
	Icon.BorderSizePixel = 0
	Icon.Active = false
	Icon.ZIndex = 2
	Icon.Image = data.Icon
	Icon.ImageColor3 = THEME.White
	Icon.ImageTransparency = 0
	Icon.ScaleType = Enum.ScaleType.Fit
	Icon.BorderColor3 = THEME.Black
	Icon.Parent = App

	local Label = Instance.new("TextLabel")
	Label.Name = "TextLabel"
	Label.AnchorPoint = Vector2.new(0.5, 0)
	Label.Size = UDim2.fromOffset(62, 12)
	Label.Position = UDim2.new(0.5, 0, 0, 47)
	Label.BackgroundColor3 = THEME.White
	Label.BackgroundTransparency = 1
	Label.BorderSizePixel = 0
	Label.Active = false
	Label.ZIndex = 2
	Label.Text = data.TextLabel
	Label.TextColor3 = THEME.Text
	Label.TextSize = 10
	Label.TextScaled = true
	Label.TextWrapped = false
	Label.TextTransparency = 0
	Label.Font = Enum.Font.GothamBold
	Label.TextXAlignment = Enum.TextXAlignment.Center
	Label.TextYAlignment = Enum.TextYAlignment.Center
	Label.RichText = false
	Label.BorderColor3 = THEME.Black
	Label.Parent = App

	local LabelConstraint = Instance.new("UITextSizeConstraint")
	LabelConstraint.Name = "UITextSizeConstraint"
	LabelConstraint.MaxTextSize = 10
	LabelConstraint.MinTextSize = 7
	LabelConstraint.Parent = Label

	return App
end

-- ===== LOGIC =====

local OPEN_TEXT = "N'EDV"
local CLOSE_TEXT = "Close"

local CLOSED_BACKGROUND_TRANSPARENCY = 0.3
local OPEN_BACKGROUND_TRANSPARENCY = 0

local CLOSED_RADIUS = UDim.new(0, 3)
local OPEN_RADIUS = UDim.new(0, 0)

local OPEN_TWEEN = TweenInfo.new(0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local CLOSE_TWEEN = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.In)

local isOpen = false
local isAnimating = false

local function setCornerRadius(radius)
	TweenService:Create(OpenCorner, OPEN_TWEEN, {
		BottomLeftRadius = radius,
		BottomRightRadius = radius,
	}):Play()
end

local function setOpenTransparency(transparency)
	TweenService:Create(Open, OPEN_TWEEN, {
		BackgroundTransparency = transparency,
	}):Play()
end

Open.Text = OPEN_TEXT
Open.BackgroundTransparency = CLOSED_BACKGROUND_TRANSPARENCY

CanvasGroup.Visible = false
CanvasGroup.GroupTransparency = 1
CanvasScale.Scale = 0

setCornerRadius(CLOSED_RADIUS)

local function togglePanel()
	if isAnimating then
		return
	end

	isAnimating = true
	isOpen = not isOpen

	local opening = isOpen
	local tweenInfo = opening and OPEN_TWEEN or CLOSE_TWEEN

	if opening then
		CanvasGroup.Visible = true
		Open.Text = CLOSE_TEXT

		setCornerRadius(OPEN_RADIUS)
		setOpenTransparency(OPEN_BACKGROUND_TRANSPARENCY)
	end

	local scaleTween = TweenService:Create(CanvasScale, tweenInfo, {
		Scale = opening and 1 or 0,
	})

	local fadeTween = TweenService:Create(CanvasGroup, tweenInfo, {
		GroupTransparency = opening and 0 or 1,
	})

	scaleTween:Play()
	fadeTween:Play()
	scaleTween.Completed:Wait()

	if not opening then
		CanvasGroup.Visible = false
		Open.Text = OPEN_TEXT

		setCornerRadius(CLOSED_RADIUS)
		setOpenTransparency(CLOSED_BACKGROUND_TRANSPARENCY)
	end

	isAnimating = false
end

Open.Activated:Connect(togglePanel)

local function executeApp(data)
	if type(data.RawLink) ~= "string" or data.RawLink == "" then
		warnError("src belum ditentukan: " .. tostring(data.App))
		return
	end

	local success, result = pcall(function()
		local source = game:HttpGet(data.RawLink)
		local compiler = executorEnv.loadstring or loadstring

		if type(compiler) ~= "function" then
			error("loadstring tidak tersedia")
		end

		local chunk, compileError = compiler(source)

		if type(chunk) ~= "function" then
			error(tostring(compileError or "Gagal compile script"))
		end

		chunk()
	end)

	if not success then
		warnError(tostring(data.App) .. ": " .. tostring(result))
	end
end

for index, data in ipairs(AppList) do
	local success, result = pcall(function()
		local app = createApp(data, index)
		app.Parent = ScrollingFrame

		app.Activated:Connect(function()
			task.spawn(executeApp, data)
		end)
	end)

	if not success then
		warnError(tostring(data.App) .. ": " .. tostring(result))
	end
end

local function updateCanvas()
	local height = Grid.AbsoluteContentSize.Y
	height += ScrollPadding.PaddingTop.Offset
	height += ScrollPadding.PaddingBottom.Offset
	ScrollingFrame.CanvasSize = UDim2.fromOffset(0, height)
end

Grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
updateCanvas()

-- ===== MOUNT =====

local mountOk, mountError = pcall(function()
	ScreenGui.Parent = resolveHost()
end)

if not mountOk then
	warnError("Gagal memasang GUI: " .. tostring(mountError))
end

randomizeGuiNames(ScreenGui)
