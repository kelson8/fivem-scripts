-- Routing bucket client to server

-- I have moved this to routing bucket 2.
-- This works! I created a basic command that can toggle peds and vehicles on/off using a boolean.
-- local peds = true
-- RegisterCommand("togglepeds", function()
--     if peds then
--         notify("Peds disabled!")
--         peds = false
--     else
--         notify("Peds enabled!")
--         peds = true
--     end
-- end, true)

-- TODO Test this later.
-- RegisterCommand("settargetr", function(_, args)
--     local targetId = tonumber(args[1])
--     -- local targetId = tonumber(args[1])
--     -- local vehicleId = tonumber(args[2])
--     local routingBucket = tonumber(args[2])

--     if IsPedInAnyVehicle(targetId, false) then
--         local vehicle = GetVehiclePedIsIn(targetId, false)
--     end
-- end, true)

-- TODO Figure out how to get vehicle id of other player.
RegisterCommand("setentityr", function(_, args)
    local player = GetPlayerPed(-1)
    -- local entityId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    local entityId = tonumber(args[1])
    local routingBucket = tonumber(args[2])

    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if args[1] ~= nil then
            TriggerServerEvent("ch_test:setEntityRtr", entityId, routingBucket)
            sendMessage(("You have set the entity id of entity %s to %s"):format(entityId, routingBucket))
        else
            TriggerServerEvent("ch_test:setEntityRtr", netId, routingBucket)
            sendMessage(("You have set the entity id of your vehicle to %s"):format(netId, routingBucket))
        end
    end
end, true)



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