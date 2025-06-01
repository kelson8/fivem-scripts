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

RegisterCommand("setrtr", function ()
    -- TriggerServerEvent('instance:set')
    TriggerServerEvent('instance:set', 'Test')

end, false)

RegisterCommand("resetrtr", function ()
    -- TriggerServerEvent('instance:set')
    TriggerServerEvent('instance:set', 0)

end, false)

