-- https://forum.cfx.re/t/howto-send-discord-messages-with-cfx-server/25299

-- So far I have this setup to display chat messages in discord.

-- To use this:
-- 1. Add your discord web hook url to config_example.lua.
-- 2. Then rename the file to 'config.lua' and it should work.

-- It gets the discord web hook url from the config.lua.

-- TODO Setup this to get the chat from discord to display in game.

AddEventHandler('chatMessage', function(source, name, message)
    --   PerformHttpRequest('DISCORD_URL', function(err, text, headers) end,
    PerformHttpRequest(Config.DiscordWebHookUrl, function(err, text, headers) end,
        'POST',
        json.encode({ username = name, content = message }),
        { ['Content-Type'] = 'application/json' })
end)
