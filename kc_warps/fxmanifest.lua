fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- Setup warp markers and warp commands, this requires kc_util
dependencies {
    'kc_util',
}

client_scripts {

    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',

    'client/locations.lua',
    'client/warp_locations.lua',
    'client/warps.lua',
    'client/markers.lua',
}