--[[
Stat list:
-- https://www.vespura.com/fivem/gta-stats/
Wanted level time: MP0_CHAR_WANTED_LEVEL_TIME
5 Star wanted level time: MP0_CHAR_WANTED_LEVEL_TIME5STAR
Deaths (Total times died): MP0_DEATHS
Deaths by other players: MP0_DEATHS_PLAYER

Times died:
    Died by drowning: MP0_DIED_IN_DROWNING
    Died by drowning in vehicle: MP0_DIED_IN_DROWNINGINVEHICLE
    Died by explosion: MP0_DIED_IN_EXPLOSION
    Died from falling: MP0_DIED_IN_FALL
    Died from fire: MP0_DIED_IN_FIRE
    Died from a road accident: MP0_DIED_IN_ROAD

Total time walking/driving/flying and total distance:
    Total distance driving a bicycle: MP0_DIST_BICYCLE
    Total distance driving a bike: MP0_DIST_BIKE
    Total distance driving a boat: MP0_DIST_BOAT
    Total distance driving a car: MP0_DIST_CAR 	
	

    Total distance driving/flying/walking:
    Total miles driving a bicycle: MP0_DIST_DRIVING_BICYCLE
    Total miles driving a bike: MP0_DIST_DRIVING_BIKE
    Total miles driving a boat: MP0_DIST_DRIVING_BOAT
    Total miles driving a car: MP0_DIST_DRIVING_CAR
    Total miles flying a helicopter: MP0_DIST_DRIVING_HELI
    Total miles flying a plane: MP0_DIST_DRIVING_PLANE
    Total miles driving a quadbike: MP0_DIST_DRIVING_QUADBIKE
    Total miles driving a submarine: MP0_DIST_DRIVING_SUBMARINE
	
    Total time driving/flying/walking:
    Total time flying a helicopter: MP0_DIST_HELI
    Total time flying a plane: MP0_DIST_PLANE
    Total time driving a quadbike: MP0_DIST_QUADBIKE
    Total time running: MP0_DIST_RUNNING
    Total time driving a submarine: MP0_DIST_SUBMARINE
    Total time swimming: MP0_DIST_SWIMMING
    Total time walking in stealth mode: MP0_DIST_WALK_ST
    Total time walking: MP0_DIST_WALKING

Fires:
    Total fires extinguished: MP0_FIRES_EXTINGUISHED
    Total fires started: MP0_FIRES_STARTED

Checking if weapon is in inventory:
    Check for baseball bat: MP0_BAT_IN_POSSESSION
]]

function GetCopsKilled()
    -- Not sure how to use this yet
    local _, copsKilled = StatGetInt(copsKilledStat, -1, -1)
    return copsKilled
end

-- I could possibly make this get the values from a mysql database when the player logs in and
-- set all the stats this way.
-- I will need to mess around with storing it in a file first.

function setCopsStat(amount)
    StatSetInt("MP0_KILLS_COP", amount, true)
end

-- TODO Figure out how to make most of the stats store into a mysql database, I'm sure it can be done.

-- Most of these are easy to understand, I'm just documenting them so I know what's doing what.

-- I finally figured this out!
-- The idea came from here:
-- https://github.com/Blumlaut/FiveM-DriftCounter/blob/master/driftcounter_c.lua#L20-L24
function copsKilledCheck()
    local player = GetPlayerPed(-1)
    local copsKilledStat = GetHashKey("MP0_KILLS_COP")
    -- I had to add a second value to this
    local _, copsKilled = StatGetInt(copsKilledStat, -1)
    -- exports.kc_util:Notify(("Cops killed: %s"):format(copsKilled))

    return copsKilled

    -- exports.kc_util:Notify("You have killed %s amount of cops.")
end

-- Get vehicles blown up
function getVehiclesBlownUp()
    local vehiclesBlownUpStat = GetHashKey("MP0_CARS_EXPLODED")
    local _, vehiclesBlownUp = StatGetInt(vehiclesBlownUpStat, -1)

    return vehiclesBlownUp
end

-- Get cop vehicles blown up
function getCopVehiclesBlownUp()
    local copVehiclesBlownUpStat = GetHashKey("MP0_CARS_COPS_EXPLODED")
    local _, copVehiclesBlownUp = StatGetInt(copVehiclesBlownUpStat, -1)

    return copVehiclesBlownUp
end

-- TODO Figure out how to store these stats
function getTiresPoppedByGunshot()
    local tiresPoppedStat = GetHashKey("MP0_TIRES_POPPED_BY_GUNSHOT")
    -- I had to add a second value to this
    local _, tiresPopped = StatGetInt(tiresPoppedStat, -1)

    return tiresPopped
end

-- Playtime and driving/flying/walking time
-- Divide the time by 1000 on most of these, convert from miliseconds to seconds
function getTimeAsDriver()
    local timeAsDriverStat = GetHashKey("MP0_TIME_DRIVING_CAR")
    local _, timeAsDriver = StatGetInt(timeAsDriverStat, -1)

    return timeAsDriver / 1000
end

function getTotalPlayTime()
    local totalPlayTimeStat = GetHashKey("MP0_LEADERBOARD_PLAYING_TIME")
    local _, playTime = StatGetInt(totalPlayTimeStat, -1)

    return playTime
end

function getTimeAsHeliPilot()
    local timeFlyingHeliStat = GetHashKey("MP0_TIME_DRIVING_HELI")
    local _, timeFlyingHeli = StatGetInt(timeFlyingHeliStat, -1)

    -- return msToSeconds(timeFlyingHeli)
    return timeFlyingHeli / 1000
end

-- Times died
-- TODO Test these
function getAmountOfTimesDied()
    local totalDeathsStat = GetHashKey("MP0_DEATHS")
    local _, totalDeaths = StatGetInt(totalDeathsStat, -1)

    return totalDeaths
end

-- Get how many times the player has drowned on foot
function getAmountOfTimesDiedByDrowning()
    local totalDeathsDrowningStat = GetHashKey("MP0_DIED_IN_DROWNING")
    local _, totalDeathsDrowning = StatGetInt(totalDeathsDrowningStat, -1)

    return totalDeathsDrowning
end

-- Get how many times the player has drowned in a vehicle
function getAmountOfTimesDiedByDrowningInVehicle()
    local totalDeathsDrowningInVehicleStat = GetHashKey("MP0_DIED_IN_DROWNINGINVEHICLE")
    local _, totalDeathsDrowningInVehicle = StatGetInt(totalDeathsDrowningInVehicleStat, -1)

    return totalDeathsDrowningInVehicle
end

-- Get how many times the player has died by explosions
function getAmountOfTimesDiedByExplosion()
    local totalDeathsExplosionStat = GetHashKey("MP0_DIED_IN_EXPLOSION")
    local _, totalDeathsExplosion = StatGetInt(totalDeathsExplosionStat, -1)

    return totalDeathsExplosion
end

-- Get how many times the player has died by falling
function getAmountOfTimesDiedByFalling()
    local totalDeathsFallingStat = GetHashKey("MP0_DIED_IN_FALL")
    local _, totalDeathsFalling = StatGetInt(totalDeathsFallingStat, -1)

    return totalDeathsFalling
end

-- Get how many times the player has died by fire
function getAmountOfTimesDiedByFire()
    local totalDeathsFireStat = GetHashKey("MP0_DIED_IN_FIRE")
    local _, totalDeathsFire = StatGetInt(totalDeathsFireStat, -1)

    return totalDeathsFire
end

-- Get how many times the player has died by road accident
-- I'm guessing this is when the player is ran over.
function getAmountOfTimesDiedByRoadAccident()
    local totalDeathsRoadAccidentStat = GetHashKey("MP0_DIED_IN_ROAD")
    local _, totalDeathsRoadAccident = StatGetInt(totalDeathsRoadAccidentStat, -1)

    return totalDeathsRoadAccident
end

--

function testStat()
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

    -- local _,copsKilled = StatGetInt(copsKilledStat, -1)

    local _, copCarsExploded = StatGetInt(copCarsExplodedStat, -1)
    -- local _,totalDistanceTraveled = StatGetFloat(totalDistanceTraveledStat, -1)
    -- local _,totalPlayTime = StatGetInt(totalPlayTimeStat, -1)
    -- Not sure how this one works.
    -- local totalPlayTime = StatGetNumberOfMinutes(totalPlayTimeStat)
    -- local _,totalTimeDrivingCar = StatGetFloat(totalTimeDrivingCarStat)

    -- if copsKilled then
    --     Text.SendMessage(tmpValue)
    -- end

    -- Text.SendMessage(("Cops killed: %s"):format(copsKilled))
    exports.kc_util:Notify(("Cop cars exploded %s"):format(copCarsExploded))
    -- Text.SendMessage(("Test %s"):format(totalDistanceTraveled))
    -- Text.SendMessage(("Test %s"):format(totalPlayTime))
    -- Text.SendMessage(("Test %s"):format(totalTimeDrivingCar))
    -- exports.kc_util:Notify("You have killed %s amount of cops.")
end

-- Make this global
stats = {}

-- This seems to work like this
tiresPoppedByGunshot = nil
copVehiclesBlownUp = nil


local function getCurrentStats()
    -- Wait(500)
    tiresPoppedByGunshot = getTiresPoppedByGunshot()
    copVehiclesBlownUp = getCopVehiclesBlownUp()
    -- These didn't work
    -- Wait(500)
    -- table.insert(stats, getTiresPoppedByGunshot())
    -- -- Remove the table and keep readding to it, will this work?
    -- Wait(500)
    -- table.remove(stats, 1)
end

-- TODO How would I do this for multiple stats?
if debugTest then
    function checkForUpdatedStats()
        Citizen.CreateThread(function()
            while true do
                Wait(500)
                getCurrentStats()
            end
        end)

        -- unpackedStatTable = table.unpack(stats)
        return tiresPoppedByGunshot
    end
end


-- I'm not sure if this is related, I found out that MP1 is the girl character
-- https://github.com/citizenfx/fivem/issues/2489
-- RegisterCommand("setstat", function()
--     local player = GetPlayerPed(-1)

--     local copsKilledStat = GetHashKey("MP1_KILLS_COP")
--     local moneyStat = GetHashKey("MP1_WALLET_BALANCE")

--     SetStatInt(moneyStat, 500, true)
-- end, false)
