
-- https://www.youtube.com/watch?v=AcUQ7GzMQNI&list=PLJHKr4HVljNJKVdetugOr1QTpqRSe1Abx&index=6

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