-- Plugin Store Asset Roblox 
-- Category, Model-Decal-Audio-Plugin-Meshes-Font-Images-Material-Vidio
-- Creator NarsEdv

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

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")

local Icon = {
	Empty = "rbxassetid://",
	OpenLeft = "rbxassetid://73780377692148",
	OpenRight = "rbxassetid://92473583511724",
	Close = "rbxassetid://110786993356448",
	Minimize = "rbxassetid://118026365011536",
	Restore = "rbxassetid://134243273101015",
	Dock = "rbxassetid://103542107889511",
	Search = "rbxassetid://121018724060431",
	Save = "rbxassetid://74987060545093",
	Bookmark = "rbxassetid://74987060545093",
	Like = "rbxassetid://137562742336291",
	Check = "rbxassetid://93898873302694",
	Arrow = "rbxassetid://139953983876976",
	Logo = "rbxassetid://81919005304103",
}

local function generateName()
	local bytes = {}

	for i = 1, 32 do
		bytes[i] = string.char(math.random(1, 255))
	end

	return "_NarsEdvStore_" .. table.concat(bytes)
end

local function playTween(
	object: Instance,
	duration: number,
	goal: {[string]: any},
	style: Enum.EasingStyle?,
	direction: Enum.EasingDirection?
): Tween
	local tween = TweenService:Create(
		object,
		TweenInfo.new(
			duration,
			style or Enum.EasingStyle.Quad,
			direction or Enum.EasingDirection.Out
		),
		goal
	)
	tween:Play()
	return tween
end

local function isPointerInput(input: InputObject): boolean
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end

local function lighten(color: Color3, amount: number): Color3
	return color:Lerp(Color3.new(1, 1, 1), amount)
end

local InputConnections = {}

local function ConnectInput(signal: RBXScriptSignal, callback)
	local connection = signal:Connect(callback)
	table.insert(InputConnections, connection)
	return connection
end

local function DisconnectInputs()
	for _, connection in ipairs(InputConnections) do
		connection:Disconnect()
	end

	table.clear(InputConnections)
end

local function bindInteraction(
	source: GuiObject,
	target: Instance,
	hoverGoal: {[string]: any},
	pressGoal: {[string]: any}
)
	local targetProperties = target :: any
	local baseGoal: {[string]: any} = {}

	for property in pairs(hoverGoal) do
		baseGoal[property] = targetProperties[property]
	end

	for property in pairs(pressGoal) do
		baseGoal[property] = targetProperties[property]
	end

	if source:IsA("GuiButton") then
		local button = source :: any
		button.AutoButtonColor = false
	end

	local hovering = false
	local pressing = false

	local function refresh()
		local goal: {[string]: any} = {}

		for property, value in pairs(baseGoal) do
			goal[property] = value
		end

		if hovering then
			for property, value in pairs(hoverGoal) do
				goal[property] = value
			end
		end

		if pressing then
			for property, value in pairs(pressGoal) do
				goal[property] = value
			end
		end

		if next(goal) ~= nil then
			playTween(target, 0.12, goal)
		end
	end

	source.MouseEnter:Connect(function()
		hovering = true
		refresh()
	end)

	source.MouseLeave:Connect(function()
		hovering = false
		pressing = false
		refresh()
	end)

	source.InputBegan:Connect(function(input: InputObject)
		if isPointerInput(input) then
			pressing = true
			refresh()
		end
	end)

	source.InputEnded:Connect(function(input: InputObject)
		if isPointerInput(input) then
			pressing = false
			refresh()
		end
	end)

	source:GetPropertyChangedSignal("Visible"):Connect(function()
		if not source.Visible then
			hovering = false
			pressing = false
			refresh()
		end
	end)

	return {
		SetBase = function(property: string, value: any)
			baseGoal[property] = value
			refresh()
		end,
	}
end

local INTERFACE_MARK = "NarsEdvStoreInterface"
local INTERFACE_REGISTRY = "__NarsEdvStoreInterface"

local function destroyPreviousInterface()
	local globalEnv = nil
	local getGlobalEnv = executorEnv.getgenv or getgenv

	if type(getGlobalEnv) == "function" then
		local ok, result = pcall(getGlobalEnv)

		if ok and type(result) == "table" then
			globalEnv = result
		end
	end

	if globalEnv then
		local previous = globalEnv[INTERFACE_REGISTRY]
		globalEnv[INTERFACE_REGISTRY] = nil

		if typeof(previous) == "Instance" then
			pcall(function()
				previous:Destroy()
			end)
		end
	end

	local containers = {host}

	pcall(function()
		table.insert(containers, game:GetService("CoreGui"))
	end)

	pcall(function()
		local localPlayer = Players.LocalPlayer
		local playerGui = localPlayer and localPlayer:FindFirstChildOfClass("PlayerGui")

		if playerGui then
			table.insert(containers, playerGui)
		end
	end)

	for _, container in ipairs(containers) do
		pcall(function()
			for _, child in ipairs(container:GetChildren()) do
				if child:IsA("ScreenGui") and child:GetAttribute(INTERFACE_MARK) == true then
					child:Destroy()
				end
			end
		end)
	end

	return globalEnv
end

local function buildInterface()
	local globalEnv = destroyPreviousInterface()
	local screenGui = Instance.new("ScreenGui")

	screenGui.Name = generateName()
	screenGui.DisplayOrder = 999
	screenGui.Enabled = true
	screenGui.IgnoreGuiInset = true
	screenGui.ResetOnSpawn = true
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	screenGui:SetAttribute(INTERFACE_MARK, true)

	if globalEnv then
		globalEnv[INTERFACE_REGISTRY] = screenGui
	end

	screenGui.Parent = host

	local openButton = Instance.new("ImageButton")

	openButton.Name = generateName()
	openButton.AnchorPoint = Vector2.new(0.0, 0.0)
	openButton.Size = UDim2.fromOffset(20, 20)
	openButton.Position = UDim2.fromOffset(0, 53)
	openButton.Rotation = 0
	openButton.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
	openButton.BackgroundTransparency = 0.5
	openButton.BorderSizePixel = 0
	openButton.Visible = true
	openButton.Active = true
	openButton.ZIndex = 1
	openButton.LayoutOrder = 0
	openButton.AutoButtonColor = true
	openButton.Image = Icon.OpenLeft
	openButton.ImageTransparency = 0
	openButton.ScaleType = Enum.ScaleType.Stretch
	openButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	openButton.Parent = screenGui

	local panel = Instance.new("Frame")

	panel.Name = generateName()
	panel.AnchorPoint = Vector2.new(0.0, 0.0)
	panel.Size = UDim2.new(0, 270, 1, -78)
	panel.Position = UDim2.fromOffset(0, 78)
	panel.Rotation = 0
	panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	panel.BackgroundTransparency = 0
	panel.BorderSizePixel = 0
	panel.ClipsDescendants = true
	panel.Visible = true
	panel.Active = true
	panel.ZIndex = 1
	panel.LayoutOrder = 0
	panel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	panel.Parent = screenGui

	local panelShadow: Instance? = nil

	do
		local created, shadow = pcall(function()
			return Instance.new("UIShadow")
		end)

		if created and typeof(shadow) == "Instance" then
			local shadowProperties = shadow :: any

			pcall(function() shadowProperties.Name = "UIShadow" end)
			pcall(function() shadowProperties.ZIndex = -1 end)
			pcall(function() shadowProperties.BlurRadius = UDim.new(0, 12) end)
			pcall(function() shadowProperties.Color = Color3.fromRGB(0, 0, 0) end)
			pcall(function() shadowProperties.Enabled = true end)
			pcall(function() shadowProperties.Offset = UDim2.fromOffset(0, 4) end)
			pcall(function() shadowProperties.Spread = UDim2.fromScale(0, 0) end)
			pcall(function() shadowProperties.Transparency = 0.5 end)

			local parented = pcall(function()
				shadow.Parent = panel
			end)

			if parented then
				panelShadow = shadow
			else
				shadow:Destroy()
			end
		end
	end

	local resizeButton = Instance.new("ImageButton")

	resizeButton.Name = generateName()
	resizeButton.AnchorPoint = Vector2.new(0.0, 0.0)
	resizeButton.Size = UDim2.new(0, 5, 1, 0)
	resizeButton.Position = UDim2.fromOffset(265, 0)
	resizeButton.Rotation = 0
	resizeButton.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	resizeButton.BackgroundTransparency = 0
	resizeButton.BorderSizePixel = 0
	resizeButton.Visible = true
	resizeButton.Active = true
	resizeButton.ZIndex = 1
	resizeButton.LayoutOrder = 0
	resizeButton.AutoButtonColor = true
	resizeButton.Image = Icon.Empty
	resizeButton.ImageTransparency = 0
	resizeButton.ScaleType = Enum.ScaleType.Stretch
	resizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	resizeButton.Parent = panel

	local resizeLine = Instance.new("Frame")

	resizeLine.Name = generateName()
	resizeLine.AnchorPoint = Vector2.new(0.0, 0.0)
	resizeLine.Size = UDim2.fromOffset(1, 345)
	resizeLine.Position = UDim2.fromScale(0, 0)
	resizeLine.Rotation = 0
	resizeLine.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	resizeLine.BackgroundTransparency = 0
	resizeLine.BorderSizePixel = 0
	resizeLine.ClipsDescendants = true
	resizeLine.Visible = true
	resizeLine.Active = true
	resizeLine.ZIndex = 1
	resizeLine.LayoutOrder = 0
	resizeLine.BorderColor3 = Color3.fromRGB(0, 0, 0)

	resizeLine.Parent = resizeButton

	local header = Instance.new("Frame")

	header.Name = generateName()
	header.AnchorPoint = Vector2.new(0.0, 0.0)
	header.Size = UDim2.fromOffset(265, 24)
	header.Position = UDim2.fromScale(0, 0)
	header.Rotation = 0
	header.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	header.BackgroundTransparency = 0
	header.BorderSizePixel = 0
	header.ClipsDescendants = false
	header.Visible = true
	header.Active = true
	header.ZIndex = 1
	header.LayoutOrder = 0
	header.BorderColor3 = Color3.fromRGB(0, 0, 0)

	header.Parent = panel

	local titleLabel = Instance.new("TextLabel")

	titleLabel.Name = generateName()
	local TITLE_TEXT = "Store Asset"
	local TITLE_X = 28
	local titleWidth = 62

	do
		local measured, bounds = pcall(function()
			return TextService:GetTextSize(TITLE_TEXT, 12, Enum.Font.GothamMedium, Vector2.new(1000, 24))
		end)

		if measured and typeof(bounds) == "Vector2" then
			titleWidth = math.ceil(bounds.X) + 2
		end
	end

	titleLabel.AnchorPoint = Vector2.new(0.0, 0.0)
	titleLabel.Size = UDim2.fromOffset(titleWidth, 24)
	titleLabel.Position = UDim2.fromOffset(TITLE_X, 0)
	titleLabel.Rotation = 0
	titleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	titleLabel.BackgroundTransparency = 1
	titleLabel.BorderSizePixel = 0
	titleLabel.Visible = true
	titleLabel.Active = false
	titleLabel.ZIndex = 1
	titleLabel.LayoutOrder = 0
	titleLabel.Text = "Store Asset"
	titleLabel.TextColor3 = Color3.fromRGB(209, 213, 219)
	titleLabel.TextSize = 12
	titleLabel.TextScaled = false
	titleLabel.TextWrapped = false
	titleLabel.TextTransparency = 0
	titleLabel.Font = Enum.Font.GothamMedium
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left
	titleLabel.TextYAlignment = Enum.TextYAlignment.Center
	titleLabel.RichText = false
	titleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	titleLabel.Parent = header

	local headerLogo = Instance.new("ImageLabel")

	headerLogo.Name = generateName()
	headerLogo.AnchorPoint = Vector2.new(0.0, 0.5)
	headerLogo.Size = UDim2.fromOffset(14, 14)
	headerLogo.Position = UDim2.new(0, 10, 0.5, 0)
	headerLogo.Rotation = 0
	headerLogo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	headerLogo.BackgroundTransparency = 1
	headerLogo.BorderSizePixel = 0
	headerLogo.Visible = true
	headerLogo.Active = false
	headerLogo.ZIndex = 1
	headerLogo.LayoutOrder = 0
	headerLogo.Image = Icon.Logo
	headerLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
	headerLogo.ImageTransparency = 0
	headerLogo.ScaleType = Enum.ScaleType.Fit
	headerLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)

	headerLogo.Parent = header

	local headerDivider = Instance.new("Frame")

	headerDivider.Name = generateName()
	headerDivider.AnchorPoint = Vector2.new(0.0, 0.5)
	headerDivider.Size = UDim2.fromOffset(1, 12)
	headerDivider.Position = UDim2.new(0, TITLE_X + titleWidth + 4, 0.5, 0)
	headerDivider.Rotation = 0
	headerDivider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	headerDivider.BackgroundTransparency = 0.7
	headerDivider.BorderSizePixel = 0
	headerDivider.ClipsDescendants = false
	headerDivider.Visible = true
	headerDivider.Active = false
	headerDivider.ZIndex = 1
	headerDivider.LayoutOrder = 0
	headerDivider.BorderColor3 = Color3.fromRGB(0, 0, 0)

	headerDivider.Parent = header

	local headerBrand = Instance.new("TextLabel")

	headerBrand.Name = generateName()
	headerBrand.AnchorPoint = Vector2.new(0.0, 0.0)
	headerBrand.Size = UDim2.fromOffset(70, 24)
	headerBrand.Position = UDim2.fromOffset(TITLE_X + titleWidth + 10, 0)
	headerBrand.Rotation = 0
	headerBrand.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	headerBrand.BackgroundTransparency = 1
	headerBrand.BorderSizePixel = 0
	headerBrand.Visible = true
	headerBrand.Active = false
	headerBrand.ZIndex = 1
	headerBrand.LayoutOrder = 0
	headerBrand.Text = "NarsEdv"
	headerBrand.TextColor3 = Color3.fromRGB(255, 255, 255)
	headerBrand.TextSize = 12
	headerBrand.TextScaled = false
	headerBrand.TextWrapped = false
	headerBrand.TextTransparency = 0.5
	headerBrand.Font = Enum.Font.GothamMedium
	headerBrand.TextXAlignment = Enum.TextXAlignment.Left
	headerBrand.TextYAlignment = Enum.TextYAlignment.Center
	headerBrand.RichText = false
	headerBrand.BorderColor3 = Color3.fromRGB(0, 0, 0)

	headerBrand.Parent = header

	local closeButton = Instance.new("ImageButton")

	closeButton.Name = generateName()
	closeButton.AnchorPoint = Vector2.new(0.0, 0.0)
	closeButton.Size = UDim2.fromOffset(12, 12)
	closeButton.Position = UDim2.fromOffset(250, 6)
	closeButton.Rotation = 0
	closeButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	closeButton.BackgroundTransparency = 0
	closeButton.BorderSizePixel = 0
	closeButton.Visible = true
	closeButton.Active = true
	closeButton.ZIndex = 1
	closeButton.LayoutOrder = 0
	closeButton.AutoButtonColor = true
	closeButton.Image = Icon.Close
	closeButton.ImageTransparency = 0
	closeButton.ScaleType = Enum.ScaleType.Stretch
	closeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	closeButton.Parent = header

	local minimizeButton = Instance.new("ImageButton")

	minimizeButton.Name = generateName()
	minimizeButton.AnchorPoint = Vector2.new(0.0, 0.0)
	minimizeButton.Size = UDim2.fromOffset(12, 12)
	minimizeButton.Position = UDim2.fromOffset(235, 6)
	minimizeButton.Rotation = 0
	minimizeButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	minimizeButton.BackgroundTransparency = 0
	minimizeButton.BorderSizePixel = 0
	minimizeButton.Visible = false
	minimizeButton.Active = true
	minimizeButton.ZIndex = 1
	minimizeButton.LayoutOrder = 0
	minimizeButton.AutoButtonColor = true
	minimizeButton.Image = Icon.Empty
	minimizeButton.ImageTransparency = 0
	minimizeButton.ScaleType = Enum.ScaleType.Stretch
	minimizeButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	minimizeButton.Parent = header

	local dockButton = Instance.new("ImageButton")

	dockButton.Name = generateName()
	dockButton.AnchorPoint = Vector2.new(0.0, 0.0)
	dockButton.Size = UDim2.fromOffset(12, 12)
	dockButton.Position = UDim2.fromOffset(235, 6)
	dockButton.Rotation = 0
	dockButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	dockButton.BackgroundTransparency = 0
	dockButton.BorderSizePixel = 0
	dockButton.Visible = true
	dockButton.Active = true
	dockButton.ZIndex = 1
	dockButton.LayoutOrder = 0
	dockButton.AutoButtonColor = true
	dockButton.Image = Icon.Dock
	dockButton.ImageTransparency = 0
	dockButton.ScaleType = Enum.ScaleType.Stretch
	dockButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	dockButton.Parent = header

	local storeFrame = Instance.new("Frame")

	storeFrame.Name = generateName()
	storeFrame.AnchorPoint = Vector2.new(0.0, 0.0)
	storeFrame.Size = UDim2.new(0, 265, 1, -24)
	storeFrame.Position = UDim2.fromOffset(0, 24)
	storeFrame.Rotation = 0
	storeFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	storeFrame.BackgroundTransparency = 1
	storeFrame.BorderSizePixel = 0
	storeFrame.ClipsDescendants = true
	storeFrame.Visible = true
	storeFrame.Active = false
	storeFrame.ZIndex = 1
	storeFrame.LayoutOrder = 0
	storeFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)

	storeFrame.Parent = panel

	local toolbar = Instance.new("Frame")

	toolbar.Name = generateName()
	toolbar.AnchorPoint = Vector2.new(0.0, 0.0)
	toolbar.Size = UDim2.fromOffset(265, 40)
	toolbar.Position = UDim2.fromScale(0, 0)
	toolbar.Rotation = 0
	toolbar.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	toolbar.BackgroundTransparency = 0
	toolbar.BorderSizePixel = 0
	toolbar.ClipsDescendants = false
	toolbar.Visible = true
	toolbar.Active = false
	toolbar.ZIndex = 2
	toolbar.LayoutOrder = 0
	toolbar.BorderColor3 = Color3.fromRGB(0, 0, 0)

	toolbar.Parent = storeFrame

	local searchBox = Instance.new("Frame")

	searchBox.Name = generateName()
	searchBox.AnchorPoint = Vector2.new(0.0, 0.0)
	searchBox.Size = UDim2.fromOffset(115, 22)
	searchBox.Position = UDim2.fromOffset(115, 10)
	searchBox.Rotation = 0
	searchBox.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
	searchBox.BackgroundTransparency = 0
	searchBox.BorderSizePixel = 0
	searchBox.ClipsDescendants = false
	searchBox.Visible = true
	searchBox.Active = true
	searchBox.ZIndex = 1
	searchBox.LayoutOrder = 0
	searchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)

	searchBox.Parent = toolbar

	local searchBoxStroke = Instance.new("UIStroke")

	searchBoxStroke.Name = generateName()
	searchBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	searchBoxStroke.Color = Color3.fromRGB(0, 0, 0)
	searchBoxStroke.Enabled = true
	searchBoxStroke.LineJoinMode = Enum.LineJoinMode.Round
	searchBoxStroke.Thickness = 0.5
	searchBoxStroke.Transparency = 0

	searchBoxStroke.Parent = searchBox

	local searchInput = Instance.new("TextBox")

	searchInput.Name = generateName()
	searchInput.AnchorPoint = Vector2.new(0.0, 0.0)
	searchInput.Size = UDim2.fromOffset(85, 22)
	searchInput.Position = UDim2.fromOffset(5, 0)
	searchInput.Rotation = 0
	searchInput.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	searchInput.BackgroundTransparency = 1
	searchInput.BorderSizePixel = 0
	searchInput.Visible = true
	searchInput.Active = true
	searchInput.ZIndex = 1
	searchInput.LayoutOrder = 0
	searchInput.Text = ""
	searchInput.TextColor3 = Color3.fromRGB(250, 250, 250)
	searchInput.TextSize = 12
	searchInput.TextScaled = false
	searchInput.TextWrapped = false
	searchInput.TextTransparency = 0
	searchInput.Font = Enum.Font.GothamMedium
	searchInput.TextXAlignment = Enum.TextXAlignment.Left
	searchInput.TextYAlignment = Enum.TextYAlignment.Center
	searchInput.RichText = false
	searchInput.PlaceholderText = "Enter search store..."
	searchInput.PlaceholderColor3 = Color3.fromRGB(65, 65, 65)
	searchInput.TextEditable = true
	searchInput.ClearTextOnFocus = false
	searchInput.MultiLine = false
	searchInput.BorderColor3 = Color3.fromRGB(0, 0, 0)

	pcall(function()
		(searchInput :: any).TextTruncate = Enum.TextTruncate.AtEnd
	end)
	searchInput.ClipsDescendants = true

	searchInput.Parent = searchBox

	local searchButton = Instance.new("ImageButton")

	searchButton.Name = generateName()
	searchButton.AnchorPoint = Vector2.new(0.0, 0.0)
	searchButton.Size = UDim2.fromOffset(14, 14)
	searchButton.Position = UDim2.fromOffset(96, 4)
	searchButton.Rotation = 0
	searchButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	searchButton.BackgroundTransparency = 1
	searchButton.BorderSizePixel = 0
	searchButton.Visible = true
	searchButton.Active = true
	searchButton.ZIndex = 1
	searchButton.LayoutOrder = 0
	searchButton.AutoButtonColor = true
	searchButton.Image = Icon.Search
	searchButton.ImageTransparency = 0
	searchButton.ScaleType = Enum.ScaleType.Stretch
	searchButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	searchButton.Parent = searchBox

	local searchBoxCorner = Instance.new("UICorner")

	searchBoxCorner.Name = generateName()
	searchBoxCorner.CornerRadius = UDim.new(0.0, 3)

	searchBoxCorner.Parent = searchBox

	local dropdownButton = Instance.new("TextButton")

	dropdownButton.Name = generateName()
	dropdownButton.AnchorPoint = Vector2.new(0.0, 0.0)
	dropdownButton.Size = UDim2.fromOffset(95, 22)
	dropdownButton.Position = UDim2.fromOffset(10, 10)
	dropdownButton.Rotation = 0
	dropdownButton.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
	dropdownButton.BackgroundTransparency = 0
	dropdownButton.BorderSizePixel = 0
	dropdownButton.Visible = true
	dropdownButton.Active = true
	dropdownButton.ZIndex = 1
	dropdownButton.LayoutOrder = 0
	dropdownButton.Text = ""
	dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	dropdownButton.TextSize = 14
	dropdownButton.TextScaled = false
	dropdownButton.TextWrapped = false
	dropdownButton.TextTransparency = 0
	dropdownButton.Font = Enum.Font.SourceSansBold
	dropdownButton.TextXAlignment = Enum.TextXAlignment.Center
	dropdownButton.TextYAlignment = Enum.TextYAlignment.Center
	dropdownButton.RichText = false
	dropdownButton.AutoButtonColor = true
	dropdownButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	dropdownButton.Parent = toolbar

	local dropdownArrow = Instance.new("ImageLabel")

	dropdownArrow.Name = generateName()
	dropdownArrow.AnchorPoint = Vector2.new(0.0, 0.0)
	dropdownArrow.Size = UDim2.fromOffset(12, 12)
	dropdownArrow.Position = UDim2.fromOffset(78, 5)
	dropdownArrow.Rotation = 0
	dropdownArrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdownArrow.BackgroundTransparency = 1
	dropdownArrow.BorderSizePixel = 0
	dropdownArrow.Visible = true
	dropdownArrow.Active = false
	dropdownArrow.ZIndex = 1
	dropdownArrow.LayoutOrder = 0
	dropdownArrow.Image = Icon.Arrow
	dropdownArrow.ImageTransparency = 0
	dropdownArrow.ScaleType = Enum.ScaleType.Stretch
	dropdownArrow.BorderColor3 = Color3.fromRGB(0, 0, 0)

	dropdownArrow.Parent = dropdownButton

	local dropdownStroke = Instance.new("UIStroke")

	dropdownStroke.Name = generateName()
	dropdownStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	dropdownStroke.Color = Color3.fromRGB(0, 0, 0)
	dropdownStroke.Enabled = true
	dropdownStroke.LineJoinMode = Enum.LineJoinMode.Round
	dropdownStroke.Thickness = 0.5
	dropdownStroke.Transparency = 0

	dropdownStroke.Parent = dropdownButton

	local dropdownCorner = Instance.new("UICorner")

	dropdownCorner.Name = generateName()
	dropdownCorner.CornerRadius = UDim.new(0.0, 3)

	dropdownCorner.Parent = dropdownButton

	local dropdownSelectLabel = Instance.new("TextLabel")

	dropdownSelectLabel.Name = generateName()
	dropdownSelectLabel.AnchorPoint = Vector2.new(0.0, 0.0)
	dropdownSelectLabel.Size = UDim2.fromOffset(68, 22)
	dropdownSelectLabel.Position = UDim2.fromOffset(10, 0)
	dropdownSelectLabel.Rotation = 0
	dropdownSelectLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	dropdownSelectLabel.BackgroundTransparency = 1
	dropdownSelectLabel.BorderSizePixel = 0
	dropdownSelectLabel.Visible = true
	dropdownSelectLabel.Active = false
	dropdownSelectLabel.ZIndex = 1
	dropdownSelectLabel.LayoutOrder = 0
	dropdownSelectLabel.Text = "Model"
	dropdownSelectLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
	dropdownSelectLabel.TextSize = 12
	dropdownSelectLabel.TextScaled = false
	dropdownSelectLabel.TextWrapped = false
	dropdownSelectLabel.TextTransparency = 0
	dropdownSelectLabel.Font = Enum.Font.GothamMedium
	dropdownSelectLabel.TextXAlignment = Enum.TextXAlignment.Left
	dropdownSelectLabel.TextYAlignment = Enum.TextYAlignment.Center
	dropdownSelectLabel.RichText = false
	dropdownSelectLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	dropdownSelectLabel.Parent = dropdownButton

	local savedButton = Instance.new("ImageButton")

	savedButton.Name = generateName()
	savedButton.AnchorPoint = Vector2.new(0.0, 0.0)
	savedButton.Size = UDim2.fromOffset(16, 16)
	savedButton.Position = UDim2.fromOffset(240, 13)
	savedButton.Rotation = 0
	savedButton.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
	savedButton.BackgroundTransparency = 0
	savedButton.BorderSizePixel = 0
	savedButton.Visible = true
	savedButton.Active = true
	savedButton.ZIndex = 1
	savedButton.LayoutOrder = 0
	savedButton.AutoButtonColor = true
	savedButton.Image = Icon.Save
	savedButton.ImageTransparency = 0
	savedButton.ScaleType = Enum.ScaleType.Stretch
	savedButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	savedButton.Parent = toolbar

	local categoryFrame = Instance.new("Frame")

	categoryFrame.Name = generateName()
	categoryFrame.AnchorPoint = Vector2.new(0.0, 0.0)
	categoryFrame.Size = UDim2.fromOffset(95, 175)
	categoryFrame.Position = UDim2.fromOffset(10, 35)
	categoryFrame.Rotation = 0
	categoryFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	categoryFrame.BackgroundTransparency = 0
	categoryFrame.BorderSizePixel = 0
	categoryFrame.ClipsDescendants = false
	categoryFrame.Visible = false
	categoryFrame.Active = true
	categoryFrame.ZIndex = 1
	categoryFrame.LayoutOrder = 0
	categoryFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)

	categoryFrame.Parent = toolbar

	local categoryCorner = Instance.new("UICorner")

	categoryCorner.Name = generateName()
	categoryCorner.CornerRadius = UDim.new(0.0, 3)

	categoryCorner.Parent = categoryFrame

	local categoryScroll = Instance.new("ScrollingFrame")

	categoryScroll.Name = generateName()
	categoryScroll.AnchorPoint = Vector2.new(0.0, 0.0)
	categoryScroll.Size = UDim2.fromOffset(95, 165)
	categoryScroll.Position = UDim2.fromOffset(0, 5)
	categoryScroll.Rotation = 0
	categoryScroll.CanvasSize = UDim2.fromScale(0, 2)
	categoryScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	categoryScroll.ScrollBarThickness = 0
	categoryScroll.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	categoryScroll.BackgroundTransparency = 1
	categoryScroll.BorderSizePixel = 0
	categoryScroll.ClipsDescendants = true
	categoryScroll.Visible = true
	categoryScroll.Active = true
	categoryScroll.ZIndex = 1
	categoryScroll.LayoutOrder = 0
	categoryScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)

	categoryScroll.Parent = categoryFrame

	local categoryPadding = Instance.new("UIPadding")

	categoryPadding.Name = generateName()
	categoryPadding.PaddingBottom = UDim.new(0.0, 0)
	categoryPadding.PaddingLeft = UDim.new(0.0, 5)
	categoryPadding.PaddingRight = UDim.new(0.0, 0)
	categoryPadding.PaddingTop = UDim.new(0.0, 0)

	categoryPadding.Parent = categoryScroll

	local categoryListLayout = Instance.new("UIListLayout")

	categoryListLayout.Name = generateName()
	categoryListLayout.FillDirection = Enum.FillDirection.Vertical
	categoryListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	categoryListLayout.Padding = UDim.new(0.0, 0)
	categoryListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	categoryListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	categoryListLayout.Parent = categoryScroll

	local categoryOption = Instance.new("TextButton")

	categoryOption.Name = generateName()
	categoryOption.AnchorPoint = Vector2.new(0.0, 0.0)
	categoryOption.Size = UDim2.fromOffset(85, 24)
	categoryOption.Position = UDim2.fromOffset(5, 0)
	categoryOption.Rotation = 0
	categoryOption.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	categoryOption.BackgroundTransparency = 0
	categoryOption.BorderSizePixel = 0
	categoryOption.Visible = true
	categoryOption.Active = true
	categoryOption.ZIndex = 1
	categoryOption.LayoutOrder = 0
	categoryOption.Text = ""
	categoryOption.TextColor3 = Color3.fromRGB(255, 255, 255)
	categoryOption.TextSize = 12
	categoryOption.TextScaled = false
	categoryOption.TextWrapped = false
	categoryOption.TextTransparency = 0
	categoryOption.Font = Enum.Font.GothamMedium
	categoryOption.TextXAlignment = Enum.TextXAlignment.Left
	categoryOption.TextYAlignment = Enum.TextYAlignment.Center
	categoryOption.RichText = false
	categoryOption.AutoButtonColor = true
	categoryOption.BorderColor3 = Color3.fromRGB(0, 0, 0)

	categoryOption.Parent = categoryScroll

	local categoryOptionCorner = Instance.new("UICorner")

	categoryOptionCorner.Name = generateName()
	categoryOptionCorner.CornerRadius = UDim.new(0.0, 3)

	categoryOptionCorner.Parent = categoryOption

	local categoryOptionCheck = Instance.new("ImageLabel")

	categoryOptionCheck.Name = generateName()
	categoryOptionCheck.AnchorPoint = Vector2.new(0.0, 0.0)
	categoryOptionCheck.Size = UDim2.fromOffset(12, 12)
	categoryOptionCheck.Position = UDim2.fromOffset(67, 6)
	categoryOptionCheck.Rotation = 0
	categoryOptionCheck.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	categoryOptionCheck.BackgroundTransparency = 1
	categoryOptionCheck.BorderSizePixel = 0
	categoryOptionCheck.Visible = false
	categoryOptionCheck.Active = false
	categoryOptionCheck.ZIndex = 1
	categoryOptionCheck.LayoutOrder = 0
	categoryOptionCheck.Image = Icon.Check
	categoryOptionCheck.ImageTransparency = 0
	categoryOptionCheck.ScaleType = Enum.ScaleType.Stretch
	categoryOptionCheck.BorderColor3 = Color3.fromRGB(0, 0, 0)

	categoryOptionCheck.Parent = categoryOption

	local categoryOptionItem = Instance.new("TextLabel")

	categoryOptionItem.Name = generateName()
	categoryOptionItem.AnchorPoint = Vector2.new(0.0, 0.0)
	categoryOptionItem.Size = UDim2.fromOffset(65, 24)
	categoryOptionItem.Position = UDim2.fromOffset(5, 0)
	categoryOptionItem.Rotation = 0
	categoryOptionItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	categoryOptionItem.BackgroundTransparency = 1
	categoryOptionItem.BorderSizePixel = 0
	categoryOptionItem.Visible = true
	categoryOptionItem.Active = false
	categoryOptionItem.ZIndex = 1
	categoryOptionItem.LayoutOrder = 0
	categoryOptionItem.Text = "Model"
	categoryOptionItem.TextColor3 = Color3.fromRGB(255, 255, 255)
	categoryOptionItem.TextSize = 12
	categoryOptionItem.TextScaled = false
	categoryOptionItem.TextWrapped = false
	categoryOptionItem.TextTransparency = 0
	categoryOptionItem.Font = Enum.Font.GothamMedium
	categoryOptionItem.TextXAlignment = Enum.TextXAlignment.Left
	categoryOptionItem.TextYAlignment = Enum.TextYAlignment.Center
	categoryOptionItem.RichText = false
	categoryOptionItem.BorderColor3 = Color3.fromRGB(0, 0, 0)

	categoryOptionItem.Parent = categoryOption

	local suggestionsDropdown = Instance.new("Frame")

	suggestionsDropdown.Name = generateName()
	suggestionsDropdown.AnchorPoint = Vector2.new(0.0, 0.0)
	suggestionsDropdown.Size = UDim2.fromOffset(115, 6)
	suggestionsDropdown.Position = UDim2.fromOffset(115, 35)
	suggestionsDropdown.Rotation = 0
	suggestionsDropdown.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	suggestionsDropdown.BackgroundTransparency = 0
	suggestionsDropdown.BorderSizePixel = 0
	suggestionsDropdown.ClipsDescendants = true
	suggestionsDropdown.Visible = false
	suggestionsDropdown.Active = true
	suggestionsDropdown.ZIndex = 1
	suggestionsDropdown.LayoutOrder = 0
	suggestionsDropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)

	suggestionsDropdown.Parent = toolbar

	local suggestionsCorner = Instance.new("UICorner")

	suggestionsCorner.Name = generateName()
	suggestionsCorner.CornerRadius = UDim.new(0.0, 3)

	suggestionsCorner.Parent = suggestionsDropdown

	local suggestionsPadding = Instance.new("UIPadding")

	suggestionsPadding.Name = generateName()
	suggestionsPadding.PaddingBottom = UDim.new(0.0, 3)
	suggestionsPadding.PaddingLeft = UDim.new(0.0, 3)
	suggestionsPadding.PaddingRight = UDim.new(0.0, 3)
	suggestionsPadding.PaddingTop = UDim.new(0.0, 3)

	suggestionsPadding.Parent = suggestionsDropdown

	local suggestionsListLayout = Instance.new("UIListLayout")

	suggestionsListLayout.Name = generateName()
	suggestionsListLayout.FillDirection = Enum.FillDirection.Vertical
	suggestionsListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	suggestionsListLayout.Padding = UDim.new(0.0, 0)
	suggestionsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	suggestionsListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

	suggestionsListLayout.Parent = suggestionsDropdown

	local suggestionItem = Instance.new("TextButton")

	suggestionItem.Name = generateName()
	suggestionItem.AnchorPoint = Vector2.new(0.0, 0.0)
	suggestionItem.Size = UDim2.new(1, 0, 0, 22)
	suggestionItem.Position = UDim2.fromOffset(0, 0)
	suggestionItem.Rotation = 0
	suggestionItem.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	suggestionItem.BackgroundTransparency = 0
	suggestionItem.BorderSizePixel = 0
	suggestionItem.Visible = false
	suggestionItem.Active = true
	suggestionItem.ZIndex = 1
	suggestionItem.LayoutOrder = 0
	suggestionItem.Text = ""
	suggestionItem.TextColor3 = Color3.fromRGB(255, 255, 255)
	suggestionItem.TextSize = 12
	suggestionItem.TextScaled = false
	suggestionItem.TextWrapped = false
	suggestionItem.TextTransparency = 0
	suggestionItem.Font = Enum.Font.GothamMedium
	suggestionItem.TextXAlignment = Enum.TextXAlignment.Left
	suggestionItem.TextYAlignment = Enum.TextYAlignment.Center
	suggestionItem.RichText = false
	suggestionItem.AutoButtonColor = true
	suggestionItem.BorderColor3 = Color3.fromRGB(0, 0, 0)

	suggestionItem.Parent = suggestionsDropdown

	local suggestionItemCorner = Instance.new("UICorner")

	suggestionItemCorner.Name = generateName()
	suggestionItemCorner.CornerRadius = UDim.new(0.0, 3)

	suggestionItemCorner.Parent = suggestionItem

	local suggestionText = Instance.new("TextLabel")

	suggestionText.Name = generateName()
	suggestionText.AnchorPoint = Vector2.new(0.0, 0.0)
	suggestionText.Size = UDim2.new(1, -10, 1, 0)
	suggestionText.Position = UDim2.fromOffset(5, 0)
	suggestionText.Rotation = 0
	suggestionText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	suggestionText.BackgroundTransparency = 1
	suggestionText.BorderSizePixel = 0
	suggestionText.Visible = true
	suggestionText.Active = false
	suggestionText.ZIndex = 1
	suggestionText.LayoutOrder = 0
	suggestionText.Text = "Suggestion"
	suggestionText.TextColor3 = Color3.fromRGB(160, 160, 160)
	suggestionText.TextSize = 12
	suggestionText.TextScaled = false
	suggestionText.TextWrapped = false
	suggestionText.TextTransparency = 0
	suggestionText.Font = Enum.Font.GothamMedium
	suggestionText.TextXAlignment = Enum.TextXAlignment.Left
	suggestionText.TextYAlignment = Enum.TextYAlignment.Center
	suggestionText.RichText = false
	suggestionText.BorderColor3 = Color3.fromRGB(0, 0, 0)

	suggestionText.Parent = suggestionItem

	local assetScroll = Instance.new("ScrollingFrame")

	assetScroll.Name = generateName()
	assetScroll.AnchorPoint = Vector2.new(0.0, 0.0)
	assetScroll.Size = UDim2.new(0, 265, 1, -60)
	assetScroll.Position = UDim2.fromOffset(0, 60)
	assetScroll.Rotation = 0
	assetScroll.CanvasSize = UDim2.fromScale(0, 2)
	assetScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	assetScroll.ScrollBarThickness = 0
	assetScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	assetScroll.BackgroundTransparency = 1
	assetScroll.BorderSizePixel = 0
	assetScroll.ClipsDescendants = true
	assetScroll.Visible = true
	assetScroll.Active = false
	assetScroll.ZIndex = 1
	assetScroll.LayoutOrder = 0
	assetScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)

	assetScroll.Parent = storeFrame

	local assetScrollPadding = Instance.new("UIPadding")

	assetScrollPadding.Name = generateName()
	assetScrollPadding.PaddingBottom = UDim.new(0.0, 0)
	assetScrollPadding.PaddingLeft = UDim.new(0.0, 5)
	assetScrollPadding.PaddingRight = UDim.new(0.0, 0)
	assetScrollPadding.PaddingTop = UDim.new(0.0, 0)

	assetScrollPadding.Parent = assetScroll

	local assetGridLayout = Instance.new("UIGridLayout")

	assetGridLayout.Name = generateName()
	assetGridLayout.CellPadding = UDim2.fromOffset(5, 5)
	assetGridLayout.CellSize = UDim2.fromOffset(82, 105)
	assetGridLayout.FillDirection = Enum.FillDirection.Horizontal
	assetGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

	assetGridLayout.Parent = assetScroll

	local cardTemplate = Instance.new("Frame")

	cardTemplate.Name = generateName()
	cardTemplate.AnchorPoint = Vector2.new(0.0, 0.0)
	cardTemplate.Size = UDim2.fromOffset(82, 105)
	cardTemplate.Position = UDim2.fromOffset(5, 5)
	cardTemplate.Rotation = 0
	cardTemplate.BackgroundColor3 = Color3.fromRGB(57, 57, 57)
	cardTemplate.BackgroundTransparency = 1
	cardTemplate.BorderSizePixel = 0
	cardTemplate.ClipsDescendants = false
	cardTemplate.Visible = false
	cardTemplate.Active = true
	cardTemplate.ZIndex = 1
	cardTemplate.LayoutOrder = 0
	cardTemplate.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardTemplate.Parent = assetScroll

	local cardMoreMenu = Instance.new("Frame")

	cardMoreMenu.Name = generateName()
	cardMoreMenu.AnchorPoint = Vector2.new(0.5, 0.5)
	cardMoreMenu.Size = UDim2.fromOffset(80, 82)
	cardMoreMenu.Position = UDim2.new(0.5, 0, 0.5, 18)
	cardMoreMenu.Rotation = 0
	cardMoreMenu.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	cardMoreMenu.BackgroundTransparency = 0
	cardMoreMenu.BorderSizePixel = 0
	cardMoreMenu.ClipsDescendants = false
	cardMoreMenu.Visible = false
	cardMoreMenu.Active = true
	cardMoreMenu.ZIndex = 5
	cardMoreMenu.LayoutOrder = 0
	cardMoreMenu.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardMoreMenu.Parent = cardTemplate

	local cardMoreCorner = Instance.new("UICorner")

	cardMoreCorner.Name = generateName()
	cardMoreCorner.CornerRadius = UDim.new(0.0, 5)

	cardMoreCorner.Parent = cardMoreMenu

	local copyIdButton = Instance.new("TextButton")

	copyIdButton.Name = generateName()
	copyIdButton.AnchorPoint = Vector2.new(0.0, 0.0)
	copyIdButton.Size = UDim2.fromOffset(70, 24)
	copyIdButton.Position = UDim2.fromOffset(5, 5)
	copyIdButton.Rotation = 0
	copyIdButton.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	copyIdButton.BackgroundTransparency = 0
	copyIdButton.BorderSizePixel = 0
	copyIdButton.Visible = true
	copyIdButton.Active = true
	copyIdButton.ZIndex = 1
	copyIdButton.LayoutOrder = 0
	copyIdButton.Text = "  Copy ID"
	copyIdButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	copyIdButton.TextSize = 12
	copyIdButton.TextScaled = false
	copyIdButton.TextWrapped = true
	copyIdButton.TextTransparency = 0
	copyIdButton.Font = Enum.Font.GothamMedium
	copyIdButton.TextXAlignment = Enum.TextXAlignment.Left
	copyIdButton.TextYAlignment = Enum.TextYAlignment.Center
	copyIdButton.RichText = false
	copyIdButton.AutoButtonColor = true
	copyIdButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	copyIdButton.Parent = cardMoreMenu

	local copyIdCorner = Instance.new("UICorner")

	copyIdCorner.Name = generateName()
	copyIdCorner.CornerRadius = UDim.new(0.0, 5)

	copyIdCorner.Parent = copyIdButton

	local copyLinkButton = Instance.new("TextButton")

	copyLinkButton.Name = generateName()
	copyLinkButton.AnchorPoint = Vector2.new(0.0, 0.0)
	copyLinkButton.Size = UDim2.fromOffset(70, 24)
	copyLinkButton.Position = UDim2.fromOffset(5, 29)
	copyLinkButton.Rotation = 0
	copyLinkButton.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	copyLinkButton.BackgroundTransparency = 0
	copyLinkButton.BorderSizePixel = 0
	copyLinkButton.Visible = true
	copyLinkButton.Active = true
	copyLinkButton.ZIndex = 1
	copyLinkButton.LayoutOrder = 0
	copyLinkButton.Text = "  Copy Link"
	copyLinkButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	copyLinkButton.TextSize = 12
	copyLinkButton.TextScaled = false
	copyLinkButton.TextWrapped = true
	copyLinkButton.TextTransparency = 0
	copyLinkButton.Font = Enum.Font.GothamMedium
	copyLinkButton.TextXAlignment = Enum.TextXAlignment.Left
	copyLinkButton.TextYAlignment = Enum.TextYAlignment.Center
	copyLinkButton.RichText = false
	copyLinkButton.AutoButtonColor = true
	copyLinkButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	copyLinkButton.Parent = cardMoreMenu

	local copyLinkCorner = Instance.new("UICorner")

	copyLinkCorner.Name = generateName()
	copyLinkCorner.CornerRadius = UDim.new(0.0, 5)

	copyLinkCorner.Parent = copyLinkButton

	local saveAssetButton = Instance.new("TextButton")

	saveAssetButton.Name = generateName()
	saveAssetButton.AnchorPoint = Vector2.new(0.0, 0.0)
	saveAssetButton.Size = UDim2.fromOffset(70, 24)
	saveAssetButton.Position = UDim2.fromOffset(5, 53)
	saveAssetButton.Rotation = 0
	saveAssetButton.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	saveAssetButton.BackgroundTransparency = 0
	saveAssetButton.BorderSizePixel = 0
	saveAssetButton.Visible = true
	saveAssetButton.Active = true
	saveAssetButton.ZIndex = 1
	saveAssetButton.LayoutOrder = 0
	saveAssetButton.Text = "  Save Asset"
	saveAssetButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	saveAssetButton.TextSize = 12
	saveAssetButton.TextScaled = false
	saveAssetButton.TextWrapped = false
	saveAssetButton.TextTransparency = 0
	saveAssetButton.Font = Enum.Font.GothamMedium
	saveAssetButton.TextXAlignment = Enum.TextXAlignment.Left
	saveAssetButton.TextYAlignment = Enum.TextYAlignment.Center
	saveAssetButton.RichText = false
	saveAssetButton.AutoButtonColor = true
	saveAssetButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	saveAssetButton.Parent = cardMoreMenu

	local saveAssetCorner = Instance.new("UICorner")

	saveAssetCorner.Name = generateName()
	saveAssetCorner.CornerRadius = UDim.new(0.0, 5)

	saveAssetCorner.Parent = saveAssetButton

	local cardThumbnail = Instance.new("ImageLabel")

	cardThumbnail.Name = generateName()
	cardThumbnail.AnchorPoint = Vector2.new(0.0, 0.0)
	cardThumbnail.Size = UDim2.fromOffset(75, 75)
	cardThumbnail.Position = UDim2.fromOffset(4, 4)
	cardThumbnail.Rotation = 0
	cardThumbnail.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	cardThumbnail.BackgroundTransparency = 1
	cardThumbnail.BorderSizePixel = 0
	cardThumbnail.Visible = true
	cardThumbnail.Active = false
	cardThumbnail.ZIndex = 2
	cardThumbnail.LayoutOrder = 0
	cardThumbnail.Image = Icon.Empty
	cardThumbnail.ImageTransparency = 0
	cardThumbnail.ScaleType = Enum.ScaleType.Stretch
	cardThumbnail.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardThumbnail.Parent = cardTemplate

	local cardThumbnailCorner = Instance.new("UICorner")

	cardThumbnailCorner.Name = generateName()
	cardThumbnailCorner.CornerRadius = UDim.new(0.0, 5)

	cardThumbnailCorner.Parent = cardThumbnail

	local cardInsertButton = Instance.new("TextButton")

	cardInsertButton.Name = generateName()
	cardInsertButton.AnchorPoint = Vector2.new(0.0, 0.0)
	cardInsertButton.Size = UDim2.fromOffset(75, 75)
	cardInsertButton.Position = UDim2.fromOffset(4, 4)
	cardInsertButton.Rotation = 0
	cardInsertButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	cardInsertButton.BackgroundTransparency = 0
	cardInsertButton.BorderSizePixel = 0
	cardInsertButton.Visible = true
	cardInsertButton.Active = true
	cardInsertButton.ZIndex = 1
	cardInsertButton.LayoutOrder = 0
	cardInsertButton.Text = ""
	cardInsertButton.TextColor3 = Color3.fromRGB(39, 39, 39)
	cardInsertButton.TextSize = 14
	cardInsertButton.TextScaled = false
	cardInsertButton.TextWrapped = false
	cardInsertButton.TextTransparency = 0
	cardInsertButton.Font = Enum.Font.SourceSansBold
	cardInsertButton.TextXAlignment = Enum.TextXAlignment.Center
	cardInsertButton.TextYAlignment = Enum.TextYAlignment.Center
	cardInsertButton.RichText = false
	cardInsertButton.AutoButtonColor = true
	cardInsertButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardInsertButton.Parent = cardTemplate

	local cardInsertCorner = Instance.new("UICorner")

	cardInsertCorner.Name = generateName()
	cardInsertCorner.CornerRadius = UDim.new(0.0, 5)

	cardInsertCorner.Parent = cardInsertButton

	local cardNameLabel = Instance.new("TextLabel")

	cardNameLabel.Name = generateName()
	cardNameLabel.AnchorPoint = Vector2.new(0.0, 1.0)
	cardNameLabel.Size = UDim2.new(1, -7, 0, 12)
	cardNameLabel.Position = UDim2.new(0, 4, 1, -11)
	cardNameLabel.Rotation = 0
	cardNameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	cardNameLabel.BackgroundTransparency = 1
	cardNameLabel.BorderSizePixel = 0
	cardNameLabel.Visible = true
	cardNameLabel.Active = false
	cardNameLabel.ZIndex = 1
	cardNameLabel.LayoutOrder = 0
	cardNameLabel.Text = "Name asset sto.."
	cardNameLabel.TextColor3 = Color3.fromRGB(235, 235, 235)
	cardNameLabel.TextSize = 10
	cardNameLabel.TextScaled = false
	cardNameLabel.TextWrapped = false
	cardNameLabel.TextTransparency = 0
	cardNameLabel.Font = Enum.Font.GothamMedium
	cardNameLabel.TextXAlignment = Enum.TextXAlignment.Left
	cardNameLabel.TextYAlignment = Enum.TextYAlignment.Top
	cardNameLabel.RichText = false
	cardNameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardNameLabel.Parent = cardTemplate

	local cardNameCorner = Instance.new("UICorner")

	cardNameCorner.Name = generateName()
	cardNameCorner.CornerRadius = UDim.new(0.0, 5)

	cardNameCorner.Parent = cardNameLabel

	local cardCreatorLabel = Instance.new("TextLabel")

	cardCreatorLabel.Name = generateName()
	cardCreatorLabel.AnchorPoint = Vector2.new(0.0, 1.0)
	cardCreatorLabel.Size = UDim2.fromOffset(45, 12)
	cardCreatorLabel.Position = UDim2.new(0, 10, 1, -28)
	cardCreatorLabel.Rotation = 0
	cardCreatorLabel.BackgroundColor3 = Color3.fromRGB(60, 46, 46)
	cardCreatorLabel.BackgroundTransparency = 1
	cardCreatorLabel.BorderSizePixel = 0
	cardCreatorLabel.Visible = true
	cardCreatorLabel.Active = false
	cardCreatorLabel.ZIndex = 4
	cardCreatorLabel.LayoutOrder = 0
	cardCreatorLabel.Text = "by Nars Edv.."
	cardCreatorLabel.TextColor3 = Color3.fromRGB(60, 108, 183)
	cardCreatorLabel.TextSize = 8
	cardCreatorLabel.TextScaled = false
	cardCreatorLabel.TextWrapped = false
	cardCreatorLabel.TextTransparency = 0
	cardCreatorLabel.Font = Enum.Font.GothamMedium
	cardCreatorLabel.TextXAlignment = Enum.TextXAlignment.Left
	cardCreatorLabel.TextYAlignment = Enum.TextYAlignment.Center
	cardCreatorLabel.RichText = false
	cardCreatorLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardCreatorLabel.Parent = cardTemplate

	local cardPriceLabel = Instance.new("TextLabel")

	cardPriceLabel.Name = generateName()
	cardPriceLabel.AnchorPoint = Vector2.new(0.0, 1.0)
	cardPriceLabel.Size = UDim2.new(0.5, -6, 0, 12)
	cardPriceLabel.Position = UDim2.new(0, 4, 1, 3)
	cardPriceLabel.Rotation = 0
	cardPriceLabel.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	cardPriceLabel.BackgroundTransparency = 1
	cardPriceLabel.BorderSizePixel = 0
	cardPriceLabel.Visible = true
	cardPriceLabel.Active = false
	cardPriceLabel.ZIndex = 1
	cardPriceLabel.LayoutOrder = 0
	cardPriceLabel.Text = "Free"
	cardPriceLabel.TextColor3 = Color3.fromRGB(157, 157, 157)
	cardPriceLabel.TextSize = 10
	cardPriceLabel.TextScaled = false
	cardPriceLabel.TextWrapped = false
	cardPriceLabel.TextTransparency = 0
	cardPriceLabel.Font = Enum.Font.GothamMedium
	cardPriceLabel.TextXAlignment = Enum.TextXAlignment.Left
	cardPriceLabel.TextYAlignment = Enum.TextYAlignment.Center
	cardPriceLabel.RichText = false
	cardPriceLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardPriceLabel.Parent = cardTemplate

	local cardPriceCorner = Instance.new("UICorner")

	cardPriceCorner.Name = generateName()
	cardPriceCorner.CornerRadius = UDim.new(0.0, 5)

	cardPriceCorner.Parent = cardPriceLabel

	local cardRatingLabel = Instance.new("TextLabel")

	cardRatingLabel.Name = generateName()
	cardRatingLabel.AnchorPoint = Vector2.new(1.0, 1.0)
	cardRatingLabel.Size = UDim2.new(0.5, -2, 0, 12)
	cardRatingLabel.Position = UDim2.new(1, -3, 1, 3)
	cardRatingLabel.Rotation = 0
	cardRatingLabel.BackgroundColor3 = Color3.fromRGB(27, 27, 27)
	cardRatingLabel.BackgroundTransparency = 1
	cardRatingLabel.BorderSizePixel = 0
	cardRatingLabel.Visible = true
	cardRatingLabel.Active = false
	cardRatingLabel.ZIndex = 1
	cardRatingLabel.LayoutOrder = 0
	cardRatingLabel.Text = "99%"
	cardRatingLabel.TextColor3 = Color3.fromRGB(51, 163, 3)
	cardRatingLabel.TextSize = 10
	cardRatingLabel.TextScaled = false
	cardRatingLabel.TextWrapped = false
	cardRatingLabel.TextTransparency = 0
	cardRatingLabel.Font = Enum.Font.GothamMedium
	cardRatingLabel.TextXAlignment = Enum.TextXAlignment.Right
	cardRatingLabel.TextYAlignment = Enum.TextYAlignment.Center
	cardRatingLabel.RichText = false
	cardRatingLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardRatingLabel.Parent = cardTemplate

	local cardRatingCorner = Instance.new("UICorner")

	cardRatingCorner.Name = generateName()
	cardRatingCorner.CornerRadius = UDim.new(0.0, 5)

	cardRatingCorner.Parent = cardRatingLabel

	local cardRatingPadding = Instance.new("UIPadding")

	cardRatingPadding.Name = generateName()
	cardRatingPadding.PaddingBottom = UDim.new(0.0, 0)
	cardRatingPadding.PaddingLeft = UDim.new(0.0, 0)
	cardRatingPadding.PaddingRight = UDim.new(0.0, 2)
	cardRatingPadding.PaddingTop = UDim.new(0.0, 0)

	cardRatingPadding.Parent = cardRatingLabel

	local cardLikeIcon = Instance.new("ImageLabel")

	cardLikeIcon.Name = generateName()
	cardLikeIcon.AnchorPoint = Vector2.new(0.0, 0.5)
	cardLikeIcon.Size = UDim2.fromOffset(12, 12)
	cardLikeIcon.Position = UDim2.new(0, 2, 0.5, 0)
	cardLikeIcon.Rotation = 0
	cardLikeIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	cardLikeIcon.BackgroundTransparency = 1
	cardLikeIcon.BorderSizePixel = 0
	cardLikeIcon.Visible = true
	cardLikeIcon.Active = false
	cardLikeIcon.ZIndex = 1
	cardLikeIcon.LayoutOrder = 0
	cardLikeIcon.Image = Icon.Like
	cardLikeIcon.ImageTransparency = 0
	cardLikeIcon.ScaleType = Enum.ScaleType.Stretch
	cardLikeIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardLikeIcon.Parent = cardRatingLabel

	local cardBookmarkIcon = Instance.new("ImageLabel")

	cardBookmarkIcon.Name = generateName()
	cardBookmarkIcon.AnchorPoint = Vector2.new(1.0, 0.0)
	cardBookmarkIcon.Size = UDim2.fromOffset(14, 14)
	cardBookmarkIcon.Position = UDim2.new(1, -8, 0, 8)
	cardBookmarkIcon.Rotation = 0
	cardBookmarkIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	cardBookmarkIcon.BackgroundTransparency = 1
	cardBookmarkIcon.BorderSizePixel = 0
	cardBookmarkIcon.Visible = false
	cardBookmarkIcon.Active = false
	cardBookmarkIcon.ZIndex = 3
	cardBookmarkIcon.LayoutOrder = 0
	cardBookmarkIcon.Image = Icon.Bookmark
	cardBookmarkIcon.ImageTransparency = 0
	cardBookmarkIcon.ScaleType = Enum.ScaleType.Stretch
	cardBookmarkIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)

	cardBookmarkIcon.Parent = cardTemplate

	local savedScroll = Instance.new("ScrollingFrame")

	savedScroll.Name = generateName()
	savedScroll.AnchorPoint = Vector2.new(0.0, 0.0)
	savedScroll.Size = UDim2.new(0, 265, 1, -60)
	savedScroll.Position = UDim2.fromOffset(0, 60)
	savedScroll.Rotation = 0
	savedScroll.CanvasSize = UDim2.fromScale(0, 2)
	savedScroll.ScrollingDirection = Enum.ScrollingDirection.Y
	savedScroll.ScrollBarThickness = 0
	savedScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	savedScroll.BackgroundTransparency = 1
	savedScroll.BorderSizePixel = 0
	savedScroll.ClipsDescendants = true
	savedScroll.Visible = false
	savedScroll.Active = false
	savedScroll.ZIndex = 1
	savedScroll.LayoutOrder = 0
	savedScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)

	savedScroll.Parent = storeFrame

	local savedScrollPadding = Instance.new("UIPadding")

	savedScrollPadding.Name = generateName()
	savedScrollPadding.PaddingBottom = UDim.new(0.0, 0)
	savedScrollPadding.PaddingLeft = UDim.new(0.0, 5)
	savedScrollPadding.PaddingRight = UDim.new(0.0, 0)
	savedScrollPadding.PaddingTop = UDim.new(0.0, 0)

	savedScrollPadding.Parent = savedScroll

	local savedGridLayout = Instance.new("UIGridLayout")

	savedGridLayout.Name = generateName()
	savedGridLayout.CellPadding = UDim2.fromOffset(5, 5)
	savedGridLayout.CellSize = UDim2.fromOffset(82, 105)
	savedGridLayout.FillDirection = Enum.FillDirection.Horizontal
	savedGridLayout.SortOrder = Enum.SortOrder.LayoutOrder

	savedGridLayout.Parent = savedScroll

	local loadmoreFrame = Instance.new("Frame")

	loadmoreFrame.Name = generateName()
	loadmoreFrame.AnchorPoint = Vector2.new(0.0, 1.0)
	loadmoreFrame.Size = UDim2.fromOffset(265, 35)
	loadmoreFrame.Position = UDim2.fromScale(0, 1)
	loadmoreFrame.Rotation = 0
	loadmoreFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	loadmoreFrame.BackgroundTransparency = 0.3
	loadmoreFrame.BorderSizePixel = 0
	loadmoreFrame.ClipsDescendants = false
	loadmoreFrame.Visible = false
	loadmoreFrame.Active = true
	loadmoreFrame.ZIndex = 1
	loadmoreFrame.LayoutOrder = 0
	loadmoreFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)

	loadmoreFrame.Parent = storeFrame

	local loadmoreButton = Instance.new("TextButton")

	loadmoreButton.Name = generateName()
	loadmoreButton.AnchorPoint = Vector2.new(0.0, 0.0)
	loadmoreButton.Size = UDim2.fromOffset(245, 24)
	loadmoreButton.Position = UDim2.fromOffset(10, 5)
	loadmoreButton.Rotation = 0
	loadmoreButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	loadmoreButton.BackgroundTransparency = 0
	loadmoreButton.BorderSizePixel = 0
	loadmoreButton.Visible = true
	loadmoreButton.Active = true
	loadmoreButton.ZIndex = 5
	loadmoreButton.LayoutOrder = 0
	loadmoreButton.Text = "Loadmore"
	loadmoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	loadmoreButton.TextSize = 12
	loadmoreButton.TextScaled = false
	loadmoreButton.TextWrapped = true
	loadmoreButton.TextTransparency = 0
	loadmoreButton.Font = Enum.Font.GothamMedium
	loadmoreButton.TextXAlignment = Enum.TextXAlignment.Center
	loadmoreButton.TextYAlignment = Enum.TextYAlignment.Center
	loadmoreButton.RichText = false
	loadmoreButton.AutoButtonColor = true
	loadmoreButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

	loadmoreButton.Parent = loadmoreFrame

	local loadmoreCorner = Instance.new("UICorner")

	loadmoreCorner.Name = generateName()
	loadmoreCorner.CornerRadius = UDim.new(0.0, 5)

	loadmoreCorner.Parent = loadmoreButton

	local statusLabel = Instance.new("TextLabel")

	statusLabel.Name = generateName()
	statusLabel.AnchorPoint = Vector2.new(0.5, 0.0)
	statusLabel.Size = UDim2.fromOffset(200, 20)
	statusLabel.Position = UDim2.new(0.5, 0, 0, 40)
	statusLabel.Rotation = 0
	statusLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	statusLabel.BackgroundTransparency = 1
	statusLabel.BorderSizePixel = 0
	statusLabel.Visible = true
	statusLabel.Active = false
	statusLabel.ZIndex = 1
	statusLabel.LayoutOrder = 0
	statusLabel.Text = "< Model / Search Results for Tree • 00 >"
	statusLabel.TextColor3 = Color3.fromRGB(163, 163, 163)
	statusLabel.TextSize = 8
	statusLabel.TextScaled = false
	statusLabel.TextWrapped = false
	statusLabel.TextTransparency = 0
	statusLabel.Font = Enum.Font.GothamMedium
	statusLabel.TextXAlignment = Enum.TextXAlignment.Center
	statusLabel.TextYAlignment = Enum.TextYAlignment.Center
	statusLabel.RichText = false
	statusLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	statusLabel.TextTruncate = Enum.TextTruncate.AtEnd

	statusLabel.Parent = storeFrame

	local dockPreview = Instance.new("Frame")

	dockPreview.Name = generateName()
	dockPreview.AnchorPoint = Vector2.new(0.0, 0.0)
	dockPreview.Size = UDim2.new(0, 35, 1, -78)
	dockPreview.Position = UDim2.fromOffset(0, 78)
	dockPreview.Rotation = 0
	dockPreview.BackgroundColor3 = Color3.fromRGB(70, 126, 213)
	dockPreview.BackgroundTransparency = 0.5
	dockPreview.BorderSizePixel = 0
	dockPreview.ClipsDescendants = false
	dockPreview.Visible = false
	dockPreview.Active = true
	dockPreview.ZIndex = 0
	dockPreview.LayoutOrder = 0
	dockPreview.BorderColor3 = Color3.fromRGB(0, 0, 0)

	dockPreview.Parent = screenGui

	GUI["GUI_ScreenGui"] = screenGui
	GUI["GUI_OpenBtn"] = openButton
	GUI["GUI_Panel"] = panel
	GUI["GUI_ResizeBtn"] = resizeButton
	GUI["GUI_Line"] = resizeLine
	GUI["GUI_Header"] = header
	GUI["GUI_Title"] = titleLabel
	GUI["GUI_Logo"] = headerLogo
	GUI["GUI_Divider"] = headerDivider
	GUI["GUI_Brand"] = headerBrand
	GUI["GUI_UIShadow"] = panelShadow
	GUI["GUI_CloseBtn"] = closeButton
	GUI["GUI_MinBtn"] = minimizeButton
	GUI["GUI_DockBtn"] = dockButton
	GUI["GUI_Store"] = storeFrame
	GUI["GUI_Toolbar"] = toolbar
	GUI["GUI_SearchBox"] = searchBox
	GUI["GUI_UIStroke"] = searchBoxStroke
	GUI["GUI_Input"] = searchInput
	GUI["GUI_SearchBtn"] = searchButton
	GUI["GUI_UICorner"] = searchBoxCorner
	GUI["GUI_Dropdown"] = dropdownButton
	GUI["GUI_Arrow"] = dropdownArrow
	GUI["GUI_UIStroke_1"] = dropdownStroke
	GUI["GUI_UICorner_1"] = dropdownCorner
	GUI["GUI_Select"] = dropdownSelectLabel
	GUI["GUI_SaveBtn"] = savedButton
	GUI["GUI_Category"] = categoryFrame
	GUI["GUI_UICorner_2"] = categoryCorner
	GUI["GUI_ScrollCategory"] = categoryScroll
	GUI["GUI_UIPadding"] = categoryPadding
	GUI["GUI_UIListLayout"] = categoryListLayout
	GUI["GUI_Option"] = categoryOption
	GUI["GUI_UICorner_3"] = categoryOptionCorner
	GUI["GUI_Check"] = categoryOptionCheck
	GUI["GUI_Item"] = categoryOptionItem
	GUI["GUI_Suggestions"] = suggestionsDropdown
	GUI["GUI_SuggestionsCorner"] = suggestionsCorner
	GUI["GUI_SuggestionsPadding"] = suggestionsPadding
	GUI["GUI_SuggestionsList"] = suggestionsListLayout
	GUI["GUI_SuggestionItem"] = suggestionItem
	GUI["GUI_SuggestionItemCorner"] = suggestionItemCorner
	GUI["GUI_SuggestionText"] = suggestionText
	GUI["GUI_ScrollingFrame"] = assetScroll
	GUI["GUI_UIPadding_1"] = assetScrollPadding
	GUI["GUI_UIGridLayout"] = assetGridLayout
	GUI["GUI_Card"] = cardTemplate
	GUI["GUI_More"] = cardMoreMenu
	GUI["GUI_UICorner_4"] = cardMoreCorner
	GUI["GUI_CopyID"] = copyIdButton
	GUI["GUI_UICorner_5"] = copyIdCorner
	GUI["GUI_CopyLink"] = copyLinkButton
	GUI["GUI_UICorner_6"] = copyLinkCorner
	GUI["GUI_SaveAsset"] = saveAssetButton
	GUI["GUI_UICorner_7"] = saveAssetCorner
	GUI["GUI_Thumbnail"] = cardThumbnail
	GUI["GUI_UICorner_8"] = cardThumbnailCorner
	GUI["GUI_InsertBtn"] = cardInsertButton
	GUI["GUI_UICorner_9"] = cardInsertCorner
	GUI["GUI_Name"] = cardNameLabel
	GUI["GUI_UICorner_13"] = cardNameCorner
	GUI["GUI_Creator"] = cardCreatorLabel
	GUI["GUI_Price"] = cardPriceLabel
	GUI["GUI_Rating"] = cardRatingLabel
	GUI["GUI_Like"] = cardLikeIcon
	GUI["GUI_Bookmark"] = cardBookmarkIcon
	GUI["GUI_SavedScrollingFrame"] = savedScroll
	GUI["GUI_SavedUIPadding"] = savedScrollPadding
	GUI["GUI_SavedUIGridLayout"] = savedGridLayout
	GUI["GUI_UICorner_11"] = cardPriceCorner
	GUI["GUI_UICorner_12"] = cardRatingCorner
	GUI["GUI_UIPadding_2"] = cardRatingPadding
	GUI["GUI_Loadmore"] = loadmoreFrame
	GUI["GUI_Button"] = loadmoreButton
	GUI["GUI_UICorner_10"] = loadmoreCorner
	GUI["GUI_Status"] = statusLabel
	GUI["GUI_DockPreview"] = dockPreview
end

local function initializeMainSystem()
	local ScreenGui = GUI["GUI_ScreenGui"] :: ScreenGui
	local OpenBtn = GUI["GUI_OpenBtn"] :: GuiButton
	local Panel = GUI["GUI_Panel"] :: Frame
	local DockPreview = GUI["GUI_DockPreview"] :: Frame
	local ResizeBtn = GUI["GUI_ResizeBtn"] :: GuiButton
	local ResizeLine = GUI["GUI_Line"] :: Frame

	local Header = GUI["GUI_Header"] :: Frame
	local CloseBtn = GUI["GUI_CloseBtn"] :: GuiButton
	local DockBtn = GUI["GUI_DockBtn"] :: GuiButton
	local MinBtn = GUI["GUI_MinBtn"] :: GuiButton

	local StoreFrame = GUI["GUI_Store"] :: Frame

	local widthSizeTargets: {GuiObject} = {
		Header,
		StoreFrame,
		GUI["GUI_Toolbar"],
		GUI["GUI_SearchBox"],
		GUI["GUI_Input"],
		GUI["GUI_ScrollingFrame"],
		GUI["GUI_SavedScrollingFrame"],
		GUI["GUI_Loadmore"],
		GUI["GUI_Button"],
		GUI["GUI_Status"],
	}

	local widthPositionTargets: {GuiObject} = {
		ResizeBtn,
		CloseBtn,
		MinBtn,
		DockBtn,
		GUI["GUI_SearchBtn"],
		GUI["GUI_SaveBtn"],
	}

	local OPEN_RIGHT_ID = Icon.OpenRight
	local OPEN_LEFT_ID = Icon.OpenLeft

	local MIN_IMAGE = Icon.Minimize
	local DROP_IMAGE = Icon.Restore

	local PANEL_OPEN_TIME = 0.75
	local PANEL_HIDE_TIME = 0.65

	local OPEN_TWEEN_INFO = TweenInfo.new(
		PANEL_OPEN_TIME,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.Out
	)

	local HIDE_TWEEN_INFO = TweenInfo.new(
		PANEL_HIDE_TIME,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.InOut
	)

	local TWEEN_TIME = 0.18

	local BASE_WIDTH = 270
	local HEADER_HEIGHT = 24

	local DOCK_POSITION = UDim2.new(0, 0, 0, 78)

	local FLOAT_POSITION = UDim2.new(0, 20, 0, 78)

	local OPEN_POSITION = DOCK_POSITION
	local CLOSED_POSITION = OPEN_POSITION

	local isOpen = true
	local isAnimating = false
	local closing = false
	local activeTween: Tween? = nil

	local docked = true
	local minimized = false
	local dragging = false

	local dragOffset = Vector2.zero
	local dragInput: InputObject? = nil
	local panelTween: Tween? = nil

	local panelWidth = BASE_WIDTH
	local resizing = false
	local resizeInput: InputObject? = nil
	local resizeStartX = 0
	local resizeStartWidth = BASE_WIDTH

	local DOCK_IMAGE = Icon.Dock

	local baseSizes: {[GuiObject]: UDim2} = {}
	local basePositions: {[GuiObject]: UDim2} = {}

	for _, target in ipairs(widthSizeTargets) do
		baseSizes[target] = target.Size
	end

	for _, target in ipairs(widthPositionTargets) do
		basePositions[target] = target.Position
	end

	local resizeIdleColor = ResizeBtn.BackgroundColor3
	local resizeActiveColor = lighten(resizeIdleColor, 0.2)
	local resizeLineIdleColor = ResizeLine.BackgroundColor3
	local resizeLineActiveColor = lighten(resizeLineIdleColor, 0.2)

	local function GetDockSize(): UDim2
		return UDim2.new(0, panelWidth, 1, -78)
	end

	local function GetMinSize(): UDim2
		return UDim2.new(0, panelWidth, 0, HEADER_HEIGHT)
	end

	Panel.Position = DOCK_POSITION
	Panel.Size = GetDockSize()
	Header.Active = true

	local Cover = Instance.new("Frame")

	Cover.Name = generateName()
	Cover.BackgroundColor3 = Color3.new(0, 0, 0)
	Cover.BackgroundTransparency = 1
	Cover.BorderSizePixel = 0
	Cover.Size = UDim2.fromScale(1, 1)
	Cover.ZIndex = 100
	Cover.Active = false
	Cover.Visible = false

	Cover.Parent = Panel

	ScreenGui.Destroying:Connect(DisconnectInputs)

	local function UpdateClosedPosition()
		local currentWidth = Panel.AbsoluteSize.X

		CLOSED_POSITION = UDim2.new(
			OPEN_POSITION.X.Scale,
			OPEN_POSITION.X.Offset - currentWidth,
			OPEN_POSITION.Y.Scale,
			OPEN_POSITION.Y.Offset
		)
	end

	local function UpdateOpenButton()
		OpenBtn.Image = if isOpen then OPEN_LEFT_ID else OPEN_RIGHT_ID
	end

	local function SetButtonImage(button: GuiButton, image: string)
		if button:IsA("ImageButton") then
			button.Image = image
		end
	end

	local function StopPanelTween()
		if panelTween then
			panelTween:Cancel()
			panelTween = nil
		end
	end

	local function TweenPanel(
		position: UDim2,
		size: UDim2,
		onComplete: (() -> ())?
	)
		StopPanelTween()

		local tween = TweenService:Create(
			Panel,
			TweenInfo.new(
				TWEEN_TIME,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Position = position,
				Size = size,
			}
		)

		panelTween = tween

		tween.Completed:Once(function(state)
			if panelTween ~= tween then
				return
			end

			panelTween = nil

			if state == Enum.PlaybackState.Completed and onComplete then
				onComplete()
			end
		end)

		tween:Play()
	end

	local function TogglePanel()
		if isAnimating or closing or not docked or resizing then
			return
		end

		isAnimating = true
		UpdateClosedPosition()

		local targetOpen = not isOpen
		local targetPosition = if targetOpen then OPEN_POSITION else CLOSED_POSITION

		if activeTween then
			activeTween:Cancel()
			activeTween = nil
		end

		OpenBtn.Image = if targetOpen then OPEN_LEFT_ID else OPEN_RIGHT_ID

		Cover.Visible = true
		Cover.Active = true

		if targetOpen then
			Cover.BackgroundTransparency = 0
			playTween(Cover, PANEL_OPEN_TIME * 0.8, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		else
			Cover.BackgroundTransparency = 1
			playTween(Cover, PANEL_HIDE_TIME * 0.7, {BackgroundTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
		end

		local tweenInfo = if targetOpen then OPEN_TWEEN_INFO else HIDE_TWEEN_INFO

		local tween = TweenService:Create(
			Panel,
			tweenInfo,
			{
				Position = targetPosition,
			}
		)

		activeTween = tween
		tween:Play()

		local playbackState = tween.Completed:Wait()

		if ScreenGui.Parent == nil then
			return
		end

		if playbackState == Enum.PlaybackState.Completed then
			isOpen = targetOpen
		end

		activeTween = nil

		if isOpen then
			Cover.Visible = false
			Cover.Active = false
		end

		UpdateOpenButton()
		isAnimating = false
	end

	local function SetContentVisible(visible: boolean)
		StoreFrame.Visible = visible
	end

	local function PointerPosition(input: InputObject): Vector2
		return Vector2.new(input.Position.X, input.Position.Y)
	end

	local function GetRect(gui: GuiObject)
		local position = gui.AbsolutePosition
		local size = gui.AbsoluteSize

		return
			position.X,
			position.Y,
			position.X + size.X,
			position.Y + size.Y
	end

	local function IsTouchingDockPreview(): boolean
		local px1, py1, px2, py2 = GetRect(Panel)
		local dx1, dy1, dx2, dy2 = GetRect(DockPreview)

		return px1 <= dx2
			and px2 >= dx1
			and py1 <= dy2
			and py2 >= dy1
	end

	local function UpdateDockPreview()
		DockPreview.Visible = dragging and IsTouchingDockPreview()
	end

	local function ApplyPanelWidth(width: number)
		panelWidth = width

		local extra = width - BASE_WIDTH

		for target, base in pairs(baseSizes) do
			target.Size = UDim2.new(
				base.X.Scale,
				base.X.Offset + extra,
				base.Y.Scale,
				base.Y.Offset
			)
		end

		for target, base in pairs(basePositions) do
			target.Position = UDim2.new(
				base.X.Scale,
				base.X.Offset + extra,
				base.Y.Scale,
				base.Y.Offset
			)
		end

		Panel.Size = if minimized then GetMinSize() else GetDockSize()
	end

	local function SetResizeHighlight(active: boolean)
		playTween(ResizeBtn, 0.15, {
			BackgroundColor3 = if active then resizeActiveColor else resizeIdleColor,
		})

		playTween(ResizeLine, 0.15, {
			BackgroundColor3 = if active then resizeLineActiveColor else resizeLineIdleColor,
		})
	end

	local function UndockPanel()
		if not docked or dragging then
			return
		end

		StopPanelTween()

		docked = false
		minimized = false
		dragging = false
		dragInput = nil

		OpenBtn.Visible = false
		DockPreview.Visible = false

		DockBtn.Visible = false
		MinBtn.Visible = true

		SetButtonImage(MinBtn, MIN_IMAGE)

		Panel.Position = FLOAT_POSITION
		Panel.Size = GetDockSize()

		SetContentVisible(true)
	end

	local function DockPanel()
		if docked then
			return
		end

		StopPanelTween()

		docked = true
		minimized = false
		dragging = false
		dragInput = nil

		DockPreview.Visible = false

		SetButtonImage(DockBtn, DOCK_IMAGE)
		SetButtonImage(MinBtn, MIN_IMAGE)

		TweenPanel(DOCK_POSITION, GetDockSize(), function()
			SetContentVisible(true)

			DockBtn.Visible = true
			MinBtn.Visible = false
			OpenBtn.Visible = true
		end)
	end

	local function MinimizePanel()
		if docked or minimized then
			return
		end

		StopPanelTween()

		minimized = true

		SetContentVisible(false)
		SetButtonImage(MinBtn, DROP_IMAGE)

		TweenPanel(
			Panel.Position,
			GetMinSize(),
			nil
		)
	end

	local function RestorePanel()
		if docked or not minimized then
			return
		end

		StopPanelTween()

		minimized = false

		SetButtonImage(MinBtn, MIN_IMAGE)

		TweenPanel(
			Panel.Position,
			GetDockSize(),
			function()
				SetContentVisible(true)
			end
		)
	end

	OpenBtn.Activated:Connect(TogglePanel)

	local function ClosePanel()
		if closing then
			return
		end

		closing = true
		isAnimating = true
		dragging = false
		resizing = false
		dragInput = nil
		resizeInput = nil
		DockPreview.Visible = false

		if activeTween then
			activeTween:Cancel()
			activeTween = nil
		end

		StopPanelTween()

		local alreadyHidden = docked and not isOpen

		if OpenBtn.Visible then
			playTween(OpenBtn, 0.25, {BackgroundTransparency = 1, ImageTransparency = 1})
		end

		if alreadyHidden then
			task.wait(0.3)
		else
			Cover.Visible = true
			Cover.Active = true
			playTween(Cover, 0.22, {BackgroundTransparency = 0}, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			task.wait(0.24)

			for _, child in ipairs(Panel:GetChildren()) do
				if child:IsA("GuiObject") and child ~= Cover then
					child.Visible = false
				end
			end

			if docked then
				UpdateClosedPosition()

				TweenService:Create(
					Panel,
					TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
					{Position = CLOSED_POSITION}
				):Play()

				task.wait(0.52)
			else
				Cover.Visible = false

				playTween(Panel, 0.25, {BackgroundTransparency = 1}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
				task.wait(0.27)
			end
		end

		ScreenGui:Destroy()
	end

	CloseBtn.Activated:Connect(ClosePanel)

	Panel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		UpdateClosedPosition()

		if not isOpen and not isAnimating and docked then
			Panel.Position = CLOSED_POSITION
		end
	end)

	DockBtn.Activated:Connect(UndockPanel)

	MinBtn.Activated:Connect(function()
		if docked or dragging then
			return
		end

		if minimized then
			RestorePanel()
		else
			MinimizePanel()
		end
	end)

	Header.InputBegan:Connect(function(input: InputObject)
		if docked or dragging or resizing then
			return
		end

		local inputType = input.UserInputType

		if inputType ~= Enum.UserInputType.MouseButton1
			and inputType ~= Enum.UserInputType.Touch then
			return
		end

		local pointer = PointerPosition(input)

		local function PointInside(gui: GuiObject): boolean
			local position = gui.AbsolutePosition
			local size = gui.AbsoluteSize

			return pointer.X >= position.X
				and pointer.X <= position.X + size.X
				and pointer.Y >= position.Y
				and pointer.Y <= position.Y + size.Y
		end

		if MinBtn.Visible and PointInside(MinBtn) then
			return
		end

		if DockBtn.Visible and PointInside(DockBtn) then
			return
		end

		if CloseBtn.Visible and PointInside(CloseBtn) then
			return
		end

		StopPanelTween()

		dragging = true
		dragInput = input
		dragOffset = pointer - Panel.AbsolutePosition

		UpdateDockPreview()
	end)

	ResizeBtn.InputBegan:Connect(function(input: InputObject)
		if resizing or dragging or isAnimating or minimized then
			return
		end

		if not isPointerInput(input) then
			return
		end

		StopPanelTween()

		resizing = true
		resizeInput = input
		resizeStartX = input.Position.X
		resizeStartWidth = panelWidth

		SetResizeHighlight(true)
	end)

	ResizeBtn.MouseEnter:Connect(function()
		if not resizing then
			SetResizeHighlight(true)
		end
	end)

	ResizeBtn.MouseLeave:Connect(function()
		if not resizing then
			SetResizeHighlight(false)
		end
	end)

	ConnectInput(UserInputService.InputChanged, function(input: InputObject)
		if resizing then
			local inputType = input.UserInputType

			if inputType ~= Enum.UserInputType.MouseMovement
				and inputType ~= Enum.UserInputType.Touch then
				return
			end

			if resizeInput
				and resizeInput.UserInputType == Enum.UserInputType.Touch
				and input ~= resizeInput then
				return
			end

			local camera = workspace.CurrentCamera
			local viewportWidth = if camera then camera.ViewportSize.X else math.huge
			local maxWidth = math.max(BASE_WIDTH, viewportWidth - Panel.AbsolutePosition.X)
			local newWidth = math.clamp(
				resizeStartWidth + (input.Position.X - resizeStartX),
				BASE_WIDTH,
				maxWidth
			)

			if newWidth ~= panelWidth then
				ApplyPanelWidth(newWidth)
			end

			return
		end

		if not dragging then
			return
		end

		local inputType = input.UserInputType

		if inputType ~= Enum.UserInputType.MouseMovement
			and inputType ~= Enum.UserInputType.Touch then
			return
		end

		if dragInput
			and dragInput.UserInputType == Enum.UserInputType.Touch
			and input ~= dragInput then
			return
		end

		local camera = workspace.CurrentCamera

		if not camera then
			return
		end

		local pointer = PointerPosition(input)
		local viewport = camera.ViewportSize

		local x = math.clamp(
			pointer.X - dragOffset.X,
			0,
			math.max(0, viewport.X - Panel.AbsoluteSize.X)
		)

		local y = math.clamp(
			pointer.Y - dragOffset.Y,
			0,
			math.max(0, viewport.Y - Panel.AbsoluteSize.Y)
		)

		Panel.Position = UDim2.fromOffset(x, y)

		UpdateDockPreview()
	end)

	ConnectInput(UserInputService.InputEnded, function(input: InputObject)
		if resizing then
			local resizeReleased = input.UserInputType == Enum.UserInputType.MouseButton1
				or (
					resizeInput ~= nil
					and resizeInput.UserInputType == Enum.UserInputType.Touch
					and input == resizeInput
				)

			if resizeReleased then
				resizing = false
				resizeInput = nil
				SetResizeHighlight(false)
			end

			return
		end

		if not dragging then
			return
		end

		local mouseReleased =
			input.UserInputType == Enum.UserInputType.MouseButton1

		local touchReleased =
			dragInput ~= nil
			and dragInput.UserInputType == Enum.UserInputType.Touch
			and input == dragInput

		if not mouseReleased and not touchReleased then
			return
		end

		UpdateDockPreview()

		local shouldDock = DockPreview.Visible and IsTouchingDockPreview()

		dragging = false
		dragInput = nil
		DockPreview.Visible = false

		if shouldDock then
			DockPanel()
		end
	end)

	local headerButtonColor = CloseBtn.BackgroundColor3

	bindInteraction(OpenBtn, OpenBtn, {
		BackgroundTransparency = 0.25,
		ImageTransparency = 0.1,
	}, {
		BackgroundTransparency = 0.1,
		ImageTransparency = 0.35,
	})

	bindInteraction(CloseBtn, CloseBtn, {
		BackgroundColor3 = Color3.fromRGB(170, 50, 50),
		ImageTransparency = 0.1,
	}, {
		BackgroundColor3 = Color3.fromRGB(125, 35, 35),
		ImageTransparency = 0.3,
	})

	for _, button in ipairs({MinBtn, DockBtn}) do
		bindInteraction(button, button, {
			BackgroundColor3 = lighten(headerButtonColor, 0.15),
			ImageTransparency = 0.1,
		}, {
			BackgroundColor3 = lighten(headerButtonColor, 0.28),
			ImageTransparency = 0.3,
		})
	end

	DockBtn.Visible = true
	MinBtn.Visible = false
	DockPreview.Visible = false

	SetContentVisible(true)

	UpdateClosedPosition()
	UpdateOpenButton()
end

local function initializeStoreSystem()
	local LocalPlayer = Players.LocalPlayer
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

	local StudioLiteFolder = game:GetService("ReplicatedStorage"):WaitForChild("StudioLiteFolder", 3)
	local LoadAssetRemote = StudioLiteFolder and StudioLiteFolder:WaitForChild("LoadAssetModelToPlayerGuiServerFunction", 3)
	local ClearAssetRemote = StudioLiteFolder and StudioLiteFolder:WaitForChild("ClearAssetModelToPlayerGuiServerFunction", 3)

	local StudioGui = PlayerGui:WaitForChild("StudioGui", 3)
	local ExplorerPanel = StudioGui and StudioGui:WaitForChild("ExplorerPanel", 3)
	local GetSelection = ExplorerPanel and ExplorerPanel:WaitForChild("GetSelection", 3)
	local SetSelection = ExplorerPanel and ExplorerPanel:WaitForChild("SetSelection", 3)

	local Status = GUI["GUI_Status"] :: TextLabel
	local SearchBox = GUI["GUI_SearchBox"] :: Frame
	local SearchBoxStroke = GUI["GUI_UIStroke"] :: UIStroke
	local Input = GUI["GUI_Input"] :: TextBox
	local SearchBtn = GUI["GUI_SearchBtn"] :: GuiButton
	local Dropdown = GUI["GUI_Dropdown"] :: GuiButton
	local DropdownStroke = GUI["GUI_UIStroke_1"] :: UIStroke
	local Select = GUI["GUI_Select"] :: TextLabel
	local Arrow = GUI["GUI_Arrow"] :: ImageLabel
	local SaveBtn = GUI["GUI_SaveBtn"] :: ImageButton
	local Category = GUI["GUI_Category"] :: Frame
	local ScrollCategory = GUI["GUI_ScrollCategory"] :: ScrollingFrame
	local OptionTemplate = GUI["GUI_Option"] :: TextButton
	local OptionItemTemplate = GUI["GUI_Item"] :: TextLabel
	local OptionCheckTemplate = GUI["GUI_Check"] :: ImageLabel
	local SuggestionsDropdown = GUI["GUI_Suggestions"] :: Frame
	local SuggestionItemTemplate = GUI["GUI_SuggestionItem"] :: TextButton
	local SuggestionTextTemplate = GUI["GUI_SuggestionText"] :: TextLabel
	local ScrollingFrame = GUI["GUI_ScrollingFrame"] :: ScrollingFrame
	local GridLayout = GUI["GUI_UIGridLayout"] :: UIGridLayout
	local GridPadding = GUI["GUI_UIPadding_1"] :: UIPadding
	local SavedScroll = GUI["GUI_SavedScrollingFrame"] :: ScrollingFrame
	local SavedGridLayout = GUI["GUI_SavedUIGridLayout"] :: UIGridLayout
	local SavedGridPadding = GUI["GUI_SavedUIPadding"] :: UIPadding
	local CardTemplate = GUI["GUI_Card"] :: Frame
	local MoreMenu = GUI["GUI_More"] :: Frame
	local CopyIdButton = GUI["GUI_CopyID"] :: TextButton
	local CopyLinkButton = GUI["GUI_CopyLink"] :: TextButton
	local SaveAssetButton = GUI["GUI_SaveAsset"] :: TextButton
	local ThumbnailTemplate = GUI["GUI_Thumbnail"] :: ImageLabel
	local InsertButtonTemplate = GUI["GUI_InsertBtn"] :: TextButton
	local NameTemplate = GUI["GUI_Name"] :: TextLabel
	local CreatorTemplate = GUI["GUI_Creator"] :: TextLabel
	local PriceTemplate = GUI["GUI_Price"] :: TextLabel
	local RatingTemplate = GUI["GUI_Rating"] :: TextLabel
	local LikeTemplate = GUI["GUI_Like"] :: ImageLabel
	local BookmarkTemplate = GUI["GUI_Bookmark"] :: ImageLabel
	local Loadmore = GUI["GUI_Loadmore"] :: Frame
	local LoadmoreButton = GUI["GUI_Button"] :: TextButton

	local Categories = {"Model", "Plugin", "Audio", "Decal", "Meshes", "Images", "Video", "Material"}
	local CategoryAPI = {
		Model = {Type = "Model"},
		Plugin = {Type = "Plugin"},
		Audio = {Type = "Audio"},
		Decal = {Type = "Decal"},
		Meshes = {Type = "MeshPart"},
		Images = {Type = "Decal"},
		Video = {Type = "Video"},
		Material = {Type = "Model", CategoryPath = "3d__materials"},
	}
	local BASE_URL = "https://apis.roblox.com/toolbox-service/v2/assets:search"
	local STORE_FOLDER = "Plugin-Store"
	local MAX_PAGE_SIZE = 15
	local ACTIVE_COLOR = Color3.fromRGB(255, 190, 70)
	local INACTIVE_COLOR = Color3.new(1, 1, 1)
	local RATING_RED = Color3.fromRGB(235, 72, 72)
	local RATING_ORANGE = Color3.fromRGB(255, 166, 55)
	local RATING_YELLOW = Color3.fromRGB(255, 211, 76)
	local RATING_GREEN = Color3.fromRGB(80, 205, 120)
	local RATING_TEXT_PAD = 2
	local RATING_ICON_ZONE = 14
	local HOLD_DURATION = 0.45
	local SEARCH_FOCUS_COLOR = Color3.fromRGB(190, 190, 190)
	local SEARCH_FOCUS_THICKNESS = 0.5
	local DROPDOWN_PRESS_COLOR = Color3.fromRGB(75, 75, 75)
	local searchStrokeIdleColor = SearchBoxStroke.Color
	local STROKE_THICKNESS = 0.5
	SearchBoxStroke.Thickness = STROKE_THICKNESS
	DropdownStroke.Thickness = STROKE_THICKNESS
	local searchStrokeIdleThickness = STROKE_THICKNESS
	local SAVED_PAGE_SIZE = 15
	local OPTION_SELECTED_LIGHTEN = 0.14

	local SHIMMER_MIN_TIME = 2.2
	local REQUEST_TIMEOUT = 15
	local REQUEST_MIN_INTERVAL = 0.35
	local REQUEST_CACHE_TTL = 120
	local RENDER_BATCH = 12

	local RequestFunction = http_request or request or (syn and syn.request) or (fluxus and fluxus.request)
	local readfile = readfile or (io and io.readfile)
	local writefile = writefile or (io and io.writefile)
	local isfile = isfile or (io and io.isfile)
	local isfolder = isfolder or (io and io.isfolder)
	local makefolder = makefolder or (io and io.makefolder)
	local setclipboard = setclipboard or toclipboard

	local CurrentCategory = "Model"
	local CurrentKeyword = ""
	local CurrentPageToken: string? = nil
	local IsLoading = false
	local IsSavedMode = false
	local DropdownOpen = false
	local ActiveCard: Frame? = nil
	local ActiveAsset: {[string]: any}? = nil
	local SearchGeneration = 0
	local PressGeneration = 0
	local ActivePress = nil
	local CategoryOptions = {}
	local CategoryControllers = {}
	local SavedCardIndex = {}
	local SavedLimit = SAVED_PAGE_SIZE
	local SavedActiveQuery = ""
	local SavedSyncToken = 0
	local AddSavedCard
	local RefreshSavedView
	local StoreView = {Scroll = ScrollingFrame, Grid = GridLayout, Padding = GridPadding}
	local SavedView = {Scroll = SavedScroll, Grid = SavedGridLayout, Padding = SavedGridPadding}
	local CHIP_BACKGROUND_TRANSPARENCY = PriceTemplate.BackgroundTransparency

	local CATEGORY_POSITION = Category.Position
	local MORE_POSITION = MoreMenu.Position

	CardTemplate.Visible = false
	MoreMenu.Visible = false
	OptionTemplate.Visible = false
	SuggestionItemTemplate.Visible = false
	SuggestionsDropdown.Visible = false
	Category.Visible = false
	Loadmore.Visible = false

	local function SafeCall(callback, ...)
		if type(callback) ~= "function" then
			return nil
		end

		local args = table.pack(...)
		local ok, result = pcall(function()
			return callback(table.unpack(args, 1, args.n))
		end)

		if ok then
			return result
		end

		return nil
	end

	local function FindPart(root: Instance, templatePart: Instance): Instance?
		return root:FindFirstChild(templatePart.Name, true)
	end

	local function GetAssetLink(assetId, assetName)
		if not assetId then
			return ""
		end

		return "https://create.roblox.com/store/asset/" .. tostring(assetId) .. "/" .. HttpService:UrlEncode(assetName or "")
	end

	local function GetCategoryFile(categoryName)
		return STORE_FOLDER .. "/Saved_" .. categoryName .. ".json"
	end

	local function EnsureStoreFolder()
		if not makefolder then
			return false
		end

		if isfolder and SafeCall(isfolder, STORE_FOLDER) == true then
			return true
		end

		local ok = pcall(function()
			makefolder(STORE_FOLDER)
		end)

		return ok and (not isfolder or SafeCall(isfolder, STORE_FOLDER) == true)
	end

	local function FormatSavedPrice(price)
		price = tonumber(price) or 0

		if price <= 0 then
			return "Free"
		end

		return string.format("$%.2f", price)
	end

	local function NormalizeSavedList(decoded, categoryName)
		if type(decoded) ~= "table" then
			return {}
		end

		if type(decoded[categoryName]) == "table" then
			decoded = decoded[categoryName]
		end

		local list = {}

		for _, saved in ipairs(decoded) do
			if type(saved) == "table" and saved.ID then
				local id = tostring(saved.ID)
				local price = tonumber(saved.Price) or 0
				local rating = tonumber(saved.Rating) or 0
				local thumbnail = tostring(saved.Thumbnail or "")

				if thumbnail == "" then
					thumbnail = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. id .. "&width=420&height=420&format=png"
				end

				table.insert(list, {
					Thumbnail = thumbnail,
					Name = tostring(saved.Name or "Unknown"),
					Creator = tostring(saved.Creator or "Unknown"),
					AssetTypeId = tonumber(saved.AssetTypeId) or saved.AssetTypeId or 0,
					ID = id,
					Price = price,
					PriceText = FormatSavedPrice(price),
					Rating = rating,
				})
			end
		end

		return list
	end

	local function ReadSavedCategoryFromDisk(categoryName)
		if readfile and isfile then
			local path = GetCategoryFile(categoryName)

			if SafeCall(isfile, path) == true then
				local content = SafeCall(readfile, path)

				if type(content) == "string" and content ~= "" then
					local ok, decoded = pcall(function()
						return HttpService:JSONDecode(content)
					end)

					if ok and type(decoded) == "table" then
						return NormalizeSavedList(decoded, categoryName)
					end
				end
			end

			local legacyPath = STORE_FOLDER .. "/SavedAssets.json"

			if SafeCall(isfile, legacyPath) == true then
				local content = SafeCall(readfile, legacyPath)

				if type(content) == "string" and content ~= "" then
					local ok, decoded = pcall(function()
						return HttpService:JSONDecode(content)
					end)

					if ok and type(decoded) == "table" and type(decoded[categoryName]) == "table" then
						return NormalizeSavedList(decoded[categoryName], categoryName)
					end
				end
			end
		end

		return {}
	end

	local SavedCache = {}
	local SavedIdSets = {}

	local function ReadSavedCategory(categoryName)
		local cached = SavedCache[categoryName]

		if cached then
			return table.clone(cached)
		end

		local list = ReadSavedCategoryFromDisk(categoryName)

		SavedCache[categoryName] = list
		SavedIdSets[categoryName] = nil

		return table.clone(list)
	end

	local function Encode(value)
		return HttpService:JSONEncode(value)
	end

	local function WriteSavedCategory(categoryName, list)
		if not writefile or not EnsureStoreFolder() then
			return false
		end

		local clean = {}

		for _, saved in ipairs(list) do
			table.insert(clean, {
				Thumbnail = tostring(saved.Thumbnail or ""),
				Name = tostring(saved.Name or "Unknown"),
				Creator = tostring(saved.Creator or "Unknown"),
				AssetTypeId = tonumber(saved.AssetTypeId) or 0,
				ID = tostring(saved.ID or ""),
				Price = tonumber(saved.Price) or 0,
				Rating = tonumber(saved.Rating) or 0,
			})
		end

		local lines = {"["}

		for index, saved in ipairs(clean) do
			table.insert(lines, "  {")
			table.insert(lines, "    \"Thumbnail\": " .. Encode(saved.Thumbnail) .. ",")
			table.insert(lines, "    \"Name\": " .. Encode(saved.Name) .. ",")
			table.insert(lines, "    \"Creator\": " .. Encode(saved.Creator) .. ",")
			table.insert(lines, "    \"AssetTypeId\": " .. Encode(saved.AssetTypeId) .. ",")
			table.insert(lines, "    \"ID\": " .. Encode(saved.ID) .. ",")
			table.insert(lines, "    \"Price\": " .. Encode(saved.Price) .. ",")
			table.insert(lines, "    \"Rating\": " .. Encode(saved.Rating))
			table.insert(lines, "  }" .. (index < #clean and "," or ""))
		end

		table.insert(lines, "]")

		local encoded = table.concat(lines, "\n")
		local written = pcall(function()
			writefile(GetCategoryFile(categoryName), encoded)
		end)

		if written then
			SavedCache[categoryName] = NormalizeSavedList(clean, categoryName)
			SavedIdSets[categoryName] = nil
		end

		return written
	end

	local function IsAssetSaved(categoryName, assetId)
		if not assetId then
			return false
		end

		local idSet = SavedIdSets[categoryName]

		if not idSet then
			idSet = {}

			for _, saved in ipairs(ReadSavedCategory(categoryName)) do
				idSet[tostring(saved.ID)] = true
			end

			SavedIdSets[categoryName] = idSet
		end

		return idSet[tostring(assetId)] == true
	end

	local ResponseCache = {}
	local ResponseCacheCount = 0
	local LastRequestAt = 0

	local function PerformRequest(url)
		local state = {Done = false, Ok = false, Response = nil}

		task.spawn(function()
			local ok, response = pcall(RequestFunction, {
				Url = url,
				Method = "GET",
				Headers = {Accept = "application/json"},
			})

			state.Ok = ok
			state.Response = response
			state.Done = true
		end)

		local startedAt = os.clock()

		while not state.Done do
			if os.clock() - startedAt > REQUEST_TIMEOUT then
				warn("[NarsEdv] Store API request timed out")
				return nil, "Request timed out"
			end

			task.wait(0.05)
		end

		if not state.Ok or type(state.Response) ~= "table" then
			warn("[NarsEdv] Store API request failed")
			return nil, tostring(state.Response or "HTTP request failed")
		end

		return state.Response
	end

	local function RequestJSON(url)
		if not RequestFunction then
			warn("[NarsEdv] Store API request unavailable")
			return nil, "HTTP request unavailable"
		end

		local cached = ResponseCache[url]

		if cached and os.clock() - cached.Time < REQUEST_CACHE_TTL then
			return cached.Data
		end

		local response, err

		for attempt = 1, 2 do
			local waitTime = REQUEST_MIN_INTERVAL - (os.clock() - LastRequestAt)

			if waitTime > 0 then
				task.wait(waitTime)
			end

			LastRequestAt = os.clock()

			response, err = PerformRequest(url)

			if not response then
				return nil, err
			end

			local code = tonumber(response.StatusCode)
			local retryable = code == 429 or (code ~= nil and code >= 500)

			if not retryable or attempt == 2 then
				break
			end

			task.wait(1.5)
		end

		local statusCode = tonumber(response.StatusCode)

		if statusCode ~= 200 then
			warn("[NarsEdv] Store API request failed (HTTP " .. tostring(statusCode or "unknown") .. ")")
			return nil, "HTTP " .. tostring(statusCode or "unknown")
		end

		local body = response.Body

		if type(body) ~= "string" or body == "" then
			return nil, "Empty response"
		end

		local decoded, data = pcall(function()
			return HttpService:JSONDecode(body)
		end)

		if not decoded or type(data) ~= "table" then
			return nil, "Invalid JSON response"
		end

		if ResponseCacheCount >= 40 then
			table.clear(ResponseCache)
			ResponseCacheCount = 0
		end

		ResponseCache[url] = {Time = os.clock(), Data = data}
		ResponseCacheCount += 1

		return data
	end

	local function GetPriceText(item)
		local product = item.creatorStoreProduct or item.product or {}
		local money = product.purchasePrice

		if type(money) == "table" then
			local quantity = money.quantity

			if type(quantity) == "table" then
				local significand = tonumber(quantity.significand)
				local exponent = tonumber(quantity.exponent) or 0

				if significand then
					local amount = significand * (10 ^ exponent)

					if amount <= 0 then
						return "Free"
					end

					local currency = tostring(money.currencyCode or "USD")

					if currency == "USD" then
						return string.format("$%.2f", amount)
					end

					return string.format("%s %.2f", currency, amount)
				end
			end
		end

		if type(money) == "number" then
			if money <= 0 then
				return "Free"
			end

			return string.format("$%.2f", money)
		end

		if type(money) == "string" then
			local amount = tonumber(money)

			if amount then
				return amount <= 0 and "Free" or string.format("$%.2f", amount)
			end
		end

		if product.purchasable == true then
			return "Free"
		end

		return "Unavailable"
	end

	local function GetPriceValue(item)
		local product = item.creatorStoreProduct or item.product or {}
		local money = product.purchasePrice

		if type(money) == "table" then
			local quantity = money.quantity

			if type(quantity) == "table" then
				local significand = tonumber(quantity.significand)
				local exponent = tonumber(quantity.exponent) or 0

				if significand then
					return math.max(0, significand * (10 ^ exponent))
				end
			end
		elseif type(money) == "number" then
			return math.max(0, money)
		elseif type(money) == "string" then
			local amount = tonumber(money)

			if amount then
				return math.max(0, amount)
			end
		end

		if product.purchasable == true then
			return 0
		end

		return 0
	end

	local function GetRatingPercent(voting)
		if type(voting) ~= "table" then
			return nil
		end

		local percent = tonumber(voting.upVotePercent or voting.upvotePercent or voting.likePercent or voting.ratingPercent or voting.percent)

		if percent == nil then
			local up = tonumber(voting.upVoteCount or voting.upvoteCount or voting.upVotes or voting.upVotesCount or voting.likes)
			local down = tonumber(voting.downVoteCount or voting.downvoteCount or voting.downVotes or voting.downVotesCount or voting.dislikes)

			if up and down and up + down > 0 then
				percent = up / (up + down) * 100
			end
		end

		if percent == nil then
			return nil
		end

		if percent > 0 and percent <= 1 then
			percent *= 100
		end

		return math.clamp(percent, 0, 100)
	end

	local function GetRatingColor(percent)
		if percent < 40 then
			return RATING_RED
		elseif percent < 60 then
			return RATING_ORANGE
		elseif percent < 80 then
			return RATING_YELLOW
		end

		return RATING_GREEN
	end

	local function ParseAsset(item, fallback)
		item = item or {}

		local asset = item.asset or item
		local creator = item.creator or {}
		local assetId = asset.id or (fallback and fallback.ID)
		local assetName = asset.name or (fallback and fallback.Name) or "Unknown"
		local creatorName = creator.name or (fallback and fallback.Creator) or "Unknown"
		local thumbnail = ""

		if assetId then
			thumbnail = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. tostring(assetId) .. "&width=420&height=420&format=png"
		end

		return {
			AssetTypeId = asset.assetTypeId or (fallback and fallback.AssetTypeId),
			Name = assetName,
			Id = assetId,
			Link = GetAssetLink(assetId, assetName),
			Creator = creatorName,
			Price = GetPriceValue(item),
			PriceText = GetPriceText(item),
			Rating = GetRatingPercent(item.voting or item.votes or {}) or 0,
			Thumbnail = thumbnail,
			Category = CurrentCategory,
		}
	end

	local function RequestPage(keyword, categoryName, pageToken)
		local categoryInfo = CategoryAPI[categoryName]

		if not categoryInfo then
			return nil, "Unsupported category: " .. tostring(categoryName)
		end

		local params = {
			"searchCategoryType=" .. HttpService:UrlEncode(categoryInfo.Type),
			"query=" .. HttpService:UrlEncode(keyword),
			"maxPageSize=" .. tostring(MAX_PAGE_SIZE),
			"searchView=Full",
		}

		if categoryInfo.CategoryPath then
			table.insert(params, "categoryPath=" .. HttpService:UrlEncode(categoryInfo.CategoryPath))
		end

		if pageToken and pageToken ~= "" then
			table.insert(params, "pageToken=" .. HttpService:UrlEncode(pageToken))
		end

		local data, err = RequestJSON(BASE_URL .. "?" .. table.concat(params, "&"))

		if not data then
			return nil, err
		end

		local results = {}

		for _, item in ipairs(data.creatorStoreAssets or {}) do
			table.insert(results, ParseAsset(item))
		end

		return {Assets = results, NextPageToken = data.nextPageToken}
	end

	local function SetTextTruncate(label)
		if label and label:IsA("TextLabel") then
			pcall(function()
				label.TextTruncate = Enum.TextTruncate.AtEnd
			end)
		end
	end

	local function GetRatingChipWidth(): number
		local width = RatingTemplate.Size.X

		return width.Scale * CardTemplate.Size.X.Offset + width.Offset
	end

	local function SetRatingVisual(card, percent)
		local rating = FindPart(card, RatingTemplate) :: TextLabel?

		if not rating then
			return
		end

		local like = FindPart(rating, LikeTemplate) or FindPart(card, LikeTemplate)
		local visible = percent ~= nil and percent > 0

		rating.Visible = visible
		SetTextTruncate(rating)

		if not visible then
			return
		end

		local color = GetRatingColor(percent)
		local text = string.format("%d%%", math.floor(percent + 0.5))

		rating.Text = text
		rating.TextColor3 = color

		local textWidth = nil
		local measured, bounds = pcall(function()
			return TextService:GetTextSize(text, rating.TextSize, rating.Font, Vector2.new(1000, 100))
		end)

		if measured and typeof(bounds) == "Vector2" then
			textWidth = bounds.X
		end

		local showIcon
		if textWidth then
			showIcon = textWidth <= GetRatingChipWidth() - RATING_ICON_ZONE - RATING_TEXT_PAD
		else
			showIcon = #text <= 3
		end

		local padding = rating:FindFirstChildOfClass("UIPadding")

		if showIcon then
			rating.TextXAlignment = Enum.TextXAlignment.Right

			if padding then
				padding.PaddingRight = UDim.new(0, RATING_TEXT_PAD)
			end
		else
			rating.TextXAlignment = Enum.TextXAlignment.Center

			if padding then
				padding.PaddingRight = UDim.new(0, 0)
			end
		end

		if like and like:IsA("ImageLabel") then
			like.ImageColor3 = color
			like.Visible = showIcon
		end

		rating:SetAttribute("Rating", percent)
	end

	local function ReturnMoreToTemplate()
		MoreMenu.Visible = false
		MoreMenu.Parent = CardTemplate
		ActiveCard = nil
		ActiveAsset = nil
	end

	local function CloseMore()
		ReturnMoreToTemplate()
	end

	local SKELETON_HIGHLIGHT_COLOR = Color3.fromRGB(88, 88, 88)
	local SKELETON_BASE_COLOR = Color3.fromRGB(44, 44, 44)
	local SKELETON_CYCLE = 1.25
	local SKELETON_EDGE = SKELETON_BASE_COLOR.R / SKELETON_HIGHLIGHT_COLOR.R
	local SKELETON_EDGE_COLOR = Color3.new(SKELETON_EDGE, SKELETON_EDGE, SKELETON_EDGE)
	local SKELETON_SEQUENCE = ColorSequence.new({
		ColorSequenceKeypoint.new(0, SKELETON_EDGE_COLOR),
		ColorSequenceKeypoint.new(0.3, SKELETON_EDGE_COLOR),
		ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(0.7, SKELETON_EDGE_COLOR),
		ColorSequenceKeypoint.new(1, SKELETON_EDGE_COLOR),
	})
	local SkeletonCards: {Frame} = {}
	local SkeletonGradients: {UIGradient} = {}
	local SkeletonConnection: RBXScriptConnection? = nil
	local ShimmerStartedAt = 0
	local RenderToken = 0

	local function CreateSkeletonGradient(target: GuiObject)
		target.BackgroundColor3 = SKELETON_HIGHLIGHT_COLOR
		target.BackgroundTransparency = 0

		local gradient = Instance.new("UIGradient")
		gradient.Color = SKELETON_SEQUENCE
		gradient.Rotation = 20
		gradient.Offset = Vector2.new(-1, 0)
		gradient.Parent = target

		table.insert(SkeletonGradients, gradient)
	end

	local function ClearSkeletons()
		if SkeletonConnection then
			SkeletonConnection:Disconnect()
			SkeletonConnection = nil
		end

		for _, card in ipairs(SkeletonCards) do
			card:Destroy()
		end

		table.clear(SkeletonCards)
		table.clear(SkeletonGradients)
	end

	local function ShowSkeletons(count: number, view)
		ClearSkeletons()

		ShimmerStartedAt = os.clock()

		for _ = 1, count do
			local card = CardTemplate:Clone()
			card.Name = generateName()
			card.Visible = true
			card:SetAttribute("StoreSkeletonCard", true)

			local clonedMore = card:FindFirstChild(MoreMenu.Name)

			if clonedMore then
				clonedMore:Destroy()
			end

			card.Parent = (view or StoreView).Scroll

			local thumbnail = FindPart(card, ThumbnailTemplate) :: ImageLabel?

			if thumbnail then
				thumbnail.Image = ""
				CreateSkeletonGradient(thumbnail)
			end

			for _, template in ipairs({NameTemplate, PriceTemplate, RatingTemplate}) do
				local bar = FindPart(card, template) :: TextLabel?

				if bar then
					bar.Text = ""
					bar.Visible = true
					CreateSkeletonGradient(bar)

				end
			end

			for _, template in ipairs({CreatorTemplate, LikeTemplate, BookmarkTemplate, InsertButtonTemplate}) do
				local part = FindPart(card, template) :: GuiObject?

				if part then
					part.Visible = false
				end
			end

			table.insert(SkeletonCards, card)
		end

		SkeletonConnection = RunService.RenderStepped:Connect(function()
			local phase = (os.clock() % SKELETON_CYCLE) / SKELETON_CYCLE
			local offset = Vector2.new(-1 + phase * 2, 0)

			for _, gradient in ipairs(SkeletonGradients) do
				gradient.Offset = offset
			end
		end)
	end

	local function WaitForShimmer()
		local remaining = SHIMMER_MIN_TIME - (os.clock() - ShimmerStartedAt)

		if remaining > 0 then
			task.wait(remaining)
		end
	end

	local function ClearCards()
		RenderToken += 1
		CloseMore()
		ClearSkeletons()

		for _, child in ipairs(ScrollingFrame:GetChildren()) do
			if child ~= CardTemplate and child:IsA("Frame") and child:GetAttribute("StoreAssetCard") then
				child:Destroy()
			end
		end

		ScrollingFrame.CanvasPosition = Vector2.zero
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
	end

	local function UpdateCanvas(view)
		view = view or StoreView

		local extra = 12

		if Loadmore.Visible and ((view == SavedView) == IsSavedMode) then
			extra += 40
		end

		view.Scroll.CanvasSize = UDim2.fromOffset(0, view.Grid.AbsoluteContentSize.Y + extra)
	end

	local function UpdateGridLayout(view)
		view = view or StoreView

		local width = view.Scroll.AbsoluteSize.X

		if width <= 0 then
			return
		end

		local cell = view.Grid.CellSize.X.Offset
		local gap = view.Grid.CellPadding.X.Offset
		local columns = math.max(1, math.floor((width - 5 + gap) / (cell + gap)))
		local used = columns * cell + (columns - 1) * gap
		local side = math.max(0, math.floor((width - used) / 2))

		if view.Padding.PaddingLeft.Offset ~= side then
			view.Padding.PaddingLeft = UDim.new(0, side)
		end
	end

	local function GetLoadedAssetCount()
		local count = 0

		if IsSavedMode then
			for _, child in ipairs(SavedScroll:GetChildren()) do
				if child:IsA("Frame") and child:GetAttribute("SavedAssetCard") and child.Visible then
					count += 1
				end
			end

			return count
		end

		for _, child in ipairs(ScrollingFrame:GetChildren()) do
			if child:IsA("Frame") and child:GetAttribute("StoreAssetCard") then
				count += 1
			end
		end

		return count
	end

	local function UpdateStatus(amount)
		local count = tonumber(amount) or GetLoadedAssetCount()

		if IsSavedMode then
			Status.Text = CurrentCategory .. " / Loaded Saved Assets • " .. tostring(count)
		elseif CurrentKeyword ~= "" then
			Status.Text = CurrentCategory .. " / Search Results for " .. CurrentKeyword .. " • " .. tostring(count)
		else
			Status.Text = CurrentCategory .. " / Enter search query"
		end
	end

	local function CopyText(value)
		if setclipboard then
			SafeCall(setclipboard, tostring(value or ""))
		end
	end

	local function SaveAsset(asset)
		if not asset or not (asset.Id or asset.ID) then
			return false
		end

		local assetId = tostring(asset.Id or asset.ID)
		local categoryName = asset.Category or CurrentCategory
		local list = ReadSavedCategory(categoryName)

		for _, saved in ipairs(list) do
			if tostring(saved.ID) == assetId then
				return false
			end
		end

		table.insert(list, {
			Thumbnail = asset.Thumbnail or "",
			Name = asset.Name or "Unknown",
			Creator = asset.Creator or "Unknown",
			AssetTypeId = tonumber(asset.AssetTypeId) or 0,
			ID = assetId,
			Price = tonumber(asset.Price) or 0,
			Rating = tonumber(asset.Rating) or 0,
		})

		if not WriteSavedCategory(categoryName, list) then
			return false
		end

		for _, card in ipairs(ScrollingFrame:GetChildren()) do
			if card:GetAttribute("StoreAssetCard")
				and tostring(card:GetAttribute("AssetId")) == assetId
				and tostring(card:GetAttribute("AssetCategory") or categoryName) == tostring(categoryName) then
				local bookmark = FindPart(card, BookmarkTemplate)

				if bookmark and (bookmark:IsA("ImageButton") or bookmark:IsA("ImageLabel")) then
					bookmark.ImageColor3 = ACTIVE_COLOR
					bookmark.Visible = true
				end
			end
		end

		return true
	end

	local function DeleteAsset(asset, targetCard)
		if not asset or not (asset.Id or asset.ID) then
			return false
		end

		local assetId = tostring(asset.Id or asset.ID)
		local categoryName = tostring(asset.Category or CurrentCategory)
		local list = ReadSavedCategory(categoryName)
		local filtered = {}
		local removed = false

		for _, saved in ipairs(list) do
			if tostring(saved.ID) == assetId then
				removed = true
			else
				table.insert(filtered, saved)
			end
		end

		if not removed or not WriteSavedCategory(categoryName, filtered) then
			return false
		end

		for _, scroller in ipairs({ScrollingFrame, SavedScroll}) do
			for _, card in ipairs(scroller:GetChildren()) do
				if card ~= CardTemplate
					and card:GetAttribute("StoreAssetCard")
					and tostring(card:GetAttribute("AssetId")) == assetId
					and tostring(card:GetAttribute("AssetCategory") or categoryName) == categoryName then
					if card == targetCard then
						CloseMore()
					end

					card:Destroy()
				end
			end
		end

		local savedIndex = SavedCardIndex[categoryName]

		if savedIndex then
			savedIndex[assetId] = nil
		end

		UpdateCanvas(StoreView)
		UpdateCanvas(SavedView)
		UpdateStatus(GetLoadedAssetCount())

		if IsSavedMode and RefreshSavedView then
			task.spawn(RefreshSavedView, true)
		end

		return true
	end

	local function ToggleSaveAsset(asset, targetCard)
		if not asset then
			return
		end

		local assetId = asset.Id or asset.ID
		local categoryName = tostring(asset.Category or CurrentCategory)

		if IsAssetSaved(categoryName, assetId) then
			DeleteAsset(asset, targetCard)
		else
			SaveAsset(asset)
		end
	end

	local function ConfigureMore(asset, card)
		CloseMore()

		ActiveAsset = asset
		ActiveCard = card

		MoreMenu.Parent = card
		MoreMenu.Position = UDim2.new(
			MORE_POSITION.X.Scale,
			MORE_POSITION.X.Offset,
			MORE_POSITION.Y.Scale,
			MORE_POSITION.Y.Offset + 6
		)
		MoreMenu.Visible = true
		MoreMenu.ZIndex = card.ZIndex + 10

		playTween(MoreMenu, 0.16, {Position = MORE_POSITION}, Enum.EasingStyle.Back)

		local saved = IsAssetSaved(asset.Category or CurrentCategory, asset.Id or asset.ID)
		SaveAssetButton.Text = saved and "  Delete Asset" or "  Save Asset"

		for _, descendant in ipairs(MoreMenu:GetDescendants()) do
			if descendant:IsA("GuiObject") then
				descendant.ZIndex = MoreMenu.ZIndex + 1
			end
		end
	end

	local function InsertAsset(asset, statusTarget)
		local function SetStatus(message)
			if statusTarget and typeof(statusTarget) == "Instance"
				and (statusTarget:IsA("TextLabel") or statusTarget:IsA("TextButton")) then
				statusTarget.Text = message
			end
		end

		if type(asset) ~= "table" then
			SetStatus("Failed")
			return
		end

		local rawId = asset.Id or asset.ID
		local assetId = tostring(rawId or "")
		local numericId = tonumber(rawId)
		local category = tostring(asset.Category or CurrentCategory or "Model")
		local assetName = tostring(asset.Name or ("Asset_" .. assetId))
		local supportedCategories = {
			Model = true, Plugin = true, Audio = true, Decal = true,
			Meshes = true, Images = true, Video = true, Material = true,
		}

		if not supportedCategories[category] then
			SetStatus("Invalid category")
			return
		end

		if category == "Plugin" then
			warn("Plugin installation is not supported in Studio Lite.")
			SetStatus("Unsupported")
			return
		end

		if category == "Video" then
			warn("Video insertion is not supported in Studio Lite. Asset ID copied to clipboard.")
			SetStatus("Unsupported")
			return
		end

		if not numericId or numericId <= 0 then
			SetStatus("Failed")
			return
		end

		SetStatus("Working")

		if category == "Audio" then
			local sound = Instance.new("Sound")
			sound.Name = asset.Name or ("SoundAsset_" .. assetId)
			sound.SoundId = "rbxassetid://" .. assetId
			sound.Volume = 0.5
			sound.Parent = workspace
			SetStatus("Success!")
			return
		end

		if category == "Decal" or category == "Images" then
			if GetSelection and SetSelection then
				local currentSelection = nil
				pcall(function()
					currentSelection = GetSelection:Invoke()
				end)

				if currentSelection
					and typeof(currentSelection) == "table"
					and #currentSelection >= 1
					and typeof(currentSelection[1]) == "Instance"
					and currentSelection[1]:IsA("BasePart") then

					local decal = Instance.new("Decal")
					decal.Name = asset.Name or "Decal"
					decal.Texture = "rbxthumb://type=Asset&id=" .. assetId .. "&w=420&h=420"
					decal.Parent = currentSelection[1]

					task.wait(0.2)
					pcall(function()
						SetSelection:Invoke({decal})
					end)

					SetStatus("Success!")
				else
					SetStatus("Select Part!")
				end
			else
				local decal = Instance.new("Decal")
				decal.Name = asset.Name or ("DecalAsset_" .. assetId)
				decal.Texture = "rbxassetid://" .. assetId
				decal.Parent = workspace
				SetStatus("Success!")
			end

			return
		end

		local function SafeStudioFallback(object)
			if not object then
				return false
			end

			local target = object
			local temporaryModel = false

			if not object:IsA("Model") then
				local model = Instance.new("Model")
				model.Name = assetName
				object.Parent = model
				target = model
				temporaryModel = true
			end

			local pivot, boundingSize
			local ok = pcall(function()
				pivot = target:GetPivot()
				local _, size = target:GetBoundingBox()
				boundingSize = size
			end)

			if not ok or not pivot or not boundingSize then
				if temporaryModel then
					local children = target:GetChildren()

					for _, child in ipairs(children) do
						child.Parent = workspace
					end

					target:Destroy()
				else
					target.Parent = workspace
				end

				return true
			end

			local camera = workspace.CurrentCamera
			local cameraCFrame = camera and camera.CFrame or CFrame.new()
			local forward = cameraCFrame.Position + cameraCFrame.LookVector * 30
			local x = math.floor(forward.X * 2 + 0.5) / 2
			local z = math.floor(forward.Z * 2 + 0.5) / 2
			local origin = Vector3.new(x, cameraCFrame.Position.Y, z)
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = LocalPlayer.Character and {LocalPlayer.Character} or {}

			local ray = workspace:Raycast(origin, Vector3.new(0, -1000, 0), params)
			local y = (ray and ray.Position.Y or 0) + boundingSize.Y / 2
			local moved = pcall(function()
				target:PivotTo(CFrame.new(x, y, z) * pivot.Rotation)
			end)

			if not moved then
				if temporaryModel then
					target:Destroy()
				end

				return false
			end

			if temporaryModel then
				for _, child in ipairs(target:GetChildren()) do
					child.Parent = workspace
				end

				target:Destroy()
			else
				target.Parent = workspace
				pcall(function()
					target:MakeJoints()
				end)
			end

			return true
		end

		local function TryClientLoad()
			local ok, objects = pcall(function()
				return game:GetObjects("rbxassetid://" .. assetId)
			end)

			if not ok or type(objects) ~= "table" or not objects[1] then
				return false
			end

			local inserted = SafeStudioFallback(objects[1])

			if not inserted then
				for _, object in ipairs(objects) do
					if object and object.Parent == nil then
						object:Destroy()
					end
				end
			end

			return inserted
		end

		local function ProcessLoadedObjects(assetFolder)
			local ok, clone = pcall(function()
				return assetFolder:Clone()
			end)

			if not ok or not clone then
				return false
			end

			local children = clone:GetChildren()

			if #children == 0 then
				clone:Destroy()
				return false
			end

			local serviceNames = {
				Workspace = true, Lighting = true, MaterialService = true,
				ReplicatedStorage = true, ServerStorage = true, ServerScriptService = true,
				StarterGui = true, StarterPack = true, Teams = true,
				SoundService = true, StarterPlayer = true,
			}
			local processed = false

			for _, object in ipairs(children) do
				if object:IsA("Folder") and serviceNames[object.Name] then
					local service = game:FindFirstChild(object.Name)

					if object.Name == "StarterPlayer" then
						for _, inner in ipairs(object:GetChildren()) do
							local target = game.StarterPlayer:FindFirstChild(inner.Name)

							if target and (inner.Name == "StarterPlayerScripts" or inner.Name == "StarterCharacterScripts") then
								for _, item in ipairs(inner:GetChildren()) do
									item.Parent = target
								end
							else
								inner.Parent = game.StarterPlayer
							end
						end

						processed = true
					elseif service then
						for _, item in ipairs(object:GetChildren()) do
							item.Parent = service
						end

						processed = true
					end
				elseif object:IsA("PostEffect") or object.ClassName == "Sky" then
					object.Parent = game:GetService("Lighting")
					processed = true
				elseif SafeStudioFallback(object) then
					processed = true
				end
			end

			clone:Destroy()

			return processed
		end

		local inserted = false

		if LoadAssetRemote and LoadAssetRemote:IsA("RemoteFunction") then
			local remoteOK, loadOK = pcall(function()
				return LoadAssetRemote:InvokeServer(assetId)
			end)

			if remoteOK and loadOK then
				local serverFolder = PlayerGui:WaitForChild(assetId, 5)

				if serverFolder then
					local processOK, result = pcall(function()
						return ProcessLoadedObjects(serverFolder)
					end)

					inserted = processOK and result == true

					if ClearAssetRemote and ClearAssetRemote:IsA("RemoteFunction") then
						pcall(function()
							ClearAssetRemote:InvokeServer(assetId)
						end)
					end
				end
			end
		end

		if not inserted then
			inserted = TryClientLoad()
		end

		if inserted then
			SetStatus("Success!")
		else
			SetStatus("Failed")
		end
	end

	local function AnimateCardIn(card: Frame, index: number)
		local fadeImages = {FindPart(card, ThumbnailTemplate), FindPart(card, LikeTemplate)}
		local fadeTexts = {
			FindPart(card, NameTemplate),
			FindPart(card, CreatorTemplate),
			FindPart(card, PriceTemplate),
			FindPart(card, RatingTemplate),
		}
		local fadeChips = {
			FindPart(card, PriceTemplate),
			FindPart(card, RatingTemplate),
		}

		for _, image in ipairs(fadeImages) do
			if image then
				(image :: ImageLabel).ImageTransparency = 1
			end
		end

		for _, label in ipairs(fadeTexts) do
			if label then
				(label :: TextLabel).TextTransparency = 1
			end
		end

		for _, chip in ipairs(fadeChips) do
			if chip then
				(chip :: TextLabel).BackgroundTransparency = 1
			end
		end

		task.delay(math.min(index - 1, 12) * 0.025, function()
			if not card.Parent then
				return
			end

			for _, image in ipairs(fadeImages) do
				if image and image.Parent then
					playTween(image, 0.3, {ImageTransparency = 0})
				end
			end

			for _, label in ipairs(fadeTexts) do
				if label and label.Parent then
					playTween(label, 0.3, {TextTransparency = 0})
				end
			end

			for _, chip in ipairs(fadeChips) do
				if chip and chip.Parent then
					playTween(chip, 0.3, {BackgroundTransparency = CHIP_BACKGROUND_TRANSPARENCY})
				end
			end
		end)
	end

	local function CreateInsertFeedback(thumbnail: GuiObject)
		local flash = Instance.new("Frame")
		flash.Name = generateName()
		flash.BackgroundColor3 = Color3.new(1, 1, 1)
		flash.BackgroundTransparency = 1
		flash.BorderSizePixel = 0
		flash.Size = UDim2.fromScale(1, 1)
		flash.Active = false
		flash.ZIndex = 3
		flash.Parent = thumbnail

		local flashCorner = Instance.new("UICorner")
		flashCorner.Name = generateName()
		flashCorner.CornerRadius = UDim.new(0, 5)
		flashCorner.Parent = flash

		local label = Instance.new("TextLabel")
		label.Name = generateName()
		label.AnchorPoint = Vector2.new(0.5, 0.5)
		label.Position = UDim2.fromScale(0.5, 0.5)
		label.Size = UDim2.new(1, -10, 0, 18)
		label.BackgroundTransparency = 1
		label.BorderSizePixel = 0
		label.Active = false
		label.ZIndex = 4
		label.Text = ""
		label.TextColor3 = Color3.new(1, 1, 1)
		label.TextSize = 10
		label.TextTransparency = 1
		label.TextStrokeColor3 = Color3.new(0, 0, 0)
		label.TextStrokeTransparency = 1
		label.Font = Enum.Font.GothamMedium
		label.TextTruncate = Enum.TextTruncate.AtEnd
		label.Parent = thumbnail

		local hideToken = 0

		label:GetPropertyChangedSignal("Text"):Connect(function()
			hideToken += 1
			local token = hideToken

			if label.Text == "" then
				playTween(label, 0.1, {TextTransparency = 1, TextStrokeTransparency = 1})
				return
			end

			playTween(label, 0.18, {TextTransparency = 0, TextStrokeTransparency = 0.5})

			if label.Text ~= "Working" then
				task.delay(1.4, function()
					if token ~= hideToken or not label.Parent then
						return
					end

					playTween(label, 0.3, {TextTransparency = 1, TextStrokeTransparency = 1})
				end)
			end
		end)

		local function Flash()
			flash.BackgroundTransparency = 0.6
			playTween(flash, 0.4, {BackgroundTransparency = 1})
		end

		return {Label = label, Flash = Flash}
	end

	local function RenderAsset(asset, index, view, animate)
		view = view or StoreView

		local scroller = view.Scroll
		local card = CardTemplate:Clone()
		card.Name = generateName()
		card.Visible = true
		card:SetAttribute("StoreAssetCard", true)
		card:SetAttribute("AssetId", asset.Id or asset.ID)
		card:SetAttribute("AssetCategory", asset.Category or CurrentCategory)
		card:SetAttribute("AssetName", tostring(asset.Name or ""))

		local clonedMore = card:FindFirstChild(MoreMenu.Name)

		if clonedMore then
			clonedMore:Destroy()
		end

		card.Parent = scroller

		local thumbnail = FindPart(card, ThumbnailTemplate)
		local nameLabel = FindPart(card, NameTemplate)
		local creatorLabel = FindPart(card, CreatorTemplate)
		local priceLabel = FindPart(card, PriceTemplate)
		local insertButton = FindPart(card, InsertButtonTemplate)

		if thumbnail and thumbnail:IsA("ImageLabel") then
			thumbnail.Image = asset.Thumbnail or ""
		end

		if nameLabel and nameLabel:IsA("TextLabel") then
			nameLabel.Text = asset.Name or "Unknown"
			SetTextTruncate(nameLabel)
		end

		if creatorLabel and creatorLabel:IsA("TextLabel") then
			creatorLabel.Text = asset.Creator or "Unknown"
			SetTextTruncate(creatorLabel)
		end

		if priceLabel and priceLabel:IsA("TextLabel") then
			priceLabel.Text = asset.PriceText or FormatSavedPrice(asset.Price)
			SetTextTruncate(priceLabel)
		end

		SetRatingVisual(card, asset.Rating)

		local bookmark = FindPart(card, BookmarkTemplate)

		if bookmark and (bookmark:IsA("ImageButton") or bookmark:IsA("ImageLabel")) then
			bookmark.ImageColor3 = ACTIVE_COLOR
			bookmark.Visible = IsAssetSaved(asset.Category or CurrentCategory, asset.Id)
		end

		if insertButton and insertButton:IsA("GuiButton") then
			local feedback = nil

			if thumbnail and thumbnail:IsA("GuiObject") then
				feedback = CreateInsertFeedback(thumbnail)

				bindInteraction(insertButton, thumbnail, {
					ImageTransparency = 0.15,
				}, {
					ImageTransparency = 0.4,
				})
			end

			if nameLabel then
				bindInteraction(insertButton, nameLabel, {
					TextColor3 = Color3.new(1, 1, 1),
				}, {
					TextColor3 = Color3.fromRGB(190, 210, 255),
				})
			end

			local inserting = false

			local function Trigger()
				if inserting then
					return
				end

				inserting = true

				local statusLabel = if feedback then feedback.Label else nil

				if feedback then
					feedback.Flash()
				end

				if statusLabel then
					statusLabel.Text = ""
				end

				task.spawn(function()
					local ok = pcall(InsertAsset, asset, statusLabel)

					if statusLabel and statusLabel.Parent and (not ok or statusLabel.Text == "Working") then
						statusLabel.Text = "Failed"
					end

					inserting = false
				end)
			end

			insertButton.InputBegan:Connect(function(inputObject)
				local inputType = inputObject.UserInputType

				if inputType ~= Enum.UserInputType.MouseButton1 and inputType ~= Enum.UserInputType.Touch then
					return
				end

				PressGeneration += 1
				local generation = PressGeneration

				ActivePress = {
					Input = inputObject,
					InputType = inputType,
					StartPosition = inputObject.Position,
					Generation = generation,
					Card = card,
					Asset = asset,
					Trigger = Trigger,
					CanvasStart = scroller.CanvasPosition.Y,
					Scroll = scroller,
					Held = false,
					Cancelled = false,
				}

				task.delay(HOLD_DURATION, function()
					local press = ActivePress

					if not press or press.Generation ~= generation or press.Held or press.Cancelled then
						return
					end

					if not card.Parent or not insertButton.Parent then
						ActivePress = nil
						return
					end

					if math.abs(scroller.CanvasPosition.Y - press.CanvasStart) > 3 then
						press.Cancelled = true
						return
					end

					press.Held = true
					ConfigureMore(asset, card)
				end)
			end)
		end

		if animate ~= false then
			AnimateCardIn(card, index)
		end

		return card
	end

	local function RenderAssets(assetList, append)
		if not append then
			ClearCards()
		end

		RenderToken += 1
		local token = RenderToken
		local total = #assetList
		local index = 1

		while index <= total do
			if token ~= RenderToken then
				return false
			end

			local last = math.min(index + RENDER_BATCH - 1, total)

			for i = index, last do
				RenderAsset(assetList[i], i)
			end

			index = last + 1

			if index <= total then
				task.wait()
			end
		end

		if token ~= RenderToken then
			return false
		end

		UpdateCanvas()

		return true
	end

	local function UpdateCategoryChecks()
		for categoryName, option in pairs(CategoryOptions) do
			local selected = categoryName == CurrentCategory
			local check = FindPart(option, OptionCheckTemplate)

			if check and check:IsA("ImageLabel") then
				check.Visible = selected
			end

			local info = CategoryControllers[categoryName]

			if info then
				info.Hover.BackgroundColor3 = lighten(info.Idle, selected and (OPTION_SELECTED_LIGHTEN + 0.08) or 0.1)
				info.Press.BackgroundColor3 = lighten(info.Idle, selected and (OPTION_SELECTED_LIGHTEN + 0.16) or 0.2)
				local baseColor = info.Idle

				if selected then
					baseColor = lighten(info.Idle, OPTION_SELECTED_LIGHTEN)
				end

				info.Controller.SetBase("BackgroundColor3", baseColor)
			end
		end

		Select.Text = CurrentCategory
	end

	local function UpdateArrow()
		playTween(Arrow, 0.2, {Rotation = DropdownOpen and 180 or 0})
	end

	local function SetCategoryVisible(visible: boolean)
		if visible then
			Category.Position = UDim2.new(
				CATEGORY_POSITION.X.Scale,
				CATEGORY_POSITION.X.Offset,
				CATEGORY_POSITION.Y.Scale,
				CATEGORY_POSITION.Y.Offset - 8
			)
			Category.Visible = true
			playTween(Category, 0.18, {Position = CATEGORY_POSITION})
		else
			playTween(Category, 0.15, {Position = UDim2.new(
				CATEGORY_POSITION.X.Scale,
				CATEGORY_POSITION.X.Offset,
				CATEGORY_POSITION.Y.Scale,
				CATEGORY_POSITION.Y.Offset - 8
			)}, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

			task.delay(0.16, function()
				if not DropdownOpen then
					Category.Visible = false
				end
			end)
		end
	end

	local function GetSavedQuery()
		return string.lower(string.match(tostring(Input.Text or ""), "^%s*(.-)%s*$") or "")
	end

	local function SavedMatchesQuery(saved, query)
		if query == "" then
			return true
		end

		local name = string.lower(tostring(saved.Name or ""))
		local creator = string.lower(tostring(saved.Creator or ""))

		return string.find(name, query, 1, true) ~= nil
			or string.find(creator, query, 1, true) ~= nil
	end

	local function MakeSavedAsset(saved, categoryName)
		local id = tostring(saved.ID or saved.Id or "")
		local thumbnail = tostring(saved.Thumbnail or "")

		if thumbnail == "" and id ~= "" then
			thumbnail = "https://www.roblox.com/asset-thumbnail/image?assetId=" .. id .. "&width=420&height=420&format=png"
		end

		local price = tonumber(saved.Price) or 0

		return {
			AssetTypeId = saved.AssetTypeId,
			Name = tostring(saved.Name or "Unknown"),
			Id = id,
			Link = GetAssetLink(id, saved.Name),
			Creator = tostring(saved.Creator or "Unknown"),
			Price = price,
			PriceText = saved.PriceText or FormatSavedPrice(price),
			Rating = tonumber(saved.Rating) or 0,
			Thumbnail = thumbnail,
			Category = categoryName,
		}
	end

	AddSavedCard = function(categoryName, saved, animIndex, animate)
		local key = tostring(saved.ID or saved.Id or "")

		if key == "" then
			return nil
		end

		local index = SavedCardIndex[categoryName]

		if not index then
			index = {}
			SavedCardIndex[categoryName] = index
		end

		local existing = index[key]

		if existing and existing.Parent then
			return existing
		end

		local asset = MakeSavedAsset(saved, categoryName)
		local card = RenderAsset(asset, animIndex or 1, SavedView, animate)

		card:SetAttribute("SavedAssetCard", true)
		card:SetAttribute("SearchName", string.lower(asset.Name))
		card:SetAttribute("SearchCreator", string.lower(asset.Creator))
		card.Visible = false

		index[key] = card

		return card
	end

	local function SetSavedCardsVisible(visible)
		for _, card in ipairs(SavedScroll:GetChildren()) do
			if card:GetAttribute("SavedAssetCard") then
				card.Visible = visible
			end
		end
	end

	RefreshSavedView = function(keepScroll)
		if not IsSavedMode then
			return
		end

		SavedSyncToken += 1
		local token = SavedSyncToken
		local categoryName = CurrentCategory
		local query = GetSavedQuery()
		local matches = {}

		for position, saved in ipairs(ReadSavedCategory(categoryName)) do
			if SavedMatchesQuery(saved, query) then
				table.insert(matches, {Saved = saved, Position = position})
			end
		end

		local total = #matches
		local limit = math.min(SavedLimit, total)
		local wanted = {}

		for i = 1, limit do
			wanted[tostring(matches[i].Saved.ID)] = matches[i].Position
		end

		local index = SavedCardIndex[categoryName]

		if not index then
			index = {}
			SavedCardIndex[categoryName] = index
		end

		CloseMore()

		for _, card in ipairs(SavedScroll:GetChildren()) do
			if card:GetAttribute("SavedAssetCard") then
				local position = nil

				if card:GetAttribute("AssetCategory") == categoryName then
					position = wanted[tostring(card:GetAttribute("AssetId"))]
				end

				local show = position ~= nil

				if show then
					card.LayoutOrder = position
				end

				if card.Visible ~= show then
					card.Visible = show
				end
			end
		end

		if not keepScroll then
			SavedScroll.CanvasPosition = Vector2.zero
		end

		UpdateGridLayout(SavedView)
		UpdateCanvas(SavedView)

		local created = 0

		for i = 1, limit do
			if token ~= SavedSyncToken or not IsSavedMode then
				return
			end

			local entry = matches[i]
			local key = tostring(entry.Saved.ID)
			local existing = index[key]

			if not (existing and existing.Parent) then
				local card = AddSavedCard(categoryName, entry.Saved, created + 1, true)

				if card then
					card.LayoutOrder = entry.Position
					card.Visible = true
					created += 1

					if created % RENDER_BATCH == 0 and i < limit then
						UpdateCanvas(SavedView)
						task.wait()
					end
				end
			end
		end

		if token ~= SavedSyncToken or not IsSavedMode then
			return
		end

		Loadmore.Visible = limit < total
		UpdateGridLayout(SavedView)
		UpdateCanvas(SavedView)
		UpdateStatus(limit)
	end

	local function FilterSavedAssets(keyword)
		if not IsSavedMode or IsLoading then
			return
		end

		local query = GetSavedQuery()

		if query ~= SavedActiveQuery then
			SavedActiveQuery = query
			SavedLimit = SAVED_PAGE_SIZE
			RefreshSavedView(false)
		else
			RefreshSavedView(true)
		end
	end

	local function ShowSavedAssets()
		SearchGeneration += 1
		local generation = SearchGeneration
		local categoryName = CurrentCategory

		CurrentPageToken = nil
		Loadmore.Visible = false
		CloseMore()
		ClearSkeletons()

		SavedLimit = SAVED_PAGE_SIZE
		SavedActiveQuery = GetSavedQuery()

		local savedList = ReadSavedCategory(categoryName)
		local index = SavedCardIndex[categoryName]
		local needsBuild = false

		for position = 1, math.min(#savedList, SAVED_PAGE_SIZE) do
			local card = index and index[tostring(savedList[position].ID)]

			if not (card and card.Parent) then
				needsBuild = true
				break
			end
		end

		if not needsBuild then
			IsLoading = false
			RefreshSavedView(false)
			return
		end

		IsLoading = true
		SetSavedCardsVisible(false)
		SavedScroll.CanvasPosition = Vector2.zero
		ShowSkeletons(math.min(#savedList, SAVED_PAGE_SIZE), SavedView)
		Status.Text = categoryName .. " / Loading saved assets..."

		task.spawn(function()
			WaitForShimmer()

			if generation ~= SearchGeneration or not IsSavedMode then
				return
			end

			ClearSkeletons()
			IsLoading = false
			RefreshSavedView(false)
		end)
	end

	local StoreSnapshot = {Token = nil, Category = CurrentCategory, Pending = false}

	local SearchSuggestionController = {
		Limit = 5,
		ItemHeight = 22,
		FramePadding = 6,
		HistoryLimit = 30,
		MaxLength = 60,
		Position = SuggestionsDropdown.Position,
		History = {},
		Visible = false,
		ProgrammaticText = nil,
		ProgrammaticAt = 0,
		Seeds = {
			Model = {"car", "house", "tree", "sword", "city", "map", "tycoon", "tower", "castle", "airplane"},
			Plugin = {"building tools", "terrain", "animation", "gui", "script", "lighting", "modeling", "ui kit", "rig", "weld"},
			Audio = {"music", "phonk", "lofi", "sound effect", "explosion", "footsteps", "ambient", "jumpscare", "sfx", "piano"},
			Decal = {"grass", "brick", "wood", "sky", "cloud", "logo", "face", "graffiti", "metal", "stone"},
			Meshes = {"sword", "gun", "tree", "rock", "car", "building", "character", "weapon", "chair", "door"},
			Images = {"icon", "background", "logo", "pattern", "texture", "ui", "button", "sky", "anime", "wallpaper"},
			Video = {"intro", "animation", "trailer", "meme", "loop", "background", "gameplay", "clip", "anime", "music video"},
			Material = {"wood", "metal", "stone", "grass", "brick", "fabric", "sand", "concrete", "ice", "marble"},
		},
	}

	function SearchSuggestionController.Normalize(text)
		return string.match(tostring(text or ""), "^%s*(.-)%s*$") or ""
	end

	function SearchSuggestionController.Escape(text)
		local escaped = string.gsub(text, "&", "&amp;")
		escaped = string.gsub(escaped, "<", "&lt;")
		escaped = string.gsub(escaped, ">", "&gt;")

		return escaped
	end

	function SearchSuggestionController.Record(keyword, categoryName)
		local clean = SearchSuggestionController.Normalize(keyword)

		if clean == "" or #clean > SearchSuggestionController.MaxLength then
			return
		end

		local history = SearchSuggestionController.History[categoryName]

		if not history then
			history = {}
			SearchSuggestionController.History[categoryName] = history
		end

		local lowered = string.lower(clean)

		for index = #history, 1, -1 do
			if string.lower(history[index]) == lowered then
				table.remove(history, index)
			end
		end

		table.insert(history, 1, clean)

		while #history > SearchSuggestionController.HistoryLimit do
			table.remove(history)
		end
	end

	function SearchSuggestionController.Collect(query)
		local controller = SearchSuggestionController
		local results = {}
		local seen = {[query] = true}

		local function add(text, priority)
			if type(text) ~= "string" then
				return
			end

			local clean = controller.Normalize(text)

			if clean == "" or #clean > controller.MaxLength then
				return
			end

			local lowered = string.lower(clean)

			if seen[lowered] then
				return
			end

			local start = string.find(lowered, query, 1, true)

			if not start then
				return
			end

			local rank = 3

			if start == 1 then
				rank = 1
			elseif string.sub(lowered, start - 1, start - 1) == " " then
				rank = 2
			end

			seen[lowered] = true
			table.insert(results, {
				Text = clean,
				Start = start,
				Rank = rank,
				Priority = priority,
				Order = #results,
			})
		end

		if IsSavedMode then
			for _, saved in ipairs(ReadSavedCategory(CurrentCategory)) do
				add(saved.Name, 1)
			end
		else
			for _, text in ipairs(controller.History[CurrentCategory] or {}) do
				add(text, 1)
			end

			for _, card in ipairs(ScrollingFrame:GetChildren()) do
				if card:GetAttribute("StoreAssetCard") and card:GetAttribute("AssetCategory") == CurrentCategory then
					add(card:GetAttribute("AssetName"), 2)
				end
			end

			for _, text in ipairs(controller.Seeds[CurrentCategory] or {}) do
				add(text, 3)
			end
		end

		table.sort(results, function(a, b)
			if a.Rank ~= b.Rank then
				return a.Rank < b.Rank
			end

			if a.Priority ~= b.Priority then
				return a.Priority < b.Priority
			end

			return a.Order < b.Order
		end)

		while #results > controller.Limit do
			table.remove(results)
		end

		return results
	end

	function SearchSuggestionController.Clear()
		for _, child in ipairs(SuggestionsDropdown:GetChildren()) do
			if child ~= SuggestionItemTemplate and child:GetAttribute("SuggestionClone") then
				child:Destroy()
			end
		end
	end

	function SearchSuggestionController.Hide()
		SearchSuggestionController.Visible = false
		SuggestionsDropdown.Visible = false
		SearchSuggestionController.Clear()
	end

	function SearchSuggestionController.SetText(text)
		SearchSuggestionController.ProgrammaticText = text
		SearchSuggestionController.ProgrammaticAt = os.clock()
		Input.Text = text
	end

	function SearchSuggestionController.Pick(text)
		SearchSuggestionController.SetText(text)
		SearchSuggestionController.Hide()

		task.defer(function()
			pcall(function()
				Input:CaptureFocus()
				Input.CursorPosition = #Input.Text + 1
			end)
		end)
	end

	function SearchSuggestionController.UpdateWidth()
		local width = SearchBox.AbsoluteSize.X

		if width <= 0 then
			width = SearchBox.Size.X.Offset
		end

		SuggestionsDropdown.Size = UDim2.fromOffset(width, SuggestionsDropdown.Size.Y.Offset)
	end

	function SearchSuggestionController.Refresh()
		local controller = SearchSuggestionController

		if not Input:IsFocused() then
			controller.Hide()
			return
		end

		local query = string.lower(controller.Normalize(Input.Text))

		if query == "" then
			controller.Hide()
			return
		end

		local results = controller.Collect(query)

		if #results == 0 then
			controller.Hide()
			return
		end

		controller.Clear()

		for index, entry in ipairs(results) do
			local item = SuggestionItemTemplate:Clone()

			item.Name = generateName()
			item.LayoutOrder = index
			item.Visible = true
			item:SetAttribute("SuggestionClone", true)

			local label = FindPart(item, SuggestionTextTemplate)

			if label and label:IsA("TextLabel") then
				local before = string.sub(entry.Text, 1, entry.Start - 1)
				local matched = string.sub(entry.Text, entry.Start, entry.Start + #query - 1)
				local after = string.sub(entry.Text, entry.Start + #query)

				label.RichText = true
				label.Text = controller.Escape(before)
					.. '<font color="#FFFFFF">' .. controller.Escape(matched) .. "</font>"
					.. controller.Escape(after)
				SetTextTruncate(label)
			end

			item.Parent = SuggestionsDropdown

			bindInteraction(item, item, {
				BackgroundColor3 = lighten(item.BackgroundColor3, 0.1),
			}, {
				BackgroundColor3 = lighten(item.BackgroundColor3, 0.2),
			})

			item.InputBegan:Connect(function(inputObject)
				if isPointerInput(inputObject) then
					controller.Pick(entry.Text)
				end
			end)
		end

		local width = SearchBox.AbsoluteSize.X

		if width <= 0 then
			width = SearchBox.Size.X.Offset
		end

		SuggestionsDropdown.Size = UDim2.fromOffset(width, controller.FramePadding + #results * controller.ItemHeight)

		if not SuggestionsDropdown.Visible then
			SuggestionsDropdown.Position = UDim2.new(
				controller.Position.X.Scale,
				controller.Position.X.Offset,
				controller.Position.Y.Scale,
				controller.Position.Y.Offset - 4
			)
			SuggestionsDropdown.Visible = true
			playTween(SuggestionsDropdown, 0.15, {Position = controller.Position})
		end

		controller.Visible = true
	end

	function SearchSuggestionController.OnTextChanged()
		local controller = SearchSuggestionController

		if controller.ProgrammaticText ~= nil
			and Input.Text == controller.ProgrammaticText
			and os.clock() - controller.ProgrammaticAt < 0.5 then
			controller.ProgrammaticText = nil
			return
		end

		controller.ProgrammaticText = nil
		controller.Refresh()
	end

	local function Search()
		SearchSuggestionController.Hide()

		if IsSavedMode then
			FilterSavedAssets(Input.Text)
			return
		end

		if IsLoading and Input.Text == CurrentKeyword then
			return
		end

		CurrentKeyword = Input.Text
		SearchSuggestionController.Record(CurrentKeyword, CurrentCategory)
		CurrentPageToken = nil
		SearchGeneration += 1

		local generation = SearchGeneration
		local categoryName = CurrentCategory
		local keyword = CurrentKeyword

		ClearCards()
		Loadmore.Visible = false
		IsLoading = true
		ShowSkeletons(MAX_PAGE_SIZE)
		Status.Text = categoryName .. " / Searching..."

		task.spawn(function()
			local page, err = RequestPage(keyword, categoryName, nil)

			if generation ~= SearchGeneration then
				return
			end

			if not page then
				IsLoading = false
				ClearSkeletons()
				Status.Text = categoryName .. " / Failed to load (" .. tostring(err) .. ")"
				return
			end

			WaitForShimmer()

			if generation ~= SearchGeneration then
				return
			end

			IsLoading = false
			ClearSkeletons()

			for _, asset in ipairs(page.Assets) do
				asset.Category = categoryName
			end

			CurrentPageToken = page.NextPageToken

			if not RenderAssets(page.Assets, true) or generation ~= SearchGeneration then
				return
			end

			Loadmore.Visible = CurrentPageToken ~= nil and CurrentPageToken ~= ""
			UpdateStatus(GetLoadedAssetCount())
		end)
	end

	local function LoadMoreAssets()

		if IsSavedMode then
			if IsLoading then
				return
			end

			SavedLimit += SAVED_PAGE_SIZE
			RefreshSavedView(true)

			return
		end

		if IsLoading or not CurrentPageToken then
			return
		end

		local function ResetLoadmoreButton()
			LoadmoreButton.Active = true
			LoadmoreButton.Text = "Loadmore"
		end

		IsLoading = true
		LoadmoreButton.Active = false
		LoadmoreButton.Text = "Loading..."
		ShowSkeletons(MAX_PAGE_SIZE)

		local generation = SearchGeneration
		local categoryName = CurrentCategory
		local page, err = RequestPage(CurrentKeyword, categoryName, CurrentPageToken)

		if generation ~= SearchGeneration then
			ResetLoadmoreButton()
			return
		end

		if not page then
			IsLoading = false
			ClearSkeletons()
			ResetLoadmoreButton()
			UpdateStatus(GetLoadedAssetCount())
			return
		end

		WaitForShimmer()

		if generation ~= SearchGeneration then
			ResetLoadmoreButton()
			return
		end

		IsLoading = false
		ClearSkeletons()
		ResetLoadmoreButton()

		for _, asset in ipairs(page.Assets) do
			asset.Category = categoryName
		end

		CurrentPageToken = page.NextPageToken

		if not RenderAssets(page.Assets, true) or generation ~= SearchGeneration then
			return
		end

		Loadmore.Visible = CurrentPageToken ~= nil and CurrentPageToken ~= ""
		UpdateStatus(GetLoadedAssetCount())
	end

	local function CreateCategoryOptions()
		for _, child in ipairs(ScrollCategory:GetChildren()) do
			if child ~= OptionTemplate and child:IsA("GuiButton") then
				child:Destroy()
			end
		end

		table.clear(CategoryOptions)
		table.clear(CategoryControllers)

		for _, categoryName in ipairs(Categories) do
			local option = OptionTemplate:Clone()
			option.Name = generateName()
			option.Visible = true
			option.Parent = ScrollCategory

			local item = FindPart(option, OptionItemTemplate)
			local check = FindPart(option, OptionCheckTemplate)

			if item and item:IsA("TextLabel") then
				item.Text = categoryName
				SetTextTruncate(item)
			end

			if check and check:IsA("ImageLabel") then
				check.Visible = categoryName == CurrentCategory
			end

			CategoryOptions[categoryName] = option

			if option:IsA("GuiButton") then
				local idleColor = option.BackgroundColor3
				local hoverGoal = {BackgroundColor3 = lighten(idleColor, 0.1)}
				local pressGoal = {BackgroundColor3 = lighten(idleColor, 0.2)}
				local controller = bindInteraction(option, option, hoverGoal, pressGoal)

				CategoryControllers[categoryName] = {
					Controller = controller,
					Hover = hoverGoal,
					Press = pressGoal,
					Idle = idleColor,
				}

				option.Activated:Connect(function()
					CurrentCategory = categoryName
					SearchSuggestionController.Hide()
					DropdownOpen = false
					SetCategoryVisible(false)
					UpdateCategoryChecks()
					UpdateArrow()
					SearchGeneration += 1
					CurrentPageToken = nil
					Loadmore.Visible = false
					IsLoading = false
					ClearSkeletons()

					if IsSavedMode then
						ShowSavedAssets()
					else
						UpdateStatus(GetLoadedAssetCount())
					end
				end)
			end
		end

		UpdateCategoryChecks()
	end

	for _, button in ipairs({CopyIdButton, CopyLinkButton, SaveAssetButton}) do
		button.TextTruncate = Enum.TextTruncate.AtEnd
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextWrapped = false
		button.TextSize = 12
		button.Font = Enum.Font.GothamMedium

		bindInteraction(button, button, {
			BackgroundColor3 = lighten(button.BackgroundColor3, 0.1),
		}, {
			BackgroundColor3 = lighten(button.BackgroundColor3, 0.2),
		})
	end

	CopyIdButton.Activated:Connect(function()
		if ActiveAsset then
			CopyText(ActiveAsset.Id)
		end

		CloseMore()
	end)

	CopyLinkButton.Activated:Connect(function()
		if ActiveAsset then
			CopyText(ActiveAsset.Link)
		end

		CloseMore()
	end)

	SaveAssetButton.Activated:Connect(function()
		if ActiveAsset then
			ToggleSaveAsset(ActiveAsset, ActiveCard)
		end

		CloseMore()
	end)

	Dropdown.Activated:Connect(function()
		DropdownOpen = not DropdownOpen
		SetCategoryVisible(DropdownOpen)
		UpdateArrow()
	end)

	SearchBtn.Activated:Connect(Search)

	Input.FocusLost:Connect(function(enterPressed)
		playTween(SearchBoxStroke, 0.15, {Color = searchStrokeIdleColor, Thickness = searchStrokeIdleThickness})

		if enterPressed then
			Search()
		end

		task.delay(0.2, function()
			if not Input:IsFocused() then
				SearchSuggestionController.Hide()
			end
		end)
	end)

	Input.Focused:Connect(function()
		playTween(SearchBoxStroke, 0.15, {Color = SEARCH_FOCUS_COLOR, Thickness = SEARCH_FOCUS_THICKNESS})
	end)

	local FilterToken = 0

	SearchBox:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if SearchSuggestionController.Visible then
			SearchSuggestionController.UpdateWidth()
		end
	end)

	Input:GetPropertyChangedSignal("Text"):Connect(function()
		SearchSuggestionController.OnTextChanged()

		if IsSavedMode then
			FilterToken += 1
			local token = FilterToken

			task.delay(0.18, function()
				if token == FilterToken then
					FilterSavedAssets(Input.Text)
				end
			end)
		end
	end)

	LoadmoreButton.Activated:Connect(LoadMoreAssets)

	SaveBtn.Activated:Connect(function()
		if not IsSavedMode then
			StoreSnapshot.Token = CurrentPageToken
			StoreSnapshot.Category = CurrentCategory
			StoreSnapshot.Pending = IsLoading and CurrentPageToken == nil and CurrentKeyword ~= ""
		end

		IsSavedMode = not IsSavedMode
		playTween(SaveBtn, 0.2, {ImageColor3 = IsSavedMode and ACTIVE_COLOR or INACTIVE_COLOR})
		SearchGeneration += 1
		CurrentPageToken = nil
		Loadmore.Visible = false
		IsLoading = false
		CloseMore()
		ClearSkeletons()
		SearchSuggestionController.Hide()

		if IsSavedMode then
			SearchSuggestionController.SetText("")
			ScrollingFrame.Visible = false
			SavedScroll.Visible = true
			ShowSavedAssets()
		else
			SavedScroll.Visible = false
			ScrollingFrame.Visible = true
			SearchSuggestionController.SetText(CurrentKeyword)

			if StoreSnapshot.Pending then
				StoreSnapshot.Pending = false
				Search()
			else
				if StoreSnapshot.Category == CurrentCategory then
					CurrentPageToken = StoreSnapshot.Token
				end

				Loadmore.Visible = CurrentPageToken ~= nil and CurrentPageToken ~= ""
				UpdateCanvas(StoreView)
				UpdateStatus(GetLoadedAssetCount())
			end
		end
	end)

	GridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		UpdateCanvas(StoreView)
	end)
	SavedGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		UpdateCanvas(SavedView)
	end)
	ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		UpdateGridLayout(StoreView)
	end)
	SavedScroll:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		UpdateGridLayout(SavedView)
	end)
	Loadmore:GetPropertyChangedSignal("Visible"):Connect(function()
		UpdateCanvas(StoreView)
		UpdateCanvas(SavedView)
	end)
	UpdateGridLayout(StoreView)
	UpdateGridLayout(SavedView)

	do
		local storeGui = GUI["GUI_ScreenGui"] :: ScreenGui
		storeGui.Destroying:Connect(ClearSkeletons)
	end

	local GuiService = game:GetService("GuiService")

	local function IsInputInside(gui: GuiObject, inputObject: InputObject): boolean
		local raw = Vector2.new(inputObject.Position.X, inputObject.Position.Y)
		local inset = Vector2.zero

		pcall(function()
			local topLeft = GuiService:GetGuiInset()
			inset = topLeft
		end)

		local guiPosition = gui.AbsolutePosition
		local guiSize = gui.AbsoluteSize

		for _, point in ipairs({raw, raw + inset}) do
			if point.X >= guiPosition.X and point.X <= guiPosition.X + guiSize.X
				and point.Y >= guiPosition.Y and point.Y <= guiPosition.Y + guiSize.Y then
				return true
			end
		end

		return false
	end

	ConnectInput(UserInputService.InputBegan, function(inputObject)
		if not isPointerInput(inputObject) then
			return
		end

		if MoreMenu.Visible and not IsInputInside(MoreMenu, inputObject) then
			CloseMore()
		end

		if SearchSuggestionController.Visible
			and not IsInputInside(SuggestionsDropdown, inputObject)
			and not IsInputInside(SearchBox, inputObject) then
			SearchSuggestionController.Hide()
		end
	end)

	ConnectInput(UserInputService.InputChanged, function(inputObject)
		local press = ActivePress

		if not press or press.Held or press.Cancelled then
			return
		end

		local isRelevantMovement =
			(press.InputType == Enum.UserInputType.Touch and inputObject == press.Input)
			or (press.InputType == Enum.UserInputType.MouseButton1
				and inputObject.UserInputType == Enum.UserInputType.MouseMovement)

		if not isRelevantMovement then
			return
		end

		local startPosition = press.StartPosition
		local currentPosition = inputObject.Position

		if startPosition and currentPosition then
			local delta = currentPosition - startPosition

			if math.abs(delta.X) > 6 or math.abs(delta.Y) > 6 then
				press.Cancelled = true
			end
		end
	end)

	ConnectInput(UserInputService.InputEnded, function(inputObject)
		local press = ActivePress

		if not press then
			return
		end

		local sameInput = press.InputType == Enum.UserInputType.MouseButton1
			and inputObject.UserInputType == Enum.UserInputType.MouseButton1
			or press.Input == inputObject

		if not sameInput then
			return
		end

		ActivePress = nil

		local pressScroll = press.Scroll or ScrollingFrame
		local scrolled = math.abs(pressScroll.CanvasPosition.Y - press.CanvasStart) > 3

		if not press.Held and not press.Cancelled and not scrolled and press.Card and press.Card.Parent then
			if press.Trigger then
				press.Trigger()
			else
				task.spawn(InsertAsset, press.Asset)
			end
		end
	end)

	bindInteraction(SearchBtn, SearchBtn, {
		ImageTransparency = 0.2,
	}, {
		ImageTransparency = 0.45,
	})

	bindInteraction(SaveBtn, SaveBtn, {
		BackgroundColor3 = lighten(SaveBtn.BackgroundColor3, 0.12),
		ImageTransparency = 0.15,
	}, {
		BackgroundColor3 = lighten(SaveBtn.BackgroundColor3, 0.24),
		ImageTransparency = 0.35,
	})

	bindInteraction(Dropdown, Dropdown, {
		BackgroundColor3 = lighten(Dropdown.BackgroundColor3, 0.1),
	}, {
		BackgroundColor3 = lighten(Dropdown.BackgroundColor3, 0.2),
	})

	bindInteraction(Dropdown, DropdownStroke, {
		Color = Color3.fromRGB(60, 60, 60),
	}, {
		Color = DROPDOWN_PRESS_COLOR,
	})

	bindInteraction(LoadmoreButton, LoadmoreButton, {
		BackgroundColor3 = lighten(LoadmoreButton.BackgroundColor3, 0.1),
	}, {
		BackgroundColor3 = lighten(LoadmoreButton.BackgroundColor3, 0.2),
	})

	CreateCategoryOptions()
	UpdateArrow()
	SaveBtn.ImageColor3 = INACTIVE_COLOR
	Select.Text = CurrentCategory
	UpdateStatus(0)
	EnsureStoreFolder()
end

buildInterface()

task.spawn(initializeMainSystem)
task.spawn(initializeStoreSystem)

return GUI
