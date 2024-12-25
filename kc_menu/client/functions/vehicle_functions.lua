-- SET_DRIFT_TYRES
-- https://nativedb.dotindustries.dev/gta5/natives/0x5AC79C98C5C17F05


-- TODO Move these into a json file for per user configs, Idk if it'll work like this.
local driftTires = false
local doorsLocked = false

-- Get the current vehicle name
function getVehicleNamePlayerIsIn()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        -- https://forum.cfx.re/t/get-vehicle-model-from-hash/3945382
        return GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    end
end

-- This works but doesn't want to turn back off
function toggleDriftTires()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        if not driftTires then
            -- SetDriftTyres(vehicle, true)
            Citizen.InvokeNative(0x5AC79C98C5C17F05, vehicle, true)
            notify("Drift tires enabled.")
            driftTires = true
        else
            Citizen.InvokeNative(0x5AC79C98C5C17F05, vehicle, false)
            -- SetDriftTyres(vehicle, true)
            notify("Drift tires disabled.")
            driftTires = false
        end
    else
        notify("You need to be in a vehicle to use this.")
    end
end

function getVehicleDoorLockStatusValue()
    -- GET_VEHICLE_DOOR_LOCK_STATUS
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player)

    return GetVehicleDoorLockStatus(vehicle)
end



-- So far this only works if the player is in a vehicle, I don't know how to get it to work when they leave it.
function toggleVehicleDoorLock()
    local player = GetPlayerPed(-1)
    local isPedInVehicle = IsPedInAnyVehicle(player, false)

    -- local pedLastVehicle = GetClosestVehicles()
    -- local pedLastVehicle = GetVehiclePedIsIn(player, true)

    -- if IsPedInAnyVehicle(player, false) then
    -- if isPedInVehicle or pedLastVehicle then
    if isPedInVehicle then
        local vehicle = GetVehiclePedIsIn(player, false)

        if not doorsLocked then
            SetVehicleDoorsLocked(vehicle, 2)
            notify("Doors locked")
        else
            -- if pedLastVehicle then
            --     local lastVehicle = GetVehiclePedIsIn(player, true)
            --     SetVehicleDoorsLocked(lastVehicle, 1)
            -- else
                SetVehicleDoorsLocked(vehicle, 1)
            -- end
            notify("Doors unlocked")
        end
    else
        -- TODO Check if previous vehicle is locked
        notify("You need to be in a vehicle to use this")
    end
end

-----------------
-- Copied from kc_car functions.lua
-- TODO Test this in here
-----------------

function createVehBlip(blip, vehicle)
    local vehBlip = AddBlipForEntity(vehicle)
    AddBlipForEntity(vehBlip)
    SetBlipSprite(vehBlip, blip)
end

function removeVehBlip(blip, vehicle)
    RemoveBlip(blip)
end

-- This seems to mostly work besides not maxing the turbo, I wonder how that is fixed.
function setVehicleMaxUpgrades(vehicle)
    SetVehicleModKit(vehicle, 0)
    -- Spoiler
    SetVehicleMod(vehicle, 0, 4, false)
    -- Engine
    SetVehicleMod(vehicle, 11, 3, false)
    -- Transmission
    SetVehicleMod(vehicle, 13, 4, false)
    -- Brakes
    SetVehicleMod(vehicle, 12, 4, false)
    -- Turbo
    SetVehicleMod(vehicle, 18, 0, false)

    -- Armor
    SetVehicleMod(vehicle, 16, 4, false)
    -- Bullet proof tires
    -- Not sure which one this is
end

-- Idea for this and the loop from here:
-- https://github.com/jevajs/Jeva/blob/master/FiveM%20-%20Vehicle%20Modifications%20and%20Extras/vehicle/client.lua
-- This is untested but should work
-- Todo Test this later
function doesVehicleHaveUpgrades()
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)
    for modType = 0, 20, 1 do
        if IsToggleModOn(vehicle, modType) then
            return true
        end
    end

    return false
end

-- Spawn vehicle without blip at a set coords and with a custom color
function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
-- function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
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



    -- These color options don't seem to work.

    -- Car color test
    -- local carColorPrimary = colors.classic["Carbon Black"]
    -- local carColorSecondary = colors.classic["Lava Red"]
    -- SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

    local vehicleNew  = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
    SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

    -- Make it to where the tires cannot be popped.
    SetVehicleTyresCanBurst(vehicleNew, false)

    -- https://forum.cfx.re/t/setvehiclemod-is-not-working/1129056
    -- SetVehicleMod: https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
    -- This seems to be needed to set the vehicle mods.
    SetVehicleModKit(vehicleNew, 0)

    -- Test function, give vehicle all upgrades
    setVehicleMaxUpgrades(vehicleNew)

    -- Test moving this down here for colors.
    SetModelAsNoLongerNeeded(car)

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
-- Todo Move custom colors outside of the function and make them able to be changed.

-- Spawn a vehicle with a blip, custom colors defined in the code below.
function spawnVehicleWithBlip(vehicleName)

-- This spawns a vehicle with a blip and custom colors, the first set of colors are for the primary
-- color and the second set are for the secondary color.
-- function spawnVehicleWithBlip(vehicleName, r1, g1, b1, r2, g2, b2)
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
        -- local carColorPrimary = colors.classic["Surf Blue"]
        -- local carColorPrimary = colors.classic["Carbon Black"]
        -- local carColorSecondary = colors.classic["Lava Red"]

        -- Set the color with the values from the table.
        -- SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)
        -- TODO Setup this to get the color value from the user.
        -- if args[1] or args[2] ~= nil then
        --     SetVehicleColours(vehicle, colors.classic[args[1]], colors.classic[args[2]])
        -- end

        local rgbCarColors = false
        -- Set the colors with rgb values if enabled
        if rgbCarColors then
            SetVehicleCustomPrimaryColour(vehicle, r1, g1, b1)
            SetVehicleCustomSecondaryColour(vehicle, r2, g2, b2)
        else
            local carColorPrimary = colors.classic["Hot Pink"]
            local carColorSecondary = colors.classic["Lava Red"]
            SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)
        end

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


        local rgbCarColors = false
        -- Set the colors with rgb values if enabled
        if rgbCarColors then
            SetVehicleCustomPrimaryColour(vehicle, r1, g1, b1)
            SetVehicleCustomSecondaryColour(vehicle, r2, g2, b2)
        else
            local carColorPrimary = colors.classic["Carbon Black"]
            local carColorSecondary = colors.classic["Lava Red"]
            SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)
    end

        -- TODO Test this later
        -- table.insert(vehicleTbl, car)
        -- Make this remove from the table once it is exploded, I will need a function somewhere so it removes the blip

        SetEntityAsNoLongerNeeded(car)
        SetModelAsNoLongerNeeded(car)

        -- ? I would like to change the colors in car_c
        -- return vehicle
    end
end

-- function setVehicleColorsTest(vehicle, color1, color2)
--     local ped = GetPlayerPed(-1)

--     -- local colors = #colors.classic
    

    if (IsPedSittingInAnyVehicle) then
        local currentVeh = GetVehiclePedIsIn(ped, false)
        SetVehicleColours(vehicle, color1, color2)
    end
-- end

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

-----------------
--
-----------------