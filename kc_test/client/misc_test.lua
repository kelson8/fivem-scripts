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

-- List of notification pictures:
-- https://wiki.rage.mp/wiki/Notification_Pictures

-- To request certain ones:
-- RequestStreamedTextureDict("name", false)
RegisterCommand('advancednotification', function(source, args, rawCommand)
    -- print(args[1])
    -- print(rawCommand)

    -- Gives error:  attempt to call a string value (local 'notificationText')
    -- in the below.
    local notificationText = tostring(args[1])
    
    showAdvancedNotification(
        rawCommand,
        -- notificationText
        'This is sender',
        'This is subject',
        -- 'CHAR_AMMUNATION',
        'CHAR_PEGASUS_DELIVERY',
        -- 8,
        2,
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

-- Looking through the decompiled scripts and the json list here for these:
-- https://github.com/DurtyFree/gta-v-data-dumps/blob/master/musicEventNames.json
-- TODO Move these into music_test.lua
RegisterCommand("playmusic", function()
    -- local player = getPlayerPed(-1)

    -- These ones doesn't work
    local mcStartTrack = "MP_MC_START"
    local startHeist4Track = "MP_MC_START_HEIST_4"
    --

    -- These below do work
    -- Play something for arena war.
    local areaCountdownTrack = "AW_COUNTDOWN_30S"

    -- Last 30 seconds track in deathmatch.
    local dmCountdownTrack = "MP_DM_COUNTDOWN_30_SEC"

    -- Plays some Arena war vehicle selection music
    local awVehicleSelectionTrack = "AW_LOBBY_VEHICLE_SELECTION"

    -- Play arena war announcer finished track.
    local awAnnouncerFinishedTrack = "AW_ANNOUNCER_FINISHED"

    -- Import Export music
    local ieStartTrack = "IE_START_MUSIC"

    -- Free mode intro track, when a player first starts the prologue.
    local fmIntroTrack = "FM_INTRO_START"

    -- Just a default track.
    local unkTrack1 = "MP_DM_COUNTDOWN_30_SEC"

    -- Looks like one of the singleplayer heist tracks.
    local ah3bCopsTrack = "AH3B_COPS"

    -- Unsure of these arcade ones honestly, for the arcade and machines I'm assuming.
    local arcadeTrack1 = "ARCADE_WR_THEME_START"


    -- This one sounds like the cop music
    -- Yes this one is one of the cop sound tracks, I've been looking everywhere for these!
    -- Or this is something for micheal, not sure though
    local shootoutMichealTrack = "MIC1_SHOOTOUT_START"

    -- Unsure of this one but sounds like the police chase music.
    local copMusic1 = "SALVAGE_START_MUSIC"

    -- local musicTrack = fmIntroTrack
    -- local musicTrack = areaCountdownTrack
    -- local musicTrack = dmCountdownTrack
    -- local musicTrack = awVehicleSelectionTrack
    -- local musicTrack = awAnnouncerFinishedTrack
    -- local musicTrack = ieStartTrack
    local musicTrack = unkTrack1

    -- endCredits = not endCredits

    -- TriggerMusicEvent("EXL1_MISSLE_HITS")
    -- TriggerMusicEvent("CHASE_PARACHUTE_START")


    -- TriggerMusicEvent("MP_MC_CMH_SUB_FINALE_START")
    -- TriggerMusicEvent("MP_MC_CMH_VEHICLE_CHASE")

    -- PrepareMusicEvent("FM_INTRO_START")
    -- TriggerMusicEvent("FM_INTRO_START")
    -- PrepareMusicEvent(musicTrack)
    TriggerMusicEvent(musicTrack)

    -- TriggerMusicEvent("FS_FORMATION_START")
    -- TriggerMusicEvent("MP_LTS")
    -- PlayEndCreditsMusic(endCredits)
end, false)

RegisterCommand("playarenamusic", function()
    local awLobbyMusic = "AW_LOBBY_MUSIC_START"
    PrepareMusicEvent(awLobbyMusic)
    TriggerMusicEvent(awLobbyMusic)
end, false)

RegisterCommand("stopmusic", function()
    -- TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
    TriggerMusicEvent("AC_STOP")
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
end
