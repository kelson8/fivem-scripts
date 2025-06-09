fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- https://forum.cfx.re/t/how-to-call-functions-from-another-lua-file-not-a-different-resource/4752847/3
client_scripts{

    -- Functions for easier usage, TeleportFade and other functions
    'client/new/functions.lua',

    -- Has notification, subtitle functions and a couple other things.
    'client/misc/messages.lua',
    'client/misc_test.lua',
    -- 'client/lobby_test.lua',
    'client/text.lua',
    'client/config.lua',

    'client/test.lua',
    'client/spawntables.lua',
    -- Helicopter testing
    'client/heli_test.lua',
    -- Ipl loading
    -- 'client/new_ipls.lua',
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
    
    'client/new/car_test.lua',

    -- Test with casino ambient audio
    'client/casino_test.lua',

    'client/new/task_heli_chase.lua',

    -- Skyswoop character switch screen test
    'client/new/skyswoop_test.lua',




    -- Sound test
    'client/sound_test.lua',

    -- Restrictions for wanted levels and other stuff.
    'client/population_functions.lua'
}

server_scripts{
    -- Server side testing
    'server/test.lua',


}
