Menus = {}

Buttons = {}

local menu = GetMenu()

StartArenaWarMusicButton = MusicMenu:AddButton({
    label = "Arena War Music",
    description =
    "Start Arena war music."
})

StopMusicButton = MusicMenu:AddButton({
    label = "Stop Music",
    description =
    "Stop music."
})

-----------
-- Music menu button
-----------
---
MusicMenuButton:On("select", function ()
    MenuV:OpenMenu(MusicMenu, function ()

        StartArenaWarMusicButton:On("select", function ()
            Music.PlayArenaWarTheme()
        end)

        StopMusicButton:On("select", function ()
            Music.Stop()
        end)

    end)
end)