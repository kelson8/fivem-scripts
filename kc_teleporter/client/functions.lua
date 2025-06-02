---@diagnostic disable: duplicate-set-field
Teleports = {}
Text = {}


------------
-- Message/Notifcation functions
------------

-- Notifications

-- function Text.SendMessage(msg)
function Text.SendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

-- function notify(msg)
function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function Text.ShowAdvancedNotification(message, sender, subject, textureDict, iconType, saveToBrief, color)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    ThefeedNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, saveToBrief)
end

------------ 
--- Teleport functions
------------

-- Taken from functions.lua in kc_menu
--- TODO Make this teleport the vehicle also, if the player is in one.
--- https://forum.cfx.re/t/esx-want-to-teleport-player-with-his-vehicle/4880346
--- Teleport with a fade
---@param x any
---@param y any
---@param z any
---@param heading any
function Teleports.TeleportFade(player, x, y, z, heading)
    -- local player = GetPlayerPed(-1)
    local fadeInTime = 500
    local fadeOutTime = 500

    DoScreenFadeOut(fadeOutTime)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    -- TODO Test this new method.
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