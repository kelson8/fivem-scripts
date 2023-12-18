--local spawnPos = vector3(686.245, 577.950, 130.461)
--local spawnPos = vector3(-1853.68, 2815.78, 32.81) -- Army base
local spawnPos = vector3(222.2027, -864.0162, 30.2922) -- Middle of Los santos

Citizen.CreateThread(function()
    exports.spawnmanager:setAutoSpawn(true) -- must be true for this to work
    -- Commenting out below code removes cooldown, that is why it kept doing without a cooldown
    -- https://docs.fivem.net/docs/resources/spawnmanager/functions/forceRespawn/
    -- while true do
    --     if IsEntityDead(PlayerPedId()) then -- check if the player is dead
    --         exports.spawnmanager:forceRespawn() -- forcefully respawn without a cooldown
    --     end
        -- Citizen.Wait(1000)
    -- end
end)

-- https://docs.fivem.net/docs/resources/chat/events/chat-addMessage/

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawnCallback(function()
        exports.spawnmanager:spawnPlayer({
            x = spawnPos.x,
            y = spawnPos.y,
            z = spawnPos.z,
            model = 'player_one' -- franklin
            --model = 'a_m_m_skater_01'
        })-- }, function()
        --     TriggerEvent('chat:addMessage', {
        --         args = { 'Welcome to kelson8\'s party!~' }
        --     })
        -- end)
    end)

    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)