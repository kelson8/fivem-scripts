function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

local tonyaPed = nil
local towTruck = nil

-- Make a ped tow the player:
-- Spawn the ped
-- Set ped to get in a tow truck, and hook onto the player's vehicle if they are in one.
-- Set the ped to tow the player somewhere in Los Santos.

function LoadModel(model)
    if IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(0)
        end
    end
end

-- TODO Figure out how to complete this command.

-- Well, this doesn't properly work lol, the tow arm doesn't get hooked properly.

RegisterCommand("towtruck", function()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(PlayerPedId())

    -- Some of this was replicated from MiscGetTowed.cpp in the Chaos Mod
    local tonyaHash = GetHashKey("ig_tonya")
    local towTruckHash = GetHashKey("towtruck")
    local relationshipGroup = 0
    AddRelationshipGroup("_TOW_TRUCK_TONYA", relationshipGroup)
    SetRelationshipBetweenGroups(0, relationshipGroup, GetHashKey("MP0"))

    -- Seems to work from my kc_util resource.
    -- exports['kc_util']:notify("Test")

    -- Not sure if this below will work, probably not.
    -- local rearBottomLeft = 0
    -- local frontTopRight = 0

    -- GetModelDimensions(towTruckHash, rearBottomLeft, frontTopRight)

    if IsPedInAnyVehicle(player, false) then
        -- Load the models
        LoadModel(tonyaHash)
        LoadModel(towTruckHash)

        local spawnPos = vector3(playerCoords.x + 10, playerCoords.y + 10, playerCoords.z)

        towTruck = CreateVehicle(towTruckHash, spawnPos.x, spawnPos.y, spawnPos.z, 10.0, false, false)
        tonyaPed = CreatePed(5, tonyaHash, spawnPos.x + 5, spawnPos.y + 5, spawnPos.z, 10.0, false, false)
        TaskEnterVehicle(tonyaPed, towTruck, 10000, 0, 10, 16, 0)

        local vehicle = GetVehiclePedIsIn(player, false)
        -- if GetEntityHealth(vehicle) < 100 then
        -- sendMessage("Health is low!")
        AttachVehicleToTowTruck(towTruck, vehicle, true, 0, 0, 0)
        SetVehicleTowTruckArmPosition(towTruck, 1.0)
        -- TaskVehicleDriveToCoordLongrange(tonyaPed, towTruck, 404, -1630, 29, 9999, 262668, 0.0)

        -- Well this one mostly works
        TaskVehicleDriveWander(tonyaPed, towTruck, 30.0, 262668)
        -- end

        -- Make sure to cleanup for the game.
        SetModelAsNoLongerNeeded(towTruckHash)
        SetModelAsNoLongerNeeded(tonyaHash)

    end
end, false)

-- Well this works to cleanup for the towtruck, also blows it up.
RegisterCommand("blowup_towtruck", function ()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0
    local cameraShake = 1.0

    if towTruck ~= nil then
        local towTruckCoords = GetEntityCoords(towTruck)
        towTruckX, towTruckY, towTruckZ = table.unpack(towTruckCoords)
        AddExplosion(towTruckX, towTruckY, towTruckZ, gaspumpExplosion,
            damageScale, true, false, cameraShake, false)

        -- SetEntityAsMissionEntity(towTruck, false, false)
        SetEntityAsNoLongerNeeded(towTruck)
        towTruck = nil

        -- print("Towtruck blown up, and removed from memory.")
    end

    if tonyaPed ~= nil then
        SetEntityAsNoLongerNeeded(tonyaPed)
        tonyPed = nil
        -- print("Tonya ped removed")
    end

end)