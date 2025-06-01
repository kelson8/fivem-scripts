---@diagnostic disable: duplicate-set-field
Vehicle = {}

------------ 
--- Vehicle functions
------------

-- New

function Vehicle.SetPrimaryColor(vehicle, r1, g1, b1)
    SetVehicleCustomPrimaryColour(vehicle, r1, g1, b1)
    
end

function Vehicle.SetSecondaryColor(vehicle, r1, g1, b1)
    SetVehicleCustomSecondaryColour(vehicle, r1, g1, b1)
end

-- Copied from vehicle_functions.lua in kc_menu.

-- Spawn vehicle at a set coords with a heading, and optionally, clear the area around it.
-- function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
function Vehicle.Create(vehicleName, x, y, z, heading, clearArea)

    -- First, clear the area if toggled on.
    if clearArea then
        -- World.ClearVehiclesInArea(playerX, playerY, playerZ, 25.0)
        -- World.ClearVehiclesInArea(x, y, z, 25.0)
        World.ClearArea(x, y, z, 25.0)
    end

    local vehicleHash = GetHashKey(vehicleName)

    -- Disable tire burst here
    local tiresBurstDisabled = true

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        return
    end

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

    -- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
    -- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

    -- Make it to where the tires cannot be popped.
    if tiresBurstDisabled then
        SetVehicleTyresCanBurst(vehicleNew, false)
    end

    -- https://forum.cfx.re/t/setvehiclemod-is-not-working/1129056
    -- SetVehicleMod: https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
    -- This seems to be needed to set the vehicle mods.
    -- SetVehicleModKit(vehicleNew, 0)

    -- Test function, give vehicle all upgrades
    -- setVehicleMaxUpgrades(vehicleNew)

    SetModelAsNoLongerNeeded(vehicleHash)
end

-- Spawn vehicle at a set coords with a heading, and optionally, clear the area around it.
-- This function sets it with a custom color also, not sure if it works though.
function Vehicle.CreateWithColor(vehicleName, x, y, z, heading, r1, g1, b1, clearArea)

    -- First, clear the area if toggled on.
    if clearArea then
        -- World.ClearVehiclesInArea(playerX, playerY, playerZ, 25.0)
        -- World.ClearVehiclesInArea(x, y, z, 25.0)
        World.ClearArea(x, y, z, 25.0)
    end

    local vehicleHash = GetHashKey(vehicleName)

    -- Disable tire burst here
    local tiresBurstDisabled = true

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        return
    end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end




    -- These color options don't seem to work.

    -- Car color test
    -- local carColorPrimary = colors.classic["Carbon Black"]
    -- local carColorSecondary = colors.classic["Lava Red"]
    -- SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

    local vehicleNew  = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    Vehicle.SetPrimaryColor(vehicleNew, r1, b1, g1)
    Vehicle.SetSecondaryColor(vehicleNew, r1, b1, g1)

    -- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
    -- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

    -- Make it to where the tires cannot be popped.
    if tiresBurstDisabled then
        SetVehicleTyresCanBurst(vehicleNew, false)
    end

    -- https://forum.cfx.re/t/setvehiclemod-is-not-working/1129056
    -- SetVehicleMod: https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
    -- This seems to be needed to set the vehicle mods.
    -- SetVehicleModKit(vehicleNew, 0)

    -- Test function, give vehicle all upgrades
    -- setVehicleMaxUpgrades(vehicleNew)

    SetModelAsNoLongerNeeded(vehicleHash)
end