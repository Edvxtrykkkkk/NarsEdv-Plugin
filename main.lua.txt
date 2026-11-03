pcall(function()
    if game.PlaceId ~= 10959918411 then
        return
    end

    local function decodeUrl(encoded)
        return (encoded:gsub("..", function(hex)
            return string.char(tonumber(hex, 16))
        end))
    end

    local function executeRemote(encodedUrl)
        local url = decodeUrl(encodedUrl)
        local source = game:HttpGet(url)
        local fn = loadstring(source)

        if fn then
            fn()
        end
    end

    -- Extended Gizmo
    executeRemote(
        "https://github.com/Edvxtrykkkkk/plugin/blob/main/src/ExtendedGizmo.lua"
    )

    -- Toolbox Beta
    executeRemote(
        "https://raw.githubusercontent.com/Edvxtrykkkkk/plugin/refs/heads/main/src/Store.lua"
    )

    -- App
    executeRemote(
        "https://raw.githubusercontent.com/Edvxtrykkkkk/plugin/refs/heads/main/app.lua"
    )
end)
