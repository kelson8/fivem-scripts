-- Message functions

-- https://forum.cfx.re/t/calling-a-function-from-a-different-resource/1415243

-- Send a notification to the player.
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