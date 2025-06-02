---@diagnostic disable: duplicate-set-field
------------ 
--- Teleport functions
------------


Teleports = {}
Text = {}

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


------------
-- Message/Notifcation functions
------------

function Text.SendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end


function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end