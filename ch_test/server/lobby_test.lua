-- This seems to be working, test with two clients when I get home.
function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = {msg, },
    })
end

RegisterCommand('getrtr', function(source, args)
    local targetId = args[1] or source
    local routingBucket = GetPlayerRoutingBucket(targetId)

    --notify("Your routing bucket is currently " .. routingBucket .. ".")
    sendMessage(source, ("Your routing bucket is currently " .. routingBucket .. "."))

end)

RegisterCommand('lobby', function(source, args)
    local targetId = args[1] or source
    local routingBucket = tonumber(args[2])

    SetPlayerRoutingBucket(targetId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    -- if args[2] ~= nil then
        sendMessage(source, "You have set your routing bucket to " .. routingBucket)
    -- end
end)

RegisterCommand('lobbyentity', function(source, args)
    local entityId = NetworkGetEntityFromNetworkId(args[1])
    local routingBucket = tonumber(args[2])

    SetEntityRoutingBucket(entityId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    -- if args[2] ~= nil then
        sendMessage(source, "Entity " ..  entityId .. "(Net ID " .. args[1] .. ") has been moved to routing bucket " .. routingBucket)
    -- end
end)

-- Set this to work on entities also.
-- This isn't working, I'm quite sure this is needed on the server side and not the client.

-- RegisterCommand('lobby', function(source, args)
--     player = GetPlayerPed(-1)
    
--     -- How many routing buckets can I set?
--     primaryRtr = 0 -- Main for all players.
--     lobbyMain = 1

--     -- This check doesn't seem to be needed
--     if(GetPlayerRoutingBucket(player == primaryRtr)) then
--         -- Would this work?
--         print("You have changed your routing bucket to " .. args[1] .. ".")
--         SetPlayerRoutingBucket(player, args[1])
--     end
-- end)

-- --SetRoutingBucketEntityLockdownMode(id, string)
-- --SetRoutingBucketPopulationEnabled(id, true) -- True for population, False for none.

-- RegisterCommand('getrtr', function(source, args)
--     player = GetPlayerPed(-1)

--     if(GetPlayerRoutingBucket(player == 0)) then
--         print("You are in the primary routing bucket.")
--     else
--         print("You are in routing bucket " .. GetPlayerRoutingBucket(player) .. ".")
--     end
-- end)

