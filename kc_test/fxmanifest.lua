fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- https://forum.cfx.re/t/how-to-call-functions-from-another-lua-file-not-a-different-resource/4752847/3
client_scripts{
    -- Has notification, subtitle functions and a couple other things.
    'client/misc/messages.lua',
    'client/misc_test.lua',
    'client/lobby_test.lua',
    'client/text.lua',
    'client/config.lua',

    'client/test.lua',
    'client/spawntables.lua',
    -- Helicopter testing
    'client/heli_test.lua',
    -- Ipl loading
    'client/new_ipls.lua',
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

    -- Misc Test
    'client/misc/scaleform_test.lua',
    'client/misc/holograms_test.lua',
    'client/misc/blip_test.lua',
    'client/new_test.lua',
    'client/clock_test.lua',
    'client/new/task_heli_chase.lua',

    -- Sound test
    'client/sound_test.lua'
}

server_scripts{
    'server/lobby_test.lua',
    -- Server side testing
    'server/test.lua',
}