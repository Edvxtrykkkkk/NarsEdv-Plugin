-- Lucide Icons | Version 0.3 (FixDebug)
-- Create NarsEdv | Sumber Lucide Link

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")

local Icon_url = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"
local LINK_URL = "https://lucide.dev/icons/"
local FONT = Enum.Font.GothamMedium
local MIN_GROUP_SIZE = 3

local function resolveHost(): Instance
	local okHui, hui = pcall(function()
		if typeof(gethui) == "function" then return gethui() end
		if typeof(get_hidden_gui) == "function" then return get_hidden_gui() end
		local env = (getgenv and getgenv()) or (getfenv and getfenv()) or {}
		if typeof(env.gethui) == "function" then return env.gethui() end
		if typeof(env.get_hidden_gui) == "function" then return env.get_hidden_gui() end
		return nil
	end)
	if okHui and typeof(hui) == "Instance" then return hui end

	local okCore, coreGui = pcall(function()
		return game:GetService("CoreGui")
	end)
	if okCore and typeof(coreGui) == "Instance" then
		return coreGui
	end

	local okPlayer, player = pcall(function() return Players.LocalPlayer end)
	if okPlayer and player then
		local pg = player:FindFirstChild("PlayerGui")
		if pg then return pg end
		local okWait, waited = pcall(function() return player:WaitForChild("PlayerGui", 2) end)
		if okWait and waited then return waited end
	end

	local okStarter, starter = pcall(function() return game:GetService("StarterGui") end)
	if okStarter and starter then return starter end

	return game:GetService("CoreGui")
end

local host = resolveHost()

local envOk, sharedEnv = pcall(function()
	return (getgenv and getgenv()) or _G
end)
if not envOk or type(sharedEnv) ~= "table" then
	sharedEnv = _G
end
local GUI_KEY = "__NarsEdv_LucideGui"

local function generateName(): string
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	local result = {}
	for i = 1, 24 do
		local idx = math.random(1, #chars)
		result[i] = string.sub(chars, idx, idx)
	end
	return "_LucideCreateNarsEdv_" .. table.concat(result)
end

do
	local prev = sharedEnv[GUI_KEY]
	if prev then
		pcall(function()
			prev:Destroy()
		end)
		sharedEnv[GUI_KEY] = nil
	end
	for _, child in ipairs(host:GetChildren()) do
		if child:IsA("ScreenGui") and string.sub(child.Name, 1, 21) == "_LucideCreateNarsEdv_" then
			pcall(function()
				child:Destroy()
			end)
		end
	end
end

local function new(className: string, props: {[string]: any}?): any
	local inst = Instance.new(className)
	inst.Name = generateName()
	local parent = nil
	if props then
		for key, value in pairs(props) do
			if key == "Parent" then
				parent = value
			else
				inst[key] = value
			end
		end
	end
	if parent then
		inst.Parent = parent
	end
	return inst
end

local function corner(parent: Instance, radius: number): any
	return new("UICorner", {CornerRadius = UDim.new(0, radius), Parent = parent})
end

local function pad(parent: Instance, l: number, t: number, r: number, b: number): any
	return new("UIPadding", {
		PaddingLeft = UDim.new(0, l),
		PaddingTop = UDim.new(0, t),
		PaddingRight = UDim.new(0, r),
		PaddingBottom = UDim.new(0, b),
		Parent = parent
	})
end

local function addShadow(parent: Instance)
	local okShadow, shadow = pcall(Instance.new, "UIShadow")
	if not okShadow or not shadow then
		return
	end
	local function trySet(prop: string, value: any)
		pcall(function()
			shadow[prop] = value
		end)
	end
	trySet("Name", generateName())
	trySet("ZIndex", -1)
	trySet("BlurRadius", UDim.new(0, 12))
	trySet("Color", Color3.fromRGB(0, 0, 0))
	trySet("Enabled", true)
	trySet("Offset", UDim2.fromOffset(0, 4))
	trySet("Spread", UDim2.fromScale(0, 0))
	trySet("Transparency", 0.5)
	pcall(function()
		shadow.Parent = parent
	end)
end

local Icon = {
	Load = "rbxassetid://78408734580845",
	ThemeMonochrome = "rbxassetid://83380517901735",
	ThemeLight = "rbxassetid://110150589884127",
	LogoMonochrome = "rbxassetid://130721982350900",
	LogoLight = "rbxassetid://74893210499305",
	Menu = "rbxassetid://77021539815611",
	Close = "rbxassetid://75539660682193",
	Back = "rbxassetid://73780377692148",
	Search = "rbxassetid://92345384671606",
	Bookmark = "rbxassetid://74987060545093",
	Copy = "rbxassetid://78979572434545",
	Resize = "rbxassetid://103321376129527",
	ArrowLeft = "rbxassetid://73780377692148",
	ArrowRight = "rbxassetid://92473583511724",
	ArrowfillDown = "rbxassetid://139953983876976",
	ArrowfillUp = "rbxassetid://132169295529879"
}

local function rgb(r: number, g: number, b: number): Color3
	return Color3.fromRGB(r, g, b)
end

local GOLD = rgb(255, 200, 60)
local RED = rgb(190, 45, 45)
local RED_HOVER = rgb(214, 62, 62)
local RED_PRESS = rgb(160, 34, 34)

local Palettes = {
	Monochrome = {
		panel = rgb(16, 16, 16),
		header = rgb(22, 22, 22),
		headerLine = rgb(42, 42, 42),
		card = rgb(24, 24, 24),
		cardHover = rgb(37, 37, 37),
		btn = rgb(31, 31, 31),
		btnHover = rgb(44, 44, 44),
		btnPress = rgb(56, 56, 56),
		inner = rgb(12, 12, 12),
		list = rgb(10, 10, 10),
		text = rgb(245, 245, 245),
		textSub = rgb(176, 176, 176),
		textDim = rgb(125, 125, 125),
		icon = rgb(210, 210, 210),
		iconDim = rgb(138, 138, 138),
		iconHover = rgb(255, 255, 255),
		placeholder = rgb(98, 98, 98),
		scroll = rgb(72, 72, 72),
		tabIdle = rgb(16, 16, 16),
		tabActive = rgb(36, 36, 36),
		tabIdleText = rgb(142, 142, 142),
		tabActiveText = rgb(255, 255, 255),
		item = rgb(18, 18, 18),
		itemSel = rgb(32, 32, 32),
		stroke = rgb(50, 50, 50),
		strokeFocus = rgb(225, 225, 225),
		cardHoverTag = rgb(20, 20, 20),
		popup = rgb(28, 28, 28),
		popupBtn = rgb(42, 42, 42),
		popupBtnHover = rgb(54, 54, 54),
		popupBtnPress = rgb(66, 66, 66),
		sep = rgb(95, 95, 95),
		link = rgb(100, 172, 255),
		linkHover = rgb(150, 205, 255)
	},
	Light = {
		panel = rgb(244, 244, 248),
		header = rgb(251, 251, 253),
		headerLine = rgb(215, 215, 225),
		card = rgb(255, 255, 255),
		cardHover = rgb(232, 234, 242),
		btn = rgb(232, 232, 240),
		btnHover = rgb(218, 221, 234),
		btnPress = rgb(200, 205, 224),
		inner = rgb(240, 240, 246),
		list = rgb(234, 234, 240),
		text = rgb(15, 15, 20),
		textSub = rgb(50, 50, 62),
		textDim = rgb(95, 95, 110),
		icon = rgb(15, 15, 20),
		iconDim = rgb(80, 80, 95),
		iconHover = rgb(0, 0, 0),
		placeholder = rgb(120, 120, 135),
		scroll = rgb(170, 170, 182),
		tabIdle = rgb(240, 240, 246),
		tabActive = rgb(214, 218, 232),
		tabIdleText = rgb(90, 90, 105),
		tabActiveText = rgb(15, 15, 20),
		item = rgb(255, 255, 255),
		itemSel = rgb(222, 226, 240),
		stroke = rgb(200, 200, 215),
		strokeFocus = rgb(30, 30, 50),
		cardHoverTag = rgb(20, 20, 20),
		popup = rgb(255, 255, 255),
		popupBtn = rgb(236, 236, 243),
		popupBtnHover = rgb(224, 226, 238),
		popupBtnPress = rgb(208, 212, 230),
		sep = rgb(150, 150, 165),
		link = rgb(0, 84, 190),
		linkHover = rgb(0, 54, 140)
	}
}

local currentThemeName = "Monochrome"
local function getTheme()
	return Palettes[currentThemeName]
end

local bindings: {{any}} = {}
local function bind(obj: Instance, prop: string, key: string)
	obj[prop] = getTheme()[key]
	table.insert(bindings, {obj, prop, key})
end

local function tween(obj: Instance, props: {[string]: any}, duration: number?, style: Enum.EasingStyle?)
	local t = TweenService:Create(
		obj,
		TweenInfo.new(duration or 0.14, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		props
	)
	t:Play()
	return t
end

local function hoverBind(trigger: GuiButton, target: Instance, prop: string, normalKey: string, hoverKey: string, pressKey: string?)
	local hovering = false
	trigger.MouseEnter:Connect(function()
		hovering = true
		tween(target, {[prop] = getTheme()[hoverKey]}, 0.12)
	end)
	trigger.MouseLeave:Connect(function()
		hovering = false
		tween(target, {[prop] = getTheme()[normalKey]}, 0.12)
	end)
	if pressKey then
		trigger.MouseButton1Down:Connect(function()
			tween(target, {[prop] = getTheme()[pressKey]}, 0.08)
		end)
		trigger.MouseButton1Up:Connect(function()
			tween(target, {[prop] = getTheme()[hovering and hoverKey or normalKey]}, 0.12)
		end)
	end
end

local function pressIcon(btn: GuiButton, icon: ImageLabel, px: number)
	btn.MouseButton1Down:Connect(function()
		tween(icon, {Size = UDim2.fromOffset(px - 3, px - 3)}, 0.08)
	end)
	btn.MouseButton1Up:Connect(function()
		tween(icon, {Size = UDim2.fromOffset(px, px)}, 0.16, Enum.EasingStyle.Back)
	end)
end

local function softHover(btn: GuiButton, icon: ImageLabel, px: number, normalKey: string, hoverKey: string)
	btn.MouseEnter:Connect(function()
		tween(btn, {BackgroundTransparency = 0}, 0.12)
		tween(icon, {ImageColor3 = getTheme()[hoverKey]}, 0.12)
	end)
	btn.MouseLeave:Connect(function()
		tween(btn, {BackgroundTransparency = 1}, 0.12)
		tween(icon, {ImageColor3 = getTheme()[normalKey]}, 0.12)
	end)
	pressIcon(btn, icon, px)
end

local function makeIconButton(parent: Instance, px: number, iconPx: number, image: string, z: number?): (any, any)
	local btn = new("TextButton", {
		Size = UDim2.fromOffset(px, px),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		ZIndex = z or 1,
		Parent = parent
	})
	corner(btn, 6)
	local icon = new("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(iconPx, iconPx),
		BackgroundTransparency = 1,
		Image = image,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = (z or 1) + 1,
		Parent = btn
	})
	return btn, icon
end

local function makeLabeledButton(parent: Instance, text: string, image: string, z: number): (any, any, any)
	local btn = new("TextButton", {
		BorderSizePixel = 0,
		Text = "",
		AutoButtonColor = false,
		ZIndex = z,
		Parent = parent
	})
	corner(btn, 6)
	local icon = new("ImageLabel", {
		Position = UDim2.new(0, 12, 0.5, -7),
		Size = UDim2.fromOffset(14, 14),
		BackgroundTransparency = 1,
		Image = image,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = z + 1,
		Parent = btn
	})
	local label = new("TextLabel", {
		Position = UDim2.fromOffset(28, 0),
		Size = UDim2.new(1, -32, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextSize = 11,
		Font = FONT,
		TextXAlignment = Enum.TextXAlignment.Center,
		ZIndex = z + 1,
		Parent = btn
	})
	return btn, icon, label
end

local FAVORITE_FILE = "Lucide_favorite.json"
local favoritesSet: {[string]: boolean} = {}

local function loadFavorites()
	favoritesSet = {}
	pcall(function()
		if type(readfile) == "function" then
			local content = readfile(FAVORITE_FILE)
			if type(content) == "string" and #content > 0 then
				local decoded = HttpService:JSONDecode(content)
				if type(decoded) == "table" then
					for _, name in ipairs(decoded) do
						if type(name) == "string" then
							favoritesSet[name] = true
						end
					end
				end
			end
		end
	end)
end

local function saveFavorites()
	pcall(function()
		if type(writefile) == "function" then
			local list = {}
			for name, val in pairs(favoritesSet) do
				if val then
					table.insert(list, name)
				end
			end
			table.sort(list)
			writefile(FAVORITE_FILE, HttpService:JSONEncode(list))
		end
	end)
end

loadFavorites()

local function safeSetClipboard(str: string): boolean
	local ok, res = pcall(function()
		if type(setclipboard) == "function" then
			setclipboard(str)
			return true
		end
		if type(toclipboard) == "function" then
			toclipboard(str)
			return true
		end
		return false
	end)
	return ok and res == true
end

local connections: {RBXScriptConnection} = {}
local function trackConn(conn: RBXScriptConnection): RBXScriptConnection
	table.insert(connections, conn)
	return conn
end

local Gui = new("ScreenGui", {
	ResetOnSpawn = false,
	IgnoreGuiInset = true,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})
pcall(function()
	Gui.DisplayOrder = 999
end)

local parentOk = pcall(function()
	Gui.Parent = host
end)
if not parentOk or Gui.Parent == nil then
	pcall(function()
		local lp = Players.LocalPlayer
		local pg = lp and (lp:FindFirstChild("PlayerGui") or lp:WaitForChild("PlayerGui", 5))
		if pg then
			Gui.Parent = pg
		end
	end)
end
sharedEnv[GUI_KEY] = Gui

local Main = new("Frame", {
	Size = UDim2.fromOffset(420, 320),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	BorderSizePixel = 0,
	ClipsDescendants = true,
	Parent = Gui
})
bind(Main, "BackgroundColor3", "panel")
corner(Main, 12)

addShadow(Main)

local Header = new("Frame", {
	Size = UDim2.new(1, 0, 0, 35),
	Position = UDim2.fromOffset(0, 0),
	BorderSizePixel = 0,
	Parent = Main
})
bind(Header, "BackgroundColor3", "header")

do
	local HeaderCorner = new("UICorner", {Parent = Header})
	pcall(function()
		HeaderCorner.Archivable = true
		HeaderCorner.CornerRadius = UDim.new(0, 12)
		HeaderCorner.TopLeftRadius = UDim.new(0, 12)
		HeaderCorner.TopRightRadius = UDim.new(0, 12)
		HeaderCorner.BottomLeftRadius = UDim.new(0, 0)
		HeaderCorner.BottomRightRadius = UDim.new(0, 0)
	end)
end

local HeaderDivider = new("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.new(0, 0, 1, -1),
	BorderSizePixel = 0,
	Parent = Header
})
bind(HeaderDivider, "BackgroundColor3", "headerLine")

local Logo = new("ImageLabel", {
	Size = UDim2.fromOffset(27, 27),
	Position = UDim2.fromOffset(8, 4),
	BackgroundTransparency = 1,
	Image = Icon.LogoMonochrome,
	ImageColor3 = Color3.fromRGB(255, 255, 255),
	ScaleType = Enum.ScaleType.Fit,
	Parent = Header
})

local TitleHolder = new("Frame", {
	Size = UDim2.new(1, -107, 1, 0),
	Position = UDim2.fromOffset(43, 0),
	BackgroundTransparency = 1,
	ClipsDescendants = true,
	Parent = Header
})

local Title = new("TextLabel", {
	Size = UDim2.new(1, 0, 0, 14),
	Position = UDim2.fromOffset(0, 5),
	BackgroundTransparency = 1,
	Text = "LUCIDE ICONS",
	TextSize = 14,
	Font = Enum.Font.GothamBold,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = TitleHolder
})
bind(Title, "TextColor3", "text")

local SubRow = new("Frame", {
	Size = UDim2.new(1, 0, 0, 13),
	Position = UDim2.fromOffset(0, 18),
	BackgroundTransparency = 1,
	Parent = TitleHolder
})
new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	SortOrder = Enum.SortOrder.LayoutOrder,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 7),
	Parent = SubRow
})

local Creator = new("TextLabel", {
	LayoutOrder = 1,
	Size = UDim2.new(0, 0, 1, 0),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
	Text = "Create NarsEdv",
	TextSize = 11.5,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = SubRow
})
bind(Creator, "TextColor3", "textSub")

local SourceSeparator = new("Frame", {
	LayoutOrder = 2,
	Size = UDim2.fromOffset(1, 10),
	BorderSizePixel = 0,
	Parent = SubRow
})
bind(SourceSeparator, "BackgroundColor3", "sep")

local SourceLink = new("TextButton", {
	LayoutOrder = 3,
	Size = UDim2.new(0, 0, 1, 0),
	AutomaticSize = Enum.AutomaticSize.X,
	BackgroundTransparency = 1,
	Text = LINK_URL,
	TextSize = 11.5,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Left,
	AutoButtonColor = false,
	Parent = SubRow
})
bind(SourceLink, "TextColor3", "link")

SourceLink.MouseEnter:Connect(function()
	tween(SourceLink, {TextColor3 = getTheme().linkHover}, 0.12)
end)
SourceLink.MouseLeave:Connect(function()
	tween(SourceLink, {TextColor3 = getTheme().link}, 0.12)
end)
SourceLink.MouseButton1Click:Connect(function()
	safeSetClipboard(LINK_URL)
	SourceLink.Text = "Copied URL!"
	task.delay(1.2, function()
		if SourceLink.Parent then
			SourceLink.Text = LINK_URL
		end
	end)
end)

local ThemeButton, ThemeIcon = makeIconButton(Header, 24, 16, Icon.ThemeMonochrome)
ThemeButton.Position = UDim2.new(1, -58, 0.5, -12)
bind(ThemeButton, "BackgroundColor3", "btn")
bind(ThemeIcon, "ImageColor3", "icon")
softHover(ThemeButton, ThemeIcon, 16, "icon", "iconHover")

local CloseButton, CloseIcon = makeIconButton(Header, 24, 16, Icon.Close)
CloseButton.Position = UDim2.new(1, -30, 0.5, -12)
bind(CloseButton, "BackgroundColor3", "btn")
bind(CloseIcon, "ImageColor3", "icon")
softHover(CloseButton, CloseIcon, 16, "icon", "iconHover")

local Toolbar = new("Frame", {
	Size = UDim2.new(1, -20, 0, 60),
	Position = UDim2.fromOffset(10, 38),
	BackgroundTransparency = 1,
	Parent = Main
})

local CategoryTabs = new("ScrollingFrame", {
	Size = UDim2.new(1, 0, 0, 24),
	Position = UDim2.fromOffset(0, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 0,
	ScrollingDirection = Enum.ScrollingDirection.X,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.None,
	Parent = Toolbar
})

local TabIndicator = new("Frame", {
	Size = UDim2.fromOffset(0, 2),
	Position = UDim2.fromOffset(0, 22),
	BorderSizePixel = 0,
	ZIndex = 5,
	Parent = CategoryTabs
})
bind(TabIndicator, "BackgroundColor3", "tabActiveText")
corner(TabIndicator, 1)

local SearchHolder = new("Frame", {
	Size = UDim2.new(1, 0, 0, 28),
	Position = UDim2.fromOffset(0, 28),
	BorderSizePixel = 0,
	Parent = Toolbar
})
bind(SearchHolder, "BackgroundColor3", "inner")
corner(SearchHolder, 6)

local SearchStroke = new("UIStroke", {
	Thickness = 0.5,
	Transparency = 0.5,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	Parent = SearchHolder
})
SearchStroke.Color = getTheme().stroke

local SearchIcon = new("ImageLabel", {
	Size = UDim2.fromOffset(14, 14),
	Position = UDim2.fromOffset(8, 7),
	BackgroundTransparency = 1,
	Image = Icon.Search,
	Parent = SearchHolder
})
bind(SearchIcon, "ImageColor3", "iconDim")

local SearchBox = new("TextBox", {
	Size = UDim2.new(1, -62, 1, 0),
	Position = UDim2.fromOffset(28, 0),
	BackgroundTransparency = 1,
	ClearTextOnFocus = false,
	PlaceholderText = "Search lucide icons...",
	Text = "",
	TextSize = 11,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = SearchHolder
})
bind(SearchBox, "PlaceholderColor3", "placeholder")
bind(SearchBox, "TextColor3", "text")

local FavoriteFilterButton, FavoriteFilterIcon = makeIconButton(SearchHolder, 22, 14, Icon.Bookmark)
FavoriteFilterButton.Position = UDim2.new(1, -26, 0.5, -11)
bind(FavoriteFilterButton, "BackgroundColor3", "btn")

local Content = new("ScrollingFrame", {
	Size = UDim2.new(1, -20, 1, -164),
	Position = UDim2.fromOffset(10, 104),
	BackgroundTransparency = 0.4,
	BorderSizePixel = 0,
	ScrollBarThickness = 2,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	ScrollingDirection = Enum.ScrollingDirection.Y,
	Parent = Main
})
bind(Content, "BackgroundColor3", "list")
bind(Content, "ScrollBarImageColor3", "scroll")
corner(Content, 8)

local CONTENT_PAD = 8
pad(Content, CONTENT_PAD, CONTENT_PAD, CONTENT_PAD, CONTENT_PAD)

local Grid = new("UIGridLayout", {
	CellSize = UDim2.fromOffset(58, 54),
	CellPadding = UDim2.fromOffset(6, 6),
	HorizontalAlignment = Enum.HorizontalAlignment.Center,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = Content
})

local BottomControls = new("Frame", {
	Size = UDim2.new(1, -20, 0, 26),
	Position = UDim2.new(0, 10, 1, -54),
	BackgroundTransparency = 1,
	Parent = Main
})

local Pagination = new("Frame", {
	Size = UDim2.new(0, 140, 1, 0),
	Position = UDim2.fromOffset(0, 0),
	BackgroundTransparency = 1,
	Parent = BottomControls
})

local PreviousButton, PreviousIcon = makeIconButton(Pagination, 22, 12, Icon.ArrowLeft)
PreviousButton.Position = UDim2.fromOffset(0, 2)
PreviousButton.BackgroundTransparency = 0
bind(PreviousButton, "BackgroundColor3", "btn")
bind(PreviousIcon, "ImageColor3", "icon")
hoverBind(PreviousButton, PreviousButton, "BackgroundColor3", "btn", "btnHover", "btnPress")
pressIcon(PreviousButton, PreviousIcon, 12)

local PageIndicator = new("TextLabel", {
	Size = UDim2.new(0, 68, 1, 0),
	Position = UDim2.fromOffset(26, 0),
	BackgroundTransparency = 1,
	Text = "1 / 1",
	TextSize = 10.5,
	Font = FONT,
	Parent = Pagination
})
bind(PageIndicator, "TextColor3", "textSub")

local NextButton, NextIcon = makeIconButton(Pagination, 22, 12, Icon.ArrowRight)
NextButton.Position = UDim2.fromOffset(98, 2)
NextButton.BackgroundTransparency = 0
bind(NextButton, "BackgroundColor3", "btn")
bind(NextIcon, "ImageColor3", "icon")
hoverBind(NextButton, NextButton, "BackgroundColor3", "btn", "btnHover", "btnPress")
pressIcon(NextButton, NextIcon, 12)

local IconSizeHolder = new("Frame", {
	Size = UDim2.fromOffset(92, 24),
	Position = UDim2.new(1, -92, 0, 1),
	BorderSizePixel = 0,
	Parent = BottomControls
})
bind(IconSizeHolder, "BackgroundColor3", "btn")
corner(IconSizeHolder, 5)

local SizeLabel = new("TextLabel", {
	Size = UDim2.new(0, 28, 1, 0),
	Position = UDim2.fromOffset(6, 0),
	BackgroundTransparency = 1,
	Text = "Size",
	TextSize = 10,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = IconSizeHolder
})
bind(SizeLabel, "TextColor3", "textDim")

local SizeBox = new("TextBox", {
	Size = UDim2.new(0, 32, 1, 0),
	Position = UDim2.fromOffset(36, 0),
	BackgroundTransparency = 1,
	ClearTextOnFocus = false,
	Text = "24px",
	TextSize = 10.5,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Center,
	Parent = IconSizeHolder
})
bind(SizeBox, "TextColor3", "text")

local StepperHolder = new("Frame", {
	Size = UDim2.fromOffset(18, 22),
	Position = UDim2.new(1, -20, 0, 1),
	BackgroundTransparency = 1,
	Parent = IconSizeHolder
})

local StepUpButton, StepUpIcon = makeIconButton(StepperHolder, 16, 8, Icon.ArrowfillUp)
StepUpButton.Size = UDim2.fromOffset(16, 10)
StepUpButton.Position = UDim2.fromOffset(1, 1)
bind(StepUpButton, "BackgroundColor3", "btnHover")
bind(StepUpIcon, "ImageColor3", "iconDim")
softHover(StepUpButton, StepUpIcon, 8, "iconDim", "iconHover")

local StepDownButton, StepDownIcon = makeIconButton(StepperHolder, 16, 8, Icon.ArrowfillDown)
StepDownButton.Size = UDim2.fromOffset(16, 10)
StepDownButton.Position = UDim2.fromOffset(1, 11)
bind(StepDownButton, "BackgroundColor3", "btnHover")
bind(StepDownIcon, "ImageColor3", "iconDim")
softHover(StepDownButton, StepDownIcon, 8, "iconDim", "iconHover")

local Footer = new("Frame", {
	Size = UDim2.new(1, 0, 0, 24),
	Position = UDim2.new(0, 0, 1, -24),
	BackgroundTransparency = 1,
	Parent = Main
})

local FooterDivider = new("Frame", {
	Size = UDim2.new(1, 0, 0, 1),
	Position = UDim2.fromOffset(0, 0),
	BorderSizePixel = 0,
	Parent = Footer
})
bind(FooterDivider, "BackgroundColor3", "headerLine")

local VersionInfo = new("TextLabel", {
	Size = UDim2.new(1, -30, 1, 0),
	Position = UDim2.fromOffset(10, 0),
	BackgroundTransparency = 1,
	Text = "ⓘ  Lisensi Lucide Icons",
	TextSize = 9.5,
	Font = FONT,
	TextXAlignment = Enum.TextXAlignment.Left,
	Parent = Footer
})
bind(VersionInfo, "TextColor3", "textDim")

local ResizeHandle = new("ImageButton", {
	Size = UDim2.fromOffset(14, 14),
	Position = UDim2.new(1, -16, 1, -16),
	BackgroundTransparency = 1,
	Image = Icon.Resize,
	ImageTransparency = 0.4,
	Rotation = -35,
	ZIndex = 30,
	Parent = Main
})
ResizeHandle.ImageColor3 = getTheme().iconDim

local HoverTag = new("Frame", {
	Size = UDim2.fromOffset(80, 20),
	AutomaticSize = Enum.AutomaticSize.XY,
	Position = UDim2.fromOffset(0, 0),
	BackgroundTransparency = 0.1,
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 80,
	Parent = Main
})
bind(HoverTag, "BackgroundColor3", "cardHoverTag")
corner(HoverTag, 4)
pad(HoverTag, 8, 3, 8, 3)

local HoverTagText = new("TextLabel", {
	Size = UDim2.new(0, 0, 0, 14),
	AutomaticSize = Enum.AutomaticSize.XY,
	BackgroundTransparency = 1,
	TextColor3 = rgb(255, 255, 255),
	TextSize = 10,
	Font = FONT,
	ZIndex = 81,
	Parent = HoverTag
})

local Detail = new("Frame", {
	Size = UDim2.fromOffset(260, 200),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 50,
	Parent = Main
})
bind(Detail, "BackgroundColor3", "popup")
corner(Detail, 10)
addShadow(Detail)

local DetailClose, DetailCloseIcon = makeIconButton(Detail, 22, 12, Icon.Close, 52)
DetailClose.Position = UDim2.new(1, -28, 0, 6)
bind(DetailClose, "BackgroundColor3", "popupBtn")
bind(DetailCloseIcon, "ImageColor3", "iconDim")
softHover(DetailClose, DetailCloseIcon, 12, "iconDim", "iconHover")

local DetailPreview = new("ImageLabel", {
	Size = UDim2.fromOffset(48, 48),
	Position = UDim2.new(0.5, -24, 0, 24),
	BackgroundTransparency = 1,
	ScaleType = Enum.ScaleType.Fit,
	ZIndex = 52,
	Parent = Detail
})
bind(DetailPreview, "ImageColor3", "iconHover")

local DetailName = new("TextLabel", {
	Size = UDim2.new(1, -20, 0, 18),
	Position = UDim2.fromOffset(10, 80),
	BackgroundTransparency = 1,
	TextSize = 13,
	Font = FONT,
	TextTruncate = Enum.TextTruncate.AtEnd,
	ZIndex = 52,
	Parent = Detail
})
bind(DetailName, "TextColor3", "text")

local DetailID = new("TextLabel", {
	Size = UDim2.new(1, -20, 0, 14),
	Position = UDim2.fromOffset(10, 102),
	BackgroundTransparency = 1,
	TextSize = 10,
	Font = FONT,
	TextTruncate = Enum.TextTruncate.AtEnd,
	ZIndex = 52,
	Parent = Detail
})
bind(DetailID, "TextColor3", "textDim")

local ActionRow = new("Frame", {
	Size = UDim2.new(1, -24, 0, 32),
	Position = UDim2.new(0, 12, 1, -44),
	BackgroundTransparency = 1,
	ZIndex = 52,
	Parent = Detail
})

local DetailFavoriteButton, DetailFavoriteIcon, DetailFavoriteLabel = makeLabeledButton(ActionRow, "Favorite", Icon.Bookmark, 53)
DetailFavoriteButton.Size = UDim2.new(0.48, 0, 1, 0)
DetailFavoriteButton.Position = UDim2.fromOffset(0, 0)
bind(DetailFavoriteButton, "BackgroundColor3", "popupBtn")
hoverBind(DetailFavoriteButton, DetailFavoriteButton, "BackgroundColor3", "popupBtn", "popupBtnHover", "popupBtnPress")

local DetailCopyButton, DetailCopyIcon, DetailCopyLabel = makeLabeledButton(ActionRow, "Copy ID", Icon.Copy, 53)
DetailCopyButton.Size = UDim2.new(0.48, 0, 1, 0)
DetailCopyButton.Position = UDim2.new(0.52, 0, 0, 0)
bind(DetailCopyButton, "BackgroundColor3", "popupBtn")
bind(DetailCopyIcon, "ImageColor3", "icon")
bind(DetailCopyLabel, "TextColor3", "text")
hoverBind(DetailCopyButton, DetailCopyButton, "BackgroundColor3", "popupBtn", "popupBtnHover", "popupBtnPress")

local CloseConfirmation = new("Frame", {
	Size = UDim2.fromOffset(240, 130),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	BorderSizePixel = 0,
	Visible = false,
	ZIndex = 90,
	Parent = Main
})
bind(CloseConfirmation, "BackgroundColor3", "popup")
corner(CloseConfirmation, 10)
addShadow(CloseConfirmation)

local CloseConfirmTitle = new("TextLabel", {
	Size = UDim2.new(1, -20, 0, 20),
	Position = UDim2.fromOffset(10, 14),
	BackgroundTransparency = 1,
	Text = "Close Lucide Icons",
	TextSize = 12.5,
	Font = FONT,
	ZIndex = 91,
	Parent = CloseConfirmation
})
bind(CloseConfirmTitle, "TextColor3", "text")

local CloseConfirmDesc = new("TextLabel", {
	Size = UDim2.new(1, -20, 0, 28),
	Position = UDim2.fromOffset(10, 38),
	BackgroundTransparency = 1,
	Text = "Are you sure you want to close this window?",
	TextSize = 10,
	Font = FONT,
	TextWrapped = true,
	ZIndex = 91,
	Parent = CloseConfirmation
})
bind(CloseConfirmDesc, "TextColor3", "textDim")

local CloseConfirmActionRow = new("Frame", {
	Size = UDim2.new(1, -24, 0, 28),
	Position = UDim2.new(0, 12, 1, -38),
	BackgroundTransparency = 1,
	ZIndex = 91,
	Parent = CloseConfirmation
})

local CancelCloseButton = new("TextButton", {
	Size = UDim2.new(0.48, 0, 1, 0),
	Position = UDim2.fromOffset(0, 0),
	BorderSizePixel = 0,
	Text = "Cancel",
	TextSize = 11,
	Font = FONT,
	AutoButtonColor = false,
	ZIndex = 92,
	Parent = CloseConfirmActionRow
})
bind(CancelCloseButton, "BackgroundColor3", "popupBtn")
bind(CancelCloseButton, "TextColor3", "text")
corner(CancelCloseButton, 6)
hoverBind(CancelCloseButton, CancelCloseButton, "BackgroundColor3", "popupBtn", "popupBtnHover", "popupBtnPress")

local ConfirmCloseButton = new("TextButton", {
	Size = UDim2.new(0.48, 0, 1, 0),
	Position = UDim2.new(0.52, 0, 0, 0),
	BackgroundColor3 = RED,
	BorderSizePixel = 0,
	Text = "Close",
	TextColor3 = rgb(255, 255, 255),
	TextSize = 11,
	Font = FONT,
	AutoButtonColor = false,
	ZIndex = 92,
	Parent = CloseConfirmActionRow
})
corner(ConfirmCloseButton, 6)
do
	local hovering = false
	ConfirmCloseButton.MouseEnter:Connect(function()
		hovering = true
		tween(ConfirmCloseButton, {BackgroundColor3 = RED_HOVER}, 0.12)
	end)
	ConfirmCloseButton.MouseLeave:Connect(function()
		hovering = false
		tween(ConfirmCloseButton, {BackgroundColor3 = RED}, 0.12)
	end)
	ConfirmCloseButton.MouseButton1Down:Connect(function()
		tween(ConfirmCloseButton, {BackgroundColor3 = RED_PRESS}, 0.08)
	end)
	ConfirmCloseButton.MouseButton1Up:Connect(function()
		tween(ConfirmCloseButton, {BackgroundColor3 = hovering and RED_HOVER or RED}, 0.12)
	end)
end

local LoadingOverlay = new("Frame", {
	Size = UDim2.new(1, 0, 1, -35),
	Position = UDim2.fromOffset(0, 35),
	BorderSizePixel = 0,
	ZIndex = 70,
	Parent = Main
})
bind(LoadingOverlay, "BackgroundColor3", "panel")

local LoadingSpinner = new("ImageLabel", {
	Size = UDim2.fromOffset(32, 32),
	Position = UDim2.new(0.5, -16, 0.5, -28),
	BackgroundTransparency = 1,
	Image = Icon.Load,
	ZIndex = 71,
	Parent = LoadingOverlay
})
bind(LoadingSpinner, "ImageColor3", "iconHover")

local LoadingText = new("TextLabel", {
	Size = UDim2.new(1, 0, 0, 16),
	Position = UDim2.new(0, 0, 0.5, 12),
	BackgroundTransparency = 1,
	Text = "LOADING DATABASE...",
	TextSize = 10,
	Font = FONT,
	ZIndex = 71,
	Parent = LoadingOverlay
})
bind(LoadingText, "TextColor3", "textSub")

local pulseTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local pulseSpinnerTween = TweenService:Create(LoadingSpinner, pulseTweenInfo, {ImageTransparency = 0.65})
local pulseTextTween = TweenService:Create(LoadingText, pulseTweenInfo, {TextTransparency = 0.65})
pulseSpinnerTween:Play()
pulseTextTween:Play()

local spinConn: RBXScriptConnection? = nil
spinConn = RunService.RenderStepped:Connect(function(dt)
	if LoadingSpinner and LoadingSpinner.Parent then
		LoadingSpinner.Rotation = (LoadingSpinner.Rotation + dt * 100) % 360
	else
		if spinConn then
			spinConn:Disconnect()
			spinConn = nil
		end
	end
end)
trackConn(spinConn)

Gui.Destroying:Connect(function()
	for _, conn in ipairs(connections) do
		pcall(function()
			conn:Disconnect()
		end)
	end
	if sharedEnv[GUI_KEY] == Gui then
		sharedEnv[GUI_KEY] = nil
	end
end)

type IconData = {
	Name: string,
	Asset: string,
	ID: string,
	Category: string,
	RectSize: Vector2?,
	RectOffset: Vector2?
}

type CardRef = {
	Button: TextButton,
	Thumb: ImageLabel,
	Badge: ImageLabel
}

local BATCH_SIZE = 60
local currentIconSize = 24

local RawIconList: {IconData} = {}
local CategoryMap: {[string]: {IconData}} = {}
local CategoryNames: {string} = {}
local activeCategory = "All"
local isFavoriteFilterActive = false
local searchQuery = ""
local searchFocused = false

local filteredList: {IconData} = {}
local currentPage = 1
local totalPages = 1
local currentSelectedIcon: IconData? = nil

local cardRefs: {[string]: CardRef} = {}
local tabRefs: {[string]: TextButton} = {}
local tabInfo: {[string]: {x: number, w: number, tw: number}} = {}

local renderPage: () -> ()
local applyFilter: () -> ()

local resizeActive = false
local handleHover = false

local function applyIconImage(label: ImageLabel, iconData: IconData)
	label.Image = iconData.Asset
	if iconData.RectSize then
		label.ImageRectSize = iconData.RectSize
		label.ImageRectOffset = iconData.RectOffset or Vector2.new(0, 0)
	else
		label.ImageRectSize = Vector2.new(0, 0)
		label.ImageRectOffset = Vector2.new(0, 0)
	end
end

local function refreshSearchStroke()
	local th = getTheme()
	if searchFocused then
		tween(SearchStroke, {Color = th.strokeFocus, Transparency = 0}, 0.15)
	else
		tween(SearchStroke, {Color = th.stroke, Transparency = 0.5}, 0.15)
	end
end

local function refreshHandle()
	local th = getTheme()
	if resizeActive then
		tween(ResizeHandle, {ImageTransparency = 0, ImageColor3 = th.iconHover}, 0.12)
	elseif handleHover then
		tween(ResizeHandle, {ImageTransparency = 0.2, ImageColor3 = th.icon}, 0.12)
	else
		tween(ResizeHandle, {ImageTransparency = 0.4, ImageColor3 = th.iconDim}, 0.12)
	end
end

local function refreshFilterIcon()
	local th = getTheme()
	tween(FavoriteFilterIcon, {ImageColor3 = isFavoriteFilterActive and GOLD or th.iconDim}, 0.12)
end

local function setFavVisual(isFav: boolean)
	local th = getTheme()
	DetailFavoriteLabel.Text = isFav and "Favorited" or "Favorite"
	DetailFavoriteLabel.TextColor3 = isFav and GOLD or th.text
	DetailFavoriteIcon.ImageColor3 = isFav and GOLD or th.icon
end

local function refreshTabColors()
	local th = getTheme()
	for catName, btn in pairs(tabRefs) do
		tween(btn, {TextColor3 = (catName == activeCategory) and th.tabActiveText or th.tabIdleText}, 0.15)
	end
end

local function refreshPaginationState()
	PageIndicator.Text = tostring(currentPage) .. " / " .. tostring(math.max(1, totalPages))
	PreviousIcon.ImageTransparency = (currentPage <= 1) and 0.6 or 0
	NextIcon.ImageTransparency = (currentPage >= totalPages) and 0.6 or 0
end

local function applyTheme()
	local th = getTheme()
	for _, b in ipairs(bindings) do
		pcall(function()
			b[1][b[2]] = th[b[3]]
		end)
	end

	ThemeIcon.Image = (currentThemeName == "Monochrome") and Icon.ThemeMonochrome or Icon.ThemeLight
	Logo.Image = (currentThemeName == "Monochrome") and Icon.LogoMonochrome or Icon.LogoLight

	SearchStroke.Color = searchFocused and th.strokeFocus or th.stroke
	FavoriteFilterIcon.ImageColor3 = isFavoriteFilterActive and GOLD or th.iconDim

	if not resizeActive then
		ResizeHandle.ImageColor3 = handleHover and th.icon or th.iconDim
	else
		ResizeHandle.ImageColor3 = th.iconHover
	end

	for catName, btn in pairs(tabRefs) do
		btn.TextColor3 = (catName == activeCategory) and th.tabActiveText or th.tabIdleText
	end

	for _, ref in pairs(cardRefs) do
		ref.Button.BackgroundColor3 = th.card
		ref.Thumb.ImageColor3 = th.icon
	end

	if currentSelectedIcon then
		setFavVisual(favoritesSet[currentSelectedIcon.Name] == true)
	else
		setFavVisual(false)
	end
end

local function setGridIconSize(newSize: number)
	currentIconSize = math.clamp(newSize, 12, 48)
	SizeBox.Text = tostring(currentIconSize) .. "px"
	for _, ref in pairs(cardRefs) do
		ref.Thumb.Size = UDim2.fromOffset(currentIconSize, currentIconSize)
	end
end

local function updateGrid()
	local width = Content.AbsoluteSize.X - (CONTENT_PAD * 2) - Content.ScrollBarThickness
	if width <= 0 then
		return
	end
	local cols = math.clamp(math.floor(width / 64), 3, 10)
	local cellW = math.floor((width - (cols - 1) * 6) / cols)
	Grid.CellSize = UDim2.fromOffset(math.max(30, cellW), 54)
end

local function showDetail(icon: IconData)
	currentSelectedIcon = icon
	applyIconImage(DetailPreview, icon)
	DetailName.Text = icon.Name
	DetailID.Text = icon.ID
	DetailCopyLabel.Text = "Copy ID"
	setFavVisual(favoritesSet[icon.Name] == true)

	Detail.Visible = true
	Detail.Position = UDim2.new(0.5, 0, 0.5, 10)
	tween(Detail, {Position = UDim2.fromScale(0.5, 0.5)}, 0.18)
end

local function hideDetail()
	Detail.Visible = false
	currentSelectedIcon = nil
end

DetailClose.MouseButton1Click:Connect(hideDetail)

DetailFavoriteButton.MouseButton1Click:Connect(function()
	if currentSelectedIcon then
		local name = currentSelectedIcon.Name
		favoritesSet[name] = not favoritesSet[name]
		if not favoritesSet[name] then
			favoritesSet[name] = nil
		end
		saveFavorites()

		local isFav = favoritesSet[name] == true
		setFavVisual(isFav)

		local ref = cardRefs[name]
		if ref then
			ref.Badge.Visible = isFav
		end

		if isFavoriteFilterActive then
			applyFilter()
		end
	end
end)

DetailCopyButton.MouseButton1Click:Connect(function()
	if currentSelectedIcon then
		local ok = safeSetClipboard(string.format('%s = "rbxassetid://%s"', currentSelectedIcon.Name, currentSelectedIcon.ID))
		if ok then
			DetailCopyLabel.Text = "COPIED!"
			task.delay(1, function()
				if DetailCopyButton.Parent and currentSelectedIcon then
					DetailCopyLabel.Text = "Copy ID"
				end
			end)
		end
	end
end)

local function clearGrid()
	for _, ref in pairs(cardRefs) do
		pcall(function()
			ref.Button:Destroy()
		end)
	end
	cardRefs = {}
end

renderPage = function()
	clearGrid()
	local th = getTheme()
	local startIndex = (currentPage - 1) * BATCH_SIZE + 1
	local endIndex = math.min(currentPage * BATCH_SIZE, #filteredList)

	for i = startIndex, endIndex do
		local iconData = filteredList[i]

		local Button = new("TextButton", {
			LayoutOrder = i,
			Size = UDim2.fromOffset(58, 54),
			BackgroundColor3 = th.card,
			BorderSizePixel = 0,
			Text = "",
			AutoButtonColor = false,
			Parent = Content
		})
		corner(Button, 8)

		local Thumbnail = new("ImageLabel", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(currentIconSize, currentIconSize),
			BackgroundTransparency = 1,
			ImageColor3 = th.icon,
			ScaleType = Enum.ScaleType.Fit,
			Parent = Button
		})
		applyIconImage(Thumbnail, iconData)

		local FavoriteBadge = new("ImageLabel", {
			Size = UDim2.fromOffset(10, 10),
			Position = UDim2.new(1, -12, 0, 4),
			BackgroundTransparency = 1,
			Image = Icon.Bookmark,
			ImageColor3 = GOLD,
			Visible = (favoritesSet[iconData.Name] == true),
			Parent = Button
		})

		cardRefs[iconData.Name] = {Button = Button, Thumb = Thumbnail, Badge = FavoriteBadge}

		local hovering = false

		Button.MouseEnter:Connect(function()
			hovering = true
			local live = getTheme()
			tween(Button, {BackgroundColor3 = live.cardHover}, 0.12)
			tween(Thumbnail, {
				ImageColor3 = live.iconHover,
				Size = UDim2.fromOffset(currentIconSize + 4, currentIconSize + 4)
			}, 0.14, Enum.EasingStyle.Back)

			HoverTagText.Text = iconData.Name
			local absPos = Button.AbsolutePosition
			local mainPos = Main.AbsolutePosition
			local relX = (absPos.X - mainPos.X) + (Button.AbsoluteSize.X / 2) - (HoverTag.AbsoluteSize.X / 2)
			local relY = (absPos.Y - mainPos.Y) - 22

			relX = math.clamp(relX, 6, math.max(6, Main.AbsoluteSize.X - HoverTag.AbsoluteSize.X - 6))
			HoverTag.Position = UDim2.fromOffset(relX, relY)
			HoverTag.Visible = true
		end)

		Button.MouseLeave:Connect(function()
			hovering = false
			local live = getTheme()
			tween(Button, {BackgroundColor3 = live.card}, 0.12)
			tween(Thumbnail, {
				ImageColor3 = live.icon,
				Size = UDim2.fromOffset(currentIconSize, currentIconSize)
			}, 0.12)
			HoverTag.Visible = false
		end)

		Button.MouseButton1Down:Connect(function()
			tween(Thumbnail, {
				Size = UDim2.fromOffset(currentIconSize - 2, currentIconSize - 2)
			}, 0.08)
		end)

		Button.MouseButton1Up:Connect(function()
			local extra = hovering and 4 or 0
			tween(Thumbnail, {
				Size = UDim2.fromOffset(currentIconSize + extra, currentIconSize + extra)
			}, 0.14, Enum.EasingStyle.Back)
		end)

		Button.MouseButton1Click:Connect(function()
			HoverTag.Visible = false
			showDetail(iconData)
		end)
	end

	refreshPaginationState()
	Content.CanvasPosition = Vector2.new(0, 0)
end

applyFilter = function()
	local rawText = SearchBox.Text or ""
	local query = string.lower(rawText)
	query = string.gsub(query, "^%s+", "")
	query = string.gsub(query, "%s+$", "")
	searchQuery = query

	local baseList: {IconData}
	if activeCategory == "All" then
		baseList = RawIconList
	else
		baseList = CategoryMap[activeCategory] or {}
	end

	filteredList = {}
	for _, icon in ipairs(baseList) do
		local matchFav = (not isFavoriteFilterActive) or (favoritesSet[icon.Name] == true)
		if matchFav then
			if query == "" then
				table.insert(filteredList, icon)
			else
				local nameMatch = icon.Name:lower():find(query, 1, true) ~= nil
				local idMatch = icon.ID:find(query, 1, true) ~= nil
				if nameMatch or idMatch then
					table.insert(filteredList, icon)
				end
			end
		end
	end

	totalPages = math.max(1, math.ceil(#filteredList / BATCH_SIZE))
	if currentPage > totalPages then
		currentPage = totalPages
	end
	if currentPage < 1 then
		currentPage = 1
	end

	renderPage()
end

local function measureText(str: string): number
	local ok, size = pcall(function()
		return TextService:GetTextSize(str, 11, FONT, Vector2.new(1000, 20))
	end)
	if ok and size then
		return size.X
	end
	return #str * 7
end

local function updateTabIndicator(catName: string)
	local info = tabInfo[catName]
	if not info then
		return
	end
	local th = getTheme()
	tween(TabIndicator, {
		Position = UDim2.fromOffset(info.x + (info.w - info.tw) / 2, 22),
		Size = UDim2.fromOffset(info.tw, 2),
		BackgroundColor3 = th.tabActiveText
	}, 0.22)

	local scrollX = CategoryTabs.CanvasPosition.X
	local viewW = CategoryTabs.AbsoluteSize.X
	local target: number? = nil
	if info.x < scrollX then
		target = math.max(0, info.x - 10)
	elseif info.x + info.w > scrollX + viewW then
		target = info.x + info.w - viewW + 10
	end
	if target then
		tween(CategoryTabs, {CanvasPosition = Vector2.new(target, 0)}, 0.22)
	end
end

local function populateCategories()
	for _, btn in pairs(tabRefs) do
		pcall(function()
			btn:Destroy()
		end)
	end
	tabRefs = {}
	tabInfo = {}

	CategoryNames = {}
	for catName in pairs(CategoryMap) do
		table.insert(CategoryNames, catName)
	end
	table.sort(CategoryNames, function(a, b)
		if a == "Other" then return false end
		if b == "Other" then return true end
		return a < b
	end)
	table.insert(CategoryNames, 1, "All")

	local th = getTheme()
	local currentX = 0

	for _, catName in ipairs(CategoryNames) do
		local textW = measureText(catName)
		local btnW = textW + 16

		local TabBtn = new("TextButton", {
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = catName,
			TextColor3 = (catName == activeCategory) and th.tabActiveText or th.tabIdleText,
			TextSize = 11,
			Font = FONT,
			AutoButtonColor = false,
			Size = UDim2.fromOffset(btnW, 20),
			Position = UDim2.fromOffset(currentX, 0),
			Parent = CategoryTabs
		})

		tabRefs[catName] = TabBtn
		tabInfo[catName] = {x = currentX, w = btnW, tw = textW}
		currentX = currentX + btnW + 4

		TabBtn.MouseEnter:Connect(function()
			if activeCategory ~= catName then
				tween(TabBtn, {TextColor3 = getTheme().tabActiveText}, 0.12)
			end
		end)

		TabBtn.MouseLeave:Connect(function()
			local live = getTheme()
			tween(TabBtn, {TextColor3 = (activeCategory == catName) and live.tabActiveText or live.tabIdleText}, 0.12)
		end)

		TabBtn.MouseButton1Click:Connect(function()
			if activeCategory ~= catName then
				activeCategory = catName
				refreshTabColors()
				updateTabIndicator(catName)
				currentPage = 1
				applyFilter()
			end
		end)
	end

	CategoryTabs.CanvasSize = UDim2.fromOffset(currentX, 0)
	if not tabInfo[activeCategory] then
		activeCategory = "All"
	end
	updateTabIndicator(activeCategory)
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	currentPage = 1
	applyFilter()
end)

SearchBox.Focused:Connect(function()
	searchFocused = true
	refreshSearchStroke()
	tween(SearchIcon, {ImageColor3 = getTheme().icon}, 0.15)
end)

SearchBox.FocusLost:Connect(function()
	searchFocused = false
	refreshSearchStroke()
	tween(SearchIcon, {ImageColor3 = getTheme().iconDim}, 0.15)
end)

FavoriteFilterButton.MouseEnter:Connect(function()
	tween(FavoriteFilterButton, {BackgroundTransparency = 0}, 0.12)
end)
FavoriteFilterButton.MouseLeave:Connect(function()
	tween(FavoriteFilterButton, {BackgroundTransparency = 1}, 0.12)
end)
pressIcon(FavoriteFilterButton, FavoriteFilterIcon, 14)

FavoriteFilterButton.MouseButton1Click:Connect(function()
	isFavoriteFilterActive = not isFavoriteFilterActive
	refreshFilterIcon()
	currentPage = 1
	applyFilter()
end)

PreviousButton.MouseButton1Click:Connect(function()
	if currentPage > 1 then
		currentPage = currentPage - 1
		renderPage()
	end
end)

NextButton.MouseButton1Click:Connect(function()
	if currentPage < totalPages then
		currentPage = currentPage + 1
		renderPage()
	end
end)

StepUpButton.MouseButton1Click:Connect(function()
	setGridIconSize(currentIconSize + 2)
end)

StepDownButton.MouseButton1Click:Connect(function()
	setGridIconSize(currentIconSize - 2)
end)

SizeBox.FocusLost:Connect(function()
	local num = tonumber(SizeBox.Text:match("%d+"))
	if num then
		setGridIconSize(num)
	else
		SizeBox.Text = tostring(currentIconSize) .. "px"
	end
end)

ThemeButton.MouseButton1Click:Connect(function()
	currentThemeName = (currentThemeName == "Monochrome") and "Light" or "Monochrome"

	tween(ThemeIcon, {Rotation = ThemeIcon.Rotation + 360}, 0.3, Enum.EasingStyle.Back)

	applyTheme()
	updateTabIndicator(activeCategory)
end)

CloseButton.MouseButton1Click:Connect(function()
	CloseConfirmation.Visible = true
	CloseConfirmation.Position = UDim2.new(0.5, 0, 0.5, 12)
	tween(CloseConfirmation, {Position = UDim2.fromScale(0.5, 0.5)}, 0.18)
end)

CancelCloseButton.MouseButton1Click:Connect(function()
	CloseConfirmation.Visible = false
end)

ConfirmCloseButton.MouseButton1Click:Connect(function()
	pcall(function()
		Gui:Destroy()
	end)
end)

ResizeHandle.MouseEnter:Connect(function()
	handleHover = true
	if not resizeActive then
		refreshHandle()
	end
end)

ResizeHandle.MouseLeave:Connect(function()
	handleHover = false
	if not resizeActive then
		refreshHandle()
	end
end)

local function dragify(target: Frame, handle: GuiObject)
	local dragging = false
	local dragStart: Vector3 = Vector3.new(0, 0, 0)
	local startPos: UDim2 = UDim2.new()

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position
		end
	end)

	trackConn(UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end))

	trackConn(UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end))
end

local function resizefy(target: Frame, handle: GuiObject, minSize: Vector2)
	local dragStart: Vector3 = Vector3.new(0, 0, 0)
	local startSize: Vector2 = Vector2.new(0, 0)

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizeActive = true
			dragStart = input.Position
			startSize = target.AbsoluteSize
			refreshHandle()
		end
	end)

	trackConn(UserInputService.InputEnded:Connect(function(input)
		if resizeActive and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			resizeActive = false
			refreshHandle()
		end
	end))

	trackConn(UserInputService.InputChanged:Connect(function(input)
		if resizeActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			local newX = math.max(minSize.X, startSize.X + delta.X)
			local newY = math.max(minSize.Y, startSize.Y + delta.Y)
			target.Size = UDim2.fromOffset(newX, newY)
		end
	end))
end

dragify(Main, Header)
resizefy(Main, ResizeHandle, Vector2.new(370, 260))

Content:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateGrid)

local function requestHttp(url: string): (boolean, string)
	local lastErr = "No supported HTTP client method found in environment"

	local attempts = {
		function()
			return game:HttpGet(url, true)
		end,
		function()
			return game:HttpGet(url)
		end,
		function()
			return game:HttpGetAsync(url)
		end,
		function()
			local req = (syn and syn.request) or (http and http.request) or http_request or request
			if type(req) ~= "function" then
				error("no request function")
			end
			local res = req({Url = url, Method = "GET"})
			if type(res) == "table" and type(res.Body) == "string" then
				return res.Body
			end
			error("request returned no body")
		end,
		function()
			return HttpService:GetAsync(url)
		end
	}

	for _, attempt in ipairs(attempts) do
		local ok, body = pcall(attempt)
		if ok and type(body) == "string" and #body > 0 then
			return true, body
		elseif not ok then
			lastErr = tostring(body)
		end
	end

	return false, lastErr
end

local function toAssetString(v: any): string?
	if type(v) == "number" then
		return "rbxassetid://" .. tostring(math.floor(v))
	end
	if type(v) == "string" and #v > 0 then
		if v:match("^%d+$") then
			return "rbxassetid://" .. v
		end
		return v
	end
	return nil
end

local function toVector2(v: any): Vector2?
	if typeof(v) == "Vector2" then
		return v
	end
	if type(v) == "table" then
		local x = v.X or v.x or v[1]
		local y = v.Y or v.y or v[2]
		if type(x) == "number" and type(y) == "number" then
			return Vector2.new(x, y)
		end
	end
	return nil
end

local function locateIconMap(db: any): (any, any)
	local spritesheets = db.Spritesheets or db.spritesheets
	local map = db.Icons or db.icons or db
	if type(map) == "table" then
		if type(map.lucide) == "table" then
			map = map.lucide
		elseif type(map.Lucide) == "table" then
			map = map.Lucide
		end
	end
	return map, spritesheets
end

local function parseEntry(name: string, value: any, spritesheets: any): IconData?
	local asset: string? = nil
	local rectSize: Vector2? = nil
	local rectOffset: Vector2? = nil

	if type(value) == "table" then
		local image = value.Image or value.Asset or value.Id or value.ID or value.image or value[1]
		local sheet = nil
		if type(spritesheets) == "table" and image ~= nil then
			sheet = spritesheets[tostring(image)] or spritesheets[image]
		end
		asset = toAssetString(sheet) or toAssetString(image)
		rectSize = toVector2(value.ImageRectSize or value.RectSize or value.Size or value.size)
		rectOffset = toVector2(value.ImageRectPosition or value.ImageRectOffset or value.RectOffset or value.Position or value.position)
	else
		asset = toAssetString(value)
	end

	if not asset then
		return nil
	end

	local numId = asset:match("(%d+)$") or asset
	return {
		Name = name,
		Asset = asset,
		ID = numId,
		Category = "Other",
		RectSize = rectSize,
		RectOffset = rectOffset
	}
end

local function groupPrefix(name: string): string
	local clean = name:gsub("^[Ll]ucide[%-:]", "")
	local first = clean:match("^(%a+)")
	if first and #first < 3 then
		local second = clean:match("^%a+%-(%a+)")
		if second and #second >= 3 then
			first = second
		end
	end
	if first and #first >= 2 then
		return first:sub(1, 1):upper() .. first:sub(2):lower()
	end
	return "Other"
end

local function assignCategories(list: {IconData})
	local counts: {[string]: number} = {}
	for _, item in ipairs(list) do
		local prefix = groupPrefix(item.Name)
		item.Category = prefix
		counts[prefix] = (counts[prefix] or 0) + 1
	end
	for _, item in ipairs(list) do
		if item.Category ~= "Other" and (counts[item.Category] or 0) < MIN_GROUP_SIZE then
			item.Category = "Other"
		end
	end
end

local function failLoading(message: string)
	LoadingText.Text = message
	LoadingText.TextColor3 = rgb(255, 80, 80)
	pcall(function() pulseSpinnerTween:Cancel() end)
	pcall(function() pulseTextTween:Cancel() end)
end

local function loadDatabase()
	LoadingText.Text = "LOADING DATABASE..."
	LoadingText.TextColor3 = getTheme().textSub

	local httpSuccess, rawSource = requestHttp(Icon_url)
	if not httpSuccess or type(rawSource) ~= "string" or #rawSource == 0 then
		warn("[Lucide Icons] Failed to load icon database from URL: " .. tostring(rawSource))
		failLoading("FAILED TO LOAD DATABASE")
		return
	end

	local compile = loadstring or load
	if type(compile) ~= "function" then
		warn("[Lucide Icons] loadstring is not available in this executor")
		failLoading("LOADSTRING UNAVAILABLE")
		return
	end

	local parseSuccess, loaderChunk, parseErr = pcall(function()
		local fn, err = compile(rawSource)
		return fn, err
	end)
	if not parseSuccess or type(loaderChunk) ~= "function" then
		warn("[Lucide Icons] Failed to parse icon database: " .. tostring(parseSuccess and parseErr or loaderChunk))
		failLoading("FAILED TO PARSE DATABASE")
		return
	end

	local execSuccess, database = pcall(loaderChunk)
	if not execSuccess or type(database) ~= "table" then
		warn("[Lucide Icons] Failed to execute icon database loader: " .. tostring(database))
		failLoading("INVALID DATABASE FORMAT")
		return
	end

	RawIconList = {}
	CategoryMap = {}

	local iconMap, spritesheets = locateIconMap(database)
	if type(iconMap) == "table" then
		for name, value in pairs(iconMap) do
			if type(name) == "string" then
				local ok, item = pcall(parseEntry, name, value, spritesheets)
				if ok and item then
					table.insert(RawIconList, item)
				end
			end
		end
	end

	if #RawIconList == 0 then
		warn("[Lucide Icons] Database loaded but contains 0 icons")
		failLoading("DATABASE IS EMPTY")
		return
	end

	table.sort(RawIconList, function(a, b)
		return a.Name < b.Name
	end)

	assignCategories(RawIconList)
	for _, item in ipairs(RawIconList) do
		if not CategoryMap[item.Category] then
			CategoryMap[item.Category] = {}
		end
		table.insert(CategoryMap[item.Category], item)
	end

	populateCategories()
	updateGrid()
	applyFilter()

	pulseSpinnerTween:Cancel()
	pulseTextTween:Cancel()
	if spinConn then
		spinConn:Disconnect()
		spinConn = nil
	end

	tween(LoadingSpinner, {ImageTransparency = 1}, 0.25)
	tween(LoadingText, {TextTransparency = 1}, 0.25)
	local fadeOverlay = tween(LoadingOverlay, {BackgroundTransparency = 1}, 0.25)
	fadeOverlay.Completed:Connect(function()
		if LoadingOverlay and LoadingOverlay.Parent then
			LoadingOverlay:Destroy()
		end
	end)
end

task.defer(function()
	task.wait(0.2)
	local ok, err = pcall(loadDatabase)
	if not ok then
		warn("[Lucide Icons] Unexpected error while loading: " .. tostring(err))
		failLoading("UNEXPECTED ERROR")
	end
end)
