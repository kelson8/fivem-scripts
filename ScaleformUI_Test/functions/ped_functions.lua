-- Copied from kc_test, player_functions.lua
-- Driving styles: https://gtaforums.com/topic/822314-guide-driving-styles/
local drivingStyleNormal = 786603
local drivingStyleRushed = 1074528293
local drivingStyleIgnoreLights = 2883621
-- Random driving style
local drivingStyleTest1 = 8388614

function SpawnDrivingPed()
    -- Create a lester ped at the players current location
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)
    -- TODO Add this to where if the player gets out the ped will stop driving and this gets changed to true.
    -- Also if the player gets back in the ped will continute driving and this gets changed to false.
    local stop = false

    local x,y,z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y+1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 
    or not HasModelLoaded(lesterModel) do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(lesterPed, x, y+1, z, true, false, false, false)
    SetEntityHealth(lesterPed, 1000)

    -- This seems to work.
    -- Test making them get into a vehicle.
    -- local vehicle = spawnVehicleWithoutBlip(GetHashKey("adder"), playerCoords.x + 3, playerCoords.y + 3, playerCoords.z)
    -- local vehicleId = 
    -- TaskEnterVehicle(lesterPed, vehicle, 3000, 0, 1.0, 8)

    -- local vehicleName = "adder"
    -- Custom police vehicle
    local vehicleName = "polbuffwb"
    local car = GetHashKey(vehicleName)

    -- -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

    -- -- Load the model
    RequestModel(vehicleName)

    -- -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(car) do
        Wait(500)
    end

    SetModelAsNoLongerNeeded(car)
        -- SetVehicleTyresCanBurst(vehicleName, true)
    -- local pedDrivingVeh1 = CreateVehicle(vehicleName, x + 3, y + 3, z, heading, true, false)
    pedDrivingVeh1 = CreateVehicle(vehicleName, x + 3, y + 3, z, heading, true, false)
    --

    -- Enable the cop siren
    SetVehicleSiren(pedDrivingVeh1, true)

    local vehicleId = NetworkGetNetworkIdFromEntity(pedDrivingVeh1)

    -- TODO Figure out why this is defined twice.
    TaskEnterVehicle(lesterPed, NetToVeh(pedDrivingVeh1), 3000, 0, 1.0, 8)
    -- Using -1 for timeout makes it to where it doesn't warp them in
    -- 1 for timeout so they get in, -1 for driver seat
    -- TaskEnterVehicle(lesterPed, vehicle, -1, -1, 1.0, 1)
    -- 16 to teleport into the vehicle.
    -- TaskEnterVehicle(lesterPed, pedDrivingVeh1, 1, -1, 1.0, 16)
    TaskWarpPedIntoVehicle(lesterPed, pedDrivingVeh1, -1)

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

    -- This should fix the problem
    local driveToMarker = true

    -- Test driving to marker, this works!
    if driveToMarker then

        -- TODO Fix this to work.
        -- Show the subtitle, this doesn't work.
        -- showSubtitle("The driving ped will go to your ~p~Marker~s~", 2000)
        
        -- Idea for this came from here: https://forum.cfx.re/t/get-gps-waypoint-coords/79387/2
        if (blip ~= 0) then
            local coord = GetBlipCoords(blip)
            blipX = coord.x
            blipY = coord.y
            blipZ = coord.z
            -- Mph = speed * 2.236936
            -- Kph = speed * 3.6
            -- speed = 60.0
            -- speed = 45.0
            speed = 30.0 -- About 66.2 mph
            -- speed = 23.0 -- 51.4mph
            TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, blipZ, speed, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
            -- TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, blipZ, speed, 0, vehicleName, drivingStyleNormal, 15, -1)
        end
    end

    local wanderAround = false
    local driveToCoords = false
    -- Drive to coords
    if driveToCoords then
        -- TaskVehicleDriveToCoord(lesterPed, vehicle, 389.19, -857.92, 29.14, 30.0, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
    end

    -- Wander around
    -- This doesn't seem to work like this
    if wanderAround then
        TaskVehicleDriveWander(lesterPed, pedDrivingVeh1, 40.0, 786469)
    end

    -- if driveToCoords and wanderAround then
        -- notify("Cannot use both values!")
    -- end
    
    -- Store the network id of the ped.
    lesterPedNetId = NetworkGetNetworkIdFromEntity(lesterPed)

    SetModelAsNoLongerNeeded(lesterModel)
    SetEntityAsNoLongerNeeded(lesterPed)
end