-- LUCIDE ICONS-NARS ENDEAVOR PLUGIN
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local GUI_NAME = "LucideXnars Icons"
local ICONS_URL = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"
local LOADING_ICON_ID = "rbxassetid://78408734580845"

-- Clear existing GUI
local oldGui = CoreGui:FindFirstChild(GUI_NAME)
if oldGui then
	oldGui:Destroy()
end

local function getParent()
	if gethui then
		return gethui()
	end
	return CoreGui
end

-- Main GUI Setup
local Gui = Instance.new("ScreenGui")
Gui.Name = GUI_NAME
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = getParent()

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(270, 310)
Main.Position = UDim2.new(0.5, -135, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

-- 1. UI SHADOW PADA PANEL (Tanpa UIStroke border)
local UIShadow = Instance.new("UIStroke")
UIShadow.Name = "UIShadow"
UIShadow.ZIndex = -1
pcall(function()
	UIShadow.BlurRadius = UDim.new(0, 12)
	UIShadow.Offset = UDim2.fromOffset(0, 4)
	UIShadow.Spread = UDim2.fromScale(0, 0)
end)
UIShadow.Color = Color3.fromRGB(0, 0, 0)
UIShadow.Enabled = true
UIShadow.Transparency = 0.5
UIShadow.Parent = Main

-- Header Section
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundTransparency = 1
Header.Parent = Main

-- Posisi Menu Button di kiri sebelum logo
local MenuButton = Instance.new("ImageButton")
MenuButton.Name = "MenuButton"
MenuButton.Size = UDim2.fromOffset(18, 18)
MenuButton.Position = UDim2.fromOffset(12, 15)
MenuButton.BackgroundTransparency = 1
MenuButton.Image = "rbxassetid://77021539815611"
MenuButton.ImageColor3 = Color3.fromRGB(235, 240, 248)
MenuButton.Parent = Header

-- Size Logo diperbesar dikit
local HeaderIcon = Instance.new("ImageLabel")
HeaderIcon.Name = "Icon"
HeaderIcon.Size = UDim2.fromOffset(28, 28)
HeaderIcon.Position = UDim2.fromOffset(36, 10)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Image = "rbxassetid://130721982350900"
HeaderIcon.ImageColor3 = Color3.fromRGB(235, 240, 248)
HeaderIcon.Parent = Header

local TitleHolder = Instance.new("Frame")
TitleHolder.Name = "TitleHolder"
TitleHolder.Size = UDim2.new(1, -110, 1, 0)
TitleHolder.Position = UDim2.fromOffset(70, 0)
TitleHolder.BackgroundTransparency = 1
TitleHolder.Parent = Header

-- 4. TITLE & SUBTITLE KONSISTEN
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 14)
Title.Position = UDim2.fromOffset(0, 12)
Title.BackgroundTransparency = 1
Title.Text = "LUCIDE ICONS"
Title.TextColor3 = Color3.fromRGB(235, 240, 248)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleHolder

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Size = UDim2.new(1, 0, 0, 12)
SubTitle.Position = UDim2.fromOffset(0, 24)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Nars' Edv"
SubTitle.TextColor3 = Color3.fromRGB(140, 145, 160)
SubTitle.TextSize = 9
SubTitle.Font = Enum.Font.GothamMedium
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = TitleHolder

-- Header Action Buttons
local CloseButton = Instance.new("ImageButton")
CloseButton.Name = "Close"
CloseButton.Size = UDim2.fromOffset(18, 18)
CloseButton.Position = UDim2.new(1, -30, 0, 15)
CloseButton.BackgroundTransparency = 1
CloseButton.Image = "rbxassetid://75539660682193"
CloseButton.ImageColor3 = Color3.fromRGB(235, 240, 248)
CloseButton.Parent = Header

-- Content Section
local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -104)
Content.Position = UDim2.fromOffset(10, 48)
Content.BackgroundTransparency = 1
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 2
Content.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
Content.CanvasSize = UDim2.new()
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollingDirection = Enum.ScrollingDirection.Y
Content.Parent = Main

local Grid = Instance.new("UIGridLayout")
Grid.CellSize = UDim2.fromOffset(42, 42)
Grid.CellPadding = UDim2.fromOffset(8, 8)
Grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
Grid.SortOrder = Enum.SortOrder.LayoutOrder
Grid.Parent = Content

-- Search Section
local SearchHolder = Instance.new("Frame")
SearchHolder.Name = "SearchHolder"
SearchHolder.Size = UDim2.new(1, -24, 0, 36)
SearchHolder.Position = UDim2.new(0, 12, 1, -46)
SearchHolder.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
SearchHolder.BorderSizePixel = 0
SearchHolder.Parent = Main

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchHolder

local SearchShadow = Instance.new("UIStroke")
SearchShadow.Color = Color3.fromRGB(45, 45, 60)
SearchShadow.Transparency = 0.5
SearchShadow.Thickness = 1
SearchShadow.Parent = SearchHolder

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Name = "Icon"
SearchIcon.Size = UDim2.fromOffset(16, 16)
SearchIcon.Position = UDim2.fromOffset(10, 10)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = "rbxassetid://92345384671606"
SearchIcon.ImageColor3 = Color3.fromRGB(160, 165, 180)
SearchIcon.Parent = SearchHolder

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "Search"
SearchBox.Size = UDim2.new(1, -38, 1, 0)
SearchBox.Position = UDim2.fromOffset(32, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.ClearTextOnFocus = false
SearchBox.PlaceholderText = "Search lucide Icons..."
SearchBox.PlaceholderColor3 = Color3.fromRGB(110, 115, 130)
SearchBox.Text = ""
SearchBox.TextColor3 = Color3.fromRGB(235, 240, 248)
SearchBox.TextSize = 11.5
SearchBox.Font = Enum.Font.GothamMedium
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchHolder

-- Loading Overlay Section
local LoadingOverlay = Instance.new("Frame")
LoadingOverlay.Name = "LoadingOverlay"
LoadingOverlay.Size = UDim2.new(1, 0, 1, -104)
LoadingOverlay.Position = UDim2.fromOffset(0, 48)
LoadingOverlay.BackgroundTransparency = 1
LoadingOverlay.ZIndex = 15
LoadingOverlay.Parent = Main

local LoadingContainer = Instance.new("Frame")
LoadingContainer.Name = "LoadingContainer"
LoadingContainer.Size = UDim2.fromOffset(100, 70)
LoadingContainer.Position = UDim2.new(0.5, -50, 0.5, -35)
LoadingContainer.BackgroundTransparency = 1
LoadingContainer.ZIndex = 16
LoadingContainer.Parent = LoadingOverlay

local LoadingSpinner = Instance.new("ImageLabel")
LoadingSpinner.Name = "Spinner"
LoadingSpinner.Size = UDim2.fromOffset(32, 32)
LoadingSpinner.Position = UDim2.new(0.5, -16, 0, 0)
LoadingSpinner.BackgroundTransparency = 1
LoadingSpinner.Image = LOADING_ICON_ID
LoadingSpinner.ImageColor3 = Color3.fromRGB(235, 240, 248)
LoadingSpinner.ZIndex = 17
LoadingSpinner.Parent = LoadingContainer

local LoadingText = Instance.new("TextLabel")
LoadingText.Name = "Text"
LoadingText.Size = UDim2.new(1, 0, 0, 16)
LoadingText.Position = UDim2.new(0, 0, 1, -18)
LoadingText.BackgroundTransparency = 1
LoadingText.Text = "LOADING..."
LoadingText.TextColor3 = Color3.fromRGB(235, 240, 248)
LoadingText.TextSize = 10
LoadingText.Font = Enum.Font.GothamBold
LoadingText.ZIndex = 17
LoadingText.Parent = LoadingContainer

local spinConnection
spinConnection = RunService.RenderStepped:Connect(function(delta)
	if LoadingSpinner and LoadingSpinner.Parent then
		LoadingSpinner.Rotation = (LoadingSpinner.Rotation + delta * 90) % 360
	else
		spinConnection:Disconnect()
	end
end)

local pulseTweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
local pulseSpinnerTween = TweenService:Create(LoadingSpinner, pulseTweenInfo, {ImageTransparency = 0.6})
local pulseTextTween = TweenService:Create(LoadingText, pulseTweenInfo, {TextTransparency = 0.6})

pulseSpinnerTween:Play()
pulseTextTween:Play()

-- 2. DETAIL VIEW SECTION (Konsisten)
local Detail = Instance.new("Frame")
Detail.Name = "Detail"
Detail.Size = UDim2.new(1, -24, 0, 120)
Detail.Position = UDim2.new(0, 12, 0.5, -60)
Detail.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Detail.BorderSizePixel = 0
Detail.Visible = false
Detail.ZIndex = 20
Detail.Parent = Main

local DetailCorner = Instance.new("UICorner")
DetailCorner.CornerRadius = UDim.new(0, 10)
DetailCorner.Parent = Detail

local DetailShadow = Instance.new("UIStroke")
DetailShadow.Color = Color3.fromRGB(45, 45, 60)
DetailShadow.Transparency = 0.4
DetailShadow.Thickness = 1
DetailShadow.Parent = Detail

local DetailPreview = Instance.new("ImageLabel")
DetailPreview.Name = "Preview"
DetailPreview.Size = UDim2.fromOffset(40, 40)
DetailPreview.Position = UDim2.fromOffset(12, 12)
DetailPreview.BackgroundTransparency = 1
DetailPreview.ImageColor3 = Color3.fromRGB(235, 240, 248)
DetailPreview.ZIndex = 21
DetailPreview.Parent = Detail

local DetailName = Instance.new("TextLabel")
DetailName.Name = "Name"
DetailName.Size = UDim2.new(1, -95, 0, 18)
DetailName.Position = UDim2.fromOffset(60, 12)
DetailName.BackgroundTransparency = 1
DetailName.TextColor3 = Color3.fromRGB(235, 240, 248)
DetailName.TextSize = 12.5
DetailName.Font = Enum.Font.GothamBold
DetailName.TextXAlignment = Enum.TextXAlignment.Left
DetailName.TextTruncate = Enum.TextTruncate.AtEnd
DetailName.ZIndex = 21
DetailName.Parent = Detail

local DetailID = Instance.new("TextLabel")
DetailID.Name = "ID"
DetailID.Size = UDim2.new(1, -95, 0, 16)
DetailID.Position = UDim2.fromOffset(60, 32)
DetailID.BackgroundTransparency = 1
DetailID.TextColor3 = Color3.fromRGB(140, 145, 160)
DetailID.TextSize = 10.5
DetailID.Font = Enum.Font.GothamMedium
DetailID.TextXAlignment = Enum.TextXAlignment.Left
DetailID.TextTruncate = Enum.TextTruncate.AtEnd
DetailID.ZIndex = 21
DetailID.Parent = Detail

local CopyButton = Instance.new("TextButton")
CopyButton.Name = "CopyID"
CopyButton.Size = UDim2.new(1, -24, 0, 32)
CopyButton.Position = UDim2.new(0, 12, 1, -44)
CopyButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
CopyButton.BorderSizePixel = 0
CopyButton.Text = "COPY ID"
CopyButton.TextColor3 = Color3.fromRGB(235, 240, 248)
CopyButton.TextSize = 11.5
CopyButton.Font = Enum.Font.GothamBold
CopyButton.ZIndex = 21
CopyButton.Parent = Detail

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 6)
CopyCorner.Parent = CopyButton

local CopyShadow = Instance.new("UIStroke")
CopyShadow.Color = Color3.fromRGB(55, 55, 75)
CopyShadow.Transparency = 0.5
CopyShadow.Thickness = 1
CopyShadow.Parent = CopyButton

local CopyBtnIcon = Instance.new("ImageLabel")
CopyBtnIcon.Name = "CopyIcon"
CopyBtnIcon.Size = UDim2.fromOffset(14, 14)
CopyBtnIcon.Position = UDim2.new(0, 10, 0.5, -7)
CopyBtnIcon.BackgroundTransparency = 1
CopyBtnIcon.Image = "rbxassetid://78979572434545"
CopyBtnIcon.ImageColor3 = Color3.fromRGB(235, 240, 248)
CopyBtnIcon.ZIndex = 22
CopyBtnIcon.Parent = CopyButton

local DetailClose = Instance.new("ImageButton")
DetailClose.Name = "Close"
DetailClose.Size = UDim2.fromOffset(14, 14)
DetailClose.Position = UDim2.new(1, -22, 0, 10)
DetailClose.BackgroundTransparency = 1
DetailClose.Image = "rbxassetid://75539660682193"
DetailClose.ImageColor3 = Color3.fromRGB(140, 145, 160)
DetailClose.ZIndex = 21
DetailClose.Parent = Detail

-- 3. FLOATING TAG (TextTruncate = End dengan Max Width)
local HoverTag = Instance.new("Frame")
HoverTag.Name = "HoverTag"
HoverTag.Size = UDim2.fromOffset(100, 20)
HoverTag.Position = UDim2.fromOffset(0, 0)
HoverTag.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
HoverTag.BackgroundTransparency = 0.2
HoverTag.BorderSizePixel = 0
HoverTag.Visible = false
HoverTag.ZIndex = 70
HoverTag.Parent = Main

local HoverTagCorner = Instance.new("UICorner")
HoverTagCorner.CornerRadius = UDim.new(0, 4)
HoverTagCorner.Parent = HoverTag

local HoverTagText = Instance.new("TextLabel")
HoverTagText.Name = "Text"
HoverTagText.Size = UDim2.new(1, 0, 1, 0)
HoverTagText.BackgroundTransparency = 1
HoverTagText.TextColor3 = Color3.fromRGB(255, 255, 255)
HoverTagText.TextSize = 9.5
HoverTagText.Font = Enum.Font.GothamBold
HoverTagText.TextTruncate = Enum.TextTruncate.AtEnd
HoverTagText.ZIndex = 71
HoverTagText.Parent = HoverTag

local HoverPadding = Instance.new("UIPadding")
HoverPadding.PaddingLeft = UDim.new(0, 6)
HoverPadding.PaddingRight = UDim.new(0, 6)
HoverPadding.Parent = HoverTag

-- Side Card Menu Section (Di bawah header)
local MenuCard = Instance.new("Frame")
MenuCard.Name = "MenuCard"
MenuCard.Size = UDim2.new(0.5, 0, 1, -48)
MenuCard.Position = UDim2.new(-0.5, 0, 0, 48)
MenuCard.BackgroundColor3 = Color3.fromRGB(10, 10, 14)
MenuCard.BorderSizePixel = 0
MenuCard.ZIndex = 50
MenuCard.Parent = Main

local MenuCardCorner = Instance.new("UICorner")
MenuCardCorner.CornerRadius = UDim.new(0, 12)
MenuCardCorner.Parent = MenuCard

local MenuHeader = Instance.new("Frame")
MenuHeader.Name = "MenuHeader"
MenuHeader.Size = UDim2.new(1, 0, 0, 38)
MenuHeader.BackgroundTransparency = 1
MenuHeader.ZIndex = 51
MenuHeader.Parent = MenuCard

-- 4. IMAGE BACK BUTTON BARU
local BackButton = Instance.new("ImageButton")
BackButton.Name = "BackButton"
BackButton.Size = UDim2.fromOffset(18, 18)
BackButton.Position = UDim2.fromOffset(10, 10)
BackButton.BackgroundTransparency = 1
BackButton.Image = "rbxassetid://73780377692148"
BackButton.ImageColor3 = Color3.fromRGB(235, 240, 248)
BackButton.ZIndex = 52
BackButton.Parent = MenuHeader

local MenuTitle = Instance.new("TextLabel")
MenuTitle.Name = "MenuTitle"
MenuTitle.Size = UDim2.new(1, -36, 1, 0)
MenuTitle.Position = UDim2.fromOffset(32, 0)
MenuTitle.BackgroundTransparency = 1
MenuTitle.Text = "CATEGORIES"
MenuTitle.TextColor3 = Color3.fromRGB(235, 240, 248)
MenuTitle.TextSize = 10
MenuTitle.Font = Enum.Font.GothamBold
MenuTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuTitle.ZIndex = 52
MenuTitle.Parent = MenuHeader

local MenuListFrame = Instance.new("ScrollingFrame")
MenuListFrame.Name = "MenuListFrame"
MenuListFrame.Size = UDim2.new(1, -12, 1, -44)
MenuListFrame.Position = UDim2.fromOffset(6, 38)
MenuListFrame.BackgroundTransparency = 1
MenuListFrame.BorderSizePixel = 0
MenuListFrame.ScrollBarThickness = 2
MenuListFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 75)
MenuListFrame.CanvasSize = UDim2.new()
MenuListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
MenuListFrame.ScrollingDirection = Enum.ScrollingDirection.Y
MenuListFrame.ZIndex = 51
MenuListFrame.Parent = MenuCard

local MenuListLayout = Instance.new("UIListLayout")
MenuListLayout.SortOrder = Enum.SortOrder.LayoutOrder
MenuListLayout.Padding = UDim.new(0, 3)
MenuListLayout.Parent = MenuListFrame

-- Base Name TextButton Template for Category Group
local NameButtonTemplate = Instance.new("TextButton")
NameButtonTemplate.Name = "CategoryButton"
NameButtonTemplate.Size = UDim2.new(1, -4, 0, 22)
NameButtonTemplate.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
NameButtonTemplate.BackgroundTransparency = 1
NameButtonTemplate.BorderSizePixel = 0
NameButtonTemplate.TextColor3 = Color3.fromRGB(180, 185, 200)
NameButtonTemplate.TextSize = 9
NameButtonTemplate.Font = Enum.Font.GothamMedium
NameButtonTemplate.TextXAlignment = Enum.TextXAlignment.Left
NameButtonTemplate.TextTruncate = Enum.TextTruncate.AtEnd
NameButtonTemplate.AutoButtonColor = false
NameButtonTemplate.ZIndex = 52

local NameButtonCorner = Instance.new("UICorner")
NameButtonCorner.CornerRadius = UDim.new(0, 4)
NameButtonCorner.Parent = NameButtonTemplate

local TemplatePadding = Instance.new("UIPadding")
TemplatePadding.PaddingLeft = UDim.new(0, 6)
TemplatePadding.Parent = NameButtonTemplate

-- 4. RESIZE HANDLE DENGAN ROTASI 45 DERAJAT
local ResizeHandle = Instance.new("ImageButton")
ResizeHandle.Name = "CornerResizeHandle"
ResizeHandle.Size = UDim2.fromOffset(16, 16)
ResizeHandle.Position = UDim2.new(1, -16, 1, -16)
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Image = "rbxassetid://103321376129527"
ResizeHandle.ImageColor3 = Color3.fromRGB(130, 135, 150)
ResizeHandle.ImageTransparency = 0.5
ResizeHandle.Rotation = -35
ResizeHandle.ZIndex = 60
ResizeHandle.Parent = Main

-- Logic Variables
local IconList = {}
local Categories = {}
local filtered = {}
local currentIcon = nil
local rendered = 0
local PAGE_SIZE = 60
local busy = false
local selectedMenuBtn = nil

local function clearGrid()
	for _, child in ipairs(Content:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
end

local function showDetail(icon)
	currentIcon = icon
	DetailPreview.Image = icon.Asset
	DetailName.Text = icon.Name
	DetailID.Text = icon.ID
	CopyButton.Text = "COPY ID"
	Detail.Visible = true
	Detail.Position = UDim2.new(0, 12, 0.5, -50)
	
	TweenService:Create(
		Detail,
		TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Position = UDim2.new(0, 12, 0.5, -60)}
	):Play()
end

-- Hierarki Grid List Thumbnail & Hover Tag
local function addIcon(icon, order)
	local Button = Instance.new("TextButton")
	Button.Name = icon.Name
	Button.LayoutOrder = order
	Button.Size = UDim2.fromOffset(42, 42)
	Button.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
	Button.BackgroundTransparency = 1
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.Parent = Content

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Button

	local Thumbnail = Instance.new("ImageLabel")
	Thumbnail.Name = "Thumbnail"
	Thumbnail.Size = UDim2.fromOffset(30, 30)
	Thumbnail.Position = UDim2.new(0.5, -15, 0.5, -15)
	Thumbnail.BackgroundTransparency = 1
	Thumbnail.Image = icon.Asset
	Thumbnail.ImageColor3 = Color3.fromRGB(235, 240, 248)
	Thumbnail.Parent = Button

	Button.MouseEnter:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.1), {
			BackgroundTransparency = 0,
			BackgroundColor3 = Color3.fromRGB(30, 30, 38)
		}):Play()

		HoverTagText.Text = icon.Name
		local absPos = Button.AbsolutePosition
		local mainAbsPos = Main.AbsolutePosition
		HoverTag.Position = UDim2.fromOffset(
			(absPos.X - mainAbsPos.X) + 21 - (HoverTag.AbsoluteSize.X / 2),
			(absPos.Y - mainAbsPos.Y) - 24
		)
		HoverTag.Visible = true
	end)

	Button.MouseLeave:Connect(function()
		TweenService:Create(Button, TweenInfo.new(0.1), {
			BackgroundTransparency = 1
		}):Play()
		HoverTag.Visible = false
	end)

	Button.MouseButton1Click:Connect(function()
		HoverTag.Visible = false
		showDetail(icon)
	end)
end

local function renderNext()
	if busy or rendered >= #filtered then
		return
	end

	busy = true
	local target = math.min(rendered + PAGE_SIZE, #filtered)

	for i = rendered + 1, target do
		addIcon(filtered[i], i)
	end

	rendered = target
	busy = false
end

local function applySearch()
	local query = SearchBox.Text:lower():gsub("^%s+", ""):gsub("%s+$", "")
	filtered = {}

	if query == "" then
		filtered = IconList
	else
		for _, icon in ipairs(IconList) do
			if icon.Name:lower():find(query, 1, true) then
				table.insert(filtered, icon)
			end
		end
	end

	rendered = 0
	clearGrid()
	Content.CanvasPosition = Vector2.zero
	renderNext()
end

local function hideMenuCard()
	TweenService:Create(
		MenuCard,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{Position = UDim2.new(-0.5, 0, 0, 48)}
	):Play()
end

local function populateMenuList()
	Categories = {}
	for _, icon in ipairs(IconList) do
		local prefix = icon.Name:match("^([a-z]+)") or "other"
		prefix = prefix:lower()
		if not Categories[prefix] then
			Categories[prefix] = {}
		end
		table.insert(Categories[prefix], icon)
	end

	local sortedCategories = {}
	for catName, _ in pairs(Categories) do
		table.insert(sortedCategories, catName)
	end
	table.sort(sortedCategories)

	for _, catName in ipairs(sortedCategories) do
		local iconsInCat = Categories[catName]
		local nameBtn = NameButtonTemplate:Clone()
		nameBtn.Text = catName:upper() .. "  " .. #iconsInCat
		nameBtn.Parent = MenuListFrame

		nameBtn.MouseEnter:Connect(function()
			if selectedMenuBtn ~= nameBtn then
				TweenService:Create(nameBtn, TweenInfo.new(0.1), {
					BackgroundTransparency = 0,
					BackgroundColor3 = Color3.fromRGB(20, 20, 26),
					TextColor3 = Color3.fromRGB(235, 240, 248)
				}):Play()
			end
		end)

		nameBtn.MouseLeave:Connect(function()
			if selectedMenuBtn ~= nameBtn then
				TweenService:Create(nameBtn, TweenInfo.new(0.1), {
					BackgroundTransparency = 1,
					TextColor3 = Color3.fromRGB(180, 185, 200)
				}):Play()
			end
		end)

		nameBtn.MouseButton1Click:Connect(function()
			if selectedMenuBtn and selectedMenuBtn ~= nameBtn then
				TweenService:Create(selectedMenuBtn, TweenInfo.new(0.1), {
					BackgroundTransparency = 1,
					TextColor3 = Color3.fromRGB(180, 185, 200)
				}):Play()
			end

			selectedMenuBtn = nameBtn
			TweenService:Create(nameBtn, TweenInfo.new(0.1), {
				BackgroundTransparency = 0,
				BackgroundColor3 = Color3.fromRGB(30, 30, 40),
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()

			hideMenuCard()

			filtered = iconsInCat
			rendered = 0
			clearGrid()
			Content.CanvasPosition = Vector2.zero
			renderNext()
		end)
	end
end

-- Dragify Window Logic
local function dragify(target, handle)
	local dragging = false
	local dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = target.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			target.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end

-- Resize Window Logic
local function resizefy(target, handle, minSize)
	local resizing = false
	local dragStart, startSize

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = true
			dragStart = input.Position
			startSize = target.AbsoluteSize

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					resizing = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			local newX = math.max(minSize.X, startSize.X + delta.X)
			local newY = math.max(minSize.Y, startSize.Y + delta.Y)
			target.Size = UDim2.fromOffset(newX, newY)
		end
	end)
end

-- Event Listeners
SearchBox:GetPropertyChangedSignal("Text"):Connect(applySearch)

Content:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
	local maxY = math.max(0, Content.AbsoluteCanvasSize.Y - Content.AbsoluteSize.Y)
	if Content.CanvasPosition.Y >= maxY - 100 then
		renderNext()
	end
end)

CopyButton.MouseButton1Click:Connect(function()
	if currentIcon then
		if setclipboard then
			setclipboard(currentIcon.ID)
		elseif toclipboard then
			toclipboard(currentIcon.ID)
		end
		CopyButton.Text = "COPIED"
		task.delay(1, function()
			if CopyButton.Parent then
				CopyButton.Text = "COPY ID"
			end
		end)
	end
end)

DetailClose.MouseButton1Click:Connect(function()
	Detail.Visible = false
	currentIcon = nil
end)

CloseButton.MouseButton1Click:Connect(function()
	Gui:Destroy()
end)

-- Menu Card Open/Close Tweens
MenuButton.MouseButton1Click:Connect(function()
	TweenService:Create(
		MenuCard,
		TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
		{Position = UDim2.new(0, 0, 0, 48)}
	):Play()
end)

BackButton.MouseButton1Click:Connect(hideMenuCard)

-- Initialize Drag and Resize
dragify(Main, Header)
resizefy(Main, ResizeHandle, Vector2.new(200, 240))

-- Deferred Data Fetch & Load Logic
task.defer(function()
	task.wait(1)

	local success, rawData = pcall(function()
		return game:HttpGet(ICONS_URL)
	end)

	if success and rawData then
		local loadedIcons = loadstring(rawData)()
		IconList = {}

		for name, asset in pairs(loadedIcons) do
			table.insert(IconList, {
				Name = name,
				Asset = asset,
				ID = tostring(asset):match("(%d+)$") or tostring(asset)
			})
		end

		table.sort(IconList, function(a, b)
			return a.Name < b.Name
		end)

		filtered = IconList
		populateMenuList()

		pulseSpinnerTween:Cancel()
		pulseTextTween:Cancel()
		if spinConnection then
			spinConnection:Disconnect()
		end
		LoadingOverlay:Destroy()

		renderNext()
	else
		LoadingText.Text = "FAILED TO LOAD"
		LoadingText.TextColor3 = Color3.fromRGB(255, 80, 80)
	end
end)
