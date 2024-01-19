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
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicle)
    -- Adding the else fixed the vehicle spawning in multiple times.
    else
        local vehicle = CreateVehicle(vehicleName, x + 3, y + 3, z + 1, heading, true, false)

        -- Add the blip for personal vehicle.
        createVehBlip(225, vehicle)

        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicle)
    end
    
    -- local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

    -- I commented these out since they are under the spawnInVehicle check.
    -- give the vehicle back to the game (This'll make the game decide when to despawn the vehicle)
    --SetEntityAsNoLongerNeeded(vehicle)

    -- Release the model
    --SetModelAsNoLongerNeeded(vehicle)
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

    -- Remove current vehicle before spawning a new one in.
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        deleteCurrentVehicle(vehicle)

    end

    -- Spawns the vehicle and notify the player
    spawnVehicle(car_random)
    notify("You have spawned a ~y~" .. car_random)

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
    spawnVehicle(vehicleName)

    -- Set the player into the drivers seat
    --SetPedIntoVehicle(ped, vehicleName, -1)

    -- tell the player
    notify("You have spawned a ~y~" .. vehicleName)
    -- TriggerEvent('chat:addMessage', {
	-- 	args = { 'You have spawned a ^* ^3' .. vehicleName }
	-- })
end, false)

-- RegisterCommand('dv', function()
--     -- get the local player ped
--     local playerPed = PlayerPedId()
--     -- get the vehicle the player is in.
--     local vehicle = GetVehiclePedIsIn(playerPed, false)
--     -- delete the vehicle.
--     DeleteEntity(vehicle)
-- end, false)

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
