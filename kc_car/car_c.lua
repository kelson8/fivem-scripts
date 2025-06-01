-- TODO Setup toggle for being in the driver seat or spawning beside the player.

-- TODO Copy into kc_menu

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


----------
--- Functions
----------

-- Test
-- https://stackoverflow.com/questions/43107953/checking-for-items-in-tables-lua

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Check if the vehicle color is in the table
function hasKey(table, color)
    return table[color] ~= nil
end

--

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = {msg, },
    })
end


-- https://forum.cfx.re/t/checking-if-someone-is-an-area/127087/4
-- https://forum.cfx.re/t/help-disable-control/43052
-- Prompt player to exit garage and disable car movement if in the Ceo Office garage
-- I figured out how to disable car movement, I had to do the action for vehicle accelerate and vehicle braking on the fivem controls page.
-- Well this disables it for outside of the garage also, I would need to fix that
-- Citizen.CreateThread(function()
--     local ped = GetPlayerPed(-1)
--     local playerCoords = GetEntityCoords(ped)
--     local x,y,z = table.unpack(playerCoords)
--     while true do
--         Wait(0)
--             if GetDistanceBetweenCoords(-1370.4, -474.18, 49.1, GetEntityCoords(ped), true) < 5 and IsPedInAnyVehicle(ped) then
--             -- if GetDistanceBetweenCoords(-1370.4, -474.18, 49.1, x, y, z, true) < 5 and IsPedInAnyVehicle(ped) then
--                 DisableControlAction(2, 71, true) -- W (Vehicle accelerate)
--                 DisableControlAction(2, 72, true) -- S (Vehicle brake)
--             else
--                 DisableControlAction(1, 71, false) -- W (Vehicle accelerate)
--                 DisableControlAction(1, 72, false) -- S (Vehicle brake)
--         end
--     end
-- end)

-----------

----------
--- Commands
----------

-- Delete current vehicle
RegisterCommand("deleteveh", function()
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(vehicleName) then
        if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            --local vehBlip = GetBlipFromEntity(vehicle)

            SetEntityAsMissionEntity(vehicle, false, false)
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

    -- if args[1] or args[2] ~= nil then
        -- SetVehicleColours(vehicle, colors.classic[args[1]], colors.classic[args[2]])
    -- end

    -- Light blue and Yellow
    -- spawnVehicleWithBlip(car_random, 0, 128, 255, 255, 255, 0)
    notify("You have spawned a ~y~" .. car_random)
end, false)

-- Todo Set this to where it adds the car to a database and only lets the player spawn one at a time, set it to get values from a database
-- RegisterCommand("spawnpv", function()
--     vehName = "t20"
--     spawnPersonalVehicleWithBlip(vehName)
--     notify("Enjoy your new ~y~" .. vehName .. "~w~!")

-- end)

-- Spawn a car
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
            local vehicle = GetVehiclePedIsIn(player, false)
            SetVehicleModKit(vehicle, 0)
            for modType = 0, 10, 1 do
                local bestMod = GetNumVehicleMods(vehicle, modType) - 1
                SetVehicleMod(vehicle, modType, bestMod, false)
            end

        elseif category == "extras" then -- /vehicle extras
            local vehicle = GetVehiclePedIsIn(player, false)
            for id = 0, 20 do
                if DoesExtraExist(vehicle, id) then
                    -- Turn it on with 1, turn off with 0
                    SetVehicleExtra(vehicle, id, true)
                end
                sendMessage("You have added all extras to the vehicle.")
            end

        elseif category == "repair" then
            local vehicle = GetVehiclePedIsIn(player, false)
            SetVehicleFixed(vehicle)
            SetVehicleEngineHealth(vehicle, 1000.0)
            sendMessage("Repaired your vehicle.")
        -- Open the doors
        elseif category == "doors" then
            local vehicle = GetVehiclePedIsIn(player, false)
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

-- Delete current vehicle, 
-- Not sure of the difference between this and the 'deletevehicle' commands are.
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

RegisterCommand("vehiclehash", function()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)

        local vehModel = GetEntityModel(vehicle)
        local vehName = GetDisplayNameFromVehicleModel(vehModel)
        local vehHash = GetHashKey(vehModel)

        sendMessage(("Vehicle Model: %s, vehicle name: %s, vehicle hash: %s")
        :format(vehModel, vehName, vehHash))
    end
end, false)


----------
--- Custom events
----------

-- Command suggestions

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
--

-- Car spawning
RegisterNetEvent("ch_car:spawn")
AddEventHandler("ch_car:spawn", function(vehicleModel, x, y, z, heading)
    -- spawnVehicleWithBlip(vehicleName)
    spawnVehicleWithoutBlip(vehicleModel, x, y, z, heading)
end)
--

-- TODO Fix this to work, I think I've gotten close with this.
-- Personal vehicle spawning
-- RegisterNetEvent("ch_car:spawnpv")
-- AddEventHandler("ch_car:spawnpv", function(vehicleModel, x, y, z, heading)
--     -- spawnVehicleWithBlip(vehicleName)
--     -- hashToName = GetDisplayNameFromVehicleModel(vehicleModel)
--     -- vehicleHash = GetHashKey(vehicleModel)
--     vehicleHash = vehicleModel
--     vehicleName = hashToName

--     -- Test
--     -- Check if the vehicle actually exists
--     -- This keeps printing this error.
--     if not IsModelInCdimage(vehicleHash) or not IsModelAVehicle(vehicleHash) then
--         notify("~r~Error~w~: The model " .. vehicleHash .. " doesn't exist!")
--     end

--     -- Load the model
--     RequestModel(vehicleHash)

--     -- If model hasn't loaded, wait on it.
--     while not HasModelLoaded(vehicleHash) do
--         Wait(500)
--     end

--     CreateVehicle(vehicleHash, x, y, z, heading, true, false)
--     -- local vehicle = spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
--     -- SetEntityCoords(vehicle, x, y, z, false, false, false, false)
-- end)
--

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
-- RegisterNetEvent("ch_car:savepv")
-- AddEventHandler("ch_car:savepv", function(vehicle)
--     local model = GetEntityModel(vehicle)
--     local x, y, z = table.unpack(GetEntityCoords(vehicle))
--     local heading = GetEntityHeading(vehicle)

--     local carDisplayName = GetDisplayNameFromVehicleModel(model)
--     local carLabel = GetLabelText(carDisplayName)

--     local color1, color2 = GetVehicleColours(vehicle)

--     TriggerServerEvent("ch_car:savepv", model, x, y, z, heading, color1, color2)
-- end)

-- RegisterCommand("savepv", function()
--     ped = GetPlayerPed(-1)
--     local vehicle = 0
--     if IsPedSittingInAnyVehicle(ped) then
--         vehicle = GetVehiclePedIsUsing(ped)
--         TriggerEvent("ch_car:savepv", vehicle)
--         SetVehicleHasBeenOwnedByPlayer(vehicle, true)
--     end
-- end, false)

-- -- Todo Setup these two commands to work

-- -- Spawn personal vehicle
-- RegisterCommand("pv", function()

-- end, false)

-- -- Delete personal vehicle.
-- RegisterCommand("deletepv", function()

-- end, false)
