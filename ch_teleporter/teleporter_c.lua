-- command to go to another player
RegisterCommand('goto', function(_, args)
    local targetId = args[1]

    if not targetId then
        TriggerEvent('chat:addMessage', {
            args = { 'Please provide a target ID.', },
        })
        return
    end
    TriggerServerEvent('ch_teleporter:goto', targetId)
end)

-- command to bring a player to us
RegisterCommand('summon', function(_, args)
    local targetId = args[1]

    if not targetId then
        TriggerEvent('chat:addMessage', {
            args = { 'Please provide a target ID.', },
        })
        return
    end

    TriggerServerEvent('ch_teleporter:summon', targetId)
end)

-- an event that teleports us to a specific location
--RegisterNetEvent('ch_teleporter:teleport')
RegisterNetEvent('ch_teleporter:teleport', function(targetCoordinates)
    local playerPed = playerPedId()

    SetEntityCoords(playerPed, targetCoordinates)
end)
