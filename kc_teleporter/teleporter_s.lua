-- function notify(msg)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(msg)
--     DrawNotification(true, false)
-- end

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = {msg, },
    })
end

RegisterNetEvent('ch_teleporter:goto', function(targetId)
    local playerId = source

    -- get entity handle of target
    local targetPed = GetPlayerPed(targetId)

    -- Replace playerId or anything to -1 and that will send the message to all clients that are connected.
    -- if targetPed <= 0 then
    --     sendMessage(source, "That player doesn't seem to exist!")
    --     return
    -- end

    -- get coordniates of the target
    local targetPos = GetEntityCoords(targetPed)
    
    -- send the coordinates to the client so it can go to the target

    TriggerClientEvent('ch_teleporter:teleport', playerId, targetPos)

end)

