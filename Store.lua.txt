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

local function generateName()
    local bytes = {}

    for i = 1, 32 do
        bytes[i] = string.char(math.random(0, 255))
    end

    return "_narsedv_" .. table.concat(bytes)
end

GUI["GUI_ScreenGui"]["Name"] = generateName()

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
GUI["GUI_Header"]["Size"] = UDim2.fromOffset(265, 16)
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
GUI["GUI_Title"]["Size"] = UDim2.fromOffset(265, 16)
GUI["GUI_Title"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Title"]["Rotation"] = 0
GUI["GUI_Title"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Title"]["BackgroundTransparency"] = 1
GUI["GUI_Title"]["BorderSizePixel"] = 0
GUI["GUI_Title"]["Visible"] = true
GUI["GUI_Title"]["Active"] = false
GUI["GUI_Title"]["ZIndex"] = 1
GUI["GUI_Title"]["LayoutOrder"] = 0
GUI["GUI_Title"]["Text"] = "Toolbox"
GUI["GUI_Title"]["TextColor3"] = Color3.fromRGB(209, 213, 219)
GUI["GUI_Title"]["TextSize"] = 10
GUI["GUI_Title"]["TextScaled"] = false
GUI["GUI_Title"]["TextWrapped"] = false
GUI["GUI_Title"]["TextTransparency"] = 0
GUI["GUI_Title"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Title"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_Title"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Title"]["RichText"] = false
GUI["GUI_Title"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Title"]["Parent"] = GUI["GUI_Header"]

-- ImageButton: CloseBtn
GUI["GUI_CloseBtn"] = Instance.new("ImageButton")
GUI["GUI_CloseBtn"]["Name"] = "CloseBtn"
GUI["GUI_CloseBtn"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CloseBtn"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_CloseBtn"]["Position"] = UDim2.fromOffset(250, 2)
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
GUI["GUI_MinBtn"]["Position"] = UDim2.fromOffset(235, 2)
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
GUI["GUI_DockBtn"]["Position"] = UDim2.fromOffset(235, 2)
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

-- Frame: TabBar
GUI["GUI_TabBar"] = Instance.new("Frame")
GUI["GUI_TabBar"]["Name"] = "TabBar"
GUI["GUI_TabBar"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TabBar"]["Size"] = UDim2.fromOffset(265, 25)
GUI["GUI_TabBar"]["Position"] = UDim2.fromOffset(0, 16)
GUI["GUI_TabBar"]["Rotation"] = 0
GUI["GUI_TabBar"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_TabBar"]["BackgroundTransparency"] = 0
GUI["GUI_TabBar"]["BorderSizePixel"] = 0
GUI["GUI_TabBar"]["ClipsDescendants"] = true
GUI["GUI_TabBar"]["Visible"] = true
GUI["GUI_TabBar"]["Active"] = false
GUI["GUI_TabBar"]["ZIndex"] = 5
GUI["GUI_TabBar"]["LayoutOrder"] = 0
GUI["GUI_TabBar"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TabBar"]["Parent"] = GUI["GUI_Panel"]

-- TextButton: TabStore
GUI["GUI_TabStore"] = Instance.new("TextButton")
GUI["GUI_TabStore"]["Name"] = "TabStore"
GUI["GUI_TabStore"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TabStore"]["Size"] = UDim2.fromOffset(90, 24)
GUI["GUI_TabStore"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_TabStore"]["Rotation"] = 0
GUI["GUI_TabStore"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_TabStore"]["BackgroundTransparency"] = 0
GUI["GUI_TabStore"]["BorderSizePixel"] = 0
GUI["GUI_TabStore"]["Visible"] = true
GUI["GUI_TabStore"]["Active"] = true
GUI["GUI_TabStore"]["ZIndex"] = 1
GUI["GUI_TabStore"]["LayoutOrder"] = 0
GUI["GUI_TabStore"]["Text"] = ""
GUI["GUI_TabStore"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_TabStore"]["TextSize"] = 14
GUI["GUI_TabStore"]["TextScaled"] = false
GUI["GUI_TabStore"]["TextWrapped"] = true
GUI["GUI_TabStore"]["TextTransparency"] = 0
GUI["GUI_TabStore"]["Font"] = Enum.Font.SourceSansBold
GUI["GUI_TabStore"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_TabStore"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_TabStore"]["RichText"] = false
GUI["GUI_TabStore"]["AutoButtonColor"] = true
GUI["GUI_TabStore"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TabStore"]["Parent"] = GUI["GUI_TabBar"]

-- ImageLabel: Icon
GUI["GUI_Icon"] = Instance.new("ImageLabel")
GUI["GUI_Icon"]["Name"] = "Icon"
GUI["GUI_Icon"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_Icon"]["Position"] = UDim2.fromOffset(40, 6)
GUI["GUI_Icon"]["Rotation"] = 0
GUI["GUI_Icon"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon"]["BackgroundTransparency"] = 1
GUI["GUI_Icon"]["BorderSizePixel"] = 0
GUI["GUI_Icon"]["Visible"] = true
GUI["GUI_Icon"]["Active"] = false
GUI["GUI_Icon"]["ZIndex"] = 1
GUI["GUI_Icon"]["LayoutOrder"] = 0
GUI["GUI_Icon"]["Image"] = "rbxassetid://81919005304103"
GUI["GUI_Icon"]["ImageTransparency"] = 0
GUI["GUI_Icon"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon"]["Parent"] = GUI["GUI_TabStore"]

-- Frame: Indicator
GUI["GUI_Indicator"] = Instance.new("Frame")
GUI["GUI_Indicator"]["Name"] = "Indicator"
GUI["GUI_Indicator"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Indicator"]["Size"] = UDim2.fromOffset(90, 2)
GUI["GUI_Indicator"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Indicator"]["Rotation"] = 0
GUI["GUI_Indicator"]["BackgroundColor3"] = Color3.fromRGB(0, 120, 212)
GUI["GUI_Indicator"]["BackgroundTransparency"] = 0
GUI["GUI_Indicator"]["BorderSizePixel"] = 0
GUI["GUI_Indicator"]["ClipsDescendants"] = true
GUI["GUI_Indicator"]["Visible"] = true
GUI["GUI_Indicator"]["Active"] = true
GUI["GUI_Indicator"]["ZIndex"] = 1
GUI["GUI_Indicator"]["LayoutOrder"] = 0
GUI["GUI_Indicator"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Indicator"]["Parent"] = GUI["GUI_TabStore"]

-- TextButton: TabTools
GUI["GUI_TabTools"] = Instance.new("TextButton")
GUI["GUI_TabTools"]["Name"] = "TabTools"
GUI["GUI_TabTools"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TabTools"]["Size"] = UDim2.fromOffset(90, 24)
GUI["GUI_TabTools"]["Position"] = UDim2.fromOffset(90, 0)
GUI["GUI_TabTools"]["Rotation"] = 0
GUI["GUI_TabTools"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_TabTools"]["BackgroundTransparency"] = 0
GUI["GUI_TabTools"]["BorderSizePixel"] = 0
GUI["GUI_TabTools"]["Visible"] = true
GUI["GUI_TabTools"]["Active"] = true
GUI["GUI_TabTools"]["ZIndex"] = 2
GUI["GUI_TabTools"]["LayoutOrder"] = 0
GUI["GUI_TabTools"]["Text"] = ""
GUI["GUI_TabTools"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_TabTools"]["TextSize"] = 14
GUI["GUI_TabTools"]["TextScaled"] = false
GUI["GUI_TabTools"]["TextWrapped"] = true
GUI["GUI_TabTools"]["TextTransparency"] = 0
GUI["GUI_TabTools"]["Font"] = Enum.Font.SourceSansBold
GUI["GUI_TabTools"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_TabTools"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_TabTools"]["RichText"] = false
GUI["GUI_TabTools"]["AutoButtonColor"] = true
GUI["GUI_TabTools"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TabTools"]["Parent"] = GUI["GUI_TabBar"]

-- Frame: LLine
GUI["GUI_LLine"] = Instance.new("Frame")
GUI["GUI_LLine"]["Name"] = "LLine"
GUI["GUI_LLine"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_LLine"]["Size"] = UDim2.fromOffset(1, 24)
GUI["GUI_LLine"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_LLine"]["Rotation"] = 0
GUI["GUI_LLine"]["BackgroundColor3"] = Color3.fromRGB(12, 12, 12)
GUI["GUI_LLine"]["BackgroundTransparency"] = 0
GUI["GUI_LLine"]["BorderSizePixel"] = 0
GUI["GUI_LLine"]["ClipsDescendants"] = true
GUI["GUI_LLine"]["Visible"] = true
GUI["GUI_LLine"]["Active"] = true
GUI["GUI_LLine"]["ZIndex"] = 1
GUI["GUI_LLine"]["LayoutOrder"] = 0
GUI["GUI_LLine"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_LLine"]["Parent"] = GUI["GUI_TabTools"]

-- ImageLabel: Icon
GUI["GUI_Icon_1"] = Instance.new("ImageLabel")
GUI["GUI_Icon_1"]["Name"] = "Icon"
GUI["GUI_Icon_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon_1"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_Icon_1"]["Position"] = UDim2.fromOffset(40, 6)
GUI["GUI_Icon_1"]["Rotation"] = 0
GUI["GUI_Icon_1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon_1"]["BackgroundTransparency"] = 1
GUI["GUI_Icon_1"]["BorderSizePixel"] = 0
GUI["GUI_Icon_1"]["Visible"] = true
GUI["GUI_Icon_1"]["Active"] = false
GUI["GUI_Icon_1"]["ZIndex"] = 1
GUI["GUI_Icon_1"]["LayoutOrder"] = 0
GUI["GUI_Icon_1"]["Image"] = "rbxassetid://111574571964024"
GUI["GUI_Icon_1"]["ImageTransparency"] = 0
GUI["GUI_Icon_1"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon_1"]["Parent"] = GUI["GUI_TabTools"]

-- Frame: RLine
GUI["GUI_RLine"] = Instance.new("Frame")
GUI["GUI_RLine"]["Name"] = "RLine"
GUI["GUI_RLine"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_RLine"]["Size"] = UDim2.fromOffset(1, 24)
GUI["GUI_RLine"]["Position"] = UDim2.fromOffset(90, 0)
GUI["GUI_RLine"]["Rotation"] = 0
GUI["GUI_RLine"]["BackgroundColor3"] = Color3.fromRGB(12, 12, 12)
GUI["GUI_RLine"]["BackgroundTransparency"] = 0
GUI["GUI_RLine"]["BorderSizePixel"] = 0
GUI["GUI_RLine"]["ClipsDescendants"] = true
GUI["GUI_RLine"]["Visible"] = false
GUI["GUI_RLine"]["Active"] = true
GUI["GUI_RLine"]["ZIndex"] = 1
GUI["GUI_RLine"]["LayoutOrder"] = 0
GUI["GUI_RLine"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_RLine"]["Parent"] = GUI["GUI_TabTools"]

-- Frame: BLine
GUI["GUI_BLine"] = Instance.new("Frame")
GUI["GUI_BLine"]["Name"] = "BLine"
GUI["GUI_BLine"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_BLine"]["Size"] = UDim2.fromOffset(90, 1)
GUI["GUI_BLine"]["Position"] = UDim2.fromOffset(0, 24)
GUI["GUI_BLine"]["Rotation"] = 0
GUI["GUI_BLine"]["BackgroundColor3"] = Color3.fromRGB(12, 12, 12)
GUI["GUI_BLine"]["BackgroundTransparency"] = 0
GUI["GUI_BLine"]["BorderSizePixel"] = 0
GUI["GUI_BLine"]["ClipsDescendants"] = true
GUI["GUI_BLine"]["Visible"] = true
GUI["GUI_BLine"]["Active"] = true
GUI["GUI_BLine"]["ZIndex"] = 1
GUI["GUI_BLine"]["LayoutOrder"] = 0
GUI["GUI_BLine"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_BLine"]["Parent"] = GUI["GUI_TabTools"]

-- TextButton: TabTerrain
GUI["GUI_TabTerrain"] = Instance.new("TextButton")
GUI["GUI_TabTerrain"]["Name"] = "TabTerrain"
GUI["GUI_TabTerrain"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TabTerrain"]["Size"] = UDim2.fromOffset(85, 24)
GUI["GUI_TabTerrain"]["Position"] = UDim2.fromOffset(180, 0)
GUI["GUI_TabTerrain"]["Rotation"] = 0
GUI["GUI_TabTerrain"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_TabTerrain"]["BackgroundTransparency"] = 0
GUI["GUI_TabTerrain"]["BorderSizePixel"] = 0
GUI["GUI_TabTerrain"]["Visible"] = true
GUI["GUI_TabTerrain"]["Active"] = true
GUI["GUI_TabTerrain"]["ZIndex"] = 1
GUI["GUI_TabTerrain"]["LayoutOrder"] = 0
GUI["GUI_TabTerrain"]["Text"] = ""
GUI["GUI_TabTerrain"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_TabTerrain"]["TextSize"] = 14
GUI["GUI_TabTerrain"]["TextScaled"] = false
GUI["GUI_TabTerrain"]["TextWrapped"] = true
GUI["GUI_TabTerrain"]["TextTransparency"] = 0
GUI["GUI_TabTerrain"]["Font"] = Enum.Font.SourceSansBold
GUI["GUI_TabTerrain"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_TabTerrain"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_TabTerrain"]["RichText"] = false
GUI["GUI_TabTerrain"]["AutoButtonColor"] = true
GUI["GUI_TabTerrain"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TabTerrain"]["Parent"] = GUI["GUI_TabBar"]

-- ImageLabel: Icon
GUI["GUI_Icon_2"] = Instance.new("ImageLabel")
GUI["GUI_Icon_2"]["Name"] = "Icon"
GUI["GUI_Icon_2"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon_2"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_Icon_2"]["Position"] = UDim2.fromOffset(40, 6)
GUI["GUI_Icon_2"]["Rotation"] = 0
GUI["GUI_Icon_2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon_2"]["BackgroundTransparency"] = 1
GUI["GUI_Icon_2"]["BorderSizePixel"] = 0
GUI["GUI_Icon_2"]["Visible"] = true
GUI["GUI_Icon_2"]["Active"] = true
GUI["GUI_Icon_2"]["ZIndex"] = 1
GUI["GUI_Icon_2"]["LayoutOrder"] = 0
GUI["GUI_Icon_2"]["Image"] = "rbxassetid://127282455310961"
GUI["GUI_Icon_2"]["ImageTransparency"] = 0
GUI["GUI_Icon_2"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon_2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon_2"]["Parent"] = GUI["GUI_TabTerrain"]

-- Frame: B2Line
GUI["GUI_B2Line"] = Instance.new("Frame")
GUI["GUI_B2Line"]["Name"] = "B2Line"
GUI["GUI_B2Line"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_B2Line"]["Size"] = UDim2.fromOffset(90, 1)
GUI["GUI_B2Line"]["Position"] = UDim2.fromOffset(0, 24)
GUI["GUI_B2Line"]["Rotation"] = 0
GUI["GUI_B2Line"]["BackgroundColor3"] = Color3.fromRGB(12, 12, 12)
GUI["GUI_B2Line"]["BackgroundTransparency"] = 0
GUI["GUI_B2Line"]["BorderSizePixel"] = 0
GUI["GUI_B2Line"]["ClipsDescendants"] = true
GUI["GUI_B2Line"]["Visible"] = true
GUI["GUI_B2Line"]["Active"] = true
GUI["GUI_B2Line"]["ZIndex"] = 2
GUI["GUI_B2Line"]["LayoutOrder"] = 0
GUI["GUI_B2Line"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_B2Line"]["Parent"] = GUI["GUI_TabTerrain"]

-- Frame: Store
GUI["GUI_Store"] = Instance.new("Frame")
GUI["GUI_Store"]["Name"] = "Store"
GUI["GUI_Store"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Store"]["Size"] = UDim2.new(0, 265, 1, -40)
GUI["GUI_Store"]["Position"] = UDim2.fromOffset(0, 40)
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

-- Frame: Tools
GUI["GUI_Tools"] = Instance.new("Frame")
GUI["GUI_Tools"]["Name"] = "Tools"
GUI["GUI_Tools"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Tools"]["Size"] = UDim2.new(0, 265, 1, -40)
GUI["GUI_Tools"]["Position"] = UDim2.fromOffset(0, 40)
GUI["GUI_Tools"]["Rotation"] = 0
GUI["GUI_Tools"]["BackgroundColor3"] = Color3.fromRGB(45, 45, 48)
GUI["GUI_Tools"]["BackgroundTransparency"] = 1
GUI["GUI_Tools"]["BorderSizePixel"] = 0
GUI["GUI_Tools"]["ClipsDescendants"] = true
GUI["GUI_Tools"]["Visible"] = false
GUI["GUI_Tools"]["Active"] = true
GUI["GUI_Tools"]["ZIndex"] = 1
GUI["GUI_Tools"]["LayoutOrder"] = 0
GUI["GUI_Tools"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Tools"]["Parent"] = GUI["GUI_Panel"]

-- Frame: Toolbar
GUI["GUI_Toolbar_1"] = Instance.new("Frame")
GUI["GUI_Toolbar_1"]["Name"] = "Toolbar"
GUI["GUI_Toolbar_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Toolbar_1"]["Size"] = UDim2.fromOffset(265, 40)
GUI["GUI_Toolbar_1"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Toolbar_1"]["Rotation"] = 0
GUI["GUI_Toolbar_1"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_Toolbar_1"]["BackgroundTransparency"] = 0
GUI["GUI_Toolbar_1"]["BorderSizePixel"] = 0
GUI["GUI_Toolbar_1"]["ClipsDescendants"] = true
GUI["GUI_Toolbar_1"]["Visible"] = true
GUI["GUI_Toolbar_1"]["Active"] = true
GUI["GUI_Toolbar_1"]["ZIndex"] = 1
GUI["GUI_Toolbar_1"]["LayoutOrder"] = 0
GUI["GUI_Toolbar_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Toolbar_1"]["Parent"] = GUI["GUI_Tools"]

-- Frame: SearchBox
GUI["GUI_SearchBox_1"] = Instance.new("Frame")
GUI["GUI_SearchBox_1"]["Name"] = "SearchBox"
GUI["GUI_SearchBox_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SearchBox_1"]["Size"] = UDim2.fromOffset(195, 22)
GUI["GUI_SearchBox_1"]["Position"] = UDim2.fromOffset(10, 10)
GUI["GUI_SearchBox_1"]["Rotation"] = 0
GUI["GUI_SearchBox_1"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_SearchBox_1"]["BackgroundTransparency"] = 0
GUI["GUI_SearchBox_1"]["BorderSizePixel"] = 0
GUI["GUI_SearchBox_1"]["ClipsDescendants"] = false
GUI["GUI_SearchBox_1"]["Visible"] = true
GUI["GUI_SearchBox_1"]["Active"] = true
GUI["GUI_SearchBox_1"]["ZIndex"] = 1
GUI["GUI_SearchBox_1"]["LayoutOrder"] = 0
GUI["GUI_SearchBox_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SearchBox_1"]["Parent"] = GUI["GUI_Toolbar_1"]

-- UIStroke: UIStroke
GUI["GUI_UIStroke_2"] = Instance.new("UIStroke")
GUI["GUI_UIStroke_2"]["Name"] = "UIStroke"
GUI["GUI_UIStroke_2"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Contextual
GUI["GUI_UIStroke_2"]["Color"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_UIStroke_2"]["Enabled"] = true
GUI["GUI_UIStroke_2"]["LineJoinMode"] = Enum.LineJoinMode.Round
GUI["GUI_UIStroke_2"]["Thickness"] = 0.5
GUI["GUI_UIStroke_2"]["Transparency"] = 0
GUI["GUI_UIStroke_2"]["Parent"] = GUI["GUI_SearchBox_1"]

-- TextBox: Input
GUI["GUI_Input_1"] = Instance.new("TextBox")
GUI["GUI_Input_1"]["Name"] = "Input"
GUI["GUI_Input_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Input_1"]["Size"] = UDim2.fromOffset(167, 22)
GUI["GUI_Input_1"]["Position"] = UDim2.fromOffset(5, 0)
GUI["GUI_Input_1"]["Rotation"] = 0
GUI["GUI_Input_1"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Input_1"]["BackgroundTransparency"] = 1
GUI["GUI_Input_1"]["BorderSizePixel"] = 0
GUI["GUI_Input_1"]["Visible"] = true
GUI["GUI_Input_1"]["Active"] = true
GUI["GUI_Input_1"]["ZIndex"] = 1
GUI["GUI_Input_1"]["LayoutOrder"] = 0
GUI["GUI_Input_1"]["Text"] = ""
GUI["GUI_Input_1"]["TextColor3"] = Color3.fromRGB(250, 250, 250)
GUI["GUI_Input_1"]["TextSize"] = 12
GUI["GUI_Input_1"]["TextScaled"] = false
GUI["GUI_Input_1"]["TextWrapped"] = false
GUI["GUI_Input_1"]["TextTransparency"] = 0
GUI["GUI_Input_1"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_Input_1"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_Input_1"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_Input_1"]["RichText"] = false
GUI["GUI_Input_1"]["PlaceholderText"] = "Enter search..."
GUI["GUI_Input_1"]["PlaceholderColor3"] = Color3.fromRGB(65, 65, 65)
GUI["GUI_Input_1"]["TextEditable"] = true
GUI["GUI_Input_1"]["ClearTextOnFocus"] = false
GUI["GUI_Input_1"]["MultiLine"] = false
GUI["GUI_Input_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Input_1"]["Parent"] = GUI["GUI_SearchBox_1"]

-- ImageButton: SearchBtn
GUI["GUI_SearchBtn_1"] = Instance.new("ImageButton")
GUI["GUI_SearchBtn_1"]["Name"] = "SearchBtn"
GUI["GUI_SearchBtn_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_SearchBtn_1"]["Size"] = UDim2.fromOffset(14, 14)
GUI["GUI_SearchBtn_1"]["Position"] = UDim2.fromOffset(175, 4)
GUI["GUI_SearchBtn_1"]["Rotation"] = 0
GUI["GUI_SearchBtn_1"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_SearchBtn_1"]["BackgroundTransparency"] = 1
GUI["GUI_SearchBtn_1"]["BorderSizePixel"] = 0
GUI["GUI_SearchBtn_1"]["Visible"] = true
GUI["GUI_SearchBtn_1"]["Active"] = true
GUI["GUI_SearchBtn_1"]["ZIndex"] = 1
GUI["GUI_SearchBtn_1"]["LayoutOrder"] = 0
GUI["GUI_SearchBtn_1"]["AutoButtonColor"] = true
GUI["GUI_SearchBtn_1"]["Image"] = "rbxassetid://121018724060431"
GUI["GUI_SearchBtn_1"]["ImageTransparency"] = 0
GUI["GUI_SearchBtn_1"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_SearchBtn_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_SearchBtn_1"]["Parent"] = GUI["GUI_SearchBox_1"]

-- UICorner: UICorner
GUI["GUI_UICorner_11"] = Instance.new("UICorner")
GUI["GUI_UICorner_11"]["Name"] = "UICorner"
GUI["GUI_UICorner_11"]["CornerRadius"] = UDim.new(0.0, 3)
GUI["GUI_UICorner_11"]["Parent"] = GUI["GUI_SearchBox_1"]

-- Frame: Terrain
GUI["GUI_Terrain"] = Instance.new("Frame")
GUI["GUI_Terrain"]["Name"] = "Terrain"
GUI["GUI_Terrain"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Terrain"]["Size"] = UDim2.new(0, 265, 1, -40)
GUI["GUI_Terrain"]["Position"] = UDim2.fromOffset(0, 40)
GUI["GUI_Terrain"]["Rotation"] = 0
GUI["GUI_Terrain"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_Terrain"]["BackgroundTransparency"] = 0
GUI["GUI_Terrain"]["BorderSizePixel"] = 0
GUI["GUI_Terrain"]["ClipsDescendants"] = true
GUI["GUI_Terrain"]["Visible"] = true
GUI["GUI_Terrain"]["Active"] = true
GUI["GUI_Terrain"]["ZIndex"] = 1
GUI["GUI_Terrain"]["LayoutOrder"] = 0
GUI["GUI_Terrain"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Terrain"]["Parent"] = GUI["GUI_Panel"]

-- Frame: Titlebar
GUI["GUI_Titlebar"] = Instance.new("Frame")
GUI["GUI_Titlebar"]["Name"] = "Titlebar"
GUI["GUI_Titlebar"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Titlebar"]["Size"] = UDim2.fromOffset(265, 20)
GUI["GUI_Titlebar"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Titlebar"]["Rotation"] = 0
GUI["GUI_Titlebar"]["BackgroundColor3"] = Color3.fromRGB(34, 34, 34)
GUI["GUI_Titlebar"]["BackgroundTransparency"] = 0
GUI["GUI_Titlebar"]["BorderSizePixel"] = 0
GUI["GUI_Titlebar"]["ClipsDescendants"] = true
GUI["GUI_Titlebar"]["Visible"] = true
GUI["GUI_Titlebar"]["Active"] = true
GUI["GUI_Titlebar"]["ZIndex"] = 1
GUI["GUI_Titlebar"]["LayoutOrder"] = 0
GUI["GUI_Titlebar"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Titlebar"]["Parent"] = GUI["GUI_Terrain"]

-- TextLabel: TextLabel
GUI["GUI_TextLabel"] = Instance.new("TextLabel")
GUI["GUI_TextLabel"]["Name"] = "TextLabel"
GUI["GUI_TextLabel"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_TextLabel"]["Size"] = UDim2.fromOffset(265, 16)
GUI["GUI_TextLabel"]["Position"] = UDim2.fromOffset(0, 4)
GUI["GUI_TextLabel"]["Rotation"] = 0
GUI["GUI_TextLabel"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_TextLabel"]["BackgroundTransparency"] = 1
GUI["GUI_TextLabel"]["BorderSizePixel"] = 0
GUI["GUI_TextLabel"]["Visible"] = true
GUI["GUI_TextLabel"]["Active"] = true
GUI["GUI_TextLabel"]["ZIndex"] = 1
GUI["GUI_TextLabel"]["LayoutOrder"] = 0
GUI["GUI_TextLabel"]["Text"] = "Editor Terrain"
GUI["GUI_TextLabel"]["TextColor3"] = Color3.fromRGB(209, 213, 219)
GUI["GUI_TextLabel"]["TextSize"] = 9
GUI["GUI_TextLabel"]["TextScaled"] = false
GUI["GUI_TextLabel"]["TextWrapped"] = true
GUI["GUI_TextLabel"]["TextTransparency"] = 0
GUI["GUI_TextLabel"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_TextLabel"]["TextXAlignment"] = Enum.TextXAlignment.Center
GUI["GUI_TextLabel"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_TextLabel"]["RichText"] = false
GUI["GUI_TextLabel"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_TextLabel"]["Parent"] = GUI["GUI_Titlebar"]

-- ScrollingFrame: ScrollingFrame
GUI["GUI_ScrollingFrame_1"] = Instance.new("ScrollingFrame")
GUI["GUI_ScrollingFrame_1"]["Name"] = "ScrollingFrame"
GUI["GUI_ScrollingFrame_1"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ScrollingFrame_1"]["Size"] = UDim2.new(0, 265, 1, -20)
GUI["GUI_ScrollingFrame_1"]["Position"] = UDim2.fromOffset(0, 20)
GUI["GUI_ScrollingFrame_1"]["Rotation"] = 0
GUI["GUI_ScrollingFrame_1"]["CanvasSize"] = UDim2.fromScale(0, 2)
GUI["GUI_ScrollingFrame_1"]["ScrollingDirection"] = Enum.ScrollingDirection.Y
GUI["GUI_ScrollingFrame_1"]["ScrollBarThickness"] = 0
GUI["GUI_ScrollingFrame_1"]["BackgroundColor3"] = Color3.fromRGB(35, 35, 35)
GUI["GUI_ScrollingFrame_1"]["BackgroundTransparency"] = 1
GUI["GUI_ScrollingFrame_1"]["BorderSizePixel"] = 0
GUI["GUI_ScrollingFrame_1"]["ClipsDescendants"] = true
GUI["GUI_ScrollingFrame_1"]["Visible"] = true
GUI["GUI_ScrollingFrame_1"]["Active"] = true
GUI["GUI_ScrollingFrame_1"]["ZIndex"] = 1
GUI["GUI_ScrollingFrame_1"]["LayoutOrder"] = 0
GUI["GUI_ScrollingFrame_1"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ScrollingFrame_1"]["Parent"] = GUI["GUI_Terrain"]

-- UIListLayout: UIListLayout
GUI["GUI_UIListLayout_1"] = Instance.new("UIListLayout")
GUI["GUI_UIListLayout_1"]["Name"] = "UIListLayout"
GUI["GUI_UIListLayout_1"]["FillDirection"] = Enum.FillDirection.Vertical
GUI["GUI_UIListLayout_1"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Left
GUI["GUI_UIListLayout_1"]["Padding"] = UDim.new(0.0, 0)
GUI["GUI_UIListLayout_1"]["SortOrder"] = Enum.SortOrder.LayoutOrder
GUI["GUI_UIListLayout_1"]["VerticalAlignment"] = Enum.VerticalAlignment.Top
GUI["GUI_UIListLayout_1"]["Parent"] = GUI["GUI_ScrollingFrame_1"]

-- Frame: CardEdit
GUI["GUI_CardEdit"] = Instance.new("Frame")
GUI["GUI_CardEdit"]["Name"] = "CardEdit"
GUI["GUI_CardEdit"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CardEdit"]["Size"] = UDim2.fromOffset(255, 120)
GUI["GUI_CardEdit"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_CardEdit"]["Rotation"] = 0
GUI["GUI_CardEdit"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_CardEdit"]["BackgroundTransparency"] = 0
GUI["GUI_CardEdit"]["BorderSizePixel"] = 0
GUI["GUI_CardEdit"]["ClipsDescendants"] = true
GUI["GUI_CardEdit"]["Visible"] = true
GUI["GUI_CardEdit"]["Active"] = true
GUI["GUI_CardEdit"]["ZIndex"] = 1
GUI["GUI_CardEdit"]["LayoutOrder"] = 0
GUI["GUI_CardEdit"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CardEdit"]["Parent"] = GUI["GUI_ScrollingFrame_1"]

-- TextButton: EDropdown
GUI["GUI_EDropdown"] = Instance.new("TextButton")
GUI["GUI_EDropdown"]["Name"] = "EDropdown"
GUI["GUI_EDropdown"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_EDropdown"]["Size"] = UDim2.fromOffset(265, 18)
GUI["GUI_EDropdown"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_EDropdown"]["Rotation"] = 0
GUI["GUI_EDropdown"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_EDropdown"]["BackgroundTransparency"] = 0
GUI["GUI_EDropdown"]["BorderSizePixel"] = 0
GUI["GUI_EDropdown"]["Visible"] = true
GUI["GUI_EDropdown"]["Active"] = true
GUI["GUI_EDropdown"]["ZIndex"] = 1
GUI["GUI_EDropdown"]["LayoutOrder"] = 0
GUI["GUI_EDropdown"]["Text"] = "         Edit Mode"
GUI["GUI_EDropdown"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_EDropdown"]["TextSize"] = 9
GUI["GUI_EDropdown"]["TextScaled"] = false
GUI["GUI_EDropdown"]["TextWrapped"] = true
GUI["GUI_EDropdown"]["TextTransparency"] = 0
GUI["GUI_EDropdown"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_EDropdown"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_EDropdown"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_EDropdown"]["RichText"] = false
GUI["GUI_EDropdown"]["AutoButtonColor"] = true
GUI["GUI_EDropdown"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_EDropdown"]["Parent"] = GUI["GUI_CardEdit"]

-- ImageLabel: Icon
GUI["GUI_Icon_3"] = Instance.new("ImageLabel")
GUI["GUI_Icon_3"]["Name"] = "Icon"
GUI["GUI_Icon_3"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon_3"]["Size"] = UDim2.fromOffset(10, 10)
GUI["GUI_Icon_3"]["Position"] = UDim2.fromOffset(5, 4)
GUI["GUI_Icon_3"]["Rotation"] = 0
GUI["GUI_Icon_3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon_3"]["BackgroundTransparency"] = 1
GUI["GUI_Icon_3"]["BorderSizePixel"] = 0
GUI["GUI_Icon_3"]["Visible"] = true
GUI["GUI_Icon_3"]["Active"] = false
GUI["GUI_Icon_3"]["ZIndex"] = 1
GUI["GUI_Icon_3"]["LayoutOrder"] = 0
GUI["GUI_Icon_3"]["Image"] = "rbxassetid://139953983876976"
GUI["GUI_Icon_3"]["ImageTransparency"] = 0
GUI["GUI_Icon_3"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon_3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon_3"]["Parent"] = GUI["GUI_EDropdown"]

-- Frame: ContentEdit
GUI["GUI_ContentEdit"] = Instance.new("Frame")
GUI["GUI_ContentEdit"]["Name"] = "ContentEdit"
GUI["GUI_ContentEdit"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ContentEdit"]["Size"] = UDim2.fromOffset(265, 100)
GUI["GUI_ContentEdit"]["Position"] = UDim2.fromOffset(0, 18)
GUI["GUI_ContentEdit"]["Rotation"] = 0
GUI["GUI_ContentEdit"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_ContentEdit"]["BackgroundTransparency"] = 0
GUI["GUI_ContentEdit"]["BorderSizePixel"] = 0
GUI["GUI_ContentEdit"]["ClipsDescendants"] = true
GUI["GUI_ContentEdit"]["Visible"] = true
GUI["GUI_ContentEdit"]["Active"] = true
GUI["GUI_ContentEdit"]["ZIndex"] = 1
GUI["GUI_ContentEdit"]["LayoutOrder"] = 0
GUI["GUI_ContentEdit"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ContentEdit"]["Parent"] = GUI["GUI_CardEdit"]

-- Frame: CardBrush
GUI["GUI_CardBrush"] = Instance.new("Frame")
GUI["GUI_CardBrush"]["Name"] = "CardBrush"
GUI["GUI_CardBrush"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CardBrush"]["Size"] = UDim2.fromOffset(255, 240)
GUI["GUI_CardBrush"]["Position"] = UDim2.fromOffset(0, 120)
GUI["GUI_CardBrush"]["Rotation"] = 0
GUI["GUI_CardBrush"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_CardBrush"]["BackgroundTransparency"] = 0
GUI["GUI_CardBrush"]["BorderSizePixel"] = 0
GUI["GUI_CardBrush"]["ClipsDescendants"] = true
GUI["GUI_CardBrush"]["Visible"] = true
GUI["GUI_CardBrush"]["Active"] = true
GUI["GUI_CardBrush"]["ZIndex"] = 1
GUI["GUI_CardBrush"]["LayoutOrder"] = 0
GUI["GUI_CardBrush"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CardBrush"]["Parent"] = GUI["GUI_ScrollingFrame_1"]

-- TextButton: BDropdown
GUI["GUI_BDropdown"] = Instance.new("TextButton")
GUI["GUI_BDropdown"]["Name"] = "BDropdown"
GUI["GUI_BDropdown"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_BDropdown"]["Size"] = UDim2.fromOffset(265, 18)
GUI["GUI_BDropdown"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_BDropdown"]["Rotation"] = 0
GUI["GUI_BDropdown"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_BDropdown"]["BackgroundTransparency"] = 0
GUI["GUI_BDropdown"]["BorderSizePixel"] = 0
GUI["GUI_BDropdown"]["Visible"] = true
GUI["GUI_BDropdown"]["Active"] = true
GUI["GUI_BDropdown"]["ZIndex"] = 1
GUI["GUI_BDropdown"]["LayoutOrder"] = 0
GUI["GUI_BDropdown"]["Text"] = "         Brush Settings"
GUI["GUI_BDropdown"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_BDropdown"]["TextSize"] = 9
GUI["GUI_BDropdown"]["TextScaled"] = false
GUI["GUI_BDropdown"]["TextWrapped"] = true
GUI["GUI_BDropdown"]["TextTransparency"] = 0
GUI["GUI_BDropdown"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_BDropdown"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_BDropdown"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_BDropdown"]["RichText"] = false
GUI["GUI_BDropdown"]["AutoButtonColor"] = true
GUI["GUI_BDropdown"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_BDropdown"]["Parent"] = GUI["GUI_CardBrush"]

-- ImageLabel: Icon
GUI["GUI_Icon_4"] = Instance.new("ImageLabel")
GUI["GUI_Icon_4"]["Name"] = "Icon"
GUI["GUI_Icon_4"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon_4"]["Size"] = UDim2.fromOffset(10, 10)
GUI["GUI_Icon_4"]["Position"] = UDim2.fromOffset(5, 4)
GUI["GUI_Icon_4"]["Rotation"] = 0
GUI["GUI_Icon_4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon_4"]["BackgroundTransparency"] = 1
GUI["GUI_Icon_4"]["BorderSizePixel"] = 0
GUI["GUI_Icon_4"]["Visible"] = true
GUI["GUI_Icon_4"]["Active"] = false
GUI["GUI_Icon_4"]["ZIndex"] = 1
GUI["GUI_Icon_4"]["LayoutOrder"] = 0
GUI["GUI_Icon_4"]["Image"] = "rbxassetid://139953983876976"
GUI["GUI_Icon_4"]["ImageTransparency"] = 0
GUI["GUI_Icon_4"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon_4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon_4"]["Parent"] = GUI["GUI_BDropdown"]

-- Frame: ContentBrush
GUI["GUI_ContentBrush"] = Instance.new("Frame")
GUI["GUI_ContentBrush"]["Name"] = "ContentBrush"
GUI["GUI_ContentBrush"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ContentBrush"]["Size"] = UDim2.fromOffset(265, 222)
GUI["GUI_ContentBrush"]["Position"] = UDim2.fromOffset(0, 18)
GUI["GUI_ContentBrush"]["Rotation"] = 0
GUI["GUI_ContentBrush"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_ContentBrush"]["BackgroundTransparency"] = 0
GUI["GUI_ContentBrush"]["BorderSizePixel"] = 0
GUI["GUI_ContentBrush"]["ClipsDescendants"] = true
GUI["GUI_ContentBrush"]["Visible"] = true
GUI["GUI_ContentBrush"]["Active"] = true
GUI["GUI_ContentBrush"]["ZIndex"] = 1
GUI["GUI_ContentBrush"]["LayoutOrder"] = 0
GUI["GUI_ContentBrush"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ContentBrush"]["Parent"] = GUI["GUI_CardBrush"]

-- Frame: CardMaterial
GUI["GUI_CardMaterial"] = Instance.new("Frame")
GUI["GUI_CardMaterial"]["Name"] = "CardMaterial"
GUI["GUI_CardMaterial"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_CardMaterial"]["Size"] = UDim2.fromOffset(255, 222)
GUI["GUI_CardMaterial"]["Position"] = UDim2.fromOffset(0, 360)
GUI["GUI_CardMaterial"]["Rotation"] = 0
GUI["GUI_CardMaterial"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_CardMaterial"]["BackgroundTransparency"] = 0
GUI["GUI_CardMaterial"]["BorderSizePixel"] = 0
GUI["GUI_CardMaterial"]["ClipsDescendants"] = true
GUI["GUI_CardMaterial"]["Visible"] = true
GUI["GUI_CardMaterial"]["Active"] = true
GUI["GUI_CardMaterial"]["ZIndex"] = 1
GUI["GUI_CardMaterial"]["LayoutOrder"] = 0
GUI["GUI_CardMaterial"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_CardMaterial"]["Parent"] = GUI["GUI_ScrollingFrame_1"]

-- TextButton: MDropdown
GUI["GUI_MDropdown"] = Instance.new("TextButton")
GUI["GUI_MDropdown"]["Name"] = "MDropdown"
GUI["GUI_MDropdown"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_MDropdown"]["Size"] = UDim2.fromOffset(265, 18)
GUI["GUI_MDropdown"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_MDropdown"]["Rotation"] = 0
GUI["GUI_MDropdown"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27)
GUI["GUI_MDropdown"]["BackgroundTransparency"] = 0
GUI["GUI_MDropdown"]["BorderSizePixel"] = 0
GUI["GUI_MDropdown"]["Visible"] = true
GUI["GUI_MDropdown"]["Active"] = true
GUI["GUI_MDropdown"]["ZIndex"] = 1
GUI["GUI_MDropdown"]["LayoutOrder"] = 0
GUI["GUI_MDropdown"]["Text"] = "         Material Settings"
GUI["GUI_MDropdown"]["TextColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_MDropdown"]["TextSize"] = 9
GUI["GUI_MDropdown"]["TextScaled"] = false
GUI["GUI_MDropdown"]["TextWrapped"] = true
GUI["GUI_MDropdown"]["TextTransparency"] = 0
GUI["GUI_MDropdown"]["Font"] = Enum.Font.GothamMedium
GUI["GUI_MDropdown"]["TextXAlignment"] = Enum.TextXAlignment.Left
GUI["GUI_MDropdown"]["TextYAlignment"] = Enum.TextYAlignment.Center
GUI["GUI_MDropdown"]["RichText"] = false
GUI["GUI_MDropdown"]["AutoButtonColor"] = true
GUI["GUI_MDropdown"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_MDropdown"]["Parent"] = GUI["GUI_CardMaterial"]

-- ImageLabel: Icon
GUI["GUI_Icon_5"] = Instance.new("ImageLabel")
GUI["GUI_Icon_5"]["Name"] = "Icon"
GUI["GUI_Icon_5"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Icon_5"]["Size"] = UDim2.fromOffset(10, 10)
GUI["GUI_Icon_5"]["Position"] = UDim2.fromOffset(5, 3)
GUI["GUI_Icon_5"]["Rotation"] = 0
GUI["GUI_Icon_5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255)
GUI["GUI_Icon_5"]["BackgroundTransparency"] = 1
GUI["GUI_Icon_5"]["BorderSizePixel"] = 0
GUI["GUI_Icon_5"]["Visible"] = true
GUI["GUI_Icon_5"]["Active"] = false
GUI["GUI_Icon_5"]["ZIndex"] = 1
GUI["GUI_Icon_5"]["LayoutOrder"] = 0
GUI["GUI_Icon_5"]["Image"] = "rbxassetid://139953983876976"
GUI["GUI_Icon_5"]["ImageTransparency"] = 0
GUI["GUI_Icon_5"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Icon_5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Icon_5"]["Parent"] = GUI["GUI_MDropdown"]

-- Frame: ContentMaterial
GUI["GUI_ContentMaterial"] = Instance.new("Frame")
GUI["GUI_ContentMaterial"]["Name"] = "ContentMaterial"
GUI["GUI_ContentMaterial"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_ContentMaterial"]["Size"] = UDim2.fromOffset(265, 202)
GUI["GUI_ContentMaterial"]["Position"] = UDim2.fromOffset(0, 20)
GUI["GUI_ContentMaterial"]["Rotation"] = 0
GUI["GUI_ContentMaterial"]["BackgroundColor3"] = Color3.fromRGB(14, 14, 14)
GUI["GUI_ContentMaterial"]["BackgroundTransparency"] = 0
GUI["GUI_ContentMaterial"]["BorderSizePixel"] = 0
GUI["GUI_ContentMaterial"]["ClipsDescendants"] = true
GUI["GUI_ContentMaterial"]["Visible"] = true
GUI["GUI_ContentMaterial"]["Active"] = true
GUI["GUI_ContentMaterial"]["ZIndex"] = 1
GUI["GUI_ContentMaterial"]["LayoutOrder"] = 0
GUI["GUI_ContentMaterial"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_ContentMaterial"]["Parent"] = GUI["GUI_CardMaterial"]

-- Frame: Scrollbar
GUI["GUI_Scrollbar"] = Instance.new("Frame")
GUI["GUI_Scrollbar"]["Name"] = "Scrollbar"
GUI["GUI_Scrollbar"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Scrollbar"]["Size"] = UDim2.new(0, 12, 1, -20)
GUI["GUI_Scrollbar"]["Position"] = UDim2.fromOffset(253, 20)
GUI["GUI_Scrollbar"]["Rotation"] = 0
GUI["GUI_Scrollbar"]["BackgroundColor3"] = Color3.fromRGB(17, 17, 17)
GUI["GUI_Scrollbar"]["BackgroundTransparency"] = 0
GUI["GUI_Scrollbar"]["BorderSizePixel"] = 0
GUI["GUI_Scrollbar"]["ClipsDescendants"] = false
GUI["GUI_Scrollbar"]["Visible"] = true
GUI["GUI_Scrollbar"]["Active"] = true
GUI["GUI_Scrollbar"]["ZIndex"] = 2
GUI["GUI_Scrollbar"]["LayoutOrder"] = 0
GUI["GUI_Scrollbar"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Scrollbar"]["Parent"] = GUI["GUI_Terrain"]

-- ImageButton: Up
GUI["GUI_Up"] = Instance.new("ImageButton")
GUI["GUI_Up"]["Name"] = "Up"
GUI["GUI_Up"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Up"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_Up"]["Position"] = UDim2.fromScale(0, 0)
GUI["GUI_Up"]["Rotation"] = 0
GUI["GUI_Up"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_Up"]["BackgroundTransparency"] = 0
GUI["GUI_Up"]["BorderSizePixel"] = 0
GUI["GUI_Up"]["Visible"] = true
GUI["GUI_Up"]["Active"] = true
GUI["GUI_Up"]["ZIndex"] = 1
GUI["GUI_Up"]["LayoutOrder"] = 0
GUI["GUI_Up"]["AutoButtonColor"] = true
GUI["GUI_Up"]["Image"] = "rbxassetid://132169295529879"
GUI["GUI_Up"]["ImageTransparency"] = 0
GUI["GUI_Up"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Up"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Up"]["Parent"] = GUI["GUI_Scrollbar"]

-- ImageButton: Handle
GUI["GUI_Handle"] = Instance.new("ImageButton")
GUI["GUI_Handle"]["Name"] = "Handle"
GUI["GUI_Handle"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Handle"]["Size"] = UDim2.fromOffset(12, 72)
GUI["GUI_Handle"]["Position"] = UDim2.fromOffset(0, 12)
GUI["GUI_Handle"]["Rotation"] = 0
GUI["GUI_Handle"]["BackgroundColor3"] = Color3.fromRGB(25, 25, 25)
GUI["GUI_Handle"]["BackgroundTransparency"] = 0
GUI["GUI_Handle"]["BorderSizePixel"] = 0
GUI["GUI_Handle"]["Visible"] = true
GUI["GUI_Handle"]["Active"] = true
GUI["GUI_Handle"]["ZIndex"] = 1
GUI["GUI_Handle"]["LayoutOrder"] = 0
GUI["GUI_Handle"]["AutoButtonColor"] = true
GUI["GUI_Handle"]["Image"] = "rbxassetid://"
GUI["GUI_Handle"]["ImageTransparency"] = 0
GUI["GUI_Handle"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Handle"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Handle"]["Parent"] = GUI["GUI_Scrollbar"]

-- ImageButton: Down
GUI["GUI_Down"] = Instance.new("ImageButton")
GUI["GUI_Down"]["Name"] = "Down"
GUI["GUI_Down"]["AnchorPoint"] = Vector2.new(0.0, 0.0)
GUI["GUI_Down"]["Size"] = UDim2.fromOffset(12, 12)
GUI["GUI_Down"]["Position"] = UDim2.new(0, 0, 1, -12)
GUI["GUI_Down"]["Rotation"] = 0
GUI["GUI_Down"]["BackgroundColor3"] = Color3.fromRGB(22, 22, 22)
GUI["GUI_Down"]["BackgroundTransparency"] = 0
GUI["GUI_Down"]["BorderSizePixel"] = 0
GUI["GUI_Down"]["Visible"] = true
GUI["GUI_Down"]["Active"] = true
GUI["GUI_Down"]["ZIndex"] = 1
GUI["GUI_Down"]["LayoutOrder"] = 0
GUI["GUI_Down"]["AutoButtonColor"] = true
GUI["GUI_Down"]["Image"] = "rbxassetid://139953983876976"
GUI["GUI_Down"]["ImageTransparency"] = 0
GUI["GUI_Down"]["ScaleType"] = Enum.ScaleType.Stretch
GUI["GUI_Down"]["BorderColor3"] = Color3.fromRGB(0, 0, 0)
GUI["GUI_Down"]["Parent"] = GUI["GUI_Scrollbar"]

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

local TabBar = Panel:WaitForChild("TabBar")

local TabStore = TabBar:WaitForChild("TabStore") :: GuiButton
local TabTools = TabBar:WaitForChild("TabTools") :: GuiButton
local TabTerrain = TabBar:WaitForChild("TabTerrain") :: GuiButton

local Indicator = TabStore:WaitForChild("Indicator")
local LLine = TabTools:WaitForChild("LLine")
local BLine = TabTools:WaitForChild("BLine")
local RLine = TabTools:WaitForChild("RLine")
local B2Line = TabTerrain:WaitForChild("B2Line")

local StoreIcon = TabStore:WaitForChild("Icon") :: ImageLabel
local ToolsIcon = TabTools:WaitForChild("Icon") :: ImageLabel
local TerrainIcon = TabTerrain:WaitForChild("Icon") :: ImageLabel

local StoreFrame = Panel:WaitForChild("Store") :: Frame
local ToolsFrame = Panel:WaitForChild("Tools") :: Frame
local TerrainFrame = Panel:WaitForChild("Terrain") :: Frame

local OPEN_RIGHT_ID = "rbxassetid://92473583511724"
local OPEN_LEFT_ID = "rbxassetid://73780377692148"

local MIN_IMAGE = "rbxassetid://118026365011536"
local DROP_IMAGE = "rbxassetid://134243273101015"

local PANEL_TWEEN_INFO = TweenInfo.new(
0.5,
Enum.EasingStyle.Linear,
Enum.EasingDirection.Out
)

local DOCK_POSITION = UDim2.new(0, 0, 0, 78)
local DOCK_SIZE = UDim2.new(0, 270, 1, -78)
local FLOAT_POSITION = UDim2.new(0, 20, 0, 78)
local MIN_SIZE = UDim2.new(0, 270, 0, 16)

local TWEEN_TIME = 0.18

local isOpen = true
local isAnimating = false
local activeTween: Tween? = nil

local docked = true
local minimized = false
local dragging = false

local dragOffset = Vector2.zero
local dragInput: InputObject? = nil
local panelTween: Tween? = nil

local OPEN_POSITION = UDim2.new(0, 0, 0, 78)
local CLOSED_POSITION = OPEN_POSITION

local DOCK_IMAGE = ""

if DockBtn:IsA("ImageButton") then
	DOCK_IMAGE = DockBtn.Image
end

local activeTab = "Store"

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
{ Position = targetPosition }
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

local function UpdateTabContent(tabName: string)
activeTab = tabName

StoreFrame.Visible = tabName == "Store"
ToolsFrame.Visible = tabName == "Tools"
TerrainFrame.Visible = tabName == "Terrain"
end

local function SelectTab(tabName: string)
UpdateTabContent(tabName)

StoreIcon.ImageTransparency = if tabName == "Store" then 0 else 0.5
ToolsIcon.ImageTransparency = if tabName == "Tools" then 0 else 0.5
TerrainIcon.ImageTransparency = if tabName == "Terrain" then 0 else 0.5

if tabName == "Store" then
	Indicator.Parent = TabStore
	Indicator.Visible = true

	BLine.Parent = TabTools
	BLine.Visible = true

	LLine.Parent = TabTools
	LLine.Visible = true

	RLine.Parent = TabTools
	RLine.Visible = false

	B2Line.Parent = TabTerrain
	B2Line.Visible = true

	elseif tabName == "Tools" then
		BLine.Parent = TabStore
		BLine.Visible = true

		Indicator.Parent = TabTools
		Indicator.Visible = true

		LLine.Parent = TabTools
		LLine.Visible = true

		RLine.Parent = TabTools
		RLine.Visible = true

		B2Line.Parent = TabTerrain
		B2Line.Visible = true

		elseif tabName == "Terrain" then
			BLine.Parent = TabStore
			BLine.Visible = true

			B2Line.Parent = TabTools
			B2Line.Visible = true

			LLine.Parent = TabTools
			LLine.Visible = false

			RLine.Parent = TabTools
			RLine.Visible = true

			Indicator.Parent = TabTerrain
			Indicator.Visible = true
		end
	end

	local CONTENT_NAMES = {
	"TabBar",
	"Store",
	"Tools",
	"Terrain",
	}

	local contentFrames: {Frame} = {}
	local originalVisibility: {[Frame]: boolean} = {}

	for _, name in ipairs(CONTENT_NAMES) do
		local child = Panel:FindFirstChild(name)

		if child and child:IsA("Frame") then
			table.insert(contentFrames, child)
			originalVisibility[child] = child.Visible
		end
	end

	local function setButtonImage(button: GuiButton, image: string)
	if button:IsA("ImageButton") then
		button.Image = image
	end
end

local function setContentVisible(visible: boolean)
if not visible then
	for _, frame in ipairs(contentFrames) do
		frame.Visible = false
	end
	return
end

TabBar.Visible = originalVisibility[TabBar] ~= false
UpdateTabContent(activeTab)
end

local function stopPanelTween()
if panelTween then
	panelTween:Cancel()
	panelTween = nil
end
end

local function tweenPanel(
position: UDim2,
size: UDim2,
onComplete: (() -> ())?
)
stopPanelTween()

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

local function pointerPosition(input: InputObject): Vector2
return Vector2.new(input.Position.X, input.Position.Y)
end

local function getRect(gui: GuiObject)
local position = gui.AbsolutePosition
local size = gui.AbsoluteSize

return position.X,
position.Y,
position.X + size.X,
position.Y + size.Y
end

local function isTouchingDockPreview(): boolean
local px1, py1, px2, py2 = getRect(Panel)
local dx1, dy1, dx2, dy2 = getRect(DockPreview)

return px1 <= dx2
and px2 >= dx1
and py1 <= dy2
and py2 >= dy1
end

local function updateDockPreview()
DockPreview.Visible = dragging and isTouchingDockPreview()
end

local function undockPanel()
if not docked or dragging then
	return
end

stopPanelTween()

docked = false
minimized = false
dragging = false
dragInput = nil

OpenBtn.Visible = false
DockPreview.Visible = false

DockBtn.Visible = false
MinBtn.Visible = true

setButtonImage(MinBtn, MIN_IMAGE)

Panel.Position = FLOAT_POSITION
Panel.Size = DOCK_SIZE

setContentVisible(true)
end

local function dockPanel()
if docked then
	return
end

stopPanelTween()

docked = true
minimized = false
dragging = false
dragInput = nil

DockPreview.Visible = false

setButtonImage(DockBtn, DOCK_IMAGE)
setButtonImage(MinBtn, MIN_IMAGE)

tweenPanel(DOCK_POSITION, DOCK_SIZE, function()
setContentVisible(true)

DockBtn.Visible = true
MinBtn.Visible = false
OpenBtn.Visible = true
end)
end

local function minimizePanel()
if docked or minimized then
	return
end

stopPanelTween()

minimized = true

setContentVisible(false)
setButtonImage(MinBtn, DROP_IMAGE)

tweenPanel(Panel.Position, MIN_SIZE, nil)
end

local function restorePanel()
if docked or not minimized then
	return
end

stopPanelTween()

minimized = false

setButtonImage(MinBtn, MIN_IMAGE)

tweenPanel(Panel.Position, DOCK_SIZE, function()
setContentVisible(true)
end)
end

OpenBtn.Activated:Connect(TogglePanel)

CloseBtn.Activated:Connect(function()
if activeTween then
	activeTween:Cancel()
	activeTween = nil
end

stopPanelTween()
ScreenGui:Destroy()
end)

Panel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
UpdateClosedPosition()

if not isOpen and not isAnimating and docked then
	Panel.Position = CLOSED_POSITION
end
end)

TabStore.Activated:Connect(function()
SelectTab("Store")
end)

TabTools.Activated:Connect(function()
SelectTab("Tools")
end)

TabTerrain.Activated:Connect(function()
SelectTab("Terrain")
end)

DockBtn.Activated:Connect(undockPanel)

MinBtn.Activated:Connect(function()
if docked or dragging then
	return
end

if minimized then
	restorePanel()
	else
		minimizePanel()
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

	local pointer = pointerPosition(input)

	local function pointInside(gui: GuiObject): boolean
	local pos = gui.AbsolutePosition
	local size = gui.AbsoluteSize

	return pointer.X >= pos.X
	and pointer.X <= pos.X + size.X
	and pointer.Y >= pos.Y
	and pointer.Y <= pos.Y + size.Y
end

if MinBtn.Visible and pointInside(MinBtn) then
	return
end

if DockBtn.Visible and pointInside(DockBtn) then
	return
end

stopPanelTween()

dragging = true
dragInput = input
dragOffset = pointer - Panel.AbsolutePosition

updateDockPreview()
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

local pointer = pointerPosition(input)
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

updateDockPreview()
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

updateDockPreview()

local shouldDock = DockPreview.Visible and isTouchingDockPreview()

dragging = false
dragInput = nil
DockPreview.Visible = false

if shouldDock then
	dockPanel()
end
end)

DockBtn.Visible = true
MinBtn.Visible = false
DockPreview.Visible = false

UpdateClosedPosition()
UpdateOpenButton()
SelectTab("Store")

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

-- LocalScript 3: ScreenGui.Terrain
local chunk3, holder3 = compile(
	"Terrain",
	GUI["GUI_ScreenGui"],
	[[
--!strict

local UserInputService = game:GetService("UserInputService")

local Panel = script.Parent:WaitForChild("Panel") :: Frame
local Terrain = Panel:WaitForChild("Terrain") :: Frame

local ScrollingFrame = Terrain:WaitForChild("ScrollingFrame") :: ScrollingFrame
local Layout = ScrollingFrame:WaitForChild("UIListLayout") :: UIListLayout

local Scrollbar = Terrain:WaitForChild("Scrollbar") :: Frame
local Up = Scrollbar:WaitForChild("Up") :: ImageButton
local Handle = Scrollbar:WaitForChild("Handle") :: ImageButton
local Down = Scrollbar:WaitForChild("Down") :: ImageButton

local SCROLL_STEP = 100

local Dropdowns = {
{
Card = ScrollingFrame:WaitForChild("CardEdit") :: Frame,
Button = ScrollingFrame:WaitForChild("CardEdit"):WaitForChild("EDropdown") :: TextButton,
Content = ScrollingFrame:WaitForChild("CardEdit"):WaitForChild("ContentEdit") :: Frame,
},
{
Card = ScrollingFrame:WaitForChild("CardBrush") :: Frame,
Button = ScrollingFrame:WaitForChild("CardBrush"):WaitForChild("BDropdown") :: TextButton,
Content = ScrollingFrame:WaitForChild("CardBrush"):WaitForChild("ContentBrush") :: Frame,
},
{
Card = ScrollingFrame:WaitForChild("CardMaterial") :: Frame,
Button = ScrollingFrame:WaitForChild("CardMaterial"):WaitForChild("MDropdown") :: TextButton,
Content = ScrollingFrame:WaitForChild("CardMaterial"):WaitForChild("ContentMaterial") :: Frame,
},
}

local function updateCanvas()
ScrollingFrame.CanvasSize = UDim2.fromOffset(
0,
Layout.AbsoluteContentSize.Y
)
end

for _, Dropdown in ipairs(Dropdowns) do
	local Card = Dropdown.Card
	local Button = Dropdown.Button
	local Content = Dropdown.Content
	local Icon = Button:WaitForChild("Icon") :: ImageLabel

	local ExpandedHeight = Card.Size.Y.Offset
	local CollapsedHeight = Button.Size.Y.Offset

	local function setExpanded(expanded: boolean)
	Content.Visible = expanded

	Card.Size = UDim2.fromOffset(
	Card.Size.X.Offset,
	if expanded then ExpandedHeight else CollapsedHeight
		)

		Icon.Rotation = if expanded then 180 else 0

		task.defer(updateCanvas)
	end

	setExpanded(Content.Visible)

	Button.Activated:Connect(function()
	setExpanded(not Content.Visible)
	end)
end

local dragging = false
local dragStartY = 0
local dragStartHandleY = 0
local activeTouch: InputObject? = nil

local function getTrack()
local trackTop = Up.AbsoluteSize.Y
local trackBottom = Scrollbar.AbsoluteSize.Y - Down.AbsoluteSize.Y
local trackHeight = math.max(0, trackBottom - trackTop)

return trackTop, trackHeight
end

local function getMaxScroll()
return math.max(
0,
ScrollingFrame.AbsoluteCanvasSize.Y
- ScrollingFrame.AbsoluteWindowSize.Y
)
end

local function updateScrollbar()
local trackTop, trackHeight = getTrack()
local maxScroll = getMaxScroll()

if trackHeight <= 0 then
	return
end

if maxScroll <= 0 then
	Handle.Visible = false
	Handle.Position = UDim2.fromOffset(0, trackTop)
	return
end

Handle.Visible = true

local handleHeight = Handle.AbsoluteSize.Y
local availableTravel = math.max(0, trackHeight - handleHeight)

if availableTravel <= 0 then
	Handle.Position = UDim2.fromOffset(0, trackTop)
	return
end

local ratio = math.clamp(
ScrollingFrame.CanvasPosition.Y / maxScroll,
0,
1
)

Handle.Position = UDim2.fromOffset(
0,
trackTop + availableTravel * ratio
)
end

local function scrollTo(position: number)
local newY = math.clamp(position, 0, getMaxScroll())

ScrollingFrame.CanvasPosition = Vector2.new(
ScrollingFrame.CanvasPosition.X,
newY
)

updateScrollbar()
end

local function scrollBy(amount: number)
scrollTo(ScrollingFrame.CanvasPosition.Y + amount)
end

Up.Activated:Connect(function()
scrollBy(-SCROLL_STEP)
end)

Down.Activated:Connect(function()
scrollBy(SCROLL_STEP)
end)

Handle.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then
	dragging = true
	activeTouch = nil
	dragStartY = input.Position.Y
	dragStartHandleY = Handle.Position.Y.Offset
	elseif input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		activeTouch = input
		dragStartY = input.Position.Y
		dragStartHandleY = Handle.Position.Y.Offset
	end
	end)

	UserInputService.InputChanged:Connect(function(input)
	if not dragging then
		return
	end

	if activeTouch then
		if input ~= activeTouch then
			return
		end
		elseif input.UserInputType ~= Enum.UserInputType.MouseMovement then
			return
		end

		local trackTop, trackHeight = getTrack()
		local handleHeight = Handle.AbsoluteSize.Y
		local availableTravel = trackHeight - handleHeight

		if availableTravel <= 0 then
			return
		end

		local deltaY = input.Position.Y - dragStartY

		local newHandleY = math.clamp(
		dragStartHandleY + deltaY,
		trackTop,
		trackTop + availableTravel
		)

		local ratio = (newHandleY - trackTop) / availableTravel

		scrollTo(getMaxScroll() * ratio)
		end)

		UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
			activeTouch = nil
			elseif input.UserInputType == Enum.UserInputType.Touch
				and activeTouch == input then
				dragging = false
				activeTouch = nil
			end
			end)

			ScrollingFrame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseWheel then
				scrollBy(-input.Position.Z * SCROLL_STEP)
			end
			end)

			Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			updateCanvas()
			task.defer(updateScrollbar)
			end)

			ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(updateScrollbar)
			ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateScrollbar)
			ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(updateScrollbar)
			Scrollbar:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateScrollbar)

			task.defer(function()
			updateCanvas()
			updateScrollbar()
			end)
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
if chunk3 ~= nil then
	task.spawn(chunk3)
end

return GUI
