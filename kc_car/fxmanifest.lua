fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
    'car_c.lua',
    'car_spawns.lua',

    -- Extras
    'data/functions.lua',
    'data/paints.lua',
    'data/upgrades.lua',
    'data/vehicles.lua',
}

server_scripts {
    '@icmysql/library/MySQL.lua',
    'car_s.lua',
}
