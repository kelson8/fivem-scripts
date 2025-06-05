fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- Restrictions for weapons in certain interiors.
-- This requires kc_util
dependencies {
    'kc_util',
}

client_scripts {
    -- This works for my utility functions, exported from kc_util.
    '@kc_util/client/util.lua',

    'client/weapon_restrictions.lua',
}

-- server_scripts {
    -- 'server/weapon_restrictions.lua'
-- }