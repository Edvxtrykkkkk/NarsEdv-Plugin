local function executeRemote(name, url)
    -- Download source
    local downloadOK, source = pcall(function()
        return game:HttpGet(url)
    end)

    if not downloadOK then
        warn("[NARS EDV] " .. name .. " Download Error: " .. tostring(source))
        return false
    end

    if type(source) ~= "string" or #source == 0 then
        warn("[NARS EDV] " .. name .. " Error: Source kosong")
        return false
    end

    -- Compile source
    local compileOK, fn, compileError = pcall(function()
        return loadstring(source)
    end)

    if not compileOK or type(fn) ~= "function" then
        warn("[NARS EDV] " .. name .. " Compile Error: " .. tostring(compileError or fn))
        return false
    end

    -- Execute source
    local executeOK, result = pcall(fn)

    if not executeOK then
        warn("[NARS EDV] " .. name .. " Runtime Error: " .. tostring(result))
        return false
    end

    print("[NARS EDV] " .. name .. " Loaded")
    return true
end

-- 1. Extended Gizmo
executeRemote(
    "Extended Gizmo",
    "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/ExtendedGizmo.lua"
)

-- 2. Main App
executeRemote(
    "App",
    "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/app.lua"
)
