-- https://www.youtube.com/watch?v=EMrWIwB0TRw

Citizen.CreateThread(function()
    GlobalState.doors = Config.Doors
end)


-- /door <name> [1 locked, 0 unlocked]
RegisterCommand("door", function(source, args, rawCommand)
    local doorName = args[1]
    local lockState = tonumber(args[2])
    local doors = GlobalState.doors

    if not doorName or not doors[doorName] then
        return
    end

    if not lockState or (lockState ~= 0 and lockState ~= 1) then
        return
    end

    doors[doorName].Locked = lockState
    GlobalState.doors = doors

    -- DoorSystemSetDoorState("police_1", tonumber(args[1]), false, false)
    TriggerClientEvent("kc_doors:update", -1, doorName, lockState)
end, false)