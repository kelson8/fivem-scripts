function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- List of scaleforms: https://vespura.com/fivem/scaleform/

-- function sendMessage(msg)
--     TriggerEvent('chat:addMessage', {
--         args = {msg, },
--     })
-- end


function GetCopsKilled()
    -- Not sure how to use this yet
    return StatGetInt("KILLS_COP", -1)
end

RegisterCommand("copskilled", function()
    local player = GetPlayerPed(-1)
    -- local copskilled = GetCopsKilled()
    local copskilled = StatGetInt("KILLS_COP", -1, 1)
    sendMessage(("Test %s"):format(copskilled))
    -- notify("You have killed %s amount of cops.")
end, false)

RegisterCommand("testmsg", function()
    local player = GetPlayerPed(-1)
    local playerName = GetPlayerName(player)

    -- sendMessage("Hello player " .. playerName .. ".")
    sendMessage("Hello")
end, false)



