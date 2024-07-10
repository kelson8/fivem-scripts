local lesterPedNetId = 0
-- Set this to be changed, if it's nil then the vehicle doesn't exist.
local pedDrivingVeh1 = nil

-- Vehicle functions
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

-- Driving styles: https://gtaforums.com/topic/822314-guide-driving-styles/
local drivingStyleNormal = 786603
local drivingStyleRushed = 1074528293
local drivingStyleIgnoreLights = 2883621
-- Random driving style
local drivingStyleTest1 = 8388614



-- I wonder how to return the ped, to make this be used for a /pedveh command
-- Make the ped enter a vehicle on a seperate command.

-- Spawn a ped with 1000 health, set them into a vehicle.
-- Todo Setup health bar above the ped.
-- This might be useful for what I'm trying to do: https://github.com/Lanzaned-Enterprises/LENT-PedSpawner/blob/main/client/cl_main.lua
RegisterCommand("spawnped", function()
    -- Create a lester ped at the players current location
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x,y,z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y+1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(lesterPed, x, y+1, z, true, false, false, false)
    SetEntityHealth(lesterPed, 1000)

    -- Test giving them a weapon and aiming at the player, this didn't work
    -- giveWeapon("WEAPON_PISTOL")
    -- This works for the player if I reverse it.

    -- I had to add this to fix it, but they don't damage the player.
    -- Makes it to where the player is an enemy to the ped.
    -- https://gist.github.com/ghermans/30b7e578fca2494b20616f8d4725d05c
    SetPedRelationshipGroupHash(lesterPed, GetHashKey('AMBIENT_GANG_LOST'))

    GiveWeaponToPed(lesterPed, GetHashKey("WEAPON_PISTOL"), 9999, false, true)
    --
    SetCurrentPedWeapon(lesterPed, GetHashKey("WEAPON_PISTOL"), true)
    TaskAimGunAtEntity(lesterPed, player, 20000, false)
    TaskShootAtEntity(lesterPed, player, 20000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))

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

    SetModelAsNoLongerNeeded(lesterModel)
    SetEntityAsNoLongerNeeded(lesterPed)

    -- while true do
    --     holograms(x_1, y_1, z_1 + 3)
    --     end

    -- SetEntityCoords(lesterPed, x, y, z, true, false, false, false)

    -- Test function
    -- notify("Coords: " .. x .. " " .. y .. " " .. z .. " Heading: " .. playerHeading)

end, false)

-- TODO Make the ped stop if I get out, he drives away lol.
RegisterCommand("drivingped", function()
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

    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
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
    while not HasModelLoaded(vehicleName) do
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
    TaskEnterVehicle(lesterPed, pedDrivingVeh1, 1, -1, 1.0, 16)

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
        showSubtitle("The driving ped will go to your ~p~Marker~s~", 2000)
        
        -- Idea for this came from here: https://forum.cfx.re/t/get-gps-waypoint-coords/79387/2
        if (blip ~= 0) then
            local coord = GetBlipCoords(blip)
            blipX = coord.x
            blipY = coord.y
            blipZ = coord.z
            -- Mph = speed * 2.236936
            -- Kph = speed * 3.6
            -- speed = 60.0
            speed = 45.0
            TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, blipZ, speed, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
            -- TaskVehicleDriveToCoord(lesterPed, pedDrivingVeh1, blipX, blipY, 35.0, speed, 0, vehicleName, drivingStyleIgnoreLights, 15, -1)
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
end, false)

-- TODO Test this
-- This should stop the lester ped without making them exit the vehicle, or they'll wander around.
RegisterCommand("stopped", function()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local x,y,z = table.unpack(playerCoords)

    -- Redefine these to add 3 to them
    local x,y = x+3, y+3
    local heading = 0

    -- https://forum.cfx.re/t/need-help-issue-with-taskvehiclepark-and-getistaskactive/2397492
    -- Will this possibly work?
    if DoesEntityExist(lesterPedNetId) and pedDrivingVeh1 ~= nil then
        TaskVehiclePark(lesterPedNetId, pedDrivingVeh1, x, y, z, heading, 60.0, 20, true)
        -- ClearPedTasksImmediately(lesterPedNetId)
    end
end)

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

-- This seems to work for getting the previous peds network id, stored by one of the functions.
RegisterCommand("previd", function()
    notify("Lester ped net id: " .. lesterPedNetId)
end)

-- TODO Fix this up to work.
-- RegisterCommand("delprevped", function()
--     -- SetEntityHealth()
-- end)

-- Test event to possibly store the ped network id
function spawnPedTest()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x,y,z = table.unpack(playerCoords)
    -- local x_1, y_1, z_1 = -1441.38, -1385.25, 7.5

    local lesterModel = GetHashKey("ig_lestercrest")
    -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
    local lesterPed = CreatePed(1, lesterModel, z, y+1, z, playerHeading, true, true)
    -- Oops, I had this set to request the ped instead of the model hash.
    RequestModel(lesterModel)

    while not DoesEntityExist(lesterPed) or NetworkGetNetworkIdFromEntity(lesterPed) == 0 do
        Citizen.Wait(100)
    end

    -- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
    SetEntityCoords(lesterPed, x, y+1, z, true, false, false, false)
    SetEntityHealth(lesterPed, 1000)

    -- if DoesEntityExist(lesterPed) then
        
    -- end

    SetModelAsNoLongerNeeded(lesterModel)
    SetEntityAsNoLongerNeeded(lesterPed)
    -- return NetworkGetNetworkIdFromEntity(lesterPed)
    lesterPedNetId = NetworkGetNetworkIdFromEntity(lesterPed)
    -- return lesterPedNetId

end

-- This works
RegisterCommand("spawnpedtest", function()
    spawnPedTest()
    notify("Entity id: " .. lesterPedNetId)

end)

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
        local x,y,z = table.unpack(playerCoords)

        local lesterModel = GetHashKey("ig_lestercrest")
        -- local lesterPed = CreatePed(1, lesterModel, x_1, y_1, z_1, 10.0, true, true)
        local lesterPed = CreatePed(1, lesterModel, z, y+1, z, playerHeading, true, true)
        -- Oops, I had this set to request the ped instead of the model hash.
        RequestModel(lesterModel)

        local lesterPed2 = CreatePed(1, lesterModel, z, y+3, z, playerHeading, true, true)

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
        SetEntityCoords(lesterPed, x, y+1, z, true, false, false, false)
        SetEntityCoords(lesterPed2, x, y+3, z, true, false, false, false)

        -- SetEntityHealth(lesterPed, 1000)

        -- Set them to the lost mc and the ballas
        -- https://gist.github.com/ghermans/30b7e578fca2494b20616f8d4725d05c
        SetPedRelationshipGroupHash(lesterPed, GetHashKey('AMBIENT_GANG_LOST'))
        SetPedRelationshipGroupHash(lesterPed2, GetHashKey('AMBIENT_GANG_BALLAS'))

        SetEntityAsNoLongerNeeded(lesterPed)
        SetEntityAsNoLongerNeeded(lesterPed2)

end, false)
