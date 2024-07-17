---@diagnostic disable: param-type-mismatch

function notifyPlayer(source, msg)
    -- Add custom notification here (use chat by default)
    -- TriggerClientEvent('chatMessage', source, "[StreetRaces]", {255, 0, 0}, msg)
    -- This works! My first time doing client to server events.
    TriggerClientEvent("ch_test:notifyClient", source, msg)
end

RegisterServerEvent("ch_test:ping")
AddEventHandler("ch_test:ping", function()
    local src = source
    local ping = GetPlayerPing(src)
    TriggerClientEvent("ch_test:returnPing", src, ping)
end)

--

-- RegisterCommand("getvehicle", function()
--     -- if IsPedInAnyVehicle(source, false) then
--         notifyPlayer(source, "Current vehicle: " .. GetVehiclePedIsIn(source, false))
--     -- end
-- end, false)

RegisterCommand("getidenfier", function(source)
    local playerId = GetPlayerIdentifier(source)
    notifyPlayer(source, ("Player id is %s."):format(playerId))

end, false)

RegisterNetEvent("kc_test:getPlayerIdentifier")
AddEventHandler("kc_test:getPlayerIdentifier", function()
    local player = GetPlayerPed(-1)
    local playerId = GetPlayerIdentifier(player)
    notify(playerId)
end)

RegisterCommand("playerid", function()
    -- local player = GetPlayerPed(-1)
    local playerId = GetPlayerIdentifier(source, 1)
    notifyPlayer(source, playerId)
end, false)

-- Permission test

