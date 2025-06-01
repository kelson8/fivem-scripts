-- TODO Setup routing bucket for Cayo Perico warp

-- To setup permissions for this, go into vMenu/config/permissions.cfg
-- Scroll to where it says permissions setup, and add these:
-- add_ace group.admin "kc_test.set.rtr" allow
-- add_ace group.admin "kc_test.get.rtr" allow


-- add_ace group.admin "kc_test.set.entity_rtr" allow
-- add_ace group.admin "kc_test.rtr.set.no.population" allow
-- add_ace group.admin "kc_test.hub" allow
-- add_ace group.admin "kc_test.lobby_all" allow

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
RegisterServerEvent("instance:set")
AddEventHandler("instance:set", function(set)
    local src = source

    if IsPlayerAceAllowed(src, "kc_test.set.rtr") then
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


RegisterServerEvent("instance:setNamed")
AddEventHandler("instance:setNamed", function(setName)
    local src = source
    if IsPlayerAceAllowed(src, "kc_test.set.rtr") then
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
-- RegisterNetEvent("instance:setEntityRtr")
-- AddEventHandler("instance:setEntityRtr", function(entityId, routingBucket)
--     -- local NetId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
--     if IsPlayerAceAllowed(source, "kc_test.set.entity_rtr") then
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

RegisterServerEvent("instance:setHub")
AddEventHandler("instance:setHub", function()
    if IsPlayerAceAllowed(source, "kc_test.hub") then
        SetPlayerRoutingBucket(source, lobbyBucket)
        Server.SendMessage(source, "You have been returned to the main lobby.")
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)

-- TODO Add other player support to this.
RegisterServerEvent("instance:setNoPopulation")
AddEventHandler("instance:setNoPopulation", function()
    if IsPlayerAceAllowed(source, "kc_test.rtr.set.no.population") then
        SetRoutingBucketPopulationEnabled(noPopulationBucket, false)

        SetPlayerRoutingBucket(source, noPopulationBucket)
        Server.SendMessage(source, "You have been sent to the no population lobby.")
    else
        Server.SendMessage(source, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)

-- I got this part to work, I had to get the network ID like I was doing in lobby_test.
RegisterServerEvent("instance:getCurrent")
AddEventHandler("instance:getCurrent", function()
    if IsPlayerAceAllowed(source, "kc_test.get.rtr") then
        -- This requires the network of of the player.
        local netId = NetworkGetEntityFromNetworkId(source)

        -- local currentRoutingBucket = GetEntityRoutingBucket(source)
        local currentRoutingBucket = GetEntityRoutingBucket(netId)
        Server.SendMessage(source, string.format("Current routing bucket: %d", currentRoutingBucket))
    else
        Server.SendMessage(src, "[Error]: You do not have permission for this!")
        -- Server.SendErrorMessage()
    end
end)
