Menus = {}

Buttons = {}

local menu = GetMenu()

-- musicMenu = MenuV:CreateMenu("Music", "Music Menu", "topleft", 255, 0, 0, "size-110", "default",
Menus.MusicMenu = MenuV:CreateMenu("Music", "Music Menu", "topleft", 255, 0, 0, "size-110", "default",
        "menuv", "musicMenuNamespace", "native")

-- musicMenuButton = menu:AddButton({ label = "Music Menu", description = 'Open Music Menu' })
Buttons.MusicMenuButton = menu:AddButton({ label = "Music Menu", description = 'Open Music Menu' })

-- startArenaWarMusicButton = musicMenu:AddButton({
Buttons.StartArenaWarMusicButton = Menus.MusicMenu:AddButton({
    label = "Arena War Music",
    description =
    "Start Arena war music."
})

-- stopMusicButton = musicMenu:AddButton({
Buttons.StopMusicButton = Menus.MusicMenu:AddButton({
    label = "Stop Music",
    description =
    "Stop music."
})

-----------
-- Music menu button
-----------
---
-- musicMenuButton:On("select", function ()
Buttons.MusicMenuButton:On("select", function ()
    -- MenuV:OpenMenu(musicMenu, function ()
    MenuV:OpenMenu(Menus.MusicMenu, function ()

        -- startArenaWarMusicButton:On("select", function ()
        Buttons.StartArenaWarMusicButton:On("select", function ()
            Music.PlayArenaWarTheme()
        end)

        -- stopMusicButton:On("select", function ()
        Buttons.StopMusicButton:On("select", function ()
            Music.Stop()
        end)

    end)
end)