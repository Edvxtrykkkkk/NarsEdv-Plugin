-- ExtendedGizmo Studio Lite - Nars Endeavor
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("SL_ExtendedGizmoGui") then
	CoreGui.SL_ExtendedGizmoGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SL_ExtendedGizmoGui"
ScreenGui.ResetOnSpawn = false

pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then 
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") 
end

local function CreateAxisLine(name, color)
	local line = Instance.new("CylinderHandleAdornment")
	line.Name = "SL_AxisLine_" .. name
	line.Height = 10000 -- Sumbu memanjang tanpa part fisik
	line.Radius = 0.02
	line.Color3 = color
	line.CFrame = CFrame.new()
	line.AlwaysOnTop = false -- Agar tertutup objek 3D jika di belakang
	line.Transparency = 1
	line.Parent = ScreenGui
	return line
end

local AxisX = CreateAxisLine("X", Color3.fromRGB(255, 50, 50))
local AxisY = CreateAxisLine("Y", Color3.fromRGB(50, 255, 50))
local AxisZ = CreateAxisLine("Z", Color3.fromRGB(50, 120, 255))

local function SetAxisVisibility(visible)
	local trans = visible and 0.2 or 1
	AxisX.Transparency = trans
	AxisY.Transparency = trans
	AxisZ.Transparency = trans
end

local SelectedTarget = nil
local RenderConnection = nil

local function UpdateGizmo()
	if not SelectedTarget or not SelectedTarget.Parent or not SelectedTarget:IsDescendantOf(Workspace) then
		SetAxisVisibility(false)
		return
	end

	AxisX.Adornee = SelectedTarget
	AxisY.Adornee = SelectedTarget
	AxisZ.Adornee = SelectedTarget

	-- Orientasi Rotasi Sumbu 3D
	AxisX.CFrame = CFrame.Angles(0, math.rad(90), 0)
	AxisY.CFrame = CFrame.Angles(math.rad(90), 0, 0)
	AxisZ.CFrame = CFrame.new()

	SetAxisVisibility(true)
end

local function HookStudioLiteHandles()
	local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
	local StudioGui = PlayerGui:WaitForChild("StudioGui", 10)
	if not StudioGui then return end

	local HandlesR = StudioGui:FindFirstChild("HandlesR")
	local HandlesG = StudioGui:FindFirstChild("HandlesG")
	local HandlesB = StudioGui:FindFirstChild("HandlesB")
	local ArcHandles = StudioGui:FindFirstChild("ArcHandles")

	if RenderConnection then RenderConnection:Disconnect() end
	RenderConnection = RunService.RenderStepped:Connect(function()
			
		local activeTarget = (HandlesR and HandlesR.Adornee) 
			or (HandlesG and HandlesG.Adornee) 
			or (HandlesB and HandlesB.Adornee) 
			or (ArcHandles and ArcHandles.Adornee)

		if activeTarget and activeTarget.Name ~= "SL_AttachmentAdornee" then
			SelectedTarget = activeTarget
		else
			SelectedTarget = nil
		end

		UpdateGizmo()
	end)
end

task.spawn(HookStudioLiteHandles)

local ExplorerEvent = Workspace:FindFirstChild("ExplorerSelectionChangedToMain")
if ExplorerEvent then
	ExplorerEvent.Event:Connect(function()
		task.defer(HookStudioLiteHandles)
	end)
end
