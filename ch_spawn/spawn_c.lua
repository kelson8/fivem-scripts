--local spawnPos = vector3(686.245, 577.950, 130.461)
--local spawnPos = vector3(-1853.68, 2815.78, 32.81) -- Army base
local spawnPos = vector3(222.2027, -864.0162, 30.2922) -- Middle of Los santos

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            --model = 'SupermanBvS' -- superman skin, the cape didn't work right
            model = 'player_one' -- franklin
            --model = 'a_m_m_skater_01'
        }, function()
            triggerEvent('chat:addMessage', {
                args = { 'Welcome to kelson8\'s party!~' }
            })
        end)
    end)

    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)