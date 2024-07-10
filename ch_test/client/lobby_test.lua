-- Will this possibly work? Trying to spawn a vehicle in the same place
-- Eventually I would like to add saving my own vehicles into the database.
-- This works!! I had to move it into a client script
-- https://github.com/itsJarrett/FiveM-boot_vehicles

Citizen.CreateThread(function()
    Wait(0)
    spawnVehicle("nemesis")
    -- Wait(0)
    -- -- modelHash = "nemesis"
    -- -- local modelHash = "adder"
    -- local modelHash = GetHashKey("adder")

    -- local vehSpawnLoc1 = vector3(-1369.43, -476.13, 49.1)
    -- local vehSpawnHeading = 185.93

    -- -- if not IsModelInCdimage(modelHash) then return end
    -- RequestModel(modelHash)
    -- while not HasModelLoaded(modelHash) do
    --     Wait(0)
    -- end
    -- CreateVehicle(modelHash, vehSpawnLoc1, vehSpawnHeading, true, false)
end)

function spawnVehicle(vehicleName)
    local car = GetHashKey(vehicleName)

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
    notify("~r~Error~w~: The model " .. vehicleName .. " doesn't exist!")
    end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local ped = GetPlayerPed(-1)
    local vehSpawnLocX, vehSpawnLocY, vehSpawnLocZ = -1369.43, -476.13, 49.1
    local vehSpawnHeading = 185.93

        local vehicle = CreateVehicle(vehicleName, vehSpawnLocX, vehSpawnLocY,  vehSpawnLocZ, vehSpawnHeading, true, false)

        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicle)
end