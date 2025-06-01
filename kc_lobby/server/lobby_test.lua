
-- I should be able to use these for players in an apartment or interior that they can see outside of.
-- NetworkConcealPlayer() -- https://nativedb.dotindustries.dev/gta5/natives/0xBBDF066252829606
-- NetworkConcealEntity() -- https://nativedb.dotindustries.dev/gta5/natives/0x1632BE0AC1E62876
-- NetworkIsPlayerConcealed() -- https://nativedb.dotindustries.dev/gta5/natives/0x919B3C98ED8292F9
-- NetworkIsEntityConcealed() -- https://nativedb.dotindustries.dev/gta5/natives/0x71302EC70689052A

-- This file is disabled, not active in the fxmanifest.

---@diagnostic disable: param-type-mismatch
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
        -- sendMessage(source, ("Player %s routing bucket is currently %s") .. routingBucket .. ".")
        sendMessage(source, ("Player %s routing bucket is currently %s."):format(
            targetId, routingBucket))
    else
        -- sendMessage(source, "Your routing bucket is currently %s" .. routingBucket .. ".")
        sendMessage(source, ("Your routing bucket is currently %s."):format(
            routingBucket)) 
        end
end, false)

local primaryRtr = 0 -- Main for all players.
local lobbyMain = 1 -- Unused
local disabledPopulation = 2 -- Disabled all vehicles and peds.

-- This is set to restricted, players shouldn't be able to access it without admin.
RegisterCommand('lobby', function(source, args)
    local targetId = args[1] or source
    local routingBucket = tonumber(args[2])

    -- Get the name of the target player.
    local targetName = GetPlayerName(targetId)



    SetPlayerRoutingBucket(targetId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    if args[2] ~= nil then
        sendMessage(source, ("You have set %s to routing bucket %s."):format(
            targetName, routingBucket
        ))
    else
        sendMessage(source, ("You have set your routing bucket to %s."):format(
            routingBucket
        ))
        -- sendMessage(source, "You have set %s to routing bucket %s." .. routingBucket)
    end

    -- if args[2] == 0 then
        
    -- end
end, true)


-- This is going to be allowed for all players if they aren't in a race, I can setup routing bucket 2 to be toggled on/off.
-- This works.
-- TODO Set this to be restricted when a race is started using the StreetRaces resource
RegisterCommand('racelobby', function(source, args)
    local targetId = source

    if GetPlayerRoutingBucket(source) == 0 then
        SetPlayerRoutingBucket(source, 2)
        sendMessage(source, "You have joined the race lobby.")
    elseif GetPlayerRoutingBucket(source) == 2 then
        SetPlayerRoutingBucket(source, 0)
        sendMessage(source, "You have left the race lobby.")
    end


end, false)

-- Make a hub command to bring the player back to the default routing bucket
RegisterCommand('hub', function(source, args)
    SetPlayerRoutingBucket(source, 0)
    sendMessage(source, "You have been returned to the main lobby.")
end, true)

RegisterCommand('gettargetid', function(source, args)
    -- local targetId = args[1] or source
    -- This didn't seem to work.
   
    -- local player = GetPlayerPed()
    local targetEntityId = NetworkGetEntityFromNetworkId(args[1])

    -- local targetPed = GetPlayerPed(args[1])
    -- TODO Fix the other player part of this command.
    if args[1] ~= nil then
        sendMessage(source, args[1] .. "'s target ID: " .. targetEntityId)
    else
        sendMessage(source, "Your target ID: " .. source)
    end
end, false)

-- RegisterCommand('getentityid', function(source, args)
--     -- Is this correct?
--     -- network
--     local entityId = NetworkGetNetworkIdFromEntity(source)
--     sendMessage(source, "Your entity id is: " .. entityId)
-- end, false)

RegisterCommand('lobbyentity', function(source, args)
    local entityId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    -- local entityId = tonumber(args[1])
    local routingBucket = tonumber(args[2])

    SetEntityRoutingBucket(entityId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    -- if args[2] ~= nil then
        sendMessage(source, "Entity " ..  entityId .. "(Net ID " .. args[1] .. ") has been moved to routing bucket " .. routingBucket)
    -- end
end, true)

-- TODO Test this.
-- This seems to work now.
-- This says Tried to access invalid entity
RegisterNetEvent("ch_test:setEntityRtr")
AddEventHandler("ch_test:setEntityRtr", function(entityId, routingBucket)
    -- local NetId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    local netId = NetworkGetEntityFromNetworkId(entityId)
    -- local routingBucket = tonumber(args[2])

    -- if args[1] and args[2] ~= nil then
        SetEntityRoutingBucket(netId, routingBucket)
        sendMessage(source, ("You have set the routing bucket of %s to %s"):format(netId, routingBucket))
    -- end
end)

-- This works! 7-13-2024 @ 3:15AM
-- This sets the routing bucket of the player and the vehicle.
-- entityId, playerId, routingBucket

-- TODO Figure out how to get the vehicle id if not in the vehicle, such as another player.
RegisterCommand("lobbyall", function(source, args)

    local entityId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    -- local playerId = NetworkGetEntityFromNetworkId(tonumber(args[2]))
    local playerId = tonumber(args[2]) or source
    local routingBucket = tonumber(args[3])

    SetEntityRoutingBucket(entityId, routingBucket)
    SetPlayerRoutingBucket(playerId, routingBucket)
    -- SetPlayerRoutingBucket(source, routingBucket)
    if args[1] and args[2] and args[3] ~= nil then
        -- sendMessage(source, "Entity " ..  entityId .. "(Net ID " .. args[1] .. ") has been moved to routing bucket " .. routingBucket)
        sendMessage(source,
        ("Entity %s (Net ID %s) and player %s (Net ID %s) has been moved to routing bucket %s."):format(
            entityId, args[1], playerId, args[2], routingBucket
        ))
    end

end, true)



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

