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

        -- SetEntityAsNoLongerNeeded(car)
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
-- RegisterCommand("spawnpv", function()
--     vehName = "t20"
--     spawnPersonalVehicleWithBlip(vehName)
--     notify("Enjoy your new ~y~" .. vehName .. "~w~!")

-- end)

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

-- https://forum.cfx.re/t/checking-if-someone-is-an-area/127087/4
-- https://forum.cfx.re/t/help-disable-control/43052
-- Prompt player to exit garage and disable car movement if in the Ceo Office garage
-- I figured out how to disable car movement, I had to do the action for vehicle accelerate and vehicle braking on the fivem controls page. 
-- Well this disables it for outside of the garage also, I would need to fix that
-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)
--         local ped = GetPlayerPed(-1)
--             if GetDistanceBetweenCoords(-1370.4, -474.18, 49.1, GetEntityCoords(ped)) < 15 and IsPedInAnyVehicle(ped) then
--                 DisableControlAction(2, 71, true) -- W (Vehicle accelerate)
--                 DisableControlAction(2, 72, true) -- S (Vehicle brake)
--             else
--                 DisableControlAction(1, 71, false) -- W (Vehicle accelerate)
--                 DisableControlAction(1, 72, false) -- S (Vehicle brake)
--         end
--     end
-- end)

-- Custom events
RegisterNetEvent("ch_car:spawn")
AddEventHandler("ch_car:spawn", function(vehicleName, x, y, z, heading)
    -- spawnVehicleWithBlip(vehicleName)
    spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
end)

-- Notify client event
RegisterNetEvent("ch_car:notifyClient")
AddEventHandler("ch_car:notifyClient",
    function (msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(true, false)
end)

-- Get players vehicle
RegisterNetEvent("ch_car:getVehicle")
-- AddEventHandler("ch_car:getVehicle", function()
AddEventHandler("ch_car:getVehicle", function()
    local ped = GetPlayerPed(-1)
    if IsPedSittingInAnyVehicle(ped) then
        local vehicle = GetVehiclePedIsIn(ped, false)

        -- Cancel if the vehicle doesn't exist.
        if not DoesEntityExist(vehicle) then return end

        local model = GetEntityModel(vehicle)
        local carDisplayName = GetDisplayNameFromVehicleModel(model)
        local carLabel = GetLabelText(carDisplayName)

        -- I kept trying to get the colors from the ped lol.
        -- https://forum.cfx.re/t/help-configure-showroom-vehicle-colors/4915586/5
        -- Both of these seem to work, first one grabs the primary and secondary color, second one gives the color in rgb format.
        local color1, color2 = GetVehicleColours(vehicle)
        local r,g,b = GetVehicleColor(vehicle)

        notify("You are in a " .. carLabel .. " with colors: " .. color1 .. " " .. color2)
        -- notify("You are in a " .. carLabel .. " with colors: " .. r .. " " .. g .. " " .. b)

        -- I have no idea if i did this right
        return carLabel, color1, color2
    end
end)

-- I got this working without a specific ID in the database, I would like to add multiple ID's so the players can do /car 1-<amount> or
-- Do it in the menu that I have.
-- Todo Set this to where it'll notify the user on a success or failure.
-- Todo Set this to where it'll update the id of a car that already exists instead of making a bunch of new ones.
RegisterNetEvent("ch_car:savepv")
AddEventHandler("ch_car:savepv", function(vehicle)
    local model = GetEntityModel(vehicle)
    local x,y,z = table.unpack(GetEntityCoords(vehicle))
    local heading = GetEntityHeading(vehicle)

    local carDisplayName = GetDisplayNameFromVehicleModel(model)
    local carLabel = GetLabelText(carDisplayName)

    local color1, color2 = GetVehicleColours(vehicle)

    TriggerServerEvent("ch_car:savepv", model, x, y, z, heading, color1, color2)
end)

RegisterCommand("savepv", function()
    ped = GetPlayerPed(-1)
    local vehicle = 0
    if IsPedSittingInAnyVehicle(ped) then
        vehicle = GetVehiclePedIsUsing(ped)
        TriggerEvent("ch_car:savepv", vehicle)
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    end
end)

-- Todo Setup these two commands to work

-- Spawn personal vehicle
RegisterCommand("pv", function()

end)

-- Delete personal vehicle.
RegisterCommand("deletepv", function()

end)

