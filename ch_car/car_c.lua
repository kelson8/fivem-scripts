-- TODO Setup toggle for being in the driver seat or spawning beside the player.
-- Setup this to remove vehicle once new one is spawned, or set it to where only 2 can be spawned at a time.
-- To prevent lag/crashes.

-- This seems to work
-- Setup to where the blip only shows up when the player isn't in the vehicle.
-- Add car spawns on the map where the player spawns.

-- https://docs.fivem.net/docs/game-references/blips/
--local vehBlip = AddBlipForEntity(vehicle)
--AddBlipForEntity(vehicle)

-- Remove when car is deleted.
--RemoveBlip(vehBlip)

-- Set the sprite for the blip
--SetBlipSprite(vehBlip, 225)


function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

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

        SetEntityAsNoLongerNeeded(car)
        SetModelAsNoLongerNeeded(car)

        SetVehicleTyresCanBurst(vehicleName, true)

        -- These color options don't seem to work.
        -- SetVehicleCustomPrimaryColour(vehicleName, 255, 0, 0)
        -- SetVehicleCustomSecondaryColour(vehicleName, 255, 0 , 0)
        CreateVehicle(vehicleName, x, y, z, heading, true, false)
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
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local heading = GetEntityHeading(ped)

    -- Set this to true to spawn player into vehicle.
    local spawnInVehicle = true


    -- TODO Setup spawn in vehicle check.
    -- TODO Fix this to where it doesn't despawn when you walk a bit from it.
    -- Setup persistant vehicle check, if enabled the current vehicle won't despawn.
    if (spawnInVehicle) then
        -- Remove vehicle if player is in one.
        if(IsPedSittingInAnyVehicle) then
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
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local heading = GetEntityHeading(ped)

    -- Set this to true to spawn player into vehicle.
    local spawnInVehicle = true


    -- TODO Setup spawn in vehicle check.
    -- TODO Fix this to where it doesn't despawn when you walk a bit from it.
    -- Setup persistant vehicle check, if enabled the current vehicle won't despawn.
    if (spawnInVehicle) then
        -- Remove vehicle if player is in one.
        if(IsPedSittingInAnyVehicle) then
            deleteCurrentVehicle(GetVehiclePedIsIn(ped, false))
        end

        -- Set the player into the drivers seat
        local vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        SetPedIntoVehicle(ped, vehicle, -1)

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

-- Random cars
-- Fix this to where the cars delete the old ones as they spawn in.
RegisterCommand('rndcar', function()
    local cars = {"adder", "t20", "faggio", "cheetah"}
    local car_random = (cars[math.random(#cars)])
    local ped = GetPlayerPed(-1)

    -- Todo Add check to see if a vehicle is already spawned in, if so remove it before spawning more.

    -- Remove current vehicle before spawning a new one in.
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        deleteCurrentVehicle(vehicle)

    end

    -- Spawns the vehicle and notify the player
    spawnVehicleWithBlip(car_random)
    notify("You have spawned a ~y~" .. car_random)
end)

-- Todo Set this to where it adds the car to a database and only lets the player spawn one at a time, set it to get values from a database
RegisterCommand("spawnpv", function()
    vehName = "t20"
    spawnPersonalVehicleWithBlip(vehName)
    notify("Enjoy your new ~y~" .. vehName .. "~w~!")

end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'
    local ped = GetPlayerPed(-1)

    -- Remove current vehicle before spawning a new one in.
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        deleteCurrentVehicle(vehicle)
    end

    -- Spawn the car
    spawnVehicleWithBlip(vehicleName)

    -- Set the player into the drivers seat
    --SetPedIntoVehicle(ped, vehicleName, -1)

    -- tell the player
    notify("You have spawned a ~y~" .. vehicleName)
end, false)

RegisterCommand('dv', function()

    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
        local vehicleName = GetVehiclePedIsIn(ped, false)
        deleteCurrentVehicle(vehicleName)

        notify("~w~You have ~r~deleted~w~ your car!")
    else
        notify("~r~Error~w~: You need a car to use this command!")
    end

end, false)

-- Adding suggestions to the command
-- Note, the command has to start with `/`.
TriggerEvent('chat:addSuggestion', '/car', 'help text', {
    { name="carName", help="name of the car to spawn" }
})

TriggerEvent('chat:addSuggestion', '/dv', 'Delete vehicle')

TriggerEvent('chat:addSuggestion', '/rndcar', 'Gives a random vehicle.')

TriggerEvent('chat:addSuggestion', '/spawnpv', 'Spawns a personal vehicle that shouldn\'t despawn.')

-- Add cars to the map
-- This is currently working, not sure how to do custom colors though
-- Spawn vehicle with specific colors.
-- https://forum.cfx.re/t/how-to-spawn-a-vehicle-with-specific-colors/7401
Citizen.CreateThread(function()
    -- LOL It kept spawning cars, Oops I made an infinte loop, don't ever put something into a "while true do" 
    -- loop if I don't want it constantly running.
        Wait(1)
        for i = 1, #vehicle_spawns, 1 do
            spawns = vehicle_spawns[i]
            local x,y,z = table.unpack(spawns.pos)
            spawnVehicleWithoutBlip(spawns.vehiclename, x, y, z, spawns.heading)
            -- spawnVehicleWithoutBlip(spawns.vehiclename, x, y, z, spawns.heading, spawns.colors.r, spawns.colors.g, spawns.colors.b)
    end
end)