-- Importer File | rbxm-rbxl-rbxlx 
-- Creator NarsEdv  |  Link Discord 

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService       = game:GetService("HttpService")
local InsertService     = game:GetService("InsertService")
local TweenService      = game:GetService("TweenService")
local UIS               = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local ENV = _G
pcall(function()
    if type(getgenv) == "function" then
        ENV = getgenv()
    end
end)

local function getFn(name: string)
    local f
    pcall(function() f = ENV[name] end)
    if type(f) == "function" then return f end
    pcall(function()
        if type(getfenv) == "function" then f = getfenv()[name] end
    end)
    if type(f) == "function" then return f end
    pcall(function() f = _G[name] end)
    if type(f) == "function" then return f end
    return nil
end

local listfiles        = getFn("listfiles")
local readfile         = getFn("readfile")
local isfile           = getFn("isfile")
local isfolder         = getFn("isfolder")
local getcustomasset   = getFn("getcustomasset")
local toclipboard      = getFn("setclipboard") or getFn("toclipboard")
local identifyexecutor = getFn("identifyexecutor") or getFn("getexecutorname")

local executorName = "--"
pcall(function()
    if identifyexecutor then
        local id = identifyexecutor()
        if type(id) == "string" and #id > 0 then
            executorName = id
        end
    end
end)

local RAW_SOURCES = {}

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
    local bytes = {}

    for i = 1, 32 do
        bytes[i] = string.char(math.random(0, 255))
    end

    return "_narsedv_" .. table.concat(bytes)
end

local LogicalName = setmetatable({}, { __mode = "k" })
local Renamed = setmetatable({}, { __mode = "k" })

local function applyName(inst, logical)
    if logical ~= nil then LogicalName[inst] = logical end
    Renamed[inst] = true
    local name = generateName()
    local ok = pcall(function() inst.Name = name end)
    local same = false
    pcall(function() same = (inst.Name == name) end)
    if not ok or not same then
        pcall(function()
            inst.Name = "_narsedv_" .. (HttpService:GenerateGUID(false):gsub("-", ""))
        end)
    end
end

local REG_KEY = "__NarsEdvImporterGui"

pcall(function()
    local prev = ENV[REG_KEY]
    ENV[REG_KEY] = nil
    if typeof(prev) == "Instance" then
        prev:Destroy()
    end
end)

pcall(function()
    for _, child in ipairs(host:GetChildren()) do
        if child.Name == "NarsRbxImporter" or child.Name == "NarsEdvImporter" then
            child:Destroy()
        end
    end
end)

local Icon = {
    Logo = "rbxassetid://122926744824622",
    Banner = "rbxassetid://123479937842693",
    Minimize = "rbxassetid://122268389930903",
    Maximize = "rbxassetid://136612013728069",
    Close = "rbxassetid://6031094678",
    Discord = "rbxassetid://124918347913410",
    File = "rbxassetid://119264004071690",
    Checklist = "rbxassetid://93898873302694",
    Expand = "rbxassetid://136612013728069",
    Collapse = "rbxassetid://117796781690923",
    Scan = "rbxassetid://138133190015277",
    Import = "rbxassetid://93307473217005",
    Clear = "rbxassetid://133957773112410",
    Search = "rbxassetid://91918048389224",
    Folder = "rbxassetid://101394054141166",
    Info = "rbxassetid://88424087003035",
    Storage = "rbxassetid://88183305858463",
    Identify = "rbxassetid://76231597751076",
    ImportWorkspace = "rbxassetid://76231597751076",
    ThemeMono = "rbxassetid://83380517901735",
    ThemeLight = "rbxassetid://110150589884127",
}

local function Buffer(str, allowOverflows)
    local s = { Offset = 0, Source = str, Length = #str, AllowOverflows = (allowOverflows == nil and true) or allowOverflows }
    function s:read(len, shift)
        len = len or 1
        shift = (shift == nil and true) or shift
        local d = string.sub(self.Source, self.Offset + 1, self.Offset + len)
        if shift then self:seek(len) end
        return d
    end
    function s:seek(len)
        self.Offset = math.clamp(self.Offset + len, 0, self.Length)
    end
    function s:readNumber(fmt, shift)
        fmt = fmt or "I1"
        local c = self:read(string.packsize(fmt), shift)
        return string.unpack(fmt, c)
    end
    function s:append(str2)
        self.Source = self.Source .. str2
        self.Length = #self.Source
    end
    function s:toEnd()
        self.Offset = self.Length
    end
    return s
end

local function transformInt(x)
    return (x % 2 == 0) and (x / 2) or (-(x + 1) / 2)
end

local function rbxF32(x)
    x = bit32.rrotate(x, 1)
    return string.unpack(">f", string.pack(">I4", x))
end

local bt = {}
function bt.String(b)
    return b:read(b:readNumber("<I4"))
end
function bt.Int32(b)
    return transformInt(b:readNumber(">I4"))
end
function bt.Int64(b)
    return transformInt(b:readNumber(">I8"))
end
function bt.Float32(b)
    return rbxF32(b:readNumber(">I4"))
end
function bt.InterleaveArrayWithSize(b, count, sizeof)
    if count < 0 then return Buffer("", false) end
    local stream = b:read(count * sizeof)
    local out = table.create(count)
    for i = 1, count do
        local chunk = table.create(sizeof)
        for s2 = 0, sizeof - 1 do
            local bp = i + (count * s2)
            chunk[s2 + 1] = string.sub(stream, bp, bp)
        end
        out[i] = table.concat(chunk)
    end
    return Buffer(table.concat(out), false)
end
function bt.Int32Array(b, count)
    if count < 1 then return {} end
    local o = table.create(count)
    local s2 = bt.InterleaveArrayWithSize(b, count, 4)
    for i = 1, count do
        o[i] = bt.Int32(s2)
    end
    return o
end
function bt.RefArray(b, count)
    if count < 1 then return {} end
    local o = table.create(count)
    local refs = bt.Int32Array(b, count)
    local last = 0
    for i = 1, count do
        local ref = last + refs[i]
        o[i] = ref
        last = ref
    end
    return o
end

local function b64encode(str)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local out = {}
    for i = 1, #str, 3 do
        local b0, b1, b2 = string.byte(str, i, i + 2)
        local b = bit32.lshift(b0, 16) + bit32.lshift(b1 or 0, 8) + (b2 or 0)
        table.insert(out, chars:sub(bit32.extract(b, 18, 6) + 1, bit32.extract(b, 18, 6) + 1))
        table.insert(out, chars:sub(bit32.extract(b, 12, 6) + 1, bit32.extract(b, 12, 6) + 1))
        table.insert(out, b1 and chars:sub(bit32.extract(b, 6, 6) + 1, bit32.extract(b, 6, 6) + 1) or "=")
        table.insert(out, b2 and chars:sub(bit32.band(b, 63) + 1, bit32.band(b, 63) + 1) or "=")
    end
    return table.concat(out)
end

local function zstdDecompress(stream)
    local z64 = b64encode(stream)
    local json = '{"m":null,"t":"buffer","zbase64":"' .. z64 .. '"}'
    return buffer.tostring(HttpService:JSONDecode(json))
end

local function lz4Decompress(lz4data)
    local inp = Buffer(lz4data)
    local compressedLen = string.unpack("<I4", inp:read(4))
    local decompressedLen = string.unpack("<I4", inp:read(4))
    local reserved = string.unpack("<I4", inp:read(4))
    if reserved ~= 0 then error("not lz4") end
    if compressedLen == 0 then return inp:read(decompressedLen) end
    local out = Buffer("")
    repeat
        local token = string.byte(inp:read())
        local litLen = bit32.rshift(token, 4)
        local matLen = bit32.band(token, 15) + 4
        if litLen >= 15 then
            repeat
                local nb = string.byte(inp:read())
                litLen = litLen + nb
            until nb ~= 0xFF
        end
        local literal = inp:read(litLen)
        out:append(literal)
        out:toEnd()
        if out.Length < decompressedLen then
            local offset = string.unpack("<I2", inp:read(2))
            if matLen >= 19 then
                repeat
                    local nb = string.byte(inp:read())
                    matLen = matLen + nb
                until nb ~= 0xFF
            end
            out:seek(-offset)
            local pos = out.Offset
            local match = out:read(matLen)
            local unread = out.LastUnreadBytes or 0
            if unread then
                repeat
                    out.Offset = pos
                    local extra = out:read(unread)
                    unread = out.LastUnreadBytes or 0
                    match = match .. extra
                until unread <= 0
            end
            out:append(match)
            out:toEnd()
        end
    until out.Length >= decompressedLen
    return out.Source
end

local function parseRBXMForSources(data)
    local sources = {}
    local rb = Buffer(data, false)
    if rb:read(8) ~= "<roblox!" or rb:read(6) ~= string.char(137, 255, 13, 10, 26, 10) then return sources end
    if rb:read(2) ~= (string.char(0) .. string.char(0)) then return sources end
    local classRefs, virtualInstances, chunkInfo = {}, {}, {}
    local _EC = "END" .. string.char(0)
    local valid = { [_EC] = true, ["INST"] = true, ["META"] = true, ["PRNT"] = true, ["PROP"] = true, ["SIGN"] = true, ["SSTR"] = true }
    for k in pairs(valid) do chunkInfo[k] = {} end
    if rb:read(8) ~= string.char(0, 0, 0, 0, 0, 0, 0, 0) then return sources end
    local last_chunk = nil
    repeat
        local chunk = { Header = rb:read(4) }
        if not valid[chunk.Header] then return sources end
        local lz4h = rb:read(16, false)
        local compressed = string.unpack("<I4", string.sub(lz4h, 1, 4))
        local decompressed = string.unpack("<I4", string.sub(lz4h, 5, 8))
        local zstd_check = string.sub(lz4h, 13, 16)
        local dataChunk
        if compressed == 0 then
            dataChunk = rb:read(decompressed + 12)
        else
            if zstd_check == string.char(40, 181, 47, 253) then
                rb:seek(12)
                dataChunk = zstdDecompress(rb:read(compressed))
            else
                dataChunk = lz4Decompress(rb:read(compressed + 12))
            end
        end
        chunk.Data = Buffer(dataChunk, false)
        table.insert(chunkInfo[chunk.Header], chunk)
        last_chunk = chunk
    until last_chunk and last_chunk.Header == _EC

    for _, chunk in ipairs(chunkInfo["INST"] or {}) do
        local b = chunk.Data
        local classID = b:readNumber("<I4")
        local className = bt.String(b)
        if b:read() ~= "\1" then
            local count = b:readNumber("<I4")
            local refs = bt.RefArray(b, count)
            classRefs[classID] = { Name = className, Sizeof = count, Refs = refs }
            for _, ref in ipairs(refs) do
                virtualInstances[ref] = { ClassId = classID, ClassName = className, Ref = ref, Properties = {}, Children = {} }
            end
        end
    end

    for _, chunk in ipairs(chunkInfo["PROP"] or {}) do
        local b = chunk.Data
        local classID = b:readNumber("<I4")
        local classref = classRefs[classID]
        if classref then
            local refs = classref.Refs
            local sizeof = classref.Sizeof
            local name = bt.String(b)
            if string.byte(b:read(1, false)) == 0x1E then b:seek(1) end
            local typeID = string.byte(b:read())
            local props = {}
            if typeID == 0x01 or typeID == 0x1D then
                for i = 1, sizeof do props[i] = bt.String(b) end
            end
            if name == "Source" or name == "ContentText" then
                for i, v in ipairs(refs) do
                    if virtualInstances[v] and props[i] then
                        virtualInstances[v].Properties[name] = props[i]
                    end
                end
            end
        end
    end

    for _, chunk in ipairs(chunkInfo["PRNT"] or {}) do
        local b = chunk.Data
        if b:read() == string.char(0) then
            local count = b:readNumber("<I4")
            local child_refs = bt.RefArray(b, count)
            local parent_refs = bt.RefArray(b, count)
            for i = 1, count do
                local child = virtualInstances[child_refs[i]]
                local par = virtualInstances[parent_refs[i]]
                if child and par then table.insert(par.Children, child) end
            end
        end
    end

    local function buildSourceMap(node, path)
        local src = node.Properties["Source"] or node.Properties["ContentText"]
        if src and type(src) == "string" and #src > 0 then sources[path] = src end
        for _, child in ipairs(node.Children or {}) do
            buildSourceMap(child, path .. "." .. child.ClassName .. ":" .. (child.Properties["Name"] or "unnamed"))
        end
    end

    local roots = {}
    for _, inst in pairs(virtualInstances) do
        local hasParent = false
        for _, other in pairs(virtualInstances) do
            for _, child in ipairs(other.Children or {}) do
                if child.Ref == inst.Ref then hasParent = true; break end
            end
            if hasParent then break end
        end
        if not hasParent then table.insert(roots, inst) end
    end
    for _, root in ipairs(roots) do
        buildSourceMap(root, root.ClassName .. ":" .. (root.Properties["Name"] or "root"))
    end
    return sources
end

local slFolder    = ReplicatedStorage:FindFirstChild("StudioLiteFolder")
local serverFuncs = slFolder and slFolder:FindFirstChild("ServerFunctions")
local SL_CACHE    = {}

local function triggerServerLoad(idStr)
    if not serverFuncs or not idStr or idStr == "" then return end
    local id = tostring(idStr):match("%d+")
    if id then
        pcall(function() serverFuncs:InvokeServer("LoadMeshToRuntimeMeshes", tonumber(id)) end)
    end
end

local function injectStudioLiteUI(scr, sourceMap)
    if not scr:IsA("LuaSourceContainer") then return end
    local path = scr.ClassName .. ":" .. scr.Name
    local realSource = sourceMap and sourceMap[path]
    if not realSource then pcall(function() realSource = scr.Source end) end
    if realSource and #realSource > 0 then
        realSource = realSource:gsub(string.char(0) .. "*$", "")
    else
        realSource = "-- [Nars Importer] Source extracted"
    end
    RAW_SOURCES[scr] = realSource

    local UI_TEXT = realSource
    if #UI_TEXT > 150000 then
        UI_TEXT = "-- [Nars Importer Warning] Source code too long.\n\n" .. string.sub(UI_TEXT, 1, 150000) .. "\n\n... [TRUNCATED]"
    end

    local existingTB = scr:FindFirstChild("SL_CodeTextBox")
    if existingTB then
        existingTB.Text = UI_TEXT
        if scr.ClassName == "ModuleScript" then
            local ro = scr:FindFirstChild("SL_1ReadOnly")
            if ro then ro.ContentText = UI_TEXT; ro.Text = UI_TEXT end
        end
        return
    end

    if not serverFuncs then return end
    local map = { Script = "InsertScriptScript", LocalScript = "InsertLocalScriptLocalScript", ModuleScript = "InsertModuleScriptModuleScript" }
    local assetName = map[scr.ClassName]
    if not assetName then return end

    if not SL_CACHE[assetName] then
        pcall(function()
            serverFuncs:InvokeServer("LoadAssetToPlayerGui", assetName)
            local guiF = Player:WaitForChild("PlayerGui"):WaitForChild(assetName, 3)
            if guiF then
                SL_CACHE[assetName] = {}
                for _, c in ipairs(guiF:GetChildren()) do
                    table.insert(SL_CACHE[assetName], c:Clone())
                end
                serverFuncs:InvokeServer("ClearAssetFromPlayerGui", assetName)
            end
        end)
    end
    if not SL_CACHE[assetName] then return end

    pcall(function()
        for _, c in ipairs(SL_CACHE[assetName]) do c:Clone().Parent = scr end
        local tb = scr:FindFirstChild("SL_CodeTextBox")
        if tb then
            tb.Text = UI_TEXT
            if scr.ClassName == "ModuleScript" then
                local ro = scr:FindFirstChild("SL_1ReadOnly")
                if ro then ro.ContentText = UI_TEXT; ro.Text = UI_TEXT end
            end
        end
    end)
end

local function injectAllScripts(root, sourceMap)
    if not root then return end
    local list = {}
    if root:IsA("LuaSourceContainer") then table.insert(list, root) end
    for _, d in ipairs(root:GetDescendants()) do
        if d:IsA("LuaSourceContainer") then table.insert(list, d) end
    end
    for _, s in ipairs(list) do
        pcall(injectStudioLiteUI, s, sourceMap)
        task.wait(0.01)
    end
end

local function ApplyStudioLiteProperties(obj)
    if not obj then return end
    pcall(function()
        if obj:IsA("BasePart") then
            local oa = obj.Anchored
            local oc = obj.CanCollide
            obj.Anchored = true
            if obj:GetAttribute("SL_Anchored") == nil then obj:SetAttribute("SL_Anchored", oa) end
            if obj:GetAttribute("SL_CanCollide") == nil then obj:SetAttribute("SL_CanCollide", oc) end
        end
    end)
    for _, child in ipairs(obj:GetChildren()) do
        ApplyStudioLiteProperties(child)
    end
end

local function LoadAssetsToSLServer(obj)
    local function scan(node)
        pcall(function()
            if node:IsA("MeshPart") then
                triggerServerLoad(node.MeshId)
                triggerServerLoad(node.TextureID)
            elseif node:IsA("Decal") or node:IsA("Texture") then
                triggerServerLoad(node.Texture)
            elseif node:IsA("SpecialMesh") then
                triggerServerLoad(node.MeshId)
                triggerServerLoad(node.TextureId)
            elseif node:IsA("Clothing") or node:IsA("ShirtGraphic") then
                triggerServerLoad(node.ClassName == "ShirtGraphic" and node.Graphic or node[node.ClassName .. "Template"])
            elseif node:IsA("UnionOperation") or node:IsA("PartOperation") then
                triggerServerLoad(node.AssetId)
            end
        end)
        for _, child in ipairs(node:GetChildren()) do
            scan(child)
        end
    end
    scan(obj)
end

local SVC_MAP = {
    Workspace = workspace,
    ReplicatedStorage = ReplicatedStorage,
    ReplicatedFirst = game:GetService("ReplicatedFirst"),
    StarterGui = game:GetService("StarterGui"),
    StarterPack = game:GetService("StarterPack"),
    StarterPlayer = game:GetService("StarterPlayer"),
    Lighting = game:GetService("Lighting"),
    SoundService = game:GetService("SoundService"),
    ServerScriptService = _G.sss or ReplicatedStorage,
    ServerStorage = _G.ss or ReplicatedStorage,
    Teams = ReplicatedStorage,
    Chat = ReplicatedStorage
}

local ImportSignal = setmetatable({}, { __mode = "k" })

local function insertObjects(objects, isRbxl, sourceMap)
    local count = 0
    for _, obj in ipairs(objects) do
        pcall(function()
            local target = (isRbxl and (SVC_MAP[obj.ClassName] or SVC_MAP[obj.Name])) or workspace
            if target == workspace and obj:IsA("Service") then target = ReplicatedStorage end
            if isRbxl and target ~= workspace then
                for _, ch in ipairs(obj:GetChildren()) do
                    pcall(function()
                        ch.Parent = target
                        ImportSignal[coroutine.running()] = true
                        injectAllScripts(ch, sourceMap)
                        ApplyStudioLiteProperties(ch)
                        LoadAssetsToSLServer(ch)
                        count = count + 1
                    end)
                    task.wait(0.01)
                end
            else
                obj.Parent = target
                ImportSignal[coroutine.running()] = true
                injectAllScripts(obj, sourceMap)
                ApplyStudioLiteProperties(obj)
                LoadAssetsToSLServer(obj)
                count = count + 1
            end
        end)
    end
    return count
end

local function httpRequest(url, method, headers, data)
    method = method or "GET"
    headers = headers or {}
    local fns = {
        function()
            if syn and syn.request then
                local r = syn.request({ Url = url, Method = method, Headers = headers, Body = data })
                return r.Body, r.StatusCode
            end
        end,
        function()
            if request then
                local r = request({ Url = url, Method = method, Headers = headers, Body = data })
                return r.Body, r.StatusCode
            end
        end,
        function()
            if http_request then
                local r = http_request({ Url = url, Method = method, Headers = headers, Body = data })
                return r.Body, r.StatusCode
            end
        end,
        function()
            return game:HttpGet(url, true), 200
        end
    }
    for _, fn in ipairs(fns) do
        local ok, body, status = pcall(fn)
        if ok and body and type(body) == "string" and #body > 0 then
            return body, status or 200
        end
    end
    return nil, nil
end

local function loadFile(fileInfo)
    local ftype = fileInfo.type or fileInfo.ftype or ""
    local isRbxl = (ftype == "RBXL" or ftype == "RBXLX")
    if not readfile then return false, "readfile() unavailable" end
    local ok, data = pcall(readfile, fileInfo.path)
    if not ok or type(data) ~= "string" or #data == 0 then
        return false, "readfile failed: " .. tostring(data)
    end

    local sourceMap = {}
    if not isRbxl then
        local parseOk, sources = pcall(parseRBXMForSources, data)
        if parseOk and sources then sourceMap = sources end
    end

    if getcustomasset then
        local ok1, aid = pcall(getcustomasset, fileInfo.path)
        if ok1 and aid then
            local ok2, objs = pcall(function() return game:GetObjects(aid) end)
            if ok2 and objs and #objs > 0 then
                return true, insertObjects(objs, isRbxl, sourceMap) .. " object(s) via getcustomasset"
            end
        end
    end

    local ok3, objs3 = pcall(function() return game:GetObjects("rbxasset://" .. fileInfo.path) end)
    if ok3 and objs3 and #objs3 > 0 then
        return true, insertObjects(objs3, isRbxl, sourceMap) .. " object(s) via rbxasset"
    end

    if ftype == "RBXMX" or ftype == "RBXL" or ftype == "RBXLX" then
        local fn = getFn("loadrbxmx") or getFn("loadasset")
        if fn then
            local ok4, model = pcall(fn, data)
            if ok4 and model then
                pcall(function() model.Parent = workspace end)
                ImportSignal[coroutine.running()] = true
                injectAllScripts(model, sourceMap)
                ApplyStudioLiteProperties(model)
                LoadAssetsToSLServer(model)
                return true, "1 object(s) loaded via loadrbxmx"
            end
        end
        if data:find("<roblox", 1, true) then
            return false, "RBXMX/RBXLX format valid but no insertion API supported by executor"
        end
        return false, "RBXMX/RBXLX invalid or corrupt"
    else
        local fn = getFn("loadrbxm") or getFn("readrbxm")
        if fn then
            local ok5, model = pcall(fn, data)
            if ok5 and model then
                pcall(function() model.Parent = workspace end)
                ImportSignal[coroutine.running()] = true
                injectAllScripts(model, sourceMap)
                ApplyStudioLiteProperties(model)
                LoadAssetsToSLServer(model)
                return true, "1 object(s) loaded via loadrbxm"
            end
        end

        local assetId = fileInfo.path:match("(%d+)") or ""
        if #assetId > 0 then
            local body, _ = httpRequest("https://assetdelivery.roblox.com/v1/asset/?id=" .. assetId, "GET", {})
            if body and #body > 0 then
                local okH, objsH = pcall(function() return game:GetObjects("rbxassetid://" .. assetId) end)
                if okH and objsH and #objsH > 0 then
                    return true, insertObjects(objsH, isRbxl, sourceMap) .. " object(s) via rbxassetid"
                end
            end
        end

        return false, "Load methods exhausted. getcustomasset=" .. (getcustomasset and "ok" or "fail") .. " loadrbxm=" .. (getFn("loadrbxm") and "ok" or "fail")
    end
end

local scannedFiles = {}
local selectedFiles = {}

local ROOT_PATHS = {
    "Delta/Workspace", "Delta/Workspace/", "delta/workspace", "delta/workspace/",
    "Android/Delta/Workspace", "Android/Delta/Workspace/",
    "/sdcard/Delta/Workspace", "/sdcard/Android/Delta/Workspace",
    "workspace", "workspace/", "Workspace", "Workspace/", "../workspace", ".", ""
}

local function normPath(p)
    p = tostring(p or ""):gsub("\\", "/")
    while p:find("//", 1, true) do p = p:gsub("//", "/") end
    if p:sub(-1) == "/" and #p > 1 then p = p:sub(1, -2) end
    return p
end

local function getFileName(p)
    return normPath(p):match("([^/]+)$") or p
end

local function getFileType(name)
    local n = name:lower()
    if n:match("%.rbxlx$") then return "RBXLX" end
    if n:match("%.rbxl$")  then return "RBXL" end
    if n:match("%.rbxmx$") then return "RBXMX" end
    if n:match("%.rbxm$")  then return "RBXM" end
    return nil
end

local function looksLikeFolder(p)
    return not getFileName(p):match("%.[%a%d]+$")
end

local function safeList(p)
    if not listfiles then return nil end
    local ok, r = pcall(listfiles, p)
    return (ok and type(r) == "table") and r or nil
end

local function formatBytes(b)
    if not b or b <= 0 then return "0.0 MB" end
    if b < 1024 * 1024 then
        return string.format("%.1f KB", b / 1024)
    end
    return string.format("%.1f MB", b / (1024 * 1024))
end

local ScanState = { last = os.clock() }

local function scanYield()
    if os.clock() - ScanState.last >= 0.012 then
        task.wait()
        ScanState.last = os.clock()
    end
end

local function walkDir(path, depth, results, seen)
    if depth > 6 then return end
    local np = normPath(path)
    if seen[np] then return end
    seen[np] = true
    local items = safeList(path)
    if not items then return end
    for _, raw in ipairs(items) do
        scanYield()
        local p = normPath(raw)
        local ext = getFileType(getFileName(p))
        if ext then
            local key = p:lower()
            if not seen[key] then
                local valid = true
                if isfile then
                    local ok2, val = pcall(isfile, p)
                    if ok2 and val == false then valid = false end
                end
                if valid then
                    seen[key] = true
                    table.insert(results, { name = getFileName(p), path = p, type = ext, size = 0 })
                end
            end
        else
            local isDir, known = false, false
            if isfolder then
                local ok3, val = pcall(isfolder, p)
                if ok3 then
                    known = true
                    isDir = val and true or false
                end
            end
            if not known and safeList(p) then isDir = true end
            if isDir or looksLikeFolder(p) then
                walkDir(p, depth + 1, results, seen)
            end
        end
    end
end

local function scanFiles()
    scannedFiles = {}
    selectedFiles = {}
    if not listfiles then return false, "listfiles() unavailable" end
    local seen = {}
    local results = {}
    local usedPath = nil
    ScanState.last = os.clock()
    for _, root in ipairs(ROOT_PATHS) do
        scanYield()
        local items = safeList(root)
        if items then
            if not usedPath then usedPath = root end
            walkDir(root, (root == "." or root == "") and 3 or 0, results, seen)
            if #results > 0 then break end
        end
    end
    table.sort(results, function(a, b) return a.name:lower() < b.name:lower() end)
    scannedFiles = results
    return true, nil, usedPath
end

task.spawn(function()
    if getFn("hookmetamethod") then
        local hookmetamethod = getFn("hookmetamethod")
        local getnamecallmethod = getFn("getnamecallmethod")
        local checkcaller = getFn("checkcaller")
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod and getnamecallmethod() or ""
            local args = { ... }
            if checkcaller and not checkcaller() and method == "InvokeServer" then
                if self.Name == "GetScriptSourceServerFunction" then
                    local target = tostring(args[1])
                    for obj, src in pairs(RAW_SOURCES) do
                        if typeof(obj) == "Instance" and (obj.ClassName .. obj.Name) == target then
                            if src and src ~= "" then return src end
                        end
                    end
                end
                if self.Name == "SaveScriptSourceServerFunction" then
                    local target = tostring(args[1])
                    local newSource = tostring(args[2])
                    for obj, _ in pairs(RAW_SOURCES) do
                        if typeof(obj) == "Instance" and (obj.ClassName .. obj.Name) == target then
                            RAW_SOURCES[obj] = newSource
                            break
                        end
                    end
                end
            end
            return oldNamecall(self, ...)
        end)
    end

    if getFn("hookfunction") then
        local hookfunction = getFn("hookfunction")
        local getrenv = getFn("getrenv")
        local oldRequire
        pcall(function()
            oldRequire = hookfunction((getrenv and getrenv() or {}).require or require, function(module)
                if typeof(module) == "Instance" and module:IsA("ModuleScript") then
                    local src = RAW_SOURCES[module]
                    if src and src ~= "" then
                        local func, err = loadstring(src)
                        if func then
                            local success, result = pcall(func)
                            if success then return result end
                        end
                    end
                end
                return oldRequire(module)
            end)
        end)

        local oldGetObjects
        pcall(function()
            oldGetObjects = hookfunction(game.GetObjects, function(self, url, ...)
                local assetId = tostring(url):match("%d+")
                if assetId then triggerServerLoad(assetId) end
                local objects = oldGetObjects(self, url, ...)
                if objects then
                    for _, obj in ipairs(objects) do
                        pcall(function() injectAllScripts(obj, {}) end)
                        pcall(function() ApplyStudioLiteProperties(obj) end)
                        pcall(function() LoadAssetsToSLServer(obj) end)
                    end
                end
                return objects
            end)
        end)
    end
end)

local rgb = Color3.fromRGB
local WHITE = Color3.new(1, 1, 1)

local function CS(...)
    local points = {}
    for _, p in ipairs({ ... }) do
        points[#points + 1] = ColorSequenceKeypoint.new(p[1], rgb(p[2], p[3], p[4]))
    end
    return ColorSequence.new(points)
end

local Palettes = {
    Monochrome = {
        panelGrad = CS({ 0, 36, 36, 42 }, { 0.08, 26, 26, 30 }, { 0.5, 17, 17, 21 }, { 0.95, 12, 12, 15 }, { 1, 22, 22, 26 }),
        headerGrad = CS({ 0, 34, 34, 40 }, { 0.2, 25, 25, 29 }, { 1, 16, 16, 20 }),
        headerLine = rgb(42, 42, 50),
        cardGrad = CS({ 0, 36, 36, 44 }, { 0.1, 26, 26, 31 }, { 0.5, 20, 20, 24 }, { 1, 14, 14, 18 }),
        cardStroke = rgb(48, 48, 58),
        inner = rgb(14, 14, 18),
        innerStroke = rgb(42, 42, 50),
        list = rgb(11, 11, 14),
        bannerBg = rgb(10, 10, 12),
        text = rgb(250, 250, 252),
        textSub = rgb(165, 165, 175),
        textDim = rgb(120, 120, 135),
        icon = rgb(200, 200, 210),
        iconDim = rgb(130, 130, 142),
        iconHover = rgb(255, 255, 255),
        placeholder = rgb(95, 95, 110),
        scroll = rgb(65, 65, 75),
        overlay = rgb(255, 255, 255),
        overlayWhite = rgb(255, 255, 255),
        focusStroke = rgb(175, 175, 195),
        scanGrad = CS({ 0, 34, 34, 42 }, { 1, 18, 18, 24 }),
        scanStroke = rgb(90, 90, 110),
        scanText = rgb(235, 235, 245),
        scanOverlay = rgb(255, 255, 255),
        importGrad = CS({ 0, 255, 255, 255 }, { 1, 232, 232, 236 }),
        importText = rgb(15, 15, 20),
        importOverlay = rgb(0, 0, 0),
        tabIdle = rgb(16, 16, 20),
        tabActive = rgb(34, 34, 44),
        tabIdleText = rgb(140, 140, 155),
        tabActiveText = rgb(255, 255, 255),
        tabIdleStroke = rgb(40, 40, 48),
        tabActiveStroke = rgb(225, 225, 238),
        item = rgb(18, 18, 22),
        itemSel = rgb(30, 30, 40),
        itemStroke = rgb(42, 42, 52),
        itemSelStroke = rgb(215, 215, 228),
        checkBg = rgb(22, 22, 28),
        checkOnBg = rgb(245, 245, 250),
        checkStroke = rgb(80, 80, 95),
        checkMark = rgb(15, 15, 20),
        bar1 = rgb(190, 190, 200),
        bar2 = rgb(120, 120, 130),
        bar3 = rgb(70, 70, 80),
        barBg = rgb(26, 26, 32),
        barFill = rgb(235, 235, 245),
    },
    Light = {
        panelGrad = CS({ 0, 255, 255, 255 }, { 0.08, 250, 250, 253 }, { 0.5, 244, 244, 248 }, { 0.95, 238, 238, 243 }, { 1, 244, 244, 249 }),
        headerGrad = CS({ 0, 255, 255, 255 }, { 0.2, 248, 248, 252 }, { 1, 238, 238, 244 }),
        headerLine = rgb(215, 215, 225),
        cardGrad = CS({ 0, 255, 255, 255 }, { 0.1, 252, 252, 254 }, { 0.5, 248, 248, 251 }, { 1, 242, 242, 247 }),
        cardStroke = rgb(214, 214, 224),
        inner = rgb(240, 240, 246),
        innerStroke = rgb(214, 214, 226),
        list = rgb(234, 234, 240),
        bannerBg = rgb(225, 225, 232),
        text = rgb(15, 15, 20),
        textSub = rgb(50, 50, 62),
        textDim = rgb(95, 95, 110),
        icon = rgb(15, 15, 20),
        iconDim = rgb(80, 80, 95),
        iconHover = rgb(0, 0, 0),
        placeholder = rgb(120, 120, 135),
        scroll = rgb(170, 170, 182),
        overlay = rgb(0, 0, 0),
        overlayWhite = rgb(255, 255, 255),
        focusStroke = rgb(25, 25, 32),
        scanGrad = CS({ 0, 252, 252, 255 }, { 1, 230, 230, 238 }),
        scanStroke = rgb(150, 150, 165),
        scanText = rgb(15, 15, 20),
        scanOverlay = rgb(0, 0, 0),
        importGrad = CS({ 0, 30, 30, 36 }, { 1, 10, 10, 14 }),
        importText = rgb(255, 255, 255),
        importOverlay = rgb(255, 255, 255),
        tabIdle = rgb(240, 240, 246),
        tabActive = rgb(214, 218, 232),
        tabIdleText = rgb(90, 90, 105),
        tabActiveText = rgb(15, 15, 20),
        tabIdleStroke = rgb(214, 214, 226),
        tabActiveStroke = rgb(20, 20, 28),
        item = rgb(255, 255, 255),
        itemSel = rgb(222, 226, 240),
        itemStroke = rgb(214, 214, 226),
        itemSelStroke = rgb(30, 30, 40),
        checkBg = rgb(232, 232, 238),
        checkOnBg = rgb(15, 15, 20),
        checkStroke = rgb(150, 150, 168),
        checkMark = rgb(255, 255, 255),
        bar1 = rgb(165, 165, 178),
        bar2 = rgb(95, 95, 108),
        bar3 = rgb(22, 22, 28),
        barBg = rgb(222, 222, 230),
        barFill = rgb(22, 22, 28),
    },
}

local currentTheme = "Monochrome"
local ThemeBindings = {}
local ThemeRefreshers = {}
local FileCardRefreshers = {}

local function palette()
    return Palettes[currentTheme]
end

local function bind(inst, prop, key)
    ThemeBindings[#ThemeBindings + 1] = { inst = inst, prop = prop, key = key }
    inst[prop] = palette()[key]
end

local function registerRefresher(fn)
    ThemeRefreshers[#ThemeRefreshers + 1] = fn
end

local function new(class, props)
    local inst = Instance.new(class)
    local parent = nil
    local logical = nil
    for k, v in pairs(props or {}) do
        if k == "Parent" then
            parent = v
        elseif k == "Name" then
            logical = v
        else
            inst[k] = v
        end
    end
    if class == "TextLabel" or class == "TextButton" or class == "TextBox" then
        inst.Font = Enum.Font.GothamMedium
    end
    applyName(inst, logical or class)
    if parent then inst.Parent = parent end
    return inst
end

local function merge(base, extra)
    for k, v in pairs(extra or {}) do base[k] = v end
    return base
end

local function setProps(inst, props, animate, info)
    if animate then
        TweenService:Create(inst, info or TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    else
        for k, v in pairs(props) do inst[k] = v end
    end
end

local function corner(parent, radius)
    return new("UICorner", { CornerRadius = UDim.new(0, radius), Parent = parent })
end

local function stroke(parent, thickness, key)
    local s = new("UIStroke", {
        Thickness = thickness,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = parent,
    })
    if key then bind(s, "Color", key) end
    return s
end

local function gradient(parent, key, rotation)
    local g = new("UIGradient", { Rotation = rotation or 90, Parent = parent })
    bind(g, "Color", key)
    return g
end

local function list(parent, padding, direction)
    return new("UIListLayout", {
        Padding = UDim.new(0, padding or 0),
        FillDirection = direction or Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = parent,
    })
end

local function padding(parent, top, bottom, left, right)
    return new("UIPadding", {
        PaddingTop = UDim.new(0, top or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
        PaddingRight = UDim.new(0, right or 0),
        Parent = parent,
    })
end

local function label(parent, props, colorKey)
    local l = new("TextLabel", merge({
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = parent,
    }, props))
    bind(l, "TextColor3", colorKey)
    return l
end

local function icon(parent, image, size, colorKey, props)
    local i = new("ImageLabel", merge({
        Size = UDim2.fromOffset(size, size),
        BackgroundTransparency = 1,
        Image = image,
        Parent = parent,
    }, props))
    bind(i, "ImageColor3", colorKey)
    return i
end

local HOVER_INFO = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local PRESS_INFO = TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function isPointerInput(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end

local function addButtonFeedback(btn, overlayKey, radius, hoverAlpha, pressScale)
    hoverAlpha = hoverAlpha or 0.9
    pressScale = pressScale or 0.97
    local scale = new("UIScale", { Scale = 1, Parent = btn })
    local overlay = new("Frame", {
        Name = "Overlay",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = btn.ZIndex,
        Parent = btn,
    })
    bind(overlay, "BackgroundColor3", overlayKey)
    corner(overlay, radius)

    local hovering, pressed = false, false
    local function update()
        local alpha = pressed and (hoverAlpha - 0.1) or (hovering and hoverAlpha or 1)
        TweenService:Create(overlay, HOVER_INFO, { BackgroundTransparency = alpha }):Play()
        TweenService:Create(scale, PRESS_INFO, { Scale = pressed and pressScale or 1 }):Play()
    end

    btn.MouseEnter:Connect(function()
        hovering = true
        update()
    end)
    btn.MouseLeave:Connect(function()
        hovering = false
        pressed = false
        update()
    end)
    btn.InputBegan:Connect(function(input)
        if isPointerInput(input) then
            pressed = true
            update()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if isPointerInput(input) then
            pressed = false
            update()
        end
    end)
    return overlay
end

local function addIconFeedback(btn)
    local scale = new("UIScale", { Scale = 1, Parent = btn })
    local hovering, pressed = false, false
    local function update()
        local P = palette()
        TweenService:Create(btn, HOVER_INFO, {
            BackgroundTransparency = pressed and 0.8 or (hovering and 0.9 or 1),
            ImageColor3 = (hovering or pressed) and P.iconHover or P.icon,
        }):Play()
        TweenService:Create(scale, PRESS_INFO, { Scale = pressed and 0.88 or 1 }):Play()
    end
    btn.MouseEnter:Connect(function()
        hovering = true
        update()
    end)
    btn.MouseLeave:Connect(function()
        hovering = false
        pressed = false
        update()
    end)
    btn.InputBegan:Connect(function(input)
        if isPointerInput(input) then
            pressed = true
            update()
        end
    end)
    btn.InputEnded:Connect(function(input)
        if isPointerInput(input) then
            pressed = false
            update()
        end
    end)
end

local ScreenGui = new("ScreenGui", {
    Name = "NarsEdvImporter",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = host,
})
pcall(function() ENV[REG_KEY] = ScreenGui end)

local PANEL_NORMAL_SIZE = UDim2.new(0, 270, 0, 320)
local PANEL_HEADER_HEIGHT = 36
local PANEL_MIN_SIZE = UDim2.new(0, 270, 0, PANEL_HEADER_HEIGHT)
local CARD_HEADER_HEIGHT = 26
local FILE_CARD_HEIGHT = 46
local FILE_LIST_HEIGHT = 140

local Panel = new("Frame", {
    Name = "MainPanel",
    Size = PANEL_NORMAL_SIZE,
    Position = UDim2.new(0, 50, 0, 78),
    BackgroundColor3 = WHITE,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = ScreenGui,
})
local MainUICorner = corner(Panel, 8)
gradient(Panel, "panelGrad", 90)

pcall(function()
    local UIShadow = Instance.new("UIShadow")
    applyName(UIShadow, "UIShadow")
    UIShadow.ZIndex = -1
    UIShadow.BlurRadius = UDim.new(0, 12)
    UIShadow.Color = Color3.fromRGB(0, 0, 0)
    UIShadow.Enabled = true
    UIShadow.Offset = UDim2.fromOffset(0, 4)
    UIShadow.Spread = UDim2.fromScale(0, 0)
    UIShadow.Transparency = 0.5
    UIShadow.Parent = Panel
end)

local Header = new("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, PANEL_HEADER_HEIGHT),
    BackgroundColor3 = WHITE,
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = Panel,
})
local HeaderCorner = corner(Header, 8)
pcall(function()
    HeaderCorner.BottomLeftRadius = UDim.new(0, 0)
    HeaderCorner.BottomRightRadius = UDim.new(0, 0)
end)
gradient(Header, "headerGrad", 90)

local HeaderBorder = new("Frame", {
    Name = "HeaderBorder",
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, -1),
    BorderSizePixel = 0,
    ZIndex = 11,
    Parent = Header,
})
bind(HeaderBorder, "BackgroundColor3", "headerLine")

icon(Header, Icon.Logo, 18, "icon", {
    Name = "Logo",
    Position = UDim2.new(0, 10, 0.5, -9),
    ZIndex = 12,
})

label(Header, {
    Name = "Title",
    Size = UDim2.new(1, -110, 1, 0),
    Position = UDim2.new(0, 34, 0, 0),
    Text = "Nars Edv Importer",
    TextSize = 14,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 12,
}, "text")

local function createHeaderButton(name, image, xOffset)
    local btn = new("ImageButton", {
        Name = name,
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(1, xOffset, 0.5, -7),
        BackgroundTransparency = 1,
        Image = image,
        AutoButtonColor = false,
        ZIndex = 12,
        Parent = Header,
    })
    bind(btn, "BackgroundColor3", "overlay")
    bind(btn, "ImageColor3", "icon")
    corner(btn, 4)
    addIconFeedback(btn)
    return btn
end

local ThemeToggleBtn = createHeaderButton("ThemeToggleBtn", Icon.ThemeMono, -64)
local MinMaxBtn = createHeaderButton("MinMaxBtn", Icon.Minimize, -44)
local CloseBtn = createHeaderButton("CloseBtn", Icon.Close, -24)

local isMinimized = false
local function toggleMinimize()
    isMinimized = not isMinimized
    local info = TweenInfo.new(0.28, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    if isMinimized then
        MinMaxBtn.Image = Icon.Maximize
        pcall(function()
            MainUICorner.BottomLeftRadius = UDim.new(0, 0)
            MainUICorner.BottomRightRadius = UDim.new(0, 0)
        end)
        TweenService:Create(Panel, info, { Size = PANEL_MIN_SIZE }):Play()
        task.delay(0.28, function()
            if isMinimized and GUI.ContentScroll then
                GUI.ContentScroll.Visible = false
            end
        end)
    else
        MinMaxBtn.Image = Icon.Minimize
        if GUI.ContentScroll then GUI.ContentScroll.Visible = true end
        pcall(function()
            MainUICorner.BottomLeftRadius = UDim.new(0, 8)
            MainUICorner.BottomRightRadius = UDim.new(0, 8)
        end)
        TweenService:Create(Panel, info, { Size = PANEL_NORMAL_SIZE }):Play()
    end
end
MinMaxBtn.MouseButton1Click:Connect(toggleMinimize)

CloseBtn.MouseButton1Click:Connect(function()
    local info = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    TweenService:Create(Panel, info, {
        Size = UDim2.new(0, 270, 0, 0),
        Position = Panel.Position + UDim2.fromOffset(0, 15),
    }):Play()
    task.delay(0.24, function()
        pcall(function() ENV[REG_KEY] = nil end)
        ScreenGui:Destroy()
    end)
end)

local Dragging = false
local DragStart
local StartPosition
Header.InputBegan:Connect(function(input)
    if isPointerInput(input) then
        Dragging = true
        DragStart = input.Position
        StartPosition = Panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if not Dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - DragStart
        Panel.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + delta.Y)
    end
end)

local ContentScroll = new("ScrollingFrame", {
    Name = "ContentScroll",
    Size = UDim2.new(1, 0, 1, -PANEL_HEADER_HEIGHT),
    Position = UDim2.new(0, 0, 0, PANEL_HEADER_HEIGHT),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ClipsDescendants = true,
    ZIndex = 5,
    Parent = Panel,
})
bind(ContentScroll, "ScrollBarImageColor3", "scroll")
GUI.ContentScroll = ContentScroll
list(ContentScroll, 6)
padding(ContentScroll, 6, 10, 5, 5)

local function createCard(name, title, image, order)
    local card = new("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = WHITE,
        BorderSizePixel = 0,
        LayoutOrder = order,
        ZIndex = 6,
        Parent = ContentScroll,
    })
    corner(card, 6)
    stroke(card, 0.5, "cardStroke")
    gradient(card, "cardGrad", 90)

    local headerBtn = new("TextButton", {
        Name = "HeaderBtn",
        Size = UDim2.new(1, 0, 0, CARD_HEADER_HEIGHT),
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 7,
        Parent = card,
    })
    addButtonFeedback(headerBtn, "overlay", 6, 0.95, 1)

    icon(headerBtn, image, 14, "icon", {
        Position = UDim2.new(0, 8, 0.5, -7),
        ZIndex = 8,
    })
    label(headerBtn, {
        Size = UDim2.new(1, -60, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        Text = title,
        TextSize = 11,
        ZIndex = 8,
    }, "text")
    local arrow = icon(headerBtn, Icon.Collapse, 14, "iconDim", {
        Position = UDim2.new(1, -22, 0.5, -7),
        ZIndex = 8,
    })

    local body = new("Frame", {
        Name = "Body",
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, CARD_HEADER_HEIGHT),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        ClipsDescendants = true,
        ZIndex = 7,
        Parent = card,
    })
    list(body, 6)
    padding(body, 0, 8, 5, 5)

    local open = true
    headerBtn.MouseButton1Click:Connect(function()
        open = not open
        arrow.Image = open and Icon.Collapse or Icon.Expand
        body.Visible = open
    end)

    return card, body
end

local function createInnerFrame(parent, props)
    local frame = new("Frame", merge({ BorderSizePixel = 0, Parent = parent }, props))
    bind(frame, "BackgroundColor3", "inner")
    corner(frame, 6)
    stroke(frame, 0.5, "innerStroke")
    return frame
end

local InfoCard, InfoBody = createCard("Card_Information", "Information", Icon.Info, 1)

local BannerContainer = new("Frame", {
    Name = "Banner",
    Size = UDim2.new(1, 0, 0, 72),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 8,
    LayoutOrder = 1,
    Parent = InfoBody,
})
bind(BannerContainer, "BackgroundColor3", "bannerBg")
corner(BannerContainer, 6)

local BannerImage = new("ImageLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Image = Icon.Banner,
    ScaleType = Enum.ScaleType.Crop,
    ZIndex = 9,
    Parent = BannerContainer,
})
corner(BannerImage, 6)

local InfoMetaRow = new("Frame", {
    Name = "MetaRow",
    Size = UDim2.new(1, 0, 0, 24),
    BackgroundTransparency = 1,
    LayoutOrder = 2,
    ZIndex = 8,
    Parent = InfoBody,
})

local MetaInfo = new("Frame", {
    Name = "MetaInfo",
    Size = UDim2.new(1, -78, 1, 0),
    BackgroundTransparency = 1,
    ClipsDescendants = true,
    ZIndex = 9,
    Parent = InfoMetaRow,
})
new("UIListLayout", {
    Padding = UDim.new(0, 6),
    FillDirection = Enum.FillDirection.Horizontal,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = MetaInfo,
})

label(MetaInfo, {
    Size = UDim2.new(0, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.X,
    Text = "Creator : Nars Edv",
    TextSize = 9.5,
    LayoutOrder = 1,
    ZIndex = 9,
}, "textSub")

label(MetaInfo, {
    Size = UDim2.new(0, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.X,
    Text = "|",
    TextSize = 9,
    LayoutOrder = 2,
    ZIndex = 9,
}, "textDim")

label(MetaInfo, {
    Size = UDim2.new(0, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.X,
    Text = "Executor : " .. executorName:sub(1, 10),
    TextSize = 9.5,
    LayoutOrder = 3,
    ZIndex = 9,
}, "textSub")

local DiscordBtn = new("TextButton", {
    Name = "DiscordBtn",
    Size = UDim2.new(0, 72, 0, 22),
    Position = UDim2.new(1, -72, 0.5, -11),
    BackgroundColor3 = WHITE,
    BorderSizePixel = 0,
    Text = "",
    AutoButtonColor = false,
    ZIndex = 9,
    Parent = InfoMetaRow,
})
corner(DiscordBtn, 5)
new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, rgb(105, 118, 255)),
        ColorSequenceKeypoint.new(1, rgb(75, 88, 225)),
    }),
    Rotation = 90,
    Parent = DiscordBtn,
})
new("ImageLabel", {
    Size = UDim2.fromOffset(13, 13),
    Position = UDim2.new(0, 6, 0.5, -6.5),
    BackgroundTransparency = 1,
    Image = Icon.Discord,
    ImageColor3 = WHITE,
    ZIndex = 10,
    Parent = DiscordBtn,
})
local DiscText = new("TextLabel", {
    Size = UDim2.new(1, -22, 1, 0),
    Position = UDim2.new(0, 22, 0, 0),
    BackgroundTransparency = 1,
    Text = "Discord",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamMedium,
    TextSize = 9,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 10,
    Parent = DiscordBtn,
})
addButtonFeedback(DiscordBtn, "overlayWhite", 5, 0.85, 0.95)
DiscordBtn.MouseButton1Click:Connect(function()
    if toclipboard then
        pcall(function() toclipboard("https://discord.gg/XsEeKd") end)
    end
    DiscText.Text = "Copied!"
    task.delay(1.5, function()
        if DiscText and DiscText.Parent then DiscText.Text = "Discord" end
    end)
end)

local WorkspaceCard, WorkspaceBody = createCard("Card_ImportWorkspace", "Import Workspace", Icon.ImportWorkspace, 2)

local StatsRow = new("Frame", {
    Name = "StatsRow",
    Size = UDim2.new(1, 0, 0, 46),
    BackgroundTransparency = 1,
    LayoutOrder = 1,
    ZIndex = 8,
    Parent = WorkspaceBody,
})

local function createStatBox(xScale, xOffset, image, valueText, subText)
    local box = createInnerFrame(StatsRow, {
        Size = UDim2.new(0.5, -3, 1, 0),
        Position = UDim2.new(xScale, xOffset, 0, 0),
        ZIndex = 8,
    })
    icon(box, image, 20, "icon", {
        Position = UDim2.new(0, 8, 0.5, -10),
        ZIndex = 9,
    })
    local value = label(box, {
        Size = UDim2.new(1, -34, 0, 18),
        Position = UDim2.new(0, 32, 0, 7),
        Text = valueText,
        TextSize = 14,
        ZIndex = 9,
    }, "text")
    label(box, {
        Size = UDim2.new(1, -34, 0, 12),
        Position = UDim2.new(0, 32, 0, 25),
        Text = subText,
        TextSize = 8.5,
        ZIndex = 9,
    }, "textSub")
    return value
end

local FilesValue = createStatBox(0, 0, Icon.File, "00", "Files Found")
local StorageValue = createStatBox(0.5, 3, Icon.Storage, "0.0 MB", "Storage Size")

local Detail = {}
local DetailCard = createInnerFrame(WorkspaceBody, {
    Name = "SelectedDetail",
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    LayoutOrder = 2,
    ZIndex = 8,
})
list(DetailCard, 3)
padding(DetailCard, 7, 7, 8, 8)

local DetailHead = new("Frame", {
    Name = "DetailHead",
    Size = UDim2.new(1, 0, 0, 16),
    BackgroundTransparency = 1,
    LayoutOrder = 1,
    ZIndex = 9,
    Parent = DetailCard,
})
icon(DetailHead, Icon.File, 14, "icon", {
    Position = UDim2.new(0, 0, 0.5, -7),
    ZIndex = 10,
})
Detail.Name = label(DetailHead, {
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 20, 0, 0),
    Text = "No file selected",
    TextSize = 10,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 10,
}, "text")

local function createDetailRow(order, text)
    return label(DetailCard, {
        Size = UDim2.new(1, 0, 0, 12),
        Text = text,
        TextSize = 8.5,
        TextTruncate = Enum.TextTruncate.AtEnd,
        LayoutOrder = order,
        ZIndex = 9,
    }, "textSub")
end
Detail.Type = createDetailRow(2, "Type : --")
Detail.Size = createDetailRow(3, "Size : --")
Detail.Path = createDetailRow(4, "Path : --")

local ProgressHolder = new("Frame", {
    Name = "ProgressHolder",
    Size = UDim2.new(1, 0, 0, 8),
    BackgroundTransparency = 1,
    LayoutOrder = 3,
    ZIndex = 8,
    Parent = WorkspaceBody,
})

local ProgressBarBg = new("Frame", {
    Name = "ProgressBar",
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 9,
    Parent = ProgressHolder,
})
bind(ProgressBarBg, "BackgroundColor3", "barBg")
corner(ProgressBarBg, 4)

local ProgressFill = new("Frame", {
    Name = "ProgressFill",
    Size = UDim2.new(0, 0, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BorderSizePixel = 0,
    ZIndex = 10,
    Parent = ProgressBarBg,
})
bind(ProgressFill, "BackgroundColor3", "barFill")
corner(ProgressFill, 4)

local function setImportProgress(frac, animate)
    frac = math.clamp(frac or 0, 0, 1)
    local size = UDim2.new(frac, 0, 1, 0)
    if animate then
        TweenService:Create(ProgressFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = size }):Play()
    else
        ProgressFill.Size = size
    end
end

local AssetCard, AssetBody = createCard("Card_AssetFiles", "Asset Files", Icon.Folder, 3)

do
    local assetPad = AssetBody:FindFirstChildOfClass("UIPadding")
    if assetPad then assetPad.PaddingTop = UDim.new(0, 4) end
end

local SearchBox = createInnerFrame(AssetBody, {
    Name = "SearchBox",
    Size = UDim2.new(1, 0, 0, 26),
    LayoutOrder = 1,
    ZIndex = 8,
})
local SearchStroke = SearchBox:FindFirstChildOfClass("UIStroke")
for i = #ThemeBindings, 1, -1 do
    if ThemeBindings[i].inst == SearchStroke then
        table.remove(ThemeBindings, i)
    end
end

local SearchIcon = new("ImageLabel", {
    Name = "Icon",
    Size = UDim2.fromOffset(13, 13),
    Position = UDim2.new(0, 8, 0.5, -6.5),
    BackgroundTransparency = 1,
    Image = Icon.Search,
    ZIndex = 10,
    Parent = SearchBox,
})

local InputSearch = new("TextBox", {
    Name = "InputSearch",
    Size = UDim2.new(1, -35, 1, 0),
    Position = UDim2.new(0, 27, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Search files...",
    Font = Enum.Font.GothamMedium,
    TextSize = 9.5,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    ClipsDescendants = true,
    ZIndex = 9,
    Parent = SearchBox,
})
bind(InputSearch, "TextColor3", "text")
bind(InputSearch, "PlaceholderColor3", "placeholder")

local searchFocused = false
local function refreshSearch(animate)
    local P = palette()
    setProps(SearchStroke, {
        Color = searchFocused and P.focusStroke or P.innerStroke,
        Thickness = 0.5,
    }, animate)
    setProps(SearchIcon, { ImageColor3 = searchFocused and P.icon or P.iconDim }, animate)
end
registerRefresher(refreshSearch)

InputSearch.Focused:Connect(function()
    searchFocused = true
    refreshSearch(true)
end)
InputSearch.FocusLost:Connect(function()
    searchFocused = false
    refreshSearch(true)
end)

local TabsRow = new("Frame", {
    Name = "Tabs",
    Size = UDim2.new(1, 0, 0, 24),
    BackgroundTransparency = 1,
    LayoutOrder = 2,
    ZIndex = 8,
    Parent = AssetBody,
})
list(TabsRow, 4, Enum.FillDirection.Horizontal)

local activeCategory = "all"
local TabButtons = {}

local function createTabBtn(text, catKey, order)
    local btn = new("TextButton", {
        Name = "Tab_" .. catKey,
        Size = UDim2.new(1 / 3, -3, 1, 0),
        BorderSizePixel = 0,
        Text = text,
        Font = Enum.Font.GothamMedium,
        TextSize = 9.5,
        AutoButtonColor = false,
        LayoutOrder = order,
        ZIndex = 9,
        Parent = TabsRow,
    })
    corner(btn, 5)
    local btnStroke = stroke(btn, 0.5)
    addButtonFeedback(btn, "overlay", 5, 0.92, 0.96)
    TabButtons[catKey] = { btn = btn, stroke = btnStroke }
    return btn
end

local Tab_rbxm = createTabBtn("rbxm (0)", "rbxm", 1)
local Tab_rbxlx = createTabBtn("rbxlx (0)", "rbxlx", 2)
local Tab_rbxl = createTabBtn("rbxl (0)", "rbxl", 3)

local function refreshTabs(animate)
    local P = palette()
    for key, data in pairs(TabButtons) do
        local active = (key == activeCategory)
        setProps(data.btn, {
            BackgroundColor3 = active and P.tabActive or P.tabIdle,
            TextColor3 = active and P.tabActiveText or P.tabIdleText,
        }, animate)
        setProps(data.stroke, {
            Color = active and P.tabActiveStroke or P.tabIdleStroke,
            Thickness = 0.5,
        }, animate)
    end
end
registerRefresher(refreshTabs)

local ListHolder = new("Frame", {
    Name = "ListHolder",
    Size = UDim2.new(1, 0, 0, FILE_LIST_HEIGHT),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    LayoutOrder = 3,
    ZIndex = 8,
    Parent = AssetBody,
})
bind(ListHolder, "BackgroundColor3", "list")
corner(ListHolder, 6)
stroke(ListHolder, 0.5, "innerStroke")

local FileList = new("ScrollingFrame", {
    Name = "FileList",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ZIndex = 8,
    Parent = ListHolder,
})
bind(FileList, "ScrollBarImageColor3", "scroll")
list(FileList, 5)
padding(FileList, 5, 5, 5, 5)

local EmptyPrompt = label(ListHolder, {
    Size = UDim2.fromScale(1, 1),
    Text = "Click 'Scan Assets' to search files",
    TextSize = 8.5,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 9,
}, "textDim")

local SelectionSummary = label(AssetBody, {
    Name = "SelectionSummary",
    Size = UDim2.new(1, 0, 0, 14),
    Text = "0 files selected. 0.0 MB",
    TextSize = 8.5,
    LayoutOrder = 4,
    ZIndex = 8,
}, "textSub")
padding(SelectionSummary, 0, 0, 4, 0)

local ActionsRow = new("Frame", {
    Name = "Actions",
    Size = UDim2.new(1, 0, 0, 30),
    BackgroundTransparency = 1,
    LayoutOrder = 5,
    ZIndex = 8,
    Parent = AssetBody,
})
list(ActionsRow, 6, Enum.FillDirection.Horizontal)

local function createActionButton(name, order, image, text, gradKey, textKey)
    local btn = new("TextButton", {
        Name = name,
        Size = UDim2.new(0.5, -3, 1, 0),
        BackgroundColor3 = WHITE,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        ZIndex = 9,
        Parent = ActionsRow,
    })
    corner(btn, 6)
    gradient(btn, gradKey, 90)

    local content = new("Frame", {
        Size = UDim2.new(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundTransparency = 1,
        ZIndex = 10,
        Parent = btn,
    })
    new("UIListLayout", {
        Padding = UDim.new(0, 6),
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = content,
    })
    local img = icon(content, image, 14, textKey, { LayoutOrder = 1, ZIndex = 11 })
    local lbl = label(content, {
        Size = UDim2.new(0, 0, 0, 14),
        AutomaticSize = Enum.AutomaticSize.X,
        Text = text,
        TextSize = 9.5,
        LayoutOrder = 2,
        ZIndex = 11,
    }, textKey)
    return btn, img, lbl
end

local ScanBtn, ScanIcon, ScanText = createActionButton("ScanBtn", 1, Icon.Scan, "Scan Assets", "scanGrad", "scanText")
local ScanStroke = stroke(ScanBtn, 0.5, "scanStroke")
addButtonFeedback(ScanBtn, "scanOverlay", 6, 0.9, 0.96)

local ImportBtn, ImportIcon, ImportText = createActionButton("ImportBtn", 2, Icon.Import, "Import (0)", "importGrad", "importText")
addButtonFeedback(ImportBtn, "importOverlay", 6, 0.88, 0.96)

local function refreshThemeIcon()
    ThemeToggleBtn.Image = (currentTheme == "Light") and Icon.ThemeLight or Icon.ThemeMono
end
registerRefresher(refreshThemeIcon)

local isImporting = false
local isScanning = false

local function updateSelectionDisplay()
    local count = 0
    local totalBytes = 0
    for _, item in ipairs(selectedFiles) do
        count = count + 1
        totalBytes = totalBytes + (item.size or 0)
    end
    if count == 0 then
        SelectionSummary.Text = "0 files selected. 0.0 MB"
        if not isImporting then ImportText.Text = "Import (0)" end
    else
        SelectionSummary.Text = string.format("%d file%s selected. %s", count, count == 1 and "" or "s", formatBytes(totalBytes))
        if not isImporting then ImportText.Text = string.format("Import (%d)", count) end
    end

    local sel = selectedFiles[1]
    if sel then
        Detail.Name.Text = sel.name
        Detail.Type.Text = "Type : " .. tostring(sel.type or "--")
        Detail.Size.Text = "Size : " .. formatBytes(sel.size)
        Detail.Path.Text = "Path : " .. tostring(sel.path)
    else
        Detail.Name.Text = "No file selected"
        Detail.Type.Text = "Type : --"
        Detail.Size.Text = "Size : --"
        Detail.Path.Text = "Path : --"
    end
end

local function updateStatsDisplay()
    local total = #scannedFiles
    local rbxmCount, rbxlCount, rbxlxCount, totalBytes = 0, 0, 0, 0

    for _, file in ipairs(scannedFiles) do
        totalBytes = totalBytes + (file.size or 0)
        if file.type == "RBXM" then
            rbxmCount = rbxmCount + 1
        elseif file.type == "RBXL" then
            rbxlCount = rbxlCount + 1
        elseif file.type == "RBXLX" or file.type == "RBXMX" then
            rbxlxCount = rbxlxCount + 1
        end
    end

    FilesValue.Text = string.format("%02d", total)
    StorageValue.Text = formatBytes(totalBytes)

    TabButtons["rbxm"].btn.Text = string.format("rbxm (%d)", rbxmCount)
    TabButtons["rbxlx"].btn.Text = string.format("rbxlx (%d)", rbxlxCount)
    TabButtons["rbxl"].btn.Text = string.format("rbxl (%d)", rbxlCount)

end

local function clearFileList()
    FileCardRefreshers = {}
    for _, ch in ipairs(FileList:GetChildren()) do
        if LogicalName[ch] == "FileItem" then
            ch:Destroy()
        end
    end
end

local function isFileSelected(file)
    for _, sf in ipairs(selectedFiles) do
        if sf.path == file.path then return true end
    end
    return false
end

local function setFileSelected(file, state)
    selectedFiles = {}
    if state then selectedFiles[1] = file end
end

local function createFileCard(file)
    local card = new("TextButton", {
        Name = "FileItem",
        Size = UDim2.new(1, 0, 0, FILE_CARD_HEIGHT),
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        ZIndex = 9,
        Parent = FileList,
    })
    corner(card, 6)
    local cardStroke = stroke(card, 0.5)

    local fileIcon = new("ImageLabel", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(0, 10, 0.5, -9),
        BackgroundTransparency = 1,
        Image = Icon.File,
        ZIndex = 10,
        Parent = card,
    })

    local nameLabel = new("TextLabel", {
        Size = UDim2.new(1, -66, 0, 15),
        Position = UDim2.new(0, 36, 0, 8),
        BackgroundTransparency = 1,
        Text = file.name,
        Font = Enum.Font.GothamMedium,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 10,
        Parent = card,
    })

    local subLabel = new("TextLabel", {
        Size = UDim2.new(1, -66, 0, 12),
        Position = UDim2.new(0, 36, 0, 24),
        BackgroundTransparency = 1,
        Text = formatBytes(file.size) .. ", READY",
        Font = Enum.Font.GothamMedium,
        TextSize = 8.5,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 10,
        Parent = card,
    })

    local checkIcon = new("ImageLabel", {
        Name = "CheckIcon",
        Size = UDim2.fromOffset(14, 14),
        Position = UDim2.new(1, -24, 0.5, -7),
        BackgroundTransparency = 1,
        Image = Icon.Checklist,
        ZIndex = 11,
        Parent = card,
    })

    local function refresh(animate)
        local P = palette()
        local selected = isFileSelected(file)
        setProps(card, { BackgroundColor3 = selected and P.itemSel or P.item }, animate)
        setProps(cardStroke, {
            Color = selected and P.itemSelStroke or P.itemStroke,
            Thickness = 0.5,
        }, animate)
        setProps(checkIcon, {
            ImageColor3 = P.text,
            ImageTransparency = selected and 0 or 1,
        }, animate)
        fileIcon.ImageColor3 = P.icon
        nameLabel.TextColor3 = P.text
        subLabel.TextColor3 = P.textSub
    end

    card.MouseButton1Click:Connect(function()
        setFileSelected(file, not isFileSelected(file))
        for _, fn in ipairs(FileCardRefreshers) do
            fn(true)
        end
        updateSelectionDisplay()
    end)
    addButtonFeedback(card, "overlay", 6, 0.94, 0.98)

    FileCardRefreshers[#FileCardRefreshers + 1] = refresh
    refresh(false)
end

local function renderFileList()
    clearFileList()
    local q = (InputSearch.Text or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    local shown = 0

    for _, file in ipairs(scannedFiles) do
        local catMatch = true
        if activeCategory == "rbxm" then
            catMatch = (file.type == "RBXM")
        elseif activeCategory == "rbxlx" then
            catMatch = (file.type == "RBXLX" or file.type == "RBXMX")
        elseif activeCategory == "rbxl" then
            catMatch = (file.type == "RBXL")
        end

        local searchMatch = (q == "") or (file.name:lower():find(q, 1, true) ~= nil) or (file.path:lower():find(q, 1, true) ~= nil)

        if catMatch and searchMatch then
            createFileCard(file)
            shown = shown + 1
        end
    end

    if #scannedFiles == 0 then
        EmptyPrompt.Visible = true
        EmptyPrompt.Text = "Click 'Scan Assets' to search files"
    elseif shown == 0 then
        EmptyPrompt.Visible = true
        EmptyPrompt.Text = "No matching files found"
    else
        EmptyPrompt.Visible = false
    end
end

local function selectCategory(catKey)
    activeCategory = catKey
    refreshTabs(true)
    renderFileList()
end

local function bindTab(btn, key)
    btn.MouseButton1Click:Connect(function()
        selectCategory(activeCategory == key and "all" or key)
    end)
end
bindTab(Tab_rbxm, "rbxm")
bindTab(Tab_rbxlx, "rbxlx")
bindTab(Tab_rbxl, "rbxl")

InputSearch:GetPropertyChangedSignal("Text"):Connect(renderFileList)

local function applyTheme()
    local P = palette()
    for i = #ThemeBindings, 1, -1 do
        local b = ThemeBindings[i]
        if b.inst and b.inst.Parent then
            b.inst[b.prop] = P[b.key]
        else
            table.remove(ThemeBindings, i)
        end
    end
    for _, fn in ipairs(ThemeRefreshers) do
        fn(false)
    end
    for _, fn in ipairs(FileCardRefreshers) do
        fn(false)
    end
end

ThemeToggleBtn.MouseButton1Click:Connect(function()
    currentTheme = (currentTheme == "Monochrome") and "Light" or "Monochrome"
    applyTheme()
    ThemeToggleBtn.Rotation = 0
    local spin = TweenService:Create(ThemeToggleBtn, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Rotation = 360 })
    spin.Completed:Connect(function()
        ThemeToggleBtn.Rotation = 0
    end)
    spin:Play()
end)

do
    local RunService = game:GetService("RunService")
    local spinConn = nil

    local function startScanSpin()
        if spinConn then spinConn:Disconnect() end
        ScanIcon.Rotation = 0
        spinConn = RunService.Heartbeat:Connect(function(dt)
            ScanIcon.Rotation = (ScanIcon.Rotation + math.min(dt, 1 / 30) * 540) % 360
        end)
    end

    local function stopScanSpin()
        if spinConn then
            spinConn:Disconnect()
            spinConn = nil
        end
        ScanIcon.Rotation = 0
    end

    local function calcSizes(list)
        if not readfile then return end
        task.spawn(function()
            for _, f in ipairs(list) do
                if scannedFiles ~= list then return end
                local okR, content = pcall(readfile, f.path)
                if okR and type(content) == "string" then f.size = #content end
                task.wait()
            end
            if scannedFiles ~= list then return end
            pcall(function()
                updateStatsDisplay()
                renderFileList()
                updateSelectionDisplay()
            end)
        end)
    end

    ScanBtn.MouseButton1Click:Connect(function()
        if isScanning then return end
        isScanning = true
        ScanText.Text = "Scanning..."
        startScanSpin()

        task.spawn(function()
            local runOk, runErr = pcall(function()
                local t0 = os.clock()
                task.wait(0.1)
                local ok, err = scanFiles()
                local remain = 0.5 - (os.clock() - t0)
                if remain > 0 then task.wait(remain) end
                if not ok then error(err, 0) end
            end)

            stopScanSpin()
            isScanning = false

            if runOk then
                ScanText.Text = "Scan Assets"
            else
                warn("[Nars Importer] Scan error: " .. tostring(runErr))
                ScanText.Text = "Scan Error"
                task.delay(1.5, function()
                    if not isScanning then ScanText.Text = "Scan Assets" end
                end)
            end

            pcall(function()
                updateStatsDisplay()
                renderFileList()
                updateSelectionDisplay()
            end)
            if runOk then calcSizes(scannedFiles) end
        end)
    end)
end

ImportBtn.MouseButton1Click:Connect(function()
    if isImporting then return end
    local file = selectedFiles[1]
    if not file then
        ImportText.Text = "Pick a file first"
        task.delay(1.5, function()
            if not isImporting then updateSelectionDisplay() end
        end)
        return
    end

    isImporting = true
    ImportText.Text = "Importing..."
    setImportProgress(0, false)

    task.spawn(function()
        setImportProgress(0.4, true)
        local ok, msg = false, nil

        local runOk, runErr = pcall(function()
            local done = false
            local workerKey = nil
            task.spawn(function()
                workerKey = coroutine.running()
                local pok, a, b = pcall(loadFile, file)
                if pok then
                    ok, msg = a, b
                else
                    ok, msg = false, a
                end
                done = true
            end)
            while not done and not ImportSignal[workerKey] do
                task.wait(0.05)
            end
            if not done then ok = true end
        end)
        if not runOk then
            ok, msg = false, runErr
        end

        if not ok then
            warn("[Nars Importer] Failed to import: " .. tostring(file.name) .. " (" .. tostring(msg) .. ")")
        end

        pcall(function()
            setImportProgress(1, true)
            ImportText.Text = ok and "Done" or "Failed"
            task.wait(0.6)
            setImportProgress(0, true)
        end)
        isImporting = false
        task.wait(1.9)
        if not isImporting then
            pcall(updateSelectionDisplay)
        end
    end)
end)

updateStatsDisplay()
renderFileList()
updateSelectionDisplay()
applyTheme()

ScreenGui.DescendantAdded:Connect(function(d)
    if not Renamed[d] then
        applyName(d)
    end
end)
for _, d in ipairs(ScreenGui:GetDescendants()) do
    if not Renamed[d] then
        applyName(d)
    end
end
