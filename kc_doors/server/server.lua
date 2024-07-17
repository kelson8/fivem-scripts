-- https://www.youtube.com/watch?v=EMrWIwB0TRw

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = {msg, },
    })
end

Citizen.CreateThread(function()
    GlobalState.doors = Config.Doors
end)




-- /door <name> [1 locked, 0 unlocked]
RegisterCommand("door", function(source, args, rawCommand)
    local doorName = args[1]
    local lockState = tonumber(args[2])
    -- Get the door from the GlobalState, I'm not exactly sure how this works yet.
    -- TODO Look into how GlobalStates work in FiveM
    local doors = GlobalState.doors

    -- if not doorName or not doors[doorName] then
        
        if not doorName then
            sendMessage(source, "You did not specify a door to lock/unlock")
        elseif not doors[doorName] then
            sendMessage(source, ("Door %s doesn't exist!"):format(doorName))
            return
        end
        -- return
    -- end

    -- if not lockState or (lockState ~= 0 and lockState ~= 1) then
        if not lockState then
            sendMessage(source, "Lock state not entered")
            return
        elseif (lockState ~= 0 and lockState ~= 1) then
            sendMessage(source, "Invalid lock state! Valid values are 1 and 2.")
        end
    -- if not (lockState ~= 0 and lockState ~= 1) then
    -- This message shows instead of the "You didnt specify a door" message. 
        -- sendMessage(source, "Invalid lock state or lock state not entered! Valid values are 1 and 2.")
        -- return
    -- end

    doors[doorName].Locked = lockState
    GlobalState.doors = doors

    -- DoorSystemSetDoorState("police_1", tonumber(args[1]), false, false)
    TriggerClientEvent("kc_doors:update", -1, doorName, lockState)
    -- Todo Test this later, should say "You have locked/unlocked the door <name>."
    if lockState == 0 then
        sendMessage(source, ("You have unlocked the door %s."):format(doorName))
    elseif lockState == 1 then
        sendMessage(source, ("You have locked the door %s."):format(doorName))
    end
    -- sendMessage(source, ("You have set the %s the door to %s."):format(doorName, lockState))
end, false)

-- This seems to work now
-- TODO Setup this to where the doors are printed like this:
-- Doors: <name1>, <name2>, <etc...>
-- Instead of all on seperate lines.

RegisterCommand("doorlist", function(source, args, rawCommand)
    local doors = GlobalState.doors

    -- print(table.unpack(doors))
    for k,v in pairs(doors) do
        sendMessage(source, doors[k].DoorHash:gsub("\n", " "))
        -- sendMessage(source, table.unpack(doors[k].DoorHash))
    end
    -- sendMessage("")

end, false)
