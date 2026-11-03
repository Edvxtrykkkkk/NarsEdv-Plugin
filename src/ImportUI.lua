-- Nars Edv - Import ui json to StarterGui
-- Version beta V0.3 (UI Monochrome Glow)

local CONFIG = {
    APP_NAME = "NARS JSON UI IMPORTER",
    VERSION = "1.0.1",
    FOLDER = "Import-UI",
    MAX_FILE_BYTES = 5 * 1024 * 1024,
    MAX_NODES = 5000,
    MAX_DEPTH = 80,
    IMPORT_PARENT = "StarterGui", -- "StarterGui" or "PlayerGui"
    CLEAR_PREVIOUS_IMPORT = false,
    IMPORT_TAG = "_NARS_JSON_IMPORT",
    ACCENT = Color3.fromRGB(245, 245, 245),
    BG = Color3.fromRGB(14, 14, 14),
    PANEL = Color3.fromRGB(24, 24, 24),
    PANEL_2 = Color3.fromRGB(32, 32, 32),
    TEXT = Color3.fromRGB(240, 240, 240),
    MUTED = Color3.fromRGB(150, 150, 150),
    GREEN = Color3.fromRGB(170, 235, 195),
    RED = Color3.fromRGB(255, 125, 125),
    YELLOW = Color3.fromRGB(255, 210, 130),
}

-- Icon module (pakai: Image = Icon.Close)
local Icon = {
    Maximize = 73085922906397,
    Close = 110786993356448,
    Minimal = 118026365011536,
    FileCode = 77253337986109,
    Refresh = 138133190015277,
    Import = 93307473217005,
    List = 96385120752336,
    Search = 80009010551347,
    Checklis = 93898873302694,
    Logo = 122926744824622,
}
for key, id in pairs(Icon) do
    Icon[key] = "rbxassetid://" .. tostring(id)
end

local Services = {}
local function getService(name)
    local ok, value = pcall(function()
        return game:GetService(name)
    end)
    if ok then return value end
end

Services.HttpService = getService("HttpService")
Services.Players = getService("Players")
Services.StarterGui = getService("StarterGui")
Services.CoreGui = getService("CoreGui")
Services.TweenService = getService("TweenService")
Services.UserInputService = getService("UserInputService")

local function safeCall(fn, ...)
    if type(fn) ~= "function" then return false, "API tidak tersedia" end
    return pcall(fn, ...)
end

local function trim(s)
    return tostring(s or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function lower(s)
    return string.lower(tostring(s or ""))
end

local function isArray(t)
    if type(t) ~= "table" then return false end
    local n = 0
    for k in pairs(t) do
        if type(k) ~= "number" or k < 1 or k % 1 ~= 0 then return false end
        n = n + 1
    end
    return n == #t
end

local function safeDestroy(instance)
    if instance then pcall(function() instance:Destroy() end) end
end

local function make(className, parent, name)
    local obj = Instance.new(className)
    if name then obj.Name = name end
    if parent then obj.Parent = parent end
    return obj
end

-- Executor file API compatibility
local FS = {}
FS.listfiles = listfiles
FS.readfile = readfile
FS.isfile = isfile
FS.isfolder = isfolder
FS.makefolder = makefolder

local function filesystemReady()
    return type(FS.listfiles) == "function"
       and type(FS.readfile) == "function"
end

local function ensureFolder()
    if type(FS.makefolder) ~= "function" then return end
    local path = ""
    for segment in CONFIG.FOLDER:gmatch("[^/\\]+") do
        path = path == "" and segment or (path .. "/" .. segment)
        if type(FS.isfolder) ~= "function" then
            pcall(FS.makefolder, path)
        else
            local ok, exists = pcall(FS.isfolder, path)
            if ok and not exists then pcall(FS.makefolder, path) end
        end
    end
end

local function isJsonPath(path)
    return lower(path):match("%.json$") ~= nil
end

local function pathFileName(path)
    return tostring(path):gsub("\\", "/"):match("([^/]+)$") or tostring(path)
end

local function scanJsonFiles()
    if not filesystemReady() then
        return nil, "API file executor tidak lengkap. Dibutuhkan listfiles() dan readfile()."
    end
    ensureFolder()
    local ok, files = pcall(FS.listfiles, CONFIG.FOLDER)
    if not ok or type(files) ~= "table" then
        return nil, "Gagal membaca folder: " .. CONFIG.FOLDER
    end

    local out = {}
    for _, path in ipairs(files) do
        if type(path) == "string" and isJsonPath(path) then
            local bytes = nil
            if type(FS.isfile) == "function" then
                local okFile, yes = pcall(FS.isfile, path)
                if okFile and not yes then continue end
            end
            if type(FS.readfile) == "function" then
                local okRead, contents = pcall(FS.readfile, path)
                if okRead and type(contents) == "string" then bytes = #contents end
            end
            table.insert(out, {
                path = path,
                name = pathFileName(path),
                bytes = bytes or 0,
            })
        end
    end
    table.sort(out, function(a, b) return lower(a.name) < lower(b.name) end)
    return out
end

local SCRIPT_CLASSES = {
    Script = true,
    LocalScript = true,
    ModuleScript = true,
}

local function isBlockedClass(className)
    return SCRIPT_CLASSES[className] == true
end

local function vec2(v)
    if type(v) ~= "table" then return nil end
    if v.x ~= nil and v.y ~= nil then return Vector2.new(v.x, v.y) end
    return nil
end

local function udim2(v)
    if type(v) ~= "table" then return nil end
    if v.scaleX ~= nil and v.offsetX ~= nil and v.scaleY ~= nil and v.offsetY ~= nil then
        return UDim2.new(v.scaleX, v.offsetX, v.scaleY, v.offsetY)
    end
    if v.X and v.Y and v.X.Scale ~= nil and v.Y.Scale ~= nil then
        return UDim2.new(v.X.Scale, v.X.Offset or 0, v.Y.Scale, v.Y.Offset or 0)
    end
end

local function udim(v)
    if type(v) ~= "table" then return nil end
    if v.scale ~= nil and v.offset ~= nil then return UDim.new(v.scale, v.offset) end
    if v.Scale ~= nil then return UDim.new(v.Scale, v.Offset or 0) end
    if v.scaleX ~= nil and v.offsetX ~= nil and v.scaleY == nil then
        return UDim.new(v.scaleX, v.offsetX)
    end
end

local function color3(v)
    if type(v) ~= "table" then return nil end
    if v.r ~= nil and v.g ~= nil and v.b ~= nil then
        return Color3.fromRGB(
            math.clamp(tonumber(v.r) or 0, 0, 255),
            math.clamp(tonumber(v.g) or 0, 0, 255),
            math.clamp(tonumber(v.b) or 0, 0, 255)
        )
    end
    if v.R ~= nil and v.G ~= nil and v.B ~= nil then
        return Color3.new(v.R, v.G, v.B)
    end
end

local function vector3(v)
    if type(v) == "table" and v.x ~= nil and v.y ~= nil and v.z ~= nil then
        return Vector3.new(v.x, v.y, v.z)
    end
    if type(v) == "table" and v.X ~= nil and v.Y ~= nil and v.Z ~= nil then
        return Vector3.new(v.X, v.Y, v.Z)
    end
end

local function rect(v)
    if type(v) == "table" then
        local min = v.Min or v.min
        local max = v.Max or v.max
        if type(min) == "table" and type(max) == "table" then
            return Rect.new(Vector2.new(min.x or min.X or 0, min.y or min.Y or 0),
                            Vector2.new(max.x or max.X or 0, max.y or max.Y or 0))
        end
    end
end

local UDim2Props = {
    Size=true, Position=true, CanvasSize=true, CanvasPosition=false,
    CellSize=true, CellPadding=true, TouchTap=true,
    TileSize=true, SliceCenter=true, ImageRectSize=true, ImageRectOffset=true,
}
local UDimProps = {
    CornerRadius=true, PaddingTop=true, PaddingBottom=true,
    PaddingLeft=true, PaddingRight=true, Thickness=false,
}
local Vector2Props = {
    AnchorPoint=true, CanvasPosition=true, ImageRectSize=true, ImageRectOffset=true,
}
local ColorProps = {
    BackgroundColor3=true, BorderColor3=true, TextColor3=true,
    TextStrokeColor3=true, ImageColor3=true, ScrollBarImageColor3=true,
    PlaceholderColor3=true, SelectionImageObject=false,
}
local EnumTypes = {
    Font="Font",
    TextXAlignment="TextXAlignment",
    TextYAlignment="TextYAlignment",
    TextTruncate="TextTruncate",
    TextDirection="TextDirection",
    TextWrapped="TextWrapped",
    ScaleType="ScaleType",
    SliceScale="",
    FillDirection="FillDirection",
    HorizontalAlignment="HorizontalAlignment",
    VerticalAlignment="VerticalAlignment",
    SortOrder="SortOrder",
    StartCorner="StartCorner",
    FillDirectionMaxCells="",
    ScrollingDirection="ScrollingDirection",
    AutomaticCanvasSize="AutomaticSize",
    AutomaticSize="AutomaticSize",
    ElasticBehavior="ElasticBehavior",
    ScrollBarInset="ScrollBarInset",
    VerticalScrollBarPosition="VerticalScrollBarPosition",
    ResampleMode="ResamplerMode",
    ZIndexBehavior="ZIndexBehavior",
    DisplayOrder="",
    SelectionBehaviorDown="SelectionBehavior",
    SelectionBehaviorUp="SelectionBehavior",
    SelectionBehaviorLeft="SelectionBehavior",
    SelectionBehaviorRight="SelectionBehavior",
    ApplyStrokeMode="ApplyStrokeMode",
    LineJoinMode="LineJoinMode",
    FontFace="",
    UIFlexMode="UIFlexMode",
    ItemLineAlignment="ItemLineAlignment",
    Padding="",
}

local function convertProperty(key, value)
    if type(value) ~= "table" then
        local enumType = EnumTypes[key]
        if enumType and enumType ~= "" and type(value) == "string" then
            local ok, enumValue = pcall(function() return Enum[enumType][value] end)
            if ok and enumValue then return enumValue end
        end
        if key == "Font" and type(value) == "string" then
            local ok, enumValue = pcall(function() return Enum.Font[value] end)
            if ok and enumValue then return enumValue end
        end
        return value
    end

    if UDim2Props[key] then
        local converted = udim2(value)
        if converted then return converted end
    end
    if UDimProps[key] then
        local converted = udim(value)
        if converted then return converted end
    end
    if Vector2Props[key] then
        local converted = vec2(value)
        if converted then return converted end
        if key == "CanvasPosition" or key == "ImageRectSize" or key == "ImageRectOffset" then
            if value.x ~= nil and value.y ~= nil then return Vector2.new(value.x, value.y) end
        end
    end
    if ColorProps[key] then
        local converted = color3(value)
        if converted then return converted end
    end
    if key == "AnchorPoint" then
        local converted = vec2(value)
        if converted then return converted end
    end
    if key == "Rotation" or key == "TextSize" or key == "LayoutOrder" or key == "ZIndex"
       or key == "BorderSizePixel" or key == "ScrollBarThickness" or key == "SliceCenter" then
        return value
    end

    -- Common structured value fallbacks.
    local c = color3(value)
    if c then return c end
    local u2 = udim2(value)
    if u2 then return u2 end
    local u = udim(value)
    if u then return u end
    local v2 = vec2(value)
    if v2 then return v2 end
    local v3 = vector3(value)
    if v3 then return v3 end
    local r = rect(value)
    if r then return r end

    -- A schema-specific UICorner radius set is not part of Roblox's UICorner API.
    -- Such fields are skipped and reported by the property setter.
    return value
end

local function isWritableProperty(instance, property)
    local ok, current = pcall(function() return instance[property] end)
    return ok, current
end

local function applyProperties(instance, properties, report, nodeLabel)
    if type(properties) ~= "table" then return end
    for key, rawValue in pairs(properties) do
        if type(key) == "string" and key ~= "ClassName" and key ~= "Source" then
            local converted = convertProperty(key, rawValue)
            local ok = pcall(function()
                instance[key] = converted
            end)
            if not ok then
                -- Font can be represented by Enum.Font in older schema; FontFace can differ by runtime.
                if key == "FontFace" and type(rawValue) == "string" then
                    local fontOk, fontEnum = pcall(function() return Enum.Font[rawValue] end)
                    if fontOk and fontEnum then
                        ok = pcall(function() instance.Font = fontEnum end)
                    end
                end
            end
            if not ok then
                report.warnings = report.warnings + 1
                table.insert(report.details, ("Property dilewati: %s.%s"):format(nodeLabel, key))
            else
                report.properties = report.properties + 1
            end
        end
    end
end

local function validateDocument(doc)
    if type(doc) ~= "table" then return false, "Root JSON harus berupa object." end
    if type(doc.objects) ~= "table" or not isArray(doc.objects) then
        return false, 'Field "objects" harus berupa array.'
    end
    local count, errors = 0, {}
    local function walk(nodes, depth)
        if depth > CONFIG.MAX_DEPTH then
            table.insert(errors, "Kedalaman hierarki melebihi batas " .. CONFIG.MAX_DEPTH)
            return
        end
        for _, node in ipairs(nodes) do
            count = count + 1
            if count > CONFIG.MAX_NODES then
                table.insert(errors, "Jumlah node melebihi batas " .. CONFIG.MAX_NODES)
                return
            end
            if type(node) ~= "table" then
                table.insert(errors, "Node bukan object JSON.")
            elseif type(node.className) ~= "string" or node.className == "" then
                table.insert(errors, "Node tanpa className.")
            elseif type(node.properties) ~= "table" then
                table.insert(errors, "Properties tidak valid pada " .. tostring(node.name or node.id or "?"))
            elseif node.children ~= nil and (type(node.children) ~= "table" or not isArray(node.children)) then
                table.insert(errors, "Children bukan array pada " .. tostring(node.name or node.id or "?"))
            else
                if node.children then walk(node.children, depth + 1) end
            end
        end
    end
    walk(doc.objects, 1)
    if #errors > 0 then return false, table.concat(errors, "\n"), count end
    return true, nil, count
end

local function getImportParent()
    if CONFIG.IMPORT_PARENT == "PlayerGui" then
        local player = Services.Players and Services.Players.LocalPlayer
        if player then
            local ok, pg = pcall(function() return player:FindFirstChildOfClass("PlayerGui") end)
            if ok and pg then return pg end
        end
        return nil, "PlayerGui tidak ditemukan."
    end
    if Services.StarterGui then return Services.StarterGui end
    return nil, "StarterGui tidak tersedia pada environment ini."
end

local function buildNode(node, parent, report, depth)
    if depth > CONFIG.MAX_DEPTH then
        error("Batas kedalaman hierarki tercapai.")
    end
    local className = node.className
    if isBlockedClass(className) then
        report.skippedScripts = report.skippedScripts + 1
        table.insert(report.details, "Script class dilewati: " .. tostring(node.name or className))
        return nil
    end

    local ok, instanceOrError = pcall(function() return Instance.new(className) end)
    if not ok or not instanceOrError then
        report.errors = report.errors + 1
        table.insert(report.details, ("Class tidak tersedia: %s (%s)"):format(
            tostring(className), tostring(instanceOrError)))
        return nil
    end

    local instance = instanceOrError
    instance.Name = tostring(node.name or className)
    report.nodes = report.nodes + 1
    applyProperties(instance, node.properties, report, instance.Name)

    -- Do not copy executable source or unknown schema metadata into Instances.
    for _, childNode in ipairs(node.children or {}) do
        local child = nil
        local childOk, childErr = pcall(function()
            child = buildNode(childNode, instance, report, depth + 1)
        end)
        if not childOk then
            report.errors = report.errors + 1
            table.insert(report.details, "Gagal membuat child: " .. tostring(childErr))
        elseif child then
            local parentOk = pcall(function() child.Parent = instance end)
            if not parentOk then
                safeDestroy(child)
                report.errors = report.errors + 1
                table.insert(report.details, ("Parent tidak cocok: %s -> %s"):format(
                    tostring(childNode.className), tostring(instance.ClassName)))
            end
        end
    end
    return instance
end

local function importDocument(doc, fileName)
    local valid, validationError, nodeCount = validateDocument(doc)
    if not valid then return false, validationError end
    local destination, destinationError = getImportParent()
    if not destination then return false, destinationError end

    local report = {
        nodes = 0, properties = 0, warnings = 0, errors = 0,
        skippedScripts = 0, details = {},
    }
    local roots = {}
    for _, rootNode in ipairs(doc.objects) do
        local ok, rootOrError = pcall(function()
            return buildNode(rootNode, nil, report, 1)
        end)
        if ok and rootOrError then
            table.insert(roots, rootOrError)
        else
            report.errors = report.errors + 1
            table.insert(report.details, "Root gagal: " .. tostring(rootOrError))
        end
    end

    if #roots == 0 then
        for _, root in ipairs(roots) do safeDestroy(root) end
        return false, "Tidak ada root UI yang berhasil dibuat."
    end

    local importedCount = 0
    for _, root in ipairs(roots) do
        local parentOk, parentError = pcall(function()
            root.Parent = destination
            root:SetAttribute(CONFIG.IMPORT_TAG, tostring(fileName or "JSON"))
        end)
        if parentOk then
            importedCount = importedCount + 1
        else
            safeDestroy(root)
            report.errors = report.errors + 1
            table.insert(report.details, "Gagal memasang root ke " .. destination.Name .. ": " .. tostring(parentError))
        end
    end

    if importedCount == 0 then
        return false, "Semua root gagal dipasang ke " .. destination.Name
    end

    return true, {
        projectName = tostring(doc.projectName or fileName or "Untitled"),
        sourceNodes = nodeCount,
        importedNodes = report.nodes,
        roots = importedCount,
        properties = report.properties,
        warnings = report.warnings,
        errors = report.errors,
        skippedScripts = report.skippedScripts,
        details = report.details,
        destination = destination:GetFullName(),
    }
end

-- ============================================================
-- UI (Monochrome Dark / White Glow / UIGradient)
-- ============================================================
local TweenService = Services.TweenService
local UIS = Services.UserInputService

local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(10, 10, 10)
local ROW_IDLE = Color3.fromRGB(26, 26, 26)
local ROW_ON = Color3.fromRGB(46, 46, 46)

local function destroyOldGui()
    local playerGui = Services.Players and Services.Players.LocalPlayer
        and Services.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    for _, container in ipairs({ Services.CoreGui, playerGui }) do
        if container then
            local found = container:FindFirstChild("NARS_JSON_UI_IMPORTER")
            if found then safeDestroy(found) end
        end
    end
end

destroyOldGui()

local guiParent = Services.CoreGui
if not guiParent then
    local player = Services.Players and Services.Players.LocalPlayer
    guiParent = player and player:FindFirstChildOfClass("PlayerGui")
end
if not guiParent then
    warn("[NARS Importer] Tidak menemukan parent UI untuk panel importer.")
    return
end

-- helpers ----------------------------------------------------
local function tween(obj, time, props, style, dir)
    local t = TweenService:Create(obj, TweenInfo.new(time, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
    t:Play()
    return t
end

local function corner(obj, radius)
    local c = make("UICorner", obj)
    c.CornerRadius = UDim.new(0, radius)
    return c
end

local function stroke(obj, color, transparency, thickness)
    local s = make("UIStroke", obj)
    s.Color = color
    s.Transparency = transparency
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end

local function gradient(obj, c0, c1, rotation)
    local g = make("UIGradient", obj)
    g.Color = ColorSequence.new(c0, c1)
    g.Rotation = rotation or 90
    return g
end

local function pulse(obj, prop, from, to, duration, delay)
    obj[prop] = from
    local t = TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true, delay or 0), { [prop] = to })
    t:Play()
    return t
end

local function label(parent, name, text, size, position, font, color, textSize)
    local o = make("TextLabel", parent, name)
    o.BackgroundTransparency = 1
    o.BorderSizePixel = 0
    o.Size = size
    o.Position = position or UDim2.new()
    o.Font = font or Enum.Font.GothamMedium
    o.Text = text
    o.TextSize = textSize or 10
    o.TextColor3 = color or CONFIG.TEXT
    o.TextXAlignment = Enum.TextXAlignment.Left
    o.TextYAlignment = Enum.TextYAlignment.Center
    o.TextTruncate = Enum.TextTruncate.AtEnd
    return o
end

local function icon(parent, name, image, size, position, color)
    local i = make("ImageLabel", parent, name)
    i.BackgroundTransparency = 1
    i.BorderSizePixel = 0
    i.Image = image
    i.Size = UDim2.fromOffset(size, size)
    i.Position = position
    i.ImageColor3 = color or WHITE
    i.ScaleType = Enum.ScaleType.Fit
    return i
end

local function makeCard(parent, name, size, position)
    local f = make("Frame", parent, name)
    f.Size = size
    f.Position = position or UDim2.new()
    f.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    f.BorderSizePixel = 0
    corner(f, 8)
    stroke(f, WHITE, 0.88, 1)
    gradient(f, Color3.fromRGB(36, 36, 36), Color3.fromRGB(20, 20, 20), 90)
    return f
end

local function pressable(btn, hoverColor)
    local base = btn.BackgroundColor3
    local scale = make("UIScale", btn)
    btn.MouseEnter:Connect(function()
        tween(btn, 0.15, { BackgroundColor3 = hoverColor or base:Lerp(WHITE, 0.12) })
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, 0.15, { BackgroundColor3 = base })
        tween(scale, 0.12, { Scale = 1 })
    end)
    btn.MouseButton1Down:Connect(function()
        tween(scale, 0.08, { Scale = 0.94 })
    end)
    btn.MouseButton1Up:Connect(function()
        tween(scale, 0.2, { Scale = 1 }, Enum.EasingStyle.Back)
    end)
    return scale
end

local function badge(parent, text, size, position)
    local f = make("Frame", parent, "Badge")
    f.Size = size
    f.Position = position
    f.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    f.BorderSizePixel = 0
    corner(f, 8)
    stroke(f, WHITE, 0.85, 1)
    local l = label(f, "Text", text, UDim2.fromScale(1, 1), UDim2.new(), Enum.Font.GothamBold, CONFIG.TEXT, 8)
    l.TextXAlignment = Enum.TextXAlignment.Center
    return f, l
end

local function setBadge(l, text, color)
    l.Text = text
    tween(l, 0.2, { TextColor3 = color or CONFIG.TEXT })
end

local function formatSize(bytes)
    bytes = tonumber(bytes) or 0
    if bytes < 1024 then return ("%d B"):format(bytes) end
    if bytes < 1048576 then return ("%.1f KB"):format(bytes / 1024) end
    return ("%.2f MB"):format(bytes / 1048576)
end

-- root panel -------------------------------------------------
local NORMAL_SIZE = Vector2.new(270, 240)
local HEADER_H = 30

local gui = make("ScreenGui", guiParent, "NARS_JSON_UI_IMPORTER")
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local panel = make("Frame", gui, "Panel")
panel.Size = UDim2.new(0, 270, 0, 240)
panel.Position = UDim2.new(0.5, -135, 0.5, -120)
panel.BackgroundTransparency = 1
panel.BorderSizePixel = 0
local panelScale = make("UIScale", panel)
panelScale.Scale = 0.88

local glow = make("Frame", panel, "Glow")
glow.Position = UDim2.fromOffset(-4, -4)
glow.Size = UDim2.new(1, 8, 1, 8)
glow.BackgroundColor3 = WHITE
glow.BorderSizePixel = 0
glow.ZIndex = 0
corner(glow, 14)
local glowGradient = gradient(glow, WHITE, Color3.fromRGB(90, 90, 90), 45)

local root = make("Frame", panel, "Root")
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = CONFIG.BG
root.BorderSizePixel = 0
root.ClipsDescendants = true
root.ZIndex = 1
corner(root, 10)
gradient(root, Color3.fromRGB(26, 26, 26), Color3.fromRGB(10, 10, 10), 90)
local outline = stroke(root, WHITE, 0.4, 1.2)
local outlineGradient = make("UIGradient", outline)
outlineGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, WHITE),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(80, 80, 80)),
    ColorSequenceKeypoint.new(1, WHITE),
})

-- header -----------------------------------------------------
local header = make("Frame", root, "Header")
header.Size = UDim2.new(1, 0, 0, HEADER_H)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.Active = true

local headerLine = make("Frame", header, "Line")
headerLine.Position = UDim2.new(0, 0, 1, -1)
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.BackgroundColor3 = WHITE
headerLine.BackgroundTransparency = 0.88
headerLine.BorderSizePixel = 0

local logoBox = make("Frame", header, "LogoBox")
logoBox.Position = UDim2.fromOffset(6, 4)
logoBox.Size = UDim2.fromOffset(22, 22)
logoBox.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
logoBox.BorderSizePixel = 0
corner(logoBox, 6)
local logo = icon(logoBox, "Logo", Icon.Logo, 16, UDim2.fromOffset(3, 3), BLACK)

local title = label(header, "Title", CONFIG.APP_NAME, UDim2.new(1, -112, 0, 13), UDim2.fromOffset(34, 3), Enum.Font.GothamBold, CONFIG.TEXT, 10)
local subtitle = label(header, "Subtitle", "UI Asset Manager · v" .. CONFIG.VERSION, UDim2.new(1, -112, 0, 10), UDim2.fromOffset(34, 16), Enum.Font.GothamMedium, CONFIG.MUTED, 8)

local function headerButton(name, image, xOffset)
    local b = make("ImageButton", header, name)
    b.Size = UDim2.fromOffset(18, 18)
    b.Position = UDim2.new(1, xOffset, 0, 6)
    b.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Image = image
    b.ImageColor3 = WHITE
    b.ScaleType = Enum.ScaleType.Fit
    corner(b, 5)
    stroke(b, WHITE, 0.9, 1)
    pressable(b)
    return b
end

local closeButton = headerButton("Close", Icon.Close, -24)
local maximizeButton = headerButton("Maximize", Icon.Maximize, -46)
local minimizeButton = headerButton("Minimal", Icon.Minimal, -68)

-- content (ScrollingFrame utama) -----------------------------
local content = make("ScrollingFrame", root, "Content")
content.Position = UDim2.fromOffset(0, HEADER_H + 1)
content.Size = UDim2.new(1, 0, 1, -(HEADER_H + 1))
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.ScrollBarImageColor3 = WHITE
content.ScrollBarImageTransparency = 0.5
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.CanvasSize = UDim2.new()
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
local contentPad = make("UIPadding", content)
contentPad.PaddingTop = UDim.new(0, 8)
contentPad.PaddingBottom = UDim.new(0, 10)
contentPad.PaddingLeft = UDim.new(0, 8)
contentPad.PaddingRight = UDim.new(0, 8)
local contentLayout = make("UIListLayout", content)
contentLayout.Padding = UDim.new(0, 9)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

local pulseLabels = { title }

local function makeSection(order, titleText, cardHeight, collapsible)
    local sec = make("Frame", content, "Sec_" .. (titleText:gsub("%s", "")))
    sec.BackgroundTransparency = 1
    sec.BorderSizePixel = 0
    sec.Size = UDim2.new(1, 0, 0, 0)
    sec.AutomaticSize = Enum.AutomaticSize.Y
    sec.LayoutOrder = order
    local lay = make("UIListLayout", sec)
    lay.Padding = UDim.new(0, 5)
    lay.SortOrder = Enum.SortOrder.LayoutOrder

    local head = make("Frame", sec, "Head")
    head.BackgroundTransparency = 1
    head.Size = UDim2.new(1, 0, 0, 18)
    head.LayoutOrder = 1
    local ttl = label(head, "Title", titleText, UDim2.new(1, -24, 1, 0), UDim2.new(), Enum.Font.GothamBold, CONFIG.TEXT, 12)
    table.insert(pulseLabels, ttl)

    local card = makeCard(sec, "Card", UDim2.new(1, 0, 0, cardHeight))
    card.LayoutOrder = 2
    card.ClipsDescendants = true

    if collapsible then
        local chev = make("TextButton", head, "Chevron")
        chev.Size = UDim2.fromOffset(18, 18)
        chev.Position = UDim2.new(1, -18, 0, 0)
        chev.BackgroundTransparency = 1
        chev.Text = "▾"
        chev.Font = Enum.Font.GothamBold
        chev.TextSize = 12
        chev.TextColor3 = CONFIG.MUTED
        chev.AutoButtonColor = false
        local open = true
        chev.Activated:Connect(function()
            open = not open
            if open then card.Visible = true end
            tween(chev, 0.2, { Rotation = open and 0 or 180 })
            local tw = tween(card, 0.22, { Size = UDim2.new(1, 0, 0, open and cardHeight or 0) })
            if not open then
                tw.Completed:Once(function()
                    if not open then card.Visible = false end
                end)
            end
        end)
    end
    return sec, head, card, ttl
end

-- 1. Import Workspace ----------------------------------------
local wsHead = make("Frame", content, "WorkspaceHead")
wsHead.BackgroundTransparency = 1
wsHead.Size = UDim2.new(1, 0, 0, 36)
wsHead.LayoutOrder = 1
local wsTitle = label(wsHead, "Title", "Import Workspace", UDim2.new(1, -72, 0, 18), UDim2.new(), Enum.Font.GothamBold, CONFIG.TEXT, 14)
table.insert(pulseLabels, wsTitle)
local wsFolder = label(wsHead, "Folder", "Folder: " .. CONFIG.FOLDER .. "/", UDim2.new(1, -72, 0, 12), UDim2.fromOffset(0, 21), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
local jsonOnlyBadge = badge(wsHead, "JSON ONLY", UDim2.fromOffset(62, 18), UDim2.new(1, -62, 0, 0))

-- 2. Stats ---------------------------------------------------
local statsRow = make("Frame", content, "Stats")
statsRow.BackgroundTransparency = 1
statsRow.Size = UDim2.new(1, 0, 0, 52)
statsRow.LayoutOrder = 2
local statsGrid = make("UIGridLayout", statsRow)
statsGrid.CellSize = UDim2.new(1 / 3, -4, 0, 52)
statsGrid.CellPadding = UDim2.fromOffset(5, 0)
statsGrid.SortOrder = Enum.SortOrder.LayoutOrder

local function statCard(order, image, valueText, caption)
    local c = makeCard(statsRow, "Stat" .. order, UDim2.new())
    c.LayoutOrder = order
    icon(c, "Icon", image, 13, UDim2.fromOffset(10, 8), WHITE)
    local v = label(c, "Value", valueText, UDim2.new(1, -20, 0, 16), UDim2.fromOffset(10, 22), Enum.Font.GothamBold, CONFIG.TEXT, 13)
    label(c, "Caption", caption, UDim2.new(1, -20, 0, 10), UDim2.fromOffset(10, 39), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
    table.insert(pulseLabels, v)
    return v
end
local statFiles = statCard(1, Icon.List, "00", "Files found")
local statSelected = statCard(2, Icon.Checklis, "00", "Selected")
local statSize = statCard(3, Icon.FileCode, "--", "Total size")

-- 3. JSON Files header --------------------------------------
local filesHead = make("Frame", content, "FilesHead")
filesHead.BackgroundTransparency = 1
filesHead.Size = UDim2.new(1, 0, 0, 20)
filesHead.LayoutOrder = 3
local filesTitle = label(filesHead, "Title", "JSON Files", UDim2.new(1, -90, 1, 0), UDim2.new(), Enum.Font.GothamBold, CONFIG.TEXT, 12)
table.insert(pulseLabels, filesTitle)
local clearButton = make("TextButton", filesHead, "ClearSelection")
clearButton.Size = UDim2.fromOffset(86, 18)
clearButton.Position = UDim2.new(1, -86, 0, 1)
clearButton.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
clearButton.BorderSizePixel = 0
clearButton.AutoButtonColor = false
clearButton.Text = "Clear selection"
clearButton.Font = Enum.Font.GothamMedium
clearButton.TextSize = 9
clearButton.TextColor3 = CONFIG.TEXT
corner(clearButton, 9)
stroke(clearButton, WHITE, 0.7, 1)
pressable(clearButton)

-- 4. Files card (folder row + search + list) ----------------
local FILES_OPEN_H, FILES_CLOSED_H = 184, 36
local filesCard = makeCard(content, "FilesCard", UDim2.new(1, 0, 0, FILES_OPEN_H))
filesCard.LayoutOrder = 4
filesCard.ClipsDescendants = true

local folderRow = make("TextButton", filesCard, "FolderRow")
folderRow.Size = UDim2.new(1, 0, 0, 36)
folderRow.BackgroundTransparency = 1
folderRow.Text = ""
folderRow.AutoButtonColor = false
icon(folderRow, "Icon", Icon.List, 16, UDim2.fromOffset(10, 10), WHITE)
local folderName = label(folderRow, "Name", CONFIG.FOLDER, UDim2.new(1, -66, 0, 14), UDim2.fromOffset(34, 5), Enum.Font.GothamBold, CONFIG.TEXT, 11)
local folderSub = label(folderRow, "Sub", "0 files · local executor storage", UDim2.new(1, -66, 0, 11), UDim2.fromOffset(34, 20), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
local folderChevron = label(folderRow, "Chevron", "▾", UDim2.fromOffset(18, 18), UDim2.new(1, -26, 0, 9), Enum.Font.GothamBold, CONFIG.MUTED, 12)
folderChevron.TextXAlignment = Enum.TextXAlignment.Center

local folderLine = make("Frame", filesCard, "Line")
folderLine.Position = UDim2.fromOffset(0, 36)
folderLine.Size = UDim2.new(1, 0, 0, 1)
folderLine.BackgroundColor3 = WHITE
folderLine.BackgroundTransparency = 0.9
folderLine.BorderSizePixel = 0

local filesOpen = true
folderRow.Activated:Connect(function()
    filesOpen = not filesOpen
    tween(folderChevron, 0.2, { Rotation = filesOpen and 0 or 180 })
    tween(filesCard, 0.22, { Size = UDim2.new(1, 0, 0, filesOpen and FILES_OPEN_H or FILES_CLOSED_H) })
end)

local searchFrame = make("Frame", filesCard, "SearchFrame")
searchFrame.Position = UDim2.fromOffset(8, 43)
searchFrame.Size = UDim2.new(1, -16, 0, 24)
searchFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
searchFrame.BorderSizePixel = 0
corner(searchFrame, 6)
local searchStroke = stroke(searchFrame, WHITE, 0.9, 1)
icon(searchFrame, "Icon", Icon.Search, 12, UDim2.fromOffset(8, 6), CONFIG.MUTED)
local searchBox = make("TextBox", searchFrame, "SearchBox")
searchBox.BackgroundTransparency = 1
searchBox.Position = UDim2.fromOffset(26, 0)
searchBox.Size = UDim2.new(1, -34, 1, 0)
searchBox.Text = ""
searchBox.PlaceholderText = "Search JSON files..."
searchBox.PlaceholderColor3 = CONFIG.MUTED
searchBox.TextColor3 = CONFIG.TEXT
searchBox.Font = Enum.Font.GothamMedium
searchBox.TextSize = 10
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.BorderSizePixel = 0
searchBox.Focused:Connect(function() tween(searchStroke, 0.2, { Transparency = 0.5 }) end)
searchBox.FocusLost:Connect(function() tween(searchStroke, 0.2, { Transparency = 0.9 }) end)

local fileList = make("ScrollingFrame", filesCard, "FileList")
fileList.Position = UDim2.fromOffset(3, 73)
fileList.Size = UDim2.new(1, -6, 0, 104)
fileList.BackgroundTransparency = 1
fileList.BorderSizePixel = 0
fileList.ScrollBarThickness = 2
fileList.ScrollBarImageColor3 = WHITE
fileList.ScrollBarImageTransparency = 0.5
fileList.ScrollingDirection = Enum.ScrollingDirection.Y
fileList.CanvasSize = UDim2.new()
fileList.AutomaticCanvasSize = Enum.AutomaticSize.Y
local filePadding = make("UIPadding", fileList)
filePadding.PaddingTop = UDim.new(0, 5)
filePadding.PaddingLeft = UDim.new(0, 5)
filePadding.PaddingRight = UDim.new(0, 5)
filePadding.PaddingBottom = UDim.new(0, 5)
local fileLayout = make("UIListLayout", fileList)
fileLayout.Padding = UDim.new(0, 4)
fileLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- 5. Buttons -------------------------------------------------
local actionRow = make("Frame", content, "Actions")
actionRow.BackgroundTransparency = 1
actionRow.Size = UDim2.new(1, 0, 0, 32)
actionRow.LayoutOrder = 5

local function actionButton(name, image, text, position, light)
    local b = make("TextButton", actionRow, name)
    b.Size = UDim2.new(0.5, -3, 1, 0)
    b.Position = position
    b.BackgroundColor3 = light and Color3.fromRGB(70, 70, 70) or Color3.fromRGB(16, 16, 16)
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Text = ""
    corner(b, 16)
    local s = stroke(b, WHITE, light and 0.55 or 0.6, 1)
    if light then gradient(b, Color3.fromRGB(110, 110, 110), Color3.fromRGB(50, 50, 50), 90) end
    local inner = make("Frame", b, "Inner")
    inner.BackgroundTransparency = 1
    inner.Size = UDim2.fromScale(1, 1)
    local lay = make("UIListLayout", inner)
    lay.FillDirection = Enum.FillDirection.Horizontal
    lay.HorizontalAlignment = Enum.HorizontalAlignment.Center
    lay.VerticalAlignment = Enum.VerticalAlignment.Center
    lay.Padding = UDim.new(0, 6)
    local ic = icon(inner, "Icon", image, 14, UDim2.new(), WHITE)
    local txt = label(inner, "Text", text, UDim2.new(0, 0, 0, 14), UDim2.new(), Enum.Font.GothamBold, CONFIG.TEXT, 10)
    txt.AutomaticSize = Enum.AutomaticSize.X
    txt.TextTruncate = Enum.TextTruncate.None
    pressable(b)
    return b, ic, txt, s
end

local scanButton, scanIcon = actionButton("Scan", Icon.Refresh, "Scan JSON", UDim2.new(), false)
local importButton, importIcon, importText = actionButton("Import", Icon.Import, "Import (0)", UDim2.new(0.5, 3, 0, 0), true)
importButton.BackgroundTransparency = 0.5

-- 6. File Preview --------------------------------------------
local _, _, pvCard = makeSection(6, "File Preview", 104, true)
local pvIconBox = make("Frame", pvCard, "IconBox")
pvIconBox.Position = UDim2.fromOffset(10, 10)
pvIconBox.Size = UDim2.fromOffset(26, 26)
pvIconBox.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
pvIconBox.BorderSizePixel = 0
corner(pvIconBox, 6)
icon(pvIconBox, "Icon", Icon.FileCode, 14, UDim2.fromOffset(6, 6), BLACK)
local pvName = label(pvCard, "Name", "No file selected", UDim2.new(1, -120, 0, 14), UDim2.fromOffset(44, 10), Enum.Font.GothamBold, CONFIG.TEXT, 11)
label(pvCard, "Sub", "JSON document overview", UDim2.new(1, -120, 0, 11), UDim2.fromOffset(44, 25), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
local _, pvBadgeText = badge(pvCard, "IDLE", UDim2.fromOffset(50, 18), UDim2.new(1, -60, 0, 14))

local function statBox(position, caption, value)
    local f = make("Frame", pvCard, "Box")
    f.Position = position
    f.Size = UDim2.new(0.5, -13, 0, 34)
    f.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
    f.BorderSizePixel = 0
    corner(f, 6)
    label(f, "Caption", caption, UDim2.new(1, -16, 0, 11), UDim2.fromOffset(8, 4), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
    return label(f, "Value", value, UDim2.new(1, -16, 0, 14), UDim2.fromOffset(8, 17), Enum.Font.GothamBold, CONFIG.TEXT, 11)
end
local pvRoots = statBox(UDim2.fromOffset(10, 46), "Root objects", "--")
local pvValid = statBox(UDim2.new(0.5, 3, 0, 46), "Validation", "Pending")
local pvNote = label(pvCard, "Note", "Values are read from the selected JSON file.", UDim2.new(1, -20, 0, 12), UDim2.fromOffset(10, 86), Enum.Font.GothamMedium, CONFIG.MUTED, 9)

-- 7. Import Process ------------------------------------------
local _, _, prCard = makeSection(7, "Import Process", 112, false)
prCard.AutomaticSize = Enum.AutomaticSize.Y
prCard.ClipsDescendants = false

local function stepRow(y, image, titleText, subText, badgeText)
    icon(prCard, "Icon", image, 14, UDim2.fromOffset(10, y + 6), WHITE)
    label(prCard, "StepTitle", titleText, UDim2.new(1, -112, 0, 13), UDim2.fromOffset(34, y), Enum.Font.GothamBold, CONFIG.TEXT, 11)
    local sub = label(prCard, "StepSub", subText, UDim2.new(1, -112, 0, 11), UDim2.fromOffset(34, y + 15), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
    local _, bl = badge(prCard, badgeText, UDim2.fromOffset(52, 18), UDim2.new(1, -62, 0, y + 6))
    return sub, bl
end
local _, folderBadgeText = stepRow(8, Icon.Checklis, "Folder initialized", CONFIG.FOLDER .. " directory", "READY")
local valSub, valBadgeText = stepRow(40, Icon.Search, "JSON validation", "Waiting for scan / import", "IDLE")

label(prCard, "ProgressLabel", "Overall progress", UDim2.new(0.5, -10, 0, 11), UDim2.fromOffset(10, 74), Enum.Font.GothamMedium, CONFIG.TEXT, 9)
local progressPct = label(prCard, "ProgressPct", "0%", UDim2.new(0.5, -10, 0, 11), UDim2.new(0.5, 0, 0, 74), Enum.Font.GothamBold, CONFIG.TEXT, 9)
progressPct.TextXAlignment = Enum.TextXAlignment.Right
local progressBg = make("Frame", prCard, "ProgressBg")
progressBg.Position = UDim2.fromOffset(10, 90)
progressBg.Size = UDim2.new(1, -20, 0, 6)
progressBg.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
progressBg.BorderSizePixel = 0
corner(progressBg, 3)
local progressFill = make("Frame", progressBg, "Fill")
progressFill.Size = UDim2.fromScale(0, 1)
progressFill.BackgroundColor3 = WHITE
progressFill.BorderSizePixel = 0
corner(progressFill, 3)
local progressGradient = make("UIGradient", progressFill)
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 120, 120)),
    ColorSequenceKeypoint.new(0.5, WHITE),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120)),
})

local statusLabel = label(prCard, "Status", "Status output will show validation errors, object creation, and completion details.",
    UDim2.new(1, -20, 0, 0), UDim2.fromOffset(10, 102), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
statusLabel.TextWrapped = true
statusLabel.TextTruncate = Enum.TextTruncate.None
statusLabel.TextYAlignment = Enum.TextYAlignment.Top
statusLabel.AutomaticSize = Enum.AutomaticSize.Y
local statusPad = make("UIPadding", statusLabel)
statusPad.PaddingBottom = UDim.new(0, 8)

-- 8. Quick Guide ---------------------------------------------
local _, _, qgCard = makeSection(8, "Quick Guide", 102, true)
local guideSteps = {
    { Icon.List, "1. Prepare files", "Place UI JSON files inside the Import-UI folder." },
    { Icon.Checklis, "2. Select files", "Tick only the files you want to import." },
    { Icon.Import, "3. Validate and import", "Review validation and process status before finishing." },
}
for index, step in ipairs(guideSteps) do
    local col = make("Frame", qgCard, "Step" .. index)
    col.BackgroundTransparency = 1
    col.Position = UDim2.new((index - 1) / 3, 0, 0, 0)
    col.Size = UDim2.new(1 / 3, 0, 1, 0)
    icon(col, "Icon", step[1], 14, UDim2.fromOffset(8, 9), WHITE)
    local t = label(col, "Title", step[2], UDim2.new(1, -14, 0, 22), UDim2.fromOffset(8, 28), Enum.Font.GothamBold, CONFIG.TEXT, 9)
    t.TextWrapped = true
    t.TextTruncate = Enum.TextTruncate.None
    t.TextYAlignment = Enum.TextYAlignment.Top
    local d = label(col, "Desc", step[3], UDim2.new(1, -14, 0, 46), UDim2.fromOffset(8, 52), Enum.Font.GothamMedium, CONFIG.MUTED, 8)
    d.TextWrapped = true
    d.TextTruncate = Enum.TextTruncate.None
    d.TextYAlignment = Enum.TextYAlignment.Top
    if index > 1 then
        local sep = make("Frame", col, "Sep")
        sep.Size = UDim2.new(0, 1, 0.7, 0)
        sep.Position = UDim2.fromScale(0, 0.15)
        sep.BackgroundColor3 = WHITE
        sep.BackgroundTransparency = 0.9
        sep.BorderSizePixel = 0
    end
end

-- 9. Footer --------------------------------------------------
local footer = make("Frame", content, "Footer")
footer.BackgroundTransparency = 1
footer.Size = UDim2.new(1, 0, 0, 24)
footer.LayoutOrder = 9
local footerLine = make("Frame", footer, "Line")
footerLine.Size = UDim2.new(1, 0, 0, 1)
footerLine.BackgroundColor3 = WHITE
footerLine.BackgroundTransparency = 0.9
footerLine.BorderSizePixel = 0
label(footer, "Left", "NARS EDV · UI IMPORTER", UDim2.new(0.6, 0, 0, 14), UDim2.fromOffset(0, 9), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
local footerRight = label(footer, "Right", "Monochrome UI", UDim2.new(0.4, 0, 0, 14), UDim2.new(0.6, 0, 0, 9), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
footerRight.TextXAlignment = Enum.TextXAlignment.Right

-- ============================================================
-- State & behaviour
-- ============================================================
local filesCache = {}
local selected = {}
local focusFile = nil
local rows = {}
local busy = false
local scanning = false

-- progress animation (NumberValue -> fill + persen)
local progressValue = Instance.new("NumberValue")
progressValue.Changed:Connect(function(v)
    progressFill.Size = UDim2.fromScale(math.clamp(v, 0, 1), 1)
    progressPct.Text = math.floor(math.clamp(v, 0, 1) * 100 + 0.5) .. "%"
end)
local function setProgress(p, duration)
    if duration and duration > 0 then
        tween(progressValue, duration, { Value = p }, Enum.EasingStyle.Quad)
    else
        progressValue.Value = p
    end
end

local function setStatus(text, color)
    statusLabel.Text = tostring(text)
    statusLabel.TextColor3 = color or CONFIG.MUTED
    statusLabel.TextTransparency = 1
    tween(statusLabel, 0.25, { TextTransparency = 0 })
end

local function getSelectedFiles()
    local list = {}
    for _, file in ipairs(filesCache) do
        if selected[file.path] then table.insert(list, file) end
    end
    return list
end

local function refreshStats()
    local list = getSelectedFiles()
    local totalBytes = 0
    for _, file in ipairs(list) do totalBytes += file.bytes or 0 end
    statFiles.Text = ("%02d"):format(#filesCache)
    statSelected.Text = ("%02d"):format(#list)
    statSize.Text = #list > 0 and formatSize(totalBytes) or "--"
    importText.Text = ("Import (%d)"):format(#list)
    tween(importButton, 0.2, { BackgroundTransparency = #list > 0 and 0 or 0.5 })
    folderSub.Text = ("%d files · local executor storage"):format(#filesCache)
    wsFolder.Text = "Folder: " .. CONFIG.FOLDER .. "/"
    folderName.Text = CONFIG.FOLDER
end

local function setRowState(path, on, animate)
    local r = rows[path]
    if not r then return end
    local t = animate and 0.2 or 0
    tween(r.circle, t, { BackgroundColor3 = on and WHITE or Color3.fromRGB(30, 30, 30) })
    tween(r.circleStroke, t, { Transparency = on and 1 or 0.4 })
    if on then
        r.tick.Size = UDim2.fromOffset(0, 0)
        tween(r.tick, animate and 0.28 or 0, { Size = UDim2.fromOffset(10, 10) }, Enum.EasingStyle.Back)
    else
        tween(r.tick, t, { Size = UDim2.fromOffset(0, 0) })
    end
    tween(r.right, t, { ImageTransparency = on and 0 or 1 })
    tween(r.stroke, t, { Transparency = on and 0.4 or 0.9 })
    tween(r.button, t, { BackgroundColor3 = on and ROW_ON or ROW_IDLE })
end

local function loadPreview(file)
    focusFile = file
    if not file then
        pvName.Text = "No file selected"
        pvRoots.Text = "--"
        pvValid.Text = "Pending"
        setBadge(pvBadgeText, "IDLE", CONFIG.TEXT)
        setBadge(valBadgeText, "IDLE", CONFIG.TEXT)
        valSub.Text = "Waiting for scan / import"
        return
    end
    pvName.Text = file.name
    pvRoots.Text = "--"
    pvValid.Text = "Pending"
    setBadge(pvBadgeText, "...", CONFIG.MUTED)

    local okRead, raw = pcall(FS.readfile, file.path)
    if not okRead or type(raw) ~= "string" then
        pvValid.Text = "Error"
        setBadge(pvBadgeText, "ERROR", CONFIG.RED)
        setStatus("Gagal membaca file: " .. file.name, CONFIG.RED)
        warn("[NARS Importer] Gagal membaca file: " .. file.name)
        return
    end
    if #raw > CONFIG.MAX_FILE_BYTES then
        pvValid.Text = "Too large"
        setBadge(pvBadgeText, "ERROR", CONFIG.RED)
        setStatus(("File terlalu besar: %.2f MB"):format(#raw / 1048576), CONFIG.RED)
        warn("[NARS Importer] File terlalu besar: " .. file.name)
        return
    end
    if not Services.HttpService then
        pvValid.Text = "Error"
        setBadge(pvBadgeText, "ERROR", CONFIG.RED)
        setStatus("HttpService tidak tersedia untuk JSONDecode.", CONFIG.RED)
        warn("[NARS Importer] HttpService tidak tersedia.")
        return
    end
    local okDecode, doc = pcall(function() return Services.HttpService:JSONDecode(raw) end)
    if not okDecode then
        pvValid.Text = "Invalid"
        setBadge(pvBadgeText, "ERROR", CONFIG.RED)
        setBadge(valBadgeText, "FAILED", CONFIG.RED)
        valSub.Text = "JSON tidak valid"
        setStatus("JSON tidak valid: " .. tostring(doc), CONFIG.RED)
        warn("[NARS Importer] JSON tidak valid (" .. file.name .. "): " .. tostring(doc))
        return
    end
    local valid, err, nodes = validateDocument(doc)
    if not valid then
        pvRoots.Text = type(doc) == "table" and type(doc.objects) == "table" and tostring(#doc.objects) or "--"
        pvValid.Text = "Invalid"
        setBadge(pvBadgeText, "ERROR", CONFIG.RED)
        setBadge(valBadgeText, "FAILED", CONFIG.RED)
        valSub.Text = "Validation failed"
        setStatus("VALIDASI GAGAL\n" .. tostring(err), CONFIG.RED)
        warn("[NARS Importer] Validasi gagal (" .. file.name .. "): " .. tostring(err))
        return
    end
    pvRoots.Text = tostring(#doc.objects)
    pvValid.Text = "Valid"
    setBadge(pvBadgeText, "READY", CONFIG.GREEN)
    setBadge(valBadgeText, "IDLE", CONFIG.TEXT)
    valSub.Text = "Waiting for scan / import"
    pvNote.Text = ("%s · %d nodes · target %s"):format(tostring(doc.projectName or file.name), nodes or 0, CONFIG.IMPORT_PARENT)
    setStatus(("PROJECT  %s\nNODES  %d  •  ROOTS  %d\nDESTINATION  %s"):format(
        tostring(doc.projectName or file.name), nodes or 0, #doc.objects, CONFIG.IMPORT_PARENT), CONFIG.GREEN)
end

local function inspectFile(file)
    file.objects = nil
    file.valid = nil
    if not Services.HttpService then return end
    local okRead, raw = pcall(FS.readfile, file.path)
    if not okRead or type(raw) ~= "string" or #raw > CONFIG.MAX_FILE_BYTES then return end
    local okDecode, doc = pcall(function() return Services.HttpService:JSONDecode(raw) end)
    if not okDecode then file.valid = false return end
    local valid, _, count = validateDocument(doc)
    file.valid = valid
    if count then file.objects = count end
end

local function applyFilter()
    local q = lower(trim(searchBox.Text))
    for _, file in ipairs(filesCache) do
        local r = rows[file.path]
        if r then
            r.button.Visible = q == "" or lower(file.name):find(q, 1, true) ~= nil
        end
    end
end
searchBox:GetPropertyChangedSignal("Text"):Connect(applyFilter)

local function toggleFile(file)
    if busy then return end
    local on = not selected[file.path]
    selected[file.path] = on or nil
    setRowState(file.path, on, true)
    refreshStats()
    if on then
        loadPreview(file)
    elseif focusFile == file then
        local list = getSelectedFiles()
        loadPreview(list[#list])
    end
end

local function clearFileRows()
    for _, child in ipairs(fileList:GetChildren()) do
        if child:IsA("TextButton") or child.Name == "Empty" then safeDestroy(child) end
    end
    rows = {}
end

local function buildRow(file, index)
    local b = make("TextButton", fileList, "File_" .. index)
    b.Size = UDim2.new(1, 0, 0, 40)
    b.BackgroundColor3 = ROW_IDLE
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Text = ""
    b.LayoutOrder = index
    corner(b, 7)
    local st = stroke(b, WHITE, 0.9, 1)

    local circle = make("Frame", b, "Circle")
    circle.Position = UDim2.fromOffset(9, 12)
    circle.Size = UDim2.fromOffset(16, 16)
    circle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    circle.BorderSizePixel = 0
    corner(circle, 8)
    local circleStroke = stroke(circle, WHITE, 0.4, 1)
    local tick = make("ImageLabel", circle, "Tick")
    tick.BackgroundTransparency = 1
    tick.Image = Icon.Checklis
    tick.ImageColor3 = BLACK
    tick.AnchorPoint = Vector2.new(0.5, 0.5)
    tick.Position = UDim2.fromScale(0.5, 0.5)
    tick.Size = UDim2.fromOffset(0, 0)
    tick.ScaleType = Enum.ScaleType.Fit

    local fileBox = make("Frame", b, "FileBox")
    fileBox.Position = UDim2.fromOffset(34, 7)
    fileBox.Size = UDim2.fromOffset(26, 26)
    fileBox.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
    fileBox.BorderSizePixel = 0
    corner(fileBox, 6)
    icon(fileBox, "Icon", Icon.FileCode, 14, UDim2.fromOffset(6, 6), BLACK)

    local nameLabel = label(b, "Name", file.name, UDim2.new(1, -104, 0, 14), UDim2.fromOffset(68, 6), Enum.Font.GothamBold, CONFIG.TEXT, 10)
    local metaText = formatSize(file.bytes) .. " · " .. (file.objects and (file.objects .. " objects") or (file.valid == false and "invalid" or "-- objects"))
    local metaLabel = label(b, "Meta", metaText, UDim2.new(1, -104, 0, 12), UDim2.fromOffset(68, 22), Enum.Font.GothamMedium, CONFIG.MUTED, 9)

    local right = make("ImageLabel", b, "Selected")
    right.BackgroundTransparency = 1
    right.Image = Icon.Checklis
    right.ImageColor3 = WHITE
    right.ImageTransparency = 1
    right.Size = UDim2.fromOffset(14, 14)
    right.Position = UDim2.new(1, -24, 0.5, -7)
    right.ScaleType = Enum.ScaleType.Fit

    rows[file.path] = { button = b, stroke = st, circle = circle, circleStroke = circleStroke, tick = tick, right = right }

    b.MouseEnter:Connect(function()
        if not selected[file.path] then tween(st, 0.15, { Transparency = 0.65 }) end
    end)
    b.MouseLeave:Connect(function()
        if not selected[file.path] then tween(st, 0.15, { Transparency = 0.9 }) end
    end)
    b.Activated:Connect(function() toggleFile(file) end)

    -- animasi muncul
    b.BackgroundTransparency = 1
    nameLabel.TextTransparency = 1
    metaLabel.TextTransparency = 1
    task.delay(math.min(index, 8) * 0.04, function()
        tween(b, 0.25, { BackgroundTransparency = 0 })
        tween(nameLabel, 0.25, { TextTransparency = 0 })
        tween(metaLabel, 0.25, { TextTransparency = 0 })
    end)
end

local function renderFiles(files)
    filesCache = files or {}
    local keep = {}
    for _, file in ipairs(filesCache) do
        if selected[file.path] then keep[file.path] = true end
    end
    selected = keep
    clearFileRows()

    if #filesCache == 0 then
        local empty = label(fileList, "Empty", "Tidak ada .json di folder ini.", UDim2.new(1, 0, 0, 28), UDim2.new(), Enum.Font.GothamMedium, CONFIG.MUTED, 9)
        empty.TextXAlignment = Enum.TextXAlignment.Center
    else
        for index, file in ipairs(filesCache) do
            buildRow(file, index)
            if selected[file.path] then setRowState(file.path, true, false) end
        end
    end
    applyFilter()
    refreshStats()
    local list = getSelectedFiles()
    loadPreview(list[#list])
end

local function doScan()
    if scanning or busy then return end
    scanning = true
    scanIcon.Rotation = 0
    local spin = tween(scanIcon, 0.7, { Rotation = 360 }, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    setBadge(valBadgeText, "SCAN", CONFIG.TEXT)
    valSub.Text = "Scanning " .. CONFIG.FOLDER .. "/"

    local files, err = scanJsonFiles()
    if files then
        for _, file in ipairs(files) do inspectFile(file) end
    end
    task.wait(0.7)
    scanIcon.Rotation = 0
    spin:Cancel()

    if not files then
        renderFiles({})
        setBadge(valBadgeText, "FAILED", CONFIG.RED)
        valSub.Text = "Scan failed"
        setStatus(err, CONFIG.RED)
        warn("[NARS Importer] " .. tostring(err))
    else
        renderFiles(files)
        setBadge(valBadgeText, "IDLE", CONFIG.TEXT)
        valSub.Text = "Waiting for scan / import"
        setProgress(0, 0.3)
        if #files == 0 then
            setStatus("Tidak ditemukan file .json.\nPastikan path folder benar: " .. CONFIG.FOLDER, CONFIG.YELLOW)
        else
            setStatus(("Ditemukan %d file JSON.\nPilih file lalu tekan Import."):format(#files), CONFIG.GREEN)
        end
    end
    scanning = false
end

local function doImport()
    if busy or scanning then return end
    local list = getSelectedFiles()
    if #list == 0 then
        setStatus("Pilih file JSON terlebih dahulu.", CONFIG.YELLOW)
        return
    end
    if not Services.HttpService then
        setStatus("HttpService tidak tersedia untuk JSONDecode.", CONFIG.RED)
        warn("[NARS Importer] HttpService tidak tersedia.")
        return
    end

    busy = true
    importText.Text = "Importing..."
    setProgress(0, 0)
    setBadge(valBadgeText, "RUNNING", CONFIG.TEXT)
    valSub.Text = "Validating and building objects"
    setStatus("Memproses " .. #list .. " file...", CONFIG.MUTED)

    local total = #list
    local function stage(i, frac)
        setProgress(((i - 1) + frac) / total, 0.18)
        task.wait(0.2)
    end

    local function processFile(file, i)
        stage(i, 0.15)
        local okRead, raw = pcall(FS.readfile, file.path)
        if not okRead or type(raw) ~= "string" then
            return false, "Tidak bisa membaca file: " .. file.name
        end
        if #raw > CONFIG.MAX_FILE_BYTES then
            return false, "File melewati batas 5 MB: " .. file.name
        end
        stage(i, 0.4)
        local okDecode, doc = pcall(function() return Services.HttpService:JSONDecode(raw) end)
        if not okDecode then
            return false, "JSONDecode gagal (" .. file.name .. "): " .. tostring(doc)
        end
        stage(i, 0.65)
        local okImport, result = importDocument(doc, file.name)
        stage(i, 1)
        if not okImport then
            return false, file.name .. ": " .. tostring(result)
        end
        return true, result
    end

    local okCount, failCount = 0, 0
    local nodes, roots, props, warnCount, errCount, skipped = 0, 0, 0, 0, 0, 0
    local failures, details = {}, {}
    local destination = CONFIG.IMPORT_PARENT

    for i, file in ipairs(list) do
        local ok, result = processFile(file, i)
        if ok then
            okCount += 1
            nodes += result.importedNodes
            roots += result.roots
            props += result.properties
            warnCount += result.warnings
            errCount += result.errors
            skipped += result.skippedScripts
            destination = result.destination
            for _, d in ipairs(result.details) do table.insert(details, d) end
        else
            failCount += 1
            table.insert(failures, tostring(result))
        end
    end

    setProgress(1, 0.2)

    if failCount == 0 then
        setBadge(valBadgeText, "DONE", CONFIG.GREEN)
        valSub.Text = "Import completed"
        setStatus(("IMPORT SELESAI\n%d file • Nodes %d • Roots %d • Props %d\nWarnings %d • Errors %d • Scripts skipped %d\nTarget: %s"):format(
            okCount, nodes, roots, props, warnCount, errCount, skipped, destination),
            errCount > 0 and CONFIG.YELLOW or CONFIG.GREEN)
    else
        setBadge(valBadgeText, "FAILED", CONFIG.RED)
        valSub.Text = "Import has errors"
        setStatus(("IMPORT GAGAL\n%d berhasil • %d gagal\n%s"):format(okCount, failCount, table.concat(failures, "\n")), CONFIG.RED)
        for _, msg in ipairs(failures) do
            warn("[NARS Importer] " .. msg)
        end
    end
    if errCount > 0 then
        for _, detail in ipairs(details) do
            warn("[NARS Importer] " .. detail)
        end
    end

    busy = false
    refreshStats()
end

scanButton.Activated:Connect(function() task.spawn(doScan) end)
importButton.Activated:Connect(function() task.spawn(doImport) end)
clearButton.Activated:Connect(function()
    if busy then return end
    for path in pairs(selected) do setRowState(path, false, true) end
    selected = {}
    refreshStats()
    loadPreview(nil)
    setProgress(0, 0.3)
    setStatus("Seleksi dibersihkan.", CONFIG.MUTED)
end)

-- window controls (minimal / maximize / close) ---------------
local mode, prevMode = "normal", "normal"
local function getMaxSize()
    local camera = workspace.CurrentCamera
    local vp = camera and camera.ViewportSize or Vector2.new(800, 600)
    return Vector2.new(math.clamp(vp.X - 24, 270, 340), math.clamp(vp.Y - 24, 240, 440))
end

local function setMode(newMode)
    mode = newMode
    if newMode == "min" then
        local width = panel.AbsoluteSize.X / math.max(panelScale.Scale, 0.01)
        tween(panel, 0.22, { Size = UDim2.new(0, width, 0, HEADER_H) }, Enum.EasingStyle.Quint)
        task.delay(0.2, function()
            if mode == "min" then content.Visible = false end
        end)
    else
        content.Visible = true
        local size = newMode == "max" and getMaxSize() or NORMAL_SIZE
        tween(panel, 0.28, { Size = UDim2.new(0, size.X, 0, size.Y) }, Enum.EasingStyle.Quint)
    end
end

minimizeButton.Activated:Connect(function()
    if mode == "min" then
        setMode(prevMode)
    else
        prevMode = mode
        setMode("min")
    end
end)
maximizeButton.Activated:Connect(function()
    if mode == "max" then setMode("normal") else setMode("max") end
end)
closeButton.Activated:Connect(function()
    tween(panelScale, 0.18, { Scale = 0.85 }, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.delay(0.2, function() safeDestroy(gui) end)
end)

-- drag -------------------------------------------------------
do
    local dragging = false
    local dragStart, startPos
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
           or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = panel.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    local dragConn = UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
           or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    gui.Destroying:Connect(function() dragConn:Disconnect() end)
end

-- ambient animations -----------------------------------------
do
    -- gradient outline & glow berputar
    TweenService:Create(outlineGradient, TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Rotation = 360 }):Play()
    TweenService:Create(glowGradient, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Rotation = 405 }):Play()
    TweenService:Create(progressGradient, TweenInfo.new(1.6, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), { Offset = Vector2.new(0.4, 0) }):Play()
    progressGradient.Offset = Vector2.new(-0.4, 0)

    -- glow berdenyut
    pulse(glow, "BackgroundTransparency", 0.93, 0.8, 1.8)
    pulse(outline, "Transparency", 0.55, 0.15, 1.8)

    -- teks redup-nyala (title + kandidat teks sejenis)
    for index, obj in ipairs(pulseLabels) do
        pulse(obj, "TextTransparency", 0, 0.4, 1.5, (index - 1) * 0.15)
    end

    -- animasi masuk
    tween(panelScale, 0.35, { Scale = 1 }, Enum.EasingStyle.Back)
end

refreshStats()
task.spawn(doScan)
