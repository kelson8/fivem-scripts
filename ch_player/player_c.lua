---@diagnostic disable: missing-parameter
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
    local playerX = GetEntityCoords(ped).x
    local playerY = GetEntityCoords(ped).y
    local playerZ = GetEntityCoords(ped).z

    test = true
    -- Run test code, somewhat mimics C# preprocessors.
    if not test then
        notify("Your coords are: " .. GetEntityCoords(ped))
    else
        
        notify("Your coords are: " .. "X: " .. playerX .. " Y: " .. playerY .. " Z: " .. playerZ)
    end
end, false)

RegisterCommand("spawn", function()
    local ped = GetPlayerPed(PlayerId())
    -- middle_ls1 = vector3(222.2027, -864.0162, 30.2922)
    SetEntityCoords(PlayerPedId(), 222.2027, -864.0162, 29.2922, true, true, true, false)
    notify("You have been teleported to the spawn!")
end)

-- Create markers
-- https://forum.cfx.re/t/best-way-of-creating-markers/1961883/2
-- https://docs.fivem.net/natives/?_0x28477EC23D892089

RegisterCommand("playerid", function()
    notify("Your player id: " .. GetPlayerServerId(PlayerId()))
end)


RegisterCommand("getstatus", function()
    notify("Max wanted level: " .. GetMaxWantedLevel())
end)

RegisterCommand('kms', function()
    local ped = GetPlayerPed(PlayerId())
    SetEntityHealth(ped, 0)
end)