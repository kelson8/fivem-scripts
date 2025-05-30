-- Copied into kc_menu

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- List of scaleforms: https://vespura.com/fivem/scaleform/
-- List of stats: https://www.vespura.com/fivem/gta-stats/

-- function sendMessage(msg)
--     TriggerEvent('chat:addMessage', {
--         args = {msg, },
--     })
-- end



function GetCopsKilled()
    -- Not sure how to use this yet
    local _,copsKilled = StatGetInt(copsKilledStat, -1, -1)
    return copsKilled
end


-- I could possibly make this get the values from a mysql database when the player logs in and
-- set all the stats this way.
-- I will need to mess around with storing it in a file first.
RegisterCommand("setcops", function()
    StatSetInt("MP0_KILLS_COP", 222, true)
end, false)

-- TODO Figure out how to make most of the stats store into a mysql database, I'm sure it can be done.

-- I finally figured this out!
-- The idea came from here:
-- https://github.com/Blumlaut/FiveM-DriftCounter/blob/master/driftcounter_c.lua#L20-L24
RegisterCommand("copskilled", function()
    local player = GetPlayerPed(-1)
    local copsKilledStat = GetHashKey("MP0_KILLS_COP")
    -- I had to add a second value to this
    local _,copsKilled = StatGetInt(copsKilledStat, -1)

    sendMessage(("Cops killed: %s"):format(copsKilled))

    -- notify("You have killed %s amount of cops.")
end, false)

RegisterCommand("teststat", function()
    local player = GetPlayerPed(-1)

    -- TODO Setup check for this, I think these can be MP0 or MP1 on FiveM but I'm not sure.
    -- Male
    local multiplayer0 = "MP0"
    -- Female
    local multiplayer1 = "MP1"

    local copsKilledStat = GetHashKey("MP0_KILLS_COP")
    local copCarsExplodedStat = GetHashKey("MP0_CARS_COPS_EXPLODED")
    local totalDistanceTraveledStat = GetHashKey("MP0_MPPLY_CHAR_DIST_TRAVELLED")
    local totalPlayTimeStat = GetHashKey("MP0_LEADERBOARD_PLAYING_TIME")
    local totalTimeDrivingCarStat = GetHashKey("MP0_DIST_DRIVING_CAR")

    -- Other total time stats:
    -- DIST_DRIVING_BICYCLE
    -- DIST_DRIVING_BIKE 
    -- DIST_DRIVING_BOAT
    -- DIST_DRIVING_CAR -- This one doesn't seem to return the value in a proper miles number like what is stored.
    -- DIST_DRIVING_HELI
    -- DIST_DRIVING_PLANE
    -- DIST_DRIVING_QUADBIKE
    -- DIST_DRIVING_SUBMARINE

    -- Total distance
    -- DIST_HELI
    -- DIST_PLANE
    -- DIST_QUADBIKE
    -- DIST_RUNNING
    -- DIST_SUBMARINE
    -- DIST_SWIMMING
    -- DIST_WALK_ST (Walking in stealth)
    -- DIST_WALKING


    -- local _,copsKilled = StatGetInt(copsKilledStat, -1)

    local _,copCarsExploded = StatGetInt(copCarsExplodedStat, -1)
    -- local _,totalDistanceTraveled = StatGetFloat(totalDistanceTraveledStat, -1)
    -- local _,totalPlayTime = StatGetInt(totalPlayTimeStat, -1)
    -- Not sure how this one works.
    -- local totalPlayTime = StatGetNumberOfMinutes(totalPlayTimeStat)
    -- local _,totalTimeDrivingCar = StatGetFloat(totalTimeDrivingCarStat)

    -- if copsKilled then
    --     sendMessage(tmpValue)
    -- end

    -- if StatGetInt(copsKilledStat, -1) then
        -- sendMessage(("Cops killed: %s"):format(copsKilled))
        sendMessage(("Cop cars exploded %s"):format(copCarsExploded))
        -- sendMessage(("Test %s"):format(totalDistanceTraveled))
        -- sendMessage(("Test %s"):format(totalPlayTime))
        -- sendMessage(("Test %s"):format(totalTimeDrivingCar))

    -- end
    
    -- notify("You have killed %s amount of cops.")
end, false)

-- I'm not sure if this is related, I found out that MP1 is the girl character
-- https://github.com/citizenfx/fivem/issues/2489
RegisterCommand("setstat", function()
    local player = GetPlayerPed(-1)

    local copsKilledStat = GetHashKey("MP1_KILLS_COP")
    local moneyStat = GetHashKey("MP1_WALLET_BALANCE")

    SetStatInt(moneyStat, 500, true)
end, false)

-- Test for showing money on the hud
-- https://forum.cfx.re/t/does-anyone-know-how-to-set-the-stats-in-the-new-update/52858/5
-- Citizen.CreateThread(function()
-- 	while true do
-- 		Wait(1)
-- 		if not IsHudComponentActive(4) and GetPlayerPed(-1) then
-- 			ShowHudComponentThisFrame(4)
-- 		end
-- 	end
-- end)

RegisterCommand("testmsg", function()
    local player = GetPlayerPed(-1)
    local playerName = GetPlayerName(player)

    -- sendMessage("Hello player " .. playerName .. ".")
    sendMessage("Hello")
end, false)



