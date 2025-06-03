-- Lobby test

-- https://forum.cfx.re/t/tutorial-how-to-use-routing-buckets-easily-the-correct-way-to-instance-people/2485164

-- Add someone to any available instance. (use this when you dont need to add others to the same instance)

-- TriggerServerEvent('instance:set')

-- -- Then to put them back into the normal instance

-- TriggerServerEvent('instance:set', 0)

-- -- Use the follwing when you would like to add multiple people to the same instance.

-- TriggerServerEvent('instance:setNamed', 'InstanceName')  -- InstanceName can be any string, e.g Apartment-26

-- -- Then to put them back into the normal instance

-- TriggerServerEvent('instance:setNamed', 0)

-- These work!

-- Set and reset the players routing bucket if they have permission.

RegisterCommand("setrtr", function ()
    -- TriggerServerEvent('instance:set')
    TriggerServerEvent('instance:set', 'Test')

end, false)

RegisterCommand("resetrtr", function ()
    -- TriggerServerEvent('instance:set')
    TriggerServerEvent('instance:set', 0)

end, false)



-- Print the current routing bucket to the player if they have permission.
RegisterCommand("getrtr", function()
    local player = GetPlayerPed(-1)

    TriggerServerEvent("instance:getCurrent")

    -- TODO Test this, see if this works.
    -- Well this part didn't work
    -- local vehicle = GetVehiclePedIsIn(player, false)
    --     if vehicle ~= nil then
    --         TriggerServerEvent("instance:getCurrent", vehicle)
    --     else
    --         TriggerServerEvent("instance:getCurrent")
    --     end
end, false)


-- Print the vehicle routing bucket
-- https://forum.cfx.re/t/help-i-cant-get-a-vehicle-model-name-from-the-server-side/4899885/2
-- TODO Fix this to work.
-- RegisterCommand("getrtr_veh", function (source, raw, args)
--     local ped = GetPlayerPed(-1)
-- 	local veh = GetVehiclePedIsIn(ped, false)
--     TriggerServerEvent("instance:getCurrentVehicle", veh)
-- end, false)

-- Set the player to routing bucket 0 (Hub)
RegisterCommand('hub', function()
    TriggerServerEvent("instance:setHub")
end, false)

-- Set the player to routing bucket 10 (Disabled peds and traffic.)
-- So far only works on the player, I will try to make this work on others later.
RegisterCommand('nopopulation', function()
    TriggerServerEvent("instance:setNoPopulation")
end, false)

-- TODO Make this return the current vehicle, can the server see these values?
RegisterNetEvent("instance:getCurrentVehicle")
AddEventHandler("instance:getCurrentVehicle", function ()
    local player = GetPlayerPed(-1)
    -- if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        if vehicle ~= nil then
            -- vehicleId = 
            -- vehicleId = NetworkGetNetworkIdFromEntity(vehicle)
        end
    -- end
end)