-- https://www.youtube.com/watch?v=AcUQ7GzMQNI&list=PLJHKr4HVljNJKVdetugOr1QTpqRSe1Abx&index=6

-- Notify client event
RegisterNetEvent("ch_test:notifyClient")
AddEventHandler("ch_test:notifyClient", function(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end)

-- Fade the screen in and out for a teleport, so it's not instant.
function FadeScreenForTeleport()
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

-- function sendMessage(source, msg)
--     TriggerEvent('chat:addMessage', source, {
--         args = {msg, },
--     })
-- end

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

-- This might work for what I'm trying to do, make sure the interior is loaded
-- https://forum.cfx.re/t/help-teleport-player-to-streamed-location/811867/4

-- TODO Setup config file for this, either in lua or json
RegisterCommand("warp", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local carrier1 = "m24_1_carrier"
    local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"
    local aircarrierX, airCarrierY, airCarrierZ = -3259.89, 3909.33, 26.78
    local bountyOfficeX, bountyOfficeY, bountyOfficeZ = 565.887, -2688.762, -50.2
    local casinoVaultX, casinoVaultY, casinoVaultZ = 2497.08, -238.51, -70.74

    if args[1] == nil then
        sendMessage("Warp list: casino_vault, aircarrier1, bountyoffice")
        -- TODO Figure out how to get this working with a list of warps.
        -- for k,v in pairs(Warps) do
        --     notify(v[1])
        -- end
    end

    -- TODO Move this into a config, get the name, x, y, z, heading and teleport message from the config
    -- Like I am doing in the ScaleformUI_Test which has the markers drawing.
    if args[1] == "casino_vault" then
        FadeScreenForTeleport()
        SetEntityCoords(player, casinoVaultX, casinoVaultY, casinoVaultZ, true, false, false, false)
        SetEntityHeading(player, 270.79)
        notify("Teleported to casino vault")
    -- Ipl checks are needed for below two
    elseif args[1] == "aircarrier1" then
        if IsIplActive(carrier1) then
            FadeScreenForTeleport()
            SetEntityCoords(player, aircarrierX, airCarrierY, airCarrierZ, true, false, false, false)
            sendMessage("Warped to the aircraft carrier.")
        end
    elseif args[1] == "bountyoffice" then
        if IsIplActive(bountyOffice2) then
            FadeScreenForTeleport()
            SetEntityCoords(player, bountyOfficeX, bountyOfficeY, bountyOfficeZ, true, false, false, false)
            sendMessage("Warped to the bounty office.")
        end

    -- 
    
        -- end
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


RegisterCommand('testspinner', function(_, _, rawCommand)
    if rawCommand == 'testspinner' then
        Text.HideBusySpinner()
    else
        Text.ShowBusySpinner(rawCommand)
    end
end, false)


-- These seem to work now, not sure what changed.
local endCredits = false

RegisterCommand("playmusic", function()
    -- local player = getPlayerPed(-1)

    -- endCredits = not endCredits

    -- TriggerMusicEvent("EXL1_MISSLE_HITS")
    TriggerMusicEvent("CHASE_PARACHUTE_START")
    -- TriggerMusicEvent("FS_FORMATION_START")
    -- TriggerMusicEvent("MP_LTS")
    -- PlayEndCreditsMusic(endCredits)
end, false)

RegisterCommand("playarenamusic", function()

    TriggerMusicEvent("AW_LOBBY_MUSIC_START")
end, false)

RegisterCommand("stopmusic", function()
    TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
end, false)

RegisterCommand("playsound", function()
    PlaySound(1, "CHARACTER_CHANGE_UP_MASTER", 0, false, false, false)
end, false)

--

-- Subtitles
function showSubtitle(message, duration)
    BeginTextCommandPrint("STRING")
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
    -- BeginTextCommandBusyspinnerOn()
end
