RegisterCommand('+openhood', function()
    local playerId = PlayerPedId()
    local playerVehicle = GetVehiclePedIsIn(playerId, false)

    if playerVehicle <= 0 then
        return
    end
    if GetPedInVehicleSeat(playerVehicle, -1) ~= playerId then
        return
    end

    if GetVehicleDoorAngleRatio(playerVehicle, 4) > 0.1 then
        -- Its open, close it.
        SetVehicleDoorShut(playerVehicle, 4, false)
    else
        -- It's closed, open it.
        SetVehicleDoorOpen(playerVehicle, 4, false, false)
    end
end)

RegisterCommand('+opentrunk', function()
    local playerId = PlayerPedId()
    local playerVehicle = GetVehiclePedIsIn(playerId, false)

    if playerVehicle <= 0 then
        return
    end
    if GetPedInVehicleSeat(playerVehicle, -1) ~= playerId then
        return
    end

    if GetVehicleDoorAngleRatio(playerVehicle, 5) > 0.1 then
        -- Its open, close it.
        SetVehicleDoorShut(playerVehicle, 5, false)
    else
        -- It's closed, open it.
        SetVehicleDoorOpen(playerVehicle, 5, false, false)
    end
end)

-- These below can be setup to use controller mappings.
RegisterKeyMapping('+openhood', 'Open Vehicle Hood', 'keyboard' ,'PAGEUP')
RegisterKeyMapping('+opentrunk', 'Open Vehicle Trunk', 'keyboard' ,'PAGEDOWN')
-- Possible controller mappings:
--RegisterKeyMapping('+openhood', 'Open Vehicle Hood', 'pad_digitalbutton', 'LDOWN_INDEX')



RegisterCommand('+openwindows', function()
    local playerId = PlayerPedId()
    local playerVehicle = GetVehiclePedIsIn(playerId, false)

    if playerVehicle <= 0 then
        return
    end

    if GetPedInVehicleSeat(playerVehicle, -1) ~= playerId then
        return
    end

    if playerVehicle > 0 and GetPedInVehicleSeat(playerVehicle, -1) == playerId then
        RollDownWindows(playerVehicle)
    end

end, false)

RegisterCommand('+closewindows', function()
    local playerId = PlayerPedId()
    local playerVehicle = GetVehiclePedIsIn(playerId, false)

    if playerVehicle <= 0 then
        return
    end

    if GetPedInVehicleSeat(playerVehicle, -1) ~= playerId then
        return
    end

    if playerVehicle > 0 and GetPedInVehicleSeat(playerVehicle, -1) == playerId then
        RollUpWindow(playerVehicle, 0)
        RollUpWindow(playerVehicle, 1)
        RollUpWindow(playerVehicle, 2)
        RollUpWindow(playerVehicle, 3)
    end


end)

RegisterKeyMapping('+openwindows', 'Open Vehicle Windows', 'keyboard', 'DELETE')
RegisterKeyMapping('+closewindows', 'Close Vehicle Windows', 'keyboard', 'INSERT')


-- CreateThread(function()
--     while true do
--         Wait(0)
--         local playerId = PlayerPedId()
--         local playerVehicle = GetVehiclePedIsIn(playerId, false)

--         if playerVehicle > 0 and GetPedInVehicleSeat(playerVehicle, -1) == playerId then
--             -- Delete key, open windows
--             if IsControlJustPressed(0, 214) then
--                 RollDownWindows(playerVehicle)
--             end

--             -- Insert key, close windows
--             if IsControlJustPressed(0, 121) then
--                 RollUpWindow(playerVehicle, 0)
--                 RollUpWindow(playerVehicle, 1)
--                 RollUpWindow(playerVehicle, 2)
--                 RollUpWindow(playerVehicle, 3)
--             end
--         end
--     end
-- end)

-- CreateThread(function()
--     while true do
--         Wait(0)

--         local playerId = PlayerPedId()
--         local playerVehicle = GetVehiclePedIsIn(playerId, false)

--         if playerVehicle > 0 and GetPedInVehicleSeat(playerVehicle, -1) == playerId then
--             if IsControlJustReleased(0, 208) then
--                 if GetVehicleDoorAngleRatio(playerVehicle, 4) > 0.1 then
--                     -- Its open, close it.
--                     SetVehicleDoorShut(playerVehicle, 4, false)
                    
--                 else
--                     -- It's closed, open it.
--                     SetVehicleDoorOpen(playerVehicle, 4, false, false)
--                 end         
--             end

--             if IsControlJustPressed(0, 207) then
--                 if GetVehicleDoorAngleRatio(playerVehicle, 5) > 0.1 then
--                     -- Its open, close it.
--                     SetVehicleDoorShut(playerVehicle, 5, false)
                    
--                 else
--                     -- It's closed, open it.
--                     SetVehicleDoorOpen(playerVehicle, 5, false, false)
--                 end
--             end
--         end
--     end
-- end)

