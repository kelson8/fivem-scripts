-- TODO Setup toggle for being in the driver seat or spawning beside the player.

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
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

    local vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    -- local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

    -- Set the player into the drivers seat
    SetPedIntoVehicle(ped, vehicle, -1)

    -- give the vehicle back to the game (This'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    -- Release the model
    SetModelAsNoLongerNeeded(vehicle)
end

function deleteCurrentVehicle(vehicleName)
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(vehicleName) then
        if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)

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

    --if IsPedInVehicle(ped) then
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        deleteCurrentVehicle(vehicle)
        
        -- SetEntityAsMissionEntity(vehicle, true, true)

        -- DeleteVehicle(vehicle)
    end

    spawnVehicle(car_random)
    notify("You have spawned a ~y~" .. car_random)

end)

RegisterCommand('car_menu', function (source, args)
    -- TODO figure out how to make a menu with a couple of cars in it.
end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'

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
