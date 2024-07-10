
-- I should be able to use these for players in an apartment or interior that they can see outside of.
-- NetworkConcealPlayer() -- https://nativedb.dotindustries.dev/gta5/natives/0xBBDF066252829606
-- NetworkConcealEntity() -- https://nativedb.dotindustries.dev/gta5/natives/0x1632BE0AC1E62876
-- NetworkIsPlayerConcealed() -- https://nativedb.dotindustries.dev/gta5/natives/0x919B3C98ED8292F9
-- NetworkIsEntityConcealed() -- https://nativedb.dotindustries.dev/gta5/natives/0x71302EC70689052A

---@diagnostic disable: param-type-mismatch
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

-- TODO Setup permissions for these commands, players should not be able to set routing buckets I don't think.

-- This should disable peds in routing bucket 2, I may switch users over to this whenever they join a race
-- if the disable peds option is enabled
SetRoutingBucketPopulationEnabled(2, false)

RegisterCommand('getrtr', function(source, args)
    local targetId = args[1] or source
    local routingBucket = GetPlayerRoutingBucket(targetId)

    --notify("Your routing bucket is currently " .. routingBucket .. ".")
    if args[1] ~= nil then
        sendMessage(source, "Players routing bucket is currently " .. routingBucket .. ".")
    else
        sendMessage(source, "Your routing bucket is currently " .. routingBucket .. ".")
    end
end, false)

-- This is set to restricted, players shouldn't be able to access it without admin.
RegisterCommand('lobby', function(source, args)
    local targetId = args[1] or source
    local routingBucket = tonumber(args[2])

    local primaryRtr = 0 -- Main for all players.
    local lobbyMain = 1 -- Unused
    local disabledPopulation = 2 -- Disabled all vehicles and peds.

    SetPlayerRoutingBucket(targetId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    if args[2] ~= nil then

        sendMessage(source, "You have set your routing bucket to " .. routingBucket)
    end

    -- if args[2] == 0 then
        
    -- end
end, true)

RegisterCommand('gettargetid', function(source, args)
    --TODO Isn't this useless? Remapping source...
    -- local targetId = source
    sendMessage(source, "Your target id is: " .. source)
end, false)

-- RegisterCommand('getentityid', function(source, args)
--     -- Is this correct?
--     -- network
--     local entityId = NetworkGetNetworkIdFromEntity(source)
--     sendMessage(source, "Your entity id is: " .. entityId)
-- end, false)

RegisterCommand('lobbyentity', function(source, args)
    local entityId = NetworkGetEntityFromNetworkId(args[1])
    local routingBucket = tonumber(args[2])

    SetEntityRoutingBucket(entityId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    -- if args[2] ~= nil then
        sendMessage(source, "Entity " ..  entityId .. "(Net ID " .. args[1] .. ") has been moved to routing bucket " .. routingBucket)
    -- end
end, false)



-- Set this to work on entities also.
-- This isn't working, I'm quite sure this is needed on the server side and not the client.

-- This is set to restricted, players shouldn't be able to access it without admin.
-- RegisterCommand('lobby', function(source, args)
--     -- player = GetPlayerPed(-1)
    
--     -- How many routing buckets can I set?
--     primaryRtr = 0 -- Main for all players.
--     lobbyMain = 1

--     -- if args[1] ~= nil and GetPlayerRoutingBucket(player == primaryRtr) then
--     if args[1] ~= nil and GetPlayerRoutingBucket(source == primaryRtr) then
--         -- Would this work?
--         print("You have changed your routing bucket to " .. args[1] .. ".")
--         -- SetPlayerRoutingBucket(player, args[1])
--         SetPlayerRoutingBucket(source, args[1])
--     end
-- end, true)

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

