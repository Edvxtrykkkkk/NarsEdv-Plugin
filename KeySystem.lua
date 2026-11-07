local Ophyn = loadstring(game:HttpGet("https://ophyn.space/interface"))()

Ophyn.new({
    -- Window
    Title = "Nars Edv",
    Description = "Verify Access Plugin",
    Logo = "rbxassetid://122926744824622",
    Theme = "Dark",
    Folder = "Nars-Plugin",

    -- Buttons
    getkey = false,

    -- Intro
    Intro = true,
    startintro_size = 80,
    squareintro_time = 0.5,

    -- Appearance
    Changelogocolor = false,
    Changeiconscolor = true,
    NotifStyle = "2",

    -- Links
    discord_link = "https://discord.gg/6GmpsmNvY",

    -- Cards
    Discord = true,

    -- Games
    SupportedGames = {
        [10959918411] = true,
    },

    -- Key System
    KeySystem = {
        Key = {"NARS-ACCESS-PLUGIN"},
        SaveKey = true,
    },

    -- Script
    Callback = function(key)
        loadstring(game:HttpGet( "https://raw.githubusercontent.com/Edvxtrykkkkk/NarsEdv-Plugin/refs/heads/main/main.lua"
        ))()
    end,
})
