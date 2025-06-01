fx_version 'cerulean'
game 'gta5'
lua54 'yes'

-- Moved routing buckets into a new resource for testing.

client_scripts {
    'client/routing_bucket_commands.lua',
}

server_scripts {
    -- New test for routing buckets:
    -- https://forum.cfx.re/t/tutorial-how-to-use-routing-buckets-easily-the-correct-way-to-instance-people/2485164
    'server/routing_buckets.lua',

    -- Old routing bucket test:
    -- 'server/lobby_test.lua'
}