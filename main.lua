-- load
local function executeRemote(name, url)
    -- Download
    local success, source = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        warn("[NARS EDV] " .. name .. " | Download Error: " .. tostring(source))
        return false
    end

    if type(source) ~= "string" or source == "" then
        warn("[NARS EDV] " .. name .. " | Source is empty")
        return false
    end

    -- Compile
    local compiled, callback = pcall(loadstring, source)

    if not compiled or type(callback) ~= "function" then
        warn("[NARS EDV] " .. name .. " | Compile Error: " .. tostring(callback))
        return false
    end

    -- Execute
    local executed, result = pcall(callback)

    if not executed then
        warn("[NARS EDV] " .. name .. " | Runtime Error: " .. tostring(result))
        return false
    end

    return true
end

-- Modules
local Modules = {
    {
        Name = "Extended Gizmo",
        URL = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/ExtendedGizmo.lua"
    },
    {
        Name = "App",
        URL = "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/app.lua"
    }
}

-- Load Modules
for _, module in ipairs(Modules) do
    executeRemote(module.Name, module.URL)
end
