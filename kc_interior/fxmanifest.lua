fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'kelson8'

-- https://github.com/Bob74/bob74_ipl/wiki/How-to-interact-with-an-interior

-- Change and modify some interiors, this requires bob74_ipl and kc_util
dependencies {
    'kc_util',
    'bob74_ipl'
}

client_scripts {
    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',

    'client/customize_arcade.lua',
    'client/customize_chop_shop.lua',
    'client/customize_others.lua',
    -- 'client/customize_casino.lua',
}

-- server_scripts {
    -- 'server/weapon_restrictions.lua'
-- }