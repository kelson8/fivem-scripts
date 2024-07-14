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

RegisterCommand("deleteveh", function()
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(vehicleName) then
        if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            --local vehBlip = GetBlipFromEntity(vehicle)

            SetEntityAsMissionEntity(vehicle)
            DeleteVehicle(vehicle)
        end
    end    
end, false)

-- Random cars
-- Fix this to where the cars delete the old ones as they spawn in.
RegisterCommand('rndcar', function()
    local cars = { "adder", "t20", "faggio", "cheetah" }
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
end, false)

-- Todo Set this to where it adds the car to a database and only lets the player spawn one at a time, set it to get values from a database
-- RegisterCommand("spawnpv", function()
--     vehName = "t20"
--     spawnPersonalVehicleWithBlip(vehName)
--     notify("Enjoy your new ~y~" .. vehName .. "~w~!")

-- end)

RegisterCommand('car', function(source, args)
    -- account for the argument not being passed

    local category = args[1]
    local player = GetPlayerPed(-1)


    if category == "spawn" then
        local vehicleName = args[2] or 'adder'

        -- Remove current vehicle before spawning a new one in.
        if IsPedSittingInAnyVehicle(player) then
            local vehicle = GetVehiclePedIsIn(player, false)
            deleteCurrentVehicle(vehicle)
        end

        -- Spawn the car
        spawnVehicleWithBlip(vehicleName)

        -- Set the player into the drivers seat
        --SetPedIntoVehicle(ped, vehicleName, -1)

        -- tell the player
        notify("You have spawned a ~y~" .. vehicleName)

        -- Check if player is in a vehicle before running these.
        -- if IsPedInAnyVehicle(player) then

        elseif category == "customize" then
            local vehicle = GetVehiclePedIsIn(player)
            SetVehicleModKit(vehicle, 0)
            for modType = 0, 10, 1 do
                local bestMod = GetNumVehicleMods(vehicle, modType) - 1
                SetVehicleMod(vehicle, modType, bestMod, false)
            end

        elseif category == "extras" then -- /vehicle extras
            local vehicle = GetVehiclePedIsIn(player)
            for id = 0, 20 do
                if DoesExtraExist(vehicle, id) then
                    -- Turn it on with 1, turn off with 0
                    SetVehicleExtra(vehicle, id, 1)
                end
                sendMessage("You have added all extras to the vehicle.")
            end

        elseif category == "repair" then
            local vehicle = GetVehiclePedIsIn(player)
            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            sendMessage("Repaired your vehicle.")
        
        
        -- Open the doors
        elseif category == "doors" then
            local vehicle = GetVehiclePedIsIn(player)
            local closed = GetVehicleDoorAngleRatio(vehicle, 0) < 0.1
            if closed then
                for i=0, 7 do
                    SetVehicleDoorOpen(vehicle, i, false, false)
                end
            else
                SetVehicleDoorsShut(vehicle, false)
            end
        end

   
    -- end
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
    -- { name = "spawn", help = "name of the car to spawn" }
    -- { name = "customize", help = "Customize current vehicle" },
    { name = "spawn", help = "Spawn a car" },
    { name = "name",  help = "Car name to spawn" }
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
        local x, y, z = table.unpack(spawns.pos)
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
    function(msg)
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
        local r, g, b = GetVehicleColor(vehicle)

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
    local x, y, z = table.unpack(GetEntityCoords(vehicle))
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
end, false)

-- Todo Setup these two commands to work

-- Spawn personal vehicle
RegisterCommand("pv", function()

end, false)

-- Delete personal vehicle.
RegisterCommand("deletepv", function()

end, false)
