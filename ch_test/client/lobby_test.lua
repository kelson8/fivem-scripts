-- Set this to work on entities also.

RegisterCommand('lobby', function(source, args)
    player = GetPlayerPed(-1)
    
    -- How many routing buckets can I set?
    primaryRtr = 0 -- Main for all players.
    lobbyMain = 1

    -- This check doesn't seem to be needed
    if(GetPlayerRoutingBucket(player == primaryRtr)) then
        -- Would this work?
        print("You have changed your routing bucket to " .. args[1] .. ".")
        SetPlayerRoutingBucket(player, args[1])
    end
end)

--SetRoutingBucketEntityLockdownMode(id, string)
--SetRoutingBucketPopulationEnabled(id, true) -- True for population, False for none.

RegisterCommand('getrtr', function(source, args)
    player = GetPlayerPed(-1)

    if(GetPlayerRoutingBucket(player == 0)) then
        print("You are in the primary routing bucket.")
    else
        print("You are in routing bucket " .. GetPlayerRoutingBucket(source) .. ".")
    end
end)

