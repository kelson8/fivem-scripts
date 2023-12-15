RegisterCommand('car_menu', function (source, args)
    -- TODO figure out how to make a menu with a couple of cars in it.
end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed
    local vehicleName = args[1] or 'adder'

    -- check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = { 'Vehicle not recognized ' .. vehicleName }
        })
        return
    end

    -- load the model
    RequestModel(vehicleName)

    -- wait for the model to load
    while not HasModelLoaded(vehicleName) do
        Wait(500) -- often you'll also see Citizen.Wait
    end

    -- get the player's position
    local playerPed = PlayerPedId() -- get the local player ped
    local pos = GetEntityCoords(playerPed) -- get the position of the local player ped

    -- create the vehicle
    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)

    -- set the player ped into the vehicle's driver seat
    SetPedIntoVehicle(playerPed, vehicle, -1)

    -- give the vehicle back to the game (this'll make the game decide when to despawn the vehicle)
    SetEntityAsNoLongerNeeded(vehicle)

    -- release the model
    SetModelAsNoLongerNeeded(vehicleName)

    -- tell the player
    TriggerEvent('chat:addMessage', {
		args = { 'You have spawned a ^* ^3' .. vehicleName }
	})
end, false)

RegisterCommand('dv', function()
    -- get the local player ped
    local playerPed = PlayerPedId()
    -- get the vehicle the player is in.
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    -- delete the vehicle.
    DeleteEntity(vehicle)
end, false)

-- Adding suggestions to the command
-- Note, the command has to start with `/`.
TriggerEvent('chat:addSuggestion', '/car', 'help text', {
    { name="carName", help="name of the car to spawn" }
})

TriggerEvent('chat:addSuggestion', '/dv', 'Delete vehicle')

