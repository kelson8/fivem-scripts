---@diagnostic disable: missing-parameter, duplicate-set-field
-- Make the player invincible
--[[
local isInvincible = false

function toggleInvincibility()
    local isInvincible = not isInvincible
    SetEntityInvincible(PlayerPedId(), isInvincible)
end
]]

------------ 
--- Teleport functions
------------


local Teleports = {}

-- Taken from functions.lua in kc_menu
--- https://forum.cfx.re/t/esx-want-to-teleport-player-with-his-vehicle/4880346
--- Teleport with a fade, also teleports the player vehicle if they are in one.
---@param x any
---@param y any
---@param z any
---@param heading any
function Teleports.TeleportFade(x, y, z, heading)
    local player = GetPlayerPed(-1)
    local fadeInTime = 500
    local fadeOutTime = 500

    DoScreenFadeOut(fadeOutTime)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    if IsPedInAnyVehicle(player, false) then
        local currentVeh = GetVehiclePedIsIn(player, false)
        SetEntityCoords(currentVeh, x, y, z, false, false, false, false)
        SetEntityHeading(currentVeh, heading)
    else
        SetEntityCoords(player, x, y, z, false, false, false, false)
        SetEntityHeading(player, heading)
    end



    Wait(fadeInTime)
    DoScreenFadeIn(fadeInTime)
end


------------
-- Math functions
------------

-- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
-- This works for stripping the extra digits from the coords
function Truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end


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
    -- local playerX = GetEntityCoords(ped).x
    local playerX = Truncate(GetEntityCoords(ped).x, 3)
    local playerY = Truncate(GetEntityCoords(ped).y, 3)
    local playerZ = Truncate(GetEntityCoords(ped).z, 3)

    test = true
    -- Run test code, somewhat mimics C# preprocessors.
    if not test then
        notify("Your coords are: " .. GetEntityCoords(ped))
    else
        
        notify("Your coords are: " .. "X: " .. playerX .. " Y: " .. playerY .. " Z: " .. playerZ)
    end
end, false)




-- Adapted to use my new command format
RegisterCommand("spawn", function()
    local player = GetPlayerPed(PlayerId())
    if IsPedInAnyVehicle(player, false) then
        Teleports.TeleportFade(PlayerConfig.SpawnX, PlayerConfig.SpawnY, PlayerConfig.SpawnZ, 10.0)
    else
        Teleports.TeleportFade(PlayerConfig.SpawnX, PlayerConfig.SpawnY, PlayerConfig.SpawnZ, 10.0)

    end
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

-- Basic test for logging coords to a file.
RegisterCommand("logcoords", function ()
    -- TriggerServerEvent("kc_player:log", "Test log text")

    local ped = GetPlayerPed(PlayerId())
    -- local playerX = GetEntityCoords(ped).x
    local playerX = Truncate(GetEntityCoords(ped).x, 3)
    local playerY = Truncate(GetEntityCoords(ped).y, 3)
    local playerZ = Truncate(GetEntityCoords(ped).z, 3)
    local playerHeading = Truncate(GetEntityHeading(ped), 3)

    TriggerServerEvent("kc_player:log", string.format("X: %f, Y: %f, Z: %f, Heading: %f\n", playerX, playerY, playerZ, playerHeading))
end, false)