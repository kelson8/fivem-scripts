-- TODO Setup routing bucket for Cayo Perico warp

-- Copied out of kc_lobby

-- To setup permissions for this, go into vMenu/config/permissions.cfg
-- Scroll to where it says permissions setup, and add these:

-- add_ace group.admin "kc_menu.lobby_all" allow

---- New for menu
--- add_ace group.admin kc_menu.lobby.get_lobby allow
-- add_ace group.admin kc_menu.lobby.set_no_population allow

-- add_ace group.admin kc_menu.lobby.hub allow

-- add_ace group.admin kc_menu.lobby.set allow
-- add_ace group.admin kc_menu.lobby.setnamed allow

-- add_ace group.admin kc_menu.set_rtr allow
-- This one isn't implemented yet
-- add_ace group.admin kc_menu.lobby.set_entity_lobby allow

-- For the string format
-- d - a decimal number
-- x - for hexadecimal
-- o - for octal
-- f - for a floating-point number
-- s - strings
-- https://www.tutorialspoint.com/string-format-function-in-lua-programming

-- Well, making these local does restrict them to this file, that is neat.
local Text = {}
local Server = {}

-- These are the current routing bucket IDs, I need to test the no population one.
local lobbyBucket = 0
local noPopulationBucket = 10

-- function Text.SendServerMessage(source, msg)
-- function Server.SendMessage(source, msg)
function Server.SendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = { msg, },
    })
end

function Server.SendErrorMessage()
    TriggerClientEvent('chat:addMessage', source, {
        args = { "[Error]: You do not have permission for this!", source },
    })
end

-- https://forum.cfx.re/t/tutorial-how-to-use-routing-buckets-easily-the-correct-way-to-instance-people/2485164
local instances = {}

-- I got ace permissions working for this!
-- Now, to make this command run on another player instead of myself.
-- Oh, I think I forgot to add "allow" to the permission for admins.
RegisterServerEvent("kc_menu:setLobby")
AddEventHandler("kc_menu:setLobby", function(set)
    local src = source

    if IsPlayerAceAllowed(src, "kc_menu.lobby.set") then
        print('[INSTANCES] Instances now looked like this: ', json.encode(instances))

        TriggerClientEvent('DoTheBigRefreshYmaps', src)
        local instanceSource = 0
        if set then
            if set == 0 then
                for k, v in pairs(instances) do
                    for k2, v2 in pairs(v) do
                        if v2 == src then
                            table.remove(v, k2)
                            if #v == 0 then
                                instances[k] = nil
                            end
                        end
                    end
                end
            end
            instanceSource = set
        else
            instanceSource = math.random(1, 63)

            while instances[instanceSource] and #instances[instanceSource] >= 1 do
                instanceSource = math.random(1, 63)
                Citizen.Wait(1)
            end
        end

        print(instanceSource)

        if instanceSource ~= 0 then
            if not instances[instanceSource] then
                instances[instanceSource] = {}
            end

            table.insert(instances[instanceSource], src)
        end

        SetPlayerRoutingBucket(
            src --[[ string ]],
            instanceSource
        )
        print('[INSTANCES] Instances now looks like this: ', json.encode(instances))
    else
        Server.SendMessage(src, "[Error]: You do not have permission for this!")
    end
end)

Namedinstances = {}


RegisterServerEvent("kc_menu:setNamedLobby")
AddEventHandler("kc_menu:setNamedLobby", function(setName)
    local src = source
    -- if IsPlayerAceAllowed(src, "kc_test.set.rtr") then
    if IsPlayerAceAllowed(src, "kc_menu.lobby.setnamed") then
        print('[INSTANCES] Named Instances looked like this: ', json.encode(Namedinstances))
        local instanceSource = nil

        TriggerClientEvent('DoTheBigRefreshYmaps', src)

        if setName == 0 then
            for k, v in pairs(Namedinstances) do
                for k2, v2 in pairs(v.people) do
                    if v2 == src then
                        table.remove(v.people, k2)
                    end
                end
                if #v.people == 0 then
                    Namedinstances[k] = nil
                end
            end
            instanceSource = setName
        else
            for k, v in pairs(Namedinstances) do
                if v.name == setName then
                    instanceSource = k
                end
            end

            if instanceSource == nil then
                instanceSource = math.random(1, 63)

                while Namedinstances[instanceSource] and #Namedinstances[instanceSource] >= 1 do
                    instanceSource = math.random(1, 63)
                    Citizen.Wait(1)
                end
            end
        end

        if instanceSource ~= 0 then
            if not Namedinstances[instanceSource] then
                Namedinstances[instanceSource] = {
                    name = setName,
                    people = {}
                }
            end

            table.insert(Namedinstances[instanceSource].people, src)
        end

        SetPlayerRoutingBucket(
            src --[[ string ]],
            instanceSource
        )

        -- TODO Test this
        -- SetRoutingBucketPopulationEnabled(instanceSource, false)

        print('[INSTANCES] Named Instances now look like this: ', json.encode(Namedinstances))
    else
        Server.SendMessage(src, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)


-- Taken from lobby_test.lua
-- RegisterNetEvent("kc_menu:setEntityRtr")
-- AddEventHandler("kc_menu:setEntityRtr", function(entityId, routingBucket)
--     -- local NetId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
--     if IsPlayerAceAllowed(source, "kc_menu.lobby.set_entity_lobby") then
--         local netId = NetworkGetEntityFromNetworkId(entityId)
--         -- local routingBucket = tonumber(args[2])

--         -- if args[1] and args[2] ~= nil then
--         SetEntityRoutingBucket(netId, routingBucket)
--         sendMessage(source, ("You have set the routing bucket of %s to %s"):format(netId, routingBucket))
--         -- end
--     else
--         Server.SendErrorMessage()
--     end
-- end)

-- Taken from lobby_test.lua

-- TODO Figure out how to run this on others
-- RegisterCommand('lobby', function(source, args)
--     if IsPlayerAceAllowed(source, "kc_test.lobby_all") then
--         local targetId = args[1] or source
--         local routingBucket = tonumber(args[2])

--         -- Get the name of the target player.
--         local targetName = GetPlayerName(targetId)



--         SetPlayerRoutingBucket(targetId, routingBucket)
--         -- SetPlayerRoutingBucket(source, routingBucket)
--         if args[2] ~= nil then
--             sendMessage(source, ("You have set %s to routing bucket %s."):format(
--                 targetName, routingBucket
--             ))
--         else
--             sendMessage(source, ("You have set your routing bucket to %s."):format(
--                 routingBucket
--             ))
--             -- sendMessage(source, "You have set %s to routing bucket %s." .. routingBucket)
--         end

--         -- if args[2] == 0 then

--         -- end
--     end
-- end, false)

-- Make a hub command to bring the player back to the default routing bucket
-- RegisterCommand('hub', function(source, args)
-- RegisterCommand('hub', function(source, args)
--     if IsPlayerAceAllowed(source, "kc_test.hub") then
--         SetPlayerRoutingBucket(source, 0)
--         sendMessage(source, "You have been returned to the main lobby.")
--     else
--         Server.SendMessage(source, "[Error]: You do not have permission for this!")
--         -- Server.SendErrorMessage()
--     end
-- end, true)

RegisterServerEvent("kc_menu:setHub")
AddEventHandler("kc_menu:setHub", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.hub") then
        SetPlayerRoutingBucket(source, lobbyBucket)
        Server.SendMessage(source, "You have been returned to the main lobby.")
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)

-- TODO Add other player support to this.
RegisterServerEvent("kc_menu:setNoPopulation")
AddEventHandler("kc_menu:setNoPopulation", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.set_no_population") then
        SetRoutingBucketPopulationEnabled(noPopulationBucket, false)

        SetPlayerRoutingBucket(source, noPopulationBucket)
        Server.SendMessage(source, "You have been sent to the no population lobby.")
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)

-- I got this part to work, I had to get the network ID like I was doing in lobby_test.
-- Get current player routing bucket.
-- TODO Make this get the vehicles network id if a player is in one.
RegisterServerEvent("kc_menu:getCurrentLobby")
AddEventHandler("kc_menu:getCurrentLobby", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.get_lobby") then
        -- This requires the network of of the player.
        local netId = NetworkGetEntityFromNetworkId(source)

        -- TODO Set this up, if the player is in a vehicle this should return the network ID of it.
        -- TriggerClientEvent("instance:getCurrentVehicle", source)
        local currentRoutingBucket = GetEntityRoutingBucket(netId)

        Server.SendMessage(source, string.format("Current routing bucket: %d", currentRoutingBucket))
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)

-- TODO Set this up, if the player is in a vehicle this should return the network ID of it.
-- Well this didn't work, or at least the way I am doing it didn't work.
-- Well now this just says the vehicle is in routing bucket 0
-- https://docs.fivem.net/docs/scripting-manual/networking/ids/
RegisterServerEvent("kc_menu:getCurrentVehicleLobby")
AddEventHandler("kc_menu:getCurrentVehicleLobby", function(currentVehicle)
    -- AddEventHandler("kc_menu:getCurrentVehicleLobby", function()
    if IsPlayerAceAllowed(source, "kc_menu.lobby.get_lobby") then
        local playerName = GetPlayerName(source)
        -- This requires the network of of the player.
        -- local netId = NetworkGetEntityFromNetworkId(source)

        -- local vehNetId = NetworkGetEntityFromNetworkId(currentVehicle)

        -- print(("%s's Current Vehicle: %s"):format(playerName, currentVehicle))

        -- Now this prints off an invalid entity
        -- if DoesEntityExist(currentVehicle) then

        -- I slightly changed this
        local vehNetId = NetworkGetEntityFromNetworkId(currentVehicle)
        -- local vehNetId = NetworkGetNetworkIdFromEntity(currentVehicle)

        -- local currentRoutingBucket = GetEntityRoutingBucket(netId)
        local currentVehRoutingBucket = GetEntityRoutingBucket(vehNetId)

        Server.SendMessage(source, string.format("Current vehicle routing bucket: %d", currentVehRoutingBucket))
        -- else
        -- Server.SendMessage(source, "Vehicle doesn't exist")
        -- end
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
    end
end)


-- TODO Make a new permission for this, don't want to restart for now.
-- Why doesn't this work right?
-- Get the current vehicle network id, TODO Setup.
-- RegisterServerEvent("kc_menu:getCurrentVehicle")
-- AddEventHandler("kc_menu:getCurrentVehicle", function(vehicle)
--     if IsPlayerAceAllowed(source, "kc_menu.set_entity_lobby") then
--         -- This requires the network of of the vehicle.
--         local vehicleId = NetworkGetEntityFromNetworkId(vehicle)

--         -- TODO Set this up, if the player is in a vehicle this should return the network ID of it.
--         -- TriggerClientEvent("kc_menu:getCurrentVehicle", source)

--         local currentVehicleRoutingBucket = GetEntityRoutingBucket(vehicleId)
--         -- Server.SendMessage(source, string.format("Current vehicle routing bucket: %d, netID: %d", currentVehicleRoutingBucket, vehicleId))
--         print(string.format("Vehicle '%d' Routing bucket: '%d', netID '%d'", vehicle, currentVehicleRoutingBucket, vehicleId))
--     else
--         Server.SendMessage(source, "[Error]: You do not have permission for this!")
--         -- Server.SendErrorMessage()
--     end
-- end)
