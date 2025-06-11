---@diagnostic disable: duplicate-set-field
-- Message functions

-- https://forum.cfx.re/t/calling-a-function-from-a-different-resource/1415243

Animation = {}
Fade = {}

Text = {}
Teleports = {}


-- To use this in another resource:
-- First, make this required in the dependices of fxmanifest.lua:
-- This resource requires kc_util
-- dependencies {
    -- 'kc_util'
-- }

-- At the top of client_scripts in fxmanifest.lua:
-- client_scripts{
    -- This works for my utility functions, exported from kc_util.
    -- '@kc_util/client/util.lua',
-- }


-- Then to use this in another resource:
-- exports.kc_util:Notify("Model doesn't exist!")


------------
-- Animation functions
-- TODO Test these
------------
function Animation.Request(animDict)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
end

-- Remove an animation dict
function Animation.Remove(animDict)
    if DoesAnimDictExist(animDict) then
        RemoveAnimDict(animDict)
    end
end

-- TODO Test this one:
-- anim_casino_b@amb@casino@games@blackjack@ped_female@slouchy_withdrink@01b@base
-- Name: Base
-- https://forum.cfx.re/t/confused-playing-animation-on-the-player/2426
-- Big list of animations:
-- https://raw.githubusercontent.com/DurtyFree/gta-v-data-dumps/refs/heads/master/animDictsCompact.json
-- https://www.gtahash.ru/animations
function Animation.Play(animDict, animName)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, 5000, 0, 1, true, true, true)
end


------------
-- Fade functions
------------

-- Fade the screen in and out for a teleport, so it's not instant.
-- This was an old function in the previous functions.lua.
function Fade.FadeScreen()
    local player = GetPlayerPed(-1)
    -- Test moving this into the thread.
    DoScreenFadeOut(500)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    Wait(500)
    DoScreenFadeIn(500)
    FreezeEntityPosition(player, false)
end

function Fade.FadeOut(fadeTime)
    DoScreenFadeOut(fadeTime)
    Wait(fadeTime)
end

function Fade.FadeIn(fadeTime)
    DoScreenFadeIn(fadeTime)
    Wait(fadeTime)
end


------------
-- Message/Notifcation functions
------------

-- Send a notification to the player, old function should be removed later.
-- function notify(msg)
--     SetNotificationTextEntry("STRING")
--     AddTextComponentString(msg)
--     DrawNotification(true, false)
-- end

--

-- Send a message to the player.
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

------------
-- Teleport functions
------------
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

-- Exports are setup down here, if more is added to this file
-- Make a name for them and a mapping down here.

-- Animation
exports("RemoveAnim", Animation.Remove)
exports("RequestAnim", Animation.Request)
exports("PlayAnim", Animation.Play)

exports("Notify", Text.Notify)
exports("SendMessage", Text.SendMessage)

-- Fade
exports("FadeOut", Fade.FadeOut)
exports("FadeIn", Fade.FadeIn)

-- Teleport
exports("TeleportFade", Teleports.TeleportFade)