
-- https://www.youtube.com/watch?v=AcUQ7GzMQNI&list=PLJHKr4HVljNJKVdetugOr1QTpqRSe1Abx&index=6

-- Notify client event
RegisterNetEvent("ch_test:notifyClient")
AddEventHandler("ch_test:notifyClient", function (msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(true, false)
end)

-- function sendMessage(source, msg)
--     TriggerEvent('chat:addMessage', source, {
--         args = {msg, },
--     })
-- end

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = {msg, },
    })
end

-- This might work for what I'm trying to do, make sure the interior is loaded
-- https://forum.cfx.re/t/help-teleport-player-to-streamed-location/811867/4

RegisterCommand("warp", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    if args[1] == nil then
        sendMessage("Warp list: casino_vault")
        -- TODO Figure out how to get this working with a list of warps.
        -- for k,v in pairs(Warps) do
        --     notify(v[1])
        -- end
    end

        -- TODO Move this into a config, get the name, x, y, z, heading and teleport message from the config
        -- Like I am doing in the ScaleformUI_Test which has the markers drawing.
        if args[1] == "casino_vault" then
            SetEntityCoords(player, 2497.08, -238.51, -70.74, true, false, false, false)
            SetEntityHeading(player, 270.79)
            notify("Teleported to casino vault")
        elseif args[1] == "" then
        end
    
end, false)

-- RegisterNetEvent("ch_test:getVehicle")
-- AddEventHandler("ch_test:getVehicle", function()
--     local player = GetPlayerPed(-1)
--     if IsPedInAnyVehicle(player, false) then
        
--     end

-- end)

-- Advanced Notifications

function showAdvancedNotification(message, sender, subject, textureDict, iconType, saveToBrief, color)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    ThefeedNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, saveToBrief)
end

RegisterCommand('advancednotification', function(_, _, rawCommand)
    showAdvancedNotification(
        rawCommand,
        'This is sender',
        'This is subject',
        'CHAR_AMMUNATION',
        8,
        true,
        130
    )
end, false)

-- Alerts
function showAlert(message, beep, duration)
    AddTextEntry('CH_ALERT', message)

    BeginTextCommandDisplayHelp('CH_ALERT')
    EndTextCommandDisplayHelp(0, false, beep, duration)
end

RegisterCommand('testAlert', function(_, _, rawCommand)
    showAlert(
        rawCommand,
        true,
        5000
    )
end, false)


-- Busy spinners

function showBusySpinner(message)
    BeginTextCommandBusyspinnerOn("STRING")
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandBusyspinnerOn(5)
end

function hideBusySpinner()
    BusyspinnerOff()
end

RegisterCommand('testspinner', function(_, _, rawCommand)
    if rawCommand == 'testspinner' then
        hideBusySpinner()
    else
        showBusySpinner(rawCommand)
    end

end, false)

--

-- Subtitles
function showSubtitle(message, duration)
    BeginTextCommandPrint("STRING")
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
    -- BeginTextCommandBusyspinnerOn()
end