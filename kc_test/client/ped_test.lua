-- Net id
local ped1NetId = 0
-- Ped handle
-- local lesterPed = nil
-- Set this to be changed, if it's nil then the vehicle doesn't exist.
local pedDrivingVeh1 = nil

-- Driving styles: https://gtaforums.com/topic/822314-guide-driving-styles/
local drivingStyleNormal = 786603
local drivingStyleRushed = 1074528293
local drivingStyleIgnoreLights = 2883621
-- Random driving style
local drivingStyleTest1 = 8388614

----------
--- Functions
----------

-- Todo look into functions from here:
-- https://github.com/jevajs/Jeva/blob/master/FiveM%20-%20Ped%20AI%20and%20Manipulation/peds/ped_c.lua


--- Vehicle functions

function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
    local car = GetHashKey(vehicleName)

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end
    SetModelAsNoLongerNeeded(car)
    SetVehicleTyresCanBurst(vehicleName, true)
    CreateVehicle(vehicleName, x, y, z, heading, true, false)
end

function StopDrivingPed()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local x, y, z = table.unpack(playerCoords)
    local networkPed = NetworkGetEntityFromNetworkId(ped1NetId)

    -- Redefine these to add 3 to them
    local x, y = x + 3, y + 3
    local heading = 0

    -- https://forum.cfx.re/t/need-help-issue-with-taskvehiclepark-and-getistaskactive/2397492
    -- Check if the network Ped exists and they are in a vehicle.
    if DoesEntityExist(networkPed) and IsPedInAnyVehicle(networkPed, false) then
        -- TaskVehiclePark(lesterPedNetId, pedDrivingVeh1, x, y, z, heading, 60.0, 20, true)
        -- TaskVehiclePark(networkPed, pedDrivingVeh1, x, y, z, heading, 60.0, 20, true)
        notify("Stopping the car!")
        TaskLeaveVehicle(networkPed, pedDrivingVeh1, 0)
        -- Make the ped wander around.
        TaskWanderStandard(networkPed, 10.0, 10)
        -- ClearPedTasks(lesterPedNetId)
        -- ClearPedTasks(networkPed)
        -- notify("Success")
        -- ClearPedTasksImmediately(lesterPedNetId)
    end
end

-- Check if the ped is too far away from the player, if so despawn them to prevent lag
-- Also remove the vehicle if possible.
local function IsPedFarAway()
    -- local function BlowUpFarAwayPed()
    -- Check if the ped exists, otherwise do nothing
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
    local x, y, z = table.unpack(coords)

    if ped1NetId ~= 0 then
        local pedEntity = NetworkGetEntityFromNetworkId(ped1NetId)
        local pedCoords = GetEntityCoords(pedEntity)
        local pedX, pedY, pedZ = table.unpack(pedCoords)
        local gaspumpExplosion = 9
        local railgunExplosion = 36
        local damageScale = 100.0
        -- Not sure what this is from but it's what I use for this
        local cameraShake = 1065353216

        -- Oops, I set this to less then and they blew up right beside me lol.

        local explodePed = true
        -- Check if the ped is greater then the distance and is alive
        if Vdist(x, y, z, pedX, pedY, pedZ) > 10 and not IsEntityDead(pedEntity) then
            -- Explode them as a test :>
            if explodePed then
                AddExplosion(pedX, pedY, pedZ, gaspumpExplosion, damageScale, true, false, cameraShake, false)
            else
                DeletePed(pedEntity)
            end
        else
            return
        end
    end
end


--------------



-- TODO Test this, and move this when complete.
function MphToMeters(value)
    -- MphToMeters(35.2)
    return value / 2.237
end

-- Create ped test function

function CreateCustomPed(ped)
    -- Create a lester ped at the players current location
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x, y, z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    -- local lesterModel = GetHashKey("ig_lestercrest")
    -- Do nothing if the model doesn't exist
    if not IsModelInCdimage(ped) then return end

    local pedModel = GetHashKey(ped)
    -- local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, z, y + 1, z, playerHeading, true, true)
    local customPed = CreatePed(1, pedModel, z, y + 1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(pedModel)

    while not DoesEntityExist(customPed) or NetworkGetNetworkIdFromEntity(customPed) == 0
        or not HasModelLoaded(pedModel) do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(customPed, x, y + 1, z, true, false, false, false)
    SetEntityHealth(customPed, 1000)

    return customPed

    -- SetModelAsNoLongerNeeded(lesterModel)
    -- SetModelAsNoLongerNeeded(lesterModel)
    -- SetEntityAsNoLongerNeeded(lesterPed)
end

-- Possible fix for above function
function test()
    local player = GetPlayerPed(-1)
    local previousVeh = GetVehiclePedIsIn(player, true)
    while true do
        -- This don't need to run constantly I don't think.
        Wait(500)
        -- Check if player exits above vehicle, it needs to be viewable outside of that function also along with the ped.
        -- This should stop the driving ped from driving if the player leaves the vehicle or types /stopveh.
        -- If player is in a vehicle and pedDrivingVeh1 is not nil
        if IsPedSittingInAnyVehicle(player) and pedDrivingVeh1 ~= nil then
            -- Will this work?
            if previousVeh == pedDrivingVeh1 then
                -- I'm not sure how to make the ped stop and go.
            end
        end
    end
end

-- TODO Fix this up to work.
-- RegisterCommand("delprevped", function()
--     -- SetEntityHealth()
-- end)

-- Test event to possibly store the ped network id
function spawnPedTest()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x, y, z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y + 1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    -- Wait on the model
    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(lesterPed, x, y + 1, z, true, false, false, false)
    -- SetEntityHealth(lesterPed, 1000)
    SetEntityHealth(lesterPed, 100)

    GiveWeaponToPed(lesterPed, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
    SetCurrentPedWeapon(lesterPed, GetHashKey("WEAPON_PISTOL"), true)

    SetModelAsNoLongerNeeded(lesterModel)
    SetEntityAsNoLongerNeeded(lesterPed)
    -- return NetworkGetNetworkIdFromEntity(lesterPed)

    -- Make it to where they won't run away
    -- SetPedFleeAttributes(lesterPed, 0, false)

    ped1NetId = NetworkGetNetworkIdFromEntity(lesterPed)

    -- This seems to work in here.
    Citizen.CreateThread(function()
        local player = GetPlayerPed(-1)
        local pedNetId = NetworkGetEntityFromNetworkId(ped1NetId)
        while not IsEntityDead(pedNetId, false) do
            -- This shouldn't always run
            Wait(1000)
            -- TaskHandsUp(pedNetId, 500, true, 1, false)
            TaskAimGunAtEntity(pedNetId, player, 1000)
        end
    end)
    -- return lesterPedNetId
end

----------
---
----------


--------------
--- Commands
--------------

---
---- Spawn commands
---

-- TODO Make the ped stop if I get out, he drives away lol.
RegisterCommand("drivingped", function()
    -- Create a lester ped at the players current location
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)
    -- TODO Add this to where if the player gets out the ped will stop driving and this gets changed to true.
    -- Also if the player gets back in the ped will continute driving and this gets changed to false.
    local stop = false

    local x, y, z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    -- Todo Test moving the ped spawning into a function
    -- local lesterPed = GetHashKey("ig_lestercrest")
    -- local customPed = CreateCustomPed(lesterPed)

    --

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y + 1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0
        or not HasModelLoaded(lesterModel) do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(lesterPed, x, y + 1, z, true, false, false, false)
    SetEntityHealth(lesterPed, 1000)

    -- Test setting the ped voice to lester.
    -- SetPedVoiceGroup(lesterPed, GetHashKey("ig_lestercrest"))
    SetPedVoiceGroup(lesterPed, GetHashKey(""))

    -- This seems to work.
    -- Test making them get into a vehicle.
    -- local vehicle = spawnVehicleWithoutBlip(GetHashKey("adder"), playerCoords.x + 3, playerCoords.y + 3, playerCoords.z)
    -- TaskEnterVehicle(lesterPed, vehicle, 3000, 0, 1.0, 8)

    -- local vehicleName = "adder"
    -- Custom police vehicle
    local vehicleName = "polbuffwb"
    local car = GetHashKey(vehicleName)

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(car) do
        Wait(500)
    end

    SetModelAsNoLongerNeeded(car)
    -- SetVehicleTyresCanBurst(vehicleName, true)
    -- local pedDrivingVeh1 = CreateVehicle(vehicleName, x + 3, y + 3, z, heading, true, false)
    pedDrivingVeh1 = CreateVehicle(vehicleName, x + 3, y + 3, z, heading, true, false)
    --

    -- Enable the cop siren
    -- SetVehicleSiren(pedDrivingVeh1, true)

    local vehicleId = NetworkGetNetworkIdFromEntity(pedDrivingVeh1)

    -- TODO Figure out why this is defined twice.
    -- TaskEnterVehicle(lesterPed, NetToVeh(pedDrivingVeh1), 3000, 0, 1.0, 8)
    -- Using -1 for timeout makes it to where it doesn't warp them in
    -- 1 for timeout so they get in, -1 for driver seat
    -- TaskEnterVehicle(lesterPed, vehicle, -1, -1, 1.0, 1)
    -- 16 to teleport into the vehicle.
    -- TaskEnterVehicle(lesterPed, pedDrivingVeh1, 1, -1, 1.0, 16)

    -- Make the player enter the vehicle.
    -- Well this makes the player just take whoever is in the vehicle out if they enter the passenger side.

    -- Seat Numbers: https://nativedb.dotindustries.dev/gta5/natives/0x9A7D091411C5F684
    -------------------------------
    -- Driver = -1
    -- Any = -2
    -- Left-Rear = 1
    -- Right-Front = 0
    -- Right-Rear = 2
    -- Extra seats = 3-14(This may differ from vehicle type e.g. Firetruck Rear Stand, Ambulance Rear)
    --#endregion
    TaskWarpPedIntoVehicle(player, pedDrivingVeh1, 1)

    -- Task: https://nativedb.dotindustries.dev/gta5/natives/0xE2A2AA2F659D77A7

    local blip = GetFirstBlipInfoId(8)
    local blipX = 0.0
    local blipY = 0.0

    -- Test
    local blipZ = 0.0

    -- Enable the features to use here, if more then one is enabled this command won't run.
    local driveToMarker = false
    local wanderAround = true
    local driveToCoords = false

    -- Test driving to marker, this works!
    if driveToMarker then
        -- TODO Fix this to work.
        -- Show the subtitle, this doesn't work.
        showSubtitle("The driving ped will go to your ~p~Marker~s~", 2000)

        -- Idea for this came from here: https://forum.cfx.re/t/get-gps-waypoint-coords/79387/2
        if (blip ~= 0) then
            local coord = GetBlipCoords(blip)
            blipX = coord.x
            blipY = coord.y
            blipZ = coord.z

            -- TODO Convert miles per hour to meters per second.
            -- This is currently using meters per second and is annoying to convert.
            -- Mph = speed * 2.236936
            -- Kph = speed * 3.6
            -- speed = 60.0
            -- speed = MphToMeters(35.2)
            speed = 23.0 -- 51.4mph
            -- speed = 45.0
            TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, blipZ, speed, 0, vehicleName,
                drivingStyleIgnoreLights, 15, -1)
            -- TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, 35.0, speed, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
        end
    end

    -- Drive to coords
    if driveToCoords then
        -- TaskVehicleDriveToCoord(lesterPed, vehicle, 389.19, -857.92, 29.14, 30.0, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
    end

    -- Wander around
    if wanderAround then
        speed = 30.0
        TaskVehicleDriveWander(lesterPed, pedDrivingVeh1, speed, drivingStyleIgnoreLights)
    end

    -- Todo Figure out how to implement this, make this command not run if two or more values are enabled.
    -- if driveToCoords and wanderAround and driveToMarker then
    --     notify("Cannot use both values!")
    -- end

    -- Store the network id of the ped.
    -- This makes it to where the ped can be stopped with the function and command.
    ped1NetId = NetworkGetNetworkIdFromEntity(lesterPed)
end, false)

-- I wonder how to return the ped, to make this be used for a /pedveh command
-- Make the ped enter a vehicle on a seperate command.


--------------

local function SpawnShootingPed(pedName)
    -- Create a ped at the players current location and try to kill the player.
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x, y, z = table.unpack(playerCoords)

    local highHealth = false
    local enemyPed = true
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    -- https://wiki.rage.mp/index.php?title=Peds
    -- local pedModel = GetHashKey("ig_lestercrest")
    -- local pedModel = GetHashKey("s_m_m_prisguard_01")

    -- Make this send an error if the ped doesn't exist
    if not IsModelInCdimage(pedName) then
        notify("Ped doesn't exist")
        return
    end

    -- local pedModel = GetHashKey("ig_siemonyetarian")
    local pedModel = GetHashKey(pedName)
    local ped = CreatePed(1, pedModel, z, y + 10, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(pedModel)

    while not DoesEntityExist(ped) or NetworkGetNetworkIdFromEntity(ped) == 0 do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(ped, x, y + 10, z, true, false, false, false)

    if highHealth then
        SetEntityHealth(ped, 1000)
    end

    -- giveWeapon("WEAPON_PISTOL")
    -- This works for the player if I reverse it.

    -- https://gist.github.com/ghermans/30b7e578fca2494b20616f8d4725d05c

    if enemyPed then
        SetPedRelationshipGroupHash(ped, GetHashKey('AMBIENT_GANG_LOST'))

        -- Taken from client.lua in mth-aggressive
        -- https://forum.cfx.re/t/free-mth-aggressive-an-aggressive-ped-spawner/5056241
        SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("AMBIENT_GANG_LOST"))
        SetRelationshipBetweenGroups(5, GetHashKey("AMBIENT_GANG_LOST"), GetHashKey("PLAYER"))
        SetPedCombatRange(ped, 2)

        SetPedCombatAttributes(ped, 46, 1)
        SetPedFleeAttributes(ped, 0, 0)

        TaskCombatPed(ped, player, 0, 16)
        SetPedKeepTask(ped, true)
        SetPedHasAiBlip(ped, true)
        SetPedAiBlipHasCone(ped, true)

        -- GiveWeaponToPed(lesterPed, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
        GiveWeaponToPed(ped, GetHashKey("WEAPON_COMBATPISTOL"), 9999, false, true)
        --
        -- SetCurrentPedWeapon(ped, GetHashKey("WEAPON_PISTOL"), true)
        SetCurrentPedWeapon(ped, GetHashKey("WEAPON_COMBATPISTOL"), true)
        -- TaskAimGunAtEntity(ped, player, 20000, false)

        -- Moved
        -- TaskShootAtEntity(ped, player, 20000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
    else
        TaskWanderStandard(ped, 10.0, 10)
    end
    -- Store the network id of the ped.
    -- This makes it to where the ped can be stopped with the function and command.
    ped1NetId = NetworkGetNetworkIdFromEntity(ped)

    SetModelAsNoLongerNeeded(pedModel)
    SetEntityAsNoLongerNeeded(ped)

    --- Test stuff



    -- Will this work? I should be able to modify the ped outside of this command using the id.
    -- notify("Entity network id: " .. NetworkGetNetworkIdFromEntity(lesterPed))


    -- This didn't seem to do anything
    -- TaskCombatPed(leserPed, player, 0, 16)

    -- This seems to work.
    -- Test making them get into a vehicle.
    -- local vehicle = spawnVehicleWithoutBlip(GetHashKey("adder"), playerCoords.x + 3, playerCoords.y + 3, playerCoords.z)
    -- local vehicleId =
    -- TaskEnterVehicle(lesterPed, vehicle, 3000, 0, 1.0, 8)

    -- local vehicleName = "adder"
    -- local car = GetHashKey(vehicleName)

    -- -- Check if the vehicle actually exists
    -- if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

    -- -- Load the model
    -- RequestModel(vehicleName)

    -- -- If model hasn't loaded, wait on it.
    -- while not HasModelLoaded(vehicleName) do
    --     Wait(500)
    -- end
    --     SetModelAsNoLongerNeeded(car)
    --     -- SetVehicleTyresCanBurst(vehicleName, true)
    -- local vehicle = CreateVehicle(vehicleName, x + 3, y + 3, z, heading, true, false)
    --

    -- local vehicleId = NetworkGetNetworkIdFromEntity(vehicle)
    -- TaskEnterVehicle(lesterPed, NetToVeh(vehicle), 3000, 0, 1.0, 8)
    -- Using -1 for timeout makes it to where it doesn't warp them in
    -- 1 for timeout so they get in, -1 for driver seat
    -- TaskEnterVehicle(lesterPed, vehicle, -1, -1, 1.0, 1)
    -- 16 to teleport into the vehicle.
    -- TaskEnterVehicle(lesterPed, vehicle, 1, -1, 1.0, 16)

    -- Task: https://nativedb.dotindustries.dev/gta5/natives/0xE2A2AA2F659D77A7

    -- This sometimes works
    -- TaskVehicleDriveToCoord(lesterPed, vehicle, 389.19, -857.92, 29.14, 30.0, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)


    -- Hologram test
    -- lesterPedCoords = GetEntityCoords(lesterPed)
    -- lesterPedHeading = GetEntityHeading(lesterPed)

    -- Add 3 to the Z value to be above the ped.
    -- Create the hologram
    -- Citizen.CreateThread(function()

    -- end)
    -- local x_1, y_1, z_1 = table.unpack(lesterPedCoords)
    -- holograms(x_1, y_1, z_1 + 3)


    -- while true do
    --     holograms(x_1, y_1, z_1 + 3)
    --     end

    -- SetEntityCoords(lesterPed, x, y, z, true, false, false, false)

    -- Test function
    -- notify("Coords: " .. x .. " " .. y .. " " .. z .. " Heading: " .. playerHeading)
end

-- Spawn a ped with 1000 health, set them to shoot the player
-- Todo Setup health bar above the ped.
-- This might be useful for what I'm trying to do: https://github.com/Lanzaned-Enterprises/LENT-PedSpawner/blob/main/client/cl_main.lua
RegisterCommand("spawnped", function()
    -- Create a ped at the players current location and try to kill the player.
    SpawnShootingPed("ig_siemonyetarian")
end, false)

------

---
-- Misc commands
---

-- This works
-- This should stop the lester ped without making them exit the vehicle, or they'll wander around.
RegisterCommand("stopped", function()
    StopDrivingPed()
end)


-- This works
RegisterCommand("spawnpedtest", function()
    spawnPedTest()
    notify("Entity id: " .. ped1NetId)
end)

---
--- Debug commands


-- This seems to work for getting the previous peds network id, stored by one of the functions.
RegisterCommand("previd", function()
    notify("Lester ped net id: " .. ped1NetId)
end)

RegisterCommand("pedcheck", function()
    local pedNetId = NetworkGetEntityFromNetworkId(ped1NetId)
    if not IsEntityDead(pedNetId, false) then
        notify("The ped is alive")
    else
        notify("The ped is dead")
    end
end, false)

-- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
-- This works for stripping the extra digits from the coords
function truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end

-- Oh wow this actually works.
-- 8-9-2024 @ 1:01AM
RegisterCommand("pedcoords", function()
    -- Player
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
    local x, y, z = table.unpack(coords)

    -- Custom ped, check if they exist first.
    -- This won't work if I spawn in multiple peds though since the id gets overwritten.
    -- I could possibly store the entity ids somewhere if i needed to, like in a table
    if ped1NetId ~= 0 then
        local pedEntity = NetworkGetEntityFromNetworkId(ped1NetId)
        local pedCoords = GetEntityCoords(pedEntity)
        local pedX, pedY, pedZ = table.unpack(pedCoords)

        -- if GetDistanceBetweenCoords(x, y, z, pedX, pedY, pedZ, false) then
        if Vdist(x, y, z, pedX, pedY, pedZ) < 10 then
            notify("The ped is close by")
            -- sendMessage(("Ped coords: X:%s Y:%s Z:%s"):format(pedX, pedY, pedZ))
            -- Remove the extra numbers, I only want 3 after the decimal not a ton.
            sendMessage(("Ped coords: X:%s Y:%s Z:%s"):format(truncate(pedX, 3), truncate(pedY, 3), truncate(pedZ, 3)))
        else
            notify("The ped is far away")
        end
    else
        notify("Ped doesn't exist")
    end
end, false)

-- RegisterCommand("spawnpedtest", function(source, args, rawcommand)
--     TriggerEvent("ch_test:SpawnCustomPed")
-- end)

-- RegisterNetEvent("ch_test:SpawnCustomPed")



-- AddEventHandler("ch_test:SpawnCustomPed", function ()
--     -- Create a lester ped at the players current location
--     local player = GetPlayerPed(-1)
--     local playerCoords = GetEntityCoords(player)
--     local playerHeading = GetEntityHeading(player)

--     local x,y,z = table.unpack(playerCoords)
--     -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

--     local lesterModel = GetHashKey("ig_lestercrest")
--     -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
--     local lesterPed = CreatePed(1, lesterModel, z, y+1, z, playerHeading, true, true)
--     -- Oops, I had this set to request the ped instead of the model hash.
--     RequestModel(lesterModel)

--     while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
--         Citizen.Wait(100)
--     end

--     -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
--     SetEntityCoords(lesterPed, x, y+1, z, true, false, false, false)
--     SetEntityHealth(lesterPed, 1000)

--     -- Return the ped network id.
--     -- This shows up, how would I return this value?
--     -- notify(NetworkGetNetworkIdFromEntity(lesterPed))
--     return NetworkGetNetworkIdFromEntity(lesterPed)

-- end)
--

-- This seems to work now.
-- Spawn two lester peds to fight each other.
RegisterCommand("fightingpeds", function()
    -- Create a lester ped at the players current location
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)
    local x, y, z = table.unpack(playerCoords)

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y + 1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    local lesterPed2 = CreatePed(1, lesterModel, z, y + 3, z, playerHeading, true, true)

    -- TODO Figure out a better way to do this, possibly use arrays or something?
    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 or not DoesEntityExist(lesterPed2) do
        Citizen.Wait(100)
    end

    -- while not DoesEntityExist(lesterPed2) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
    --     Citizen.Wait(100)
    -- end

    -- Give the peds weapons
    GiveWeaponToPed(lesterPed, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
    GiveWeaponToPed(lesterPed2, GetHashKey("WEAPON_PISTOL"), 9999, false, true)

    -- Set their weapons
    SetCurrentPedWeapon(lesterPed, GetHashKey("WEAPON_PISTOL"), true)
    SetCurrentPedWeapon(lesterPed2, GetHashKey("WEAPON_PISTOL"), true)

    -- Make them aim and shoot at each other.
    TaskAimGunAtEntity(lesterPed, lesterPed2, 20000, false)
    TaskAimGunAtEntity(lesterPed2, lesterPed, 20000, false)

    TaskShootAtEntity(lesterPed, lesterPed2, 20000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
    TaskShootAtEntity(lesterPed2, lesterPed, 20000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))

    -- Set their coordinates
    SetEntityCoords(lesterPed, x, y + 1, z, true, false, false, false)
    SetEntityCoords(lesterPed2, x, y + 3, z, true, false, false, false)


    -- Make it to where they won't run away from each other
    SetPedFleeAttributes(lesterPed, 0, true)
    SetPedFleeAttributes(lesterPed2, 0, true)
    -- SetEntityHealth(lesterPed, 1000)

    -- Set them to the lost mc and the ballas
    -- https://gist.github.com/ghermans/30b7e578fca2494b20616f8d4725d05c
    SetPedRelationshipGroupHash(lesterPed, GetHashKey('AMBIENT_GANG_LOST'))
    SetPedRelationshipGroupHash(lesterPed2, GetHashKey('AMBIENT_GANG_BALLAS'))

    SetEntityAsNoLongerNeeded(lesterPed)
    SetEntityAsNoLongerNeeded(lesterPed2)
end, false)

-- Todo Fix this to where it doesn't spam the console.
local function CleanupPeds()
    -- Only run this if the ped isn't dead and the id exists

    -- This shouldn't need to run often.
    Wait(500)
    -- For some reason this just spams the console

    -- Check if the ped exists before running this loop.

    -- Wait on the lester ped id to show up.
    local pedEntity = NetworkGetEntityFromNetworkId(ped1NetId)
    if lesterPedId == 0 and DoesEntityExist(pedEntity) then
        Wait(500)
    end

    if DoesEntityExist(pedEntity) and ped1NetId ~= 0 then
        while not IsEntityDead(pedEntity) do
            -- Add a wait to this.
            Wait(0)
            IsPedFarAway()
        end
    else
        return
    end
end

-- Script cleanup
while true do
    -- Check added to prevent console spam with the the entity not existing.
    -- if lesterPedNetId ~= 0 then
    -- local pedEntity = NetworkGetEntityFromNetworkId(lesterPedNetId)

    -- Cleanup the peds if they are far away
    -- if DoesEntityExist(pedEntity) and lesterPedNetId ~= 0 then
    --     while not IsEntityDead(pedEntity) do
    --         Wait(0)
    -- CleanupPeds()
    -- end
    -- end
    -- end

    Wait(0)
end
