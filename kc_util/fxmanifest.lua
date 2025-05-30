fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- This script should load before all my scripts, so other scripts that use the kc_util resource can use it.

-- TODO Setup this resource to attempt to move notify and sendMessage out of the files.
-- I should be able to export these functions and run them.

client_scripts{
    'client/util.lua',
}

-- TODO Test these
-- https://forum.cfx.re/t/calling-a-function-from-a-different-resource/1415243
-- Export the functions for use outside this resource.
export 'notify'
export 'sendMessage'

-- server_scripts{
--     'server/util.lua'
-- }
