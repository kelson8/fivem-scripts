
-- Moved out of kc_car, this should be its own resource.

-- Add cars to the map
-- This is currently working, not sure how to do custom colors though
-- Spawn vehicle with specific colors.
-- https://forum.cfx.re/t/how-to-spawn-a-vehicle-with-specific-colors/7401

-- TODO Make this to where it clears the area of cars if the resource is restarted.

Citizen.CreateThread(function()
    -- LOL It kept spawning cars, Oops I made an infinte loop, don't ever put something into a "while true do"
    -- loop if I don't want it constantly running.
    Wait(1)
    for i = 1, #vehicle_spawns, 1 do
        spawns = vehicle_spawns[i]
        local x, y, z = table.unpack(spawns.pos)
        -- This doesnt seem to work
        -- ClearAreaOfVehicles(x, y, z, 10, false, false, false, false, false, false, false)
        -- Vehicle.Create(spawns.vehiclename, x, y, z, spawns.heading, spawns.colors.r, spawns.colors.g, spawns.colors.b)
        Vehicle.CreateWithColor(spawns.vehiclename, x, y, z, spawns.heading, spawns.colors.r, spawns.colors.g, spawns.colors.b, false)
    end
end)