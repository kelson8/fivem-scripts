--local spawnPos = vector3(686.245, 577.950, 130.461)
--local spawnPos = vector3(-1853.68, 2815.78, 32.81) -- Army base
local spawnPos = vector3(222.2027, -864.0162, 30.2922) -- Middle of Los santos

-- TODO Make this get a list of values from spawns.lua 

--for k,v in pairs(player_spawns) do
--    print(v,[3])
--end

--x = player_spawns.x

function loadSpawns()
    local data = json.decode(player_spawns)

    for i, spawns in ipairs(data.spawns) do
        print(spawns)
    end

end


-- RegisterCommand('spawns', function()
--     --loadSpawns(player_spawns)

--     -- This grabs the x coord on both of the spawn locations, try to narrow it down to one.
--     for i, spawns in ipairs(player_spawns) do
--         print (spawns.x)
--     end

-- end, false)



-- I'm quite sure this might fix the players not being able to respawn.
-- Yes, this works without a cooldown and without needing ch_gamemode, and ch_map
-- Citizen.CreateThread(function()
--     exports.spawnmanager:setAutoSpawn(true) -- must be true for this to work
--     while true do
--         if IsEntityDead(PlayerPedId()) then -- check if the player is dead
--             exports.spawnmanager:forceRespawn() -- forcefully respawn without a cooldown
--         end
--         Citizen.Wait(1000)
--     end
-- end)

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