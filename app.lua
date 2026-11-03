--!strict
--[[
    Generated with Roblox UI Designer Mobile (Executor)
    ----------------------------------------
    - Self-contained: paste it into an executor, or loadstring it.
    - Mounts into the hidden GUI container, falling back to PlayerGui.
    - Every LocalScript runs with its own script.Parent, as authored.
]]

local executorEnv = getfenv() :: any

local function resolveHost(): Instance
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

	local players = game:GetService("Players")
	local player = players.LocalPlayer
	return player:WaitForChild("PlayerGui")
end

local host = resolveHost()

local GUI: {[string]: any} = {}

-- ===== UI =====

-- ScreenGui: ScreenGui
GUI["GUI_ScreenGui"] = Instance.new("ScreenGui")
GUI["GUI_ScreenGui"]["Name"] = "ScreenGui"
GUI["GUI_ScreenGui"]["DisplayOrder"] = 999
GUI["GUI_ScreenGui"]["Enabled"] = true
GUI["GUI_ScreenGui"]["IgnoreGuiInset"] = true
GUI["GUI_ScreenGui"]["ResetOnSpawn"] = true
GUI["GUI_ScreenGui"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling
GUI["GUI_ScreenGui"]["Parent"] = host

-- TextButton: Open
GUI["GUI_Open"] = Instance.new("TextButton")
GUI["GUI_Open"]["Name"] = "Open"
GUI["GUI_Open"]["AnchorPoint"] = Vector2.new(0.5, 0.0)
GUI["GUI_Open"]["Size"] = UDim2.fromOffset(55, 24)
GUI["GUI_Open"]["Position"] = UDim2.new(0.5, 0, 0, 2)
GUI["GUI_Open"]["Rotation"] = 0
GUI["GUI_Open"]["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
GUI["GUI_Open"]["BackgroundTransparency"] = 0
GUI["GUI_Open"]["BorderSizePixel"] = 0
GUI["GUI_Open"]["Visible"] = true
GUI["GUI_Open"]["Active"] = true
GUI["GUI_Open"]["ZIndex"] = 1
GUI["GUI_Open"]["LayoutOrder"] = 0
GUI["GUI_Open"]["Text"] = "N'EDV"
GUI["GUI_Open"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Open"]["TextSize"] = 12
GUI["GUI_Open"]["TextScaled"] = false
GUI["GUI_Open"]["TextWrapped"] = true
GUI["GUI_Open"]["TextTransparency"] = 0
GUI["GUI_Open"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Open"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Open"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Open"]["RichText"] = false
GUI["GUI_Open"]["AutoButtonColor"] = true
GUI["GUI_Open"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Open"]["Parent"] = GUI["GUI_ScreenGui"]

-- UICorner: UICorner
GUI["GUI_UICorner"] = Instance.new("UICorner")
GUI["GUI_UICorner"]["Name"] = "UICorner"
GUI["GUI_UICorner"]["BottomLeftRadius"] = UDim.new(0.0, 0)
GUI["GUI_UICorner"]["BottomRightRadius"] = UDim.new(0.0, 0)
GUI["GUI_UICorner"]["TopLeftRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner"]["TopRightRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner"]["Parent"] = GUI["GUI_Open"]

-- CanvasGroup: CanvasGroup
GUI["GUI_CanvasGroup"] = Instance.new("CanvasGroup")
GUI["GUI_CanvasGroup"]["Name"] = "CanvasGroup"
GUI["GUI_CanvasGroup"]["AnchorPoint"] = Vector2.new(0.5, 0.0)
GUI["GUI_CanvasGroup"]["Size"] = UDim2.fromOffset(222, 180)
GUI["GUI_CanvasGroup"]["Position"] = UDim2.new(0.5, 0, 0, 24)
GUI["GUI_CanvasGroup"]["Rotation"] = 0
GUI["GUI_CanvasGroup"]["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
GUI["GUI_CanvasGroup"]["BackgroundTransparency"] = 0
GUI["GUI_CanvasGroup"]["BorderSizePixel"] = 0
GUI["GUI_CanvasGroup"]["ClipsDescendants"] = true
GUI["GUI_CanvasGroup"]["GroupColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_CanvasGroup"]["GroupTransparency"] = 0
GUI["GUI_CanvasGroup"]["Visible"] = true
GUI["GUI_CanvasGroup"]["Active"] = true
GUI["GUI_CanvasGroup"]["ZIndex"] = 1
GUI["GUI_CanvasGroup"]["LayoutOrder"] = 0
GUI["GUI_CanvasGroup"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CanvasGroup"]["Parent"] = GUI["GUI_Open"]

-- Frame: Bottbar
GUI["GUI_Bottbar"] = Instance.new("Frame")
GUI["GUI_Bottbar"]["Name"] = "Bottbar"
GUI["GUI_Bottbar"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Bottbar"]["Size"] = UDim2.fromOffset(222, 24)
GUI["GUI_Bottbar"]["Position"] = UDim2.fromOffset(0, 156)
GUI["GUI_Bottbar"]["Rotation"] = 0
GUI["GUI_Bottbar"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_Bottbar"]["BackgroundTransparency"] = 0
GUI["GUI_Bottbar"]["BorderSizePixel"] = 0
GUI["GUI_Bottbar"]["ClipsDescendants"] = false
GUI["GUI_Bottbar"]["Visible"] = true
GUI["GUI_Bottbar"]["Active"] = true
GUI["GUI_Bottbar"]["ZIndex"] = 2
GUI["GUI_Bottbar"]["LayoutOrder"] = 0
GUI["GUI_Bottbar"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Bottbar"]["Parent"] = GUI["GUI_CanvasGroup"]

-- UIShadow: UIShadow
GUI["GUI_UIShadow"] = Instance.new("UIShadow")
GUI["GUI_UIShadow"]["Name"] = "UIShadow"
GUI["GUI_UIShadow"]["ZIndex"] = -1
GUI["GUI_UIShadow"]["BlurRadius"] = UDim.new(0.0, 12)
GUI["GUI_UIShadow"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIShadow"]["Enabled"] = true
GUI["GUI_UIShadow"]["Offset"] = UDim2.fromOffset(0, 4)
GUI["GUI_UIShadow"]["Spread"] = UDim2.fromScale(0, 0)
GUI["GUI_UIShadow"]["Transparency"] = 0.8
GUI["GUI_UIShadow"]["Parent"] = GUI["GUI_Bottbar"]

-- ImageButton: InfoBtn
GUI["GUI_InfoBtn"] = Instance.new("ImageButton")
GUI["GUI_InfoBtn"]["Name"] = "InfoBtn"
GUI["GUI_InfoBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_InfoBtn"]["Size"] = UDim2.fromOffset(16, 16)
GUI["GUI_InfoBtn"]["Position"] = UDim2.fromOffset(200, 4)
GUI["GUI_InfoBtn"]["Rotation"] = 0
GUI["GUI_InfoBtn"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_InfoBtn"]["BackgroundTransparency"] = 0
GUI["GUI_InfoBtn"]["BorderSizePixel"] = 0
GUI["GUI_InfoBtn"]["Visible"] = true
GUI["GUI_InfoBtn"]["Active"] = true
GUI["GUI_InfoBtn"]["ZIndex"] = 1
GUI["GUI_InfoBtn"]["LayoutOrder"] = 0
GUI["GUI_InfoBtn"]["AutoButtonColor"] = true
GUI["GUI_InfoBtn"]["Image"] = "rbxassetid://88424087003035"
GUI["GUI_InfoBtn"]["ImageTransparency"] = 0
GUI["GUI_InfoBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_InfoBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_InfoBtn"]["Parent"] = GUI["GUI_Bottbar"]

-- ImageButton: SettingBtn
GUI["GUI_SettingBtn"] = Instance.new("ImageButton")
GUI["GUI_SettingBtn"]["Name"] = "SettingBtn"
GUI["GUI_SettingBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SettingBtn"]["Size"] = UDim2.fromOffset(16, 16)
GUI["GUI_SettingBtn"]["Position"] = UDim2.fromOffset(178, 4)
GUI["GUI_SettingBtn"]["Rotation"] = 0
GUI["GUI_SettingBtn"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_SettingBtn"]["BackgroundTransparency"] = 0
GUI["GUI_SettingBtn"]["BorderSizePixel"] = 0
GUI["GUI_SettingBtn"]["Visible"] = true
GUI["GUI_SettingBtn"]["Active"] = true
GUI["GUI_SettingBtn"]["ZIndex"] = 1
GUI["GUI_SettingBtn"]["LayoutOrder"] = 0
GUI["GUI_SettingBtn"]["AutoButtonColor"] = true
GUI["GUI_SettingBtn"]["Image"] = "rbxassetid://97764716713536"
GUI["GUI_SettingBtn"]["ImageTransparency"] = 0
GUI["GUI_SettingBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_SettingBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SettingBtn"]["Parent"] = GUI["GUI_Bottbar"]

-- UICorner: UICorner
GUI["GUI_UICorner_1"] = Instance.new("UICorner")
GUI["GUI_UICorner_1"]["Name"] = "UICorner"
GUI["GUI_UICorner_1"]["BottomLeftRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_1"]["BottomRightRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_1"]["TopLeftRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner_1"]["TopRightRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_1"]["Parent"] = GUI["GUI_CanvasGroup"]

-- ScrollingFrame: ScrollingFrame
GUI["GUI_ScrollingFrame"] = Instance.new("ScrollingFrame")
GUI["GUI_ScrollingFrame"]["Name"] = "ScrollingFrame"
GUI["GUI_ScrollingFrame"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ScrollingFrame"]["Size"] = UDim2.fromOffset(222, 150)
GUI["GUI_ScrollingFrame"]["Position"] = UDim2.fromOffset(0, 5)
GUI["GUI_ScrollingFrame"]["Rotation"] = 0
GUI["GUI_ScrollingFrame"]["CanvasSize"] = UDim2.fromScale(0, 2)
GUI["GUI_ScrollingFrame"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
GUI["GUI_ScrollingFrame"]["ScrollBarThickness"] = 0
GUI["GUI_ScrollingFrame"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
GUI["GUI_ScrollingFrame"]["BackgroundTransparency"] = 1
GUI["GUI_ScrollingFrame"]["BorderSizePixel"] = 0
GUI["GUI_ScrollingFrame"]["ClipsDescendants"] = true
GUI["GUI_ScrollingFrame"]["Visible"] = true
GUI["GUI_ScrollingFrame"]["Active"] = true
GUI["GUI_ScrollingFrame"]["ZIndex"] = 1
GUI["GUI_ScrollingFrame"]["LayoutOrder"] = 0
GUI["GUI_ScrollingFrame"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ScrollingFrame"]["Parent"] = GUI["GUI_CanvasGroup"]

-- UIPadding: UIPadding
GUI["GUI_UIPadding"] = Instance.new("UIPadding")
GUI["GUI_UIPadding"]["Name"] = "UIPadding"
GUI["GUI_UIPadding"]["PaddingBottom"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding"]["PaddingLeft"] = UDim.new(0.0, 8)
GUI["GUI_UIPadding"]["PaddingRight"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding"]["PaddingTop"] = UDim.new(0.0, 2)
GUI["GUI_UIPadding"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- UIGridLayout: UIGridLayout
GUI["GUI_UIGridLayout"] = Instance.new("UIGridLayout")
GUI["GUI_UIGridLayout"]["Name"] = "UIGridLayout"
GUI["GUI_UIGridLayout"]["CellPadding"] = UDim2.fromOffset(5, 5)
GUI["GUI_UIGridLayout"]["CellSize"] = UDim2.fromOffset(66, 66)
GUI["GUI_UIGridLayout"]["FillDirection"] = Enum.FillDirection.Horizontal
GUI["GUI_UIGridLayout"]["SortOrder"] = Enum.SortOrder.LayoutOrder
GUI["GUI_UIGridLayout"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- TextButton: App
GUI["GUI_App"] = Instance.new("TextButton")
GUI["GUI_App"]["Name"] = "App"
GUI["GUI_App"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_App"]["Size"] = UDim2.fromOffset(66, 66)
GUI["GUI_App"]["Position"] = UDim2.fromOffset(8, 3)
GUI["GUI_App"]["Rotation"] = 0
GUI["GUI_App"]["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
GUI["GUI_App"]["BackgroundTransparency"] = 0
GUI["GUI_App"]["BorderSizePixel"] = 0
GUI["GUI_App"]["Visible"] = true
GUI["GUI_App"]["Active"] = true
GUI["GUI_App"]["ZIndex"] = 1
GUI["GUI_App"]["LayoutOrder"] = 0
GUI["GUI_App"]["Text"] = ""
GUI["GUI_App"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_App"]["TextSize"] = 10
GUI["GUI_App"]["TextScaled"] = false
GUI["GUI_App"]["TextWrapped"] = true
GUI["GUI_App"]["TextTransparency"] = 0
GUI["GUI_App"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_App"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_App"]["TextYAlignment"] = Enum.TextYAlignment.Bottom
GUI["GUI_App"]["RichText"] = false
GUI["GUI_App"]["AutoButtonColor"] = true
GUI["GUI_App"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_App"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- ImageLabel: Icon
GUI["GUI_Icon"] = Instance.new("ImageLabel")
GUI["GUI_Icon"]["Name"] = "Icon"
GUI["GUI_Icon"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
GUI["GUI_Icon"]["Size"] = UDim2.fromOffset(40, 40)
GUI["GUI_Icon"]["Position"] = UDim2.new(0.5, 0, 0.5, -10)
GUI["GUI_Icon"]["Rotation"] = 0
GUI["GUI_Icon"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon"]["BackgroundTransparency"] = 1
GUI["GUI_Icon"]["BorderSizePixel"] = 0
GUI["GUI_Icon"]["Visible"] = true
GUI["GUI_Icon"]["Active"] = false
GUI["GUI_Icon"]["ZIndex"] = 1
GUI["GUI_Icon"]["LayoutOrder"] = 0
GUI["GUI_Icon"]["Image"] = "rbxassetid://130721982350900"
GUI["GUI_Icon"]["ImageTransparency"] = 0
GUI["GUI_Icon"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon"]["Parent"] = GUI["GUI_App"]

-- TextLabel: TextLabel
GUI["GUI_TextLabel"] = Instance.new("TextLabel")
GUI["GUI_TextLabel"]["Name"] = "TextLabel"
GUI["GUI_TextLabel"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TextLabel"]["Size"] = UDim2.fromOffset(58, 12)
GUI["GUI_TextLabel"]["Position"] = UDim2.fromOffset(5, 48)
GUI["GUI_TextLabel"]["Rotation"] = 0
GUI["GUI_TextLabel"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_TextLabel"]["BackgroundTransparency"] = 1
GUI["GUI_TextLabel"]["BorderSizePixel"] = 0
GUI["GUI_TextLabel"]["Visible"] = true
GUI["GUI_TextLabel"]["Active"] = true
GUI["GUI_TextLabel"]["ZIndex"] = 1
GUI["GUI_TextLabel"]["LayoutOrder"] = 0
GUI["GUI_TextLabel"]["Text"] = "Lucide"
GUI["GUI_TextLabel"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_TextLabel"]["TextSize"] = 12
GUI["GUI_TextLabel"]["TextScaled"] = false
GUI["GUI_TextLabel"]["TextWrapped"] = true
GUI["GUI_TextLabel"]["TextTransparency"] = 0
GUI["GUI_TextLabel"]["Font"] = Enum.Font.GothamBold
GUI["GUI_TextLabel"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_TextLabel"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_TextLabel"]["RichText"] = false
GUI["GUI_TextLabel"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TextLabel"]["Parent"] = GUI["GUI_App"]

-- UICorner: UICorner
GUI["GUI_UICorner_2"] = Instance.new("UICorner")
GUI["GUI_UICorner_2"]["Name"] = "UICorner"
GUI["GUI_UICorner_2"]["CornerRadius"] = UDim.new(0.0, 8)
GUI["GUI_UICorner_2"]["Parent"] = GUI["GUI_App"]

-- UIShadow: UIShadow
GUI["GUI_UIShadow_1"] = Instance.new("UIShadow")
GUI["GUI_UIShadow_1"]["Name"] = "UIShadow"
GUI["GUI_UIShadow_1"]["ZIndex"] = -1
GUI["GUI_UIShadow_1"]["BlurRadius"] = UDim.new(0.0, 12)
GUI["GUI_UIShadow_1"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIShadow_1"]["Enabled"] = true
GUI["GUI_UIShadow_1"]["Offset"] = UDim2.fromOffset(0, 4)
GUI["GUI_UIShadow_1"]["Spread"] = UDim2.fromScale(0, 0)
GUI["GUI_UIShadow_1"]["Transparency"] = 0.5
GUI["GUI_UIShadow_1"]["Parent"] = GUI["GUI_CanvasGroup"]

-- UIShadow: UIShadow
GUI["GUI_UIShadow_2"] = Instance.new("UIShadow")
GUI["GUI_UIShadow_2"]["Name"] = "UIShadow"
GUI["GUI_UIShadow_2"]["ZIndex"] = -1
GUI["GUI_UIShadow_2"]["BlurRadius"] = UDim.new(0.0, 12)
GUI["GUI_UIShadow_2"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIShadow_2"]["Enabled"] = true
GUI["GUI_UIShadow_2"]["Offset"] = UDim2.fromOffset(0, 4)
GUI["GUI_UIShadow_2"]["Spread"] = UDim2.fromScale(0, 0)
GUI["GUI_UIShadow_2"]["Transparency"] = 0.5
GUI["GUI_UIShadow_2"]["Parent"] = GUI["GUI_Open"]


-- ===== Scripts =====

local loadstringFn = (executorEnv.loadstring or loadstring) :: any
local setfenvFn = (executorEnv.setfenv or setfenv) :: any
local getfenvFn = (executorEnv.getfenv or getfenv) :: any

local moduleLoaders: {[Instance]: () -> any} = {}
local moduleResults: {[Instance]: any} = {}
local moduleLoaded: {[Instance]: boolean} = {}

local function requireShim(target: any): any
	local loader = moduleLoaders[target]
	if loader == nil then
		return require(target)
	end
	if not moduleLoaded[target] then
		moduleLoaded[target] = true
		moduleResults[target] = loader()
	end
	return moduleResults[target]
end

local function compile(name: string, parent: Instance, source: string, className: string)
	if loadstringFn == nil then
		warn("[Vanilla] no loadstring available; skipped " .. name)
		return nil, nil
	end
	local chunk, err = loadstringFn(source, name)
	if chunk == nil then
		warn("[Vanilla] " .. name .. " failed to compile: " .. tostring(err))
		return nil, nil
	end

	-- A real instance, so script.Name, script.Parent and every path built
	-- from it behave exactly as they do in a normal game.
	local holder = Instance.new(className)
	holder.Name = name
	holder.Parent = parent

	if setfenvFn ~= nil and getfenvFn ~= nil then
		local env = setmetatable({ script = holder, require = requireShim }, {
			__index = getfenvFn(0),
		})
		setfenvFn(chunk, env)
	end
	return chunk, holder
end

-- LocalScript 1: ScreenGui.LocalScript
local chunk1, holder1 = compile(
	"LocalScript",
	GUI["GUI_ScreenGui"],
	[[

--!strict

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local executorEnv = getfenv() :: any
local ScreenGui = script.Parent :: ScreenGui

local Open = ScreenGui:WaitForChild("Open") :: TextButton
local CanvasGroup = Open:WaitForChild("CanvasGroup") :: CanvasGroup
local ScrollingFrame = CanvasGroup:WaitForChild("ScrollingFrame") :: ScrollingFrame
local Template = ScrollingFrame:WaitForChild("App") :: TextButton
local Grid = ScrollingFrame:WaitForChild("UIGridLayout") :: UIGridLayout
local OpenCorner = Open:WaitForChild("UICorner") :: UICorner

local AppList = {
	{
		App = "TERRAIN",
		Icon = "rbxassetid://129361331543944",
		TextLabel = "TERRAIN",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/terrain.lua",
	},
	{
		App = "TERRAIN V0.02",
		Icon = "rbxassetid://129361331543944",
		TextLabel = "TERRAIN V0.02",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/terrain2.lua",
	},
	{
		App = "EDITOR CODE",
		Icon = "rbxassetid://130150477351734",
		TextLabel = "EDITOR CODE",
		RawLink = "https://raw.githubusercontent.com/narakuhub/narsenvr-editorcode/refs/heads/main/load.lua",
	},
	{
		App = "AUDIO PLAY",
		Icon = "rbxassetid://136460394404917",
		TextLabel = "AUDIO PLAY",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/audio.lua",
	},
	{
		App = "ARCHIMEDES",
		Icon = "rbxassetid://87188567501065",
		TextLabel = "ARCHIMEDES",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/ArchSementara.lua",
	},
	{
		App = "LUCIDE ICONS",
		Icon = "rbxassetid://130721982350900",
		TextLabel = "LUCIDE ICONS",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/lucide.lua",
	},
	{
		App = "FLY CAMERA",
		Icon = "rbxassetid://80451686744860",
		TextLabel = "FLY CAMERA",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/FlyCamera.lua",
	},
	{
		App = "FLY GUI",
		Icon = "rbxassetid://126428723702595",
		TextLabel = "FLY GUI",
		RawLink = "https://raw.githubusercontent.com/narakuhub/plugin-tools/refs/heads/main/tools/flygui.lua",
	},
	{
		App = "TOOLBOX",
		Icon = "rbxassetid://79190391061047",
		TextLabel = "TOOLBOX",
		RawLink = "https://raw.githubusercontent.com/Edvxtrykkkkk/plugin/refs/heads/main/pluginbeta.lua",
	},
}

local OPEN_TEXT = "N'EDV"
local CLOSE_TEXT = "Close"

local CLOSED_BACKGROUND_TRANSPARENCY = 0.3
local OPEN_BACKGROUND_TRANSPARENCY = 0

local CLOSED_RADIUS = UDim.new(0, 3)
local OPEN_RADIUS = UDim.new(0, 0)

local OPEN_TWEEN = TweenInfo.new(
	0.22,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out
)

local CLOSE_TWEEN = TweenInfo.new(
	0.18,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.In
)

local isOpen = false
local isAnimating = false

local appData: {[TextButton]: any} = {}

local function warnError(message: string)
	warn("[N'EDV] " .. message)
end

local function generateName(): string
	local bytes = {}

	for i = 1, 32 do
		bytes[i] = string.char(math.random(0, 255))
	end

	return "_narsedv_" .. table.concat(bytes)
end

local function randomizeGuiNames(root: Instance)
	for _, instance in ipairs(root:GetDescendants()) do
		instance.Name = generateName()
	end

	root.Name = generateName()
end

local function setCornerRadius(radius: UDim)
	TweenService:Create(
		OpenCorner,
		OPEN_TWEEN,
		{
			BottomLeftRadius = radius,
			BottomRightRadius = radius,
		}
	):Play()
end

local function setOpenTransparency(transparency: number)
	TweenService:Create(
		Open,
		OPEN_TWEEN,
		{
			BackgroundTransparency = transparency,
		}
	):Play()
end

local CanvasScale = CanvasGroup:FindFirstChildOfClass("UIScale")

if not CanvasScale then
	CanvasScale = Instance.new("UIScale")
	CanvasScale.Scale = 1
	CanvasScale.Parent = CanvasGroup
end

local Scale = CanvasScale :: UIScale

Open.Text = OPEN_TEXT
Open.BackgroundTransparency = CLOSED_BACKGROUND_TRANSPARENCY

CanvasGroup.Visible = false
CanvasGroup.GroupTransparency = 1
Scale.Scale = 0

setCornerRadius(CLOSED_RADIUS)

local function togglePanel()
	if isAnimating then
		return
	end

	isAnimating = true
	isOpen = not isOpen

	local opening = isOpen
	local tweenInfo = if opening then OPEN_TWEEN else CLOSE_TWEEN

	if opening then
		CanvasGroup.Visible = true
		Open.Text = CLOSE_TEXT

		setCornerRadius(OPEN_RADIUS)
		setOpenTransparency(OPEN_BACKGROUND_TRANSPARENCY)
	end

	local scaleTween = TweenService:Create(
		Scale,
		tweenInfo,
		{
			Scale = if opening then 1 else 0,
		}
	)

	local fadeTween = TweenService:Create(
		CanvasGroup,
		tweenInfo,
		{
			GroupTransparency = if opening then 0 else 1,
		}
	)

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

local function resolveHost(): Instance
	local getHiddenUi =
		executorEnv.gethui or executorEnv.get_hidden_gui

	if type(getHiddenUi) == "function" then
		local ok, result = pcall(getHiddenUi)

		if ok and typeof(result) == "Instance" then
			return result
		end
	end

	local ok, result = pcall(function()
		return game:GetService("CoreGui")
	end)

	if ok and typeof(result) == "Instance" then
		return result
	end

	return Players.LocalPlayer:WaitForChild("PlayerGui")
end

local Host = ScreenGui.Parent or resolveHost()

local function executeApp(app: TextButton)
	local data = appData[app]

	if not data then
		return
	end

	if type(data.RawLink) ~= "string" or data.RawLink == "" then
		warnError("RawLink belum ditentukan: " .. tostring(data.App))
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

Template.Visible = false

for index, data in ipairs(AppList) do
	local success, result = pcall(function()
		local app = Template:Clone()

		app.Name = data.App
		app.LayoutOrder = index

		local icon = app:WaitForChild("Icon") :: ImageLabel
		local label = app:WaitForChild("TextLabel") :: TextLabel

		icon.Image = data.Icon

		label.Text = data.TextLabel
		label.TextTruncate = Enum.TextTruncate.AtEnd
		label.TextWrapped = false

		appData[app] = data
		app.Parent = ScrollingFrame
		app.Visible = true

		app.Activated:Connect(function()
			executeApp(app)
		end)
	end)

	if not success then
		warnError(tostring(data.App) .. ": " .. tostring(result))
	end
end

local function updateCanvas()
	local height = Grid.AbsoluteContentSize.Y
	local padding = ScrollingFrame:FindFirstChildOfClass("UIPadding")

	if padding then
		height += padding.PaddingTop.Offset
		height += padding.PaddingBottom.Offset
	end

	ScrollingFrame.CanvasSize = UDim2.fromOffset(0, height)
end

Grid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

updateCanvas()

randomizeGuiNames(ScreenGui)
]],
	"LocalScript"
)

-- Each on its own thread, so one yielding never blocks the
-- rest and an error stays contained to its script.
if chunk1 ~= nil then
	task.spawn(chunk1)
end

return GUI
