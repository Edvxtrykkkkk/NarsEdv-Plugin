local Ophyn = loadstring(game:HttpGet("https://ophyn.space/interface"))()

local Window = Ophyn.new({
    Title = "Nars Edv",
    Description = "Verify Access Plugin",
    Logo = "rbxassetid://122926744824622",
    Theme = "Dark",
    Folder = "Nars-Plugin",

    getkey = false,

    Intro = true,
    startintro_size = 80,
    squareintro_time = 0.5,

    Changelogocolor = false,
    Changeiconscolor = true,
    NotifStyle = "2",
    TabsStyle = "2",

    discord_link = "https://discord.gg/6GmpsmNvY",

    Discord = true,

    SupportedGames = {
        [10959918411] = true,
    },

    KeySystem = {
        Key = {"NARS-ACCESS-PLUGIN"},
        SaveKey = true,
    },

    Callback = function(key)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/main.lua"))()
    end,
})

local Icons = {
    Dashboard = "rbxassetid://139929981863901",
    Globe = "rbxassetid://114238209622913",
    Feather = "rbxassetid://91872927606406",
}

local function copyText(text)
    local fn = setclipboard or toclipboard or (syn and syn.write_clipboard)

    if fn then
        local ok = pcall(fn, text)
        if ok then
            return true
        end
    end

    warn("[Nars Edv] Clipboard is not available. Link: " .. text)
    return false
end

local FeaturesTab = Window({
    Title = "Features",
    Icon = Icons.Dashboard,
})

FeaturesTab:Section({
    Title = "Feature",
})

local featureLines = {
    "1. Roblox Asset Store",
    "Search and browse Roblox assets directly through the Creator Store API. Supports multiple asset categories, including Models, Decals, Audio, Images, and more, with asset previews and insertion tools.",
    "",
    "2. Terrain Editor",
    "Create and edit terrain using dedicated building tools. Generate terrain from parts, sculpt landscapes, paint materials, and customize terrain properties directly from the editor.",
    "",
    "3. Lucide Icons",
    "Explore the Lucide icon library with searchable icons and category filtering. Browse icon previews, select your preferred style, and easily copy or use icons in your UI projects.",
    "",
    "4. Ecode",
    "A dedicated Luau script editor for writing and managing code. Includes script editing, Explorer integration, console output, and script management tools in one workspace.",
    "",
    "5. File Importer",
    "Import Roblox files into your workspace with support for RBXM, RBXL, and RBXLX formats. Provides a straightforward way to bring external models and places into your project.",
    "",
    "6. FlyCameraFocus",
    "Navigate your workspace using a free-flying camera system. Control camera movement, adjust flight speed, and explore your builds with flexible camera positioning.",
    "",
    "7. Archimedes",
    "Create precise circular and curved part arrangements with rotation-based building tools. Adjust angles and placement to construct arcs, circles, and other geometric structures.",
    "",
    "8. Fly Character",
    "Enable free-flight movement for your character to explore the workspace. Move through different directions and adjust movement speed for easier navigation and building tests.",
    "",
    "9. Gizmo XYZ Axis",
    "Provides directional XYZ axis handles for precise object manipulation. Includes Handles for movement and resizing, plus ArcHandles for rotation, with color-coded X, Y, and Z axes.",
}

FeaturesTab:Paragraph({
    Title = "Feature List",
    Desc = table.concat(featureLines, "\n"),
    Buttons = {
        {
            Icon = Icons.Globe,
            Title = "https://lucide.dev/icons/",
            Callback = function()
                copyText("https://lucide.dev/icons/")
            end,
        },
    },
})

local CreditTab = Window({
    Title = "Credit",
    Icon = Icons.Feather,
})

CreditTab:Section({
    Title = "Credit",
})

CreditTab:Paragraph({
    Title = "About",
    Desc = "Nars Endeavor is an all-in-one Roblox Studio utility plugin designed to simplify building, editing, and development workflows. It brings together asset management, terrain editing, Luau scripting, file importing, camera controls, and advanced building tools in a single workspace.",
})

CreditTab:Paragraph({
    Title = "Credit",
    Desc = table.concat({
        "Plugin : Nars Endeavor",
        "KeyUI : Ophyn",
    }, "\n"),
    Buttons = {
        {
            Icon = Icons.Globe,
            Title = "https://www.ophyn.space",
            Callback = function()
                copyText("https://www.ophyn.space")
            end,
        },
    },
})
