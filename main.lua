local function executeRemote(name, url)
    local success, err = pcall(function()
        local source = game:HttpGet(url)
        assert(type(source) == "string" and #source > 0, "Source kosong")

        local fn, compileError = loadstring(source)
        assert(fn, compileError or "Gagal compile")

        fn()
    end)

    if not success then
        warn("[NARS EDV] " .. name .. " Error: " .. tostring(err))
    end
end

-- Extended Gizmo
executeRemote(
    "Extended Gizmo",
    "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/ExtendedGizmo.lua"
)

-- Toolbox Beta
executeRemote(
    "Toolbox Beta",
    "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/store.lua"
)

-- App
executeRemote(
    "App",
    "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/app.lua"
)
