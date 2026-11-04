-- Ecode | Creator: NarsEdv (Fixed & Optimized)
-- Luau script editor for Roblox executors

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

local function generateName()
	local chars = {}
	for i = 1, 32 do
		chars[i] = string.char(math.random(97, 122))
	end
	return "_ECNarsEdv_" .. table.concat(chars)
end

local Services = {
	Players = game:GetService("Players"),
	UserInputService = game:GetService("UserInputService"),
	RunService = game:GetService("RunService"),
	TweenService = game:GetService("TweenService"),
	LogService = game:GetService("LogService"),
	TextService = game:GetService("TextService"),
	Stats = game:GetService("Stats"),
	HttpService = game:GetService("HttpService"),
}

local isfolder = executorEnv.isfolder
local makefolder = executorEnv.makefolder
local delfolder = executorEnv.delfolder or executorEnv.rmdir
local isfile = executorEnv.isfile
local readfile = executorEnv.readfile
local writefile = executorEnv.writefile
local delfile = executorEnv.delfile
local listfiles = executorEnv.listfiles
local setclipboard = executorEnv.setclipboard or executorEnv.toclipboard
local executorLoadstring = executorEnv.loadstring

local function identifyExecutor(): (string, string)
	local fn = executorEnv.identifyexecutor or executorEnv.getexecutorname
	if type(fn) == "function" then
		local ok, name, ver = pcall(fn)
		if ok and name then
			return tostring(name), ver and tostring(ver) or ""
		end
	end
	return "Ecode", "v0.04"
end

for _, child in ipairs(host:GetChildren()) do
	local ok, marked = pcall(function()
		return child:GetAttribute("NarsEdvEcode")
	end)
	if ok and marked == true then
		child:Destroy()
	end
end

local Icon = {
	Logo = "rbxassetid://122926744824622",
	Menu = "rbxassetid://139359175473641",
	Close = "rbxassetid://6031094678",
	Minimize = "rbxassetid://122268389930903",
	Maximize = "rbxassetid://73085922906397",
	Restore = "rbxassetid://111576059685335",
	Open = "rbxassetid://100744567525223",
	Search = "rbxassetid://91918048389224",
	TabClose = "rbxassetid://6031094678",
	TabAdd = "rbxassetid://113157136350384",
	Execute = "rbxassetid://110313200539368",
	Clear = "rbxassetid://133957773112410",
	Save = "rbxassetid://92075517294398",
	Copy = "rbxassetid://78979572434545",
	FileIcon = "rbxassetid://78293841184371",
	FolderIcon = "rbxassetid://76503133419260",
	ModuleIcon = "rbxassetid://81624079116919",
	ScriptIcon = "rbxassetid://138263002165322",
	LocalScriptIcon = "rbxassetid://132416026057348",
	ConsoleIcon = "rbxassetid://106783148545356",
	Discord = "rbxassetid://124918347913410",
	ArrowUp = "rbxassetid://117796781690923",
	ArrowDown = "rbxassetid://136612013728069",
	ArrowLeft = "rbxassetid://73780377692148",
	ArrowRight = "rbxassetid://92473583511724",
	Delete = "rbxassetid://126279426372342",
	Code = "rbxassetid://100744567525223",
	Terminal = "rbxassetid://106783148545356",
	ResizeCornerHandle = "rbxassetid://103321376129527",
	ACCodeSnippet = "rbxassetid://77949171627703",
	ACEnum = "rbxassetid://83431420464815",
	ACEvent = "rbxassetid://91990940043209",
	ACFunction = "rbxassetid://114075599845322",
	ACKeyword = "rbxassetid://86095368048523",
	ACProperty = "rbxassetid://101594010467870",
	ACText = "rbxassetid://119854595252628",
	ACVariable = "rbxassetid://101594010467870",
	Settings = "rbxassetid://97764716713536",
	Checklist = "rbxassetid://93898873302694",
	Banner = "rbxassetid://123479937842693",
	SettingsExecutor = "",
	SettingsLicense = "",
	SettingsVersion = "",
	SettingsAbout = "",
	SettingsSunc = "",
	SettingsCommunity = "",
	SettingsSyntax = "",
	SettingsAutocomplete = "",
	SettingsAutoIndent = "",
	SettingsAutoClose = "",
	SettingsLineNumbers = "",
	SettingsActiveLine = "",
	SettingsFontSize = "",
	SettingsClearConsole = "",
	SettingsAutoSave = "",
	SettingsConfirmClose = "",
	SettingsReset = "",
}

local Community = {
	DiscordInvite = "https://discord.gg/qgYtJec7rt",
}

local SuncApiOrder = {
	{"checkcaller", "clonefunction", "getfunctionhash", "hookfunction", "hookmetamethod", "iscclosure", "isexecutorclosure", "islclosure", "loadstring", "newcclosure", "restorefunction"},
	{"debug.getconstant", "debug.getconstants", "debug.getproto", "debug.getprotos", "debug.getstack", "debug.getupvalue", "debug.getupvalues", "debug.setconstant", "debug.setstack", "debug.setupvalue"},
	{"Drawing.new", "cleardrawcache", "getrenderproperty", "isrenderobj", "setrenderproperty"},
	{"base64decode", "base64encode", "lz4compress", "lz4decompress"},
	{"getgc", "getgenv", "getreg", "getrenv", "filtergc"},
	{"appendfile", "delfile", "delfolder", "getcustomasset", "isfile", "isfolder", "listfiles", "loadfile", "makefolder", "readfile", "writefile"},
	{"cloneref", "compareinstances", "fireclickdetector", "fireproximityprompt", "firetouchinterest", "getcallbackvalue", "gethui", "getinstances", "getnilinstances"},
	{"getnamecallmethod", "getrawmetatable", "isreadonly", "setrawmetatable", "setreadonly"},
	{"identifyexecutor", "request"},
	{"gethiddenproperty", "getthreadidentity", "isscriptable", "sethiddenproperty", "setscriptable", "setthreadidentity"},
	{"getcallingscript", "getloadedmodules", "getrunningscripts", "getscriptbytecode", "getscriptclosure", "getscriptfromthread", "getscripthash", "getscripts", "getsenv"},
	{"firesignal", "getconnections", "replicatesignal"},
	{"WebSocket.connect"},
}

local Theme = {
	PanelBg = Color3.fromRGB(8, 8, 8),
	Black = Color3.fromRGB(0, 0, 0),
	Surface = Color3.fromRGB(10, 10, 10),
	SurfaceElevated = Color3.fromRGB(16, 16, 16),
	ToolbarBg = Color3.fromRGB(16, 16, 16),
	ToolbarBorder = Color3.fromRGB(35, 35, 35),
	ActiveLine = Color3.fromRGB(24, 24, 26), -- Hitam agak cerah untuk highlight baris aktif
	Line = Color3.fromRGB(20, 20, 20),
	DividerDark = Color3.fromRGB(14, 14, 14), -- Garis batas explorer dan editor code lebih gelap
	Muted = Color3.fromRGB(130, 130, 130),
	MutedDark = Color3.fromRGB(70, 70, 70),
	GutterNum = Color3.fromRGB(110, 110, 110),
	White = Color3.fromRGB(240, 240, 240),
	Green = Color3.fromRGB(34, 197, 94),
	Yellow = Color3.fromRGB(234, 179, 8),
	Red = Color3.fromRGB(239, 68, 68),
	Hover = Color3.fromRGB(22, 22, 22),
	Selection = Color3.fromRGB(24, 24, 26),
	ItemActive = Color3.fromRGB(32, 32, 36),
}

local Fonts = {
	Bold = Enum.Font.GothamBold,
	Medium = Enum.Font.GothamMedium,
	Regular = Enum.Font.Gotham,
	Code = Enum.Font.Code,
}

local CODE_TEXT_SIZE = 14
local CODE_LINE_HEIGHT = 1.15

local Sizes = {
	Title = 14,
	Card = 12,
	Explorer = 12,
	Code = CODE_TEXT_SIZE,
	Input = 11,
	Body = 10,
	Tag = 10,
	Tab = 10,
}

local EDITOR_AUTO_INDENT = true
local EDITOR_AUTO_PAIR = true

local Config = {
	syntax = true,
	autocomplete = true,
	autoIndent = true,
	autoClose = true,
	lineNumbers = true,
	activeLine = true,
	fontSize = 14,
	clearConsoleOnRun = false,
	autoSaveOnRun = false,
	confirmClose = true,
}

local ConfigDefaults = {}
for key, value in pairs(Config) do
	ConfigDefaults[key] = value
end

local CODE_PLACEHOLDER = "-- Ecode | Editor code lua/luau\n-- Creator : NarsEdv | version 0.04\n-- Link Discord https://discord.gg/qgYtJec7rt"
local CODE_TEXT_COLOR = Color3.fromRGB(220, 220, 220)
local CODE_PLACEHOLDER_COLOR = Color3.fromRGB(130, 130, 130)

local SETTINGS_FILE = "Ecode_settings.json"

local function loadSettings()
	if type(isfile) ~= "function" or type(readfile) ~= "function" then
		return
	end
	local okExists, exists = pcall(isfile, SETTINGS_FILE)
	if not okExists or exists ~= true then
		return
	end
	local okRead, raw = pcall(readfile, SETTINGS_FILE)
	if not okRead or type(raw) ~= "string" or raw == "" then
		return
	end
	local okDecode, data = pcall(function()
		return Services.HttpService:JSONDecode(raw)
	end)
	if not okDecode or type(data) ~= "table" then
		return
	end
	for key, default in pairs(ConfigDefaults) do
		local value = data[key]
		if type(value) == type(default) then
			if key == "fontSize" then
				value = math.clamp(math.floor(value + 0.5), 10, 20)
			end
			Config[key] = value
		end
	end
end

local function saveSettings()
	if type(writefile) ~= "function" then
		return
	end
	pcall(function()
		writefile(SETTINGS_FILE, Services.HttpService:JSONEncode(Config))
	end)
end

loadSettings()
EDITOR_AUTO_INDENT = Config.autoIndent
EDITOR_AUTO_PAIR = Config.autoClose
CODE_TEXT_SIZE = Config.fontSize

local Syntax = {
	Keyword = "#F86D7C",
	Builtin = "#61AFEF",
	Method  = "#E5C07B",
	String  = "#98C379",
	Number  = "#D19A66",
	Comment = "#5C6370",
	Operator= "#56B6C2",
}

local LUAU_KEYWORDS = {
	"local", "function", "return", "if", "then", "else", "elseif", "end",
	"for", "while", "repeat", "until", "do", "in", "and", "or", "not",
	"true", "false", "nil", "break", "continue", "type", "typeof", "export", "self"
}

local KEYWORD_SET = {}
for _, word in ipairs(LUAU_KEYWORDS) do
	KEYWORD_SET[word] = true
end

local LUAU_BUILTINS = {
	"game", "workspace", "script", "Instance", "Vector3", "Vector2", "CFrame", "Color3",
	"UDim2", "UDim", "Enum", "TweenInfo", "NumberRange", "NumberSequence", "ColorSequence",
	"math", "table", "string", "task", "coroutine", "os", "debug", "utf8", "bit32",
	"print", "warn", "error", "pcall", "xpcall", "assert", "require", "tostring", "tonumber",
	"tick", "time", "typeof", "select", "pairs", "ipairs", "next", "unpack", "rawget", "rawset",
	"identifyexecutor", "getgenv", "getrenv", "getrawmetatable", "setreadonly", "setclipboard",
	"readfile", "writefile", "delfile", "isfile", "isfolder", "makefolder", "delfolder", "listfiles",
	"loadstring", "hookfunction", "newcclosure", "cloneref", "fireclickdetector", "fireproximityprompt"
}

local BUILTIN_SET = {}
for _, word in ipairs(LUAU_BUILTINS) do
	BUILTIN_SET[word] = true
end

local API_METHODS = {
	"GetService", "FindFirstChild", "FindFirstChildOfClass", "WaitForChild", "Destroy",
	"Clone", "ClearAllChildren", "GetChildren", "GetDescendants", "Connect", "Disconnect",
	"FireServer", "InvokeServer", "Fire", "Wait", "Create", "Play", "Pause", "Stop",
	"new", "fromOffset", "fromScale", "fromRGB", "fromHSV", "fromHex", "Lerp", "spawn",
	"delay", "defer", "cancel", "insert", "remove", "concat", "sort", "find"
}

local METHOD_SET = {}
for _, word in ipairs(API_METHODS) do
	METHOD_SET[word] = true
end

local ROOT_PATH = "Ecode"
local SUPPORTED_EXTENSIONS = { txt = true, json = true, lua = true, luau = true }

local State = {
	tabs = {},
	activeTabId = nil,
	tabCounter = 0,
	expand = { [ROOT_PATH] = true },
	selectedPath = nil,
	selectedIsFolder = false,
	rowOrder = 0,
	saveFolder = ROOT_PATH,
	insertParent = ROOT_PATH,
	consoleCollapsed = false,
	logs = {},
	logRows = {},
	logCounter = 0,
	suggestions = {},
	selectedIndex = 1,
	focused = false,
	lastCursor = 1,
	activeLine = 1,
	activeCol = 1,
	isMaximized = false,
	lastCustomSize = UDim2.fromOffset(600, 370),
	lastCustomPos = UDim2.new(0.5, -300, 0.5, -185),
	popupPressed = false,
}

local connections = {}
local function connect(signal: RBXScriptSignal, callback: (...any) -> ())
	local connection = signal:Connect(callback)
	table.insert(connections, connection)
	return connection
end

local function normalizePath(path: string?): string
	if not path then return "" end
	local norm = path:gsub("\\", "/")
	norm = norm:gsub("//+", "/")
	norm = norm:gsub("^/", "")
	norm = norm:gsub("/$", "")
	return norm
end

local function sanitizeName(name: string?): string
	if not name then return "" end
	local clean = name:gsub("[\\/:*?\"<>|%c]", "")
	clean = clean:gsub("%.%.+", ".")
	clean = clean:gsub("^%.+", "")
	clean = clean:gsub("^%s+", "")
	clean = clean:gsub("%s+$", "")
	return clean
end

local function getExtension(name: string): string?
	local ext = name:match("%.([^%.]+)$")
	return ext and ext:lower() or nil
end

local function ensureSupportedName(name: string, fallbackExt: string?): string
	local ext = getExtension(name)
	if ext and SUPPORTED_EXTENSIONS[ext] then return name end
	return name .. "." .. (fallbackExt or "lua")
end

local function getBasename(path: string?): string
	if not path then return "" end
	local norm = normalizePath(path)
	return norm:match("[^/]+$") or norm
end

local function getDirectory(path: string?): string
	if not path then return ROOT_PATH end
	local norm = normalizePath(path)
	return norm:match("^(.*)/[^/]+$") or ROOT_PATH
end

local function isInsideRoot(path: string?): boolean
	local norm = normalizePath(path)
	return norm == ROOT_PATH or norm:sub(1, #ROOT_PATH + 1) == ROOT_PATH .. "/"
end

local function formatBreadcrumb(fullPath: string?): string
	if not fullPath then return ROOT_PATH end
	return (normalizePath(fullPath):gsub("/", " / "))
end

local function pathExists(path: string): boolean
	if type(isfile) == "function" then
		local ok, result = pcall(isfile, path)
		if ok and result == true then return true end
	end
	if type(isfolder) == "function" then
		local ok, result = pcall(isfolder, path)
		if ok and result == true then return true end
	end
	return false
end

local function uniqueName(dir: string, base: string, ext: string): string
	local name = base .. ext
	local index = 1
	while pathExists(normalizePath(dir .. "/" .. name)) do
		name = base .. tostring(index) .. ext
		index = index + 1
	end
	return name
end

local function ensureRoot()
	if type(isfolder) == "function" and type(makefolder) == "function" then
		pcall(function()
			if not isfolder(ROOT_PATH) then
				makefolder(ROOT_PATH)
			end
		end)
	end
end
ensureRoot()

local function make(className: string, key: string?, props: {[string]: any}?, parent: Instance?): any
	local inst = Instance.new(className)
	pcall(function() inst.Name = generateName() end)
	if props then
		for prop, value in pairs(props) do
			inst[prop] = value
		end
	end
	if key then GUI[key] = inst end
	if parent then inst.Parent = parent end
	return inst
end

local function round(inst: Instance, radius: number?)
	return make("UICorner", nil, { CornerRadius = UDim.new(0, radius or 6) }, inst)
end

local function subtleOutline(inst: Instance, color: Color3?, thickness: number?)
	return make("UIStroke", nil, {
		Color = color or Theme.Line,
		Thickness = thickness or 0.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, inst)
end

local function animateClick(button: GuiButton)
	local originalSize = button.Size
	local shrink = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 2, originalSize.Y.Scale, originalSize.Y.Offset - 2)
	local t1 = Services.TweenService:Create(button, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = shrink })
	t1:Play()
	t1.Completed:Connect(function()
		Services.TweenService:Create(button, TweenInfo.new(0.09, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = originalSize }):Play()
	end)
end

local function addLabel(parent: Instance, key: string?, props: {[string]: any})
	local base = {
		BackgroundTransparency = 1,
		Font = Fonts.Medium,
		TextColor3 = Theme.White,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
	}
	for prop, value in pairs(props) do
		base[prop] = value
	end
	return make("TextLabel", key, base, parent)
end

make("ScreenGui", "ScreenGui", {
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	IgnoreGuiInset = false,
}, host)
GUI.ScreenGui:SetAttribute("NarsEdvEcode", true)

make("ImageButton", "OpenButton", {
	Size = UDim2.fromOffset(34, 34),
	Position = UDim2.new(0, 16, 0, 48),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Image = Icon.Open,
	ImageColor3 = Theme.White,
	Visible = false,
	ZIndex = 50,
}, GUI.ScreenGui)
round(GUI.OpenButton, 8)

local openStroke = make("UIStroke", "OpenStroke", {
	Color = Color3.new(1, 1, 1),
	Thickness = 1,
	Transparency = 0.55,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, GUI.OpenButton)

Services.TweenService:Create(openStroke, TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Transparency = 0.8,
}):Play()

make("Frame", "MainFrame", {
	Size = State.lastCustomSize,
	Position = State.lastCustomPos,
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	Active = true,
	ZIndex = 2,
}, GUI.ScreenGui)
round(GUI.MainFrame, 8)

pcall(function()
	local uiShadow = Instance.new("UIShadow")
	uiShadow.Name = "UIShadow"
	uiShadow.ZIndex = -1
	uiShadow.BlurRadius = UDim.new(0, 12)
	uiShadow.Color = Color3.fromRGB(0, 0, 0)
	uiShadow.Enabled = true
	uiShadow.Offset = UDim2.fromOffset(0, 4)
	uiShadow.Spread = UDim2.fromScale(0, 0)
	uiShadow.Transparency = 0.5
	uiShadow.Parent = GUI.MainFrame
end)

make("CanvasGroup", "ContentGroup", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ClipsDescendants = true,
	ZIndex = 2,
}, GUI.MainFrame)
round(GUI.ContentGroup, 8)

make("Frame", "TitleBar", {
	Size = UDim2.new(1, 0, 0, 32),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
}, GUI.ContentGroup)

-- TitleBar logo enlarged to 19x19 (between 18-20 as requested)
make("ImageLabel", "TitleLogo", {
	Size = UDim2.fromOffset(19, 19),
	Position = UDim2.new(0, 10, 0.5, -9.5),
	BackgroundTransparency = 1,
	Image = Icon.Logo,
	ImageColor3 = Theme.White,
}, GUI.TitleBar)

addLabel(GUI.TitleBar, "TitleLabel", {
	Size = UDim2.new(0, 60, 1, 0),
	Position = UDim2.new(0, 35, 0, 0),
	Text = "ECODE",
	Font = Fonts.Bold,
	TextSize = Sizes.Title,
	TextColor3 = Theme.White,
})

local function makeIconButton(parent: Instance, key: string?, asset: string, position: UDim2, size: number)
	local btn = make("ImageButton", key, {
		Size = UDim2.fromOffset(size, size),
		Position = position,
		BackgroundTransparency = 1,
		Image = asset,
		ImageColor3 = Theme.Muted,
		AutoButtonColor = false,
	}, parent)
	btn.MouseEnter:Connect(function() btn.ImageColor3 = Theme.White end)
	btn.MouseLeave:Connect(function() btn.ImageColor3 = Theme.Muted end)
	btn.MouseButton1Down:Connect(function() animateClick(btn) end)
	return btn
end

makeIconButton(GUI.TitleBar, "MinBtn", Icon.Minimize, UDim2.new(1, -66, 0, 9), 14)
makeIconButton(GUI.TitleBar, "MaxBtn", Icon.Maximize, UDim2.new(1, -44, 0, 9), 14)
makeIconButton(GUI.TitleBar, "CloseBtn", Icon.Close, UDim2.new(1, -22, 0, 9), 14)

make("Frame", "BodyFrame", {
	Size = UDim2.new(1, 0, 1, -32),
	Position = UDim2.new(0, 0, 0, 32),
	BackgroundTransparency = 1,
}, GUI.ContentGroup)

make("Frame", "ExplorerPanel", {
	Size = UDim2.new(0, 140, 1, 0),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
}, GUI.BodyFrame)

-- Divider: color gelap antara explorer dan editor code
make("Frame", "Divider", {
	Size = UDim2.new(0, 1, 1, 0),
	Position = UDim2.new(1, -1, 0, 0),
	BackgroundColor3 = Theme.DividerDark,
	BorderSizePixel = 0,
}, GUI.ExplorerPanel)

make("Frame", "ExpHeader", {
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundTransparency = 1,
}, GUI.ExplorerPanel)

addLabel(GUI.ExpHeader, "ExpTitle", {
	Size = UDim2.new(1, -34, 1, 0),
	Position = UDim2.new(0, 10, 0, 0),
	Text = "Explorer",
	TextColor3 = Theme.Muted,
	Font = Fonts.Bold,
	TextSize = Sizes.Explorer,
})

makeIconButton(GUI.ExpHeader, "ExpInsertBtn", Icon.ArrowRight, UDim2.new(1, -22, 0, 7), 14)

make("Frame", "ExpSearchContainer", {
	Size = UDim2.new(1, -16, 0, 22),
	Position = UDim2.new(0, 8, 0, 30),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
}, GUI.ExplorerPanel)
round(GUI.ExpSearchContainer, 4)
subtleOutline(GUI.ExpSearchContainer, Theme.ToolbarBorder, 0.5)

make("ImageLabel", "ExpSearchIcon", {
	Size = UDim2.fromOffset(11, 11),
	Position = UDim2.new(0, 6, 0.5, -5),
	BackgroundTransparency = 1,
	Image = Icon.Search,
	ImageColor3 = Theme.Muted,
}, GUI.ExpSearchContainer)

make("TextBox", "ExpSearchInput", {
	Size = UDim2.new(1, -24, 1, 0),
	Position = UDim2.new(0, 22, 0, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search files...",
	PlaceholderColor3 = Theme.MutedDark,
	Text = "",
	TextColor3 = Theme.White,
	Font = Fonts.Medium,
	TextSize = Sizes.Input,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
}, GUI.ExpSearchContainer)

make("ScrollingFrame", "ExpFileScroll", {
	Size = UDim2.new(1, -2, 1, -92),
	Position = UDim2.new(0, 0, 0, 58),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 2,
	ScrollBarImageColor3 = Theme.MutedDark,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, GUI.ExplorerPanel)

make("UIListLayout", "ExpFileLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 2),
}, GUI.ExpFileScroll)

make("UIPadding", nil, {
	PaddingLeft = UDim.new(0, 5),
	PaddingRight = UDim.new(0, 5),
}, GUI.ExpFileScroll)

make("TextButton", "SettingsBtn", {
	Size = UDim2.new(1, -16, 0, 24),
	Position = UDim2.new(0, 8, 1, -30),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Text = "",
}, GUI.ExplorerPanel)
round(GUI.SettingsBtn, 4)
subtleOutline(GUI.SettingsBtn, Theme.ToolbarBorder, 0.5)

make("ImageLabel", "SettingsBtnIcon", {
	Size = UDim2.fromOffset(12, 12),
	Position = UDim2.new(0, 8, 0.5, -6),
	BackgroundTransparency = 1,
	Image = Icon.Settings,
	ImageColor3 = Theme.Muted,
}, GUI.SettingsBtn)

addLabel(GUI.SettingsBtn, "SettingsBtnLabel", {
	Size = UDim2.new(1, -30, 1, 0),
	Position = UDim2.new(0, 26, 0, 0),
	Text = "Settings",
	TextColor3 = Theme.Muted,
	Font = Fonts.Medium,
	TextSize = Sizes.Explorer,
})

GUI.SettingsBtn.MouseEnter:Connect(function()
	GUI.SettingsBtnIcon.ImageColor3 = Theme.White
	GUI.SettingsBtnLabel.TextColor3 = Theme.White
end)
GUI.SettingsBtn.MouseLeave:Connect(function()
	GUI.SettingsBtnIcon.ImageColor3 = Theme.Muted
	GUI.SettingsBtnLabel.TextColor3 = Theme.Muted
end)
GUI.SettingsBtn.MouseButton1Down:Connect(function() animateClick(GUI.SettingsBtn) end)

make("Frame", "WorkArea", {
	Size = UDim2.new(1, -140, 1, 0),
	Position = UDim2.new(0, 140, 0, 0),
	BackgroundTransparency = 1,
}, GUI.BodyFrame)

make("Frame", "EditorHeader", {
	Size = UDim2.new(1, 0, 0, 28),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
}, GUI.WorkArea)

make("ScrollingFrame", "TabScroll", {
	Size = UDim2.new(1, -30, 1, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 0,
	CanvasSize = UDim2.new(0, 0, 1, 0),
	ScrollingDirection = Enum.ScrollingDirection.X,
}, GUI.EditorHeader)

make("UIListLayout", "TabListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	SortOrder = Enum.SortOrder.LayoutOrder,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 4),
}, GUI.TabScroll)

make("UIPadding", nil, { PaddingLeft = UDim.new(0, 6) }, GUI.TabScroll)
makeIconButton(GUI.EditorHeader, "AddTabBtn", Icon.TabAdd, UDim2.new(1, -22, 0, 6), 16)

-- ToolbarContainer: Transparansi 1, UICorner 6, UIStroke HILANGKAN
make("Frame", "ToolbarContainer", {
	Size = UDim2.new(1, -12, 0, 28),
	Position = UDim2.new(0, 6, 0, 32),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
}, GUI.WorkArea)
round(GUI.ToolbarContainer, 6)

-- EditorToolbar: Transparansi 1
make("ScrollingFrame", "EditorToolbar", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 0,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.X,
	ScrollingDirection = Enum.ScrollingDirection.X,
}, GUI.ToolbarContainer)

make("UIListLayout", "ToolbarLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Left,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 6),
}, GUI.EditorToolbar)

make("UIPadding", nil, {
	PaddingLeft = UDim.new(0, 4),
	PaddingRight = UDim.new(0, 4),
}, GUI.EditorToolbar)

-- Ke 5 button: UIStroke thickness 0.5 color putih, UICorner 5, background hitam, text kapital, tinggi 24, lebar fixed
local function createToolButton(key: string, iconAsset: string, labelText: string, order: number)
	local measured = Services.TextService:GetTextSize(labelText:upper(), 11, Fonts.Bold, Vector2.new(200, 20))
	local width = math.max(68, math.ceil(measured.X) + 28)

	local btn = make("TextButton", key, {
		LayoutOrder = order,
		Size = UDim2.fromOffset(width, 24),
		BackgroundColor3 = Theme.Black,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
	}, GUI.EditorToolbar)
	round(btn, 5)

	-- UIStroke putih thickness 0.5
	make("UIStroke", nil, {
		Color = Color3.fromRGB(255, 255, 255),
		Thickness = 0.5,
		Transparency = 0.25,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, btn)

	make("ImageLabel", nil, {
		Size = UDim2.fromOffset(11, 11),
		Position = UDim2.new(0, 7, 0.5, -5.5),
		BackgroundTransparency = 1,
		Image = iconAsset,
		ImageColor3 = Theme.White,
	}, btn)

	addLabel(btn, nil, {
		Size = UDim2.new(1, -22, 1, 0),
		Position = UDim2.new(0, 21, 0, 0),
		Text = labelText:upper(),
		TextColor3 = Theme.White,
		Font = Fonts.Bold,
		TextSize = 11,
	})

	btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Theme.Hover end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Theme.Black end)
	btn.MouseButton1Down:Connect(function() animateClick(btn) end)

	return btn
end

createToolButton("ExecBtn", Icon.Execute, "Execute", 1)
createToolButton("ClearBtn", Icon.Clear, "Clear", 2)
createToolButton("SaveBtn", Icon.Save, "Save", 3)
createToolButton("CopyBtn", Icon.Copy, "Copy", 4)
createToolButton("DeleteBtn", Icon.Delete, "Delete", 5)

-- EditorContainer: Background hitam
make("Frame", "EditorContainer", {
	Size = UDim2.new(1, 0, 1, -170),
	Position = UDim2.new(0, 0, 0, 64),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, GUI.WorkArea)

make("Frame", "Gutter", {
	Size = UDim2.new(0, 36, 1, -14),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
	ZIndex = 3,
	ClipsDescendants = true,
}, GUI.EditorContainer)

make("TextLabel", "LineLabel", {
	Size = UDim2.new(1, -8, 0, 14),
	Position = UDim2.new(0, 0, 0, 3),
	BackgroundTransparency = 1,
	Text = "1",
	TextColor3 = Theme.GutterNum,
	Font = Fonts.Code,
	TextSize = CODE_TEXT_SIZE,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextXAlignment = Enum.TextXAlignment.Right,
	LineHeight = CODE_LINE_HEIGHT,
	ZIndex = 3,
}, GUI.Gutter)

-- CodeContainer: Background hitam seperti panel
make("Frame", "CodeContainer", {
	Size = UDim2.new(1, -50, 1, -14),
	Position = UDim2.new(0, 36, 0, 0),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
	ClipsDescendants = true,
}, GUI.EditorContainer)

-- ActiveLineHighlight: Hitam agak cerah
make("Frame", "ActiveLineHighlight", {
	Size = UDim2.new(1, 0, 0, 14),
	Position = UDim2.new(0, 0, 0, 3),
	BackgroundColor3 = Theme.ActiveLine,
	BorderSizePixel = 0,
	ZIndex = 0,
}, GUI.CodeContainer)

make("TextLabel", "HighlightLabel", {
	Size = UDim2.new(1, 0, 0, 14),
	BackgroundTransparency = 1,
	Text = "",
	TextColor3 = CODE_TEXT_COLOR,
	Font = Fonts.Code,
	TextSize = CODE_TEXT_SIZE,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,
	TextWrapped = false,
	LineHeight = CODE_LINE_HEIGHT,
	RichText = true,
	Visible = false,
	ZIndex = 1,
}, GUI.CodeContainer)

-- CodeInput: Hitam background transparan di atas CodeContainer hitam
make("TextBox", "CodeInput", {
	Size = UDim2.fromScale(1, 1),
	Position = UDim2.fromScale(0, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,

	ClearTextOnFocus = false,
	MultiLine = true,
	TextWrapped = false,
	TextScaled = false,
	TextEditable = true,
	RichText = false,

	Font = Enum.Font.Code,
	TextSize = CODE_TEXT_SIZE,
	LineHeight = CODE_LINE_HEIGHT,

	TextColor3 = CODE_TEXT_COLOR,
	TextTransparency = 0,

	TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top,

	PlaceholderText = CODE_PLACEHOLDER,
	PlaceholderColor3 = CODE_PLACEHOLDER_COLOR,

	AutomaticSize = Enum.AutomaticSize.None,
	TextTruncate = Enum.TextTruncate.None,

	ZIndex = 2,
}, GUI.CodeContainer)

make("UIPadding", nil, { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) }, GUI.HighlightLabel)
make("UIPadding", nil, { PaddingLeft = UDim.new(0, 6), PaddingTop = UDim.new(0, 3) }, GUI.CodeInput)
pcall(function()
	GUI.CodeInput.TextDirection = Enum.TextDirection.LeftToRight
end)

make("Frame", "VScrollTrack", {
	Size = UDim2.new(0, 14, 1, -14),
	Position = UDim2.new(1, -14, 0, 0),
	BackgroundColor3 = Theme.Surface,
	BorderSizePixel = 0,
}, GUI.EditorContainer)

local function makeScrollArrow(parent: Instance, key: string, asset: string, size: UDim2, position: UDim2)
	local btn = make("ImageButton", key, {
		Size = size,
		Position = position,
		BackgroundColor3 = Theme.Surface,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Image = asset,
		ImageColor3 = Theme.Muted,
		ZIndex = 3,
	}, parent)
	btn.MouseEnter:Connect(function() btn.ImageColor3 = Theme.White end)
	btn.MouseLeave:Connect(function() btn.ImageColor3 = Theme.Muted end)
	return btn
end

makeScrollArrow(GUI.VScrollTrack, "VScrollUpBtn", Icon.ArrowUp, UDim2.new(1, 0, 0, 14), UDim2.new(0, 0, 0, 0))
makeScrollArrow(GUI.VScrollTrack, "VScrollDownBtn", Icon.ArrowDown, UDim2.new(1, 0, 0, 14), UDim2.new(0, 0, 1, -14))

make("Frame", "VScrollThumb", {
	Size = UDim2.new(1, 0, 0, 120),
	Position = UDim2.new(0, 0, 0, 14),
	BackgroundColor3 = Theme.MutedDark,
	BorderSizePixel = 0,
	ZIndex = 2,
}, GUI.VScrollTrack)

make("Frame", "HScrollTrack", {
	Size = UDim2.new(1, 0, 0, 14),
	Position = UDim2.new(0, 0, 1, -14),
	BackgroundColor3 = Theme.Surface,
	BorderSizePixel = 0,
}, GUI.EditorContainer)

makeScrollArrow(GUI.HScrollTrack, "HScrollLeftBtn", Icon.ArrowLeft, UDim2.new(0, 14, 1, 0), UDim2.new(0, 0, 0, 0))
makeScrollArrow(GUI.HScrollTrack, "HScrollRightBtn", Icon.ArrowRight, UDim2.new(0, 14, 1, 0), UDim2.new(1, -14, 0, 0))

make("Frame", "HScrollThumb", {
	Size = UDim2.new(0, 120, 1, 0),
	Position = UDim2.new(0, 14, 0, 0),
	BackgroundColor3 = Theme.MutedDark,
	BorderSizePixel = 0,
	ZIndex = 2,
}, GUI.HScrollTrack)

make("Frame", "ConsolePanel", {
	Size = UDim2.new(1, 0, 0, 84),
	Position = UDim2.new(0, 0, 1, -106),
	BackgroundColor3 = Theme.Black,
	BorderSizePixel = 0,
}, GUI.WorkArea)

make("Frame", "ConsoleHeader", {
	Size = UDim2.new(1, 0, 0, 22),
	BackgroundColor3 = Theme.Surface,
	BorderSizePixel = 0,
}, GUI.ConsolePanel)

make("ImageLabel", nil, {
	Size = UDim2.fromOffset(12, 12),
	Position = UDim2.new(0, 8, 0.5, -6),
	BackgroundTransparency = 1,
	Image = Icon.Terminal,
	ImageColor3 = Theme.White,
}, GUI.ConsoleHeader)

addLabel(GUI.ConsoleHeader, "ConsoleTitle", {
	Size = UDim2.new(0, 90, 1, 0),
	Position = UDim2.new(0, 24, 0, 0),
	Text = "Console",
	TextColor3 = Theme.White,
	Font = Fonts.Bold,
	TextSize = 10,
})

makeIconButton(GUI.ConsoleHeader, "ConsoleClearBtn", Icon.Clear, UDim2.new(1, -50, 0, 5), 12)
makeIconButton(GUI.ConsoleHeader, "ConsoleCopyBtn", Icon.Copy, UDim2.new(1, -32, 0, 5), 12)
makeIconButton(GUI.ConsoleHeader, "ConsoleCollapseBtn", Icon.ArrowDown, UDim2.new(1, -16, 0, 4), 14)

make("ScrollingFrame", "ConsoleScroll", {
	Size = UDim2.new(1, 0, 1, -22),
	Position = UDim2.new(0, 0, 0, 22),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 2,
	ScrollBarImageColor3 = Theme.MutedDark,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
}, GUI.ConsolePanel)

make("UIListLayout", "ConsoleLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 1),
}, GUI.ConsoleScroll)

make("UIPadding", nil, {
	PaddingLeft = UDim.new(0, 8),
	PaddingRight = UDim.new(0, 8),
	PaddingTop = UDim.new(0, 2),
}, GUI.ConsoleScroll)

make("Frame", "StatusBar", {
	Size = UDim2.new(1, 0, 0, 22),
	Position = UDim2.new(0, 0, 1, -22),
	BackgroundColor3 = Theme.Surface,
	BorderSizePixel = 0,
}, GUI.WorkArea)

addLabel(GUI.StatusBar, "StatusFileLabel", {
	Size = UDim2.new(0.4, 0, 1, 0),
	Position = UDim2.new(0, 10, 0, 0),
	Text = "script.lua",
	TextColor3 = Theme.Muted,
	TextSize = 10,
})

local statusMeta = make("Frame", nil, {
	Size = UDim2.new(0.6, -28, 1, 0),
	Position = UDim2.new(0.4, 0, 0, 0),
	BackgroundTransparency = 1,
}, GUI.StatusBar)

make("UIListLayout", nil, {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 12),
}, statusMeta)

local statusOrder = 0
local function makeStatusMetaItem(parent: Instance, key: string, initial: string)
	statusOrder += 1
	return addLabel(parent, key, {
		LayoutOrder = statusOrder,
		Size = UDim2.new(0, 0, 1, 0),
		AutomaticSize = Enum.AutomaticSize.X,
		Text = initial,
		TextColor3 = Theme.Muted,
		Font = Fonts.Medium,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Right,
	})
end

local lnColLabel = makeStatusMetaItem(statusMeta, "LnColLabel", "Ln 1, Col 1")
local spacesLabel = makeStatusMetaItem(statusMeta, "SpacesLabel", "Spaces: 0")
local encodingLabel = makeStatusMetaItem(statusMeta, "EncodingLabel", "UTF-8")
local langLabel = makeStatusMetaItem(statusMeta, "LangLabel", "Lua")
-- Note: fpsLabel and pingLabel are removed per instruction

make("ImageButton", "ResizeHandle", {
	Size = UDim2.fromOffset(14, 14),
	AnchorPoint = Vector2.new(1, 1),
	Position = UDim2.new(1, -4, 1, -4),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Image = Icon.ResizeCornerHandle,
	ImageColor3 = Theme.Muted,
	Rotation = -35,
	ZIndex = 40,
}, GUI.MainFrame)

GUI.ResizeHandle.MouseEnter:Connect(function() GUI.ResizeHandle.ImageColor3 = Theme.White end)
GUI.ResizeHandle.MouseLeave:Connect(function() GUI.ResizeHandle.ImageColor3 = Theme.Muted end)

local AC = {
	RowH = 22,
	MaxRows = 8,
	Pad = 3,
	MinW = 200,
	MaxW = 340,
	Badge = 16,
	CatW = 52,
}

-- Autocomplete popup with very high ZIndex (above CodeInput and all other layers)
make("Frame", "AutoPopup", {
	Size = UDim2.fromOffset(AC.MinW, 100),
	BackgroundColor3 = Theme.SurfaceElevated,
	BorderSizePixel = 0,
	Visible = false,
	Active = true,
	ZIndex = 500,
}, GUI.ScreenGui)
round(GUI.AutoPopup, 6)
subtleOutline(GUI.AutoPopup, Theme.ToolbarBorder, 1)

make("ScrollingFrame", "PopupScroll", {
	Size = UDim2.new(1, 0, 1, 0),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ScrollBarThickness = 2,
	ScrollBarImageColor3 = Theme.MutedDark,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	Active = true,
	ZIndex = 501,
}, GUI.AutoPopup)

make("UIListLayout", "PopupLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 0),
}, GUI.PopupScroll)

make("UIPadding", nil, {
	PaddingTop = UDim.new(0, AC.Pad),
	PaddingBottom = UDim.new(0, AC.Pad),
	PaddingLeft = UDim.new(0, AC.Pad),
	PaddingRight = UDim.new(0, AC.Pad),
}, GUI.PopupScroll)

local function makeModal(key: string, zIndex: number)
	return make("Frame", key, {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.55,
		BorderSizePixel = 0,
		Active = true,
		Visible = false,
		ZIndex = zIndex,
	}, GUI.ContentGroup)
end

local function makeSleekCard(key: string, overlay: Instance, width: number, height: number, titleText: string, zIndex: number)
	local card = make("Frame", key, {
		Size = UDim2.fromOffset(width, height),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = Theme.SurfaceElevated,
		BorderSizePixel = 0,
		ZIndex = zIndex,
	}, overlay)
	round(card, 8)
	subtleOutline(card, Theme.ToolbarBorder, 0.5)

	addLabel(card, key .. "Title", {
		Size = UDim2.new(1, -40, 0, 28),
		Position = UDim2.new(0, 12, 0, 2),
		Text = titleText,
		Font = Fonts.Bold,
		TextSize = Sizes.Card,
		TextColor3 = Theme.White,
		ZIndex = zIndex + 1,
	})
	return card
end

local function makeModalActionBtn(parent: Instance, key: string, label: string, position: UDim2, isPrimary: boolean, z: number, size: UDim2?)
	local btn = make("TextButton", key, {
		Size = size or UDim2.new(0, 72, 0, 24),
		Position = position,
		BackgroundColor3 = isPrimary and Theme.White or Theme.Surface,
		TextColor3 = isPrimary and Theme.PanelBg or Theme.White,
		Font = Fonts.Bold,
		TextSize = 10,
		Text = label,
		AutoButtonColor = false,
		BorderSizePixel = 0,
		ZIndex = z,
	}, parent)
	round(btn, 5)
	if not isPrimary then
		subtleOutline(btn, Theme.ToolbarBorder, 0.5)
	end
	btn.MouseButton1Down:Connect(function() animateClick(btn) end)
	return btn
end

makeModal("SaveModalCard", 20)
local saveCard = makeSleekCard("CardFrame", GUI.SaveModalCard, 310, 172, "Save Script", 21)
local saveClose = makeIconButton(GUI.CardFrame, "SaveCardCloseBtn", Icon.Close, UDim2.new(1, -22, 0, 9), 12)
saveClose.ZIndex = 22

addLabel(GUI.CardFrame, "SaveFolderLabel", {
	Size = UDim2.new(1, -24, 0, 14),
	Position = UDim2.new(0, 12, 0, 34),
	Text = "Destination Folder",
	TextColor3 = Theme.Muted,
	TextSize = Sizes.Body,
	ZIndex = 22,
})

make("TextButton", "FolderSelectBtn", {
	Size = UDim2.new(1, -24, 0, 26),
	Position = UDim2.new(0, 12, 0, 50),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	AutoButtonColor = false,
	Text = ROOT_PATH,
	TextColor3 = Theme.White,
	Font = Fonts.Medium,
	TextSize = Sizes.Input,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
	ZIndex = 22,
}, GUI.CardFrame)
round(GUI.FolderSelectBtn, 5)
subtleOutline(GUI.FolderSelectBtn, Theme.ToolbarBorder, 0.5)
make("UIPadding", nil, { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 26) }, GUI.FolderSelectBtn)

make("ImageLabel", "FolderSelectArrow", {
	Size = UDim2.fromOffset(10, 10),
	Position = UDim2.new(1, -30, 0, 58),
	BackgroundTransparency = 1,
	Image = Icon.ArrowDown,
	ImageColor3 = Theme.Muted,
	ZIndex = 23,
}, GUI.CardFrame)

addLabel(GUI.CardFrame, "SaveNameLabel", {
	Size = UDim2.new(1, -24, 0, 14),
	Position = UDim2.new(0, 12, 0, 84),
	Text = "File Name (.lua, .luau, .txt, .json)",
	TextColor3 = Theme.Muted,
	TextSize = Sizes.Body,
	ZIndex = 22,
})

make("TextBox", "FileNameInput", {
	Size = UDim2.new(1, -24, 0, 26),
	Position = UDim2.new(0, 12, 0, 100),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	PlaceholderText = "script.lua",
	PlaceholderColor3 = Theme.MutedDark,
	Text = "script.lua",
	TextColor3 = Theme.White,
	Font = Fonts.Code,
	TextSize = Sizes.Input,
	TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd,
	ClearTextOnFocus = false,
	ZIndex = 22,
}, GUI.CardFrame)
round(GUI.FileNameInput, 5)
subtleOutline(GUI.FileNameInput, Theme.ToolbarBorder, 0.5)
make("UIPadding", nil, { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, GUI.FileNameInput)

make("Frame", "SaveButtonRow", {
	Size = UDim2.new(1, -24, 0, 24),
	Position = UDim2.new(0, 12, 1, -34),
	BackgroundTransparency = 1,
	ZIndex = 22,
}, GUI.CardFrame)

makeModalActionBtn(GUI.SaveButtonRow, "CardCancelBtn", "Cancel", UDim2.new(0, 0, 0, 0), false, 22, UDim2.new(0.5, -3, 1, 0))
makeModalActionBtn(GUI.SaveButtonRow, "CardSaveBtn", "Save", UDim2.new(0.5, 3, 0, 0), true, 22, UDim2.new(0.5, -3, 1, 0))

make("ScrollingFrame", "FolderDropdown", {
	Size = UDim2.new(1, -24, 0, 24),
	Position = UDim2.new(0, 12, 0, 78),
	BackgroundColor3 = Theme.SurfaceElevated,
	BorderSizePixel = 0,
	ScrollBarThickness = 2,
	ScrollBarImageColor3 = Theme.MutedDark,
	CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	Visible = false,
	ZIndex = 30,
}, GUI.CardFrame)
round(GUI.FolderDropdown, 5)
subtleOutline(GUI.FolderDropdown, Theme.ToolbarBorder, 0.5)

make("UIListLayout", "FolderDropLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 2),
}, GUI.FolderDropdown)

make("UIPadding", nil, {
	PaddingTop = UDim.new(0, 3),
	PaddingBottom = UDim.new(0, 3),
	PaddingLeft = UDim.new(0, 3),
	PaddingRight = UDim.new(0, 3),
}, GUI.FolderDropdown)

makeModal("InsertModalCard", 35)
makeSleekCard("InsertCardFrame", GUI.InsertModalCard, 220, 168, "Insert", 36)
local insertClose = makeIconButton(GUI.InsertCardFrame, "InsertCardCloseBtn", Icon.Close, UDim2.new(1, -22, 0, 9), 12)
insertClose.ZIndex = 37

make("Frame", "InsertOptionsFrame", {
	Size = UDim2.new(1, -20, 1, -40),
	Position = UDim2.new(0, 10, 0, 32),
	BackgroundTransparency = 1,
	ZIndex = 37,
}, GUI.InsertCardFrame)

make("UIListLayout", "InsertOptionsLayout", {
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 4),
}, GUI.InsertOptionsFrame)

make("Frame", "InsertFolderNameFrame", {
	Size = UDim2.new(1, -24, 1, -42),
	Position = UDim2.new(0, 12, 0, 34),
	BackgroundTransparency = 1,
	Visible = false,
	ZIndex = 37,
}, GUI.InsertCardFrame)

addLabel(GUI.InsertFolderNameFrame, "FolderNameLabel", {
	Size = UDim2.new(1, 0, 0, 14),
	Text = "Folder Name",
	TextColor3 = Theme.Muted,
	TextSize = 10,
	ZIndex = 38,
})

make("TextBox", "FolderNameInput", {
	Size = UDim2.new(1, 0, 0, 28),
	Position = UDim2.new(0, 0, 0, 18),
	BackgroundColor3 = Theme.PanelBg,
	BorderSizePixel = 0,
	PlaceholderText = "Folder name...",
	PlaceholderColor3 = Theme.MutedDark,
	Text = "",
	TextColor3 = Theme.White,
	Font = Fonts.Code,
	TextSize = 11,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	ZIndex = 38,
}, GUI.InsertFolderNameFrame)
round(GUI.FolderNameInput, 5)
subtleOutline(GUI.FolderNameInput, Theme.ToolbarBorder, 0.5)
make("UIPadding", nil, { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, GUI.FolderNameInput)

make("Frame", "FolderButtonRow", {
	Size = UDim2.new(1, 0, 0, 24),
	Position = UDim2.new(0, 0, 1, -24),
	BackgroundTransparency = 1,
	ZIndex = 38,
}, GUI.InsertFolderNameFrame)

makeModalActionBtn(GUI.FolderButtonRow, "FolderCancelBtn", "Cancel", UDim2.new(0, 0, 0, 0), false, 38, UDim2.new(0.5, -3, 1, 0))
makeModalActionBtn(GUI.FolderButtonRow, "FolderCreateBtn", "Create", UDim2.new(0.5, 3, 0, 0), true, 38, UDim2.new(0.5, -3, 1, 0))

makeModal("CloseModalCard", 50)
makeSleekCard("CloseCardFrame", GUI.CloseModalCard, 250, 114, "Close Ecode", 51)
addLabel(GUI.CloseCardFrame, "CloseCardMessage", {
	Size = UDim2.new(1, -24, 0, 32),
	Position = UDim2.new(0, 12, 0, 32),
	Text = "Are you sure you want to exit Ecode? Unsaved script changes will be lost.",
	TextColor3 = Theme.Muted,
	TextSize = Sizes.Input,
	TextWrapped = true,
	ZIndex = 52,
})

make("Frame", "CloseButtonRow", {
	Size = UDim2.new(1, -24, 0, 24),
	Position = UDim2.new(0, 12, 1, -34),
	BackgroundTransparency = 1,
	ZIndex = 52,
}, GUI.CloseCardFrame)

makeModalActionBtn(GUI.CloseButtonRow, "CloseCancelBtn", "Cancel", UDim2.new(0, 0, 0, 0), false, 52, UDim2.new(0.5, -3, 1, 0))
makeModalActionBtn(GUI.CloseButtonRow, "ClosePanelBtn", "Close Panel", UDim2.new(0.5, 3, 0, 0), true, 52, UDim2.new(0.5, -3, 1, 0))

local addTab, switchTab, renderTabs, populateExplorer, updateSaveFolders, openInsertCard
local getActiveTab, hideSuggestions, setEditorText, updateEditorLayout, addConsoleEntry, checkAutocomplete
local renderHighlight, updateStatusBarDetails

function getActiveTab()
	for _, tab in ipairs(State.tabs) do
		if tab.id == State.activeTabId then
			return tab
		end
	end
	return nil
end

local function updateConsoleLayout()
	if State.consoleCollapsed then
		GUI.ConsolePanel.Size = UDim2.new(1, 0, 0, 22)
		GUI.ConsolePanel.Position = UDim2.new(0, 0, 1, -44)
		GUI.ConsoleScroll.Visible = false
		GUI.ConsoleCollapseBtn.Image = Icon.ArrowUp
		GUI.EditorContainer.Size = UDim2.new(1, 0, 1, -108)
	else
		GUI.ConsolePanel.Size = UDim2.new(1, 0, 0, 84)
		GUI.ConsolePanel.Position = UDim2.new(0, 0, 1, -106)
		GUI.ConsoleScroll.Visible = true
		GUI.ConsoleCollapseBtn.Image = Icon.ArrowDown
		GUI.EditorContainer.Size = UDim2.new(1, 0, 1, -170)
	end
end

GUI.ConsoleCollapseBtn.MouseButton1Click:Connect(function()
	State.consoleCollapsed = not State.consoleCollapsed
	updateConsoleLayout()
end)

function addConsoleEntry(message: any, category: string?, source: string?)
	category = category or "Info"
	source = source or "System"
	local text = tostring(message)
	local timeStr = os.date("%H:%M:%S")

	table.insert(State.logs, string.format("[%s] %s (%s)", timeStr, text, source))
	if #State.logs > 200 then
		table.remove(State.logs, 1)
	end

	State.logCounter = State.logCounter + 1
	local row = make("Frame", nil, {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = State.logCounter,
	}, GUI.ConsoleScroll)

	addLabel(row, nil, {
		Size = UDim2.new(0, 50, 0, 15),
		Text = timeStr,
		TextColor3 = Theme.MutedDark,
		Font = Fonts.Code,
		TextSize = 10,
		TextYAlignment = Enum.TextYAlignment.Top,
	})

	local textColor = Theme.White
	if category == "Warning" then
		textColor = Theme.Yellow
	elseif category == "Error" then
		textColor = Theme.Red
	end

	local msgLabel = make("TextLabel", nil, {
		Size = UDim2.new(1, -130, 0, 0),
		Position = UDim2.new(0, 54, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Text = text,
		TextColor3 = textColor,
		Font = Fonts.Code,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextWrapped = true,
		TextTruncate = Enum.TextTruncate.None,
	}, row)

	addLabel(row, nil, {
		Size = UDim2.new(0, 70, 0, 15),
		Position = UDim2.new(1, -70, 0, 0),
		Text = tostring(source),
		TextColor3 = Theme.MutedDark,
		Font = Fonts.Code,
		TextSize = Sizes.Body,
		TextXAlignment = Enum.TextXAlignment.Right,
		TextYAlignment = Enum.TextYAlignment.Top,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	table.insert(State.logRows, row)
	if #State.logRows > 200 then
		local oldest = table.remove(State.logRows, 1)
		if oldest then oldest:Destroy() end
	end

	task.defer(function()
		local maxY = math.max(0, GUI.ConsoleScroll.AbsoluteCanvasSize.Y - GUI.ConsoleScroll.AbsoluteWindowSize.Y)
		GUI.ConsoleScroll.CanvasPosition = Vector2.new(0, maxY)
	end)
end

function State.clearConsole()
	for _, row in ipairs(State.logRows) do row:Destroy() end
	State.logRows = {}
	State.logs = {}
	GUI.ConsoleScroll.CanvasPosition = Vector2.new(0, 0)
end

GUI.ConsoleClearBtn.MouseButton1Click:Connect(State.clearConsole)

GUI.ConsoleCopyBtn.MouseButton1Click:Connect(function()
	if type(setclipboard) == "function" then
		pcall(setclipboard, table.concat(State.logs, "\n"))
	end
end)

GUI.MinBtn.MouseButton1Click:Connect(function()
	GUI.MainFrame.Visible = false
	GUI.OpenButton.Visible = true
end)

-- Maximize handler: saat Maximize Panel ScreenGui nilai properties IgnoreGuiInset = true ya
GUI.MaxBtn.MouseButton1Click:Connect(function()
	State.isMaximized = not State.isMaximized
	GUI.MaxBtn.Image = State.isMaximized and Icon.Restore or Icon.Maximize
	if State.isMaximized then
		GUI.ScreenGui.IgnoreGuiInset = true
		State.lastCustomSize = GUI.MainFrame.Size
		State.lastCustomPos = GUI.MainFrame.Position
		GUI.MainFrame.Size = UDim2.new(1, -20, 1, -20)
		GUI.MainFrame.Position = UDim2.new(0, 10, 0, 10)
		GUI.ResizeHandle.Visible = false
	else
		GUI.ScreenGui.IgnoreGuiInset = false
		GUI.MainFrame.Size = State.lastCustomSize
		GUI.MainFrame.Position = State.lastCustomPos
		GUI.ResizeHandle.Visible = true
	end
	task.defer(updateEditorLayout)
end)

function State.closePanel()
	for _, connection in ipairs(connections) do connection:Disconnect() end
	table.clear(connections)
	GUI.ScreenGui:Destroy()
end

GUI.CloseBtn.MouseButton1Click:Connect(function()
	if Config.confirmClose then
		GUI.CloseModalCard.Visible = true
	else
		State.closePanel()
	end
end)
GUI.CloseCancelBtn.MouseButton1Click:Connect(function()
	GUI.CloseModalCard.Visible = false
end)
GUI.ClosePanelBtn.MouseButton1Click:Connect(State.closePanel)

local openDragging = false
local openDragStart: Vector3
local openStartPos: UDim2
local wasDragged = false

GUI.OpenButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		openDragging = true
		wasDragged = false
		openDragStart = input.Position
		openStartPos = GUI.OpenButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then openDragging = false end
		end)
	end
end)

connect(Services.UserInputService.InputChanged, function(input)
	if openDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - openDragStart
		if delta.Magnitude > 5 then
			wasDragged = true
			GUI.OpenButton.Position = UDim2.new(openStartPos.X.Scale, openStartPos.X.Offset + delta.X, openStartPos.Y.Scale, openStartPos.Y.Offset + delta.Y)
		end
	end
end)

GUI.OpenButton.MouseButton1Click:Connect(function()
	if not wasDragged then
		GUI.MainFrame.Visible = true
		GUI.OpenButton.Visible = false
	end
end)

local panelDragging = false
local panelDragStart: Vector3
local panelDragStartPos: UDim2

GUI.TitleBar.InputBegan:Connect(function(input)
	if not State.isMaximized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		panelDragging = true
		panelDragStart = input.Position
		panelDragStartPos = GUI.MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then panelDragging = false end
		end)
	end
end)

connect(Services.UserInputService.InputChanged, function(input)
	if panelDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - panelDragStart
		GUI.MainFrame.Position = UDim2.new(panelDragStartPos.X.Scale, panelDragStartPos.X.Offset + delta.X, panelDragStartPos.Y.Scale, panelDragStartPos.Y.Offset + delta.Y)
		State.lastCustomPos = GUI.MainFrame.Position
	end
end)

local resizing = false
local resizeStart: Vector3
local resizeStartSize: UDim2
local resizeStartPos: UDim2
local MIN_W, MIN_H = 420, 260

GUI.ResizeHandle.InputBegan:Connect(function(input)
	if State.isMaximized then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		resizing = true
		resizeStart = input.Position
		resizeStartSize = GUI.MainFrame.Size
		resizeStartPos = GUI.MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizing = false
				State.lastCustomSize = GUI.MainFrame.Size
				State.lastCustomPos = GUI.MainFrame.Position
			end
		end)
	end
end)

connect(Services.UserInputService.InputChanged, function(input)
	if not resizing then return end
	if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end

	local delta = input.Position - resizeStart
	local newW = math.max(MIN_W, resizeStartSize.X.Offset + delta.X)
	local newH = math.max(MIN_H, resizeStartSize.Y.Offset + delta.Y)
	GUI.MainFrame.Size = UDim2.fromOffset(newW, newH)
	State.lastCustomSize = GUI.MainFrame.Size
	task.defer(updateEditorLayout)
end)

local THUMB_SIZE = 120
local ARROW_SIZE = 14
local SCROLL_STEP = 28
local PAD_LEFT = 6
local PAD_TOP = 3
local RENDER_BUFFER = 12
local MEASURE_BOUNDS = Vector2.new(100000, 100000)
local LANGUAGE_NAMES = { lua = "Lua", luau = "Luau", txt = "Text", json = "JSON" }

local function measureText(text: string): Vector2
	local ok, size = pcall(function()
		return Services.TextService:GetTextSize(text, CODE_TEXT_SIZE, Fonts.Code, MEASURE_BOUNDS)
	end)
	if ok and typeof(size) == "Vector2" then
		return size
	end
	return Vector2.new(#text * 7, 14)
end

local function measureLineHeight(): number
	local height = measureText("A\nA").Y - measureText("A").Y
	if height > 4 and height < 40 then
		return height * CODE_LINE_HEIGHT
	end
	return 14 * CODE_LINE_HEIGHT
end

local LINE_HEIGHT = measureLineHeight()
local CHAR_WIDTH = math.max(measureText("0").X, 5)

State.text = ""
State.lines = { "" }
State.lineStarts = { 1 }
State.lineCount = 1
State.hlLines = { "" }
State.hlDirty = false
State.indentLabel = "Spaces: 0"
State.encoding = "UTF-8"
State.gutterWidth = 36
State.canvasWidth = 0
State.canvasHeight = 0
State.scrollX = 0
State.scrollY = 0
State.overCode = false
State.committedText = ""
State.expectedText = nil
State.suppressAutoText = nil
State.indentUnit = "\t"
State.typedStamp = 0
State.sugRows = {}
State.sugToken = ""
State.popupWidth = 200
State.popupHeight = 100
State.renderedLineCount = 0
State.acPending = false
State.geoHold = false
State.geoX = nil
State.geoY = nil
State.syncToken = 0
State.nativeMoved = false
State.lastFocusLoss = nil

local Editor = {}

local function updateCustomScrollbars()
	local window = GUI.CodeContainer.AbsoluteSize
	local canvasX = State.canvasWidth
	local canvasY = State.canvasHeight

	if canvasY > window.Y + 1 then
		local trackLen = math.max(0, GUI.VScrollTrack.AbsoluteSize.Y - ARROW_SIZE * 2)
		local thumbLen = math.min(THUMB_SIZE, trackLen)
		local ratio = math.clamp(State.scrollY / (canvasY - window.Y), 0, 1)
		GUI.VScrollThumb.Size = UDim2.new(1, 0, 0, thumbLen)
		GUI.VScrollThumb.Position = UDim2.new(0, 0, 0, ARROW_SIZE + (trackLen - thumbLen) * ratio)
		GUI.VScrollThumb.Visible = thumbLen >= 8
		GUI.VScrollTrack.Visible = true
	else
		GUI.VScrollTrack.Visible = false
	end

	if canvasX > window.X + 1 then
		local trackLen = math.max(0, GUI.HScrollTrack.AbsoluteSize.X - ARROW_SIZE * 2)
		local thumbLen = math.min(THUMB_SIZE, trackLen)
		local ratio = math.clamp(State.scrollX / (canvasX - window.X), 0, 1)
		GUI.HScrollThumb.Size = UDim2.new(0, thumbLen, 1, 0)
		GUI.HScrollThumb.Position = UDim2.new(0, ARROW_SIZE + (trackLen - thumbLen) * ratio, 0, 0)
		GUI.HScrollThumb.Visible = thumbLen >= 8
		GUI.HScrollTrack.Visible = true
	else
		GUI.HScrollTrack.Visible = false
	end
end

GUI.VScrollUpBtn.MouseButton1Click:Connect(function()
	Editor.userScroll(State.scrollX, State.scrollY - SCROLL_STEP)
end)

GUI.VScrollDownBtn.MouseButton1Click:Connect(function()
	Editor.userScroll(State.scrollX, State.scrollY + SCROLL_STEP)
end)

GUI.HScrollLeftBtn.MouseButton1Click:Connect(function()
	Editor.userScroll(State.scrollX - SCROLL_STEP, State.scrollY)
end)

GUI.HScrollRightBtn.MouseButton1Click:Connect(function()
	Editor.userScroll(State.scrollX + SCROLL_STEP, State.scrollY)
end)

local function bindThumbDrag(thumb: GuiObject, isVertical: boolean)
	local dragging = false
	local startMouse = 0
	local startScroll = 0

	thumb.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startMouse = isVertical and input.Position.Y or input.Position.X
			startScroll = isVertical and State.scrollY or State.scrollX
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	connect(Services.UserInputService.InputChanged, function(input)
		if not dragging then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end

		local track = isVertical and GUI.VScrollTrack or GUI.HScrollTrack
		local trackLen = (isVertical and track.AbsoluteSize.Y or track.AbsoluteSize.X) - ARROW_SIZE * 2
		local range = trackLen - math.min(THUMB_SIZE, trackLen)
		if range <= 0 then return end

		local delta = (isVertical and input.Position.Y or input.Position.X) - startMouse
		local limitX, limitY = Editor.scrollLimits()
		local maxScroll = isVertical and limitY or limitX

		local value = math.clamp(startScroll + (delta / range) * maxScroll, 0, maxScroll)
		if isVertical then
			Editor.userScroll(State.scrollX, value)
		else
			Editor.userScroll(value, State.scrollY)
		end
	end)
end

bindThumbDrag(GUI.VScrollThumb, true)
bindThumbDrag(GUI.HScrollThumb, false)

local function escapeRichText(str: string): string
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	return str
end

local function wrapColor(color: string, text: string): string
	return '<font color="' .. color .. '">' .. escapeRichText(text) .. "</font>"
end

local function highlightLines(source: string): {string}
	local out = {}
	local current = {}

	local function emit(color: string?, text: string)
		local parts = string.split(text, "\n")
		for index, piece in ipairs(parts) do
			if index > 1 then
				out[#out + 1] = table.concat(current)
				current = {}
			end
			if piece ~= "" then
				current[#current + 1] = color and wrapColor(color, piece) or escapeRichText(piece)
			end
		end
	end

	local i = 1
	local len = #source

	while i <= len do
		local ch = string.sub(source, i, i)

		if string.sub(source, i, i + 1) == "--" then
			local level = string.match(source, "^%-%-%[(=*)%[", i)
			local stop
			if level then
				local _, closeEnd = string.find(source, "]" .. level .. "]", i, true)
				stop = closeEnd or len
			else
				local newline = string.find(source, "\n", i, true)
				stop = (newline or (len + 1)) - 1
			end
			emit(Syntax.Comment, string.sub(source, i, stop))
			i = stop + 1
		elseif ch == "[" and string.match(source, "^%[(=*)%[", i) then
			local level = string.match(source, "^%[(=*)%[", i)
			local _, closeEnd = string.find(source, "]" .. level .. "]", i, true)
			local stop = closeEnd or len
			emit(Syntax.String, string.sub(source, i, stop))
			i = stop + 1
		elseif ch == '"' or ch == "'" or ch == "`" then
			local j = i + 1
			while j <= len do
				local c = string.sub(source, j, j)
				if c == "\\" then
					j += 2
				elseif c == ch then
					break
				elseif c == "\n" then
					j -= 1
					break
				else
					j += 1
				end
			end
			local stop = math.min(j, len)
			emit(Syntax.String, string.sub(source, i, stop))
			i = stop + 1
		elseif string.match(ch, "[ \t\r\n]") then
			local space = string.match(source, "^[ \t\r\n]+", i)
			emit(nil, space)
			i += #space
		elseif string.match(ch, "[%a_]") then
			local word = string.match(source, "^[%a_][%w_]*", i)
			local prevChar = string.sub(source, i - 1, i - 1)
			if KEYWORD_SET[word] then
				emit(Syntax.Keyword, word)
			elseif BUILTIN_SET[word] then
				emit(Syntax.Builtin, word)
			elseif prevChar == "." or prevChar == ":" or METHOD_SET[word] then
				emit(Syntax.Method, word)
			else
				emit(nil, word)
			end
			i += #word
		elseif string.match(ch, "%d") then
			local numberText = string.match(source, "^0[xX][%x_]+", i) or string.match(source, "^%d[%d_]*%.?[%d_]*", i) or ch
			emit(Syntax.Number, numberText)
			i += #numberText
		elseif string.match(ch, "%p") then
			emit(Syntax.Operator, ch)
			i += 1
		else
			emit(nil, ch)
			i += 1
		end
	end

	out[#out + 1] = table.concat(current)
	return out
end

local function cleanNewlines(text: string): string
	return (text:gsub("\r\n", "\n"):gsub("\r", "\n"))
end

local function indexLines(text: string)
	local lines = {}
	local starts = {}
	local pos = 1
	local count = 0
	while true do
		local newline = string.find(text, "\n", pos, true)
		count += 1
		starts[count] = pos
		if newline then
			lines[count] = string.sub(text, pos, newline - 1)
			pos = newline + 1
		else
			lines[count] = string.sub(text, pos)
			break
		end
	end
	return lines, starts
end

local function findLine(pos: number): number
	local starts = State.lineStarts
	local low, high = 1, #starts
	while low < high do
		local mid = (low + high + 1) // 2
		if starts[mid] <= pos then
			low = mid
		else
			high = mid - 1
		end
	end
	return low
end

local function detectIndent(lines: {string}): string
	local tabLines = 0
	local spaceLines = 0
	local minSpaces = nil

	for index = 1, math.min(#lines, 3000) do
		local line = lines[index]
		local lead = string.match(line, "^[ \t]*")
		if #lead > 0 and #lead < #line then
			if string.sub(lead, 1, 1) == "\t" then
				tabLines += 1
			else
				local spaces = #string.match(lead, "^ *")
				spaceLines += 1
				if not minSpaces or spaces < minSpaces then
					minSpaces = spaces
				end
			end
		end
	end

	if tabLines > spaceLines then
		return "Tabs"
	end
	return string.format("Spaces: %d", minSpaces or 0)
end

-- Fix: get accurate cursor line, column and segment
local function getCursorInfo()
	local text = State.text
	local cursorPos = GUI.CodeInput.CursorPosition
	if cursorPos > 0 then
		State.lastCursor = cursorPos
	end
	local pos = math.clamp(State.lastCursor, 1, #text + 1)
	local line = findLine(pos)
	local lineStart = State.lineStarts[line] or 1
	local currentLineText = State.lines[line] or ""
	local offset = math.max(0, math.min(pos - lineStart, #currentLineText))
	local segment = string.sub(currentLineText, 1, offset)
	local col = (utf8.len(segment) or #segment) + 1
	return line, col, segment
end

local function onTextChanged()
	local rawText = GUI.CodeInput.Text
	local text = cleanNewlines(rawText)
	if text ~= rawText then
		GUI.CodeInput.Text = text
	end
	if text == State.text and #State.lines > 0 then return end

	State.text = text
	State.lines, State.lineStarts = indexLines(text)
	State.lineCount = #State.lines
	State.hlDirty = true
	State.indentLabel = detectIndent(State.lines)
	State.indentUnit = Editor.indentUnitFor(State.indentLabel)
	State.encoding = utf8.len(text) and "UTF-8" or "Non-UTF-8"
end

function updateStatusBarDetails()
	local line, col = getCursorInfo()
	State.activeLine = line
	State.activeCol = col

	GUI.ActiveLineHighlight.Visible = Config.activeLine
	Editor.placeActiveLine()

	local selectionText = ""
	if State.focused then
		local cursorPos = GUI.CodeInput.CursorPosition
		local selectionStart = GUI.CodeInput.SelectionStart
		if cursorPos ~= -1 and selectionStart ~= -1 and cursorPos ~= selectionStart then
			selectionText = string.format(" (%d selected)", math.abs(cursorPos - selectionStart))
		end
	end
	lnColLabel.Text = string.format("Ln %d, Col %d%s", line, col, selectionText)
	spacesLabel.Text = State.indentLabel
	encodingLabel.Text = State.encoding

	local tab = getActiveTab()
	local ext = tab and getExtension(tab.filename) or "lua"
	langLabel.Text = LANGUAGE_NAMES[ext] or "Text"
end

local function renderVisible(force: boolean?)
	local scrollY = State.scrollY
	local viewH = GUI.CodeContainer.AbsoluteSize.Y
	local total = State.lineCount

	local firstVisible = math.max(1, math.floor((scrollY - PAD_TOP) / LINE_HEIGHT) + 1)
	local lastVisible = math.min(total, math.ceil((scrollY + viewH - PAD_TOP) / LINE_HEIGHT) + 1)
	local first = math.max(1, math.min(firstVisible, math.max(total, 1)) - RENDER_BUFFER)
	local last = math.max(first, math.min(total, lastVisible + RENDER_BUFFER))

	GUI.LineLabel.Position = UDim2.fromOffset(0, PAD_TOP + (first - 1) * LINE_HEIGHT - scrollY)

	if force or first ~= State.gutterFirst or last ~= State.gutterLast then
		State.gutterFirst = first
		State.gutterLast = last
		local numbers = table.create(last - first + 1)
		for index = first, last do
			numbers[index - first + 1] = index
		end
		GUI.LineLabel.Size = UDim2.new(1, -8, 0, (last - first + 1) * LINE_HEIGHT)
		GUI.LineLabel.Text = table.concat(numbers, "\n")
	end

	if GUI.HighlightLabel.Visible and not State.hlDirty then
		if force or first ~= State.hlFirst or last ~= State.hlLast then
			State.hlFirst = first
			State.hlLast = last
			GUI.HighlightLabel.Size = UDim2.fromOffset(State.canvasWidth, (last - first + 1) * LINE_HEIGHT + PAD_TOP * 2)
			GUI.HighlightLabel.Text = table.concat(State.hlLines, "\n", first, last)
		end
		GUI.HighlightLabel.Position = UDim2.fromOffset(-State.scrollX, (State.hlFirst - 1) * LINE_HEIGHT - scrollY)
	end
end

function renderHighlight()
	if State.focused or State.text == "" or not Config.syntax then
		GUI.HighlightLabel.Visible = false
		GUI.CodeInput.TextTransparency = 0
		return
	end

	if State.hlDirty then
		State.hlLines = highlightLines(State.text)
		State.hlDirty = false
	end

	GUI.CodeInput.TextTransparency = 1
	GUI.HighlightLabel.Visible = true
	renderVisible(true)
end

local function applyGutterWidth(width: number)
	State.gutterWidth = width
	GUI.Gutter.Visible = width > 0
	GUI.Gutter.Size = UDim2.new(0, width, 1, -ARROW_SIZE)
	GUI.CodeContainer.Position = UDim2.new(0, width, 0, 0)
	GUI.CodeContainer.Size = UDim2.new(1, -(width + ARROW_SIZE), 1, -ARROW_SIZE)
end

function updateEditorLayout()
	local width = Config.lineNumbers and math.max(36, math.ceil(#tostring(State.lineCount) * CHAR_WIDTH) + 18) or 0
	if width ~= State.gutterWidth then
		applyGutterWidth(width)
	end

	local window = GUI.CodeContainer.AbsoluteSize
	local boundsX = GUI.CodeInput.TextBounds.X
	if boundsX < 8 then
		boundsX = measureText(State.text).X
	end

	local contentW = boundsX + PAD_LEFT + 24
	local contentH = State.lineCount * LINE_HEIGHT + PAD_TOP * 2
	local canvasW = math.max(window.X, contentW)
	local canvasH = math.max(window.Y, contentH)

	State.canvasWidth = canvasW
	State.canvasHeight = canvasH

	local limitX, limitY = Editor.scrollLimits()
	State.scrollX = math.clamp(State.scrollX, 0, limitX)
	State.scrollY = math.clamp(State.scrollY, 0, limitY)

	Editor.applyInputGeometry()
	GUI.ActiveLineHighlight.Size = UDim2.fromOffset(canvasW, LINE_HEIGHT)

	updateStatusBarDetails()

	local linesChanged = State.renderedLineCount ~= State.lineCount
	State.renderedLineCount = State.lineCount
	renderVisible(linesChanged)
	updateCustomScrollbars()
end

local function followCursor()
	if not State.focused or State.geoHold then return end

	local window = GUI.CodeContainer.AbsoluteSize
	local line, _, segment = getCursorInfo()

	local top = PAD_TOP + (line - 1) * LINE_HEIGHT
	local bottom = top + LINE_HEIGHT
	local caretX = PAD_LEFT + measureText(segment).X

	local newX, newY = State.scrollX, State.scrollY
	if top < newY then
		newY = (line == 1) and 0 or top
	elseif bottom > newY + window.Y then
		newY = bottom - window.Y
	end
	if caretX < newX then
		newX = math.max(0, caretX - PAD_LEFT)
	elseif caretX + 2 > newX + window.X then
		newX = caretX + 2 - window.X
	end

	if newX ~= State.scrollX or newY ~= State.scrollY then
		State.nativeMoved = true
	end
	Editor.setScroll(newX, newY)
end

function Editor.nativeSync()
	State.syncToken += 1
	local token = State.syncToken

	task.spawn(function()
		task.wait()
		if token ~= State.syncToken then
			return
		end
		State.geoHold = false

		if not State.focused then
			Editor.applyInputGeometry()
			return
		end

		local text = GUI.CodeInput.Text
		local caret = GUI.CodeInput.CursorPosition
		if caret < 1 then
			caret = State.lastCursor
		end
		caret = math.clamp(caret, 1, #text + 1)

		State.nativeMoved = false
		Editor.setScroll(0, 0)
		Editor.applyInputGeometry()

		pcall(function()
			GUI.CodeInput.SelectionStart = -1
			GUI.CodeInput.CursorPosition = 1
		end)
		task.wait()
		if token ~= State.syncToken or not State.focused or GUI.CodeInput.Text ~= text then
			return
		end

		pcall(function()
			GUI.CodeInput.SelectionStart = -1
			GUI.CodeInput.CursorPosition = caret
		end)
		State.lastCursor = caret
		followCursor()
	end)
end

Editor.PAIRS = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'" }
Editor.CLOSERS = { [")"] = true, ["]"] = true, ["}"] = true, ['"'] = true, ["'"] = true }

function Editor.indentUnitFor(label: string): string
	if label == "Tabs" then
		return "\t"
	end
	local count = tonumber(string.match(label, "%d+"))
	if count and count >= 2 and count <= 8 then
		return string.rep(" ", count)
	end
	return "\t"
end

function Editor.lineStartOf(text: string, pos: number): number
	for index = pos - 1, 1, -1 do
		if string.byte(text, index) == 10 then
			return index + 1
		end
	end
	return 1
end

function Editor.previousLineRange(text: string, lineStart: number): (number?, number?)
	if lineStart <= 1 then
		return nil, nil
	end
	local stop = lineStart - 2
	local start = Editor.lineStartOf(text, stop + 1)
	return start, stop
end

function Editor.trimLineEnd(line: string): string
	local clean = string.gsub(line, "%s*%-%-.*$", "")
	clean = string.gsub(clean, "%s+$", "")
	return clean
end

function Editor.opensBlock(line: string): boolean
	if string.match(line, "[%(%{%[]$") then
		return true
	end
	if string.match(line, "%f[%w_]then$") or string.match(line, "%f[%w_]do$")
		or string.match(line, "%f[%w_]else$") or string.match(line, "%f[%w_]repeat$") then
		return true
	end
	if string.match(line, "%f[%w_]function%f[^%w_][%w_%.:%s]*%b()$") then
		return true
	end
	return false
end

function Editor.insideCode(segment: string): boolean
	local quote = nil
	local index = 1
	local length = #segment
	while index <= length do
		local ch = string.sub(segment, index, index)
		if quote then
			if ch == "\\" then
				index += 1
			elseif ch == quote then
				quote = nil
			end
		else
			if ch == '"' or ch == "'" or ch == "`" then
				quote = ch
			elseif ch == "-" and string.sub(segment, index + 1, index + 1) == "-" then
				return false
			end
		end
		index += 1
	end
	return quote == nil
end

function Editor.computeTyping(oldText: string, newText: string, cursor: number): (string?, number?)
	if cursor < 2 or #newText ~= #oldText + 1 then
		return nil, nil
	end

	local q = cursor - 1
	if string.sub(newText, 1, q - 1) ~= string.sub(oldText, 1, q - 1)
		or string.sub(newText, q + 1) ~= string.sub(oldText, q) then
		return nil, nil
	end

	local ch = string.sub(newText, q, q)
	local after = string.sub(newText, q + 1, q + 1)
	local before = q > 1 and string.sub(newText, q - 1, q - 1) or ""
	local unit = State.indentUnit

	if ch == "\n" then
		if not EDITOR_AUTO_INDENT then
			return nil, nil
		end
		local lineStart = Editor.lineStartOf(newText, q)
		local prevLine = string.sub(newText, lineStart, q - 1)
		local indent = string.match(prevLine, "^[ \t]*") or ""
		local extra = Editor.opensBlock(Editor.trimLineEnd(prevLine)) and unit or ""
		local body = indent .. extra
		if extra ~= "" and (after == "}" or after == ")" or after == "]") then
			return string.sub(newText, 1, q) .. body .. "\n" .. indent .. string.sub(newText, q + 1), q + #body + 1
		end
		if body == "" then
			return nil, nil
		end
		return string.sub(newText, 1, q) .. body .. string.sub(newText, q + 1), q + #body + 1
	end

	if EDITOR_AUTO_PAIR then
		if Editor.CLOSERS[ch] and after == ch then
			return string.sub(newText, 1, q - 1) .. string.sub(newText, q + 1), q + 1
		end
		local closer = Editor.PAIRS[ch]
		if closer then
			local isQuote = (ch == '"' or ch == "'")
			local wordBefore = string.match(before, "[%w_]") ~= nil
			local wordAfter = string.match(after, "[%w_]") ~= nil
			if not wordAfter and not (isQuote and wordBefore) then
				return string.sub(newText, 1, q) .. closer .. string.sub(newText, q + 1), q + 1
			end
		end
	end

	if EDITOR_AUTO_INDENT and string.match(ch, "[%a%}%)%]]") and not string.match(after, "[%w_]") then
		local lineStart = Editor.lineStartOf(newText, q)
		local prefix = string.sub(newText, lineStart, q)
		local lead, word = string.match(prefix, "^([ \t]+)(%S+)$")
		if lead and (word == "end" or word == "else" or word == "until" or word == "}" or word == ")" or word == "]") then
			local prevLead = nil
			local openerLead = nil
			local scanStart = lineStart
			for _ = 1, 300 do
				local s, e = Editor.previousLineRange(newText, scanStart)
				if not s then
					break
				end
				local line = string.sub(newText, s, e)
				if string.find(line, "%S") then
					local leadOfLine = string.match(line, "^[ \t]*") or ""
					if prevLead == nil then
						prevLead = leadOfLine
					end
					if #leadOfLine < #lead then
						openerLead = leadOfLine
						break
					end
				end
				scanStart = s
			end
			if prevLead and openerLead and (lead == prevLead or lead == prevLead .. unit) then
				local rebuilt = string.sub(newText, 1, lineStart - 1) .. openerLead .. string.sub(newText, lineStart + #lead)
				return rebuilt, q + 1 + (#openerLead - #lead)
			end
		end
	end

	return nil, nil
end

local function placeCursor(text: string, cursor: number)
	local function apply()
		if GUI.CodeInput.Text ~= text then
			return
		end
		pcall(function()
			GUI.CodeInput.SelectionStart = -1
			GUI.CodeInput.CursorPosition = cursor
		end)
		State.lastCursor = cursor
	end
	apply()
	task.defer(apply)
end

local function commitText(text: string, cursor: number?)
	State.expectedText = text
	GUI.CodeInput.Text = text
	State.committedText = text
	if cursor then
		State.lastCursor = cursor
		if State.focused then
			placeCursor(text, cursor)
		end
	end
end

local function scheduleAutocomplete()
	if State.acPending then
		return
	end
	State.acPending = true
	task.defer(function()
		State.acPending = false
		checkAutocomplete()
	end)
end

local function afterTextChanged()
	State.typedStamp = os.clock()
	local tab = getActiveTab()
	if tab then
		tab.content = GUI.CodeInput.Text
	end
	onTextChanged()
	updateEditorLayout()
	renderHighlight()
	followCursor()
	scheduleAutocomplete()
end

function setEditorText(text: string)
	text = cleanNewlines(text or "")
	if GUI.CodeInput.Text ~= text then
		State.expectedText = text
		GUI.CodeInput.Text = text
	end
	State.committedText = text
	State.lastCursor = 1
	onTextChanged()
	updateEditorLayout()
	renderHighlight()
	if State.focused then
		Editor.nativeSync()
	end
end

function Editor.scrollLimits(): (number, number)
	local window = GUI.CodeContainer.AbsoluteSize
	return math.max(0, math.floor(State.canvasWidth - window.X)), math.max(0, math.floor(State.canvasHeight - window.Y))
end

function Editor.placeActiveLine()
	GUI.ActiveLineHighlight.Position = UDim2.fromOffset(-State.scrollX, PAD_TOP + (State.activeLine - 1) * LINE_HEIGHT - State.scrollY)
end

function Editor.applyInputGeometry()
	local x, y = 0, 0
	if State.geoHold or not State.focused then
		x, y = State.scrollX, State.scrollY
	end
	if State.geoX == x and State.geoY == y then
		return
	end
	State.geoX, State.geoY = x, y
	GUI.CodeInput.Size = UDim2.new(1, x, 1, y)
	GUI.CodeInput.Position = UDim2.fromOffset(-x, -y)
end

function Editor.setScroll(x: number, y: number)
	local limitX, limitY = Editor.scrollLimits()
	x = math.clamp(math.round(x), 0, limitX)
	y = math.clamp(math.round(y), 0, limitY)
	if x == State.scrollX and y == State.scrollY then
		return
	end

	State.scrollX = x
	State.scrollY = y
	Editor.applyInputGeometry()
	Editor.placeActiveLine()
	renderVisible()
	updateCustomScrollbars()
	if GUI.AutoPopup.Visible and os.clock() - State.typedStamp > 0.15 then
		hideSuggestions()
	end
end

function Editor.userScroll(x: number, y: number)
	if State.focused then
		pcall(function()
			GUI.CodeInput:ReleaseFocus()
		end)
	end
	Editor.setScroll(x, y)
end

connect(GUI.CodeInput.MouseEnter, function()
	State.overCode = true
end)

connect(GUI.CodeInput.MouseLeave, function()
	State.overCode = false
end)

connect(Services.UserInputService.InputChanged, function(input)
	if input.UserInputType == Enum.UserInputType.MouseWheel then
		if not State.overCode or State.focused or (GUI.SettingsModalCard and GUI.SettingsModalCard.Visible) then return end
		local delta = -input.Position.Z * LINE_HEIGHT * 3
		local shift = Services.UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or Services.UserInputService:IsKeyDown(Enum.KeyCode.RightShift)
		if shift then
			Editor.setScroll(State.scrollX + delta, State.scrollY)
		else
			Editor.setScroll(State.scrollX, State.scrollY + delta)
		end
		return
	end

	local pan = State.pan
	if pan and input == pan.input then
		local delta = input.Position - pan.origin
		if pan.moved or delta.Magnitude > 6 then
			pan.moved = true
			Editor.setScroll(pan.startX - delta.X, pan.startY - delta.Y)
		end
	end
end)

connect(GUI.CodeInput.InputBegan, function(input)
	if input.UserInputType ~= Enum.UserInputType.Touch or State.focused then return end
	local pan = { input = input, origin = input.Position, startX = State.scrollX, startY = State.scrollY, moved = false }
	State.pan = pan
	input.Changed:Connect(function()
		if input.UserInputState == Enum.UserInputState.End and State.pan == pan then
			State.pan = nil
		end
	end)
end)

connect(GUI.CodeContainer:GetPropertyChangedSignal("AbsoluteSize"), updateEditorLayout)
connect(GUI.EditorContainer:GetPropertyChangedSignal("AbsoluteSize"), updateEditorLayout)
connect(GUI.CodeInput:GetPropertyChangedSignal("TextBounds"), function()
	updateEditorLayout()
	followCursor()
end)

connect(GUI.CodeInput.Focused, function()
	State.focused = true
	GUI.HighlightLabel.Visible = false
	GUI.CodeInput.TextTransparency = 0
	renderHighlight()

	if State.scrollX ~= 0 or State.scrollY ~= 0 or State.nativeMoved then
		State.geoHold = true
		Editor.nativeSync()
	else
		Editor.applyInputGeometry()
	end
	updateEditorLayout()
end)

connect(GUI.CodeInput.FocusLost, function(enterPressed: boolean, inputThatCausedFocusLoss: InputObject?)
	if GUI.CodeInput.CursorPosition > 0 then
		State.lastCursor = GUI.CodeInput.CursorPosition
	end
	State.syncToken += 1
	State.geoHold = false
	State.focused = false
	State.lastFocusLoss = { enterPressed = enterPressed, input = inputThatCausedFocusLoss }
	State.expectedText = nil
	onTextChanged()
	renderHighlight()
	updateEditorLayout()
	task.delay(0.35, function()
		if not State.focused and not State.popupPressed then
			hideSuggestions()
		end
	end)
end)

pcall(function()
	connect(GUI.CodeInput.ReturnPressedFromOnScreenKeyboard, function()
		State.typedStamp = os.clock()
		followCursor()
		updateStatusBarDetails()
	end)
end)

connect(GUI.CodeInput:GetPropertyChangedSignal("CursorPosition"), function()
	local cursor = GUI.CodeInput.CursorPosition
	if cursor == -1 then return end
	State.lastCursor = cursor
	onTextChanged()
	updateStatusBarDetails()
	followCursor()
	if GUI.AutoPopup.Visible and os.clock() - State.typedStamp > 0.08 then
		hideSuggestions()
	end
end)

connect(GUI.CodeInput:GetPropertyChangedSignal("SelectionStart"), function()
	updateStatusBarDetails()
end)

connect(GUI.CodeInput:GetPropertyChangedSignal("Text"), function()
	local text = GUI.CodeInput.Text
	local programmatic = State.expectedText ~= nil and text == State.expectedText
	State.expectedText = nil

	if not programmatic and State.focused then
		local rebuilt, cursor = Editor.computeTyping(State.committedText, text, GUI.CodeInput.CursorPosition)
		if rebuilt then
			commitText(rebuilt, cursor)
			afterTextChanged()
			return
		end
	end

	State.committedText = text
	afterTextChanged()
end)

function hideSuggestions()
	GUI.AutoPopup.Visible = false
	State.suggestions = {}
	State.popupPressed = false
end

local function applySuggestion(insertText: string)
	if not insertText or insertText == "" then return end

	local text = GUI.CodeInput.Text
	local pos = math.clamp(State.lastCursor, 1, #text + 1)
	local left = string.sub(text, 1, pos - 1)
	local right = string.sub(text, pos)
	local token = string.match(left, "([%w_]+)$") or ""
	local base = string.sub(left, 1, #left - #token)

	local lineStart = Editor.lineStartOf(text, pos)
	local linePrefix = string.sub(text, lineStart, pos - 1)
	local baseIndent = string.match(linePrefix, "^[ \t]*") or ""
	local body = string.gsub(insertText, "\n", "\n" .. baseIndent)

	local markStart, markEnd = string.find(body, "$0", 1, true)
	local before = body
	local after = ""
	if markStart then
		before = string.sub(body, 1, markStart - 1)
		after = string.sub(body, markEnd + 1)
	end

	local newText = base .. before .. after .. right
	local newCursor = #base + #before + 1

	hideSuggestions()
	State.popupPressed = true
	State.suppressAutoText = newText
	commitText(newText, newCursor)
	afterTextChanged()

	task.defer(function()
		GUI.CodeInput:CaptureFocus()
		task.wait()
		if GUI.CodeInput.Text == newText then
			pcall(function()
				GUI.CodeInput.SelectionStart = -1
				GUI.CodeInput.CursorPosition = newCursor
			end)
			State.lastCursor = newCursor
		end
		updateEditorLayout()
		followCursor()
		State.popupPressed = false
	end)
end

local function refreshSuggestionRows()
	for index, row in ipairs(State.sugRows) do
		row.BackgroundTransparency = (index == State.selectedIndex) and 0 or 1
	end
end

local function renderSuggestions()
	for _, child in ipairs(GUI.PopupScroll:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end
	State.sugRows = {}

	local total = #State.suggestions
	if total == 0 then
		GUI.AutoPopup.Visible = false
		return
	end

	local maxName = 0
	for _, sug in ipairs(State.suggestions) do
		maxName = math.max(maxName, measureText(sug.name).X)
	end

	local width = math.clamp(math.ceil(maxName) + AC.Pad * 2 + AC.Badge + 18 + AC.CatW + 6, AC.MinW, AC.MaxW)
	local height = math.min(total, AC.MaxRows) * AC.RowH + AC.Pad * 2
	State.popupWidth = width
	State.popupHeight = height

	GUI.AutoPopup.Size = UDim2.fromOffset(width, height)
	GUI.PopupScroll.CanvasSize = UDim2.fromOffset(0, total * AC.RowH + AC.Pad * 2)
	GUI.PopupScroll.CanvasPosition = Vector2.zero
	GUI.PopupScroll.ScrollBarThickness = total > AC.MaxRows and 2 or 0
	GUI.AutoPopup.Visible = true

	local matchLen = #State.sugToken

	for index, sug in ipairs(State.suggestions) do
		local row = make("TextButton", nil, {
			Size = UDim2.new(1, 0, 0, AC.RowH),
			BackgroundColor3 = Theme.ItemActive,
			BackgroundTransparency = (index == State.selectedIndex) and 0 or 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
			LayoutOrder = index,
			ZIndex = 502,
			Active = true,
		}, GUI.PopupScroll)
		round(row, 4)

		local iconAsset = sug.icon or Icon.ACText
		make("ImageLabel", nil, {
			Size = UDim2.fromOffset(AC.Badge, AC.Badge),
			Position = UDim2.new(0, 4, 0.5, -AC.Badge / 2),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = iconAsset,
			ImageColor3 = sug.color or Theme.White,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 503,
		}, row)

		local typed = escapeRichText(string.sub(sug.name, 1, matchLen))
		local rest = escapeRichText(string.sub(sug.name, matchLen + 1))
		addLabel(row, nil, {
			Size = UDim2.new(1, -(AC.Badge + 18 + AC.CatW), 1, 0),
			Position = UDim2.new(0, AC.Badge + 10, 0, 0),
			Text = '<font color="#FFFFFF">' .. typed .. '</font><font color="#8C8C8C">' .. rest .. "</font>",
			RichText = true,
			TextColor3 = Theme.White,
			Font = Fonts.Code,
			TextSize = CODE_TEXT_SIZE,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ZIndex = 503,
		})

		addLabel(row, nil, {
			Size = UDim2.new(0, AC.CatW, 1, 0),
			Position = UDim2.new(1, -(AC.CatW + 6), 0, 0),
			Text = sug.category or "",
			TextColor3 = Theme.Muted,
			Font = Fonts.Medium,
			TextSize = Sizes.Body,
			TextXAlignment = Enum.TextXAlignment.Right,
			ZIndex = 503,
		})

		row.MouseEnter:Connect(function()
			State.selectedIndex = index
			refreshSuggestionRows()
		end)
		row.MouseButton1Down:Connect(function()
			State.popupPressed = true
			if GUI.CodeInput.CursorPosition > 0 then
				State.lastCursor = GUI.CodeInput.CursorPosition
			end
		end)
		row.MouseButton1Click:Connect(function()
			State.popupPressed = true
			applySuggestion(sug.insert or sug.name)
		end)

		table.insert(State.sugRows, row)
	end
end

local function positionPopup(line: number, segment: string)
	local scroll = GUI.CodeContainer
	local screen = GUI.ScreenGui
	local prefix = string.sub(segment, 1, #segment - #State.sugToken)

	local lineTop = scroll.AbsolutePosition.Y + PAD_TOP + (line - 1) * LINE_HEIGHT - State.scrollY - screen.AbsolutePosition.Y
	local x = scroll.AbsolutePosition.X + PAD_LEFT + measureText(prefix).X - State.scrollX - screen.AbsolutePosition.X
	local y = lineTop + LINE_HEIGHT + 2

	x = math.clamp(x, 4, math.max(4, screen.AbsoluteSize.X - State.popupWidth - 4))
	if y + State.popupHeight > screen.AbsoluteSize.Y - 4 then
		y = lineTop - State.popupHeight - 2
	end
	GUI.AutoPopup.Position = UDim2.fromOffset(x, math.max(4, y))
end

local SNIPPETS = {
	{ name = "function", insert = "function name()\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "local function", insert = "local function name()\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "if", insert = "if condition then\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "for", insert = "for i = 1, 10 do\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "for pairs", insert = "for k, v in pairs(t) do\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "for ipairs", insert = "for i, v in ipairs(t) do\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "while", insert = "while condition do\n\t$0\nend", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "repeat", insert = "repeat\n\t$0\nuntil condition", category = "Snippet", color = Syntax.Keyword, icon = Icon.ACCodeSnippet },
	{ name = "pcall", insert = "local ok, result = pcall(function()\n\t$0\nend)", category = "Snippet", color = Syntax.Builtin, icon = Icon.ACFunction },
	{ name = "task.spawn", insert = "task.spawn(function()\n\t$0\nend)", category = "Snippet", color = Syntax.Builtin, icon = Icon.ACFunction },
	{ name = "task.delay", insert = "task.delay(1, function()\n\t$0\nend)", category = "Snippet", color = Syntax.Builtin, icon = Icon.ACFunction },
	{ name = "Connect", insert = "Connect(function()\n\t$0\nend)", category = "Snippet", color = Syntax.Method, icon = Icon.ACProperty },
	{ name = "GetService", insert = "GetService(\"$0\")", category = "Snippet", color = Syntax.Method, icon = Icon.ACProperty },
	{ name = "WaitForChild", insert = "WaitForChild(\"$0\")", category = "Snippet", color = Syntax.Method, icon = Icon.ACProperty },
	{ name = "print", insert = "print($0)", category = "Snippet", color = Syntax.Builtin, icon = Icon.ACFunction },
	{ name = "warn", insert = "warn($0)", category = "Snippet", color = Syntax.Builtin, icon = Icon.ACFunction },
	{ name = "return", insert = "return", category = "Keyword", color = Syntax.Keyword, icon = Icon.ACKeyword },
	{ name = "local", insert = "local ", category = "Keyword", color = Syntax.Keyword, icon = Icon.ACKeyword },
}

function checkAutocomplete()
	if not State.focused then return end
	if not Config.autocomplete then
		hideSuggestions()
		return
	end

	if State.suppressAutoText ~= nil then
		if GUI.CodeInput.Text == State.suppressAutoText then
			hideSuggestions()
			return
		end
		State.suppressAutoText = nil
	end

	local line, _, segment = getCursorInfo()
	local token = string.match(segment, "([%w_]+)$")

	if not token or string.match(token, "^%d") or not Editor.insideCode(segment) then
		hideSuggestions()
		return
	end

	local matches = {}
	local seen = {}
	local low = token:lower()

	local function collect(list, color, category, iconAsset)
		for _, word in ipairs(list) do
			if not seen[word] and word:lower():sub(1, #low) == low then
				seen[word] = true
				table.insert(matches, {
					name = word,
					insert = word,
					color = Color3.fromHex(color),
					category = category,
					icon = iconAsset or Icon.ACText,
				})
			end
		end
	end

	for _, snip in ipairs(SNIPPETS) do
		if not seen[snip.name] and snip.name:lower():sub(1, #low) == low then
			seen[snip.name] = true
			table.insert(matches, {
				name = snip.name,
				insert = snip.insert,
				color = Color3.fromHex(snip.color),
				category = snip.category,
				icon = snip.icon or Icon.ACCodeSnippet,
			})
		end
	end

	collect(LUAU_KEYWORDS, Syntax.Keyword, "Keyword", Icon.ACKeyword)
	collect(LUAU_BUILTINS, Syntax.Builtin, "Builtin", Icon.ACFunction)
	collect(API_METHODS, Syntax.Method, "Method", Icon.ACProperty)

	if #matches > 24 then
		local limited = {}
		for i = 1, 24 do limited[i] = matches[i] end
		matches = limited
	end

	if #matches == 0 or (#matches == 1 and string.lower(matches[1].name) == low) then
		hideSuggestions()
		return
	end

	State.suggestions = matches
	State.selectedIndex = 1
	State.sugToken = token

	renderSuggestions()
	positionPopup(line, segment)
end

local function updateBreadcrumb(tab)
	local label = tab.filename or "script.lua"
	GUI.StatusFileLabel.Text = label
	GUI.FileNameInput.Text = label
end

-- Fix: Always flush/save currently active tab content before switching!
function switchTab(tabId: number)
	local currentTab = getActiveTab()
	if currentTab and currentTab.id ~= tabId then
		currentTab.content = GUI.CodeInput.Text
	end

	State.activeTabId = tabId
	for _, tab in ipairs(State.tabs) do
		if tab.frame then
			local isActive = (tab.id == tabId)
			tab.frame.BackgroundColor3 = isActive and Theme.SurfaceElevated or Theme.Surface
			tab.frame.BackgroundTransparency = isActive and 0 or 0.6
			if tab.indicator then
				tab.indicator.Visible = isActive
			end
			if tab.title then
				tab.title.TextColor3 = isActive and Theme.White or Theme.Muted
				tab.title.Font = isActive and Fonts.Bold or Fonts.Medium
			end
		end
	end

	local activeTab = getActiveTab()
	if activeTab then
		hideSuggestions()
		setEditorText(activeTab.content or "")
		Editor.setScroll(0, 0)
		updateBreadcrumb(activeTab)
		updateStatusBarDetails()

		if activeTab.filePath and activeTab.filePath ~= "" then
			local norm = normalizePath(activeTab.filePath)
			if State.selectedPath ~= norm or State.selectedIsFolder then
				State.selectedPath = norm
				State.selectedIsFolder = false
				local dir = getDirectory(norm)
				while dir and dir ~= "" do
					State.expand[dir] = true
					if dir == ROOT_PATH then break end
					dir = getDirectory(dir)
				end
				State.expand[ROOT_PATH] = true
				populateExplorer(GUI.ExpSearchInput.Text)
			end
		else
			if State.selectedPath ~= nil and not State.selectedIsFolder then
				State.selectedPath = nil
				State.selectedIsFolder = false
				populateExplorer(GUI.ExpSearchInput.Text)
			end
		end
	end
end

local function closeTab(tabId: number)
	if #State.tabs <= 1 then return end
	local targetIndex = nil
	for index, tab in ipairs(State.tabs) do
		if tab.id == tabId then
			targetIndex = index
			if tab.frame then tab.frame:Destroy() end
			break
		end
	end

	if targetIndex then
		table.remove(State.tabs, targetIndex)
		if State.activeTabId == tabId then
			local newActive = State.tabs[math.min(targetIndex, #State.tabs)]
			switchTab(newActive.id)
		else
			renderTabs()
		end
	end
end

function renderTabs()
	for _, child in ipairs(GUI.TabScroll:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	local totalWidth = 4
	for _, tab in ipairs(State.tabs) do
		local isActive = (tab.id == State.activeTabId)

		local frame = make("Frame", nil, {
			Size = UDim2.new(0, 110, 1, -4),
			BackgroundColor3 = isActive and Theme.SurfaceElevated or Theme.Surface,
			BackgroundTransparency = isActive and 0 or 0.6,
			BorderSizePixel = 0,
			LayoutOrder = tab.id,
		}, GUI.TabScroll)
		round(frame, 5)
		tab.frame = frame

		local indicator = make("Frame", nil, {
			Size = UDim2.new(1, 0, 0, 2),
			AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 0, 1, 0),
			BackgroundColor3 = Theme.White,
			BorderSizePixel = 0,
			Visible = isActive,
		}, frame)
		tab.indicator = indicator

		local tabIconAsset = Icon.ScriptIcon
		local lowerName = (tab.filename or ""):lower()
		if lowerName:find("local") then
			tabIconAsset = Icon.LocalScriptIcon
		elseif lowerName:find("module") then
			tabIconAsset = Icon.ModuleIcon
		elseif lowerName:match("%.json$") or lowerName:match("%.txt$") then
			tabIconAsset = Icon.FileIcon
		end
		make("ImageLabel", nil, {
			Size = UDim2.fromOffset(11, 11),
			Position = UDim2.new(0, 8, 0.5, -5),
			BackgroundTransparency = 1,
			Image = tabIconAsset,
			ImageColor3 = Theme.Muted,
		}, frame)

		tab.title = addLabel(frame, nil, {
			Size = UDim2.new(1, -38, 1, 0),
			Position = UDim2.new(0, 24, 0, 0),
			Text = tab.filename,
			TextColor3 = isActive and Theme.White or Theme.Muted,
			Font = isActive and Fonts.Bold or Fonts.Medium,
			TextSize = 10,
			TextTruncate = Enum.TextTruncate.AtEnd,
		})

		local closeBtn = makeIconButton(frame, nil, Icon.TabClose, UDim2.new(1, -16, 0.5, -5), 10)

		frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				switchTab(tab.id)
			end
		end)

		closeBtn.MouseButton1Click:Connect(function()
			closeTab(tab.id)
		end)

		totalWidth = totalWidth + 114
	end
	GUI.TabScroll.CanvasSize = UDim2.new(0, totalWidth, 1, 0)
end

function addTab(filename: string?, content: string?, parentPath: string?, filePath: string?, isInitial: boolean?)
	-- Reuse initial blank tab if still untouched
	if not isInitial and #State.tabs == 1 and State.tabs[1].isInitial and State.tabs[1].filePath == nil and (State.tabs[1].content == "" or State.tabs[1].content == nil) then
		local initTab = State.tabs[1]
		initTab.filename = filename or "script.lua"
		initTab.content = content or ""
		initTab.parentPath = parentPath and normalizePath(parentPath) or ROOT_PATH
		initTab.filePath = filePath and normalizePath(filePath) or nil
		initTab.isInitial = false
		renderTabs()
		switchTab(initTab.id)
		return
	end

	State.tabCounter = State.tabCounter + 1
	local newTab = {
		id = State.tabCounter,
		filename = filename or "script.lua",
		content = content or "",
		parentPath = parentPath and normalizePath(parentPath) or ROOT_PATH,
		filePath = filePath and normalizePath(filePath) or nil,
		isInitial = isInitial or false,
	}
	table.insert(State.tabs, newTab)
	renderTabs()
	switchTab(newTab.id)
end

GUI.AddTabBtn.MouseButton1Click:Connect(function()
	addTab("script.lua", "", ROOT_PATH, nil, false)
end)

-- Fix: Unambiguous item path resolution across all executor variants
local function resolveItemPath(dir: string, itemPath: string): string
	local norm = normalizePath(itemPath)
	local normDir = normalizePath(dir)
	if norm == normDir or norm:sub(1, #normDir + 1) == normDir .. "/" then
		return norm
	end
	return normalizePath(normDir .. "/" .. norm)
end

local function listDirectory(dir: string)
	local folders = {}
	local files = {}
	if type(listfiles) ~= "function" then return folders, files end

	local ok, items = pcall(listfiles, dir)
	if not ok or type(items) ~= "table" then return folders, files end

	for _, itemPath in ipairs(items) do
		local resolvedPath = resolveItemPath(dir, itemPath)
		local name = getBasename(resolvedPath)
		local isDir = false
		if type(isfolder) == "function" then
			local okDir, result = pcall(isfolder, resolvedPath)
			isDir = okDir and result == true
		end

		if isDir then
			table.insert(folders, { path = resolvedPath, name = name })
		else
			local ext = getExtension(name)
			if ext and SUPPORTED_EXTENSIONS[ext] then
				table.insert(files, { path = resolvedPath, name = name })
			end
		end
	end
	table.sort(folders, function(a, b) return a.name:lower() < b.name:lower() end)
	table.sort(files, function(a, b) return a.name:lower() < b.name:lower() end)
	return folders, files
end

local function createExplorerRow(indent: number, selected: boolean, iconAsset: string, labelText: string, bold: boolean, arrowAsset: string?, withInsert: boolean)
	State.rowOrder = State.rowOrder + 1
	local row = make("Frame", nil, {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundColor3 = selected and Theme.Selection or Theme.Hover,
		BackgroundTransparency = selected and 0 or 1,
		BorderSizePixel = 0,
		LayoutOrder = State.rowOrder,
	}, GUI.ExpFileScroll)
	round(row, 4)

	if selected then
		local selectionLine = make("Frame", nil, {
			Size = UDim2.new(0, 2, 1, -8),
			Position = UDim2.new(0, 0, 0, 4),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			ZIndex = 2,
		}, row)
		round(selectionLine, 1)
	end

	local textX = 4 + (indent * 12)
	if arrowAsset then
		make("ImageLabel", nil, {
			Size = UDim2.fromOffset(8, 8),
			Position = UDim2.new(0, textX, 0.5, -4),
			BackgroundTransparency = 1,
			Image = arrowAsset,
			ImageColor3 = Theme.Muted,
		}, row)
		textX = textX + 11
	else
		textX = textX + 11
	end

	make("ImageLabel", nil, {
		Size = UDim2.fromOffset(12, 12),
		Position = UDim2.new(0, textX, 0.5, -6),
		BackgroundTransparency = 1,
		Image = iconAsset,
		ImageColor3 = selected and Theme.White or Theme.Muted,
	}, row)

	addLabel(row, nil, {
		Size = UDim2.new(1, -(textX + 30), 1, 0),
		Position = UDim2.new(0, textX + 17, 0, 0),
		Text = labelText,
		TextColor3 = selected and Theme.White or Theme.Muted,
		Font = bold and Fonts.Bold or Fonts.Regular,
		TextSize = Sizes.Explorer,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	local mainBtn = make("TextButton", nil, {
		Size = UDim2.new(1, withInsert and -20 or 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
	}, row)

	local insertBtn = nil
	if withInsert then
		insertBtn = makeIconButton(row, nil, Icon.TabAdd, UDim2.new(1, -16, 0.5, -5), 10)
	end

	return row, mainBtn, insertBtn
end

local function renderDirectory(dir: string, indent: number, filter: string)
	local folders, files = listDirectory(dir)
	for _, folder in ipairs(folders) do
		local folderPath = folder.path
		local expanded = (filter ~= "") or (State.expand[folderPath] == true)
		local selected = (State.selectedPath == folderPath)

		local _, mainBtn, insertBtn = createExplorerRow(
			indent, selected, Icon.FolderIcon, folder.name, true,
			expanded and Icon.ArrowDown or Icon.ArrowRight, true
		)

		mainBtn.MouseButton1Click:Connect(function()
			State.selectedPath = folderPath
			State.selectedIsFolder = true
			State.expand[folderPath] = not (State.expand[folderPath] == true)
			populateExplorer(GUI.ExpSearchInput.Text)
		end)

		if insertBtn then
			insertBtn.MouseButton1Click:Connect(function()
				openInsertCard(folderPath)
			end)
		end

		if expanded then
			renderDirectory(folderPath, indent + 1, filter)
		end
	end

	for _, file in ipairs(files) do
		if filter == "" or file.name:lower():find(filter:lower(), 1, true) then
			local filePath = file.path
			local fileName = file.name
			local selected = (State.selectedPath == filePath)
			local lowerName = fileName:lower()
			local fileIcon = Icon.ScriptIcon
			if lowerName:find("localscript") or lowerName:match("^local") then
				fileIcon = Icon.LocalScriptIcon
			elseif lowerName:find("module") then
				fileIcon = Icon.ModuleIcon
			elseif lowerName:match("%.json$") or lowerName:match("%.txt$") then
				fileIcon = Icon.FileIcon
			end
			local _, mainBtn = createExplorerRow(indent, selected, fileIcon, fileName, false, nil, false)

			mainBtn.MouseButton1Click:Connect(function()
				State.selectedPath = filePath
				State.selectedIsFolder = false
				populateExplorer(GUI.ExpSearchInput.Text)

				-- Check if tab is already open
				for _, tab in ipairs(State.tabs) do
					if tab.filePath and normalizePath(tab.filePath) == normalizePath(filePath) then
						switchTab(tab.id)
						return
					end
				end

				-- Read file content and open tab
				if type(readfile) == "function" then
					local okRead, content = pcall(readfile, filePath)
					if okRead then
						addTab(fileName, content, getDirectory(filePath), filePath, false)
					else
						addConsoleEntry("Failed to read file: " .. tostring(filePath), "Error", "Explorer")
					end
				end
			end)
		end
	end
end

function populateExplorer(filterText: string?)
	for _, child in ipairs(GUI.ExpFileScroll:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end

	State.rowOrder = 0
	local filter = (filterText or ""):lower()
	ensureRoot()

	local rootExpanded = (filter ~= "") or (State.expand[ROOT_PATH] == true)
	local rootSelected = (State.selectedPath == ROOT_PATH)

	local _, rootBtn, rootInsert = createExplorerRow(
		0, rootSelected, Icon.FolderIcon, ROOT_PATH, true,
		rootExpanded and Icon.ArrowDown or Icon.ArrowRight, true
	)

	rootBtn.MouseButton1Click:Connect(function()
		State.selectedPath = ROOT_PATH
		State.selectedIsFolder = true
		State.expand[ROOT_PATH] = not (State.expand[ROOT_PATH] == true)
		populateExplorer(filter)
	end)

	if rootInsert then
		rootInsert.MouseButton1Click:Connect(function()
			openInsertCard(ROOT_PATH)
		end)
	end

	if rootExpanded then
		renderDirectory(ROOT_PATH, 1, filter)
	end

	updateSaveFolders()
end

GUI.ExpSearchInput:GetPropertyChangedSignal("Text"):Connect(function()
	populateExplorer(GUI.ExpSearchInput.Text)
end)

GUI.ExpInsertBtn.MouseButton1Click:Connect(function()
	openInsertCard(ROOT_PATH)
end)

local insertOptions = {
	{ label = "Folder", icon = Icon.FolderIcon, kind = "Folder" },
	{ label = "Script", icon = Icon.ScriptIcon, kind = "Script" },
	{ label = "LocalScript", icon = Icon.LocalScriptIcon, kind = "LocalScript" },
	{ label = "ModuleScript", icon = Icon.ModuleIcon, kind = "ModuleScript" },
}

local SCRIPT_TEMPLATES = {
	Script = { base = "Script", content = "-- Script\n\n" },
	LocalScript = { base = "LocalScript", content = "-- LocalScript\n\n" },
	ModuleScript = { base = "ModuleScript", content = "local module = {\n}\n\nreturn module\n" },
}

local function createScriptFile(kind: string)
	local template = SCRIPT_TEMPLATES[kind]
	if not template then return end

	ensureRoot()
	local dir = isInsideRoot(State.insertParent) and State.insertParent or ROOT_PATH
	local name = uniqueName(dir, template.base, ".lua")
	local path = normalizePath(dir .. "/" .. name)

	if type(writefile) == "function" then
		pcall(writefile, path, template.content)
	end

	State.expand[dir] = true
	addTab(name, template.content, dir, path, false)
	populateExplorer(GUI.ExpSearchInput.Text)
	GUI.InsertModalCard.Visible = false
end

for index, option in ipairs(insertOptions) do
	local btn = make("TextButton", nil, {
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundColor3 = Theme.Surface,
		BorderSizePixel = 0,
		AutoButtonColor = false,
		Text = "",
		LayoutOrder = index,
		ZIndex = 37,
	}, GUI.InsertOptionsFrame)
	round(btn, 5)
	subtleOutline(btn, Theme.ToolbarBorder, 0.5)

	make("ImageLabel", nil, {
		Size = UDim2.fromOffset(13, 13),
		Position = UDim2.new(0, 8, 0.5, -6),
		BackgroundTransparency = 1,
		Image = option.icon,
		ImageColor3 = Theme.White,
		ZIndex = 38,
	}, btn)

	addLabel(btn, nil, {
		Size = UDim2.new(1, -30, 1, 0),
		Position = UDim2.new(0, 28, 0, 0),
		Text = option.label,
		TextColor3 = Theme.White,
		Font = Fonts.Medium,
		TextSize = Sizes.Input,
		ZIndex = 38,
	})

	btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Theme.Hover end)
	btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Theme.Surface end)
	btn.MouseButton1Down:Connect(function() animateClick(btn) end)

	btn.MouseButton1Click:Connect(function()
		if option.kind == "Folder" then
			GUI.InsertCardFrame.Size = UDim2.fromOffset(220, 124)
			GUI.InsertOptionsFrame.Visible = false
			GUI.InsertFolderNameFrame.Visible = true
			GUI.FolderNameInput.Text = ""
			GUI.FolderNameInput:CaptureFocus()
			return
		end
		createScriptFile(option.kind)
	end)
end

function openInsertCard(parentPath: string?)
	State.insertParent = parentPath or ROOT_PATH
	GUI.InsertCardFrame.Size = UDim2.fromOffset(220, 168)
	GUI.InsertFolderNameFrame.Visible = false
	GUI.InsertOptionsFrame.Visible = true
	GUI.InsertModalCard.Visible = true
end

GUI.InsertCardCloseBtn.MouseButton1Click:Connect(function()
	GUI.InsertModalCard.Visible = false
end)

GUI.FolderCancelBtn.MouseButton1Click:Connect(function()
	GUI.InsertModalCard.Visible = false
end)

GUI.FolderCreateBtn.MouseButton1Click:Connect(function()
	local folderName = sanitizeName(GUI.FolderNameInput.Text)
	if folderName == "" then folderName = "Folder" end

	ensureRoot()
	local dir = isInsideRoot(State.insertParent) and State.insertParent or ROOT_PATH
	local finalName = uniqueName(dir, folderName, "")
	local fullPath = normalizePath(dir .. "/" .. finalName)

	if type(makefolder) == "function" then
		pcall(makefolder, fullPath)
	end
	State.expand[dir] = true
	State.expand[fullPath] = true
	populateExplorer(GUI.ExpSearchInput.Text)
	GUI.InsertModalCard.Visible = false
end)

function updateSaveFolders()
	for _, child in ipairs(GUI.FolderDropdown:GetChildren()) do
		if child:IsA("TextButton") then child:Destroy() end
	end

	local allFolders = { ROOT_PATH }
	local function collect(dir: string, depth: number)
		if depth > 10 then return end
		local folders = listDirectory(dir)
		for _, folder in ipairs(folders) do
			table.insert(allFolders, folder.path)
			collect(folder.path, depth + 1)
		end
	end
	collect(ROOT_PATH, 1)

	for index, folderPath in ipairs(allFolders) do
		local btn = make("TextButton", nil, {
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundColor3 = Theme.Hover,
			BackgroundTransparency = (State.saveFolder == folderPath) and 0.2 or 1,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = formatBreadcrumb(folderPath),
			TextColor3 = Theme.White,
			Font = Fonts.Medium,
			TextSize = Sizes.Input,
			TextXAlignment = Enum.TextXAlignment.Left,
			LayoutOrder = index,
			ZIndex = 31,
		}, GUI.FolderDropdown)
		round(btn, 4)
		make("UIPadding", nil, { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, btn)

		btn.MouseButton1Click:Connect(function()
			State.saveFolder = folderPath
			GUI.FolderSelectBtn.Text = formatBreadcrumb(folderPath)
			GUI.FolderDropdown.Visible = false
		end)
	end
	GUI.FolderDropdown.Size = UDim2.new(1, -24, 0, math.min(#allFolders * 24 + 4, 90))
end

GUI.FolderSelectBtn.MouseButton1Click:Connect(function()
	GUI.FolderDropdown.Visible = not GUI.FolderDropdown.Visible
end)

local function closeSaveCard()
	GUI.SaveModalCard.Visible = false
	GUI.FolderDropdown.Visible = false
end

GUI.CardCancelBtn.MouseButton1Click:Connect(closeSaveCard)
GUI.SaveCardCloseBtn.MouseButton1Click:Connect(closeSaveCard)

GUI.CardSaveBtn.MouseButton1Click:Connect(function()
	local tab = getActiveTab()
	local fallbackExt = tab and getExtension(tab.filename) or "lua"
	local filename = sanitizeName(GUI.FileNameInput.Text)
	if filename == "" then
		filename = tab and tab.filename or "script.lua"
	end
	filename = ensureSupportedName(filename, SUPPORTED_EXTENSIONS[fallbackExt] and fallbackExt or "lua")

	ensureRoot()
	local targetDir = isInsideRoot(State.saveFolder) and normalizePath(State.saveFolder) or ROOT_PATH
	local oldPath = tab and tab.filePath or nil
	local fullPath = normalizePath(targetDir .. "/" .. filename)

	if fullPath ~= oldPath and pathExists(fullPath) then
		local base = filename:match("^(.*)%.[^%.]+$") or filename
		local ext = getExtension(filename) or "lua"
		filename = uniqueName(targetDir, base, "." .. ext)
		fullPath = normalizePath(targetDir .. "/" .. filename)
	end

	if type(writefile) ~= "function" then
		closeSaveCard()
		return
	end

	local ok = pcall(writefile, fullPath, GUI.CodeInput.Text)
	if not ok then
		addConsoleEntry("Could not save " .. fullPath, "Error", "Save")
		closeSaveCard()
		return
	end

	if oldPath and oldPath ~= fullPath and type(delfile) == "function" then
		pcall(delfile, oldPath)
	end

	if tab then
		tab.filename = filename
		tab.parentPath = targetDir
		tab.filePath = fullPath
		tab.content = GUI.CodeInput.Text
		renderTabs()
		updateBreadcrumb(tab)
		updateStatusBarDetails()
	end

	State.selectedPath = fullPath
	State.selectedIsFolder = false
	State.expand[targetDir] = true
	populateExplorer(GUI.ExpSearchInput.Text)
	closeSaveCard()
end)

-- Fix ClearBtn: Cukup hapus code yang ter load di CodeInput, BUKAN clear isi file aslinya
GUI.ClearBtn.MouseButton1Click:Connect(function()
	setEditorText("")
	Editor.setScroll(0, 0)
	-- Catatan: File asli di disk tidak pernah dihapus/di-clear oleh tombol Clear ini
end)

GUI.CopyBtn.MouseButton1Click:Connect(function()
	if type(setclipboard) == "function" then
		pcall(setclipboard, GUI.CodeInput.Text)
	end
end)

GUI.SaveBtn.MouseButton1Click:Connect(function()
	local tab = getActiveTab()
	if tab then
		GUI.FileNameInput.Text = tab.filename
		State.saveFolder = isInsideRoot(tab.parentPath) and normalizePath(tab.parentPath) or ROOT_PATH
	end
	GUI.FolderSelectBtn.Text = formatBreadcrumb(State.saveFolder)
	updateSaveFolders()
	GUI.SaveModalCard.Visible = true
end)

GUI.DeleteBtn.MouseButton1Click:Connect(function()
	local target = State.selectedPath

	if target and State.selectedIsFolder then
		if normalizePath(target) ~= ROOT_PATH then
			if type(delfolder) == "function" then
				pcall(delfolder, target)
			end
			State.selectedPath = ROOT_PATH
			State.selectedIsFolder = true
			populateExplorer(GUI.ExpSearchInput.Text)
		else
			addConsoleEntry("Root folder 'Ecode' cannot be deleted.", "Warning", "Explorer")
		end
		return
	end

	if target and not State.selectedIsFolder then
		if type(isfile) == "function" and type(delfile) == "function" then
			pcall(delfile, target)
			State.selectedPath = nil
			populateExplorer(GUI.ExpSearchInput.Text)
		end
		return
	end

	local tab = getActiveTab()
	if tab and tab.filePath and tab.filePath ~= "" then
		if type(isfile) == "function" and type(delfile) == "function" then
			pcall(delfile, tab.filePath)
			tab.filePath = nil
			populateExplorer(GUI.ExpSearchInput.Text)
		end
	end
end)

GUI.ExecBtn.MouseButton1Click:Connect(function()
	if Config.clearConsoleOnRun then
		State.clearConsole()
	end

	if Config.autoSaveOnRun then
		local activeTab = getActiveTab()
		if activeTab and activeTab.filePath and activeTab.filePath ~= "" and type(writefile) == "function" then
			pcall(writefile, activeTab.filePath, GUI.CodeInput.Text)
		end
	end

	if type(executorLoadstring) ~= "function" then
		addConsoleEntry("loadstring is not supported by this executor", "Error", "Compiler")
		return
	end

	local logConnection = Services.LogService.MessageOut:Connect(function(msg, msgType)
		local cat = "Info"
		if msgType == Enum.MessageType.MessageWarning then cat = "Warning" end
		if msgType == Enum.MessageType.MessageError then cat = "Error" end
		addConsoleEntry(msg, cat, "Output")
	end)

	local fn, err = executorLoadstring(GUI.CodeInput.Text)
	if fn then
		local ok, runtimeError = pcall(fn)
		if not ok then
			addConsoleEntry(tostring(runtimeError), "Error", "Runtime")
		end
	else
		addConsoleEntry(tostring(err), "Error", "Compiler")
	end

	task.delay(0.1, function()
		if logConnection then logConnection:Disconnect() end
	end)
end)

function Editor.calibrate()
	State.calibrateToken = (State.calibrateToken or 0) + 1
	local token = State.calibrateToken

	task.spawn(function()
		local function makeProbe(text: string)
			return make("TextLabel", nil, {
				Size = UDim2.fromOffset(200, 20),
				Position = UDim2.fromOffset(-5000, -5000),
				BackgroundTransparency = 1,
				TextTransparency = 1,
				Font = Fonts.Code,
				TextSize = CODE_TEXT_SIZE,
				LineHeight = CODE_LINE_HEIGHT,
				TextWrapped = false,
				RichText = false,
				Text = text,
			}, GUI.ScreenGui)
		end

		local single = makeProbe("A")
		local multi = makeProbe(string.rep("A\n", 39) .. "A")
		Services.RunService.Heartbeat:Wait()
		Services.RunService.Heartbeat:Wait()
		local singleHeight = single.TextBounds.Y
		local multiHeight = multi.TextBounds.Y
		single:Destroy()
		multi:Destroy()

		if token ~= State.calibrateToken or not GUI.ScreenGui.Parent then return end

		local pitch = (multiHeight - singleHeight) / 39
		local drift = math.abs(pitch - LINE_HEIGHT)
		if pitch > 4 and drift > 0.01 and drift <= LINE_HEIGHT * 0.25 then
			LINE_HEIGHT = pitch
			State.gutterFirst = nil
			State.gutterLast = nil
			State.hlFirst = nil
			State.hlLast = nil
			updateEditorLayout()
			renderHighlight()
		end
	end)
end

function Editor.applyFontSize(size: number)
	CODE_TEXT_SIZE = size
	GUI.CodeInput.TextSize = size
	GUI.HighlightLabel.TextSize = size
	GUI.LineLabel.TextSize = size
	LINE_HEIGHT = measureLineHeight()
	CHAR_WIDTH = math.max(measureText("0").X, 5)
	State.gutterWidth = -1
	State.gutterFirst = nil
	State.gutterLast = nil
	State.hlFirst = nil
	State.hlLast = nil
	updateEditorLayout()
	renderHighlight()
	Editor.calibrate()
end

-- ========================================================
-- SETTINGS MODAL & CARDS (Updated per user instructions)
-- ========================================================
State.settingsReady = (function()
	local TweenService = Services.TweenService
	local UserInputService = Services.UserInputService
	local controls = {}
	local Apply = {}
	local rowCounters = {}
	local bodyOrder = 0

	local function nextBodyOrder()
		bodyOrder += 1
		return bodyOrder
	end

	local function nextRowOrder(section: Instance)
		rowCounters[section] = (rowCounters[section] or 0) + 1
		return rowCounters[section]
	end

	Apply.syntax = function()
		renderHighlight()
	end
	Apply.autocomplete = function(value)
		if not value then
			hideSuggestions()
		end
	end
	Apply.autoIndent = function(value)
		EDITOR_AUTO_INDENT = value
	end
	Apply.autoClose = function(value)
		EDITOR_AUTO_PAIR = value
	end
	Apply.lineNumbers = function()
		updateEditorLayout()
	end
	Apply.activeLine = function()
		updateStatusBarDetails()
	end
	Apply.fontSize = function(value)
		Editor.applyFontSize(value)
	end
	Apply.clearConsoleOnRun = function() end
	Apply.autoSaveOnRun = function() end
	Apply.confirmClose = function() end

	makeModal("SettingsModalCard", 45)

	make("Frame", "SettingsCard", {
		Size = UDim2.new(0, 320, 1, -24),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		BackgroundColor3 = Theme.SurfaceElevated,
		BorderSizePixel = 0,
		ZIndex = 46,
	}, GUI.SettingsModalCard)
	round(GUI.SettingsCard, 8)
	subtleOutline(GUI.SettingsCard, Theme.ToolbarBorder, 0.5)
	make("UISizeConstraint", nil, {
		MinSize = Vector2.new(260, 180),
		MaxSize = Vector2.new(340, 420),
	}, GUI.SettingsCard)
	local cardScale = make("UIScale", nil, { Scale = 1 }, GUI.SettingsCard)

	make("Frame", "SettingsHeader", {
		Size = UDim2.new(1, 0, 0, 32),
		BackgroundTransparency = 1,
	}, GUI.SettingsCard)

	make("ImageLabel", "SettingsHeaderIcon", {
		Size = UDim2.fromOffset(14, 14),
		Position = UDim2.new(0, 12, 0, 9),
		BackgroundTransparency = 1,
		Image = Icon.Settings,
		ImageColor3 = Theme.White,
	}, GUI.SettingsHeader)

	addLabel(GUI.SettingsHeader, "SettingsHeaderTitle", {
		Size = UDim2.new(1, -60, 1, 0),
		Position = UDim2.new(0, 32, 0, 0),
		Text = "Settings",
		Font = Fonts.Bold,
		TextSize = Sizes.Card,
		TextColor3 = Theme.White,
	})

	makeIconButton(GUI.SettingsHeader, "SettingsCloseBtn", Icon.Close, UDim2.new(1, -22, 0, 10), 12)

	local body = make("ScrollingFrame", "SettingsBody", {
		Size = UDim2.new(1, 0, 1, -32),
		Position = UDim2.fromOffset(0, 32),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.MutedDark,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
	}, GUI.SettingsCard)

	make("UIListLayout", nil, {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
	}, body)

	make("UIPadding", nil, {
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 12),
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
	}, body)

	-- Helper create sleek expandable card WITHOUT line dividers
	local function makeCollapsibleCard(titleText: string, iconAsset: string?, initiallyExpanded: boolean?, hasExpandCollapse: boolean?)
		if hasExpandCollapse == nil then hasExpandCollapse = true end
		if initiallyExpanded == nil then initiallyExpanded = true end

		local card = make("Frame", nil, {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.PanelBg,
			BorderSizePixel = 0,
			LayoutOrder = nextBodyOrder(),
		}, body)
		round(card, 6)
		subtleOutline(card, Theme.ToolbarBorder, 0.5)

		make("UIListLayout", nil, {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2),
		}, card)

		make("UIPadding", nil, {
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 6),
			PaddingBottom = UDim.new(0, 6),
		}, card)

		local headerBtn = make("TextButton", nil, {
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
			AutoButtonColor = false,
			Text = "",
			LayoutOrder = 0,
		}, card)

		local titleX = 0
		if iconAsset and iconAsset ~= "" then
			make("ImageLabel", nil, {
				Size = UDim2.fromOffset(12, 12),
				Position = UDim2.new(0, 0, 0.5, -6),
				BackgroundTransparency = 1,
				Image = iconAsset,
				ImageColor3 = Theme.Muted,
			}, headerBtn)
			titleX = 18
		end

		addLabel(headerBtn, nil, {
			Size = UDim2.new(1, -(titleX + (hasExpandCollapse and 24 or 0)), 1, 0),
			Position = UDim2.fromOffset(titleX, 0),
			Text = titleText,
			Font = Fonts.Bold,
			TextSize = Sizes.Input,
			TextColor3 = Theme.White,
		})

		local arrow = nil
		if hasExpandCollapse then
			arrow = make("ImageLabel", nil, {
				Size = UDim2.fromOffset(10, 10),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, 0, 0.5, 0),
				BackgroundTransparency = 1,
				Image = initiallyExpanded and Icon.ArrowUp or Icon.ArrowDown,
				ImageColor3 = Theme.Muted,
			}, headerBtn)
		end

		local content = make("Frame", nil, {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			Visible = initiallyExpanded,
			LayoutOrder = 1,
		}, card)

		make("UIListLayout", nil, {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		}, content)

		local isExpanded = initiallyExpanded
		local function setExpanded(exp: boolean)
			isExpanded = exp
			content.Visible = exp
			if arrow then
				arrow.Image = exp and Icon.ArrowUp or Icon.ArrowDown
			end
		end

		if hasExpandCollapse then
			headerBtn.MouseButton1Click:Connect(function()
				setExpanded(not isExpanded)
			end)
		end

		return card, content, headerBtn, setExpanded
	end

	-- Row inside card (tanpa line garis pembatas)
	local function makeRow(parent: Instance, iconKey: string?, labelText: string, controlWidth: number?)
		local row = make("Frame", nil, {
			Size = UDim2.new(1, 0, 0, 24),
			BackgroundTransparency = 1,
			LayoutOrder = nextRowOrder(parent),
		}, parent)

		local textX = 0
		local iconId = iconKey and Icon[iconKey] or ""
		if type(iconId) == "string" and iconId ~= "" then
			make("ImageLabel", nil, {
				Size = UDim2.fromOffset(12, 12),
				Position = UDim2.new(0, 0, 0.5, -6),
				BackgroundTransparency = 1,
				Image = iconId,
				ImageColor3 = Theme.Muted,
			}, row)
			textX = 20
		end

		addLabel(row, nil, {
			Size = UDim2.new(1, -(textX + (controlWidth or 40) + 6), 1, 0),
			Position = UDim2.fromOffset(textX, 0),
			Text = labelText,
			Font = Fonts.Medium,
			TextSize = Sizes.Input,
			TextColor3 = Theme.White,
			TextTruncate = Enum.TextTruncate.AtEnd,
		})

		return row
	end

	local function makeSmallButton(parent: Instance, text: string, width: number, primary: boolean?)
		local btn = make("TextButton", nil, {
			Size = UDim2.fromOffset(width, 20),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundColor3 = primary and Theme.White or Theme.SurfaceElevated,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = text,
			TextColor3 = primary and Theme.PanelBg or Theme.White,
			Font = Fonts.Bold,
			TextSize = 10,
		}, parent)
		round(btn, 4)
		if not primary then
			subtleOutline(btn, Theme.ToolbarBorder, 0.5)
		end
		btn.MouseButton1Down:Connect(function() animateClick(btn) end)
		return btn
	end

	local function makeToggle(row: Instance, key: string)
		local track = make("TextButton", nil, {
			Size = UDim2.fromOffset(26, 14),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundColor3 = Theme.SurfaceElevated,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		}, row)
		round(track, 7)
		subtleOutline(track, Theme.ToolbarBorder, 0.5)

		local knob = make("Frame", nil, {
			Size = UDim2.fromOffset(10, 10),
			Position = UDim2.new(0, 2, 0.5, -5),
			BackgroundColor3 = Theme.Muted,
			BorderSizePixel = 0,
		}, track)
		round(knob, 5)

		local function render(value: boolean, instant: boolean?)
			local info = TweenInfo.new(instant and 0 or 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			TweenService:Create(track, info, {
				BackgroundColor3 = value and Theme.White or Theme.SurfaceElevated,
			}):Play()
			TweenService:Create(knob, info, {
				Position = value and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5),
				BackgroundColor3 = value and Theme.PanelBg or Theme.Muted,
			}):Play()
		end

		render(Config[key], true)
		controls[key] = { set = render }

		track.MouseButton1Click:Connect(function()
			Config[key] = not Config[key]
			render(Config[key])
			Apply[key](Config[key])
			saveSettings()
		end)
	end

	local function makeCheckbox(row: Instance, key: string)
		local box = make("TextButton", nil, {
			Size = UDim2.fromOffset(14, 14),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundColor3 = Theme.SurfaceElevated,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Text = "",
		}, row)
		round(box, 3)
		subtleOutline(box, Theme.ToolbarBorder, 0.5)

		local check = make("ImageLabel", nil, {
			Size = UDim2.fromOffset(10, 10),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BackgroundTransparency = 1,
			Image = Icon.Checklist,
			ImageColor3 = Theme.PanelBg,
			Visible = false,
		}, box)

		local function render(value: boolean)
			box.BackgroundColor3 = value and Theme.White or Theme.SurfaceElevated
			check.Visible = value
		end

		render(Config[key])
		controls[key] = { set = render }

		box.MouseButton1Click:Connect(function()
			Config[key] = not Config[key]
			render(Config[key])
			Apply[key](Config[key])
			saveSettings()
		end)
	end

	local function makeStepper(row: Instance, key: string, minValue: number, maxValue: number)
		local holder = make("Frame", nil, {
			Size = UDim2.fromOffset(46, 20),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, 0, 0.5, 0),
			BackgroundTransparency = 1,
		}, row)

		local input = make("TextBox", nil, {
			Size = UDim2.fromOffset(30, 20),
			Position = UDim2.fromOffset(0, 0),
			BackgroundColor3 = Theme.SurfaceElevated,
			BorderSizePixel = 0,
			Text = tostring(Config[key]),
			PlaceholderText = "",
			TextColor3 = Theme.White,
			Font = Fonts.Code,
			TextSize = Sizes.Input,
			TextXAlignment = Enum.TextXAlignment.Center,
			ClearTextOnFocus = false,
		}, holder)
		round(input, 4)
		subtleOutline(input, Theme.ToolbarBorder, 0.5)

		local function arrowButton(asset: string, y: number)
			local btn = make("ImageButton", nil, {
				Size = UDim2.fromOffset(12, 9),
				Position = UDim2.fromOffset(34, y),
				BackgroundTransparency = 1,
				AutoButtonColor = false,
				Image = asset,
				ImageColor3 = Theme.Muted,
				ScaleType = Enum.ScaleType.Fit,
			}, holder)
			btn.MouseEnter:Connect(function() btn.ImageColor3 = Theme.White end)
			btn.MouseLeave:Connect(function() btn.ImageColor3 = Theme.Muted end)
			return btn
		end

		local up = arrowButton(Icon.ArrowUp, 1)
		local down = arrowButton(Icon.ArrowDown, 10)

		local function commit(value: number)
			value = math.clamp(math.floor(value + 0.5), minValue, maxValue)
			Config[key] = value
			input.Text = tostring(value)
			Apply[key](value)
			saveSettings()
		end

		controls[key] = {
			set = function(value)
				input.Text = tostring(value)
			end,
		}

		up.MouseButton1Click:Connect(function() commit(Config[key] + 1) end)
		down.MouseButton1Click:Connect(function() commit(Config[key] - 1) end)

		input:GetPropertyChangedSignal("Text"):Connect(function()
			local clean = string.sub((string.gsub(input.Text, "%D", "")), 1, 2)
			if clean ~= input.Text then
				input.Text = clean
			end
		end)

		input.FocusLost:Connect(function()
			local typed = tonumber(string.match(input.Text, "%d+"))
			commit(typed or Config[key])
		end)

		connect(UserInputService.InputBegan, function(inputObject)
			if not input:IsFocused() then return end
			if inputObject.KeyCode == Enum.KeyCode.Up then
				commit(Config[key] + 1)
			elseif inputObject.KeyCode == Enum.KeyCode.Down then
				commit(Config[key] - 1)
			end
		end)
	end

	local function executorInfo(): string
		local name, ver = identifyExecutor()
		if ver and ver ~= "" then
			return name .. " " .. ver
		end
		return name
	end

	-- ==========================================================
	-- CARD 1: Community & About (Disatukan, Banner didalam card)
	-- ==========================================================
	local _, commContent, _, _ = makeCollapsibleCard("Community & About", Icon.Discord, true, true)

	-- Banner ImageLabel memakai UICorner didalam card community
	local banner = make("ImageLabel", "SettingsBanner", {
		Size = UDim2.new(1, 0, 0, 72),
		BackgroundColor3 = Theme.Black,
		BorderSizePixel = 0,
		Image = Icon.Banner,
		ScaleType = Enum.ScaleType.Crop,
		ClipsDescendants = true,
		LayoutOrder = nextRowOrder(commContent),
	}, commContent)
	round(banner, 6)

	-- Button Discord Join
	local joinRow = makeRow(commContent, "Discord", "Join Discord", 44)
	local joinBtn = makeSmallButton(joinRow, "Join", 44, true)

	local function flashJoin(text: string)
		joinBtn.Text = text
		task.delay(1.4, function()
			if joinBtn.Parent then joinBtn.Text = "Join" end
		end)
	end

	local function openInvite(url: string): boolean
		local code = string.match(url, "discord%.gg/([%w%-_]+)") or string.match(url, "discord%.com/invite/([%w%-_]+)")
		local request = executorEnv.request or executorEnv.http_request
		if code and type(request) == "function" then
			local okJson, payload = pcall(function()
				return Services.HttpService:JSONEncode({
					cmd = "INVITE_BROWSER",
					args = { code = code },
					nonce = Services.HttpService:GenerateGUID(false),
				})
			end)
			if okJson then
				local ok, response = pcall(request, {
					Url = "http://127.0.0.1:6463/rpc?v=1",
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json",
						["Origin"] = "https://discord.com",
					},
					Body = payload,
				})
				if ok and type(response) == "table" and response.StatusCode == 200 then
					return true
				end
			end
		end
		return false
	end

	joinBtn.MouseButton1Click:Connect(function()
		local url = Community.DiscordInvite
		if type(url) ~= "string" or url == "" then
			flashJoin("No URL")
			return
		end
		if openInvite(url) then
			flashJoin("Opened")
			return
		end
		if type(setclipboard) == "function" and pcall(setclipboard, url) then
			flashJoin("Copied")
		else
			flashJoin("Failed")
		end
	end)

	-- Creator : NarsEdv | Executor : ExecutorIdentify
	local infoRow = make("Frame", nil, {
		Size = UDim2.new(1, 0, 0, 22),
		BackgroundTransparency = 1,
		LayoutOrder = nextRowOrder(commContent),
	}, commContent)

	local infoLabel = addLabel(infoRow, "CreatorExecutorLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		Text = "Creator : NarsEdv | Executor : " .. executorInfo(),
		TextColor3 = Theme.Muted,
		Font = Fonts.Medium,
		TextSize = Sizes.Input,
		TextTruncate = Enum.TextTruncate.AtEnd,
	})

	-- Description Ecode
	local descText = addLabel(commContent, nil, {
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = "Ecode is a Luau script editor for Roblox executors with syntax highlighting, autocomplete, a file explorer, tabs and a built-in console.",
		TextColor3 = Theme.Muted,
		Font = Fonts.Regular,
		TextSize = Sizes.Body,
		TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Top,
		LayoutOrder = nextRowOrder(commContent),
	})
	make("UIPadding", nil, {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 2),
	}, descText)

	-- ==========================================================
	-- CARD 2: sUNC API (List disembunyikan sampai user klik RUN)
	-- ==========================================================
	local _, suncContent, suncHeader, setSuncExp = makeCollapsibleCard("sUNC API", Icon.SettingsSunc, false, true)

	local suncRunBtn = makeSmallButton(suncHeader, "RUN", 38)
	suncRunBtn.Position = UDim2.new(1, -18, 0.5, 0)

	local suncSummary = addLabel(suncContent, nil, {
		Size = UDim2.new(1, 0, 0, 16),
		Text = "Click RUN button to detect APIs.",
		TextColor3 = Theme.Muted,
		TextSize = Sizes.Body,
		LayoutOrder = 1,
	})

	local apiList = make("ScrollingFrame", "SuncApiList", {
		Size = UDim2.new(1, 0, 0, 130),
		BackgroundColor3 = Theme.Black,
		BorderSizePixel = 0,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.MutedDark,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false, -- Jangan dulu ada list ya sampai user klik run
		LayoutOrder = 2,
	}, suncContent)
	round(apiList, 4)
	make("UIListLayout", nil, {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
	}, apiList)
	make("UIPadding", nil, {
		PaddingLeft = UDim.new(0, 8),
		PaddingRight = UDim.new(0, 8),
		PaddingTop = UDim.new(0, 4),
		PaddingBottom = UDim.new(0, 4),
	}, apiList)

	local Verify = {
		loadstring = function(fn)
			local ok, chunk = pcall(fn, "return 1")
			return ok and type(chunk) == "function"
		end,
	}

	local function lookup(root: any, path: string): any
		local value = root
		for segment in string.gmatch(path, "[^%.]+") do
			if type(value) ~= "table" then return nil end
			local ok, nextValue = pcall(function() return value[segment] end)
			if not ok then return nil end
			value = nextValue
		end
		return value
	end

	local function detect(path: string): boolean
		local roots = { executorEnv }
		local getGenv = executorEnv.getgenv
		if type(getGenv) == "function" then
			local ok, genv = pcall(getGenv)
			if ok and type(genv) == "table" then
				table.insert(roots, genv)
			end
		end

		for _, root in ipairs(roots) do
			local value = lookup(root, path)
			if type(value) == "function" then
				local verify = Verify[path]
				if not verify then return true end
				local ok, result = pcall(verify, value)
				if ok and result == true then return true end
			end
		end
		return false
	end

	local apiRows = {}
	local apiIndex = 0
	for _, group in ipairs(SuncApiOrder) do
		for _, name in ipairs(group) do
			apiIndex += 1
			local row = make("Frame", nil, {
				Size = UDim2.new(1, 0, 0, 18),
				BackgroundTransparency = 1,
				LayoutOrder = apiIndex,
			}, apiList)

			addLabel(row, nil, {
				Size = UDim2.new(1, -62, 1, 0),
				Text = name,
				Font = Fonts.Code,
				TextSize = 10,
				TextColor3 = Theme.White,
				TextTruncate = Enum.TextTruncate.AtEnd,
			})

			local status = addLabel(row, nil, {
				Size = UDim2.fromOffset(58, 18),
				AnchorPoint = Vector2.new(1, 0),
				Position = UDim2.new(1, 0, 0, 0),
				Text = "--",
				TextColor3 = Theme.MutedDark,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Right,
			})

			table.insert(apiRows, { name = name, status = status })
		end
	end

	local function scanApis()
		local found, total = 0, 0
		for _, entry in ipairs(apiRows) do
			total += 1
			local present = detect(entry.name)
			if present then found += 1 end
			entry.status.Text = present and "Found" or "Missing"
			entry.status.TextColor3 = present and Theme.Green or Theme.Red
		end
		suncSummary.Text = string.format("Detected: %d / %d", found, total)
	end

	suncRunBtn.MouseButton1Click:Connect(function()
		scanApis()
		apiList.Visible = true
		setSuncExp(true)
		suncRunBtn.Text = "DONE"
		task.delay(1, function()
			if suncRunBtn.Parent then suncRunBtn.Text = "RUN" end
		end)
	end)

	-- ==========================================================
	-- CARD 3: Editor Setting (Expand/Collapse, Tanpa Line Separator)
	-- ==========================================================
	local _, editorContent, _, _ = makeCollapsibleCard("Editor Settings", Icon.Code, true, true)
	makeToggle(makeRow(editorContent, "SettingsSyntax", "Syntax Highlighting", 26), "syntax")
	makeToggle(makeRow(editorContent, "SettingsAutocomplete", "Autocomplete", 26), "autocomplete")
	makeCheckbox(makeRow(editorContent, "SettingsAutoIndent", "Auto Indent", 14), "autoIndent")
	makeCheckbox(makeRow(editorContent, "SettingsAutoClose", "Auto Close Brackets", 14), "autoClose")
	makeCheckbox(makeRow(editorContent, "SettingsLineNumbers", "Line Numbers", 14), "lineNumbers")
	makeToggle(makeRow(editorContent, "SettingsActiveLine", "Highlight Active Line", 26), "activeLine")
	makeStepper(makeRow(editorContent, "SettingsFontSize", "Font Size", 46), "fontSize", 10, 20)

	-- ==========================================================
	-- CARD 4: General Setting (Tanpa FPS & Ping)
	-- ==========================================================
	local _, generalContent, _, _ = makeCollapsibleCard("General Settings", Icon.Settings, true, true)
	makeCheckbox(makeRow(generalContent, "SettingsClearConsole", "Clear Console on Run", 14), "clearConsoleOnRun")
	makeCheckbox(makeRow(generalContent, "SettingsAutoSave", "Auto Save on Run", 14), "autoSaveOnRun")
	makeToggle(makeRow(generalContent, "SettingsConfirmClose", "Confirm Before Closing", 26), "confirmClose")

	-- ==========================================================
	-- CARD 5: Data Setting (Ga usah di beri Expand dan Collapse)
	-- ==========================================================
	local _, dataContent, _, _ = makeCollapsibleCard("Data Settings", Icon.SettingsReset, true, false)
	local resetRow = makeRow(dataContent, "SettingsReset", "Reset Settings", 44)
	local resetBtn = makeSmallButton(resetRow, "Reset", 44)

	resetBtn.MouseButton1Click:Connect(function()
		for key, value in pairs(ConfigDefaults) do
			Config[key] = value
		end
		for key, control in pairs(controls) do
			control.set(Config[key], true)
		end
		for key in pairs(ConfigDefaults) do
			Apply[key](Config[key])
		end
		saveSettings()
		resetBtn.Text = "Done"
		task.delay(1.4, function()
			if resetBtn.Parent then resetBtn.Text = "Reset" end
		end)
	end)

	-- Open / close settings
	local openToken = 0
	local function setOpen(open: boolean)
		openToken += 1
		local token = openToken
		local overlay = GUI.SettingsModalCard

		if open then
			infoLabel.Text = "Creator : NarsEdv | Executor : " .. executorInfo()
			overlay.BackgroundTransparency = 1
			cardScale.Scale = 0.92
			overlay.Visible = true
			TweenService:Create(overlay, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				BackgroundTransparency = 0.55,
			}):Play()
			TweenService:Create(cardScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Scale = 1,
			}):Play()
		else
			TweenService:Create(overlay, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				BackgroundTransparency = 1,
			}):Play()
			local shrink = TweenService:Create(cardScale, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Scale = 0.94,
			})
			shrink.Completed:Connect(function()
				if openToken == token then
					overlay.Visible = false
				end
			end)
			shrink:Play()
		end
	end

	GUI.SettingsBtn.MouseButton1Click:Connect(function() setOpen(true) end)
	GUI.SettingsCloseBtn.MouseButton1Click:Connect(function() setOpen(false) end)

	return true
end)()

addTab("script.lua", "", ROOT_PATH, nil, true)
populateExplorer("")
updateConsoleLayout()
Editor.calibrate()
