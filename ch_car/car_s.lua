function notifyPlayer(source, msg)
    -- Add custom notification here (use chat by default)
    -- TriggerClientEvent('chatMessage', source, "[StreetRaces]", {255, 0, 0}, msg)
    -- This works! My first time doing client to server events.
    TriggerClientEvent("ch_car:notifyClient", source, msg)
end

RegisterCommand("spawnpv", function(source, args, rawCommand)
    local playerID = GetPlayerIdentifierByType(source, "license")
    local model = args
    local x,y,z = GetEntityCoords(source)
    local r,g,b = GetVehicleColor(source)

    MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, colorR, colorG, colorB)")

end)

-- This is grabbing the playerID since I have it defined below, I'm not sure how to get the other values though.
-- This is incomplete
-- Todo Fix this to work and save the vehicle the player is in.
RegisterCommand("savepv", function(source, args, rawCommand)
    local playerID = GetPlayerIdentifierByType(source, "license")

    TriggerClientEvent("ch_car:getVehicle", source)

        -- local x,y,z = GetEntityCoords(source)
        -- local r,g,b = GetVehicleColor(source)
        -- MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, colorR, colorG, colorB) VALUES (@playerID, @model, @xPos, @yPos, @zPos, @heading, @colorR, @colorG, @colorB)",
        MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, color1, color2) VALUES (@playerID, @model, @xPos, @yPos, @zPos, @heading, @color1, @color2)",
        {
            ["@playerID"] = playerID,
            ["@model"] = model,
            -- ["@model"] = carModel,
            ["@xPos"] = x,
            ["@yPos"] = y,
            ["@zPos"] = z,
            ["@heading"] = heading,
            ["@color1"] = color1,
            ["@color2"] = color2,
            -- ["@colorR"] = r,
            -- ["@colorG"] = g,
            -- ["@colorB"] = b,
        })
end)

RegisterCommand("getveh", function(source)
    TriggerClientEvent("ch_car:getVehicle", source)
end)


-- Spawning might work something like this?
-- TriggerClientEvent("ch_car:spawnVehicle", source, function()

-- end)
