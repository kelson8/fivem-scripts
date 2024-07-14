function createVehBlip(blip, vehicle)
    local vehBlip = AddBlipForEntity(vehicle)
    AddBlipForEntity(vehBlip)
    SetBlipSprite(vehBlip, blip)
end

function removeVehBlip(blip, vehicle)
    RemoveBlip(blip)
end

-- function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r, g, b)
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

    -- SetEntityAsNoLongerNeeded(car)
    SetModelAsNoLongerNeeded(car)

    SetVehicleTyresCanBurst(vehicleName, true)

    -- These color options don't seem to work.

    -- Car color test
    local carColorPrimary = colors.classic["Surf Blue"]
    local carColorSecondary = colors.classic["Lava Red"]
    SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

    -- SetVehicleCustomPrimaryColour(vehicleName, 255, 0, 0)
    -- SetVehicleCustomSecondaryColour(vehicleName, 255, 0 , 0)
    CreateVehicle(vehicleName, x, y, z, heading, true, false)

    -- 6-24-2024 @ 3:28PM
    -- Possibly add this at the bottom
    -- SetModelAsNoLongerNeeded(car)
end

function spawnPersonalVehicleWithBlip(vehicleName)
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
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local heading = GetEntityHeading(ped)

    -- Set this to true to spawn player into vehicle.
    local spawnInVehicle = true


    -- TODO Setup spawn in vehicle check.
    -- TODO Fix this to where it doesn't despawn when you walk a bit from it.
    -- Setup persistant vehicle check, if enabled the current vehicle won't despawn.
    if (spawnInVehicle) then
        -- Remove vehicle if player is in one.
        if (IsPedSittingInAnyVehicle) then
            deleteCurrentVehicle(GetVehiclePedIsIn(ped, false))
        end

        -- Set the player into the drivers seat
        local vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        SetPedIntoVehicle(ped, vehicle, -1)

        -- Add the blip for personal vehicle.
        createVehBlip(225, vehicle)

        -- This should stop despawning of personal vehicles that get spawned in.
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        -- Adding the else fixed the vehicle spawning in multiple times.
    else
        local vehicle = CreateVehicle(vehicleName, x + 3, y + 3, z + 1, heading, true, false)

        -- Add the blip for personal vehicle.
        createVehBlip(225, vehicle)
        -- This should stop despawning of personal vehicles that get spawned in.
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    end
end

-- Todo Set this to where the personal vehicle marker gets removed if the car explodes.
function spawnVehicleWithBlip(vehicleName)
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
    local x, y, z = table.unpack(GetEntityCoords(ped))
    local heading = GetEntityHeading(ped)

    -- Set this to true to spawn player into vehicle.
    local spawnInVehicle = true


    -- TODO Setup spawn in vehicle check.
    -- TODO Fix this to where it doesn't despawn when you walk a bit from it.
    -- Setup persistant vehicle check, if enabled the current vehicle won't despawn.
    if (spawnInVehicle) then
        -- Remove vehicle if player is in one.
        if (IsPedSittingInAnyVehicle) then
            deleteCurrentVehicle(GetVehiclePedIsIn(ped, false))
        end

        -- Set the player into the drivers seat
        local vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        SetPedIntoVehicle(ped, vehicle, -1)

        -- Car color test
        local carColorPrimary = colors.classic["Surf Blue"]
        local carColorSecondary = colors.classic["Lava Red"]
        SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

        -- Add the blip for personal vehicle.
        createVehBlip(225, vehicle)

        -- Not sure if these are needed twice.
        SetEntityAsNoLongerNeeded(car)
        SetModelAsNoLongerNeeded(car)
        -- Adding the else fixed the vehicle spawning in multiple times.
    else
        local vehicle = CreateVehicle(vehicleName, x + 3, y + 3, z + 1, heading, true, false)

        -- Add the blip for personal vehicle.
        createVehBlip(225, vehicle)

        SetEntityAsNoLongerNeeded(car)
        SetModelAsNoLongerNeeded(car)
    end
end

function deleteCurrentVehicle(vehicleName)
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(vehicleName) then
        if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            --local vehBlip = GetBlipFromEntity(vehicle)

            -- Will this work?
            --if vehBlip == 0 then
            if GetBlipFromEntity(vehicle) == 0 then
                return
            else
                removeVehBlip()
            end

            SetEntityAsMissionEntity(vehicle)
            DeleteVehicle(vehicle)
        end
    end
end
