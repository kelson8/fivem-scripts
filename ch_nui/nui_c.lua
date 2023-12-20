-- https://www.youtube.com/watch?v=WxMOk-FuG2U&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=2
-- Basic gui for fivem

-- TODO Fix this to where it doesn't show up until the on command is typed
-- Currently it opens up without typing the command but it closes properly


local display = false

RegisterCommand("on", function()
    CreateThread(function()
        TriggerEvent("nui:on", true)
    end)
end)

RegisterCommand("off", function()
    CreateThread(function()
        TriggerEvent("nui:off", true)
    end)
end)

-- [[///////////////////////////////////]]
RegisterNetEvent("nui:on")
AddEventHandler("nui:on", function(value)
    SendNUIMessage({
        type = "ui",
        display = true
    })
end)


RegisterNetEvent("nui:off")
AddEventHandler("nui:off", function(value)
    SendNUIMessage({
        type = "ui",
        display = false
    })
end)