-- I wonder how this one works

TriggerEvent("chat:addSuggestion", "/clocktest", "Change the time", {
    {name = "hour", help = "0-23"},
    {name = "minute", help = "0-59"},
    {name = "second", help = "0-59"},
    -- {name = "transition", help = "Transition time in milliseconds"},
    -- {name = "freeze", help = "0 = don\"t freeze time, 1 = freeze time"}
})

function toggleNightTime()
    
end

-- This didn't seem to work.
RegisterCommand("clocktest", function (source, args, rawCommand)
    hour = tonumber(args[1])
    minute = tonumber(args[2])
    second = tonumber(args[3])

    if hour and minute and second then
        if hour > 23 or minute > 59 or second > 59 then
            return
        end
        -- NetworkOverrideClockTime(hour, minute, second)
        Citizen.CreateThread(function()

            -- This seems to work but it stays enabled
            while true do
                Wait(1)
                NetworkOverrideClockTime(hour, minute, second)
            end
        end)
        SetClockTime(hour, minute, second)
        -- AdvanceClockTimeTo(tonumber(hour), tonumber(minute), tonumber(second))
    else
        sendMessage("You need to specify a hour, minute and second.")
    end
end, false)