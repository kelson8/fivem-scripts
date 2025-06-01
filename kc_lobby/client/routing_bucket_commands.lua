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
    TriggerServerEvent("instance:getCurrent")
end, false)

-- Set the player to routing bucket 0 (Hub)
RegisterCommand('hub', function()
    TriggerServerEvent("instance:setHub")
end, false)

-- Set the player to routing bucket 10 (Disabled peds and traffic.)
-- So far only works on the player, I will try to make this work on others later.
RegisterCommand('nopopulation', function()
    TriggerServerEvent("instance:setNoPopulation")
end, false)
