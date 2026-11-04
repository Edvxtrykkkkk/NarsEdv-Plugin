pcall(function()
    if game.PlaceId ~= 10959918411 then
        return
    end

    local function executeRemote(url)
        local success, result = pcall(function()
            local source = game:HttpGet(url)
            local fn = loadstring(source)

            assert(fn, "Failed to compile remote source")
            fn()
        end)

        if not success then
            warn("[NARS EDV] " .. tostring(result))
        end
    end

    -- Extended Gizmo
    executeRemote(
        "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/ExtendedGizmo.lua"
    )

    -- Toolbox Beta
    executeRemote(
        "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/src/store.lua"
    )

    -- App
    executeRemote(
        "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/app.lua"
    )
end)
