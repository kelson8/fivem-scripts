-- Todo Try and fix this and teleporter_s later

-- command to go to another player
-- TODO Test this
RegisterCommand('goto', function(_, args)
    local targetId = args[1]

    if not targetId then
        TriggerEvent('chat:addMessage', {
            args = { 'Please provide a target ID.', },
        })
        return
    end
    TriggerServerEvent('kc_teleporter:goto', targetId)
end, false)

-- command to bring a player to us
-- TODO Set this one up.
RegisterCommand('summon', function(_, args)
    local targetId = args[1]

    if not targetId then
        TriggerEvent('chat:addMessage', {
            args = { 'Please provide a target ID.', },
        })
        return
    end

    TriggerServerEvent('kc_teleporter:summon', targetId)
end, false)

-- an event that teleports us to a specific location
--RegisterNetEvent('kc_teleporter:teleport')
RegisterNetEvent('kc_teleporter:teleport', function(targetCoordinates)
    local player = GetPlayerPed(-1)

    SetEntityCoords(player, targetCoordinates.x, targetCoordinates.y, targetCoordinates.z, false, false, false, false)
end)


-- https://forum.cfx.re/t/teleport-player/4842105
-- Well this doesn't work on the server side, I was trying to do permissions for it.
-- RegisterNetEvent('kc_teleporter:teleport_fade', function(x, y, z, heading)
--     local player = GetPlayerPed(-1)

--     Teleports.TeleportFade(player, x, y, z, heading)
-- end)

-- https://forum.cfx.re/t/registercommand-and-how-to-pass-the-args-properly/240361/2
-- TODO Test this one, it's not server sided.
-- This doesn't seem to teleport, although it prints off the coordinates properly.
-- RegisterCommand("teleport_fade", function (source, args, raw)
--     local player = GetPlayerPed(-1)

--     if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
--         local x = tonumber(args[1])
--         local y = tonumber(args[2])
--         local z = tonumber(args[3])
--         Teleports.TeleportFade(player, x, y, z, 10.0)
--         Text.SendMessage(string.format("X: %f Y: %f, Z: %f", x, y, z))
--     end

-- end, false)
