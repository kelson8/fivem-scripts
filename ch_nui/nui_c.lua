-- https://www.youtube.com/watch?v=WxMOk-FuG2U&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=2
-- Basic gui for fivem

-- TODO Fix this to where it doesn't show up until the on command is typed
-- Currently it opens up without typing the command but it closes properly

-- I wonder how to fix the below doing coords to work with a command like I have at the bottom.

CreateThread(function()
    while true do
        Wait(10)

        local playerId = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerId)
        local playerHeading = GetEntityHeading(playerId)

        SendNUIMessage({
            type = "position",
            x = playerCoords.x,
            y = playerCoords.y,
            z = playerCoords.z,
            heading = playerHeading,
        })
    end
end)

-- Key bindings

RegisterCommand("+openteleporter", function()
    SetNuiFocus(true, true)
end)

RegisterKeyMapping("+openteleporter", "Open Teleporter", "keyboard", "F7")

-- This had to be changed to the below since it was giving errors
-- https://forum.cfx.re/t/invalid-json-passed-in-frame/1914037
-- CreateThread(function()
--     while true do
--         Wait(1000)

--         SendNuiMessage(json.encode({
--             type = "ping",
--         }))
--         -- SendNuiMessage({
--         --     type = "ping",
--         -- })
--     end
-- end)

-- -- NUI Callbacks

-- RegisterNUICallback("pong", function(data, cb)
--     print("Got pong, foo value is ", data.foo)

--     cb({
--         acceptedPong = true
--     })
-- end)

RegisterNuiCallback('releaseFocus', function(data, cb)
    -- Call back is required even if we aren't getting any data from it
    cb({})

    SetNuiFocus(false, false)
end)

RegisterNuiCallback('teleport', function(data, cb)
    cb({})

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z)
end)

---

-- This almost works, it shows up only when the on command is pressed.
-- Now it turns off if the off command is pressed twice.
-- I will disable it for now.
-- local display = false

-- RegisterCommand("on", function()
--     CreateThread(function()
--         display = true
--         TriggerEvent("nui:on", true)
--     end)
-- end)

-- RegisterCommand("off", function()
--     CreateThread(function()
--         display = false
--         TriggerEvent("nui:off", true)
--     end)
-- end)

-- RegisterNetEvent("nui:on")
-- AddEventHandler("nui:on", function()
--     CreateThread(function()
--         while display do
--         -- while true do
--             Wait(500)

--             local playerId = GetPlayerPed(-1)
--             local playerCoords = GetEntityCoords(playerId)
--             local playerHeading = GetEntityHeading(playerId)

--             SendNUIMessage({
--                 type = "position",
--                 x = playerCoords.x,
--                 y = playerCoords.y,
--                 z = playerCoords.z,
--                 heading = playerHeading,
--                 display = true
--             })
--         end
--     end)
-- end)

-- RegisterNetEvent("nui:off")
-- AddEventHandler("nui:off", function(value)
--     SendNUIMessage({
--         type = "position",
--         display = false
--     })
-- end)
