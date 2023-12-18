--local spawnPos = vector3(686.245, 577.950, 130.461)
--local spawnPos = vector3(-1853.68, 2815.78, 32.81) -- Army base
local spawnPos = vector3(222.2027, -864.0162, 30.2922) -- Middle of Los santos

Citizen.CreateThread(function()
    exports.spawnmanager:setAutoSpawn(true) -- must be true for this to work
end)

-- https://docs.fivem.net/docs/resources/chat/events/chat-addMessage/

AddEventHandler('onClientGameTypeStart', function()
    exports.spawnmanager:setAutoSpawn(true)
    exports.spawnmanager:forceRespawn()
end)