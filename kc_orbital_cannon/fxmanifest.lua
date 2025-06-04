fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This requires kc_util
dependencies {
    'kc_util',
}

client_scripts {
    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',

    -- 'client/config.lua',
    -- 'client/functions.lua',
    'client/orbital_cannon.lua',
}

-- server_scripts {
--     'server/orbital_cannon.lua',
-- }
