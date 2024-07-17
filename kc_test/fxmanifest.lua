fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- https://forum.cfx.re/t/how-to-call-functions-from-another-lua-file-not-a-different-resource/4752847/3
client_scripts{
    -- Has notification, subtitle functions and a couple other things.
    'client/misc_test.lua',
    'client/lobby_test.lua',
    -- "@NativeUILua_Reloaded/src/NativeUIReloaded.lua",
    --'client/menu_test.lua',
    'client/text.lua',
    'client/config.lua',

    'client/test.lua',
    'client/spawntables.lua',
    -- Helicopter testing
    'client/heli_test.lua',
    -- Other test
    'client/checkpoint_test.lua',
    'client/ped_test.lua',
    'client/player_test.lua',
    'client/vehicle_test.lua',
    'client/time_functions.lua',

    'client/stats_test.lua',
    'client/get_killed_ped.lua',

    'client/data/warps.lua',

    -- Events
    'client/events.lua',

    -- Test
    'client/misc/scaleform_test.lua',
}

server_scripts{
    'server/lobby_test.lua',
    -- Server side testing
    'server/test.lua',
}