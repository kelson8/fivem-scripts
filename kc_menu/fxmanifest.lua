fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts{
    '@menuv/menuv.lua',

    -- My enums from some of my C++ headers
    'client/enums.lua',

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
    'client/menu.lua',
    'client/warps.lua',
    --'functions.lua',
    --'menu.lua'


}

server_scripts{
    'server/permissions.lua'
}
