-- function notify(msg)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(msg)
--     DrawNotification(true, false)
-- end

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = { msg, },
    })
end

-- Teleport to another player
RegisterNetEvent('kc_teleporter:goto', function(targetId)
    local playerId = source

    if IsPlayerAceAllowed(source, "kc_teleporter.goto") then
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

        TriggerClientEvent('kc_teleporter:teleport', playerId, targetPos)
    end
end)

-- TODO test this.
-- Moved to client.
-- Well this doesn't work.
-- RegisterCommand("teleport_fade", function (x, y, z)
--     TriggerClientEvent("kc_teleporter:teleport_fade", x, y, z, 180.0)
-- end, false)
