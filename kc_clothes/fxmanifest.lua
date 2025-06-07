fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'kelson8'

-- Change and modify the players clothes, this requires kc_util
dependencies {
    'kc_util',
}

client_scripts {
    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',

    'client/enums.lua',
    'client/clothes_test.lua',
}

-- server_scripts {
    -- 'server/test.lua'
-- }