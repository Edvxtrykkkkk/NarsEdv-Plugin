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

-- ImageButton: OpenBtn
GUI["GUI_OpenBtn"] = Instance.new("ImageButton")
GUI["GUI_OpenBtn"]["Name"] = "OpenBtn"
GUI["GUI_OpenBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_OpenBtn"]["Size"] = UDim2.fromOffset(20, 20)
GUI["GUI_OpenBtn"]["Position"] = UDim2.fromOffset(0, 53)
GUI["GUI_OpenBtn"]["Rotation"] = 0
GUI["GUI_OpenBtn"]["BackgroundColor3"] = Color3.fromRGB(10, 10, 10)
GUI["GUI_OpenBtn"]["BackgroundTransparency"] = 0.5
GUI["GUI_OpenBtn"]["BorderSizePixel"] = 0
GUI["GUI_OpenBtn"]["Visible"] = true
GUI["GUI_OpenBtn"]["Active"] = true
GUI["GUI_OpenBtn"]["ZIndex"] = 1
GUI["GUI_OpenBtn"]["LayoutOrder"] = 0
GUI["GUI_OpenBtn"]["AutoButtonColor"] = true
GUI["GUI_OpenBtn"]["Image"] = "rbxassetid://73780377692148"
GUI["GUI_OpenBtn"]["ImageTransparency"] = 0
GUI["GUI_OpenBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_OpenBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_OpenBtn"]["Parent"] = GUI["GUI_ScreenGui"]

-- Frame: Panel
GUI["GUI_Panel"] = Instance.new("Frame")
GUI["GUI_Panel"]["Name"] = "Panel"
GUI["GUI_Panel"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Panel"]["Size"] = UDim2.new(0, 270, 1, -78)
GUI["GUI_Panel"]["Position"] = UDim2.fromOffset(0, 78)
GUI["GUI_Panel"]["Rotation"] = 0
GUI["GUI_Panel"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Panel"]["BackgroundTransparency"] = 0
GUI["GUI_Panel"]["BorderSizePixel"] = 0
GUI["GUI_Panel"]["ClipsDescendants"] = true
GUI["GUI_Panel"]["Visible"] = true
GUI["GUI_Panel"]["Active"] = true
GUI["GUI_Panel"]["ZIndex"] = 1
GUI["GUI_Panel"]["LayoutOrder"] = 0
GUI["GUI_Panel"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Panel"]["Parent"] = GUI["GUI_ScreenGui"]

-- ImageButton: ResizeBtn
GUI["GUI_ResizeBtn"] = Instance.new("ImageButton")
GUI["GUI_ResizeBtn"]["Name"] = "ResizeBtn"
GUI["GUI_ResizeBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ResizeBtn"]["Size"] = UDim2.new(0, 5, 1, 0)
GUI["GUI_ResizeBtn"]["Position"] = UDim2.fromOffset(265, 0)
GUI["GUI_ResizeBtn"]["Rotation"] = 0
GUI["GUI_ResizeBtn"]["BackgroundColor3"] = Color3.fromRGB(38, 38, 38)
GUI["GUI_ResizeBtn"]["BackgroundTransparency"] = 0
GUI["GUI_ResizeBtn"]["BorderSizePixel"] = 0
GUI["GUI_ResizeBtn"]["Visible"] = true
GUI["GUI_ResizeBtn"]["Active"] = true
GUI["GUI_ResizeBtn"]["ZIndex"] = 1
GUI["GUI_ResizeBtn"]["LayoutOrder"] = 0
GUI["GUI_ResizeBtn"]["AutoButtonColor"] = true
GUI["GUI_ResizeBtn"]["Image"] = "rbxassetid://"
GUI["GUI_ResizeBtn"]["ImageTransparency"] = 0
GUI["GUI_ResizeBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_ResizeBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ResizeBtn"]["Parent"] = GUI["GUI_Panel"]

-- Frame: Line
GUI["GUI_Line"] = Instance.new("Frame")
GUI["GUI_Line"]["Name"] = "Line"
GUI["GUI_Line"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Line"]["Size"] = UDim2.fromOffset(1, 345)
GUI["GUI_Line"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Line"]["Rotation"] = 0
GUI["GUI_Line"]["BackgroundColor3"] = Color3.fromRGB(12, 12, 12)
GUI["GUI_Line"]["BackgroundTransparency"] = 0
GUI["GUI_Line"]["BorderSizePixel"] = 0
GUI["GUI_Line"]["ClipsDescendants"] = true
GUI["GUI_Line"]["Visible"] = true
GUI["GUI_Line"]["Active"] = true
GUI["GUI_Line"]["ZIndex"] = 1
GUI["GUI_Line"]["LayoutOrder"] = 0
GUI["GUI_Line"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Line"]["Parent"] = GUI["GUI_ResizeBtn"]

-- Frame: Header
GUI["GUI_Header"] = Instance.new("Frame")
GUI["GUI_Header"]["Name"] = "Header"
GUI["GUI_Header"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Header"]["Size"] = UDim2.fromOffset(265, 24)
GUI["GUI_Header"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Header"]["Rotation"] = 0
GUI["GUI_Header"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_Header"]["BackgroundTransparency"] = 0
GUI["GUI_Header"]["BorderSizePixel"] = 0
GUI["GUI_Header"]["ClipsDescendants"] = false
GUI["GUI_Header"]["Visible"] = true
GUI["GUI_Header"]["Active"] = true
GUI["GUI_Header"]["ZIndex"] = 1
GUI["GUI_Header"]["LayoutOrder"] = 0
GUI["GUI_Header"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Header"]["Parent"] = GUI["GUI_Panel"]

-- TextLabel: Title
GUI["GUI_Title"] = Instance.new("TextLabel")
GUI["GUI_Title"]["Name"] = "Title"
GUI["GUI_Title"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Title"]["Size"] = UDim2.fromOffset(125, 24)
GUI["GUI_Title"]["Position"] = UDim2.fromOffset(10, 0)
GUI["GUI_Title"]["Rotation"] = 0
GUI["GUI_Title"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Title"]["BackgroundTransparency"] = 1
GUI["GUI_Title"]["BorderSizePixel"] = 0
GUI["GUI_Title"]["Visible"] = true
GUI["GUI_Title"]["Active"] = false
GUI["GUI_Title"]["ZIndex"] = 1
GUI["GUI_Title"]["LayoutOrder"] = 0
GUI["GUI_Title"]["Text"] = "Store Asset"
GUI["GUI_Title"]["TextColor3"] = Color3.fromRGB(209, 213, 219)
GUI["GUI_Title"]["TextSize"] = 12
GUI["GUI_Title"]["TextScaled"] = false
GUI["GUI_Title"]["TextWrapped"] = false
GUI["GUI_Title"]["TextTransparency"] = 0
GUI["GUI_Title"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Title"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Title"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Title"]["RichText"] = false
GUI["GUI_Title"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Title"]["Parent"] = GUI["GUI_Header"]

-- ImageButton: CloseBtn
GUI["GUI_CloseBtn"] = Instance.new("ImageButton")
GUI["GUI_CloseBtn"]["Name"] = "CloseBtn"
GUI["GUI_CloseBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CloseBtn"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_CloseBtn"]["Position"] = UDim2.fromOffset(250, 6)
GUI["GUI_CloseBtn"]["Rotation"] = 0
GUI["GUI_CloseBtn"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_CloseBtn"]["BackgroundTransparency"] = 0
GUI["GUI_CloseBtn"]["BorderSizePixel"] = 0
GUI["GUI_CloseBtn"]["Visible"] = true
GUI["GUI_CloseBtn"]["Active"] = true
GUI["GUI_CloseBtn"]["ZIndex"] = 1
GUI["GUI_CloseBtn"]["LayoutOrder"] = 0
GUI["GUI_CloseBtn"]["AutoButtonColor"] = true
GUI["GUI_CloseBtn"]["Image"] = "rbxassetid://110786993356448"
GUI["GUI_CloseBtn"]["ImageTransparency"] = 0
GUI["GUI_CloseBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_CloseBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CloseBtn"]["Parent"] = GUI["GUI_Header"]

-- ImageButton: MinBtn
GUI["GUI_MinBtn"] = Instance.new("ImageButton")
GUI["GUI_MinBtn"]["Name"] = "MinBtn"
GUI["GUI_MinBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_MinBtn"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_MinBtn"]["Position"] = UDim2.fromOffset(235, 6)
GUI["GUI_MinBtn"]["Rotation"] = 0
GUI["GUI_MinBtn"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_MinBtn"]["BackgroundTransparency"] = 0
GUI["GUI_MinBtn"]["BorderSizePixel"] = 0
GUI["GUI_MinBtn"]["Visible"] = false
GUI["GUI_MinBtn"]["Active"] = true
GUI["GUI_MinBtn"]["ZIndex"] = 1
GUI["GUI_MinBtn"]["LayoutOrder"] = 0
GUI["GUI_MinBtn"]["AutoButtonColor"] = true
GUI["GUI_MinBtn"]["Image"] = "rbxassetid://"
GUI["GUI_MinBtn"]["ImageTransparency"] = 0
GUI["GUI_MinBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_MinBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_MinBtn"]["Parent"] = GUI["GUI_Header"]

-- ImageButton: DockBtn
GUI["GUI_DockBtn"] = Instance.new("ImageButton")
GUI["GUI_DockBtn"]["Name"] = "DockBtn"
GUI["GUI_DockBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_DockBtn"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_DockBtn"]["Position"] = UDim2.fromOffset(235, 6)
GUI["GUI_DockBtn"]["Rotation"] = 0
GUI["GUI_DockBtn"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_DockBtn"]["BackgroundTransparency"] = 0
GUI["GUI_DockBtn"]["BorderSizePixel"] = 0
GUI["GUI_DockBtn"]["Visible"] = true
GUI["GUI_DockBtn"]["Active"] = true
GUI["GUI_DockBtn"]["ZIndex"] = 1
GUI["GUI_DockBtn"]["LayoutOrder"] = 0
GUI["GUI_DockBtn"]["AutoButtonColor"] = true
GUI["GUI_DockBtn"]["Image"] = "rbxassetid://103542107889511"
GUI["GUI_DockBtn"]["ImageTransparency"] = 0
GUI["GUI_DockBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_DockBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_DockBtn"]["Parent"] = GUI["GUI_Header"]

-- Frame: Store
GUI["GUI_Store"] = Instance.new("Frame")
GUI["GUI_Store"]["Name"] = "Store"
GUI["GUI_Store"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Store"]["Size"] = UDim2.new(0, 265, 1, -24)
GUI["GUI_Store"]["Position"] = UDim2.fromOffset(0, 24)
GUI["GUI_Store"]["Rotation"] = 0
GUI["GUI_Store"]["BackgroundColor3"] = Color3.fromRGB(38, 38, 38)
GUI["GUI_Store"]["BackgroundTransparency"] = 1
GUI["GUI_Store"]["BorderSizePixel"] = 0
GUI["GUI_Store"]["ClipsDescendants"] = true
GUI["GUI_Store"]["Visible"] = true
GUI["GUI_Store"]["Active"] = false
GUI["GUI_Store"]["ZIndex"] = 1
GUI["GUI_Store"]["LayoutOrder"] = 0
GUI["GUI_Store"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Store"]["Parent"] = GUI["GUI_Panel"]

-- Frame: Toolbar
GUI["GUI_Toolbar"] = Instance.new("Frame")
GUI["GUI_Toolbar"]["Name"] = "Toolbar"
GUI["GUI_Toolbar"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Toolbar"]["Size"] = UDim2.fromOffset(265, 40)
GUI["GUI_Toolbar"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Toolbar"]["Rotation"] = 0
GUI["GUI_Toolbar"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_Toolbar"]["BackgroundTransparency"] = 0
GUI["GUI_Toolbar"]["BorderSizePixel"] = 0
GUI["GUI_Toolbar"]["ClipsDescendants"] = false
GUI["GUI_Toolbar"]["Visible"] = true
GUI["GUI_Toolbar"]["Active"] = false
GUI["GUI_Toolbar"]["ZIndex"] = 2
GUI["GUI_Toolbar"]["LayoutOrder"] = 0
GUI["GUI_Toolbar"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Toolbar"]["Parent"] = GUI["GUI_Store"]

-- Frame: SearchBox
GUI["GUI_SearchBox"] = Instance.new("Frame")
GUI["GUI_SearchBox"]["Name"] = "SearchBox"
GUI["GUI_SearchBox"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SearchBox"]["Size"] = UDim2.fromOffset(140, 22)
GUI["GUI_SearchBox"]["Position"] = UDim2.fromOffset(90, 10)
GUI["GUI_SearchBox"]["Rotation"] = 0
GUI["GUI_SearchBox"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_SearchBox"]["BackgroundTransparency"] = 0
GUI["GUI_SearchBox"]["BorderSizePixel"] = 0
GUI["GUI_SearchBox"]["ClipsDescendants"] = false
GUI["GUI_SearchBox"]["Visible"] = true
GUI["GUI_SearchBox"]["Active"] = true
GUI["GUI_SearchBox"]["ZIndex"] = 1
GUI["GUI_SearchBox"]["LayoutOrder"] = 0
GUI["GUI_SearchBox"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SearchBox"]["Parent"] = GUI["GUI_Toolbar"]

-- UIStroke: UIStroke
GUI["GUI_UIStroke"] = Instance.new("UIStroke")
GUI["GUI_UIStroke"]["Name"] = "UIStroke"
GUI["GUI_UIStroke"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Contextual
GUI["GUI_UIStroke"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIStroke"]["Enabled"] = true
GUI["GUI_UIStroke"]["LineJoinMode"] = Enum.LineJoinMode.Round
GUI["GUI_UIStroke"]["Thickness"] = 0.5
GUI["GUI_UIStroke"]["Transparency"] = 0
GUI["GUI_UIStroke"]["Parent"] = GUI["GUI_SearchBox"]

-- TextBox: Input
GUI["GUI_Input"] = Instance.new("TextBox")
GUI["GUI_Input"]["Name"] = "Input"
GUI["GUI_Input"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Input"]["Size"] = UDim2.fromOffset(112, 22)
GUI["GUI_Input"]["Position"] = UDim2.fromOffset(5, 0)
GUI["GUI_Input"]["Rotation"] = 0
GUI["GUI_Input"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Input"]["BackgroundTransparency"] = 1
GUI["GUI_Input"]["BorderSizePixel"] = 0
GUI["GUI_Input"]["Visible"] = true
GUI["GUI_Input"]["Active"] = true
GUI["GUI_Input"]["ZIndex"] = 1
GUI["GUI_Input"]["LayoutOrder"] = 0
GUI["GUI_Input"]["Text"] = ""
GUI["GUI_Input"]["TextColor3"] = Color3.fromRGB(250, 250, 250)
GUI["GUI_Input"]["TextSize"] = 12
GUI["GUI_Input"]["TextScaled"] = false
GUI["GUI_Input"]["TextWrapped"] = false
GUI["GUI_Input"]["TextTransparency"] = 0
GUI["GUI_Input"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Input"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Input"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Input"]["RichText"] = false
GUI["GUI_Input"]["PlaceholderText"] = "Enter search store..."
GUI["GUI_Input"]["PlaceholderColor3"] = Color3.fromRGB(65, 65, 65)
GUI["GUI_Input"]["TextEditable"] = true
GUI["GUI_Input"]["ClearTextOnFocus"] = false
GUI["GUI_Input"]["MultiLine"] = false
GUI["GUI_Input"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Input"]["Parent"] = GUI["GUI_SearchBox"]

-- ImageButton: SearchBtn
GUI["GUI_SearchBtn"] = Instance.new("ImageButton")
GUI["GUI_SearchBtn"]["Name"] = "SearchBtn"
GUI["GUI_SearchBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SearchBtn"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_SearchBtn"]["Position"] = UDim2.fromOffset(122, 4)
GUI["GUI_SearchBtn"]["Rotation"] = 0
GUI["GUI_SearchBtn"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_SearchBtn"]["BackgroundTransparency"] = 1
GUI["GUI_SearchBtn"]["BorderSizePixel"] = 0
GUI["GUI_SearchBtn"]["Visible"] = true
GUI["GUI_SearchBtn"]["Active"] = true
GUI["GUI_SearchBtn"]["ZIndex"] = 1
GUI["GUI_SearchBtn"]["LayoutOrder"] = 0
GUI["GUI_SearchBtn"]["AutoButtonColor"] = true
GUI["GUI_SearchBtn"]["Image"] = "rbxassetid://121018724060431"
GUI["GUI_SearchBtn"]["ImageTransparency"] = 0
GUI["GUI_SearchBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_SearchBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SearchBtn"]["Parent"] = GUI["GUI_SearchBox"]

-- UICorner: UICorner
GUI["GUI_UICorner"] = Instance.new("UICorner")
GUI["GUI_UICorner"]["Name"] = "UICorner"
GUI["GUI_UICorner"]["CornerRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner"]["Parent"] = GUI["GUI_SearchBox"]

-- TextButton: Dropdown
GUI["GUI_Dropdown"] = Instance.new("TextButton")
GUI["GUI_Dropdown"]["Name"] = "Dropdown"
GUI["GUI_Dropdown"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Dropdown"]["Size"] = UDim2.fromOffset(70, 22)
GUI["GUI_Dropdown"]["Position"] = UDim2.fromOffset(10, 10)
GUI["GUI_Dropdown"]["Rotation"] = 0
GUI["GUI_Dropdown"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_Dropdown"]["BackgroundTransparency"] = 0
GUI["GUI_Dropdown"]["BorderSizePixel"] = 0
GUI["GUI_Dropdown"]["Visible"] = true
GUI["GUI_Dropdown"]["Active"] = true
GUI["GUI_Dropdown"]["ZIndex"] = 1
GUI["GUI_Dropdown"]["LayoutOrder"] = 0
GUI["GUI_Dropdown"]["Text"] = ""
GUI["GUI_Dropdown"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Dropdown"]["TextSize"] = 14
GUI["GUI_Dropdown"]["TextScaled"] = false
GUI["GUI_Dropdown"]["TextWrapped"] = false
GUI["GUI_Dropdown"]["TextTransparency"] = 0
GUI["GUI_Dropdown"]["Font"] = Enum.Font.SourceSansBold
GUI["GUI_Dropdown"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Dropdown"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Dropdown"]["RichText"] = false
GUI["GUI_Dropdown"]["AutoButtonColor"] = true
GUI["GUI_Dropdown"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Dropdown"]["Parent"] = GUI["GUI_Toolbar"]

-- ImageLabel: Arrow
GUI["GUI_Arrow"] = Instance.new("ImageLabel")
GUI["GUI_Arrow"]["Name"] = "Arrow"
GUI["GUI_Arrow"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Arrow"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_Arrow"]["Position"] = UDim2.fromOffset(53, 5)
GUI["GUI_Arrow"]["Rotation"] = 0
GUI["GUI_Arrow"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Arrow"]["BackgroundTransparency"] = 1
GUI["GUI_Arrow"]["BorderSizePixel"] = 0
GUI["GUI_Arrow"]["Visible"] = true
GUI["GUI_Arrow"]["Active"] = false
GUI["GUI_Arrow"]["ZIndex"] = 1
GUI["GUI_Arrow"]["LayoutOrder"] = 0
GUI["GUI_Arrow"]["Image"] = "rbxassetid://139953983876976"
GUI["GUI_Arrow"]["ImageTransparency"] = 0
GUI["GUI_Arrow"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Arrow"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Arrow"]["Parent"] = GUI["GUI_Dropdown"]

-- UIStroke: UIStroke
GUI["GUI_UIStroke_1"] = Instance.new("UIStroke")
GUI["GUI_UIStroke_1"]["Name"] = "UIStroke"
GUI["GUI_UIStroke_1"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border
GUI["GUI_UIStroke_1"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIStroke_1"]["Enabled"] = true
GUI["GUI_UIStroke_1"]["LineJoinMode"] = Enum.LineJoinMode.Round
GUI["GUI_UIStroke_1"]["Thickness"] = 0.5
GUI["GUI_UIStroke_1"]["Transparency"] = 0
GUI["GUI_UIStroke_1"]["Parent"] = GUI["GUI_Dropdown"]

-- UICorner: UICorner
GUI["GUI_UICorner_1"] = Instance.new("UICorner")
GUI["GUI_UICorner_1"]["Name"] = "UICorner"
GUI["GUI_UICorner_1"]["CornerRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner_1"]["Parent"] = GUI["GUI_Dropdown"]

-- TextLabel: Select
GUI["GUI_Select"] = Instance.new("TextLabel")
GUI["GUI_Select"]["Name"] = "Select"
GUI["GUI_Select"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Select"]["Size"] = UDim2.fromOffset(45, 22)
GUI["GUI_Select"]["Position"] = UDim2.fromOffset(5, 0)
GUI["GUI_Select"]["Rotation"] = 0
GUI["GUI_Select"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Select"]["BackgroundTransparency"] = 1
GUI["GUI_Select"]["BorderSizePixel"] = 0
GUI["GUI_Select"]["Visible"] = true
GUI["GUI_Select"]["Active"] = false
GUI["GUI_Select"]["ZIndex"] = 1
GUI["GUI_Select"]["LayoutOrder"] = 0
GUI["GUI_Select"]["Text"] = "Model"
GUI["GUI_Select"]["TextColor3"] = Color3.fromRGB(230, 230, 230)
GUI["GUI_Select"]["TextSize"] = 12
GUI["GUI_Select"]["TextScaled"] = false
GUI["GUI_Select"]["TextWrapped"] = false
GUI["GUI_Select"]["TextTransparency"] = 0
GUI["GUI_Select"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Select"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Select"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Select"]["RichText"] = false
GUI["GUI_Select"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Select"]["Parent"] = GUI["GUI_Dropdown"]

-- ImageButton: SaveBtn
GUI["GUI_SaveBtn"] = Instance.new("ImageButton")
GUI["GUI_SaveBtn"]["Name"] = "SaveBtn"
GUI["GUI_SaveBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SaveBtn"]["Size"] = UDim2.fromOffset(16, 16)
GUI["GUI_SaveBtn"]["Position"] = UDim2.fromOffset(240, 13)
GUI["GUI_SaveBtn"]["Rotation"] = 0
GUI["GUI_SaveBtn"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_SaveBtn"]["BackgroundTransparency"] = 0
GUI["GUI_SaveBtn"]["BorderSizePixel"] = 0
GUI["GUI_SaveBtn"]["Visible"] = true
GUI["GUI_SaveBtn"]["Active"] = true
GUI["GUI_SaveBtn"]["ZIndex"] = 1
GUI["GUI_SaveBtn"]["LayoutOrder"] = 0
GUI["GUI_SaveBtn"]["AutoButtonColor"] = true
GUI["GUI_SaveBtn"]["Image"] = "rbxassetid://74987060545093"
GUI["GUI_SaveBtn"]["ImageTransparency"] = 0
GUI["GUI_SaveBtn"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_SaveBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SaveBtn"]["Parent"] = GUI["GUI_Toolbar"]

-- Frame: Category
GUI["GUI_Category"] = Instance.new("Frame")
GUI["GUI_Category"]["Name"] = "Category"
GUI["GUI_Category"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Category"]["Size"] = UDim2.fromOffset(95, 175)
GUI["GUI_Category"]["Position"] = UDim2.fromOffset(10, 35)
GUI["GUI_Category"]["Rotation"] = 0
GUI["GUI_Category"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_Category"]["BackgroundTransparency"] = 0
GUI["GUI_Category"]["BorderSizePixel"] = 0
GUI["GUI_Category"]["ClipsDescendants"] = false
GUI["GUI_Category"]["Visible"] = false
GUI["GUI_Category"]["Active"] = true
GUI["GUI_Category"]["ZIndex"] = 1
GUI["GUI_Category"]["LayoutOrder"] = 0
GUI["GUI_Category"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Category"]["Parent"] = GUI["GUI_Toolbar"]

-- UICorner: UICorner
GUI["GUI_UICorner_2"] = Instance.new("UICorner")
GUI["GUI_UICorner_2"]["Name"] = "UICorner"
GUI["GUI_UICorner_2"]["CornerRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner_2"]["Parent"] = GUI["GUI_Category"]

-- ScrollingFrame: ScrollCategory
GUI["GUI_ScrollCategory"] = Instance.new("ScrollingFrame")
GUI["GUI_ScrollCategory"]["Name"] = "ScrollCategory"
GUI["GUI_ScrollCategory"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ScrollCategory"]["Size"] = UDim2.fromOffset(95, 165)
GUI["GUI_ScrollCategory"]["Position"] = UDim2.fromOffset(0, 5)
GUI["GUI_ScrollCategory"]["Rotation"] = 0
GUI["GUI_ScrollCategory"]["CanvasSize"] = UDim2.fromScale(0, 2)
GUI["GUI_ScrollCategory"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
GUI["GUI_ScrollCategory"]["ScrollBarThickness"] = 0
GUI["GUI_ScrollCategory"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
GUI["GUI_ScrollCategory"]["BackgroundTransparency"] = 1
GUI["GUI_ScrollCategory"]["BorderSizePixel"] = 0
GUI["GUI_ScrollCategory"]["ClipsDescendants"] = true
GUI["GUI_ScrollCategory"]["Visible"] = true
GUI["GUI_ScrollCategory"]["Active"] = true
GUI["GUI_ScrollCategory"]["ZIndex"] = 1
GUI["GUI_ScrollCategory"]["LayoutOrder"] = 0
GUI["GUI_ScrollCategory"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ScrollCategory"]["Parent"] = GUI["GUI_Category"]

-- UIPadding: UIPadding
GUI["GUI_UIPadding"] = Instance.new("UIPadding")
GUI["GUI_UIPadding"]["Name"] = "UIPadding"
GUI["GUI_UIPadding"]["PaddingBottom"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding"]["PaddingLeft"] = UDim.new(0.0, 5)
GUI["GUI_UIPadding"]["PaddingRight"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding"]["PaddingTop"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding"]["Parent"] = GUI["GUI_ScrollCategory"]

-- UIListLayout: UIListLayout
GUI["GUI_UIListLayout"] = Instance.new("UIListLayout")
GUI["GUI_UIListLayout"]["Name"] = "UIListLayout"
GUI["GUI_UIListLayout"]["FillDirection"] = Enum.FillDirection.Vertical
GUI["GUI_UIListLayout"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Left
GUI["GUI_UIListLayout"]["Padding"] = UDim.new(0.0, 0)
GUI["GUI_UIListLayout"]["SortOrder"] = Enum.SortOrder.LayoutOrder
GUI["GUI_UIListLayout"]["VerticalAlignment"] = Enum.VerticalAlignment.Top
GUI["GUI_UIListLayout"]["Parent"] = GUI["GUI_ScrollCategory"]

-- TextButton: Option
GUI["GUI_Option"] = Instance.new("TextButton")
GUI["GUI_Option"]["Name"] = "Option"
GUI["GUI_Option"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Option"]["Size"] = UDim2.fromOffset(85, 24)
GUI["GUI_Option"]["Position"] = UDim2.fromOffset(5, 0)
GUI["GUI_Option"]["Rotation"] = 0
GUI["GUI_Option"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_Option"]["BackgroundTransparency"] = 0
GUI["GUI_Option"]["BorderSizePixel"] = 0
GUI["GUI_Option"]["Visible"] = true
GUI["GUI_Option"]["Active"] = true
GUI["GUI_Option"]["ZIndex"] = 1
GUI["GUI_Option"]["LayoutOrder"] = 0
GUI["GUI_Option"]["Text"] = ""
GUI["GUI_Option"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Option"]["TextSize"] = 12
GUI["GUI_Option"]["TextScaled"] = false
GUI["GUI_Option"]["TextWrapped"] = false
GUI["GUI_Option"]["TextTransparency"] = 0
GUI["GUI_Option"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Option"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Option"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Option"]["RichText"] = false
GUI["GUI_Option"]["AutoButtonColor"] = true
GUI["GUI_Option"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Option"]["Parent"] = GUI["GUI_ScrollCategory"]

-- UICorner: UICorner
GUI["GUI_UICorner_3"] = Instance.new("UICorner")
GUI["GUI_UICorner_3"]["Name"] = "UICorner"
GUI["GUI_UICorner_3"]["CornerRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner_3"]["Parent"] = GUI["GUI_Option"]

-- ImageLabel: Check
GUI["GUI_Check"] = Instance.new("ImageLabel")
GUI["GUI_Check"]["Name"] = "Check"
GUI["GUI_Check"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Check"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_Check"]["Position"] = UDim2.fromOffset(67, 6)
GUI["GUI_Check"]["Rotation"] = 0
GUI["GUI_Check"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Check"]["BackgroundTransparency"] = 1
GUI["GUI_Check"]["BorderSizePixel"] = 0
GUI["GUI_Check"]["Visible"] = false
GUI["GUI_Check"]["Active"] = false
GUI["GUI_Check"]["ZIndex"] = 1
GUI["GUI_Check"]["LayoutOrder"] = 0
GUI["GUI_Check"]["Image"] = "rbxassetid://93898873302694"
GUI["GUI_Check"]["ImageTransparency"] = 0
GUI["GUI_Check"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Check"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Check"]["Parent"] = GUI["GUI_Option"]

-- TextLabel: Item
GUI["GUI_Item"] = Instance.new("TextLabel")
GUI["GUI_Item"]["Name"] = "Item"
GUI["GUI_Item"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Item"]["Size"] = UDim2.fromOffset(65, 24)
GUI["GUI_Item"]["Position"] = UDim2.fromOffset(5, 0)
GUI["GUI_Item"]["Rotation"] = 0
GUI["GUI_Item"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Item"]["BackgroundTransparency"] = 1
GUI["GUI_Item"]["BorderSizePixel"] = 0
GUI["GUI_Item"]["Visible"] = true
GUI["GUI_Item"]["Active"] = false
GUI["GUI_Item"]["ZIndex"] = 1
GUI["GUI_Item"]["LayoutOrder"] = 0
GUI["GUI_Item"]["Text"] = "Model"
GUI["GUI_Item"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Item"]["TextSize"] = 12
GUI["GUI_Item"]["TextScaled"] = false
GUI["GUI_Item"]["TextWrapped"] = false
GUI["GUI_Item"]["TextTransparency"] = 0
GUI["GUI_Item"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Item"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Item"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Item"]["RichText"] = false
GUI["GUI_Item"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Item"]["Parent"] = GUI["GUI_Option"]

-- ScrollingFrame: ScrollingFrame
GUI["GUI_ScrollingFrame"] = Instance.new("ScrollingFrame")
GUI["GUI_ScrollingFrame"]["Name"] = "ScrollingFrame"
GUI["GUI_ScrollingFrame"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ScrollingFrame"]["Size"] = UDim2.new(0, 265, 1, -60)
GUI["GUI_ScrollingFrame"]["Position"] = UDim2.fromOffset(0, 60)
GUI["GUI_ScrollingFrame"]["Rotation"] = 0
GUI["GUI_ScrollingFrame"]["CanvasSize"] = UDim2.fromScale(0, 2)
GUI["GUI_ScrollingFrame"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
GUI["GUI_ScrollingFrame"]["ScrollBarThickness"] = 0
GUI["GUI_ScrollingFrame"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25)
GUI["GUI_ScrollingFrame"]["BackgroundTransparency"] = 1
GUI["GUI_ScrollingFrame"]["BorderSizePixel"] = 0
GUI["GUI_ScrollingFrame"]["ClipsDescendants"] = true
GUI["GUI_ScrollingFrame"]["Visible"] = true
GUI["GUI_ScrollingFrame"]["Active"] = false
GUI["GUI_ScrollingFrame"]["ZIndex"] = 1
GUI["GUI_ScrollingFrame"]["LayoutOrder"] = 0
GUI["GUI_ScrollingFrame"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ScrollingFrame"]["Parent"] = GUI["GUI_Store"]

-- UIPadding: UIPadding
GUI["GUI_UIPadding_1"] = Instance.new("UIPadding")
GUI["GUI_UIPadding_1"]["Name"] = "UIPadding"
GUI["GUI_UIPadding_1"]["PaddingBottom"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding_1"]["PaddingLeft"] = UDim.new(0.0, 5)
GUI["GUI_UIPadding_1"]["PaddingRight"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding_1"]["PaddingTop"] = UDim.new(0.0, 0)
GUI["GUI_UIPadding_1"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- UIGridLayout: UIGridLayout
GUI["GUI_UIGridLayout"] = Instance.new("UIGridLayout")
GUI["GUI_UIGridLayout"]["Name"] = "UIGridLayout"
GUI["GUI_UIGridLayout"]["CellPadding"] = UDim2.fromOffset(5, 5)
GUI["GUI_UIGridLayout"]["CellSize"] = UDim2.fromOffset(82, 105)
GUI["GUI_UIGridLayout"]["FillDirection"] = Enum.FillDirection.Horizontal
GUI["GUI_UIGridLayout"]["SortOrder"] = Enum.SortOrder.LayoutOrder
GUI["GUI_UIGridLayout"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- Frame: Card
GUI["GUI_Card"] = Instance.new("Frame")
GUI["GUI_Card"]["Name"] = "Card"
GUI["GUI_Card"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Card"]["Size"] = UDim2.fromOffset(82, 105)
GUI["GUI_Card"]["Position"] = UDim2.fromOffset(5, 5)
GUI["GUI_Card"]["Rotation"] = 0
GUI["GUI_Card"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57)
GUI["GUI_Card"]["BackgroundTransparency"] = 1
GUI["GUI_Card"]["BorderSizePixel"] = 0
GUI["GUI_Card"]["ClipsDescendants"] = false
GUI["GUI_Card"]["Visible"] = false
GUI["GUI_Card"]["Active"] = true
GUI["GUI_Card"]["ZIndex"] = 1
GUI["GUI_Card"]["LayoutOrder"] = 0
GUI["GUI_Card"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Card"]["Parent"] = GUI["GUI_ScrollingFrame"]

-- Frame: More
GUI["GUI_More"] = Instance.new("Frame")
GUI["GUI_More"]["Name"] = "More"
GUI["GUI_More"]["AnchorPoint"] = Vector2.new(0.5, 0.5)
GUI["GUI_More"]["Size"] = UDim2.fromOffset(80, 82)
GUI["GUI_More"]["Position"] = UDim2.new(0.5, 0, 0.5, 18)
GUI["GUI_More"]["Rotation"] = 0
GUI["GUI_More"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_More"]["BackgroundTransparency"] = 0
GUI["GUI_More"]["BorderSizePixel"] = 0
GUI["GUI_More"]["ClipsDescendants"] = false
GUI["GUI_More"]["Visible"] = false
GUI["GUI_More"]["Active"] = true
GUI["GUI_More"]["ZIndex"] = 5
GUI["GUI_More"]["LayoutOrder"] = 0
GUI["GUI_More"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_More"]["Parent"] = GUI["GUI_Card"]

-- UICorner: UICorner
GUI["GUI_UICorner_4"] = Instance.new("UICorner")
GUI["GUI_UICorner_4"]["Name"] = "UICorner"
GUI["GUI_UICorner_4"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_4"]["Parent"] = GUI["GUI_More"]

-- TextButton: CopyID
GUI["GUI_CopyID"] = Instance.new("TextButton")
GUI["GUI_CopyID"]["Name"] = "CopyID"
GUI["GUI_CopyID"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CopyID"]["Size"] = UDim2.fromOffset(70, 24)
GUI["GUI_CopyID"]["Position"] = UDim2.fromOffset(5, 5)
GUI["GUI_CopyID"]["Rotation"] = 0
GUI["GUI_CopyID"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_CopyID"]["BackgroundTransparency"] = 0
GUI["GUI_CopyID"]["BorderSizePixel"] = 0
GUI["GUI_CopyID"]["Visible"] = true
GUI["GUI_CopyID"]["Active"] = true
GUI["GUI_CopyID"]["ZIndex"] = 1
GUI["GUI_CopyID"]["LayoutOrder"] = 0
GUI["GUI_CopyID"]["Text"] = "  Copy ID"
GUI["GUI_CopyID"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_CopyID"]["TextSize"] = 12
GUI["GUI_CopyID"]["TextScaled"] = false
GUI["GUI_CopyID"]["TextWrapped"] = true
GUI["GUI_CopyID"]["TextTransparency"] = 0
GUI["GUI_CopyID"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_CopyID"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_CopyID"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_CopyID"]["RichText"] = false
GUI["GUI_CopyID"]["AutoButtonColor"] = true
GUI["GUI_CopyID"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CopyID"]["Parent"] = GUI["GUI_More"]

-- UICorner: UICorner
GUI["GUI_UICorner_5"] = Instance.new("UICorner")
GUI["GUI_UICorner_5"]["Name"] = "UICorner"
GUI["GUI_UICorner_5"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_5"]["Parent"] = GUI["GUI_CopyID"]

-- TextButton: CopyLink
GUI["GUI_CopyLink"] = Instance.new("TextButton")
GUI["GUI_CopyLink"]["Name"] = "CopyLink"
GUI["GUI_CopyLink"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CopyLink"]["Size"] = UDim2.fromOffset(70, 24)
GUI["GUI_CopyLink"]["Position"] = UDim2.fromOffset(5, 29)
GUI["GUI_CopyLink"]["Rotation"] = 0
GUI["GUI_CopyLink"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_CopyLink"]["BackgroundTransparency"] = 0
GUI["GUI_CopyLink"]["BorderSizePixel"] = 0
GUI["GUI_CopyLink"]["Visible"] = true
GUI["GUI_CopyLink"]["Active"] = true
GUI["GUI_CopyLink"]["ZIndex"] = 1
GUI["GUI_CopyLink"]["LayoutOrder"] = 0
GUI["GUI_CopyLink"]["Text"] = "  Copy Link"
GUI["GUI_CopyLink"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_CopyLink"]["TextSize"] = 12
GUI["GUI_CopyLink"]["TextScaled"] = false
GUI["GUI_CopyLink"]["TextWrapped"] = true
GUI["GUI_CopyLink"]["TextTransparency"] = 0
GUI["GUI_CopyLink"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_CopyLink"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_CopyLink"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_CopyLink"]["RichText"] = false
GUI["GUI_CopyLink"]["AutoButtonColor"] = true
GUI["GUI_CopyLink"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CopyLink"]["Parent"] = GUI["GUI_More"]

-- UICorner: UICorner
GUI["GUI_UICorner_6"] = Instance.new("UICorner")
GUI["GUI_UICorner_6"]["Name"] = "UICorner"
GUI["GUI_UICorner_6"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_6"]["Parent"] = GUI["GUI_CopyLink"]

-- TextButton: SaveAsset
GUI["GUI_SaveAsset"] = Instance.new("TextButton")
GUI["GUI_SaveAsset"]["Name"] = "SaveAsset"
GUI["GUI_SaveAsset"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SaveAsset"]["Size"] = UDim2.fromOffset(70, 24)
GUI["GUI_SaveAsset"]["Position"] = UDim2.fromOffset(5, 53)
GUI["GUI_SaveAsset"]["Rotation"] = 0
GUI["GUI_SaveAsset"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_SaveAsset"]["BackgroundTransparency"] = 0
GUI["GUI_SaveAsset"]["BorderSizePixel"] = 0
GUI["GUI_SaveAsset"]["Visible"] = true
GUI["GUI_SaveAsset"]["Active"] = true
GUI["GUI_SaveAsset"]["ZIndex"] = 1
GUI["GUI_SaveAsset"]["LayoutOrder"] = 0
GUI["GUI_SaveAsset"]["Text"] = "  Save Asset"
GUI["GUI_SaveAsset"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_SaveAsset"]["TextSize"] = 12
GUI["GUI_SaveAsset"]["TextScaled"] = false
GUI["GUI_SaveAsset"]["TextWrapped"] = false
GUI["GUI_SaveAsset"]["TextTransparency"] = 0
GUI["GUI_SaveAsset"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_SaveAsset"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_SaveAsset"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_SaveAsset"]["RichText"] = false
GUI["GUI_SaveAsset"]["AutoButtonColor"] = true
GUI["GUI_SaveAsset"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SaveAsset"]["Parent"] = GUI["GUI_More"]

-- UICorner: UICorner
GUI["GUI_UICorner_7"] = Instance.new("UICorner")
GUI["GUI_UICorner_7"]["Name"] = "UICorner"
GUI["GUI_UICorner_7"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_7"]["Parent"] = GUI["GUI_SaveAsset"]

-- ImageLabel: Thumbnail
GUI["GUI_Thumbnail"] = Instance.new("ImageLabel")
GUI["GUI_Thumbnail"]["Name"] = "Thumbnail"
GUI["GUI_Thumbnail"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Thumbnail"]["Size"] = UDim2.fromOffset(75, 75)
GUI["GUI_Thumbnail"]["Position"] = UDim2.fromOffset(4, 4)
GUI["GUI_Thumbnail"]["Rotation"] = 0
GUI["GUI_Thumbnail"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_Thumbnail"]["BackgroundTransparency"] = 1
GUI["GUI_Thumbnail"]["BorderSizePixel"] = 0
GUI["GUI_Thumbnail"]["Visible"] = true
GUI["GUI_Thumbnail"]["Active"] = false
GUI["GUI_Thumbnail"]["ZIndex"] = 2
GUI["GUI_Thumbnail"]["LayoutOrder"] = 0
GUI["GUI_Thumbnail"]["Image"] = "rbxassetid://"
GUI["GUI_Thumbnail"]["ImageTransparency"] = 0
GUI["GUI_Thumbnail"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Thumbnail"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Thumbnail"]["Parent"] = GUI["GUI_Card"]

-- UICorner: UICorner
GUI["GUI_UICorner_8"] = Instance.new("UICorner")
GUI["GUI_UICorner_8"]["Name"] = "UICorner"
GUI["GUI_UICorner_8"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_8"]["Parent"] = GUI["GUI_Thumbnail"]

-- TextButton: InsertBtn
GUI["GUI_InsertBtn"] = Instance.new("TextButton")
GUI["GUI_InsertBtn"]["Name"] = "InsertBtn"
GUI["GUI_InsertBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_InsertBtn"]["Size"] = UDim2.fromOffset(75, 75)
GUI["GUI_InsertBtn"]["Position"] = UDim2.fromOffset(4, 4)
GUI["GUI_InsertBtn"]["Rotation"] = 0
GUI["GUI_InsertBtn"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_InsertBtn"]["BackgroundTransparency"] = 0
GUI["GUI_InsertBtn"]["BorderSizePixel"] = 0
GUI["GUI_InsertBtn"]["Visible"] = true
GUI["GUI_InsertBtn"]["Active"] = true
GUI["GUI_InsertBtn"]["ZIndex"] = 1
GUI["GUI_InsertBtn"]["LayoutOrder"] = 0
GUI["GUI_InsertBtn"]["Text"] = ""
GUI["GUI_InsertBtn"]["TextColor3"] = Color3.fromRGB(39, 39, 39)
GUI["GUI_InsertBtn"]["TextSize"] = 14
GUI["GUI_InsertBtn"]["TextScaled"] = false
GUI["GUI_InsertBtn"]["TextWrapped"] = false
GUI["GUI_InsertBtn"]["TextTransparency"] = 0
GUI["GUI_InsertBtn"]["Font"] = Enum.Font.SourceSansBold
GUI["GUI_InsertBtn"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_InsertBtn"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_InsertBtn"]["RichText"] = false
GUI["GUI_InsertBtn"]["AutoButtonColor"] = true
GUI["GUI_InsertBtn"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_InsertBtn"]["Parent"] = GUI["GUI_Card"]

-- UICorner: UICorner
GUI["GUI_UICorner_9"] = Instance.new("UICorner")
GUI["GUI_UICorner_9"]["Name"] = "UICorner"
GUI["GUI_UICorner_9"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_9"]["Parent"] = GUI["GUI_InsertBtn"]

-- TextLabel: Name
GUI["GUI_Name"] = Instance.new("TextLabel")
GUI["GUI_Name"]["Name"] = "Name"
GUI["GUI_Name"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Name"]["Size"] = UDim2.fromOffset(75, 12)
GUI["GUI_Name"]["Position"] = UDim2.fromOffset(4, 82)
GUI["GUI_Name"]["Rotation"] = 0
GUI["GUI_Name"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Name"]["BackgroundTransparency"] = 1
GUI["GUI_Name"]["BorderSizePixel"] = 0
GUI["GUI_Name"]["Visible"] = true
GUI["GUI_Name"]["Active"] = false
GUI["GUI_Name"]["ZIndex"] = 1
GUI["GUI_Name"]["LayoutOrder"] = 0
GUI["GUI_Name"]["Text"] = "Name asset sto.."
GUI["GUI_Name"]["TextColor3"] = Color3.fromRGB(235, 235, 235)
GUI["GUI_Name"]["TextSize"] = 10
GUI["GUI_Name"]["TextScaled"] = false
GUI["GUI_Name"]["TextWrapped"] = false
GUI["GUI_Name"]["TextTransparency"] = 0
GUI["GUI_Name"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Name"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Name"]["TextYAlignment"] = Enum.TextYAlignment.Top
GUI["GUI_Name"]["RichText"] = false
GUI["GUI_Name"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Name"]["Parent"] = GUI["GUI_Card"]

-- TextLabel: Creator
GUI["GUI_Creator"] = Instance.new("TextLabel")
GUI["GUI_Creator"]["Name"] = "Creator"
GUI["GUI_Creator"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Creator"]["Size"] = UDim2.fromOffset(45, 12)
GUI["GUI_Creator"]["Position"] = UDim2.fromOffset(10, 65)
GUI["GUI_Creator"]["Rotation"] = 0
GUI["GUI_Creator"]["BackgroundColor3"] = Color3.fromRGB(60, 46, 46)
GUI["GUI_Creator"]["BackgroundTransparency"] = 1
GUI["GUI_Creator"]["BorderSizePixel"] = 0
GUI["GUI_Creator"]["Visible"] = true
GUI["GUI_Creator"]["Active"] = false
GUI["GUI_Creator"]["ZIndex"] = 4
GUI["GUI_Creator"]["LayoutOrder"] = 0
GUI["GUI_Creator"]["Text"] = "by Nars Edv.."
GUI["GUI_Creator"]["TextColor3"] = Color3.fromRGB(60, 108, 183)
GUI["GUI_Creator"]["TextSize"] = 8
GUI["GUI_Creator"]["TextScaled"] = false
GUI["GUI_Creator"]["TextWrapped"] = false
GUI["GUI_Creator"]["TextTransparency"] = 0
GUI["GUI_Creator"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Creator"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Creator"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Creator"]["RichText"] = false
GUI["GUI_Creator"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Creator"]["Parent"] = GUI["GUI_Card"]

-- TextLabel: Price
GUI["GUI_Price"] = Instance.new("TextLabel")
GUI["GUI_Price"]["Name"] = "Price"
GUI["GUI_Price"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Price"]["Size"] = UDim2.fromOffset(30, 12)
GUI["GUI_Price"]["Position"] = UDim2.fromOffset(4, 93)
GUI["GUI_Price"]["Rotation"] = 0
GUI["GUI_Price"]["BackgroundColor3"] = Color3.fromRGB(189, 189, 189)
GUI["GUI_Price"]["BackgroundTransparency"] = 1
GUI["GUI_Price"]["BorderSizePixel"] = 0
GUI["GUI_Price"]["Visible"] = true
GUI["GUI_Price"]["Active"] = false
GUI["GUI_Price"]["ZIndex"] = 1
GUI["GUI_Price"]["LayoutOrder"] = 0
GUI["GUI_Price"]["Text"] = "Free"
GUI["GUI_Price"]["TextColor3"] = Color3.fromRGB(157, 157, 157)
GUI["GUI_Price"]["TextSize"] = 10
GUI["GUI_Price"]["TextScaled"] = false
GUI["GUI_Price"]["TextWrapped"] = false
GUI["GUI_Price"]["TextTransparency"] = 0
GUI["GUI_Price"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Price"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Price"]["TextYAlignment"] = Enum.TextYAlignment.Top
GUI["GUI_Price"]["RichText"] = false
GUI["GUI_Price"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Price"]["Parent"] = GUI["GUI_Card"]

-- TextLabel: Rating
GUI["GUI_Rating"] = Instance.new("TextLabel")
GUI["GUI_Rating"]["Name"] = "Rating"
GUI["GUI_Rating"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Rating"]["Size"] = UDim2.fromOffset(30, 12)
GUI["GUI_Rating"]["Position"] = UDim2.fromOffset(45, 93)
GUI["GUI_Rating"]["Rotation"] = 0
GUI["GUI_Rating"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Rating"]["BackgroundTransparency"] = 1
GUI["GUI_Rating"]["BorderSizePixel"] = 0
GUI["GUI_Rating"]["Visible"] = true
GUI["GUI_Rating"]["Active"] = false
GUI["GUI_Rating"]["ZIndex"] = 1
GUI["GUI_Rating"]["LayoutOrder"] = 0
GUI["GUI_Rating"]["Text"] = "99%"
GUI["GUI_Rating"]["TextColor3"] = Color3.fromRGB(51, 163, 3)
GUI["GUI_Rating"]["TextSize"] = 10
GUI["GUI_Rating"]["TextScaled"] = false
GUI["GUI_Rating"]["TextWrapped"] = false
GUI["GUI_Rating"]["TextTransparency"] = 0
GUI["GUI_Rating"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Rating"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Rating"]["TextYAlignment"] = Enum.TextYAlignment.Top
GUI["GUI_Rating"]["RichText"] = false
GUI["GUI_Rating"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Rating"]["Parent"] = GUI["GUI_Card"]

-- ImageLabel: Like
GUI["GUI_Like"] = Instance.new("ImageLabel")
GUI["GUI_Like"]["Name"] = "Like"
GUI["GUI_Like"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Like"]["Size"] = UDim2.fromOffset(10, 10)
GUI["GUI_Like"]["Position"] = UDim2.fromOffset(-12, 0)
GUI["GUI_Like"]["Rotation"] = 0
GUI["GUI_Like"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Like"]["BackgroundTransparency"] = 1
GUI["GUI_Like"]["BorderSizePixel"] = 0
GUI["GUI_Like"]["Visible"] = true
GUI["GUI_Like"]["Active"] = false
GUI["GUI_Like"]["ZIndex"] = 1
GUI["GUI_Like"]["LayoutOrder"] = 0
GUI["GUI_Like"]["Image"] = "rbxassetid://137562742336291"
GUI["GUI_Like"]["ImageTransparency"] = 0
GUI["GUI_Like"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Like"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Like"]["Parent"] = GUI["GUI_Rating"]

-- ImageLabel: Bookmark
GUI["GUI_Bookmark"] = Instance.new("ImageLabel")
GUI["GUI_Bookmark"]["Name"] = "Bookmark"
GUI["GUI_Bookmark"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Bookmark"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_Bookmark"]["Position"] = UDim2.fromOffset(60, 8)
GUI["GUI_Bookmark"]["Rotation"] = 0
GUI["GUI_Bookmark"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Bookmark"]["BackgroundTransparency"] = 1
GUI["GUI_Bookmark"]["BorderSizePixel"] = 0
GUI["GUI_Bookmark"]["Visible"] = false
GUI["GUI_Bookmark"]["Active"] = false
GUI["GUI_Bookmark"]["ZIndex"] = 3
GUI["GUI_Bookmark"]["LayoutOrder"] = 0
GUI["GUI_Bookmark"]["Image"] = "rbxassetid://74987060545093"
GUI["GUI_Bookmark"]["ImageTransparency"] = 0
GUI["GUI_Bookmark"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Bookmark"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Bookmark"]["Parent"] = GUI["GUI_Card"]

-- Frame: Loadmore
GUI["GUI_Loadmore"] = Instance.new("Frame")
GUI["GUI_Loadmore"]["Name"] = "Loadmore"
GUI["GUI_Loadmore"]["AnchorPoint"] = Vector2.new(0.0, 1.0)
GUI["GUI_Loadmore"]["Size"] = UDim2.fromOffset(265, 35)
GUI["GUI_Loadmore"]["Position"] = UDim2.fromScale(0, 1)
GUI["GUI_Loadmore"]["Rotation"] = 0
GUI["GUI_Loadmore"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Loadmore"]["BackgroundTransparency"] = 0.3
GUI["GUI_Loadmore"]["BorderSizePixel"] = 0
GUI["GUI_Loadmore"]["ClipsDescendants"] = false
GUI["GUI_Loadmore"]["Visible"] = false
GUI["GUI_Loadmore"]["Active"] = true
GUI["GUI_Loadmore"]["ZIndex"] = 1
GUI["GUI_Loadmore"]["LayoutOrder"] = 0
GUI["GUI_Loadmore"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Loadmore"]["Parent"] = GUI["GUI_Store"]

-- TextButton: Button
GUI["GUI_Button"] = Instance.new("TextButton")
GUI["GUI_Button"]["Name"] = "Button"
GUI["GUI_Button"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Button"]["Size"] = UDim2.fromOffset(245, 24)
GUI["GUI_Button"]["Position"] = UDim2.fromOffset(10, 5)
GUI["GUI_Button"]["Rotation"] = 0
GUI["GUI_Button"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30)
GUI["GUI_Button"]["BackgroundTransparency"] = 0
GUI["GUI_Button"]["BorderSizePixel"] = 0
GUI["GUI_Button"]["Visible"] = true
GUI["GUI_Button"]["Active"] = true
GUI["GUI_Button"]["ZIndex"] = 5
GUI["GUI_Button"]["LayoutOrder"] = 0
GUI["GUI_Button"]["Text"] = "Loadmore"
GUI["GUI_Button"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Button"]["TextSize"] = 12
GUI["GUI_Button"]["TextScaled"] = false
GUI["GUI_Button"]["TextWrapped"] = true
GUI["GUI_Button"]["TextTransparency"] = 0
GUI["GUI_Button"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Button"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Button"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Button"]["RichText"] = false
GUI["GUI_Button"]["AutoButtonColor"] = true
GUI["GUI_Button"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Button"]["Parent"] = GUI["GUI_Loadmore"]

-- UICorner: UICorner
GUI["GUI_UICorner_10"] = Instance.new("UICorner")
GUI["GUI_UICorner_10"]["Name"] = "UICorner"
GUI["GUI_UICorner_10"]["CornerRadius"] = UDim.new(0.0, 5)
GUI["GUI_UICorner_10"]["Parent"] = GUI["GUI_Button"]

-- TextLabel: Status
GUI["GUI_Status"] = Instance.new("TextLabel")
GUI["GUI_Status"]["Name"] = "Status"
GUI["GUI_Status"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Status"]["Size"] = UDim2.fromOffset(265, 20)
GUI["GUI_Status"]["Position"] = UDim2.fromOffset(0, 40)
GUI["GUI_Status"]["Rotation"] = 0
GUI["GUI_Status"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Status"]["BackgroundTransparency"] = 1
GUI["GUI_Status"]["BorderSizePixel"] = 0
GUI["GUI_Status"]["Visible"] = true
GUI["GUI_Status"]["Active"] = false
GUI["GUI_Status"]["ZIndex"] = 1
GUI["GUI_Status"]["LayoutOrder"] = 0
GUI["GUI_Status"]["Text"] = "< Model / Search Results for Tree • 00 >"
GUI["GUI_Status"]["TextColor3"] = Color3.fromRGB(163, 163, 163)
GUI["GUI_Status"]["TextSize"] = 8
GUI["GUI_Status"]["TextScaled"] = false
GUI["GUI_Status"]["TextWrapped"] = false
GUI["GUI_Status"]["TextTransparency"] = 0
GUI["GUI_Status"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Status"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Status"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Status"]["RichText"] = false
GUI["GUI_Status"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Status"]["Parent"] = GUI["GUI_Store"]

-- Frame: DockPreview
GUI["GUI_DockPreview"] = Instance.new("Frame")
GUI["GUI_DockPreview"]["Name"] = "DockPreview"
GUI["GUI_DockPreview"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_DockPreview"]["Size"] = UDim2.new(0, 35, 1, -78)
GUI["GUI_DockPreview"]["Position"] = UDim2.fromOffset(0, 78)
GUI["GUI_DockPreview"]["Rotation"] = 0
GUI["GUI_DockPreview"]["BackgroundColor3"] = Color3.fromRGB(70, 126, 213)
GUI["GUI_DockPreview"]["BackgroundTransparency"] = 0.5
GUI["GUI_DockPreview"]["BorderSizePixel"] = 0
GUI["GUI_DockPreview"]["ClipsDescendants"] = false
GUI["GUI_DockPreview"]["Visible"] = false
GUI["GUI_DockPreview"]["Active"] = true
GUI["GUI_DockPreview"]["ZIndex"] = 0
GUI["GUI_DockPreview"]["LayoutOrder"] = 0
GUI["GUI_DockPreview"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_DockPreview"]["Parent"] = GUI["GUI_ScreenGui"]


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

-- LocalScript 1: ScreenGui.MainUI
local chunk1, holder1 = compile(
	"MainUI",
	GUI["GUI_ScreenGui"],
	[[

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local ScreenGui = script.Parent
local OpenBtn = ScreenGui:WaitForChild("OpenBtn") :: GuiButton
local Panel = ScreenGui:WaitForChild("Panel") :: Frame
local DockPreview = ScreenGui:WaitForChild("DockPreview") :: Frame

local Header = Panel:WaitForChild("Header") :: Frame
local CloseBtn = Header:WaitForChild("CloseBtn") :: GuiButton
local DockBtn = Header:WaitForChild("DockBtn") :: GuiButton
local MinBtn = Header:WaitForChild("MinBtn") :: GuiButton

local StoreFrame = Panel:WaitForChild("Store") :: Frame

local OPEN_RIGHT_ID = "rbxassetid://92473583511724"
local OPEN_LEFT_ID = "rbxassetid://73780377692148"

local MIN_IMAGE = "rbxassetid://118026365011536"
local DROP_IMAGE = "rbxassetid://134243273101015"

local PANEL_TWEEN_INFO = TweenInfo.new(
	0.5,
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.Out
)

local TWEEN_TIME = 0.18

local DOCK_POSITION = UDim2.new(0, 0, 0, 78)
local DOCK_SIZE = UDim2.new(0, 270, 1, -78)

local FLOAT_POSITION = UDim2.new(0, 20, 0, 78)
local MIN_SIZE = UDim2.new(0, 270, 0, 24)

local OPEN_POSITION = DOCK_POSITION
local CLOSED_POSITION = OPEN_POSITION

local isOpen = true
local isAnimating = false
local activeTween: Tween? = nil

local docked = true
local minimized = false
local dragging = false

local dragOffset = Vector2.zero
local dragInput: InputObject? = nil
local panelTween: Tween? = nil

local DOCK_IMAGE = ""

if DockBtn:IsA("ImageButton") then
	DOCK_IMAGE = DockBtn.Image
end

Panel.Position = DOCK_POSITION
Panel.Size = DOCK_SIZE
Header.Active = true

local function UpdateClosedPosition()
	local panelWidth = Panel.AbsoluteSize.X

	CLOSED_POSITION = UDim2.new(
		OPEN_POSITION.X.Scale,
		OPEN_POSITION.X.Offset - panelWidth,
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
			Size = size
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
	if isAnimating or not docked then
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

	local tween = TweenService:Create(
		Panel,
		PANEL_TWEEN_INFO,
		{
			Position = targetPosition
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
	Panel.Size = DOCK_SIZE

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

	TweenPanel(DOCK_POSITION, DOCK_SIZE, function()
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
		MIN_SIZE,
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
		DOCK_SIZE,
		function()
			SetContentVisible(true)
		end
	)
end

OpenBtn.Activated:Connect(TogglePanel)

CloseBtn.Activated:Connect(function()
	if activeTween then
		activeTween:Cancel()
		activeTween = nil
	end

	StopPanelTween()
	ScreenGui:Destroy()
end)

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
	if docked or dragging then
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

UserInputService.InputChanged:Connect(function(input: InputObject)
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

UserInputService.InputEnded:Connect(function(input: InputObject)
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

DockBtn.Visible = true
MinBtn.Visible = false
DockPreview.Visible = false

SetContentVisible(true)

UpdateClosedPosition()
UpdateOpenButton()
]],
	"LocalScript"
)

-- LocalScript 2: ScreenGui.Store
local chunk2, holder2 = compile(
	"Store",
	GUI["GUI_ScreenGui"],
	[[
--!strict
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local StudioLiteFolder = game:GetService("ReplicatedStorage"):WaitForChild("StudioLiteFolder", 3)
local LoadAssetRemote = StudioLiteFolder and StudioLiteFolder:WaitForChild("LoadAssetModelToPlayerGuiServerFunction", 3)
local ClearAssetRemote = StudioLiteFolder and StudioLiteFolder:WaitForChild("ClearAssetModelToPlayerGuiServerFunction", 3)

local StudioGui = PlayerGui:WaitForChild("StudioGui", 3)
local ExplorerPanel = StudioGui and StudioGui:WaitForChild("ExplorerPanel", 3)
local GetSelection = ExplorerPanel and ExplorerPanel:WaitForChild("GetSelection", 3)
local SetSelection = ExplorerPanel and ExplorerPanel:WaitForChild("SetSelection", 3)

local ScreenGui = script.Parent
local Panel = ScreenGui:WaitForChild("Panel")
local Store = Panel:WaitForChild("Store")
local Status = Store:WaitForChild("Status")
local Toolbar = Store:WaitForChild("Toolbar")
local SearchBox = Toolbar:WaitForChild("SearchBox")
local Input = SearchBox:WaitForChild("Input")
local SearchBtn = SearchBox:WaitForChild("SearchBtn")
local Dropdown = Toolbar:WaitForChild("Dropdown")
local Select = Dropdown:WaitForChild("Select")
local Arrow = Dropdown:WaitForChild("Arrow")
local SaveBtn = Toolbar:WaitForChild("SaveBtn")
local Category = Toolbar:WaitForChild("Category")
local ScrollCategory = Category:WaitForChild("ScrollCategory")
local OptionTemplate = ScrollCategory:WaitForChild("Option")
local ScrollingFrame = Store:WaitForChild("ScrollingFrame")
local CardTemplate = ScrollingFrame:WaitForChild("Card")
local Loadmore = Store:WaitForChild("Loadmore")
local LoadmoreButton = Loadmore:WaitForChild("Button")

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
local HOLD_DURATION = 0.45
local PressGeneration = 0
local ActivePress = nil
local CategoryOptions = {}
local SavedModeAssets = {}
local MoreMenu = CardTemplate:WaitForChild("More")

CardTemplate.Visible = false
MoreMenu.Visible = false
OptionTemplate.Visible = false
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

local function ReadSavedCategory(categoryName)
local function NormalizeList(decoded)
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

if readfile and isfile then
	local path = GetCategoryFile(categoryName)
	if SafeCall(isfile, path) == true then
		local content = SafeCall(readfile, path)
		if type(content) == "string" and content ~= "" then
			local ok, decoded = pcall(function()
			return HttpService:JSONDecode(content)
			end)
			if ok and type(decoded) == "table" then
				return NormalizeList(decoded)
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
				return NormalizeList(decoded[categoryName])
			end
		end
	end
end
return {}
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
local function Encode(value)
return HttpService:JSONEncode(value)
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
return written
end

local function IsAssetSaved(categoryName, assetId)
if not assetId then
	return false
end
for _, saved in ipairs(ReadSavedCategory(categoryName)) do
	if tostring(saved.ID) == tostring(assetId) then
		return true
	end
end
return false
end

local function RequestJSON(url)
if not RequestFunction then
	warn("[NarsEdv] Store API request unavailable")
	return nil, "HTTP request unavailable"
end

local ok, response = pcall(function()
return RequestFunction({
Url = url,
Method = "GET",
Headers = {Accept = "application/json"},
})
end)

if not ok or not response then
	warn("[NarsEdv] Store API request failed")
	return nil, tostring(response or "HTTP request failed")
end

local statusCode = tonumber(response.StatusCode)
if statusCode ~= 200 then
	warn("[NarsEdv] Store API request failed (HTTP " .. tostring(statusCode or "unknown") .. ")")
	return nil, "HTTP " .. tostring(statusCode or "unknown")
end

local decoded, data = pcall(function()
return HttpService:JSONDecode(response.Body)
end)
if not decoded or type(data) ~= "table" then
	return nil, "Invalid JSON response"
end

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

local function SetRatingVisual(card, percent)
local rating = card:FindFirstChild("Rating", true)
if not rating then
	return
end
local like = rating:FindFirstChild("Like", true) or card:FindFirstChild("Like", true)
local label
if rating:IsA("TextLabel") then
	label = rating
	elseif rating:IsA("GuiObject") then
		label = rating:FindFirstChild("Value", true)
		if not label or not label:IsA("TextLabel") then
			label = rating:FindFirstChildWhichIsA("TextLabel", true)
		end
		if not label then
			label = Instance.new("TextLabel")
			label.Name = "Value"
			label.BackgroundTransparency = 1
			label.BorderSizePixel = 0
			label.Position = UDim2.new(0, 18, 0, 0)
			label.Size = UDim2.new(1, -18, 1, 0)
			label.Font = Enum.Font.GothamMedium
			label.TextSize = 12
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Center
			label.TextTruncate = Enum.TextTruncate.AtEnd
			label.ZIndex = rating.ZIndex + 1
			label.Parent = rating
		end
	end
	local visible = percent ~= nil and percent > 0
	if rating:IsA("GuiObject") then
		rating.Visible = visible
	end
	if label and label:IsA("TextLabel") then
		label.Visible = visible
		SetTextTruncate(label)
	end
	if not visible then
		return
	end
	local color = GetRatingColor(percent)
	if label and label:IsA("TextLabel") then
		label.Text = string.format("%d%%", math.floor(percent + 0.5))
		label.TextColor3 = color
	end
	if like and like:IsA("ImageLabel") then
		like.ImageColor3 = color
	end
	if rating:IsA("GuiObject") then
		rating:SetAttribute("Rating", percent)
	end
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

local function ClearCards()
CloseMore()
for _, child in ipairs(ScrollingFrame:GetChildren()) do
	if child ~= CardTemplate and child:IsA("Frame") and child:GetAttribute("StoreAssetCard") then
		child:Destroy()
	end
end
ScrollingFrame.CanvasPosition = Vector2.zero
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
end

local function UpdateCanvas()
local layout = ScrollingFrame:FindFirstChildOfClass("UIGridLayout") or ScrollingFrame:FindFirstChildOfClass("UIListLayout")
if layout then
	ScrollingFrame.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 12)
end
end

local function GetLoadedAssetCount()
local count = 0
for _, child in ipairs(ScrollingFrame:GetChildren()) do
	if child:IsA("Frame") and child:GetAttribute("StoreAssetCard") then
		count += 1
	end
end
return count
end

local function UpdateStatus(amount)
if not Status or not Status:IsA("TextLabel") then
	return
end

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
		local bookmark = card:FindFirstChild("Bookmark", true)
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
	-- Remove only the matching cloned asset card(s), never the template.
	for _, card in ipairs(ScrollingFrame:GetChildren()) do
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

	for index = #SavedModeAssets, 1, -1 do
		if tostring(SavedModeAssets[index].Id or SavedModeAssets[index].ID) == assetId
			and tostring(SavedModeAssets[index].Category or categoryName) == categoryName then
			table.remove(SavedModeAssets, index)
		end
	end

	UpdateCanvas()
	UpdateStatus(GetLoadedAssetCount())
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
MoreMenu.Visible = true
MoreMenu.ZIndex = card.ZIndex + 10
local saveButton = MoreMenu:FindFirstChild("SaveAsset", true)
if saveButton and saveButton:IsA("TextButton") then
	local saved = IsAssetSaved(asset.Category or CurrentCategory, asset.Id or asset.ID)
	saveButton.Text = saved and "  Delete Asset" or "  Save Asset"
end
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
	return
end

if category == "Video" then
	warn("Video insertion is not supported in Studio Lite. Asset ID copied to clipboard.")
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
				if temporaryModel then target:Destroy() end
				return false
			end

			if temporaryModel then
				for _, child in ipairs(target:GetChildren()) do
					child.Parent = workspace
				end
				target:Destroy()
				else
					target.Parent = workspace
					pcall(function() target:MakeJoints() end)
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
					if object and object.Parent == nil then object:Destroy() end
				end
			end
			return inserted
		end

		local function ProcessLoadedObjects(assetFolder)
		local ok, clone = pcall(function() return assetFolder:Clone() end)
		if not ok or not clone then return false end
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
							for _, item in ipairs(inner:GetChildren()) do item.Parent = target end
							else
								inner.Parent = game.StarterPlayer
							end
						end
						processed = true
						elseif service then
							for _, item in ipairs(object:GetChildren()) do item.Parent = service end
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
									pcall(function() ClearAssetRemote:InvokeServer(assetId) end)
								end
							end
						end
					end

					if not inserted then inserted = TryClientLoad() end
					if inserted then
						SetStatus("Success!")
						else
							SetStatus("Failed")
						end
					end

					local function RenderAsset(asset)
					local card = CardTemplate:Clone()
					card.Name = "Asset_" .. tostring(asset.Id or "Unknown")
					card.Visible = true
					card:SetAttribute("StoreAssetCard", true)
					card:SetAttribute("AssetId", asset.Id or asset.ID)
					card:SetAttribute("AssetCategory", asset.Category or CurrentCategory)
					local clonedMore = card:FindFirstChild("More")
					if clonedMore then
						clonedMore:Destroy()
					end
					card.Parent = ScrollingFrame

					local thumbnail = card:FindFirstChild("Thumbnail", true)
					local nameLabel = card:FindFirstChild("Name", true)
					local creatorLabel = card:FindFirstChild("Creator", true)
					local priceLabel = card:FindFirstChild("Price", true)
					local insertButton = card:FindFirstChild("InsertBtn", true)

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

					local bookmark = card:FindFirstChild("Bookmark", true)
					if bookmark and (bookmark:IsA("ImageButton") or bookmark:IsA("ImageLabel")) then
						bookmark.ImageColor3 = ACTIVE_COLOR
						bookmark.Visible = IsAssetSaved(asset.Category or CurrentCategory, asset.Id)
					end
					if insertButton and insertButton:IsA("GuiButton") then
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
						press.Held = true
						ConfigureMore(asset, card)
						end)
						end)
					end
					return card
				end

				local function RenderAssets(assetList, append)
				if not append then
					ClearCards()
				end
				for _, asset in ipairs(assetList) do
					RenderAsset(asset)
				end
				UpdateCanvas()
			end

			local function UpdateCategoryChecks()
			for categoryName, option in pairs(CategoryOptions) do
				local check = option:FindFirstChild("Check", true)
				if check and check:IsA("ImageLabel") then
					check.Visible = categoryName == CurrentCategory
				end
			end
			Select.Text = CurrentCategory
		end

		local function UpdateArrow()
		Arrow.Rotation = DropdownOpen and 180 or 0
	end

	local function FilterSavedAssets(keyword)
	if not IsSavedMode then
		return
	end
	local query = string.lower(string.match(tostring(keyword or ""), "^%s*(.-)%s*$") or "")
	local filtered = {}
	for _, asset in ipairs(SavedModeAssets) do
		local name = string.lower(tostring(asset.Name or ""))
		local creator = string.lower(tostring(asset.Creator or ""))
		if query == "" or string.find(name, query, 1, true) or string.find(creator, query, 1, true) then
			table.insert(filtered, asset)
		end
	end
	CurrentPageToken = nil
	Loadmore.Visible = false
	RenderAssets(filtered, false)
	UpdateStatus(#filtered)
end

local function ShowSavedAssets()
SearchGeneration += 1
local generation = SearchGeneration
CurrentPageToken = nil
Loadmore.Visible = false
ClearCards()
table.clear(SavedModeAssets)

local savedList = ReadSavedCategory(CurrentCategory)
if generation ~= SearchGeneration or not IsSavedMode then
	return
end

for _, saved in ipairs(savedList) do
	table.insert(SavedModeAssets, {
	AssetTypeId = saved.AssetTypeId,
	Name = saved.Name,
	Id = saved.ID,
	Link = GetAssetLink(saved.ID, saved.Name),
	Creator = saved.Creator,
	Price = saved.Price,
	PriceText = saved.PriceText or FormatSavedPrice(saved.Price),
	Rating = saved.Rating or 0,
	Thumbnail = saved.Thumbnail or "",
	Category = CurrentCategory,
	})
end

IsLoading = false
FilterSavedAssets(Input.Text)
end

local function Search()
if IsSavedMode then
	FilterSavedAssets(Input.Text)
	return
end
if IsLoading then
	return
end
CurrentKeyword = Input.Text
CurrentPageToken = nil
SearchGeneration += 1
local generation = SearchGeneration
local categoryName = CurrentCategory
ClearCards()
Loadmore.Visible = false
IsLoading = true
task.spawn(function()
local page, err = RequestPage(CurrentKeyword, categoryName, nil)
if generation ~= SearchGeneration then
	return
end
IsLoading = false
if not page then
	UpdateStatus(0)
	return
end
for _, asset in ipairs(page.Assets) do
	asset.Category = categoryName
end
CurrentPageToken = page.NextPageToken
RenderAssets(page.Assets, true)
Loadmore.Visible = CurrentPageToken ~= nil and CurrentPageToken ~= ""
UpdateStatus(GetLoadedAssetCount())
end)
end

local function LoadMoreAssets()
if IsLoading or IsSavedMode or not CurrentPageToken then
	return
end
IsLoading = true
LoadmoreButton.Active = false
local generation = SearchGeneration
local page, err = RequestPage(CurrentKeyword, CurrentCategory, CurrentPageToken)
LoadmoreButton.Active = true
if generation ~= SearchGeneration then
	return
end
IsLoading = false
if not page then
	UpdateStatus(GetLoadedAssetCount())
	return
end
for _, asset in ipairs(page.Assets) do
	asset.Category = CurrentCategory
end
CurrentPageToken = page.NextPageToken
RenderAssets(page.Assets, true)
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
for _, categoryName in ipairs(Categories) do
	local option = OptionTemplate:Clone()
	option.Name = categoryName
	option.Visible = true
	option.Parent = ScrollCategory
	local item = option:FindFirstChild("Item", true)
	local check = option:FindFirstChild("Check", true)
	if item and item:IsA("TextLabel") then
		item.Text = categoryName
		SetTextTruncate(item)
	end
	if check and check:IsA("ImageLabel") then
		check.Visible = categoryName == CurrentCategory
	end
	CategoryOptions[categoryName] = option
	if option:IsA("GuiButton") then
		option.Activated:Connect(function()
		CurrentCategory = categoryName
		DropdownOpen = false
		Category.Visible = false
		UpdateCategoryChecks()
		UpdateArrow()
		SearchGeneration += 1
		CurrentPageToken = nil
		Loadmore.Visible = false
		IsLoading = false
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

local copyID = MoreMenu:FindFirstChild("CopyID", true)
local copyLink = MoreMenu:FindFirstChild("CopyLink", true)
local saveAssetButton = MoreMenu:FindFirstChild("SaveAsset", true)

for _, button in ipairs({copyID, copyLink, saveAssetButton}) do
	if button and button:IsA("TextButton") then
		button.TextTruncate = Enum.TextTruncate.AtEnd
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextWrapped = false
		button.TextSize = 12
		button.Font = Enum.Font.GothamMedium
	end
end

if copyID and copyID:IsA("GuiButton") then
	copyID.Activated:Connect(function()
	if ActiveAsset then
		CopyText(ActiveAsset.Id)
	end
	CloseMore()
	end)
end

if copyLink and copyLink:IsA("GuiButton") then
	copyLink.Activated:Connect(function()
	if ActiveAsset then
		CopyText(ActiveAsset.Link)
	end
	CloseMore()
	end)
end

if saveAssetButton and saveAssetButton:IsA("GuiButton") then
	saveAssetButton.Activated:Connect(function()
	if ActiveAsset then
		ToggleSaveAsset(ActiveAsset, ActiveCard)
	end
	CloseMore()
	end)
end

Dropdown.Activated:Connect(function()
DropdownOpen = not DropdownOpen
Category.Visible = DropdownOpen
UpdateArrow()
end)

SearchBtn.Activated:Connect(Search)
Input.FocusLost:Connect(function(enterPressed)
if enterPressed then
	Search()
end
end)
Input:GetPropertyChangedSignal("Text"):Connect(function()
if IsSavedMode then
	FilterSavedAssets(Input.Text)
end
end)
LoadmoreButton.Activated:Connect(LoadMoreAssets)

SaveBtn.Activated:Connect(function()
IsSavedMode = not IsSavedMode
SaveBtn.ImageColor3 = IsSavedMode and ACTIVE_COLOR or INACTIVE_COLOR
SearchGeneration += 1
CurrentPageToken = nil
Loadmore.Visible = false
IsLoading = false

if IsSavedMode then
	Input.Text = ""
	CurrentKeyword = ""
	ShowSavedAssets()
	else
		table.clear(SavedModeAssets)
		ClearCards()
		CurrentKeyword = ""
		UpdateStatus(0)
	end
	end)

	UserInputService.InputBegan:Connect(function(inputObject, gameProcessed)
	if gameProcessed or not MoreMenu.Visible then
		return
	end
	if inputObject.UserInputType ~= Enum.UserInputType.MouseButton1 and inputObject.UserInputType ~= Enum.UserInputType.Touch then
		return
	end
	local position = inputObject.Position
	local menuPosition = MoreMenu.AbsolutePosition
	local menuSize = MoreMenu.AbsoluteSize
	local insideMenu = position.X >= menuPosition.X and position.X <= menuPosition.X + menuSize.X
	and position.Y >= menuPosition.Y and position.Y <= menuPosition.Y + menuSize.Y
	local insideCard = false
	if ActiveCard then
		local cardPosition = ActiveCard.AbsolutePosition
		local cardSize = ActiveCard.AbsoluteSize
		insideCard = position.X >= cardPosition.X and position.X <= cardPosition.X + cardSize.X
		and position.Y >= cardPosition.Y and position.Y <= cardPosition.Y + cardSize.Y
	end
	if not insideMenu and not insideCard then
		CloseMore()
	end
	end)

	UserInputService.InputChanged:Connect(function(inputObject)
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
		if math.abs(delta.X) > 12 or math.abs(delta.Y) > 12 then
			press.Cancelled = true
		end
	end
	end)

	UserInputService.InputEnded:Connect(function(inputObject)
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
	if not press.Held and not press.Cancelled and press.Card and press.Card.Parent then
		InsertAsset(press.Asset)
	end
	end)

	CreateCategoryOptions()
	UpdateArrow()
	SaveBtn.ImageColor3 = INACTIVE_COLOR
	Select.Text = CurrentCategory
	UpdateStatus(0)
	EnsureStoreFolder()
]],
	"LocalScript"
)

-- Each on its own thread, so one yielding never blocks the
-- rest and an error stays contained to its script.
if chunk1 ~= nil then
	task.spawn(chunk1)
end
if chunk2 ~= nil then
	task.spawn(chunk2)
end

return GUI
