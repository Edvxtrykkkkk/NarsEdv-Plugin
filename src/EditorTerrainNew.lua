-- Terrain Editor | NarsEdv
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
	return "_narsedv_" .. table.concat(chars)
end

local genv: any = (type(executorEnv.getgenv) == "function" and executorEnv.getgenv()) or _G
if type(genv.__NarsTerrainEditorDestroy) == "function" then
	pcall(genv.__NarsTerrainEditorDestroy)
end

local Icons = {
	ArrowUp = "rbxassetid://117796781690923",
	ArrowDown = "rbxassetid://136612013728069",

	Close = "rbxassetid://110786993356448",
	Min = "rbxassetid://118026365011536",
	Dock = "rbxassetid://103542107889511",
	Banner = "rbxassetid://99027217090571",
	Discord = "rbxassetid://109798031608756",

	Terrain = "rbxassetid://127282455310961",

	Generate = "rbxassetid://76469526004628",
	Clear = "rbxassetid://115818216820315",

	Select = "rbxassetid://117000619215345",
	Move = "rbxassetid://140210140199063",
	Rotate = "rbxassetid://129301880906383",
	Scale = "rbxassetid://92604696821185",

	Fill = "rbxassetid://90175266847800",
	SeaLevel = "rbxassetid://97885351178945",
	Draw = "rbxassetid://85215151455162",
	Sculpt = "rbxassetid://124869537103788",
	Smooth = "rbxassetid://84294758062543",
	Paint = "rbxassetid://125035233634682",
	Flatten = "rbxassetid://119268925809522",

	Undo = "rbxassetid://113885292059932",
	Redo = "rbxassetid://70451039017914",
	CodeClear = "rbxassetid://133957773112410",
	Copy = "rbxassetid://78979572434545",
	Code = "rbxassetid://106783148545356",
	Save = "rbxassetid://116946975799440",

	Cylinder = "rbxassetid://130288865038956",
	Ball = "rbxassetid://115371186678014",
	Block = "rbxassetid://114602877369426",

	Material = {
		Grass = "rbxassetid://0",
		Ground = "rbxassetid://0",
		Rock = "rbxassetid://0",
		Sand = "rbxassetid://0",
		Snow = "rbxassetid://0",
		Mud = "rbxassetid://0",
		Water = "rbxassetid://0",
		Slate = "rbxassetid://0",
		Concrete = "rbxassetid://0",
		Brick = "rbxassetid://0",
		Cobblestone = "rbxassetid://0",
		Sandstone = "rbxassetid://0",
		Basalt = "rbxassetid://0",
		CrackedLava = "rbxassetid://0",
		Glacier = "rbxassetid://0",
		Ice = "rbxassetid://0",
		LeafyGrass = "rbxassetid://0",
		Limestone = "rbxassetid://0",
		Pavement = "rbxassetid://0",
		Salt = "rbxassetid://0",
		Asphalt = "rbxassetid://0",
		WoodPlanks = "rbxassetid://0",
	},
}

local function hasIcon(id: string?): boolean
	return id ~= nil and id ~= "" and id ~= "rbxassetid://0"
end

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local Workspace        = game:GetService("Workspace")
local TweenService     = game:GetService("TweenService")

local player  = Players.LocalPlayer
local terrain = Workspace.Terrain

local VS    = 4
local AIR   = Enum.Material.Air
local WATER = Enum.Material.Water
local EPS   = 0.02

local Alive = true
local Conns = {}
local function bind(signal, fn)
	local c = signal:Connect(fn)
	Conns[#Conns + 1] = c
	return c
end

local progressHook = function(_p) end
local function progress(p)
	if Alive then
		progressHook(p)
	end
end

local function clamp(v, a, b) return math.max(a, math.min(b, v)) end
local function lerp(a, b, t) return a + (b - a) * t end
local function snapDown(v) return math.floor(v / VS) * VS end
local function snapUp(v) return math.ceil(v / VS) * VS end
local function snapRound(v) return math.floor(v / VS + 0.5) * VS end
local function snapVec(v, f) return Vector3.new(f(v.X), f(v.Y), f(v.Z)) end
local function round1(v) return math.floor(v * 10 + 0.5) / 10 end

local function copy3(src, nx, ny)
	local dst = table.create(nx)
	for x = 1, nx do
		local sx = src[x]
		local dx = table.create(ny)
		for y = 1, ny do
			dx[y] = table.clone(sx[y])
		end
		dst[x] = dx
	end
	local s = src.Size
	if s ~= nil then dst.Size = s end
	return dst
end

local function newGrid(nx, ny, nz, fill)
	local g = table.create(nx)
	for x = 1, nx do
		local gx = table.create(ny)
		for y = 1, ny do
			gx[y] = table.create(nz, fill)
		end
		g[x] = gx
	end
	return g
end

local MATERIAL_NAMES = {
	"Asphalt", "Basalt", "Brick", "Cobblestone", "Concrete",
	"CrackedLava", "Glacier", "Grass", "Ground", "Ice",
	"LeafyGrass", "Limestone", "Mud", "Pavement", "Rock",
	"Salt", "Sand", "Sandstone", "Slate", "Snow",
	"Water", "WoodPlanks",
}
local MATERIAL_ABBR = {
	Asphalt = "Asph", Basalt = "Basa", Brick = "Brick", Cobblestone = "Cobb", Concrete = "Conc",
	CrackedLava = "Lava", Glacier = "Glac", Grass = "Grass", Ground = "Grnd", Ice = "Ice",
	LeafyGrass = "LGrass", Limestone = "Lime", Mud = "Mud", Pavement = "Pave", Rock = "Rock",
	Salt = "Salt", Sand = "Sand", Sandstone = "SStone", Slate = "Slate", Snow = "Snow",
	Water = "Water", WoodPlanks = "Wood",
}
local DEFAULT_COLORS = {
	Asphalt = Color3.fromRGB(115, 123, 107), Basalt = Color3.fromRGB(30, 30, 37),
	Brick = Color3.fromRGB(138, 86, 62), Cobblestone = Color3.fromRGB(132, 123, 90),
	Concrete = Color3.fromRGB(127, 102, 63), CrackedLava = Color3.fromRGB(232, 156, 74),
	Glacier = Color3.fromRGB(101, 176, 234), Grass = Color3.fromRGB(106, 127, 63),
	Ground = Color3.fromRGB(102, 92, 59), Ice = Color3.fromRGB(129, 194, 229),
	LeafyGrass = Color3.fromRGB(115, 132, 74), Limestone = Color3.fromRGB(206, 173, 148),
	Mud = Color3.fromRGB(58, 46, 36), Pavement = Color3.fromRGB(148, 148, 140),
	Rock = Color3.fromRGB(102, 108, 111), Salt = Color3.fromRGB(198, 189, 181),
	Sand = Color3.fromRGB(143, 126, 95), Sandstone = Color3.fromRGB(137, 90, 71),
	Slate = Color3.fromRGB(63, 127, 107), Snow = Color3.fromRGB(195, 199, 218),
	Water = Color3.fromRGB(12, 84, 91), WoodPlanks = Color3.fromRGB(139, 109, 79),
}

local MATERIALS = {}
local MAT_COLOR = {}
local MAT_ORIGINAL = {}
local MAT_INDEX = { [AIR] = 0 }
local EXPORT_MATS = { AIR }
for i, name in ipairs(MATERIAL_NAMES) do
	local enum = Enum.Material[name]
	local col = DEFAULT_COLORS[name]
	local ok, c = pcall(function() return terrain:GetMaterialColor(enum) end)
	if ok and typeof(c) == "Color3" then col = c end
	MATERIALS[i] = { name = name, mat = enum, col = col }
	MAT_COLOR[enum] = col
	MAT_ORIGINAL[enum] = col
	MAT_INDEX[enum] = i
	EXPORT_MATS[i + 1] = enum
end

local MatColors = {}
local MatColorOrder = {}

local State = {
	tab = "Edit",
	tools = { Create = "Generate", Region = "Select", Edit = "Add" },
	minimized = false,
	docked = true,

	brushActive = false,
	shape = "Ball",
	baseSize = 6,
	height = 6,
	strength = 0.5,
	pivot = "Cen",
	planeLock = "Off",
	planePos = Vector3.new(0, 0, 0),
	planeRot = Vector3.new(0, 0, 0),
	snap = false,
	ignoreWater = false,
	ignoreParts = true,
	autoMaterial = false,
	material = Enum.Material.Grass,
	replaceSource = Enum.Material.Grass,
	replaceTarget = Enum.Material.Rock,
	flattenMode = "Both",

	regionMin = Vector3.new(-128, 0, -128),
	regionSize = Vector3.new(256, 64, 256),
	committedMin = Vector3.new(-128, 0, -128),
	committedSize = Vector3.new(256, 64, 256),
	regionSnap = true,
	mergeEmpty = false,
	fillMode = "Fill",
	fillMaterial = Enum.Material.Grass,
	fillSource = Enum.Material.Grass,
	rotateAxis = "Y",

	seed = 1234,
	biomeSize = 3,
	blending = 0.35,
	caves = false,
	biomes = {
		Water = true, Plains = true, Hills = true, Dunes = true, Canyons = true,
		Mountains = true, Lava = true, Arctic = true, Marsh = true,
	},

	clearedAll = false,
	exportClearFirst = false,
}

local BRUSH_TOOLS = {
	Add = true, Subtract = true, Grow = true, Erode = true,
	Smooth = true, Flatten = true, Paint = true, Replace = true,
}

do
	local ch = player.Character
	local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
	if hrp then
		local p = hrp.Position
		local mn = Vector3.new(snapRound(p.X - 128), snapRound(p.Y - 16), snapRound(p.Z - 128))
		State.regionMin = mn
		State.committedMin = mn
	end
end

local sg = Instance.new("ScreenGui")
sg.Name = generateName()
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.DisplayOrder = 999
sg.IgnoreGuiInset = true
pcall(function()
	sg.ScreenInsets = Enum.ScreenInsets.None
end)
pcall(function()
	if type(executorEnv.protect_gui) == "function" then
		executorEnv.protect_gui(sg)
	elseif type(executorEnv.syn) == "table" and type(executorEnv.syn.protect_gui) == "function" then
		executorEnv.syn.protect_gui(sg)
	end
end)
sg.Parent = host

local function visualParent()
	return Workspace.CurrentCamera or Workspace
end

local E = {}

local Busy = false
local function runAsync(name, fn)
	if Busy then return false end
	Busy = true
	task.spawn(function()
		local ok, err = pcall(fn)
		Busy = false
		progress(nil)
		if not ok then
			warn("[TerrainEditor] " .. name .. ": " .. tostring(err))
		end
	end)
	return true
end

local function readBox(minV, maxV)
	local ok, mats, occs = pcall(function()
		return terrain:ReadVoxels(Region3.new(minV, maxV), VS)
	end)
	if not ok or not mats then return nil end
	local s = mats.Size
	return mats, occs, s.X, s.Y, s.Z
end

local function writeBox(minV, maxV, mats, occs)
	local ok = pcall(function()
		terrain:WriteVoxels(Region3.new(minV, maxV), VS, mats, occs)
	end)
	return ok
end

local History = { undo = {}, redo = {}, cells = 0 }
local MAX_HISTORY_CELLS = 6000000
local currentEntry = nil

local Script = { list = {} }

function E.beginEntry()
	currentEntry = { patches = {}, cells = 0, ops = {}, active = true }
end

function E.record(op)
	local e = currentEntry
	if e then
		e.ops[#e.ops + 1] = op
	else
		Script.list[#Script.list + 1] = { ops = { op }, active = true }
	end
end

function E.recordStandalone(op)
	Script.list[#Script.list + 1] = { ops = { op }, active = true }
end

local function addPatch(minV, maxV, nx, ny, nz, bm, bo, am, ao)
	local e = currentEntry
	if not e then return end
	if e.cells > 8000000 then
		e.truncated = true
		return
	end
	e.patches[#e.patches + 1] = { minV = minV, maxV = maxV, bm = bm, bo = bo, am = am, ao = ao }
	e.cells += nx * ny * nz * 2
end

function E.commitEntry()
	local e = currentEntry
	currentEntry = nil
	if not e then return end

	local ops = {}
	for _, op in ipairs(e.ops) do
		if op.k ~= "stroke" or #op.pts > 0 then ops[#ops + 1] = op end
	end
	e.ops = ops
	if #ops == 0 and #e.patches == 0 then return end

	if #History.redo > 0 then
		for _, r in ipairs(History.redo) do r.dead = true end
		local keep = {}
		for _, s in ipairs(Script.list) do
			if not s.dead then keep[#keep + 1] = s end
		end
		Script.list = keep
	end
	History.redo = {}
	Script.list[#Script.list + 1] = e

	if #e.patches == 0 or e.truncated or e.noHistory then
		if e.truncated or e.noHistory then
			History.undo, History.cells = {}, 0
		end
		if E.onScriptChanged then E.onScriptChanged() end
		return
	end

	History.undo[#History.undo + 1] = e
	History.cells += e.cells
	while (#History.undo > 40 or History.cells > MAX_HISTORY_CELLS) and #History.undo > 1 do
		local old = table.remove(History.undo, 1)
		History.cells -= old.cells
	end
	if E.onScriptChanged then E.onScriptChanged() end
end

function E.resetHistory()
	History.undo, History.redo, History.cells = {}, {}, 0
end

function E.undo()
	if Busy then return end
	local e = table.remove(History.undo)
	if not e then return end
	History.cells -= e.cells
	for i = #e.patches, 1, -1 do
		local p = e.patches[i]
		writeBox(p.minV, p.maxV, p.bm, p.bo)
	end
	e.active = false
	History.redo[#History.redo + 1] = e
	if E.onScriptChanged then E.onScriptChanged() end
end

function E.redo()
	if Busy then return end
	local e = table.remove(History.redo)
	if not e then return end
	for i = 1, #e.patches do
		local p = e.patches[i]
		writeBox(p.minV, p.maxV, p.am, p.ao)
	end
	e.active = true
	History.undo[#History.undo + 1] = e
	History.cells += e.cells
	if E.onScriptChanged then E.onScriptChanged() end
end

local CHUNK = 32
local MAX_TRANSFER = 1500000

local function forChunks(minV, maxV, cs, fn)
	local span = cs * VS
	local last = os.clock()
	local x = minV.X
	while x < maxV.X do
		local x2 = math.min(x + span, maxV.X)
		local y = minV.Y
		while y < maxV.Y do
			local y2 = math.min(y + span, maxV.Y)
			local z = minV.Z
			while z < maxV.Z do
				if not Alive then return end
				local z2 = math.min(z + span, maxV.Z)
				fn(Vector3.new(x, y, z), Vector3.new(x2, y2, z2))
				if os.clock() - last > 0.015 then
					task.wait()
					last = os.clock()
				end
				z = z2
			end
			y = y2
		end
		x = x2
	end
end

function E.modifyBox(minV, maxV, fn, withHistory)
	local sz = (maxV - minV) / VS
	local record = withHistory and (sz.X * sz.Y * sz.Z <= MAX_TRANSFER)
	if withHistory and not record and currentEntry then currentEntry.noHistory = true end
	forChunks(minV, maxV, CHUNK, function(cmin, cmax)
		local mats, occs, nx, ny, nz = readBox(cmin, cmax)
		if not mats then return end
		local bm, bo
		if record then
			bm, bo = copy3(mats, nx, ny), copy3(occs, nx, ny)
		end
		fn(mats, occs, nx, ny, nz, cmin)
		if writeBox(cmin, cmax, mats, occs) and record then
			addPatch(cmin, cmax, nx, ny, nz, bm, bo, mats, occs)
		end
	end)
end

function E.editBoxDirect(minV, maxV, fn)
	local mats, occs, nx, ny, nz = readBox(minV, maxV)
	if not mats then return false end
	local bm, bo = copy3(mats, nx, ny), copy3(occs, nx, ny)
	fn(mats, occs, nx, ny, nz)
	if writeBox(minV, maxV, mats, occs) then
		addPatch(minV, maxV, nx, ny, nz, bm, bo, mats, occs)
		return true
	end
	return false
end

local function boxCells(size)
	return (size.X / VS) * (size.Y / VS) * (size.Z / VS)
end

function E.getMaterialColor(mat)
	return MAT_COLOR[mat]
end

function E.hasCustomColor(mat)
	return MatColors[mat] ~= nil
end

function E.setMaterialColor(mat, col)
	local ok = pcall(function() terrain:SetMaterialColor(mat, col) end)
	if not ok then return false end
	if MatColors[mat] == nil then
		MatColorOrder[#MatColorOrder + 1] = mat
	end
	MatColors[mat] = col
	MAT_COLOR[mat] = col
	return true
end

function E.resetMaterialColor(mat)
	if MatColors[mat] == nil then return end
	pcall(function() terrain:SetMaterialColor(mat, MAT_ORIGINAL[mat]) end)
	MatColors[mat] = nil
	MAT_COLOR[mat] = MAT_ORIGINAL[mat]
	for i, m in ipairs(MatColorOrder) do
		if m == mat then
			table.remove(MatColorOrder, i)
			break
		end
	end
end

local RegionVis = { Handles = {}, Arcs = {}, Hot = {} }
local RegionListeners = {}

local AXIS_FACES = {
	X = { Enum.NormalId.Right, Enum.NormalId.Left },
	Y = { Enum.NormalId.Top, Enum.NormalId.Bottom },
	Z = { Enum.NormalId.Front, Enum.NormalId.Back },
}
local AXIS_ENUM = { X = Enum.Axis.X, Y = Enum.Axis.Y, Z = Enum.Axis.Z }
local AXIS_COLORS = {
	X = Color3.fromRGB(255, 72, 72),
	Y = Color3.fromRGB(88, 235, 112),
	Z = Color3.fromRGB(84, 142, 255),
}

local function regionSnapFn(v)
	if State.regionSnap then return snapRound(v) end
	return math.floor(v * 100 + 0.5) / 100
end

local function bounds(minV, sizeV)
	return snapVec(minV, snapDown), snapVec(minV + sizeV, snapUp)
end

function E.onRegionChanged(fn)
	RegionListeners[#RegionListeners + 1] = fn
end

function E.regionBounds()
	return bounds(State.regionMin, State.regionSize)
end

function E.commitRegion()
	State.committedMin = State.regionMin
	State.committedSize = State.regionSize
end

function E.commitIdle()
	local rt = (State.tab == "Region") and State.tools.Region or nil
	if rt ~= "Move" and rt ~= "Resize" then
		E.commitRegion()
	end
end

function E.setRegion(minV, sizeV)
	minV = Vector3.new(regionSnapFn(minV.X), regionSnapFn(minV.Y), regionSnapFn(minV.Z))
	sizeV = Vector3.new(
		math.max(VS, regionSnapFn(sizeV.X)),
		math.max(VS, regionSnapFn(sizeV.Y)),
		math.max(VS, regionSnapFn(sizeV.Z))
	)
	State.regionMin = minV
	State.regionSize = sizeV
	if RegionVis.Part then
		RegionVis.Part.Size = Vector3.new(math.min(sizeV.X, 2048), math.min(sizeV.Y, 2048), math.min(sizeV.Z, 2048))
		RegionVis.Part.CFrame = CFrame.new(minV + sizeV / 2)
	end
	for _, f in ipairs(RegionListeners) do
		f()
	end
end

function E.initRegionVis()
	local part = Instance.new("Part")
	part.Name = generateName()
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Transparency = 1
	part.Size = State.regionSize
	part.CFrame = CFrame.new(State.regionMin + State.regionSize / 2)
	part.Parent = visualParent()

	local box = Instance.new("SelectionBox")
	box.Adornee = part
	box.Color3 = Color3.fromRGB(235, 235, 235)
	box.LineThickness = 0.08
	box.SurfaceColor3 = Color3.fromRGB(235, 235, 235)
	box.SurfaceTransparency = 0.9
	box.Visible = false
	box.Parent = sg

	RegionVis.Part, RegionVis.Box = part, box

	local base = nil
	local function onDown()
		base = { min = State.regionMin, size = State.regionSize }
	end
	local function onUp()
		base = nil
		E.commitIdle()
	end
	local function onDrag(face, dist)
		if not base then return end
		local n = Vector3.FromNormalId(face)
		local d = regionSnapFn(dist)
		if State.tab == "Region" and State.tools.Region == "Move" then
			E.setRegion(base.min + n * d, base.size)
			return
		end
		local an = Vector3.new(math.abs(n.X), math.abs(n.Y), math.abs(n.Z))
		local axisSize = an:Dot(base.size)
		d = math.max(d, VS - axisSize)
		local newSize = base.size + an * d
		local newMin = base.min
		if n.X < 0 or n.Y < 0 or n.Z < 0 then
			newMin = base.min - an * d
		end
		E.setRegion(newMin, newSize)
	end

	for axis, faces in pairs(AXIS_FACES) do
		local h = Instance.new("Handles")
		h.Adornee = part
		h.Color3 = AXIS_COLORS[axis]
		h.Style = Enum.HandlesStyle.Resize
		h.Faces = Faces.new(faces[1], faces[2])
		h.Visible = false
		h.Parent = sg
		bind(h.MouseEnter, function() RegionVis.Hot[h] = true end)
		bind(h.MouseLeave, function() RegionVis.Hot[h] = nil end)
		bind(h.MouseButton1Down, onDown)
		bind(h.MouseButton1Up, onUp)
		bind(h.MouseDrag, onDrag)
		RegionVis.Handles[axis] = h

		local a = Instance.new("ArcHandles")
		a.Adornee = part
		a.Color3 = AXIS_COLORS[axis]
		a.Axes = Axes.new(AXIS_ENUM[axis])
		a.Visible = false
		a.Parent = sg
		bind(a.MouseEnter, function() RegionVis.Hot[a] = true end)
		bind(a.MouseLeave, function() RegionVis.Hot[a] = nil end)
		local applied = 0
		bind(a.MouseButton1Down, function() applied = 0 end)
		bind(a.MouseDrag, function(_, rel)
			local target = math.floor(rel / (math.pi / 2) + 0.5)
			if target ~= applied and not Busy then
				local diff = target - applied
				if E.opRotate(axis, diff > 0 and 1 or -1, math.abs(diff)) then
					applied = target
				end
			end
		end)
		bind(a.MouseButton1Up, function() applied = 0 end)
		RegionVis.Arcs[axis] = a
	end

	E.setRegion(State.regionMin, State.regionSize)
end

function E.overHandle()
	return next(RegionVis.Hot) ~= nil
end

function E.refreshRegionVisibility()
	if not RegionVis.Part then return end
	local tab, tool = State.tab, State.tools[State.tab]
	local show, arcs, move = false, false, false
	if tab == "Create" then
		show = (tool == "Generate")
	elseif tab == "Region" then
		show = true
		arcs = (tool == "Rotate")
		move = (tool == "Move")
	elseif tab == "Edit" then
		show = (tool == "SeaLevel")
	end
	table.clear(RegionVis.Hot)
	RegionVis.Box.Visible = show
	local style = move and Enum.HandlesStyle.Movement or Enum.HandlesStyle.Resize
	for _, h in pairs(RegionVis.Handles) do
		h.Style = style
		h.Visible = show and not arcs
	end
	for _, a in pairs(RegionVis.Arcs) do
		a.Visible = show and arcs
	end
end

function E.onToolChanged()
	local tab, tool = State.tab, State.tools[State.tab]
	if tab == "Region" and (tool == "Move" or tool == "Resize" or tool == "Rotate") then
		E.commitRegion()
	end
	E.refreshRegionVisibility()
end

local function brushDims()
	local d = State.baseSize
	local h = (State.shape == "Ball") and d or State.height
	return d, h
end
E.brushDims = brushDims

local function effStrength()
	return State.strength ^ 1.5
end

do
local function makeCoverage(shape, cx, cy, cz, d, h)
	local hr, hh = d * 0.5, h * 0.5
	if shape == "Ball" then
		return function(px, py, pz)
			local dx, dy, dz = px - cx, py - cy, pz - cz
			local c = 0.5 - (math.sqrt(dx * dx + dy * dy + dz * dz) - hr) / VS
			if c < 0 then return 0 elseif c > 1 then return 1 end
			return c
		end
	elseif shape == "Block" then
		return function(px, py, pz)
			local qx, qy, qz = math.abs(px - cx) - hr, math.abs(py - cy) - hh, math.abs(pz - cz) - hr
			local ox, oy, oz = math.max(qx, 0), math.max(qy, 0), math.max(qz, 0)
			local sd = math.sqrt(ox * ox + oy * oy + oz * oz) + math.min(math.max(qx, qy, qz), 0)
			local c = 0.5 - sd / VS
			if c < 0 then return 0 elseif c > 1 then return 1 end
			return c
		end
	end
	return function(px, py, pz)
		local dx, dz = px - cx, pz - cz
		local qr = math.sqrt(dx * dx + dz * dz) - hr
		local qy = math.abs(py - cy) - hh
		local ox, oy = math.max(qr, 0), math.max(qy, 0)
		local sd = math.sqrt(ox * ox + oy * oy) + math.min(math.max(qr, qy), 0)
		local c = 0.5 - sd / VS
		if c < 0 then return 0 elseif c > 1 then return 1 end
		return c
	end
end

local function forCovered(ctx, fn)
	local cov, ox, oy, oz = ctx.cov, ctx.ox, ctx.oy, ctx.oz
	local nx, ny, nz = ctx.nx, ctx.ny, ctx.nz
	for x = 1, nx do
		local px = ox + x * VS
		for y = 1, ny do
			local py = oy + y * VS
			for z = 1, nz do
				local c = cov(px, py, oz + z * VS)
				if c > 0 then
					fn(x, y, z, c, py)
				end
			end
		end
	end
end

local function setCell(mats, occs, x, y, z, o, m)
	if o <= EPS then
		mats[x][y][z] = AIR
		occs[x][y][z] = 0
	else
		mats[x][y][z] = m
		occs[x][y][z] = (o > 1) and 1 or o
	end
end

local function sOcc(mats, occs, x, y, z)
	local m = mats[x][y][z]
	if m == AIR or m == WATER then return 0 end
	return occs[x][y][z]
end

local function neighborStats(mats, occs, x, y, z)
	local a = sOcc(mats, occs, x + 1, y, z)
	local b = sOcc(mats, occs, x - 1, y, z)
	local c = sOcc(mats, occs, x, y + 1, z)
	local d = sOcc(mats, occs, x, y - 1, z)
	local e = sOcc(mats, occs, x, y, z + 1)
	local f = sOcc(mats, occs, x, y, z - 1)
	return math.max(a, b, c, d, e, f), math.min(a, b, c, d, e, f), a + b + c + d + e + f
end

local function dominantMat(mats, occs, x, y, z)
	local best, bm = 0, nil
	local function try(xx, yy, zz)
		local m = mats[xx][yy][zz]
		if m ~= AIR and m ~= WATER then
			local o = occs[xx][yy][zz]
			if o > best then best, bm = o, m end
		end
	end
	try(x + 1, y, z); try(x - 1, y, z); try(x, y + 1, z)
	try(x, y - 1, z); try(x, y, z + 1); try(x, y, z - 1)
	return bm
end

local function autoMaterial(ctx, x, y, z, py)
	if x <= 1 or y <= 1 or z <= 1 or x >= ctx.nx or y >= ctx.ny or z >= ctx.nz then
		return State.material
	end
	return dominantMat(ctx.bm, ctx.bo, x, y, z) or State.material
end

local function pickMaterial(ctx, x, y, z, py)
	if ctx.useAuto then
		return autoMaterial(ctx, x, y, z, py)
	end
	return State.material
end

local BrushFns = {}

BrushFns.Add = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local ignoreWater = State.ignoreWater
	forCovered(ctx, function(x, y, z, c, py)
		local m = mats[x][y][z]
		local o = occs[x][y][z]
		if m == WATER and (ignoreWater or c < 0.5) then return end
		local isEmpty = (m == AIR) or o <= EPS
		local newO = (o > c) and o or c
		local newM = m
		if isEmpty or c >= 0.5 then
			newM = pickMaterial(ctx, x, y, z, py)
		end
		setCell(mats, occs, x, y, z, newO, newM)
	end)
end

BrushFns.Subtract = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local ignoreWater = State.ignoreWater
	forCovered(ctx, function(x, y, z, c)
		local m = mats[x][y][z]
		if m == AIR then return end
		if m == WATER and ignoreWater then return end
		local o = occs[x][y][z]
		local newO = math.min(o, 1 - c)
		if newO < o then
			setCell(mats, occs, x, y, z, newO, m)
		end
	end)
end

BrushFns.Grow = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local k = effStrength()
	forCovered(ctx, function(x, y, z, c, py)
		if x <= 1 or y <= 1 or z <= 1 or x >= ctx.nx or y >= ctx.ny or z >= ctx.nz then return end
		local m = mats[x][y][z]
		if m == WATER then return end
		local o = (m == AIR) and 0 or occs[x][y][z]
		if o >= 1 then return end
		local nmax = neighborStats(mats, occs, x, y, z)
		if nmax <= 0 then return end
		local newO = o + k * c * 0.5 * nmax
		local newM = m
		if m == AIR or o < 0.35 then
			newM = pickMaterial(ctx, x, y, z, py)
		end
		setCell(mats, occs, x, y, z, newO, newM)
	end)
end

BrushFns.Erode = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local k = effStrength()
	forCovered(ctx, function(x, y, z, c)
		if x <= 1 or y <= 1 or z <= 1 or x >= ctx.nx or y >= ctx.ny or z >= ctx.nz then return end
		local m = mats[x][y][z]
		if m == AIR or m == WATER then return end
		local o = occs[x][y][z]
		local _, nmin = neighborStats(mats, occs, x, y, z)
		if nmin >= 1 then return end
		local newO = o - k * c * 0.35 * (1 - nmin)
		setCell(mats, occs, x, y, z, newO, m)
	end)
end

BrushFns.Smooth = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local sm, so = ctx.bm, ctx.bo
	local k = effStrength()
	forCovered(ctx, function(x, y, z, c)
		if x <= 1 or y <= 1 or z <= 1 or x >= ctx.nx or y >= ctx.ny or z >= ctx.nz then return end
		local m = sm[x][y][z]
		if m == WATER then return end
		local selfO = (m == AIR) and 0 or so[x][y][z]
		local _, _, sum = neighborStats(sm, so, x, y, z)
		local avg = (selfO + sum) / 7
		local newO = selfO + (avg - selfO) * math.min(1, k * c * 1.3)
		local newM = m
		if m == AIR then
			newM = dominantMat(sm, so, x, y, z) or State.material
		end
		setCell(mats, occs, x, y, z, newO, newM)
	end)
end

BrushFns.Flatten = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local k = effStrength()
	local flatY = ctx.flatY
	local mode = State.flattenMode
	forCovered(ctx, function(x, y, z, c, py)
		local m = mats[x][y][z]
		if m == WATER then return end
		local o = (m == AIR) and 0 or occs[x][y][z]
		local T = clamp((flatY - (py - VS / 2)) / VS, 0, 1)
		local f = math.min(1, k * c * 1.5)
		if T < o and (mode == "Erode" or mode == "Both") then
			setCell(mats, occs, x, y, z, o + (T - o) * f, m)
		elseif T > o and (mode == "Grow" or mode == "Both") then
			local newM = m
			if m == AIR or o < 0.35 then
				newM = pickMaterial(ctx, x, y, z, py)
			end
			setCell(mats, occs, x, y, z, o + (T - o) * f, newM)
		end
	end)
end

BrushFns.Paint = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local mat = State.material
	forCovered(ctx, function(x, y, z, c)
		if c < 0.5 then return end
		local m = mats[x][y][z]
		if m == AIR or m == WATER or occs[x][y][z] <= EPS then return end
		mats[x][y][z] = mat
	end)
end

BrushFns.Replace = function(ctx)
	local mats, occs = ctx.mats, ctx.occs
	local src, dst = State.replaceSource, State.replaceTarget
	forCovered(ctx, function(x, y, z, c)
		if c < 0.5 then return end
		if mats[x][y][z] == src and occs[x][y][z] > EPS then
			mats[x][y][z] = dst
		end
	end)
end

function E.applyBrush(tool, center, flatY)
	local fn = BrushFns[tool]
	if not fn then return end
	local d, h = brushDims()
	local half = Vector3.new(d / 2, h / 2, d / 2)
	local pad = Vector3.new(VS, VS, VS)
	local minV = snapVec(center - half, snapDown) - pad
	local maxV = snapVec(center + half, snapUp) + pad
	local mats, occs, nx, ny, nz = readBox(minV, maxV)
	if not mats then return end
	local bm, bo = copy3(mats, nx, ny), copy3(occs, nx, ny)
	local ctx = {
		mats = mats, occs = occs, bm = bm, bo = bo,
		nx = nx, ny = ny, nz = nz,
		ox = minV.X - VS / 2, oy = minV.Y - VS / 2, oz = minV.Z - VS / 2,
		cov = makeCoverage(State.shape, center.X, center.Y, center.Z, d, h),
		flatY = flatY or center.Y,
		useAuto = State.autoMaterial and (tool == "Add" or tool == "Grow" or tool == "Flatten"),
	}
	fn(ctx)
	if writeBox(minV, maxV, mats, occs) then
		addPatch(minV, maxV, nx, ny, nz, bm, bo, mats, occs)
	end
end
end

local Pointer = { x = 0, y = 0, valid = false, input = nil }
E.Pointer = Pointer
local Stroke = nil

local function pointerRay(x, y)
	local ray = Workspace.CurrentCamera:ScreenPointToRay(x, y)
	return ray.Origin, ray.Direction
end

local function planeHit(x, y, origin, normal)
	local o, d = pointerRay(x, y)
	local den = normal:Dot(d)
	if math.abs(den) < 1e-4 then return nil end
	local t = normal:Dot(origin - o) / den
	if t <= 0 or t > 5000 then return nil end
	return o + d * t
end

local function manualPlane()
	return CFrame.new(State.planePos)
		* CFrame.Angles(math.rad(State.planeRot.X), math.rad(State.planeRot.Y), math.rad(State.planeRot.Z))
end

local function castWorld(x, y, anyPart)
	local o, d = pointerRay(x, y)
	local rp = RaycastParams.new()
	if anyPart or not State.ignoreParts then
		rp.FilterType = Enum.RaycastFilterType.Exclude
		local ex = {}
		if player.Character then ex[1] = player.Character end
		rp.FilterDescendantsInstances = ex
	else
		rp.FilterType = Enum.RaycastFilterType.Include
		rp.FilterDescendantsInstances = { terrain }
	end
	rp.IgnoreWater = State.ignoreWater
	local res = Workspace:Raycast(o, d * 3000, rp)
	if res then return res.Position end
	return nil
end

function E.resolveHit(x, y, stroke)
	local pos
	local mode = State.planeLock
	if mode == "Auto" and stroke and stroke.planeOrigin then
		pos = planeHit(x, y, stroke.planeOrigin, stroke.planeNormal)
	elseif mode == "Manual" then
		local cf = manualPlane()
		pos = planeHit(x, y, cf.Position, cf.UpVector)
	end
	if not pos then
		pos = castWorld(x, y, false)
		if not pos and State.ignoreParts then
			pos = planeHit(x, y, Vector3.zero, Vector3.yAxis)
		end
	end
	return pos
end

local function snapCenter(p)
	local f
	if math.floor(State.baseSize / VS + 0.5) % 2 == 1 then
		f = function(v) return math.floor(v / VS) * VS + VS / 2 end
	else
		f = snapRound
	end
	return Vector3.new(f(p.X), f(p.Y), f(p.Z))
end

function E.brushCenter(hit)
	local _, h = brushDims()
	local c = hit
	if State.pivot == "Bot" then
		c = c + Vector3.new(0, h / 2, 0)
	elseif State.pivot == "Top" then
		c = c - Vector3.new(0, h / 2, 0)
	end
	if State.snap then c = snapCenter(c) end
	return c
end

function E.activeBrushTool()
	if not State.brushActive then return nil end
	local t = State.tools.Edit
	if t and BRUSH_TOOLS[t] then return t end
	return nil
end

E.FLIP_TOOL = { Add = "Subtract", Subtract = "Add", Grow = "Erode", Erode = "Grow" }

function E.modKeyDown(a, b, c)
	return UserInputService:IsKeyDown(a)
		or (b ~= nil and UserInputService:IsKeyDown(b))
		or (c ~= nil and UserInputService:IsKeyDown(c))
end

function E.modifierTool(tool)
	if not E.FLIP_TOOL[tool] or UserInputService:GetFocusedTextBox() then return tool end
	if E.modKeyDown(Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift) then
		return "Smooth"
	end
	if E.modKeyDown(Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.LeftMeta) then
		return E.FLIP_TOOL[tool]
	end
	return tool
end

local Preview, PlaneVis = nil, nil

local function newGhost(size)
	local p = Instance.new("Part")
	p.Name = generateName()
	p.Anchored = true
	p.CanCollide = false
	p.CanQuery = false
	p.CanTouch = false
	p.CastShadow = false
	p.Material = Enum.Material.SmoothPlastic
	p.Color = Color3.fromRGB(235, 235, 235)
	p.Transparency = 1
	p.Size = size
	p.Parent = visualParent()
	return p
end

function E.initPreview()
	Preview = newGhost(Vector3.new(4, 4, 4))
	PlaneVis = newGhost(Vector3.new(256, 256, 0.1))
end

local function planeCFrame(origin, normal)
	local up = (math.abs(normal.Y) > 0.99) and Vector3.xAxis or Vector3.yAxis
	return CFrame.lookAt(origin, origin + normal, up)
end

function E.updatePlane()
	if not PlaneVis then return end
	local tool = E.activeBrushTool()
	if tool == "Paint" or tool == "Replace" then
		PlaneVis.Transparency = 1
	elseif tool and State.planeLock == "Manual" then
		local cf = manualPlane()
		PlaneVis.CFrame = planeCFrame(cf.Position, cf.UpVector)
		PlaneVis.Transparency = 0.9
	elseif tool and State.planeLock == "Auto" and Stroke and Stroke.planeOrigin then
		PlaneVis.CFrame = planeCFrame(Stroke.planeOrigin, Stroke.planeNormal)
		PlaneVis.Transparency = 0.9
	else
		PlaneVis.Transparency = 1
	end
end

function E.updatePreview()
	if not Preview then return end
	local tool = E.activeBrushTool()
	if not tool or not Pointer.valid then
		Preview.Transparency = 1
		return
	end
	local hit = E.resolveHit(Pointer.x, Pointer.y, Stroke)
	if not hit then
		Preview.Transparency = 1
		return
	end
	local c = E.brushCenter(hit)
	local d, h = brushDims()
	if State.shape == "Ball" then
		Preview.Shape = Enum.PartType.Ball
		Preview.Size = Vector3.new(d, d, d)
		Preview.CFrame = CFrame.new(c)
	elseif State.shape == "Block" then
		Preview.Shape = Enum.PartType.Block
		Preview.Size = Vector3.new(d, h, d)
		Preview.CFrame = CFrame.new(c)
	else
		Preview.Shape = Enum.PartType.Cylinder
		Preview.Size = Vector3.new(h, d, d)
		Preview.CFrame = CFrame.new(c) * CFrame.Angles(0, 0, math.pi / 2)
	end
	Preview.Transparency = 0.65
end

local IDEMPOTENT = { Add = true, Subtract = true, Paint = true, Replace = true }

local function newStrokeOp(tool)
	local d, h = brushDims()
	return {
		k = "stroke", tool = tool, shape = State.shape, d = d, h = h,
		strength = effStrength(), mat = State.material,
		src = State.replaceSource, dst = State.replaceTarget, flatMode = State.flattenMode,
		auto = State.autoMaterial and (tool == "Add" or tool == "Grow" or tool == "Flatten") or false,
		ignoreWater = State.ignoreWater,
		pts = {},
	}
end

local function logPoint(op, c)
	local pts = op.pts
	local last = pts[#pts]
	if last then
		local dist = (last.pos - c).Magnitude
		if IDEMPOTENT[op.tool] then
			if dist < 1 then return end
		elseif dist < 0.001 then
			last.n += 1
			return
		end
	end
	pts[#pts + 1] = { pos = c, n = 1 }
end

function E.strokeTick()
	if not Stroke or Busy or not E.activeBrushTool() then return end
	local tool = Stroke.tool or E.activeBrushTool()
	local hit = E.resolveHit(Pointer.x, Pointer.y, Stroke)
	if not hit then return end
	if not Stroke.planeOrigin then
		Stroke.planeOrigin = hit
		Stroke.planeNormal = -Workspace.CurrentCamera.CFrame.LookVector
	end
	if not Stroke.flatY then
		Stroke.flatY = (State.planeLock == "Manual") and manualPlane().Position.Y or hit.Y
	end
	local center = E.brushCenter(hit)
	E.applyBrush(tool, center, Stroke.flatY)
	local op = Stroke.op
	if op then
		if tool == "Flatten" then op.flatY = Stroke.flatY end
		logPoint(op, center)
	end
end

local function selectDrag(hit)
	local a = Stroke.start
	local mnx, mxx = math.min(a.X, hit.X), math.max(a.X, hit.X)
	local mnz, mxz = math.min(a.Z, hit.Z), math.max(a.Z, hit.Z)
	local sy = State.regionSize.Y
	local x0, z0 = snapDown(mnx), snapDown(mnz)
	E.setRegion(
		Vector3.new(x0, snapRound(a.Y - sy * 0.25), z0),
		Vector3.new(snapUp(mxx) - x0, sy, snapUp(mxz) - z0)
	)
end

function E.beginStroke(x, y, input)
	Pointer.x, Pointer.y, Pointer.input, Pointer.valid = x, y, input, true
	if Busy then return end
	local tab, tool = State.tab, State.tools[State.tab]
	local brushTool = E.activeBrushTool()
	if E.overHandle() then return end
	if brushTool then
		brushTool = E.modifierTool(brushTool)
		local op = newStrokeOp(brushTool)
		Stroke = { kind = "brush", last = 0, op = op, tool = brushTool }
		E.beginEntry()
		E.record(op)
		E.strokeTick()
		Stroke.last = os.clock()
	elseif tab == "Region" and tool == "Select" then
		local hit = castWorld(x, y, true) or planeHit(x, y, State.regionMin, Vector3.yAxis)
		if hit then
			Stroke = { kind = "select", start = hit }
			selectDrag(hit)
		end
	end
end

function E.moveStroke(x, y)
	Pointer.x, Pointer.y, Pointer.valid = x, y, true
	if Stroke and Stroke.kind == "select" then
		local hit = castWorld(x, y, true) or planeHit(x, y, Stroke.start, Vector3.yAxis)
		if hit then selectDrag(hit) end
	end
end

function E.endStroke()
	if not Stroke then return end
	if Stroke.kind == "brush" then
		E.commitEntry()
	elseif Stroke.kind == "select" then
		E.commitRegion()
	end
	Stroke = nil
	Pointer.input = nil
end

function E.step()
	if Stroke and Stroke.kind == "brush" then
		if os.clock() - Stroke.last >= 0.07 then
			Stroke.last = os.clock()
			E.strokeTick()
		end
	end
	E.updatePreview()
	E.updatePlane()
end

local function mergeSampled(dm, dO, dnx, dny, dnz, sm, so, snx, sny, snz, mergeEmpty)
	for i = 1, dnx do
		local si = clamp(math.floor((i - 0.5) * snx / dnx) + 1, 1, snx)
		for j = 1, dny do
			local sj = clamp(math.floor((j - 0.5) * sny / dny) + 1, 1, sny)
			for k = 1, dnz do
				local sk = clamp(math.floor((k - 0.5) * snz / dnz) + 1, 1, snz)
				local m = sm[si][sj][sk]
				local o = so[si][sj][sk]
				if mergeEmpty or (m ~= AIR and o > 0) then
					dm[i][j][k] = m
					dO[i][j][k] = o
				end
			end
		end
	end
end

local function clearFn(mats, occs, nx, ny, nz)
	for x = 1, nx do
		for y = 1, ny do
			local my, oy = mats[x][y], occs[x][y]
			for z = 1, nz do
				my[z] = AIR
				oy[z] = 0
			end
		end
	end
end

function E.opDelete()
	return runAsync("Delete", function()
		local minV, maxV = E.regionBounds()
		E.beginEntry()
		E.record({ k = "delete", min = minV, max = maxV })
		E.modifyBox(minV, maxV, clearFn, true)
		E.commitEntry()
	end)
end

function E.opFill()
	return runAsync("Fill", function()
		local minV, maxV = E.regionBounds()
		local mode = State.fillMode
		local fm, src = State.fillMaterial, State.fillSource
		E.beginEntry()
		E.record({ k = "fill", mode = mode, min = minV, max = maxV, mat = fm, src = src })
		E.modifyBox(minV, maxV, function(mats, occs, nx, ny, nz)
			for x = 1, nx do
				for y = 1, ny do
					local my, oy = mats[x][y], occs[x][y]
					for z = 1, nz do
						if mode == "Fill" then
							my[z] = fm
							oy[z] = 1
						elseif my[z] == src and oy[z] > 0 then
							my[z] = fm
						end
					end
				end
			end
		end, true)
		E.commitEntry()
	end)
end

function E.opSeaLevel(create)
	return runAsync("Sea Level", function()
		local minV, maxV = E.regionBounds()
		local topY = State.regionMin.Y + State.regionSize.Y
		E.beginEntry()
		E.record({ k = "sea", min = minV, max = maxV, topY = topY, create = create and true or false })
		E.modifyBox(minV, maxV, function(mats, occs, nx, ny, nz, cmin)
			for x = 1, nx do
				for y = 1, ny do
					local cb = cmin.Y + (y - 1) * VS
					local fill = clamp((topY - cb) / VS, 0, 1)
					local my, oy = mats[x][y], occs[x][y]
					for z = 1, nz do
						if create then
							if fill > 0 and (my[z] == AIR or oy[z] <= EPS) then
								my[z] = WATER
								oy[z] = fill
							end
						elseif my[z] == WATER then
							my[z] = AIR
							oy[z] = 0
						end
					end
				end
			end
		end, true)
		E.commitEntry()
	end)
end

function E.opApplyMove()
	return runAsync("Move", function()
		local sMin, sMax = bounds(State.committedMin, State.committedSize)
		local sSize = sMax - sMin
		local dMin = snapVec(State.regionMin, snapRound)
		if dMin == sMin then return end
		if boxCells(sSize) > MAX_TRANSFER then
			warn("[TerrainEditor] Move: region too large")
			return
		end
		local sm, so, nx, ny, nz = readBox(sMin, sMax)
		if not sm then return end
		local merge = State.mergeEmpty
		E.beginEntry()
		E.record({ k = "xfer", sMin = sMin, sMax = sMax, dMin = dMin, dMax = dMin + sSize, merge = merge })
		E.editBoxDirect(sMin, sMax, clearFn)
		E.editBoxDirect(dMin, dMin + sSize, function(mats, occs, dnx, dny, dnz)
			mergeSampled(mats, occs, dnx, dny, dnz, sm, so, nx, ny, nz, merge)
		end)
		E.commitEntry()
		E.setRegion(dMin, sSize)
		E.commitRegion()
	end)
end

function E.opResetTransform()
	E.setRegion(State.committedMin, State.committedSize)
end

function E.opApplyResize()
	return runAsync("Resize", function()
		local sMin, sMax = bounds(State.committedMin, State.committedSize)
		local dMin, dMax = bounds(State.regionMin, State.regionSize)
		local sSize, dSize = sMax - sMin, dMax - dMin
		if sMin == dMin and sSize == dSize then return end
		if boxCells(sSize) > MAX_TRANSFER or boxCells(dSize) > MAX_TRANSFER then
			warn("[TerrainEditor] Resize: region too large")
			return
		end
		local sm, so, nx, ny, nz = readBox(sMin, sMax)
		if not sm then return end
		local merge = State.mergeEmpty
		E.beginEntry()
		E.record({ k = "xfer", sMin = sMin, sMax = sMax, dMin = dMin, dMax = dMax, merge = merge })
		E.editBoxDirect(sMin, sMax, clearFn)
		E.editBoxDirect(dMin, dMax, function(mats, occs, dnx, dny, dnz)
			mergeSampled(mats, occs, dnx, dny, dnz, sm, so, nx, ny, nz, merge)
		end)
		E.commitEntry()
		E.setRegion(dMin, dSize)
		E.commitRegion()
	end)
end

local function rotateArrays(sm, so, nx, ny, nz, axis, dir)
	local dnx, dny, dnz
	if axis == "Y" then dnx, dny, dnz = nz, ny, nx
	elseif axis == "X" then dnx, dny, dnz = nx, nz, ny
	else dnx, dny, dnz = ny, nx, nz end
	local dm = newGrid(dnx, dny, dnz, AIR)
	local dO = newGrid(dnx, dny, dnz, 0)
	for i = 0, nx - 1 do
		for j = 0, ny - 1 do
			for k = 0, nz - 1 do
				local a, b, c
				if axis == "Y" then
					if dir > 0 then a, b, c = k, j, nx - 1 - i else a, b, c = nz - 1 - k, j, i end
				elseif axis == "X" then
					if dir > 0 then a, b, c = i, nz - 1 - k, j else a, b, c = i, k, ny - 1 - j end
				else
					if dir > 0 then a, b, c = ny - 1 - j, i, k else a, b, c = j, nx - 1 - i, k end
				end
				dm[a + 1][b + 1][c + 1] = sm[i + 1][j + 1][k + 1]
				dO[a + 1][b + 1][c + 1] = so[i + 1][j + 1][k + 1]
			end
		end
	end
	return dm, dO, dnx, dny, dnz
end

function E.opRotate(axis, dir, times)
	return runAsync("Rotate", function()
		local sMin, sMax = bounds(State.regionMin, State.regionSize)
		local sSize = sMax - sMin
		if boxCells(sSize) > MAX_TRANSFER then
			warn("[TerrainEditor] Rotate: region too large")
			return
		end
		local sm, so, nx, ny, nz = readBox(sMin, sMax)
		if not sm then return end
		local dm, dO, dnx, dny, dnz = sm, so, nx, ny, nz
		for _ = 1, times or 1 do
			dm, dO, dnx, dny, dnz = rotateArrays(dm, dO, dnx, dny, dnz, axis, dir)
		end
		local dSize = Vector3.new(dnx * VS, dny * VS, dnz * VS)
		local center = sMin + sSize / 2
		local dMin = snapVec(center - dSize / 2, snapRound)
		local merge = State.mergeEmpty
		E.beginEntry()
		E.record({ k = "xfer", sMin = sMin, sMax = sMax, dMin = dMin, dMax = dMin + dSize, merge = merge,
			axis = axis, dir = dir, times = times or 1 })
		E.editBoxDirect(sMin, sMax, clearFn)
		E.editBoxDirect(dMin, dMin + dSize, function(mats, occs, mx, my, mz)
			mergeSampled(mats, occs, mx, my, mz, dm, dO, dnx, dny, dnz, merge)
		end)
		E.commitEntry()
		E.setRegion(dMin, dSize)
		E.commitRegion()
	end)
end

function E.clearAll()
	return runAsync("Clear", function()
		terrain:Clear()
		E.resetHistory()
		Script.list = {}
		State.clearedAll = true
		State.exportClearFirst = true
		if E.onScriptChanged then E.onScriptChanged() end
	end)
end

do
local function fillFromColumns(minV, nxT, nyT, nzT, col, opts)
	local colH, colTop, colMid, colDeep = col.H, col.Top, col.Mid, col.Deep
	local wl, caves, seed = opts.waterLevel, opts.caves, opts.seed or 0
	local totalChunks = math.ceil(nxT / CHUNK) * math.ceil(nyT / CHUNK) * math.ceil(nzT / CHUNK)
	local done = 0
	local last = os.clock()

	local function hasTerrain(mats, nx, ny, nz)
		for i = 1, nx do
			for j = 1, ny do
				local row = mats[i][j]
				for k = 1, nz do
					if row[k] ~= AIR then return true end
				end
			end
		end
		return false
	end

	for cx0 = 0, nxT - 1, CHUNK do
		local cnx = math.min(CHUNK, nxT - cx0)
		for cy0 = 0, nyT - 1, CHUNK do
			local cny = math.min(CHUNK, nyT - cy0)
			for cz0 = 0, nzT - 1, CHUNK do
				if not Alive then return end
				local cnz = math.min(CHUNK, nzT - cz0)
				local cmin = minV + Vector3.new(cx0 * VS, cy0 * VS, cz0 * VS)
				local csize = Vector3.new(cnx * VS, cny * VS, cnz * VS)
				local cmax = cmin + csize

				local maxH, minH = 0, math.huge
				local deepUni, deep0 = true, nil
				for i = 1, cnx do
					for k = 1, cnz do
						local ci = (cx0 + i - 1) * nzT + cz0 + k
						local h = colH[ci]
						if h > maxH then maxH = h end
						if h < minH then minH = h end
						if deepUni then
							local dm = colDeep[ci]
							if deep0 == nil then
								deep0 = dm
							elseif dm ~= deep0 then
								deepUni = false
							end
						end
					end
				end
				local ceilY = maxH
				if wl and wl > ceilY then ceilY = wl end
				local fullySolid = (not caves) and minH >= (cy0 + cny) * VS + 16

				if cy0 * VS >= ceilY + VS then
					local bm, bo
					if opts.history then
						local m0, o0, bx, by, bz = readBox(cmin, cmax)
						if m0 and hasTerrain(m0, bx, by, bz) then
							bm, bo = copy3(m0, bx, by), copy3(o0, bx, by)
						end
					end
					terrain:FillBlock(CFrame.new(cmin + csize / 2), csize, AIR)
					if bm then
						local m1, o1 = readBox(cmin, cmax)
						if m1 then addPatch(cmin, cmax, cnx, cny, cnz, bm, bo, m1, o1) end
					end
				elseif fullySolid and deepUni then
					local bm, bo
					if opts.history then
						local m0, o0, bx, by = readBox(cmin, cmax)
						if m0 then bm, bo = copy3(m0, bx, by), copy3(o0, bx, by) end
					end
					terrain:FillRegion(Region3.new(cmin, cmax), VS, deep0)
					if bm then
						local m1, o1 = readBox(cmin, cmax)
						if m1 then addPatch(cmin, cmax, cnx, cny, cnz, bm, bo, m1, o1) end
					end
				else
					local bm, bo
					if opts.history then
						local m0, o0, bx, by = readBox(cmin, cmax)
						if m0 then bm, bo = copy3(m0, bx, by), copy3(o0, bx, by) end
					end
					local mats, occs = table.create(cnx), table.create(cnx)
					for i = 1, cnx do
						local mx, ox = table.create(cny), table.create(cny)
						local wx = minV.X + (cx0 + i - 0.5) * VS
						for j = 1, cny do
							local my, oy = table.create(cnz, AIR), table.create(cnz, 0)
							local cb = (cy0 + j - 1) * VS
							local cc = cb + VS * 0.5
							for k = 1, cnz do
								local ci = (cx0 + i - 1) * nzT + cz0 + k
								if fullySolid then
									my[k] = colDeep[ci]
									oy[k] = 1
								else
									local h = colH[ci]
									local tf = (h - cb) / VS
									if tf > 1 then tf = 1 elseif tf < 0 then tf = 0 end
									local m, o = AIR, 0
									if tf > 0 then
										o = tf
										local depth = h - cc
										if depth < 5 then m = colTop[ci]
										elseif depth < 16 then m = colMid[ci]
										else m = colDeep[ci] end
										if caves and depth > 10 and cc > 16 then
											local wz = minV.Z + (cz0 + k - 0.5) * VS
											local n1 = math.noise(wx * 0.017 + seed, cc * 0.034 + 3.3, wz * 0.017 + 1.1)
											if math.abs(n1) < 0.08 then
												local n2 = math.noise(wx * 0.017 + 7.7, cc * 0.034 + seed, wz * 0.017 + 5.3)
												if math.abs(n2) < 0.08 then
													m, o = AIR, 0
												end
											end
										end
									end
									if wl and tf < 0.5 and cb < wl then
										local wf = (wl - cb) / VS
										if wf > 1 then wf = 1 end
										if wf > 0 then m, o = WATER, wf end
									end
									my[k] = m
									oy[k] = o
								end
							end
							mx[j] = my
							ox[j] = oy
						end
						mats[i] = mx
						occs[i] = ox
					end
					if writeBox(cmin, cmax, mats, occs) and bm then
						addPatch(cmin, cmax, cnx, cny, cnz, bm, bo, mats, occs)
					end
				end

				done += 1
				if os.clock() - last > 0.012 then
					progress(0.5 + 0.5 * (done / totalChunks))
					task.wait()
					last = os.clock()
				end
			end
		end
	end
end

local BIOME_ORDER = { "Water", "Plains", "Hills", "Dunes", "Canyons", "Mountains", "Lava", "Arctic", "Marsh" }
E.BIOME_ORDER = BIOME_ORDER

local function n01(v) return clamp(v * 1.35 + 0.5, 0, 1) end

local function fbm(x, z, seed, oct)
	local amp, fr, sum, norm = 1, 1, 0, 0
	for i = 1, oct do
		sum += amp * math.noise(x * fr + seed * 0.731 + i * 17.13, z * fr - seed * 0.377 - i * 9.71, seed * 0.113 + i * 3.1 + 0.37)
		norm += amp
		amp *= 0.5
		fr *= 2
	end
	return sum / norm
end

local function sampleBiome(name, wx, wz, H, seed)
	local f = 1 / 220
	if name == "Plains" then
		return H * 0.30 + fbm(wx * f * 0.8, wz * f * 0.8, seed, 3) * H * 0.12
	elseif name == "Hills" then
		return H * 0.34 + fbm(wx * f, wz * f, seed + 3, 4) * H * 0.45
	elseif name == "Dunes" then
		local n = fbm(wx * f * 1.3, wz * f * 1.3, seed + 5, 2)
		local r = 1 - math.abs(math.sin((wx * 0.6 + wz * 0.35) * f * 3 + n * 6))
		return H * 0.28 + r * r * H * 0.14 + n * H * 0.05
	elseif name == "Canyons" then
		local m = n01(fbm(wx * f * 0.7, wz * f * 0.7, seed + 7, 3))
		local s = m * 5
		local fl = math.floor(s)
		local t = (fl + clamp(((s - fl) - 0.7) / 0.3, 0, 1)) / 5
		return H * 0.20 + t * H * 0.45
	elseif name == "Mountains" then
		local r = clamp(1 - math.abs(fbm(wx * f * 0.9, wz * f * 0.9, seed + 11, 5) * 2.4), 0, 1)
		return H * 0.30 + r * r * H * 0.62
	elseif name == "Lava" then
		return H * 0.28 + fbm(wx * f, wz * f, seed + 13, 3) * H * 0.18
	elseif name == "Arctic" then
		return H * 0.31 + fbm(wx * f * 0.9, wz * f * 0.9, seed + 17, 3) * H * 0.14
	elseif name == "Marsh" then
		return H * 0.26 + fbm(wx * f * 1.5, wz * f * 1.5, seed + 19, 2) * H * 0.04
	end
	return H * 0.10 + fbm(wx * f, wz * f, seed + 23, 3) * H * 0.06
end

local MT = Enum.Material
local function biomeMats(name, h, H, wl, wx, wz, seed)
	if name == "Plains" then
		return MT.Grass, MT.Ground, MT.Rock
	elseif name == "Hills" then
		if h > H * 0.62 then return MT.Rock, MT.Rock, MT.Slate end
		local top = (n01(fbm(wx / 90, wz / 90, seed + 31, 2)) > 0.6) and MT.LeafyGrass or MT.Grass
		return top, MT.Ground, MT.Rock
	elseif name == "Dunes" then
		return MT.Sand, MT.Sandstone, MT.Sandstone
	elseif name == "Canyons" then
		return MT.Sandstone, MT.Ground, MT.Rock
	elseif name == "Mountains" then
		if h > H * 0.78 then return MT.Snow, MT.Rock, MT.Rock end
		if h > H * 0.45 then return MT.Rock, MT.Rock, MT.Slate end
		return MT.Grass, MT.Ground, MT.Rock
	elseif name == "Lava" then
		local top = (n01(fbm(wx / 60, wz / 60, seed + 37, 2)) < 0.35) and MT.CrackedLava or MT.Basalt
		return top, MT.Basalt, MT.Basalt
	elseif name == "Arctic" then
		return MT.Snow, MT.Glacier, MT.Glacier
	elseif name == "Marsh" then
		if h < wl then return MT.Mud, MT.Mud, MT.Ground end
		return MT.LeafyGrass, MT.Mud, MT.Ground
	end
	return MT.Sand, MT.Mud, MT.Rock
end

function E.opGenerate()
	return runAsync("Generate", function()
		local minV, maxV = E.regionBounds()
		local size = maxV - minV
		local nxT, nyT, nzT = size.X / VS, size.Y / VS, size.Z / VS
		if nxT * nzT > 512 * 512 or nxT * nyT * nzT > 12000000 then
			warn("[TerrainEditor] Generate: region too large (max 2048 x 2048 studs)")
			return
		end
		local enabled = {}
		for _, b in ipairs(BIOME_ORDER) do
			if State.biomes[b] then enabled[#enabled + 1] = b end
		end
		if #enabled == 0 then return end

		local seed = (tonumber(State.seed) or 0) % 100000
		local H = size.Y
		local wl = H * 0.24
		local cnt = #enabled
		local bf = 1 / (math.max(0.5, State.biomeSize) * 260)
		local bB = clamp(State.blending, 0, 1) * 0.4 + 0.02

		local useHistory = (nxT * nyT * nzT <= MAX_TRANSFER)
		E.beginEntry()
		E.record({
			k = "gen", min = minV, max = maxV, seed = seed, biomes = table.clone(enabled),
			biomeSize = State.biomeSize, blending = State.blending, caves = State.caves,
		})
		if not useHistory and currentEntry then currentEntry.noHistory = true end
		local okGen, errGen = pcall(function()

		local col = { H = table.create(nxT * nzT, 0), Top = {}, Mid = {}, Deep = {} }
		local last = os.clock()
		for i = 1, nxT do
			local wx = minV.X + (i - 0.5) * VS
			for k = 1, nzT do
				if not Alive then return end
				local wz = minV.Z + (k - 0.5) * VS
				local idx, frac = 1, 0.5
				if cnt > 1 then
					local uu = n01(fbm(wx * bf, wz * bf, seed + 101, 2)) * cnt
					idx = clamp(math.floor(uu) + 1, 1, cnt)
					frac = uu - (idx - 1)
				end
				local name = enabled[idx]
				local h = sampleBiome(name, wx, wz, H, seed)
				if cnt > 1 then
					if frac < bB and idx > 1 then
						h = lerp(sampleBiome(enabled[idx - 1], wx, wz, H, seed), h, 0.5 + 0.5 * (frac / bB))
					elseif frac > 1 - bB and idx < cnt then
						h = lerp(h, sampleBiome(enabled[idx + 1], wx, wz, H, seed), 0.5 * ((frac - (1 - bB)) / bB))
					end
				end
				h = clamp(h, 0, H)
				local ci = (i - 1) * nzT + k
				local t, m, d = biomeMats(name, h, H, wl, wx, wz, seed)
				col.H[ci], col.Top[ci], col.Mid[ci], col.Deep[ci] = h, t, m, d
			end
			if os.clock() - last > 0.012 then
				progress(0.5 * (i / nxT))
				task.wait()
				last = os.clock()
			end
		end

		fillFromColumns(minV, nxT, nyT, nzT, col, {
			waterLevel = wl, caves = State.caves, seed = seed, history = useHistory,
		})
		end)
		E.commitEntry()
		if not okGen then warn("[TerrainEditor] Generate: " .. tostring(errGen)) end
	end)
end
end

do
local function fmtN(n)
	if math.abs(n) < 0.005 then return "0" end
	local s = string.format("%.2f", n)
	s = s:gsub("%.?0+$", "")
	return s
end

local function fv(v)
	return ("Vector3.new(%s, %s, %s)"):format(fmtN(v.X), fmtN(v.Y), fmtN(v.Z))
end

local function fcf(v)
	return ("CFrame.new(%s, %s, %s)"):format(fmtN(v.X), fmtN(v.Y), fmtN(v.Z))
end

local function fm(m)
	return "Enum.Material." .. m.Name
end

local H_CORE = [==[
local function R(a, b)
	return Region3.new(a, b):ExpandToGrid(RES)
end

local lastYield = os.clock()
local function pace()
	if os.clock() - lastYield > 1.5 then
		task.wait()
		lastYield = os.clock()
	end
end
]==]

local H_MATS = [==[
local AIR, WATER = Enum.Material.Air, Enum.Material.Water
local EPS = 0.02
]==]

local H_BRUSH = [==[
local function solid(m, oc, x, y, z)
	local mat = m[x][y][z]
	if mat == AIR or mat == WATER then return 0 end
	return oc[x][y][z]
end

local function around(m, oc, x, y, z)
	local a, b = solid(m, oc, x + 1, y, z), solid(m, oc, x - 1, y, z)
	local c, d = solid(m, oc, x, y + 1, z), solid(m, oc, x, y - 1, z)
	local e, f = solid(m, oc, x, y, z + 1), solid(m, oc, x, y, z - 1)
	return math.max(a, b, c, d, e, f), math.min(a, b, c, d, e, f), a + b + c + d + e + f
end

local NEIGHBORS = { { 1, 0, 0 }, { -1, 0, 0 }, { 0, 1, 0 }, { 0, -1, 0 }, { 0, 0, 1 }, { 0, 0, -1 } }

local function dominant(m, oc, x, y, z)
	local best, pick = 0, nil
	for _, n in ipairs(NEIGHBORS) do
		local xx, yy, zz = x + n[1], y + n[2], z + n[3]
		local mat = m[xx][yy][zz]
		if mat ~= AIR and mat ~= WATER and oc[xx][yy][zz] > best then
			best, pick = oc[xx][yy][zz], mat
		end
	end
	return pick
end

local function applyBrush(tool, shape, c, o, mats, occs, nx, ny, nz, org)
	local d = o.d
	local h = (shape == "Ball") and d or o.h
	local hr, hh, k = d / 2, h / 2, o.k or 1
	local x0 = math.max(1, math.floor((c.X - hr - org.X) / RES))
	local x1 = math.min(nx, math.ceil((c.X + hr - org.X) / RES) + 1)
	local y0 = math.max(1, math.floor((c.Y - hh - org.Y) / RES))
	local y1 = math.min(ny, math.ceil((c.Y + hh - org.Y) / RES) + 1)
	local z0 = math.max(1, math.floor((c.Z - hr - org.Z) / RES))
	local z1 = math.min(nz, math.ceil((c.Z + hr - org.Z) / RES) + 1)

	local sm, so = mats, occs
	if tool == "Smooth" or o.auto then
		sm, so = {}, {}
		for x = math.max(1, x0 - 1), math.min(nx, x1 + 1) do
			local mx, ox = {}, {}
			for y = math.max(1, y0 - 1), math.min(ny, y1 + 1) do
				mx[y], ox[y] = table.clone(mats[x][y]), table.clone(occs[x][y])
			end
			sm[x], so[x] = mx, ox
		end
	end
	local ignoreWater, mode = o.ignoreWater, o.mode

	local cx, cy, cz = c.X, c.Y, c.Z
	local cover
	if shape == "Ball" then
		local lim = hr + RES * 0.5
		local lim2 = lim * lim
		cover = function(px, py, pz)
			local dx, dy, dz = px - cx, py - cy, pz - cz
			local d2 = dx * dx + dy * dy + dz * dz
			if d2 >= lim2 then return 0 end
			local v = 0.5 - (math.sqrt(d2) - hr) / RES
			if v > 1 then return 1 end
			return v
		end
	elseif shape == "Block" then
		cover = function(px, py, pz)
			local qx, qy, qz = math.abs(px - cx) - hr, math.abs(py - cy) - hh, math.abs(pz - cz) - hr
			local ex, ey, ez = math.max(qx, 0), math.max(qy, 0), math.max(qz, 0)
			local sd = math.sqrt(ex * ex + ey * ey + ez * ez) + math.min(math.max(qx, qy, qz), 0)
			return math.clamp(0.5 - sd / RES, 0, 1)
		end
	else
		cover = function(px, py, pz)
			local dx, dz = px - cx, pz - cz
			local qr = math.sqrt(dx * dx + dz * dz) - hr
			local qy = math.abs(py - cy) - hh
			local ex, ey = math.max(qr, 0), math.max(qy, 0)
			local sd = math.sqrt(ex * ex + ey * ey) + math.min(math.max(qr, qy), 0)
			return math.clamp(0.5 - sd / RES, 0, 1)
		end
	end

	local function setCell(x, y, z, v, mat)
		if v <= EPS then
			mats[x][y][z], occs[x][y][z] = AIR, 0
		else
			mats[x][y][z], occs[x][y][z] = mat, (v > 1) and 1 or v
		end
	end

	local function pick(x, y, z)
		if o.auto and x > 1 and y > 1 and z > 1 and x < nx and y < ny and z < nz then
			return dominant(sm, so, x, y, z) or o.mat
		end
		return o.mat
	end

	for x = x0, x1 do
		local px = org.X + (x - 0.5) * RES
		for y = y0, y1 do
			local py = org.Y + (y - 0.5) * RES
			for z = z0, z1 do
				local pz = org.Z + (z - 0.5) * RES
				local cv = cover(px, py, pz)
				if cv > 0 then
					local edge = x <= 1 or y <= 1 or z <= 1 or x >= nx or y >= ny or z >= nz
					local m = mats[x][y][z]
					local ov = occs[x][y][z]
					if tool == "Add" then
						if not (m == WATER and (ignoreWater or cv < 0.5)) then
							local isEmpty = (m == AIR) or ov <= EPS
							local newM = m
							if isEmpty or cv >= 0.5 then newM = pick(x, y, z, py) end
							setCell(x, y, z, (ov > cv) and ov or cv, newM)
						end
					elseif tool == "Subtract" then
						if m ~= AIR and not (m == WATER and ignoreWater) then
							local newO = math.min(ov, 1 - cv)
							if newO < ov then setCell(x, y, z, newO, m) end
						end
					elseif tool == "Grow" then
						if not edge and m ~= WATER then
							local cur = (m == AIR) and 0 or ov
							if cur < 1 then
								local nmax = around(mats, occs, x, y, z)
								if nmax > 0 then
									local newM = m
									if m == AIR or cur < 0.35 then newM = pick(x, y, z, py) end
									setCell(x, y, z, cur + k * cv * 0.5 * nmax, newM)
								end
							end
						end
					elseif tool == "Erode" then
						if not edge and m ~= AIR and m ~= WATER then
							local _, nmin = around(mats, occs, x, y, z)
							if nmin < 1 then
								setCell(x, y, z, ov - k * cv * 0.35 * (1 - nmin), m)
							end
						end
					elseif tool == "Smooth" then
						local sM = sm[x][y][z]
						if not edge and sM ~= WATER then
							local selfO = (sM == AIR) and 0 or so[x][y][z]
							local _, _, sum = around(sm, so, x, y, z)
							local newO = selfO + ((selfO + sum) / 7 - selfO) * math.min(1, k * cv * 1.3)
							local newM = sM
							if sM == AIR then newM = dominant(sm, so, x, y, z) or o.mat end
							setCell(x, y, z, newO, newM)
						end
					elseif tool == "Flatten" then
						if m ~= WATER then
							local cur = (m == AIR) and 0 or ov
							local goal = math.clamp((o.flatY - (py - RES / 2)) / RES, 0, 1)
							local f = math.min(1, k * cv * 1.5)
							if goal < cur and (mode == "Erode" or mode == "Both") then
								setCell(x, y, z, cur + (goal - cur) * f, m)
							elseif goal > cur and (mode == "Grow" or mode == "Both") then
								local newM = m
								if m == AIR or cur < 0.35 then newM = pick(x, y, z, py) end
								setCell(x, y, z, cur + (goal - cur) * f, newM)
							end
						end
					elseif tool == "Paint" then
						if cv >= 0.5 and m ~= AIR and m ~= WATER and ov > EPS then
							mats[x][y][z] = o.mat
						end
					elseif tool == "Replace" then
						if cv >= 0.5 and m == o.src and ov > EPS then
							mats[x][y][z] = o.dst
						end
					end
				end
			end
		end
	end
end

local MAX_BATCH = 250000

local function brush(tool, shape, pts, o)
	local d = o.d
	local h = (shape == "Ball") and d or o.h
	local pad = Vector3.new(d / 2 + RES, h / 2 + RES, d / 2 + RES)
	local i, total = 1, #pts
	while i <= total do
		local lo = Vector3.new(pts[i][1], pts[i][2], pts[i][3])
		local hi = lo
		local j = i
		while j <= total do
			local p = pts[j]
			local nlo = Vector3.new(math.min(lo.X, p[1]), math.min(lo.Y, p[2]), math.min(lo.Z, p[3]))
			local nhi = Vector3.new(math.max(hi.X, p[1]), math.max(hi.Y, p[2]), math.max(hi.Z, p[3]))
			local sz = (nhi - nlo + pad * 2) / RES
			if j > i and sz.X * sz.Y * sz.Z > MAX_BATCH then break end
			lo, hi = nlo, nhi
			j += 1
		end
		local reg = R(lo - pad, hi + pad)
		local mats, occs = t:ReadVoxels(reg, RES)
		local nx, ny, nz = mats.Size.X, mats.Size.Y, mats.Size.Z
		local org = reg.CFrame.Position - reg.Size / 2
		for q = i, j - 1 do
			local p = pts[q]
			local c = Vector3.new(p[1], p[2], p[3])
			for _ = 1, p[4] or 1 do
				applyBrush(tool, shape, c, o, mats, occs, nx, ny, nz, org)
			end
			pace()
		end
		t:WriteVoxels(reg, RES, mats, occs)
		i = j
	end
end
]==]

local H_FLOOD = [==[
local function flood(a, b, topY)
	local reg = R(a, b)
	local mats, occs = t:ReadVoxels(reg, RES)
	local sx, sy, sz = mats.Size.X, mats.Size.Y, mats.Size.Z
	local y0 = reg.CFrame.Position.Y - reg.Size.Y / 2
	for x = 1, sx do
		pace()
		for y = 1, sy do
			local fill = math.clamp((topY - (y0 + (y - 1) * RES)) / RES, 0, 1)
			if fill > 0 then
				for z = 1, sz do
					if mats[x][y][z] == AIR or occs[x][y][z] <= 0.02 then
						mats[x][y][z], occs[x][y][z] = WATER, fill
					end
				end
			end
		end
	end
	t:WriteVoxels(reg, RES, mats, occs)
end
]==]

local H_XFER = [==[
local function rotate(sm, so, nx, ny, nz, axis, dir)
	local dx, dy, dz
	if axis == "Y" then dx, dy, dz = nz, ny, nx
	elseif axis == "X" then dx, dy, dz = nx, nz, ny
	else dx, dy, dz = ny, nx, nz end
	local dm, dO = table.create(dx), table.create(dx)
	for x = 1, dx do
		dm[x], dO[x] = table.create(dy), table.create(dy)
		for y = 1, dy do
			dm[x][y], dO[x][y] = table.create(dz, AIR), table.create(dz, 0)
		end
	end
	for i = 0, nx - 1 do
		for j = 0, ny - 1 do
			for k = 0, nz - 1 do
				local a, b, c
				if axis == "Y" then
					if dir > 0 then a, b, c = k, j, nx - 1 - i else a, b, c = nz - 1 - k, j, i end
				elseif axis == "X" then
					if dir > 0 then a, b, c = i, nz - 1 - k, j else a, b, c = i, k, ny - 1 - j end
				else
					if dir > 0 then a, b, c = ny - 1 - j, i, k else a, b, c = j, nx - 1 - i, k end
				end
				dm[a + 1][b + 1][c + 1] = sm[i + 1][j + 1][k + 1]
				dO[a + 1][b + 1][c + 1] = so[i + 1][j + 1][k + 1]
			end
		end
	end
	return dm, dO, dx, dy, dz
end

local function xfer(sMin, sMax, dMin, dMax, merge, axis, dir, times)
	local sm, so = t:ReadVoxels(R(sMin, sMax), RES)
	local nx, ny, nz = sm.Size.X, sm.Size.Y, sm.Size.Z
	if axis then
		for _ = 1, times or 1 do
			sm, so, nx, ny, nz = rotate(sm, so, nx, ny, nz, axis, dir)
		end
	end
	t:FillBlock(CFrame.new((sMin + sMax) / 2), sMax - sMin, AIR)
	local reg = R(dMin, dMax)
	local dm, dO = t:ReadVoxels(reg, RES)
	local dx, dy, dz = dm.Size.X, dm.Size.Y, dm.Size.Z
	for i = 1, dx do
		pace()
		local si = math.clamp(math.floor((i - 0.5) * nx / dx) + 1, 1, nx)
		for j = 1, dy do
			local sj = math.clamp(math.floor((j - 0.5) * ny / dy) + 1, 1, ny)
			for k = 1, dz do
				local sk = math.clamp(math.floor((k - 0.5) * nz / dz) + 1, 1, nz)
				local m, o = sm[si][sj][sk], so[si][sj][sk]
				if merge or (m ~= AIR and o > 0) then
					dm[i][j][k], dO[i][j][k] = m, o
				end
			end
		end
	end
	t:WriteVoxels(reg, RES, dm, dO)
end
]==]

local H_GEN = [==[
local MT = Enum.Material

local function lerp(a, b, f)
	return a + (b - a) * f
end

local function n01(v)
	return math.clamp(v * 1.35 + 0.5, 0, 1)
end

local function fbm(x, z, seed, oct)
	local amp, fr, sum, norm = 1, 1, 0, 0
	for i = 1, oct do
		sum += amp * math.noise(x * fr + seed * 0.731 + i * 17.13, z * fr - seed * 0.377 - i * 9.71, seed * 0.113 + i * 3.1 + 0.37)
		norm += amp
		amp *= 0.5
		fr *= 2
	end
	return sum / norm
end

local function sampleBiome(name, wx, wz, H, seed)
	local f = 1 / 220
	if name == "Plains" then
		return H * 0.30 + fbm(wx * f * 0.8, wz * f * 0.8, seed, 3) * H * 0.12
	elseif name == "Hills" then
		return H * 0.34 + fbm(wx * f, wz * f, seed + 3, 4) * H * 0.45
	elseif name == "Dunes" then
		local n = fbm(wx * f * 1.3, wz * f * 1.3, seed + 5, 2)
		local r = 1 - math.abs(math.sin((wx * 0.6 + wz * 0.35) * f * 3 + n * 6))
		return H * 0.28 + r * r * H * 0.14 + n * H * 0.05
	elseif name == "Canyons" then
		local m = n01(fbm(wx * f * 0.7, wz * f * 0.7, seed + 7, 3))
		local s = m * 5
		local fl = math.floor(s)
		local step = (fl + math.clamp(((s - fl) - 0.7) / 0.3, 0, 1)) / 5
		return H * 0.20 + step * H * 0.45
	elseif name == "Mountains" then
		local r = math.clamp(1 - math.abs(fbm(wx * f * 0.9, wz * f * 0.9, seed + 11, 5) * 2.4), 0, 1)
		return H * 0.30 + r * r * H * 0.62
	elseif name == "Lava" then
		return H * 0.28 + fbm(wx * f, wz * f, seed + 13, 3) * H * 0.18
	elseif name == "Arctic" then
		return H * 0.31 + fbm(wx * f * 0.9, wz * f * 0.9, seed + 17, 3) * H * 0.14
	elseif name == "Marsh" then
		return H * 0.26 + fbm(wx * f * 1.5, wz * f * 1.5, seed + 19, 2) * H * 0.04
	end
	return H * 0.10 + fbm(wx * f, wz * f, seed + 23, 3) * H * 0.06
end

local function biomeMats(name, h, H, wl, wx, wz, seed)
	if name == "Plains" then
		return MT.Grass, MT.Ground, MT.Rock
	elseif name == "Hills" then
		if h > H * 0.62 then return MT.Rock, MT.Rock, MT.Slate end
		local top = (n01(fbm(wx / 90, wz / 90, seed + 31, 2)) > 0.6) and MT.LeafyGrass or MT.Grass
		return top, MT.Ground, MT.Rock
	elseif name == "Dunes" then
		return MT.Sand, MT.Sandstone, MT.Sandstone
	elseif name == "Canyons" then
		return MT.Sandstone, MT.Ground, MT.Rock
	elseif name == "Mountains" then
		if h > H * 0.78 then return MT.Snow, MT.Rock, MT.Rock end
		if h > H * 0.45 then return MT.Rock, MT.Rock, MT.Slate end
		return MT.Grass, MT.Ground, MT.Rock
	elseif name == "Lava" then
		local top = (n01(fbm(wx / 60, wz / 60, seed + 37, 2)) < 0.35) and MT.CrackedLava or MT.Basalt
		return top, MT.Basalt, MT.Basalt
	elseif name == "Arctic" then
		return MT.Snow, MT.Glacier, MT.Glacier
	elseif name == "Marsh" then
		if h < wl then return MT.Mud, MT.Mud, MT.Ground end
		return MT.LeafyGrass, MT.Mud, MT.Ground
	end
	return MT.Sand, MT.Mud, MT.Rock
end

local function generateBiomes(cfg)
	local minV = cfg.min
	local size = cfg.max - cfg.min
	local nxT, nyT, nzT = size.X / RES, size.Y / RES, size.Z / RES
	local list, cnt = cfg.biomes, #cfg.biomes
	local seed, H = cfg.seed, size.Y
	local wl = H * 0.24
	local bf = 1 / (math.max(0.5, cfg.biomeSize) * 260)
	local bB = math.clamp(cfg.blending, 0, 1) * 0.4 + 0.02
	local TILE = 32

	local tiles = {}
	local last = os.clock()
	for gx0 = 0, nxT - 1, TILE do
		local tnx = math.min(TILE, nxT - gx0)
		for gz0 = 0, nzT - 1, TILE do
			local tnz = math.min(TILE, nzT - gz0)
			local colH, colTop, colMid, colDeep = {}, {}, {}, {}
			local maxH, minH, uni, deep0 = 0, math.huge, true, nil
			for i = 1, tnx do
				local wx = minV.X + (gx0 + i - 0.5) * RES
				for k = 1, tnz do
					local wz = minV.Z + (gz0 + k - 0.5) * RES
					local idx, frac = 1, 0.5
					if cnt > 1 then
						local uu = n01(fbm(wx * bf, wz * bf, seed + 101, 2)) * cnt
						idx = math.clamp(math.floor(uu) + 1, 1, cnt)
						frac = uu - (idx - 1)
					end
					local name = list[idx]
					local h = sampleBiome(name, wx, wz, H, seed)
					if cnt > 1 then
						if frac < bB and idx > 1 then
							h = lerp(sampleBiome(list[idx - 1], wx, wz, H, seed), h, 0.5 + 0.5 * (frac / bB))
						elseif frac > 1 - bB and idx < cnt then
							h = lerp(h, sampleBiome(list[idx + 1], wx, wz, H, seed), 0.5 * ((frac - (1 - bB)) / bB))
						end
					end
					h = math.clamp(h, 0, H)
					local ci = (i - 1) * tnz + k
					local top, mid, deep = biomeMats(name, h, H, wl, wx, wz, seed)
					colH[ci], colTop[ci], colMid[ci], colDeep[ci] = h, top, mid, deep
					if h > maxH then maxH = h end
					if h < minH then minH = h end
					if uni then
						if deep0 == nil then deep0 = deep elseif deep ~= deep0 then uni = false end
					end
				end
			end
			tiles[#tiles + 1] = {
				gx0 = gx0, gz0 = gz0, tnx = tnx, tnz = tnz,
				H = colH, Top = colTop, Mid = colMid, Deep = colDeep, ceil = math.max(maxH, wl),
				minH = minH, uni = uni, deep0 = deep0,
			}
			if os.clock() - last > 1.5 then
				task.wait()
				last = os.clock()
			end
		end
	end

	last = os.clock()
	local bufs = {}
	local function getBuf(bx, by, bz)
		local key = (bx * 64 + by) * 64 + bz
		local b = bufs[key]
		if not b then
			local bm, bo = table.create(bx), table.create(bx)
			for i = 1, bx do
				local mx, ox = table.create(by), table.create(by)
				for j = 1, by do
					mx[j], ox[j] = table.create(bz, AIR), table.create(bz, 0)
				end
				bm[i], bo[i] = mx, ox
			end
			b = { bm, bo }
			bufs[key] = b
		end
		return b[1], b[2]
	end

	for _, tl in ipairs(tiles) do
		local gx0, gz0, tnx, tnz = tl.gx0, tl.gz0, tl.tnx, tl.tnz
		local colH, colTop, colMid, colDeep = tl.H, tl.Top, tl.Mid, tl.Deep
		for gy0 = 0, nyT - 1, TILE do
			local tny = math.min(TILE, nyT - gy0)
			local cmin = minV + Vector3.new(gx0 * RES, gy0 * RES, gz0 * RES)
			local csize = Vector3.new(tnx * RES, tny * RES, tnz * RES)
			local solid = (not cfg.caves) and tl.minH >= (gy0 + tny) * RES + 16
			if gy0 * RES >= tl.ceil + RES then
				t:FillBlock(CFrame.new(cmin + csize / 2), csize, AIR)
			elseif solid and tl.uni then
				t:FillRegion(Region3.new(cmin, cmin + csize), RES, tl.deep0)
			else
				local mats, occs = getBuf(tnx, tny, tnz)
				for i = 1, tnx do
					local mx, ox = mats[i], occs[i]
					local wx = minV.X + (gx0 + i - 0.5) * RES
					for j = 1, tny do
						local my, oy = mx[j], ox[j]
						local cb = (gy0 + j - 1) * RES
						local cc = cb + RES * 0.5
						for k = 1, tnz do
							local ci = (i - 1) * tnz + k
							if solid then
								my[k], oy[k] = colDeep[ci], 1
							else
								local h = colH[ci]
								local tf = math.clamp((h - cb) / RES, 0, 1)
								local m, o = AIR, 0
								if tf > 0 then
									o = tf
									local depth = h - cc
									if depth < 5 then m = colTop[ci]
									elseif depth < 16 then m = colMid[ci]
									else m = colDeep[ci] end
									if cfg.caves and depth > 10 and cc > 16 then
										local wz = minV.Z + (gz0 + k - 0.5) * RES
										local n1 = math.noise(wx * 0.017 + seed, cc * 0.034 + 3.3, wz * 0.017 + 1.1)
										if math.abs(n1) < 0.08 then
											local n2 = math.noise(wx * 0.017 + 7.7, cc * 0.034 + seed, wz * 0.017 + 5.3)
											if math.abs(n2) < 0.08 then m, o = AIR, 0 end
										end
									end
								end
								if tf < 0.5 and cb < wl then
									local wf = math.min((wl - cb) / RES, 1)
									if wf > 0 then m, o = WATER, wf end
								end
								my[k], oy[k] = m, o
							end
						end
					end
				end
				t:WriteVoxels(Region3.new(cmin, cmin + csize), RES, mats, occs)
			end
		end
		if os.clock() - last > 1.5 then
			task.wait()
			last = os.clock()
		end
	end
end
]==]

local function packPoints(pts, withN, indent)
	local lines, cur = {}, indent
	for _, p in ipairs(pts) do
		local extra = (withN and p.n > 1) and (", " .. p.n) or ""
		local s = ("{ %s, %s, %s%s }, "):format(fmtN(p.pos.X), fmtN(p.pos.Y), fmtN(p.pos.Z), extra)
		if #cur + #s > 100 and #cur > #indent then
			lines[#lines + 1] = (cur:gsub("%s+$", ""))
			cur = indent
		end
		cur = cur .. s
	end
	if #cur > #indent then
		lines[#lines + 1] = (cur:gsub("%s+$", ""))
	end
	return lines
end

local STROKE_CHUNK = 150

local function emitStroke(op, blocks, used)
	local tool, shape, d = op.tool, op.shape, op.d
	local h = (shape == "Ball") and d or op.h
	local pts = op.pts
	local total = #pts
	used.brush = true

	local o = { "d = " .. fmtN(d), "h = " .. fmtN(h) }
	if tool == "Grow" or tool == "Erode" or tool == "Smooth" or tool == "Flatten" then
		o[#o + 1] = ("k = %.4g"):format(op.strength)
	end
	if tool == "Add" or tool == "Grow" or tool == "Smooth" or tool == "Flatten" or tool == "Paint" then
		o[#o + 1] = "mat = " .. fm(op.mat)
	end
	if tool == "Replace" then
		o[#o + 1] = "src = " .. fm(op.src)
		o[#o + 1] = "dst = " .. fm(op.dst)
	end
	if tool == "Flatten" then
		o[#o + 1] = "flatY = " .. fmtN(op.flatY or pts[1].pos.Y)
		o[#o + 1] = ("mode = %q"):format(op.flatMode)
	end
	if op.auto then o[#o + 1] = "auto = true" end
	if op.ignoreWater and (tool == "Add" or tool == "Subtract") then o[#o + 1] = "ignoreWater = true" end

	local chunks = math.max(1, math.ceil(total / STROKE_CHUNK))
	for c = 1, chunks do
		local first, last = (c - 1) * STROKE_CHUNK + 1, math.min(c * STROKE_CHUNK, total)
		local slice = table.move(pts, first, last, 1, {})
		local lines = { ("brush(%q, %q, {"):format(tool, shape) }
		for _, ln in ipairs(packPoints(slice, true, "\t")) do
			lines[#lines + 1] = ln
		end
		lines[#lines + 1] = "}, { " .. table.concat(o, ", ") .. " })"
		blocks[#blocks + 1] = table.concat(lines, "\n")
	end
end

local function emit(op, blocks, used, idx)
	local k = op.k
	if k == "stroke" then
		emitStroke(op, blocks, used)
		return
	end
	local out = {}
	if k == "delete" then
		out[#out + 1] = ("t:FillBlock(%s, %s, Enum.Material.Air)"):format(fcf((op.min + op.max) / 2), fv(op.max - op.min))
	elseif k == "fill" then
		if op.mode == "Replace" then
				out[#out + 1] = ("t:ReplaceMaterial(R(%s, %s), RES, %s, %s)"):format(fv(op.min), fv(op.max), fm(op.src), fm(op.mat))
		else
				out[#out + 1] = ("t:FillRegion(R(%s, %s), RES, %s)"):format(fv(op.min), fv(op.max), fm(op.mat))
		end
	elseif k == "sea" then
		if op.create then
			used.flood = true
				out[#out + 1] = ("flood(%s, %s, %s)"):format(fv(op.min), fv(op.max), fmtN(op.topY))
		else
				out[#out + 1] = ("t:ReplaceMaterial(R(%s, %s), RES, Enum.Material.Water, Enum.Material.Air)"):format(fv(op.min), fv(op.max))
		end
	elseif k == "xfer" then
		used.xfer = true
		local args = ("%s, %s, %s, %s, %s"):format(fv(op.sMin), fv(op.sMax), fv(op.dMin), fv(op.dMax), tostring(op.merge and true or false))
		if op.axis then
			args = args .. (", %q, %d, %d"):format(op.axis, op.dir, op.times)
		end
		out[#out + 1] = "xfer(" .. args .. ")"
	elseif k == "gen" then
		used.gen = true
		local names = {}
		for i, b in ipairs(op.biomes) do names[i] = ("%q"):format(b) end
		out[#out + 1] = "generateBiomes({"
		out[#out + 1] = ("\tmin = %s, max = %s,"):format(fv(op.min), fv(op.max))
		out[#out + 1] = ("\tseed = %s, biomeSize = %s, blending = %s, caves = %s,"):format(
			fmtN(op.seed), fmtN(op.biomeSize), fmtN(op.blending), tostring(op.caves and true or false))
		out[#out + 1] = "\tbiomes = { " .. table.concat(names, ", ") .. " },"
		out[#out + 1] = "})"
	end
	if #out > 0 then
		blocks[#blocks + 1] = table.concat(out, "\n")
	end
end

local function trimBlock(text)
	return (text:gsub("^%s+", ""):gsub("%s+$", ""))
end

local function buildScript()
	local ops, used, idx = {}, {}, 0
	for _, item in ipairs(Script.list) do
		if item.active ~= false and not item.dead then
			for _, op in ipairs(item.ops) do
				idx += 1
				emit(op, ops, used, idx)
			end
		end
	end
	local wantClear = State.clearedAll and State.exportClearFirst
	if idx == 0 and not wantClear then
		return nil, 0
	end

	local blocks = {
		table.concat({
			"-- Terrain Editor by NarsEdv | Script in ServerScriptService",
			"local t = workspace.Terrain",
			"local RES = 4",
		}, "\n"),
	}

	if wantClear then
		blocks[#blocks + 1] = "t:Clear()"
	end

	if #MatColorOrder > 0 then
		local lines = {}
		for _, m in ipairs(MatColorOrder) do
			local c = MatColors[m]
			lines[#lines + 1] = ("t:SetMaterialColor(%s, Color3.fromRGB(%d, %d, %d))"):format(
				fm(m), math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
		end
		blocks[#blocks + 1] = table.concat(lines, "\n")
	end

	local needHelpers = used.brush or used.flood or used.xfer or used.gen
	local needR = needHelpers and true or false
	if not needR then
		for _, b in ipairs(ops) do
			if b:find("R%(") then needR = true break end
		end
	end
	if needR then
		blocks[#blocks + 1] = trimBlock(H_CORE)
	end
	if needHelpers then
		blocks[#blocks + 1] = trimBlock(H_MATS)
		if used.brush then blocks[#blocks + 1] = trimBlock(H_BRUSH) end
		if used.flood then blocks[#blocks + 1] = trimBlock(H_FLOOD) end
		if used.xfer then blocks[#blocks + 1] = trimBlock(H_XFER) end
		if used.gen then blocks[#blocks + 1] = trimBlock(H_GEN) end
	end

	if #ops > 0 then
		for _, b in ipairs(ops) do
			blocks[#blocks + 1] = b
		end
	end
	blocks[#blocks + 1] = 'print("[TerrainEditor] Terrain build finished")'
	return blocks, idx
end

function E.generateCode()
	local ok, blocks, count = pcall(buildScript)
	if not ok then
		warn("[TerrainEditor] Generate Code: " .. tostring(blocks))
		return nil, 0
	end
	return blocks, count or 0
end

function E.opCount()
	local n = 0
	for _, item in ipairs(Script.list) do
		if item.active ~= false and not item.dead then
			n += #item.ops
		end
	end
	return n
end
end

function E.destroy()
	Alive = false
	for _, c in ipairs(Conns) do
		pcall(function() c:Disconnect() end)
	end
	Conns = {}
	if RegionVis.Part then RegionVis.Part:Destroy() end
	if Preview then Preview:Destroy() end
	if PlaneVis then PlaneVis:Destroy() end
	if sg then sg:Destroy() end
end

local T = {
	bg       = Color3.fromRGB(17, 17, 17),
	header   = Color3.fromRGB(10, 10, 10),
	surface  = Color3.fromRGB(27, 27, 27),
	hover    = Color3.fromRGB(40, 40, 40),
	active   = Color3.fromRGB(56, 56, 56),
	line     = Color3.fromRGB(36, 36, 36),
	divider  = Color3.fromRGB(25, 25, 25),
	stroke   = Color3.fromRGB(84, 84, 84),
	strokeOn = Color3.fromRGB(205, 205, 205),
	text     = Color3.fromRGB(236, 236, 236),
	sub      = Color3.fromRGB(168, 168, 168),
	dim      = Color3.fromRGB(110, 110, 110),
	white    = Color3.fromRGB(255, 255, 255),
	black    = Color3.fromRGB(10, 10, 10),
	accent   = Color3.fromRGB(232, 232, 232),
	pressed  = Color3.fromRGB(180, 180, 180),
	track    = Color3.fromRGB(54, 54, 54),
}

local DISCORD_LINK = "https://discord.gg/6GmpsmNvY"

local FONT, FONT_C = Enum.Font.GothamMedium, Enum.Font.Code
local TS = { title = 12, head = 11, body = 12, small = 11, tiny = 10 }

local IC = { sm = 14, lg = 24, badge = 10 }

local RAD = { sm = 4, md = 6 }
local ROW_H, CTL_H, LABEL_W = 26, 22, 84

local UI = {}

local TI_FAST = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TI_POP  = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TI_SLOW = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function tween(o, info, props)
	local tw = TweenService:Create(o, info, props)
	tw:Play()
	return tw
end

local function apply(o, props, animate)
	if animate then
		tween(o, TI_FAST, props)
	else
		for k, v in pairs(props) do o[k] = v end
	end
end

local NAME_PREFIX = "_narsedv_"

local function scramble(inst)
	if inst.Name:sub(1, #NAME_PREFIX) ~= NAME_PREFIX then
		inst.Name = generateName()
	end
end

local function new(class, props, parent)
	local o = Instance.new(class)
	for k, v in pairs(props) do o[k] = v end
	o.Name = generateName()
	if parent then o.Parent = parent end
	return o
end

for _, d in ipairs(sg:GetDescendants()) do scramble(d) end
bind(sg.DescendantAdded, scramble)

local function corner(o, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r or RAD.md) }, o)
end

local function stroke(o, col, th)
	return new("UIStroke", {
		Color = col or T.stroke, Thickness = th or 0.5,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}, o)
end

local function pad(o, l, t, r, b)
	return new("UIPadding", {
		PaddingLeft = UDim.new(0, l), PaddingTop = UDim.new(0, t),
		PaddingRight = UDim.new(0, r), PaddingBottom = UDim.new(0, b),
	}, o)
end

local function label(parent, str, props)
	local p = {
		Text = str, BackgroundTransparency = 1, Font = FONT, TextSize = TS.body,
		TextColor3 = T.sub, TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, 0, 1, 0),
	}
	for k, v in pairs(props or {}) do p[k] = v end
	return new("TextLabel", p, parent)
end

local function icon(parent, image, size, props)
	local p = {
		Size = UDim2.new(0, size, 0, size), BackgroundTransparency = 1,
		Image = image, ImageColor3 = T.text,
	}
	for k, v in pairs(props or {}) do p[k] = v end
	return new("ImageLabel", p, parent)
end

local function isPointer(input)
	return input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch
end
local function isMove(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
end

local function makeDraggable(handle, target, onMove, onEnd, canDrag)
	local dragging, startPos, basePos = false, nil, nil
	bind(handle.InputBegan, function(input)
		if isPointer(input) and (not canDrag or canDrag()) then
			dragging, startPos, basePos = true, input.Position, target.Position
		end
	end)
	bind(UserInputService.InputChanged, function(input)
		if dragging and isMove(input) then
			local d = input.Position - startPos
			target.Position = UDim2.new(basePos.X.Scale, basePos.X.Offset + d.X, basePos.Y.Scale, basePos.Y.Offset + d.Y)
			if onMove then onMove() end
		end
	end)
	bind(UserInputService.InputEnded, function(input)
		if isPointer(input) then
			local was = dragging
			dragging = false
			if was and onEnd then onEnd() end
		end
	end)
end

local function pressFx(btn, depth)
	local sc = new("UIScale", { Scale = 1 }, btn)
	local d = depth or 0.95
	local function release() tween(sc, TI_POP, { Scale = 1 }) end
	bind(btn.InputBegan, function(i)
		if isPointer(i) then tween(sc, TI_FAST, { Scale = d }) end
	end)
	bind(btn.InputEnded, function(i)
		if isPointer(i) then release() end
	end)
	bind(btn.MouseLeave, release)
	return sc
end

local PANEL_W, TITLE_H, TAB_H = 270, 26, 28
local COLLAPSED = UDim2.new(0, PANEL_W, 0, TITLE_H)

local DOCK_Y, DOCK_ZONE_W = 78, 35
local DOCK_SIZE = UDim2.new(0, PANEL_W, 1, -DOCK_Y)
local DOCK_POS = UDim2.new(0, 0, 0, DOCK_Y)
local FLOAT_GAP = 64
local FLOAT_POS = UDim2.new(0, FLOAT_GAP, 0, DOCK_Y)

local dockPreview = new("Frame", {
	Name = "DockPreview", Size = UDim2.new(0, DOCK_ZONE_W, 1, -DOCK_Y), Position = UDim2.new(0, 0, 0, DOCK_Y),
	BackgroundColor3 = Color3.fromRGB(40, 120, 255), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 1,
}, sg)

local main = new("Frame", {
	Name = "Main", Size = DOCK_SIZE, Position = DOCK_POS,
	BackgroundColor3 = T.bg, BorderSizePixel = 0, ClipsDescendants = true, Active = true, ZIndex = 2,
}, sg)
GUI.Main = main

local Renders = {}

local function floatSize(y)
	y = y or main.Position.Y.Offset
	if sg.AbsoluteSize.Y - y < 140 then
		return UDim2.new(0, PANEL_W, 0, 140)
	end
	return UDim2.new(0, PANEL_W, 1, -y)
end

local titleBar = new("Frame", {
	Name = "Header", Size = UDim2.new(1, 0, 0, TITLE_H), BackgroundColor3 = T.header, BorderSizePixel = 0,
}, main)
icon(titleBar, Icons.Terrain, IC.sm, { Position = UDim2.new(0, 8, 0.5, -IC.sm / 2), ImageColor3 = T.white })
do
local titleWrap = new("Frame", {
	Position = UDim2.new(0, 30, 0, 0), Size = UDim2.new(1, -(30 + 92), 1, 0),
	BackgroundTransparency = 1, ClipsDescendants = true,
}, titleBar)
new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
	Padding = UDim.new(0, 7), SortOrder = Enum.SortOrder.LayoutOrder,
}, titleWrap)
label(titleWrap, "Terrain Editor", {
	Font = FONT, TextSize = TS.title, TextColor3 = T.white, LayoutOrder = 1,
	Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, TextTruncate = Enum.TextTruncate.None,
})
new("Frame", {
	Size = UDim2.new(0, 1, 0, 12), BackgroundColor3 = T.stroke, BorderSizePixel = 0, LayoutOrder = 2,
}, titleWrap)
label(titleWrap, "NarsEdv", {
	Font = FONT, TextSize = TS.small, TextColor3 = T.sub, LayoutOrder = 3,
	Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, TextTruncate = Enum.TextTruncate.None,
})
end
local dockHot = false
local function showDockPreview(on)
	if on == dockHot then return end
	dockHot = on
	tween(dockPreview, TI_FAST, { BackgroundTransparency = on and 0.55 or 1 })
end

local function panelTouchesDock()
	local p, sz = main.AbsolutePosition, main.AbsoluteSize
	local dp, ds = dockPreview.AbsolutePosition, dockPreview.AbsoluteSize
	return p.X < dp.X + ds.X and p.X + sz.X > dp.X and p.Y < dp.Y + ds.Y and p.Y + sz.Y > dp.Y
end

local dockPanel
makeDraggable(titleBar, main, function()
	local x = clamp(main.Position.X.Offset, -(PANEL_W - 60), math.max(0, sg.AbsoluteSize.X - 60))
	local y = clamp(main.Position.Y.Offset, 0, math.max(0, sg.AbsoluteSize.Y - TITLE_H))
	main.Position = UDim2.new(0, x, 0, y)
	if not State.minimized then
		main.Size = floatSize()
	end
	showDockPreview(panelTouchesDock())
end, function()
	local hit = panelTouchesDock()
	showDockPreview(false)
	if hit then dockPanel() end
end, function()
	return not State.docked
end)

local progressBar = new("Frame", {
	Size = UDim2.new(0, 0, 0, 2), Position = UDim2.new(0, 0, 1, -2),
	BackgroundColor3 = T.white, BorderSizePixel = 0, Visible = false, ZIndex = 3,
}, titleBar)

local ctrl = new("Frame", {
	AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -4, 0, 0),
	Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1,
}, titleBar)
new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder,
}, ctrl)

local function iconButton(parent, image, order)
	local b = new("TextButton", {
		Text = "", AutoButtonColor = false, BackgroundTransparency = 1, BorderSizePixel = 0,
		Size = UDim2.new(0, 22, 0, 22), LayoutOrder = order,
	}, parent)
	local ico = icon(b, image, IC.sm, {
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ImageColor3 = T.dim,
	})
	bind(b.MouseEnter, function() tween(ico, TI_FAST, { ImageColor3 = T.white }) end)
	bind(b.MouseLeave, function() tween(ico, TI_FAST, { ImageColor3 = T.dim }) end)
	pressFx(b, 0.86)
	return b, ico
end

new("Frame", { Size = UDim2.new(0, 6, 0, 1), BackgroundTransparency = 1, LayoutOrder = 2 }, ctrl)
local dockBtn = iconButton(ctrl, Icons.Dock, 3)
local minBtn, minIco = iconButton(ctrl, Icons.Min, 3)
local closeBtn = iconButton(ctrl, Icons.Close, 4)
minBtn.Visible = false

local tabBar = new("Frame", {
	Size = UDim2.new(1, 0, 0, TAB_H), Position = UDim2.new(0, 0, 0, TITLE_H),
	BackgroundColor3 = T.header, BorderSizePixel = 0,
}, main)

local content = new("ScrollingFrame", {
	Size = UDim2.new(1, 0, 1, -(TITLE_H + TAB_H)), Position = UDim2.new(0, 0, 0, TITLE_H + TAB_H),
	BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
	ScrollBarImageColor3 = T.stroke, CanvasSize = UDim2.new(0, 0, 0, 0),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollingDirection = Enum.ScrollingDirection.Y,
	VerticalScrollBarInset = Enum.ScrollBarInset.None,
}, main)

local Pages = {}
local function newPage(name)
	local f = new("Frame", {
		Name = name, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, Visible = false,
	}, content)
	new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, f)
	pad(f, 10, 8, 10, 14)
	Pages[name] = f
	return f
end
newPage("Create"); newPage("Region"); newPage("Edit")

local Reg = { Create = {}, Region = {}, Edit = {} }
local Hooks = {}
local TileSets = {}

local Groups = {}

local function reg(tab, frame, tools, cond, head)
	local set = nil
	if tools then
		set = {}
		for _, t in ipairs(tools) do set[t] = true end
	end
	table.insert(Reg[tab], { frame = frame, tools = set, cond = cond, group = Groups[tab], head = head })
	return frame
end

local function refreshVisibility()
	local tab = State.tab
	local tool = State.tools[tab]
	for name, page in pairs(Pages) do
		page.Visible = (name == tab)
	end
	for _, r in ipairs(Reg[tab]) do
		local vis = (r.tools == nil) or (tool ~= nil and r.tools[tool] == true)
		if vis and r.cond then vis = r.cond() and true or false end
		if vis and r.group and r.group.collapsed and not r.head then vis = false end
		r.frame.Visible = vis
	end
	for _, h in ipairs(Hooks) do h() end
end

local function refreshSettings()
	local tab = State.tab
	local tool = State.tools[tab]
	refreshVisibility()
	local ts = TileSets[tab]
	if ts then
		for id, tl in pairs(ts) do tl.set(tool == id, true) end
	end
	E.onToolChanged()
end

local TabButtons = {}
local function setTab(name)
	State.tab = name
	for n, b in pairs(TabButtons) do
		local on = (n == name)
		tween(b.btn, TI_FAST, { BackgroundColor3 = on and T.bg or T.header, TextColor3 = on and T.white or T.dim })
		tween(b.bar, TI_SLOW, { Size = UDim2.new(on and 1 or 0, 0, 0, 2) })
	end
	content.CanvasPosition = Vector2.new(0, 0)
	refreshSettings()
end

for i, name in ipairs({ "Create", "Region", "Edit" }) do
	local b = new("TextButton", {
		Text = name, Font = FONT, TextSize = TS.body, AutoButtonColor = false, BorderSizePixel = 0,
		Size = UDim2.new(1 / 3, 0, 1, 0), Position = UDim2.new((i - 1) / 3, 0, 0, 0),
		BackgroundColor3 = T.header, TextColor3 = T.dim,
	}, tabBar)
	local bar = new("Frame", {
		AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0),
		Size = UDim2.new(0, 0, 0, 2), BackgroundColor3 = T.white, BorderSizePixel = 0,
	}, b)
	TabButtons[name] = { btn = b, bar = bar }
	bind(b.MouseButton1Click, function() setTab(name) end)
	pressFx(b, 0.97)
end

bind(closeBtn.MouseButton1Click, function() GUI.Destroy() end)
local PANEL_TI = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function setMinimized(v)
	State.minimized = v
	minIco.Image = v and Icons.ArrowDown or Icons.Min
	tween(main, PANEL_TI, {
		Size = v and COLLAPSED or floatSize(),
	})
end

dockPanel = function()
	State.docked = true
	State.minimized = false
	minIco.Image = Icons.Min
	dockBtn.Visible, minBtn.Visible = true, false
	tween(main, PANEL_TI, { Position = DOCK_POS, Size = DOCK_SIZE })
end

local function floatPanel()
	State.docked = false
	dockBtn.Visible, minBtn.Visible = false, true
	tween(main, PANEL_TI, { Position = FLOAT_POS, Size = DOCK_SIZE })
end

bind(dockBtn.MouseButton1Click, floatPanel)
bind(minBtn.MouseButton1Click, function()
	setMinimized(not State.minimized)
end)

progressHook = function(p)
	if p == nil then
		progressBar.Visible = false
		return
	end
	progressBar.Visible = true
	progressBar.Size = UDim2.new(clamp(p, 0, 1), 0, 0, 2)
end

function UI.syncBrush(animate)
	for _, r in ipairs(Renders) do r() end
end

function UI.onBrushToggle(v)
	if v and not BRUSH_TOOLS[State.tools.Edit] then
		State.tools.Edit = "Add"
		refreshSettings()
	end
	UI.syncBrush(true)
end

local function rowFrame(parent, order, h)
	return new("Frame", { Size = UDim2.new(1, 0, 0, h), BackgroundTransparency = 1, LayoutOrder = order }, parent)
end

local function autoFrame(parent, order)
	local f = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, LayoutOrder = order,
	}, parent)
	new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, f)
	return f
end

local function heading(parent, order, str)
	local r = rowFrame(parent, order, 20)
	label(r, string.upper(str), {
		Font = FONT, TextSize = TS.head, TextColor3 = T.dim, Size = UDim2.new(1, 0, 1, -3),
	})
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = T.divider, BorderSizePixel = 0,
	}, r)
	return r
end

local function collapsibleHeading(parent, order, str, group)
	local r = new("TextButton", {
		Text = "", Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, AutoButtonColor = false,
		BorderSizePixel = 0, LayoutOrder = order,
	}, parent)
	local lbl = label(r, string.upper(str), {
		Font = FONT, TextSize = TS.head, TextColor3 = T.dim, Size = UDim2.new(1, -20, 1, -3),
	})
	local arrow = icon(r, Icons.ArrowUp, IC.sm, {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, -1), ImageColor3 = T.dim,
	})
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = T.divider, BorderSizePixel = 0,
	}, r)
	bind(r.MouseEnter, function()
		tween(arrow, TI_FAST, { ImageColor3 = T.white })
		tween(lbl, TI_FAST, { TextColor3 = T.sub })
	end)
	bind(r.MouseLeave, function()
		tween(arrow, TI_FAST, { ImageColor3 = T.dim })
		tween(lbl, TI_FAST, { TextColor3 = T.dim })
	end)
	bind(r.MouseButton1Click, function()
		group.collapsed = not group.collapsed
		arrow.Image = group.collapsed and Icons.ArrowDown or Icons.ArrowUp
		refreshVisibility()
	end)
	return r, lbl
end

local function makeInput(parent, props)
	local f = new("Frame", {
		Size = props.size, Position = props.pos or UDim2.new(0, 0, 0, 0),
		AnchorPoint = props.anchor or Vector2.new(0, 0),
		BackgroundColor3 = T.surface, BorderSizePixel = 0,
	}, parent)
	corner(f, RAD.sm)
	local st = stroke(f)
	local left = props.inset or 0
	local box = new("TextBox", {
		Size = UDim2.new(1, -(8 + left), 1, 0), Position = UDim2.new(0, 4 + left, 0, 0),
		BackgroundTransparency = 1, Font = props.font or FONT_C, TextSize = props.textSize or TS.small,
		TextColor3 = T.text, PlaceholderColor3 = T.dim, ClearTextOnFocus = false,
		Text = props.text or "", TextXAlignment = props.align or Enum.TextXAlignment.Center,
		TextTruncate = Enum.TextTruncate.AtEnd,
	}, f)
	bind(box.Focused, function() tween(st, TI_FAST, { Color = T.strokeOn }) end)
	bind(box.FocusLost, function() tween(st, TI_FAST, { Color = T.stroke }) end)
	return f, box
end

local function makeButton(parent, str, onClick, opts)
	opts = opts or {}
	local primary = opts.primary
	local bg = primary and T.accent or T.surface
	local hv = primary and T.white or T.hover
	local fg = primary and T.black or T.text
	local b = new("TextButton", {
		Text = "", AutoButtonColor = false, BackgroundColor3 = bg, BorderSizePixel = 0,
		Size = opts.size or UDim2.new(1, 0, 0, 28),
	}, parent)
	corner(b, RAD.md)
	stroke(b, primary and T.accent or T.stroke)
	local holder = new("Frame", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 }, b)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6),
		HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, holder)
	local ico, lbl
	if hasIcon(opts.icon) then
		ico = icon(holder, opts.icon, IC.sm, { ImageColor3 = fg, LayoutOrder = 1 })
	end
	if str and str ~= "" then
		lbl = label(holder, str, {
			Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
			TextColor3 = fg, Font = FONT, TextSize = TS.body, LayoutOrder = 2,
			TextXAlignment = Enum.TextXAlignment.Center, TextTruncate = Enum.TextTruncate.None,
		})
	end
	bind(b.MouseEnter, function() tween(b, TI_FAST, { BackgroundColor3 = hv }) end)
	bind(b.MouseLeave, function() tween(b, TI_FAST, { BackgroundColor3 = bg }) end)
	pressFx(b, 0.95)
	bind(b.MouseButton1Click, function()
		b.BackgroundColor3 = primary and T.pressed or T.active
		tween(b, TI_POP, { BackgroundColor3 = hv })
		onClick(b)
	end)
	return b, lbl, ico
end

local function buttonRow(parent, order, defs)
	local r = rowFrame(parent, order, 28)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
	}, r)
	local n = #defs
	for i, d in ipairs(defs) do
		local b = makeButton(r, d.text, d.fn, {
			primary = d.primary, icon = d.icon, size = UDim2.new(1 / n, -6 * (n - 1) / n, 1, 0),
		})
		b.LayoutOrder = i
	end
	return r
end

local function makeConfirm(lbl, idleText)
	local armed, token = false, 0
	return function(action)
		if not armed then
			armed = true
			token += 1
			local my = token
			lbl.Text = "Confirm"
			task.delay(3, function()
				if token == my and armed then
					armed = false
					lbl.Text = idleText
				end
			end)
			return
		end
		armed = false
		token += 1
		lbl.Text = idleText
		action()
	end
end

local function makeSwitch(parent, getter, setter, compact)
	local swW, swH, kn = 32, 16, 10
	if compact then swW, swH, kn = 26, 14, 8 end
	local sw = new("TextButton", {
		Text = "", Size = UDim2.new(0, swW, 0, swH), BackgroundColor3 = T.surface,
		AutoButtonColor = false, BorderSizePixel = 0,
	}, parent)
	corner(sw, swH / 2)
	local st = stroke(sw)
	local knob = new("Frame", {
		Size = UDim2.new(0, kn, 0, kn), Position = UDim2.new(0, 3, 0.5, -kn / 2),
		BackgroundColor3 = T.dim, BorderSizePixel = 0,
	}, sw)
	corner(knob, kn / 2)
	pressFx(sw, 0.92)
	local function render(animate)
		local on = getter()
		apply(sw, { BackgroundColor3 = on and T.accent or T.surface }, animate)
		apply(st, { Color = on and T.accent or T.stroke }, animate)
		apply(knob, {
			Position = on and UDim2.new(1, -(kn + 3), 0.5, -kn / 2) or UDim2.new(0, 3, 0.5, -kn / 2),
			BackgroundColor3 = on and T.black or T.dim,
		}, animate)
	end
	bind(sw.MouseButton1Click, function()
		setter(not getter())
		render(true)
	end)
	render(false)
	return sw, render
end

local function makeToggleRow(parent, order, text_, key, onChange)
	local r = rowFrame(parent, order, ROW_H)
	label(r, text_, { Size = UDim2.new(1, -40, 1, 0) })
	local sw, render = makeSwitch(r, function() return State[key] end, function(v)
		State[key] = v
		if onChange then onChange(v) end
	end)
	sw.AnchorPoint = Vector2.new(1, 0.5)
	sw.Position = UDim2.new(1, 0, 0.5, 0)
	Renders[#Renders + 1] = function() render(false) end
	return r, render
end

do
	local hsw, hrender = makeSwitch(ctrl, function() return State.brushActive end, function(v)
		State.brushActive = v
		UI.onBrushToggle(v)
	end, true)
	hsw.LayoutOrder = 1
	Renders[#Renders + 1] = function() hrender(false) end

	local tip = new("TextLabel", {
		Text = "", BackgroundColor3 = T.surface, BorderSizePixel = 0, Font = FONT, TextSize = TS.tiny,
		TextColor3 = T.text, AutomaticSize = Enum.AutomaticSize.XY, Size = UDim2.new(0, 0, 0, 0),
		AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, TITLE_H + 4),
		Visible = false, ZIndex = 20,
	}, main)
	corner(tip, RAD.sm)
	stroke(tip)
	pad(tip, 6, 3, 6, 3)
	local function tipText()
		return State.brushActive and "Brush Active: On" or "Brush Active: Off"
	end
	bind(hsw.MouseEnter, function()
		tip.Text = tipText()
		tip.Visible = true
	end)
	bind(hsw.MouseLeave, function() tip.Visible = false end)
	bind(hsw.MouseButton1Click, function()
		task.defer(function() tip.Text = tipText() end)
	end)
end

local function makeSeg(parent, order, text_, options, getter, setter)
	local r = rowFrame(parent, order, ROW_H)
	label(r, text_, { Size = UDim2.new(0, LABEL_W, 1, 0) })
	local holder = new("Frame", {
		Size = UDim2.new(1, -LABEL_W, 0, CTL_H), Position = UDim2.new(0, LABEL_W, 0.5, -CTL_H / 2),
		BackgroundColor3 = T.surface, BorderSizePixel = 0,
	}, r)
	corner(holder, RAD.sm)
	stroke(holder)
	pad(holder, 2, 2, 2, 2)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder,
	}, holder)
	local btns = {}
	local n = #options
	local function render(animate)
		for _, b in ipairs(btns) do
			local on = getter() == b.id
			apply(b.btn, { BackgroundTransparency = on and 0 or 1, TextColor3 = on and T.white or T.dim }, animate)
		end
	end
	for i, o in ipairs(options) do
		local b = new("TextButton", {
			Text = o[2], Font = FONT, TextSize = TS.small, AutoButtonColor = false, BorderSizePixel = 0,
			Size = UDim2.new(1 / n, -2 * (n - 1) / n, 1, 0), LayoutOrder = i,
			BackgroundColor3 = T.active, BackgroundTransparency = 1, TextColor3 = T.dim,
		}, holder)
		corner(b, RAD.sm - 1)
		pressFx(b, 0.94)
		btns[i] = { id = o[1], btn = b }
		bind(b.MouseButton1Click, function()
			setter(o[1])
			render(true)
		end)
	end
	render(false)
	return r, render
end

local SliderDrag, SliderEnd = nil, nil
bind(UserInputService.InputChanged, function(input)
	if SliderDrag and isMove(input) then SliderDrag(input.Position.X) end
end)
bind(UserInputService.InputEnded, function(input)
	if isPointer(input) then
		if SliderEnd then SliderEnd() end
		SliderDrag, SliderEnd = nil, nil
	end
end)

local function makeSliderCore(parent, order, text_, min, max, step, get, set, labelW)
	labelW = labelW or LABEL_W
	local r = rowFrame(parent, order, ROW_H)
	label(r, text_, { Size = UDim2.new(0, labelW, 1, 0) })

	local track = new("Frame", {
		Size = UDim2.new(1, -(labelW + 8 + 52), 0, 4), Position = UDim2.new(0, labelW + 8, 0.5, -2),
		BackgroundColor3 = T.track, BorderSizePixel = 0,
	}, r)
	corner(track, 2)
	local fill = new("Frame", { Size = UDim2.new(0, 0, 1, 0), BackgroundColor3 = T.accent, BorderSizePixel = 0 }, track)
	corner(fill, 2)
	local thumb = new("Frame", {
		Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(0, -6, 0.5, -6),
		BackgroundColor3 = T.white, BorderSizePixel = 0, ZIndex = 2,
	}, track)
	corner(thumb, 6)
	local thumbScale = new("UIScale", { Scale = 1 }, thumb)
	local hit = new("TextButton", {
		Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 12, 0, CTL_H),
		Position = UDim2.new(0, -6, 0.5, -CTL_H / 2), AutoButtonColor = false, ZIndex = 3,
	}, track)

	local _, box = makeInput(r, {
		size = UDim2.new(0, 40, 0, CTL_H), pos = UDim2.new(1, 0, 0.5, 0), anchor = Vector2.new(1, 0.5),
	})

	local function render()
		local v = get()
		local pct = clamp((v - min) / (max - min), 0, 1)
		fill.Size = UDim2.new(pct, 0, 1, 0)
		thumb.Position = UDim2.new(pct, -6, 0.5, -6)
		box.Text = string.format("%g", v)
	end
	local function applyValue(v)
		v = clamp(math.floor(v / step + 0.5) * step, min, max)
		v = math.floor(v * 1000 + 0.5) / 1000
		set(v)
		render()
		if UI.onSlider then UI.onSlider() end
	end
	local function fromX(px)
		local w = math.max(track.AbsoluteSize.X, 1)
		applyValue(min + clamp((px - track.AbsolutePosition.X) / w, 0, 1) * (max - min))
	end
	bind(hit.InputBegan, function(input)
		if isPointer(input) then
			SliderDrag = fromX
			SliderEnd = function() tween(thumbScale, TI_POP, { Scale = 1 }) end
			tween(thumbScale, TI_FAST, { Scale = 1.25 })
			fromX(input.Position.X)
		end
	end)
	bind(box.FocusLost, function()
		applyValue(tonumber(box.Text) or get())
	end)
	render()
	return r, render
end

local function makeSlider(parent, order, text_, key, min, max, step)
	local r, render = makeSliderCore(parent, order, text_, min, max, step,
		function() return State[key] end,
		function(v) State[key] = v end)
	Renders[#Renders + 1] = render
	return r, render
end

local function makeVec3Row(parent, order, text_, get, set, subscribe)
	local r = rowFrame(parent, order, ROW_H)
	label(r, text_, { Size = UDim2.new(0, LABEL_W, 1, 0) })
	local holder = new("Frame", {
		Size = UDim2.new(1, -LABEL_W, 0, CTL_H), Position = UDim2.new(0, LABEL_W, 0.5, -CTL_H / 2),
		BackgroundTransparency = 1,
	}, r)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	}, holder)
	local boxes = {}
	local function refresh()
		local v = get()
		boxes[1].Text = string.format("%g", round1(v.X))
		boxes[2].Text = string.format("%g", round1(v.Y))
		boxes[3].Text = string.format("%g", round1(v.Z))
	end
	for i, ax in ipairs({ "X", "Y", "Z" }) do
		local f, box = makeInput(holder, {
			size = UDim2.new(1 / 3, -3, 1, 0), inset = 12, text = "0", align = Enum.TextXAlignment.Left,
		})
		f.LayoutOrder = i
		label(f, ax, {
			Size = UDim2.new(0, 12, 1, 0), Position = UDim2.new(0, 4, 0, 0),
			TextColor3 = T.dim, Font = FONT, TextSize = TS.tiny,
		})
		boxes[i] = box
		bind(box.FocusLost, function()
			local n = tonumber(box.Text)
			if n then
				local v = get()
				set(Vector3.new(i == 1 and n or v.X, i == 2 and n or v.Y, i == 3 and n or v.Z))
			end
			refresh()
		end)
	end
	if subscribe then subscribe(refresh) end
	refresh()
	return r
end

local function regionPosGet() return State.regionMin + State.regionSize / 2 end
local function regionPosSet(v)
	E.setRegion(v - State.regionSize / 2, State.regionSize)
	E.commitIdle()
end
local function regionSizeGet() return State.regionSize end
local function regionSizeSet(v)
	local center = State.regionMin + State.regionSize / 2
	local s = Vector3.new(math.max(VS, math.abs(v.X)), math.max(VS, math.abs(v.Y)), math.max(VS, math.abs(v.Z)))
	E.setRegion(center - s / 2, s)
	E.commitIdle()
end

local function makeRegionRows(page, n, tab, tools)
	reg(tab, makeVec3Row(page, n(), "Position", regionPosGet, regionPosSet, E.onRegionChanged), tools)
	reg(tab, makeVec3Row(page, n(), "Size", regionSizeGet, regionSizeSet, E.onRegionChanged), tools)
end

local function makeTiles(page, order, tab, defs, onAction)
	local grid = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, LayoutOrder = order,
	}, page)
	new("UIGridLayout", {
		CellSize = UDim2.new(0, 59, 0, 54), CellPadding = UDim2.new(0, 4, 0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, grid)
	local set = {}
	for i, d in ipairs(defs) do
		local b = new("TextButton", {
			Text = "", AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = i,
			BackgroundColor3 = T.surface,
		}, grid)
		corner(b, RAD.md)
		local st = stroke(b)
		local ico = icon(b, d.icon, IC.lg, {
			Position = UDim2.new(0.5, -IC.lg / 2, 0, 6), ImageColor3 = T.dim,
		})
		local lbl = label(b, d.label or d.id, {
			Size = UDim2.new(1, -4, 0, 14), Position = UDim2.new(0, 2, 0, 33),
			TextXAlignment = Enum.TextXAlignment.Center, TextSize = TS.tiny, TextColor3 = T.dim,
		})
		if d.badge then
			label(b, d.badge, {
				Size = UDim2.new(0, 12, 0, 12), Position = UDim2.new(0.5, 8, 0, 3),
				TextColor3 = T.white, Font = FONT, TextSize = TS.title,
				TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 3,
			})
		elseif d.badgeIcon then
			icon(b, d.badgeIcon, IC.badge, { Position = UDim2.new(0.5, 9, 0, 4), ImageColor3 = T.white, ZIndex = 3 })
		end
		local selected = false
		set[d.id] = {
			btn = b,
			set = function(on, animate)
				selected = on
				apply(b, { BackgroundColor3 = on and T.active or T.surface }, animate)
				apply(st, { Color = on and T.strokeOn or T.stroke }, animate)
				apply(ico, { ImageColor3 = on and T.white or T.dim }, animate)
				apply(lbl, { TextColor3 = on and T.white or T.dim }, animate)
			end,
		}
		pressFx(b, 0.93)
		bind(b.MouseEnter, function()
			if not selected then tween(b, TI_FAST, { BackgroundColor3 = T.hover }) end
		end)
		bind(b.MouseLeave, function()
			if not selected then tween(b, TI_FAST, { BackgroundColor3 = T.surface }) end
		end)
		bind(b.MouseButton1Click, function()
			if d.action then
				b.BackgroundColor3 = T.active
				tween(b, TI_SLOW, { BackgroundColor3 = T.surface })
				onAction(d.id)
			else
				State.tools[tab] = d.id
				refreshSettings()
			end
		end)
	end
	TileSets[tab] = set
	return grid
end

local MatItems = {}

local function labelColorFor(col)
	local lum = col.R * 0.299 + col.G * 0.587 + col.B * 0.114
	return lum < 0.5 and Color3.fromRGB(240, 240, 240) or Color3.fromRGB(25, 25, 25)
end

local function refreshSwatch(mat)
	local col = E.getMaterialColor(mat)
	for _, it in ipairs(MatItems) do
		if it.mat == mat then
			it.btn.BackgroundColor3 = col
			if it.lbl then it.lbl.TextColor3 = labelColorFor(col) end
		end
	end
end

local function makeMaterialGrid(parent, order, key, onChange)
	local holder = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = T.surface, BorderSizePixel = 0, LayoutOrder = order,
	}, parent)
	corner(holder, RAD.md)
	stroke(holder)
	pad(holder, 8, 8, 8, 8)
	new("UIGridLayout", {
		CellSize = UDim2.new(0, 35, 0, 35), CellPadding = UDim2.new(0, 4, 0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center,
	}, holder)
	local items, enabled = {}, true
	local function render()
		for _, it in ipairs(items) do
			local on = (State[key] == it.mat)
			it.stroke.Thickness = on and 2 or 0.5
			it.stroke.Color = on and T.white or T.stroke
			it.btn.BackgroundTransparency = enabled and 0 or 0.6
		end
	end
	for i, m in ipairs(MATERIALS) do
		local col = E.getMaterialColor(m.mat)
		local b = new("TextButton", {
			Text = "", AutoButtonColor = false, BackgroundColor3 = col, BorderSizePixel = 0, LayoutOrder = i,
		}, holder)
		corner(b, RAD.sm)
		local st = stroke(b)
		local lbl = nil
		local iconId = Icons.Material[m.name]
		if hasIcon(iconId) then
			new("ImageLabel", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = iconId }, b)
		else
			lbl = label(b, MATERIAL_ABBR[m.name] or m.name, {
				TextXAlignment = Enum.TextXAlignment.Center, TextSize = TS.tiny, Font = FONT,
				TextColor3 = labelColorFor(col), TextTruncate = Enum.TextTruncate.None,
			})
		end
		pressFx(b, 0.9)
		items[i] = { mat = m.mat, btn = b, stroke = st }
		MatItems[#MatItems + 1] = { mat = m.mat, btn = b, lbl = lbl }
		bind(b.MouseButton1Click, function()
			if not enabled then return end
			State[key] = m.mat
			render()
			if onChange then onChange(m.mat) end
		end)
	end
	render()
	return holder, {
		Render = render,
		SetEnabled = function(v) enabled = v render() end,
	}
end

local function buildColorSection(parent, order)
	local wrap = autoFrame(parent, order)
	local Draft = { R = 255, G = 255, B = 255 }
	local refreshers = {}

	local head = rowFrame(wrap, 1, ROW_H)
	label(head, "Custom Color", { Size = UDim2.new(1, -80, 1, 0) })
	local right = new("Frame", {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, BackgroundTransparency = 1,
	}, head)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
	}, right)

	local preview = new("Frame", {
		Size = UDim2.new(0, 24, 0, 16), BackgroundColor3 = Color3.new(1, 1, 1),
		BorderSizePixel = 0, LayoutOrder = 1,
	}, right)
	corner(preview, RAD.sm)
	stroke(preview)

	local function draftColor()
		return Color3.fromRGB(Draft.R, Draft.G, Draft.B)
	end

	local sw, swRender = makeSwitch(right, function()
		return E.hasCustomColor(State.material)
	end, function(v)
		if v then
			E.setMaterialColor(State.material, draftColor())
		else
			E.resetMaterialColor(State.material)
		end
		refreshSwatch(State.material)
		if UI.loadColor then UI.loadColor() end
	end)
	sw.LayoutOrder = 2

	for i, ch in ipairs({ "R", "G", "B" }) do
		local _, rr = makeSliderCore(wrap, 1 + i, ch, 0, 255, 1,
			function() return Draft[ch] end,
			function(v)
				Draft[ch] = v
				E.setMaterialColor(State.material, draftColor())
				refreshSwatch(State.material)
				preview.BackgroundColor3 = draftColor()
				swRender(true)
			end, 14)
		refreshers[i] = rr
	end

	function UI.loadColor()
		local c = E.getMaterialColor(State.material)
		Draft.R = math.floor(c.R * 255 + 0.5)
		Draft.G = math.floor(c.G * 255 + 0.5)
		Draft.B = math.floor(c.B * 255 + 0.5)
		preview.BackgroundColor3 = c
		for _, f in ipairs(refreshers) do f() end
		swRender(false)
	end
	UI.loadColor()
	return wrap
end

local Code = { pages = {}, idx = 1, full = "" }
local CARD_W, CARD_H, CARD_HEAD = 400, 340, 26
local PAGE_CHARS = 8000
local SAVE_DIR = "Terrain"
local DEFAULT_NAME = "Saved_Terrain"

local function clipboardFn()
	return executorEnv.setclipboard or executorEnv.toclipboard
		or (type(executorEnv.Clipboard) == "table" and executorEnv.Clipboard.set) or nil
end

local function paginate(blocks)
	local pages, cur, len = {}, {}, 0
	for _, b in ipairs(blocks) do
		if len + #b + 2 > PAGE_CHARS and #cur > 0 then
			pages[#pages + 1] = table.concat(cur, "\n\n")
			cur, len = {}, 0
		end
		cur[#cur + 1] = b
		len += #b + 2
	end
	if #cur > 0 then pages[#pages + 1] = table.concat(cur, "\n\n") end
	local total = #pages
	for i, text in ipairs(pages) do
		local tag
		if i == 1 then
			tag = ("-- [Page 1/%d] Paste into a Script in ServerScriptService, then add the next pages below it in order."):format(total)
		else
			tag = ("-- [Page %d/%d] Paste directly below page %d. Do not run it on its own."):format(i, total, i - 1)
		end
		pages[i] = tag .. "\n" .. text
	end
	return pages
end

local function sanitizeName(raw)
	local s = tostring(raw or "")
	s = s:gsub("%.lua$", "")
	s = s:gsub("[^%w_%-%. ]", "")
	s = s:gsub("^%s+", ""):gsub("%s+$", "")
	s = s:gsub("%s+", "_")
	if s == "" then return DEFAULT_NAME end
	return s
end

local function saveScript(name, text)
	local write = executorEnv.writefile
	if type(write) ~= "function" then
		return false, "writefile not supported"
	end
	local exists = false
	if type(executorEnv.isfolder) == "function" then
		local okDir, res = pcall(executorEnv.isfolder, SAVE_DIR)
		exists = okDir and res == true
	end
	if not exists and type(executorEnv.makefolder) == "function" then
		pcall(executorEnv.makefolder, SAVE_DIR)
	end
	local path = SAVE_DIR .. "/" .. name .. ".lua"
	local ok, err = pcall(write, path, text)
	if ok then return true, path end
	return false, tostring(err)
end

local function buildCodeCard()
	local hasClip = clipboardFn() ~= nil

	local card = new("Frame", {
		Name = "CodeCard", Size = UDim2.new(0, CARD_W, 0, CARD_H),
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		BackgroundColor3 = T.bg, BorderSizePixel = 0, Visible = false, Active = true, ZIndex = 10,
		ClipsDescendants = true,
	}, sg)
	local cardScale = new("UIScale", { Scale = 1 }, card)

	local head = new("Frame", {
		Size = UDim2.new(1, 0, 0, CARD_HEAD), BackgroundColor3 = T.header, BorderSizePixel = 0,
	}, card)
	icon(head, Icons.Code, IC.sm, { Position = UDim2.new(0, 8, 0.5, -IC.sm / 2), ImageColor3 = T.white })
	label(head, "Generate Code", {
		Font = FONT, TextSize = TS.title, TextColor3 = T.white,
		Size = UDim2.new(1, -64, 1, 0), Position = UDim2.new(0, 30, 0, 0),
	})
	local closeC = iconButton(head, Icons.Close, 1)
	closeC.AnchorPoint = Vector2.new(1, 0.5)
	closeC.Position = UDim2.new(1, -4, 0.5, 0)
	makeDraggable(head, card)

	local inner = new("Frame", {
		Size = UDim2.new(1, -16, 1, -(CARD_HEAD + 16)), Position = UDim2.new(0, 8, 0, CARD_HEAD + 8),
		BackgroundTransparency = 1,
	}, card)

	local box, scroller, pageLbl, statusLbl, copyLbl, saveLbl, nameBox

	local function fit()
		local h = math.max(box.TextBounds.Y + 4, scroller.AbsoluteSize.Y - 12)
		box.Size = UDim2.new(1, -16, 0, h)
		scroller.CanvasSize = UDim2.new(0, 0, 0, h + 12)
	end

	local function show()
		local total = #Code.pages
		pageLbl.Text = (total > 0) and (Code.idx .. " / " .. total) or "0 / 0"
		box.Text = Code.pages[Code.idx] or ""
		scroller.CanvasPosition = Vector2.new(0, 0)
		fit()
	end

	local function build(keep)
		local blocks, count = E.generateCode()
		if not blocks then
			Code.pages, Code.idx, Code.full = {}, 1, ""
			statusLbl.Text = "Nothing recorded yet"
			show()
			return
		end
		Code.pages = paginate(blocks)
		Code.full = table.concat(Code.pages, "\n\n")
		Code.idx = keep and clamp(Code.idx, 1, #Code.pages) or 1
		statusLbl.Text = ("%d ops | %d part%s | %.1fk"):format(count, #Code.pages, #Code.pages == 1 and "" or "s", #Code.full / 1000)
		show()
	end

	local refreshPending = false
	function E.onScriptChanged()
		if refreshPending or not card.Visible then return end
		refreshPending = true
		task.delay(0.35, function()
			refreshPending = false
			if Alive and card.Visible then build(true) end
		end)
	end

	function UI.codeReset()
		Code.pages, Code.idx, Code.full = {}, 1, ""
		if statusLbl then statusLbl.Text = "Cleared" end
		show()
	end

	local row = rowFrame(inner, 0, 28)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
	}, row)
	local w = UDim2.new(1 / 4, -5, 1, 0)

	local genB = makeButton(row, "Generate", function() build(false) end, { primary = true, icon = Icons.Code, size = w })
	genB.LayoutOrder = 1

	local copyB
	copyB, copyLbl = makeButton(row, "Copy", function()
		if #Code.pages == 0 then return end
		local fn = clipboardFn()
		if fn then
			local ok = pcall(fn, Code.full)
			copyLbl.Text = ok and "Copied" or "Failed"
			task.delay(1.2, function() if copyLbl.Parent then copyLbl.Text = "Copy" end end)
		else
			box:CaptureFocus()
			task.defer(function()
				box.SelectionStart = 1
				box.CursorPosition = #box.Text + 1
			end)
		end
	end, { icon = Icons.Copy, size = w })
	copyB.LayoutOrder = 2

	local saveB
	saveB, saveLbl = makeButton(row, "Save", function()
		if Code.full == "" then
			statusLbl.Text = "Nothing to save"
			return
		end
		local name = sanitizeName(nameBox.Text)
		nameBox.Text = name
		local ok, res = saveScript(name, Code.full)
		if ok then
			statusLbl.Text = "Saved: " .. res
			saveLbl.Text = "Saved"
			task.delay(1.2, function() if saveLbl.Parent then saveLbl.Text = "Save" end end)
		else
			statusLbl.Text = "Save failed: " .. res
		end
	end, { icon = Icons.Save, size = w })
	saveB.LayoutOrder = 3

	local clrB = makeButton(row, "Clear", function() UI.codeReset() end, { icon = Icons.CodeClear, size = w })
	clrB.LayoutOrder = 4

	local optRow = rowFrame(inner, 0, ROW_H)
	optRow.Position = UDim2.new(0, 0, 0, 34)
	label(optRow, "Name", { Size = UDim2.new(0, 36, 1, 0) })
	local _
	_, nameBox = makeInput(optRow, {
		size = UDim2.new(1, -(36 + 8 + 108), 0, CTL_H), pos = UDim2.new(0, 36, 0.5, -CTL_H / 2),
		text = DEFAULT_NAME, align = Enum.TextXAlignment.Left,
	})
	bind(nameBox.FocusLost, function()
		nameBox.Text = sanitizeName(nameBox.Text)
	end)
	label(optRow, "Clear First", { Size = UDim2.new(0, 70, 1, 0), Position = UDim2.new(1, -108, 0, 0) })
	local cfSwitch, cfRender = makeSwitch(optRow, function() return State.exportClearFirst end, function(v)
		State.exportClearFirst = v
	end)
	cfSwitch.AnchorPoint = Vector2.new(1, 0.5)
	cfSwitch.Position = UDim2.new(1, 0, 0.5, 0)
	Renders[#Renders + 1] = function() cfRender(false) end

	local codeWrap = new("Frame", {
		Size = UDim2.new(1, 0, 1, -(66 + 30)), Position = UDim2.new(0, 0, 0, 66),
		BackgroundColor3 = T.surface, BorderSizePixel = 0,
	}, inner)
	corner(codeWrap, RAD.md)
	stroke(codeWrap)

	scroller = new("ScrollingFrame", {
		Size = UDim2.new(1, -4, 1, -8), Position = UDim2.new(0, 0, 0, 4),
		BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
		ScrollBarImageColor3 = T.stroke, ScrollingDirection = Enum.ScrollingDirection.Y,
		CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.None,
		VerticalScrollBarInset = Enum.ScrollBarInset.None,
	}, codeWrap)

	box = new("TextBox", {
		Size = UDim2.new(1, -16, 0, 100), Position = UDim2.new(0, 8, 0, 0),
		BackgroundTransparency = 1, Font = FONT_C, TextSize = TS.small, TextColor3 = T.text,
		PlaceholderText = "Press Generate to build the script", PlaceholderColor3 = T.dim,
		MultiLine = true, TextWrapped = true, ClearTextOnFocus = false, TextEditable = true,
		RichText = false, TextTruncate = Enum.TextTruncate.None,
		TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Text = "",
	}, scroller)
	bind(box:GetPropertyChangedSignal("TextBounds"), fit)
	bind(scroller:GetPropertyChangedSignal("AbsoluteSize"), fit)

	local foot = rowFrame(inner, 0, 24)
	foot.Position = UDim2.new(0, 0, 1, -24)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4),
		VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder,
	}, foot)
	local prev = makeButton(foot, "<", function()
		if Code.idx > 1 then Code.idx -= 1 show() end
	end, { size = UDim2.new(0, 26, 0, 22) })
	prev.LayoutOrder = 1
	pageLbl = label(foot, "0 / 0", {
		Size = UDim2.new(0, 44, 1, 0), TextXAlignment = Enum.TextXAlignment.Center,
		Font = FONT_C, TextSize = TS.small, LayoutOrder = 2,
	})
	local nxt = makeButton(foot, ">", function()
		if Code.idx < #Code.pages then Code.idx += 1 show() end
	end, { size = UDim2.new(0, 26, 0, 22) })
	nxt.LayoutOrder = 3
	local pageCopyLbl
	local _pc
	_pc, pageCopyLbl = makeButton(foot, "Copy Part", function()
		local text = Code.pages[Code.idx]
		if not text then return end
		local fn = clipboardFn()
		if fn then
			local ok = pcall(fn, text)
			pageCopyLbl.Text = ok and "Copied" or "Failed"
			task.delay(1.2, function() if pageCopyLbl.Parent then pageCopyLbl.Text = "Copy Part" end end)
		else
			box:CaptureFocus()
			task.defer(function()
				box.SelectionStart = 1
				box.CursorPosition = #box.Text + 1
			end)
		end
	end, { size = UDim2.new(0, 74, 0, 22) })
	_pc.LayoutOrder = 4
	statusLbl = label(foot, hasClip and "Copy = whole script" or "No clipboard: copy part by part", {
		Size = UDim2.new(1, -190, 1, 0), TextXAlignment = Enum.TextXAlignment.Right,
		TextSize = TS.tiny, TextColor3 = T.dim, LayoutOrder = 5,
	})

	function UI.openCard()
		card.Visible = true
		cardScale.Scale = 0.9
		tween(cardScale, TI_POP, { Scale = 1 })
		build(false)
	end
	bind(closeC.MouseButton1Click, function() card.Visible = false end)
	GUI.Card = card
end

buildCodeCard()

local function historyRow(page, n, tab)
	reg(tab, buttonRow(page, n(), {
		{ text = "Undo", fn = function() E.undo() end, icon = Icons.Undo },
		{ text = "Redo", fn = function() E.redo() end, icon = Icons.Redo },
	}), nil)
end

local function section(tab, page, n, title, tools, cond)
	local group = { collapsed = false }
	Groups[tab] = group
	local head = collapsibleHeading(page, n(), title, group)
	reg(tab, head, tools, cond, true)
end

local function buildCreatePage()
	local page = Pages.Create
	local o = 0
	local function n() o += 1 return o end

	historyRow(page, n, "Create")
	reg("Create", (makeToggleRow(page, n(), "Brush Active", "brushActive", UI.onBrushToggle)), nil)

	makeTiles(page, n(), "Create", {
		{ id = "Generate", label = "Generate", icon = Icons.Generate },
		{ id = "Clear", label = "Clear", icon = Icons.Clear },
	}, function() end)

	local GEN = { "Generate" }

	section("Create", page, n, "Region", GEN)
	makeRegionRows(page, n, "Create", GEN)
	reg("Create", (makeToggleRow(page, n(), "Snap to Voxels", "regionSnap")), GEN)

	section("Create", page, n, "Terrain", GEN)
	local seedRow = rowFrame(page, n(), ROW_H)
	label(seedRow, "Seed", { Size = UDim2.new(0, LABEL_W, 1, 0) })
	local _, seedBox = makeInput(seedRow, {
		size = UDim2.new(1, -(LABEL_W + 52), 0, CTL_H), pos = UDim2.new(0, LABEL_W, 0.5, -CTL_H / 2),
		text = tostring(State.seed), align = Enum.TextXAlignment.Left,
	})
	bind(seedBox.FocusLost, function()
		local nn = tonumber(seedBox.Text)
		if not nn then
			nn = 0
			for ci = 1, #seedBox.Text do nn = (nn * 31 + seedBox.Text:byte(ci)) % 100000 end
		end
		State.seed = nn
		seedBox.Text = tostring(nn)
	end)
	local rnd = makeButton(seedRow, "Rand", function()
		State.seed = math.random(1, 99999)
		seedBox.Text = tostring(State.seed)
	end, { size = UDim2.new(0, 44, 0, CTL_H) })
	rnd.AnchorPoint = Vector2.new(1, 0.5)
	rnd.Position = UDim2.new(1, 0, 0.5, 0)
	reg("Create", seedRow, GEN)

	reg("Create", (makeSlider(page, n(), "Biome Size", "biomeSize", 1, 10, 0.5)), GEN)
	reg("Create", (makeSlider(page, n(), "Blending", "blending", 0, 1, 0.05)), GEN)
	reg("Create", (makeToggleRow(page, n(), "Caves", "caves")), GEN)

	section("Create", page, n, "Biomes", GEN)
	local biomeGrid = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1, LayoutOrder = n(),
	}, page)
	new("UIGridLayout", {
		CellSize = UDim2.new(1 / 3, -3, 0, 24), CellPadding = UDim2.new(0, 4, 0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, biomeGrid)
	for i, name in ipairs(E.BIOME_ORDER) do
		local chip = new("TextButton", {
			Text = name, Font = FONT, TextSize = TS.small, AutoButtonColor = false, BorderSizePixel = 0,
			LayoutOrder = i, BackgroundColor3 = T.surface, TextColor3 = T.dim,
		}, biomeGrid)
		corner(chip, RAD.sm)
		local st = stroke(chip)
		pressFx(chip, 0.94)
		local function render(animate)
			local on = State.biomes[name]
			apply(chip, { BackgroundColor3 = on and T.active or T.surface, TextColor3 = on and T.white or T.dim }, animate)
			apply(st, { Color = on and T.strokeOn or T.stroke }, animate)
		end
		bind(chip.MouseButton1Click, function()
			State.biomes[name] = not State.biomes[name]
			render(true)
		end)
		render(false)
	end
	reg("Create", biomeGrid, GEN)
	Groups.Create = nil

	local gen = makeButton(page, "Generate", function() E.opGenerate() end, { primary = true, icon = Icons.Generate })
	gen.LayoutOrder = n()
	reg("Create", gen, GEN)

	local clr, clrLbl = makeButton(page, "Clear", function() end, { primary = true, icon = Icons.Clear })
	clr.LayoutOrder = n()
	local confirm = makeConfirm(clrLbl, "Clear")
	bind(clr.MouseButton1Click, function()
		confirm(function()
			if E.clearAll() then
				UI.codeReset()
				for _, r in ipairs(Renders) do r() end
			end
		end)
	end)
	reg("Create", clr, { "Clear" })

	section("Create", page, n, "Export")
	reg("Create", buttonRow(page, n(), {
		{ text = "Open Code Generator", fn = function() UI.openCard() end, icon = Icons.Code },
	}), nil)
end

local function buildRegionPage()
	local page = Pages.Region
	local o = 0
	local function n() o += 1 return o end

	historyRow(page, n, "Region")
	reg("Region", (makeToggleRow(page, n(), "Brush Active", "brushActive", UI.onBrushToggle)), nil)

	makeTiles(page, n(), "Region", {
		{ id = "Select", label = "Select", icon = Icons.Select },
		{ id = "Move", label = "Move", icon = Icons.Move },
		{ id = "Resize", label = "Resize", icon = Icons.Scale },
		{ id = "Rotate", label = "Rotate", icon = Icons.Rotate },
		{ id = "Delete", label = "Delete", icon = Icons.Clear, action = true },
		{ id = "Fill", label = "Fill", icon = Icons.Fill },
	}, function(id)
		if id == "Delete" then E.opDelete() end
	end)

	section("Region", page, n, "Selection")
	makeRegionRows(page, n, "Region", nil)
	reg("Region", (makeToggleRow(page, n(), "Snap to Voxels", "regionSnap")), nil)
	reg("Region", (makeToggleRow(page, n(), "Merge Empty", "mergeEmpty")), { "Move", "Resize", "Rotate" })

	section("Region", page, n, "Move", { "Move" })
	reg("Region", buttonRow(page, n(), {
		{ text = "Apply", fn = function() E.opApplyMove() end, primary = true, icon = Icons.Move },
		{ text = "Reset", fn = function() E.opResetTransform() end },
	}), { "Move" })

	section("Region", page, n, "Resize", { "Resize" })
	reg("Region", buttonRow(page, n(), {
		{ text = "Apply", fn = function() E.opApplyResize() end, primary = true, icon = Icons.Scale },
		{ text = "Reset", fn = function() E.opResetTransform() end },
	}), { "Resize" })

	section("Region", page, n, "Rotate", { "Rotate" })
	reg("Region", (makeSeg(page, n(), "Rotate Axis", { { "X", "X" }, { "Y", "Y" }, { "Z", "Z" } },
		function() return State.rotateAxis end, function(v) State.rotateAxis = v end)), { "Rotate" })
	reg("Region", buttonRow(page, n(), {
		{ text = "-90", fn = function() E.opRotate(State.rotateAxis, -1, 1) end, icon = Icons.Rotate },
		{ text = "+90", fn = function() E.opRotate(State.rotateAxis, 1, 1) end, primary = true, icon = Icons.Rotate },
	}), { "Rotate" })

	section("Region", page, n, "Fill", { "Fill" })
	reg("Region", (makeSeg(page, n(), "Mode", { { "Fill", "Fill" }, { "Replace", "Replace" } },
		function() return State.fillMode end, function(v) State.fillMode = v refreshSettings() end)), { "Fill" })
	local isReplace = function() return State.fillMode == "Replace" end
	section("Region", page, n, "Material to replace", { "Fill" }, isReplace)
	local srcGrid = makeMaterialGrid(page, n(), "fillSource")
	reg("Region", srcGrid, { "Fill" }, isReplace)
	local fillGroup = { collapsed = false }
	Groups.Region = fillGroup
	local fillHead, fillHeadLbl = collapsibleHeading(page, n(), "", fillGroup)
	reg("Region", fillHead, { "Fill" }, nil, true)
	table.insert(Hooks, function()
		fillHeadLbl.Text = string.upper((State.fillMode == "Replace") and "Replace with" or "Fill material")
	end)
	reg("Region", (makeMaterialGrid(page, n(), "fillMaterial")), { "Fill" })
	Groups.Region = nil
	local apply_ = makeButton(page, "Apply", function() E.opFill() end, { primary = true, icon = Icons.Fill })
	apply_.LayoutOrder = n()
	reg("Region", apply_, { "Fill" })
end

local function buildEditPage()
	local page = Pages.Edit
	local o = 0
	local function n() o += 1 return o end
	local BT = { "Add", "Subtract", "Grow", "Erode", "Smooth", "Flatten", "Paint", "Replace" }

	historyRow(page, n, "Edit")

	makeTiles(page, n(), "Edit", {
		{ id = "Add", label = "Add", icon = Icons.Draw, badge = "+" },
		{ id = "Subtract", label = "Subtract", icon = Icons.Draw, badge = "-" },
		{ id = "Grow", label = "Grow", icon = Icons.Sculpt, badgeIcon = Icons.ArrowUp },
		{ id = "Erode", label = "Erode", icon = Icons.Sculpt, badgeIcon = Icons.ArrowDown },
		{ id = "Smooth", label = "Smooth", icon = Icons.Smooth },
		{ id = "Flatten", label = "Flatten", icon = Icons.Flatten },
		{ id = "Paint", label = "Paint", icon = Icons.Paint },
		{ id = "SeaLevel", label = "Sea Level", icon = Icons.SeaLevel },
		{ id = "Replace", label = "Replace", icon = Icons.Fill },
	}, function() end)

	section("Edit", page, n, "Brush", BT)
	reg("Edit", (makeToggleRow(page, n(), "Brush Active", "brushActive", UI.onBrushToggle)), BT)

	local shapeRow = rowFrame(page, n(), 40)
	local shapeBox = new("Frame", {
		Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = T.surface, BorderSizePixel = 0,
	}, shapeRow)
	corner(shapeBox, RAD.md)
	stroke(shapeBox)
	pad(shapeBox, 3, 3, 3, 3)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder,
	}, shapeBox)
	local shapeBtns = {}
	local function renderShape(animate)
		for _, b in ipairs(shapeBtns) do
			local on = (State.shape == b.id)
			apply(b.btn, { BackgroundTransparency = on and 0 or 1 }, animate)
			apply(b.ico, { ImageColor3 = on and T.white or T.dim }, animate)
		end
	end
	local shapeIcons = { Ball = Icons.Ball, Block = Icons.Block, Cylinder = Icons.Cylinder }
	for i, kind in ipairs({ "Ball", "Block", "Cylinder" }) do
		local b = new("TextButton", {
			Text = "", AutoButtonColor = false, BorderSizePixel = 0, LayoutOrder = i,
			Size = UDim2.new(1 / 3, -2, 1, 0), BackgroundColor3 = T.active, BackgroundTransparency = 1,
		}, shapeBox)
		corner(b, RAD.sm)
		local ico = icon(b, shapeIcons[kind], IC.lg, {
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ImageColor3 = T.dim,
		})
		pressFx(b, 0.92)
		shapeBtns[i] = { id = kind, btn = b, ico = ico }
		bind(b.MouseButton1Click, function()
			State.shape = kind
			renderShape(true)
			refreshSettings()
		end)
	end
	renderShape(false)
	reg("Edit", shapeRow, BT)

	reg("Edit", (makeSlider(page, n(), "Base Size", "baseSize", 1, 64, 1)), BT)
	reg("Edit", (makeSlider(page, n(), "Height", "height", 1, 64, 1)), BT, function() return State.shape ~= "Ball" end)
	reg("Edit", (makeSlider(page, n(), "Strength", "strength", 0.1, 1, 0.05)), { "Grow", "Erode", "Smooth", "Flatten" })
	local sizeRow = rowFrame(page, n(), 18)
	local sizeLbl = label(sizeRow, "", {
		Size = UDim2.new(1, 0, 1, 0), TextSize = TS.tiny, TextColor3 = T.dim, TextWrapped = true,
	})
	local function renderBrushInfo()
		local sh, d, h = State.shape, State.baseSize, State.height
		if sh == "Ball" then
			sizeLbl.Text = ("Ball: diameter %g studs"):format(d)
		elseif sh == "Block" then
			sizeLbl.Text = ("Block: %g x %g x %g studs (W x H x D)"):format(d, h, d)
		else
			sizeLbl.Text = ("Cylinder: diameter %g, height %g studs"):format(d, h)
		end
	end
	UI.onSlider = renderBrushInfo
	table.insert(Hooks, renderBrushInfo)
	renderBrushInfo()
	reg("Edit", sizeRow, BT)
	reg("Edit", (makeSeg(page, n(), "Flatten Mode", { { "Erode", "Erode" }, { "Both", "All" }, { "Grow", "Grow" } },
		function() return State.flattenMode end, function(v) State.flattenMode = v end)), { "Flatten" })

	section("Edit", page, n, "Placement", BT)
	reg("Edit", (makeSeg(page, n(), "Pivot", { { "Bot", "Bot" }, { "Cen", "Cen" }, { "Top", "Top" } },
		function() return State.pivot end, function(v) State.pivot = v end)), BT)
	reg("Edit", (makeSeg(page, n(), "Plane Lock", { { "Off", "Off" }, { "Auto", "Auto" }, { "Manual", "Manual" } },
		function() return State.planeLock end, function(v) State.planeLock = v refreshSettings() end)), BT)
	reg("Edit", makeVec3Row(page, n(), "Plane Pos",
		function() return State.planePos end, function(v) State.planePos = v end), BT,
		function() return State.planeLock == "Manual" end)
	reg("Edit", makeVec3Row(page, n(), "Plane Rot",
		function() return State.planeRot end, function(v) State.planeRot = v end), BT,
		function() return State.planeLock == "Manual" end)
	reg("Edit", (makeToggleRow(page, n(), "Snap to Voxels", "snap")), BT)
	reg("Edit", (makeToggleRow(page, n(), "Ignore Water", "ignoreWater")), BT)
	reg("Edit", (makeToggleRow(page, n(), "Ignore Parts", "ignoreParts")), BT)

	Groups.Edit = nil
	local matWrap = autoFrame(page, n())
	local head = new("TextButton", {
		Text = "", Size = UDim2.new(1, 0, 0, 20), BackgroundTransparency = 1, AutoButtonColor = false, LayoutOrder = 1,
	}, matWrap)
	label(head, "MATERIAL", {
		Font = FONT, TextSize = TS.head, TextColor3 = T.dim, Size = UDim2.new(1, -20, 1, -3),
	})
	local arrow = icon(head, Icons.ArrowUp, IC.sm, {
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, -1), ImageColor3 = T.dim,
	})
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -1),
		BackgroundColor3 = T.divider, BorderSizePixel = 0,
	}, head)
	local matBody = autoFrame(matWrap, 2)
	local collapsed = false
	bind(head.MouseEnter, function() tween(arrow, TI_FAST, { ImageColor3 = T.white }) end)
	bind(head.MouseLeave, function() tween(arrow, TI_FAST, { ImageColor3 = T.dim }) end)
	bind(head.MouseButton1Click, function()
		collapsed = not collapsed
		matBody.Visible = not collapsed
		arrow.Image = collapsed and Icons.ArrowDown or Icons.ArrowUp
	end)

	local grid
	local autoRow = makeToggleRow(matBody, 1, "Auto Material", "autoMaterial", function(v)
		if grid then grid.SetEnabled(not v) end
	end)
	local _
	_, grid = makeMaterialGrid(matBody, 2, "material", function() UI.loadColor() end)
	grid.SetEnabled(not State.autoMaterial)
	buildColorSection(matBody, 3)
	reg("Edit", matWrap, { "Add", "Grow", "Flatten", "Paint" })
	table.insert(Hooks, function()
		local tl = State.tools.Edit
		autoRow.Visible = (tl == "Add" or tl == "Grow" or tl == "Flatten")
		grid.SetEnabled(not (State.autoMaterial and autoRow.Visible))
	end)

	section("Edit", page, n, "Material to replace", { "Replace" })
	reg("Edit", (makeMaterialGrid(page, n(), "replaceSource")), { "Replace" })
	section("Edit", page, n, "Replace with", { "Replace" })
	reg("Edit", (makeMaterialGrid(page, n(), "replaceTarget")), { "Replace" })

	section("Edit", page, n, "Sea Level", { "SeaLevel" })
	makeRegionRows(page, n, "Edit", { "SeaLevel" })
	reg("Edit", (makeToggleRow(page, n(), "Snap to Voxels", "regionSnap")), { "SeaLevel" })
	reg("Edit", buttonRow(page, n(), {
		{ text = "Create", fn = function() E.opSeaLevel(true) end, primary = true, icon = Icons.SeaLevel },
		{ text = "Evaporate", fn = function() E.opSeaLevel(false) end },
	}), { "SeaLevel" })

	section("Edit", page, n, "Information", nil)
	local info = new("Frame", {
		Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
		LayoutOrder = n(),
	}, page)
	new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, info)

	local function addShine(host, delay, sweepTime, wide)
		local function band(width, alpha, zi)
			local b = new("Frame", {
				Size = UDim2.new(width, 0, 2.4, 0), Position = UDim2.new(-0.6, 0, -0.7, 0), Rotation = 20,
				BackgroundColor3 = T.white, BorderSizePixel = 0, ZIndex = zi, Active = false,
			}, host)
			new("UIGradient", {
				Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, alpha),
					NumberSequenceKeypoint.new(1, 1),
				}),
			}, b)
			return b
		end
		local glow = band(wide and 0.42 or 0.5, 0.9, 5)
		local shine = band(wide and 0.16 or 0.2, 0.5, 6)
		local info_ = TweenInfo.new(sweepTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
		task.spawn(function()
			task.wait(delay)
			while Alive and shine.Parent do
				glow.Position = UDim2.new(-0.6, 0, -0.7, 0)
				shine.Position = UDim2.new(-0.4, 0, -0.7, 0)
				tween(glow, info_, { Position = UDim2.new(1.2, 0, -0.7, 0) })
				task.wait(0.1)
				tween(shine, info_, { Position = UDim2.new(1.15, 0, -0.7, 0) })
				task.wait(3.6)
			end
		end)
	end

	local bannerBox = new("Frame", {
		Size = UDim2.new(1, 0, 0, 96), BackgroundColor3 = T.surface, BorderSizePixel = 0,
		ClipsDescendants = true, LayoutOrder = 1,
	}, info)
	corner(bannerBox, 5)
	if hasIcon(Icons.Banner) then
		local img = new("ImageLabel", {
			Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = Icons.Banner,
			ScaleType = Enum.ScaleType.Crop,
		}, bannerBox)
		corner(img, 5)
	else
		icon(bannerBox, Icons.Terrain, IC.lg, {
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ImageColor3 = T.dim,
		})
	end
	addShine(bannerBox, 0, 1.3, true)

	local DISCORD_TAG = "Discord.gg/NarsEdv"
	local discordBtn = new("TextButton", {
		Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(88, 101, 242), BorderSizePixel = 0,
		ClipsDescendants = true, LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 24),
	}, info)
	corner(discordBtn, 5)
	local dcRow = new("Frame", {
		Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 2,
	}, discordBtn)
	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}, dcRow)
	if hasIcon(Icons.Discord) then
		local dcIco = icon(dcRow, Icons.Discord, IC.sm, { ImageColor3 = T.white })
		dcIco.LayoutOrder = 1
	end
	local dcLbl = label(dcRow, DISCORD_TAG, {
		Font = FONT, TextSize = TS.small, TextColor3 = T.white, LayoutOrder = 2,
		Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, TextTruncate = Enum.TextTruncate.None,
		TextXAlignment = Enum.TextXAlignment.Center,
	})
	pressFx(discordBtn, 0.97)
	bind(discordBtn.MouseEnter, function()
		tween(discordBtn, TI_FAST, { BackgroundColor3 = Color3.fromRGB(104, 117, 255) })
	end)
	bind(discordBtn.MouseLeave, function()
		tween(discordBtn, TI_FAST, { BackgroundColor3 = Color3.fromRGB(88, 101, 242) })
	end)
	bind(discordBtn.MouseButton1Click, function()
		local fn = clipboardFn()
		local ok = fn and pcall(fn, DISCORD_LINK)
		dcLbl.Text = ok and "Copied" or "No clipboard"
		task.delay(1.2, function()
			if dcLbl.Parent then dcLbl.Text = DISCORD_TAG end
		end)
	end)
	addShine(discordBtn, 0.5, 0.9, false)

	local KEY_BG = Color3.fromRGB(44, 44, 44)
	local ROW_LINE = Color3.fromRGB(52, 52, 52)
	local BIG = Vector2.new(10000, 10000)
	local function measure(str)
		local ok, v = pcall(function()
			return game:GetService("TextService"):GetTextSize(str, TS.small, FONT, BIG)
		end)
		if ok and typeof(v) == "Vector2" then return v end
		return Vector2.new(#str * 6.4, TS.small + 2)
	end
	local spaceW = measure(string.rep(" ", 20)).X / 20
	if spaceW < 1 then spaceW = TS.small * 0.3 end
	local lineH = measure("Ag").Y

	local points = {
		{ "Create", {
			{ "Generate", "Builds procedural terrain inside the region box from your biome, seed, blending and caves settings. Large regions are built chunk by chunk, so the thin bar under the header shows the progress. Everything it makes is recorded for Generate Code." },
			{ "Clear", "Wipes all terrain in the whole place, not only inside the region box. Press it twice to confirm. The recorded script resets as well, and Clear First is switched on for the next export." },
			{ "Region", "The box where terrain is generated. Drag the arrow handles in the viewport or type the Position and Size values. The largest area is 2048 x 2048 studs." },
			{ "Snap to Voxels", "Locks the box to the 4 stud voxel grid so its edges line up with terrain voxels. Turn it off to type free values." },
			{ "Seed", "A number that decides the shape of the terrain. The same seed with the same settings always gives the same result. Press Rand to pick a new one." },
			{ "Biome Size", "Sets how wide each biome is across the region. Higher values give larger biomes that change more slowly." },
			{ "Blending", "Controls how softly neighbouring biomes mix at their borders. Higher values give smoother transitions." },
			{ "Caves", "Carves cave tunnels below the surface when it is on." },
			{ "Biomes", "Choose which biomes take part: Water, Plains, Hills, Dunes, Canyons, Mountains, Lava, Arctic and Marsh. Keep at least one selected." },
			{ "Open Code Generator", "Opens the Generate Code window, which turns your edits into a Script." },
			{ "Brush Active", "Turns the brush on or off from any tab. The same switch sits in the header." },
		} },
		{ "Region", {
			{ "Select", "Click and drag on the terrain to draw the region box. The height keeps its current value." },
			{ "Move", "Drag the arrow handles or edit Position, then press Apply to carry the terrain to the new place. Reset cancels the move." },
			{ "Resize", "Drag the face handles or edit Size, then press Apply to stretch or shrink the terrain into the new box. Reset cancels it." },
			{ "Rotate", "Drag a ring or press -90 / +90 to turn the terrain around the chosen axis in 90 degree steps." },
			{ "Delete", "Empties every voxel inside the box. The Delete key does the same while the Region tab is open." },
			{ "Fill", "Fill mode paints the whole box with one material. Replace mode only swaps the source material for the target material." },
			{ "Merge Empty", "When on, empty voxels from the source overwrite what is at the destination during Move, Resize and Rotate. When off, only solid voxels are copied." },
			{ "Snap to Voxels", "Locks the box to the 4 stud voxel grid. Turn it off to type free values." },
		} },
		{ "Edit", {
			{ "Add", "Builds terrain under the brush. It keeps the higher of the existing and the brush occupancy, so it never digs." },
			{ "Subtract", "Carves terrain away inside the brush." },
			{ "Grow", "Raises the surface a little at a time where the brush touches it. Strength sets the speed." },
			{ "Erode", "Wears the surface down gradually. Strength sets the speed." },
			{ "Smooth", "Evens out rough or sharp areas by blending every voxel with its neighbours." },
			{ "Flatten", "Levels terrain to the height where the stroke started. Flatten Mode chooses Erode, All or Grow." },
			{ "Paint", "Changes only the material of existing terrain and leaves its shape alone." },
			{ "Replace", "Swaps the source material for the target material under the brush." },
			{ "Sea Level", "Floods the region box with water up to its top edge. Create adds water, Evaporate removes it." },
			{ "Brush Active", "The brush only paints while this switch is on." },
			{ "Base Size", "Brush size in studs, from 1 to 64. Ball and Cylinder use it as the diameter, Block uses it as width and depth." },
			{ "Height", "Brush height in studs. Only used by Block and Cylinder." },
			{ "Strength", "From 0.1 (gentle) to 1 (full). Used by Grow, Erode, Smooth and Flatten." },
			{ "Pivot", "Chooses which point of the brush touches the terrain: Bottom, Center or Top." },
			{ "Plane Lock", "Off follows the terrain. Auto locks the brush to the plane where the stroke started. Manual uses the Plane Pos and Plane Rot values." },
			{ "Snap to Voxels", "Snaps the brush center to the voxel grid." },
			{ "Ignore Water", "The brush passes through water while adding or subtracting terrain." },
			{ "Ignore Parts", "The brush ignores parts and aims only at terrain." },
			{ "Auto Material", "New terrain copies the material of the terrain around the brush. The selected material is only used when nothing is nearby." },
			{ "Custom Color", "Changes the display color of the selected material. The color is added to the exported script." },
			{ "Ctrl", "Hold while using Add, Subtract, Grow or Erode to switch to the opposite mode." },
			{ "Shift", "Hold while using Add, Subtract, Grow or Erode to smooth temporarily." },
			{ "B + Scroll", "Hold B and scroll to change Base Size. Add Ctrl for Height, or Shift for Strength." },
		} },
		{ "Generate Code", {
			{ "Generate", "Builds a Script from every recorded edit, in order. Undo and Redo update it automatically." },
			{ "Copy", "Copies the whole script at once." },
			{ "Copy Part", "Copies only the page you are viewing. Use < and > to change pages." },
			{ "Save", "Saves the script as a .lua file in the Terrain folder of your executor workspace." },
			{ "Clear", "Empties the code box without touching the terrain." },
			{ "Name", "The file name used by Save." },
			{ "Clear First", "Starts the script with a terrain clear, so it rebuilds the whole map." },
			{ "Paste", "Create a Script in ServerScriptService. Paste page 1, add page 2 directly below it, and continue in order until the last page. Every page ends on a complete statement, so the pages join without errors. Press Play once all pages are in." },
		} },
	}

	for i, pt in ipairs(points) do
		local card = new("Frame", {
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = T.surface,
			BorderSizePixel = 0, LayoutOrder = 2 + i,
		}, info)
		corner(card, RAD.md)
		new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, card)
		local head = new("TextButton", {
			Text = "", Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, AutoButtonColor = false,
			BorderSizePixel = 0, LayoutOrder = 1,
		}, card)
		label(head, pt[1], {
			Font = FONT, TextSize = TS.body, TextColor3 = T.text,
			Position = UDim2.new(0, 10, 0, 0), Size = UDim2.new(1, -36, 1, 0),
		})
		local arrow = icon(head, Icons.ArrowDown, IC.sm, {
			AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), ImageColor3 = T.dim,
		})
		local body = new("Frame", {
			Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
			Visible = false, LayoutOrder = 2,
		}, card)
		pad(body, 10, 0, 10, 4)
		new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, body)

		local order = 0
		local function nextOrder()
			order += 1
			return order
		end
		new("Frame", {
			Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = ROW_LINE, BorderSizePixel = 0, LayoutOrder = nextOrder(),
		}, body)
		for j, row in ipairs(pt[2]) do
			local keyText = "_" .. row[1]
			local blockW = math.ceil(measure(keyText).X) + 12
			local indent = math.ceil((blockW + 6) / spaceW)
			local r = new("Frame", {
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1,
				BorderSizePixel = 0, LayoutOrder = nextOrder(),
			}, body)
			pad(r, 0, 8, 0, 8)
			label(r, string.rep(" ", indent) .. row[2], {
				Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true,
				TextTruncate = Enum.TextTruncate.None, TextSize = TS.small, TextColor3 = T.sub,
				TextYAlignment = Enum.TextYAlignment.Top,
			})
			local key = new("Frame", {
				Size = UDim2.new(0, blockW, 0, lineH + 4), Position = UDim2.new(0, 0, 0, -2),
				BackgroundColor3 = KEY_BG, BorderSizePixel = 0, ZIndex = 2,
			}, r)
			corner(key, 5)
			label(key, keyText, {
				TextSize = TS.small, TextColor3 = T.text, TextXAlignment = Enum.TextXAlignment.Center,
				TextTruncate = Enum.TextTruncate.None, ZIndex = 2,
			})
			if j < #pt[2] then
				new("Frame", {
					Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = ROW_LINE, BorderSizePixel = 0,
					LayoutOrder = nextOrder(),
				}, body)
			end
		end

		local open = false
		bind(head.MouseEnter, function() tween(arrow, TI_FAST, { ImageColor3 = T.white }) end)
		bind(head.MouseLeave, function() tween(arrow, TI_FAST, { ImageColor3 = T.dim }) end)
		bind(head.MouseButton1Click, function()
			open = not open
			body.Visible = open
			arrow.Image = open and Icons.ArrowUp or Icons.ArrowDown
		end)
	end
	reg("Edit", info, nil)
end

buildCreatePage()
buildRegionPage()
buildEditPage()
bind(UserInputService.InputBegan, function(input, gp)
	if isPointer(input) then
		if gp then return end
		E.beginStroke(input.Position.X, input.Position.Y, input)
	elseif input.UserInputType == Enum.UserInputType.Keyboard then
		if UserInputService:GetFocusedTextBox() then return end
		local ctrl = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)
			or UserInputService:IsKeyDown(Enum.KeyCode.RightControl)
			or UserInputService:IsKeyDown(Enum.KeyCode.LeftMeta)
		local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
		if ctrl then
			if input.KeyCode == Enum.KeyCode.Z then
				if shift then E.redo() else E.undo() end
			elseif input.KeyCode == Enum.KeyCode.Y then
				E.redo()
			end
		elseif input.KeyCode == Enum.KeyCode.Delete and State.tab == "Region" then
			E.opDelete()
		end
	end
end)

bind(UserInputService.InputChanged, function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		E.moveStroke(input.Position.X, input.Position.Y)
	elseif input.UserInputType == Enum.UserInputType.Touch and E.Pointer.input == input then
		E.moveStroke(input.Position.X, input.Position.Y)
	end
end)

bind(UserInputService.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		E.endStroke()
	elseif input.UserInputType == Enum.UserInputType.Touch and E.Pointer.input == input then
		E.endStroke()
		E.Pointer.valid = false
	end
end)

bind(UserInputService.InputChanged, function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseWheel then return end
	if UserInputService:GetFocusedTextBox() or not UserInputService:IsKeyDown(Enum.KeyCode.B) then return end
	if not E.activeBrushTool() then return end
	local dir = (input.Position.Z > 0) and 1 or -1
	local ctrlDown = E.modKeyDown(Enum.KeyCode.LeftControl, Enum.KeyCode.RightControl, Enum.KeyCode.LeftMeta)
	local shiftDown = E.modKeyDown(Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift)
	if shiftDown then
		State.strength = clamp(math.floor((State.strength + dir * 0.05) * 100 + 0.5) / 100, 0.1, 1)
	elseif ctrlDown then
		if State.shape ~= "Ball" then State.height = clamp(State.height + dir, 1, 64) end
	else
		State.baseSize = clamp(State.baseSize + dir, 1, 64)
	end
	UI.syncBrush()
	if UI.onSlider then UI.onSlider() end
end)

local stepWarned = false
bind(RunService.RenderStepped, function()
	if not Alive then return end
	local ok, err = pcall(E.step)
	if not ok and not stepWarned then
		stepWarned = true
		warn("[TerrainEditor] " .. tostring(err))
	end
end)

function GUI.Destroy()
	genv.__NarsTerrainEditorDestroy = nil
	E.destroy()
end
genv.__NarsTerrainEditorDestroy = GUI.Destroy

E.initRegionVis()
E.initPreview()
setTab("Edit")
