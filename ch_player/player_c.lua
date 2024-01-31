-- Make the player invincible
--[[
local isInvincible = false

function toggleInvincibility()
    local isInvincible = not isInvincible
    SetEntityInvincible(PlayerPedId(), isInvincible)
end
]]

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- This needs to be implemented on the server side, it doesn't work on the client.
-- Trying to make the interior number log to a file, still not really sure how to use server events.
-- https://forum.cfx.re/t/data-from-client-to-server/1916033
-- function textWrite(text)
--     log = io.open("resources/"..GetCurrentResourceName.."/log.txt", "a")
--     if log then
--         log:write(text)
--     else
--         print("Log file doesn't exist")
--     end
--     log:close()
-- end

-- This works for getting interiors that that the player is in.
-- Added > 0, everytime a player is outside their interior should be 0 and the else statement is working.
RegisterCommand('getinterior', function(source, args)
    local ped = GetPlayerPed(PlayerId())
    if(GetInteriorFromEntity(ped) > 0) then
        notify("You are in an interior: " .. GetInteriorGroupId(GetInteriorFromEntity(ped)))
        -- TriggerServerEvent("interiorLog")
        -- textWrite("Player ".. GetPlayerName(ped) .. "was in interior id: " .. GetInteriorFromEntity(ped))
    else
        notify("You are not in an interior.")
    end
end, false)

RegisterCommand('pos', function(source, args)
    local ped = GetPlayerPed(PlayerId())
    
    notify("Your coords are: " .. GetEntityCoords(ped))
    
end, false)

-- Create markers
-- https://forum.cfx.re/t/best-way-of-creating-markers/1961883/2
-- https://docs.fivem.net/natives/?_0x28477EC23D892089
-- This works! Now to figure out how to make this teleport the player
local target = {x = -676.0, y = 94.0, z = 54.5}

Citizen.CreateThread(function()
    while true do
        DrawMarker(1, target.x, target.y, target.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 255, false, false, 2, true, nil, nil, false)
    Citizen.Wait(1)
    end
end)

-- Disabled god mode
-- RegisterCommand('god', function(source, args)
    -- god = not god
    -- local ped = GetPlayerPed(PlayerId())
    -- if god then
        -- SetEntityInvincible(GetPlayerPed(ped), true)
        -- SetEntityInvincible(ped, true)
        -- TriggerEvent('chat:addMessage', {
            -- args = { 'You have enabled god mode! ' }
        -- })
        -- notify("~g~God Mode On")
    -- else
        -- SetEntityInvincible(GetPlayerPed(ped), false)
        -- SetEntityInvincible(ped, false)
        -- TriggerEvent('chat:addMessage', {
            -- args = { 'You have disabled god mode! ' }
        -- })
        -- notify("~r~God Mode Off")
    -- end
  -- end, false)

RegisterCommand('kms', function()
    local ped = GetPlayerPed(PlayerId())
    SetEntityHealth(ped, 0)
end)