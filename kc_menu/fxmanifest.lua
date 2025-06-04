fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This requires menuv.
dependencies {
    'menuv',
    'kc_util'
}

client_scripts{
    '@menuv/menuv.lua',

    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',


    -- My enums from some of my C++ headers
    'client/enums.lua',



    -- Warp config
    'client/config/warp_config.lua',


    'client/functions/functions.lua',
    'client/functions/warp_functions.lua',
    'client/functions/stat_functions.lua',
    'client/functions/vehicle_functions.lua',

    'client/functions/change_outfit.lua',
    'client/functions/player_functions.lua',

    'client/config.lua',
    -- 'client/functions.lua',
    -- Content for my debug menu, draws a display under the KCNet test message
    'client/debug_text.lua',
    'client/text.lua',
    
    'client/native_test.lua',
    'client/heli_test.lua',

    -- Main menu
    'client/menu.lua',
    -- Warps
    'client/warps.lua',

    -- Menus, new format.
    'client/menus/player_menu.lua',
    'client/menus/music_menu.lua',
    -- 'client/menus/test_menu.lua',
    -- 'client/menus/vehicle_menu.lua',
    -- 'client/menus/warp_menu.lua',

    --'functions.lua',
    --'menu.lua'


}

server_scripts{
    'server/permissions.lua'
}
