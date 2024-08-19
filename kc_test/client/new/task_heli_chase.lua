-- Test spawning a ped in a chopper that chases another ped in a chopper.
-- https://opensource.com/article/22/11/iterate-over-tables-lua

local ped = nil
local ped2 = nil

-- Driving styles: https://gtaforums.com/topic/822314-guide-driving-styles/
local drivingStyleNormal = 786603
local drivingStyleRushed = 1074528293
local drivingStyleIgnoreLights = 2883621
-- Random driving style
local drivingStyleTest1 = 8388614

local heli1 = nil
local heli2 = nil

-- Create the peds table to store the peds.
local pedsTable = {}

-- Spawn vehicle without blip at a set coords and with a custom color
-- local function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
    -- local heliName = GetHashKey(vehicleName)

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    -- local vehicleNew = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    heli1 = CreateVehicle(vehicleName, x, y + 5, z, heading, true, false)
    heli2 = CreateVehicle(vehicleName, x, y + 20, z, heading, true, false)
    -- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
    -- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

    SetModelAsNoLongerNeeded(heli1)
    SetModelAsNoLongerNeeded(heli2)

    -- Todo Re-enable this if needed
    -- return vehicleNew
end


-- List of missions for the TaskHeliMission native:
-- MISSION_NONE,               // 0
-- MISSION_CRUISE,                 // 1
-- MISSION_RAM,                    // 2
-- MISSION_BLOCK,                  // 3
-- MISSION_GOTO,                   // 4
-- MISSION_STOP,                   // 5
-- MISSION_ATTACK,                 // 6
-- MISSION_FOLLOW,                 // 7
-- MISSION_FLEE,                   // 8
-- MISSION_CIRCLE,                 // 9
-- MISSION_ESCORT_LEFT,            // 10
-- MISSION_ESCORT_RIGHT,           // 11
-- MISSION_ESCORT_REAR,            // 12
-- MISSION_ESCORT_FRONT,           // 13
-- MISSION_GOTO_RACING,            // 14
-- MISSION_FOLLOW_RECORDING,       // 15
-- MISSION_POLICE_BEHAVIOUR,       // 16
-- MISSION_PARK_PERPENDICULAR,     // 17
-- MISSION_PARK_PARALLEL,          // 18
-- MISSION_LAND,                   // 19
-- MISSION_LAND_AND_WAIT,          // 20
-- MISSION_CRASH,                  // 21
-- MISSION_PULL_OVER,               // 22
-- MISSION_PROTECT					// 23

-- List of behavior flags:
--[[
	HF_AttainRequestedOrientation = 1,
    HF_DontModifyOrientation = 2,
    HF_DontModifyPitch = 4,
    HF_DontModifyThrottle = 8,
    HF_DontModifyRoll = 16,
	HF_LandOnArrival = 32,
	HF_DontDoAvoidance = 64,
	HF_StartEngineImmediately = 128,
	HF_ForceHeightMapAvoidance = 256,
	HF_DontClampProbesToDestination = 512,
	HF_EnableTimeslicingWhenPossible = 1024,
	HF_CircleOppositeDirection = 2048,
	HF_MaintainHeightAboveTerrain = 4096,
	HF_IgnoreHiddenEntitiesDuringLand = 8192,
	HF_DisableAllHeightMapAvoidance = 16384,
	
	HF_NONE = 0,
	HF_HEIGHTMAPONLYAVOIDANCE = 320

]]

-- Spawn two peds and make them fly around in a buzzard.
-- This isn't setup to make the peds chase each other yet.
-- This seems to be spawning in multiple helicopters after the command is ran twice sometimes, I wonder why it does that.

--@param pedName1 First ped hash
--@param pedName2 Second ped hash
local function spawnPedHeliPilots(pedName1, pedName2)
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x, y, z = table.unpack(playerCoords)
    -- Other parameters for the function, moved here for easier access
    -- The speed is in m/s (meters per seconds) instead of mph
    local speed = 20.0
    local stopRange = 20
    local straightLineDistance = 20

    -- Testing below
    local crashIntoRandomVehicle = false
    local landHelicopter = true

    -- Add 10 to the first set of coords and 20 to the other set, leave the z coord alone
    -- This is where the helicopters spawn, and the peds teleport into them
    -- TODO Change the value of these to +5 and +10 or something lower
    local x_1 = x + 10
    local y_1 = y + 10
    local x_2 = x + 20
    local y_2 = y + 20

    -- Target coords
    local targetX, targetY, targetZ = -283.72, 806.09, 250.5

    local pedModel = GetHashKey(pedName1)
    local pedModel2 = GetHashKey(pedName2)

    -- Break out of this if the model doesn't exist
    if not IsModelInCdimage(pedName1) or not IsModelInCdimage(pedName2) then
        notify("Model doesn't exist!")
        return
    end

    -- ped = CreatePed(1, pedModel, z, y + 1, z, playerHeading, true, true)
    ped = CreatePed(1, pedModel, x_1, y_1, z, playerHeading, true, true)
    -- ped2 = CreatePed(1, pedModel2, z, y + 3, z, playerHeading, true, true)
    ped2 = CreatePed(1, pedModel2, x_2, y_2, z, playerHeading, true, true)
    RequestModel(pedModel)
    RequestModel(pedModel2)

    -- Wait on the model
    while not DoesEntityExist(ped) or NetworkGetNetworkIdFromEntity(ped) == 0
        or not DoesEntityExist(ped2) do
        Citizen.Wait(500)
    end


    -- These don't seem to work
    -- SetBlipAsFriendly(blip1, true)
    -- SetBlipAsFriendly(blip2, true)
    -- SetBlipColor(blip1, 38)
    -- SetBlipColor(blip2, 38)

    -- Set a blip on the peds
    SetPedHasAiBlip(ped, true)
    SetPedHasAiBlip(ped2, true)
    -- This should set the friendly blip on the peds
    SetPedAiBlipSprite(ped, 64)
    SetPedAiBlipSprite(ped2, 64)

    SetPedAiBlipHasCone(ped, false)
    SetPedAiBlipHasCone(ped2, false)

    -- Is this even needed? I'm not sure of the default health
    SetEntityHealth(ped, 100)
    SetEntityHealth(ped2, 100)

    -- Spawn the vehicles
    local model = "buzzard2"
    local heliModel = GetHashKey(model)

    -- These are in the spawn code, I couldn't get it to work in here
    -- local heli1 = spawnVehicleWithoutBlip("buzzard2", x_1, y_1, z)
    -- local heli2 = spawnVehicleWithoutBlip("buzzard2", x_2, y_2, z, 20)
    -- spawnVehicleWithoutBlip(model, x_2, y_2, z, 20)

    -- Spawn the buzzards, this function is set to spawn both of the buzzards
    spawnVehicleWithoutBlip(model, x_1, y_1, z, 20)

    -- Was just a small test, could possibly use once I figure out how to make them land,
    -- and get out.
    -- TaskHandsUp(ped1, 2000, false, -1, -1)

    -- Put the peds in the helicopters
    TaskWarpPedIntoVehicle(ped, heli1, -1)
    TaskWarpPedIntoVehicle(ped2, heli2, -1)

    -- Let them get in the air a bit.
    -- Todo this is probably not needed.
    Wait(1000)

    -- Fly to the coords
    -- TaskVehicleDriveToCoord(ped, heli1, -283.72, 806.09, 250.5, 30.0, false, heliModel, drivingStyleIgnoreLights, 20, 20)
    TaskVehicleDriveToCoord(ped, heli1, targetX, targetY, targetZ, speed, false, heliModel, drivingStyleIgnoreLights,
        stopRange, straightLineDistance)
    TaskVehicleDriveToCoord(ped2, heli2, targetX, targetY, targetZ, speed, false, heliModel, drivingStyleIgnoreLights,
        stopRange, straightLineDistance)
    -- TaskVehicleDriveToCoord(ped2, heli2, -283.72, 806.09, 250.5, 30.0, false, heliModel, drivingStyleIgnoreLights, 20, 20)

    -- Have the peds chase each other, not setup yet.
    -- TaskHeliChase(ped, ped2, 0.0, 0.0, 250.0)

    -- TODO Make the peds crash into something as a test, find a random car and crash into it
    if crashIntoRandomVehicle then
        -- mission = 20 -- MISSION_LAND_AND_WAIT
        -- behaviorFlag = 32 -- Crash the helicopter
        -- This is just copied from below, it needs fixed up.
        -- TaskHeliMission(0, heli1, 0, 0, targetX, targetY, targetZ, mission, 10.0, 5.0, 0.0, 50, 30, 20, behaviorFlag)
    end

    -- List of some of the command native help
    -- https://nativedb.dotindustries.dev/gta5/natives/0xDAD029E187A2BEB4?search=taskheli
    if landHelicopter then
        mission = 20 -- MISSION_LAND_AND_WAIT
        behaviorFlag = 32 -- Land the helicopter
        TaskHeliMission(0, heli1, 0, 0, targetX, targetY, targetZ, mission, 10.0, 5.0, 0.0, 50, 30, 20, behaviorFlag)
    end


    -- Add the peds to the table
    table.insert(pedsTable, ped)
    table.insert(pedsTable, ped2)

    -- Set the models as no longer needed
    SetModelAsNoLongerNeeded(pedModel)
    SetModelAsNoLongerNeeded(pedModel2)
    SetEntityAsNoLongerNeeded(ped)
    SetEntityAsNoLongerNeeded(ped2)

    -- return ped
end

-- Oops, I need to remove the peds from the table when they die
Citizen.CreateThread(function()
    while true do
        -- This shouldn't need to run too often.
        Wait(500)
        if DoesEntityExist(ped) and IsEntityDead(ped) then
            table.remove(pedsTable, 1)
            if DoesEntityExist(ped2) and IsEntityDead(ped2) then
                table.remove(pedsTable, 2)
            end
        end
    end
end)

-- https://nativedb.dotindustries.dev/gta5/natives/0x20B60995556D004F
-- https://nativedb.dotindustries.dev/gta5/natives/0x54736AA40E271165
-- Citizen.CreateThread(function()
--     local targetX, targetY, targetZ = -283.72, 806.09, 250.5
--     local newX, newY, newZ = -304.14, 883.09, 198.93
--     while true do
--         Wait(500)
--         -- Oops I think this is too precise, I need a square or a sphere
--         -- Well this didn't owkr
--         if DoesEntityExist(ped) and not IsEntityDead(ped) then
--             if IsEntityInArea(ped, targetX, targetY, targetZ, newX, newY, newZ, false, true, false) then
--             -- if IsEntityAtCoord(ped, targetX, targetY, targetZ, 10, 10, 10, false, true, 0) then
--                 -- Hmm what should I do when they get to the coord, blow them up?
--                 SetEntityHealth(ped, 0)
--             end
--         end
--         if DoesEntityExist(ped2) and not IsEntityDead(ped2) then
--             -- if IsEntityAtCoord(ped2, targetX, targetY, targetZ, 10, 10, 10, false, true, 0) then
--             if IsEntityInArea(ped2, targetX, targetY, targetZ, newX, newY, newZ, false, true, false) then
--                 SetEntityHealth(ped2, 0)
--             end
--         end
--     end
-- end)

-- This seems to work
RegisterCommand("pedids", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    -- if DoesEntityExist(ped) and DoesEntityExist(ped2) then
    if DoesEntityExist(ped) then
        if DoesEntityExist(ped2) then
            -- if not IsEntityDead(ped) and not IsEntityDead(ped2) then
            if not IsEntityDead(ped) then
                if not IsEntityDead(ped2) then
                    -- sendMessage(pedsTable[1] .. " " ..  pedsTable[2] .. " " .. pedsTable[3] .. " " .. pedsTable[4])
                    for k, v in pairs(pedsTable) do
                        sendMessage(v)
                    end
                    -- sendMessage(("Ped 1: %s, Ped 2: %s"):format(ped, ped2))
                end
            end
        end
    end
end, false)

-- This doesn't work.
RegisterCommand("clearpedtable", function()
    for k, v in pairs(pedsTable) do
        table.remove(pedsTable, k)
    end
    -- Removed peds from the table.
end)


-- This seems to work now
-- 8-10-2024 @ 4:45AM
RegisterCommand("helitest", function()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x, y, z = table.unpack(playerPos)

    -- Spawn the peds and put them into a helicopter
    spawnPedHeliPilots("a_m_y_clubcust_03", "a_m_y_beachvesp_01")
end, false)

-- This works to kill the peds so they don't lag the server
-- 8-10-2024 @ 4:20AM
RegisterCommand("explodepeds", function()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    local playerX, playerY, playerZ = table.unpack(playerCoords)

    -- sendMessage(("Ped 1: %s, Ped 2: %s"):format(ped, ped2))

    -- I could probably use this to despawn the peds in a loop if they exist and go a certain distance from the player.

    -- This for loop works better then what I was trying to do, which was only kill two of the peds
    for k, v in pairs(pedsTable) do
        -- I can disable this check for fun.. So I can keep blowing them up.
        if DoesEntityExist(v) and not IsPedDeadOrDying(v, false) then
            local pedCoords = GetEntityCoords(v)
            pedX, pedY, pedZ = table.unpack(pedCoords)
            -- Distance check, this works
            -- if Vdist(playerX, playerY, playerZ, ped1X, ped1Y, ped1Z) > 10
            -- and Vdist(playerX, playerY, playerZ, ped2X, ped2Y, ped2Z) > 10 then
            AddExplosion(pedX, pedY, pedZ, gaspumpExplosion, damageScale, true, false, cameraShake, false)
        else
            -- Well this just spams the message if there are multiple peds
            -- sendMessage("Peds are dead.")
        end
    end
end, false)



-- Have the peds chase each other.
-- while true do
--     -- Shorten this timer sometime
--     Wait(200)
--     if not IsEntityDead(ped1, false) or not IsEntityDead(ped2, false) then

--     end
-- end

-- Spawn 2 peds
-- Put them both in a chopper and have the first one fly up and test this on the other one.
-- TaskHeliChase()
