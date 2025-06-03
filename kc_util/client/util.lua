---@diagnostic disable: duplicate-set-field
-- Message functions

-- https://forum.cfx.re/t/calling-a-function-from-a-different-resource/1415243

Text = {}

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


-- Send a notification to the player, old function should be removed later.
function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

--

-- Send a message to the player.
function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = {msg, },
    })
end

-- function notify(msg)
function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Exports are setup down here, if more is added to this file
-- Make a name for them and a mapping down here.

exports("Notify", Text.Notify)