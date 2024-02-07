-- Auto increment MySQL: https://www.heidisql.com/forum.php?t=34221

function notifyPlayer(source, msg)
    -- Add custom notification here (use chat by default)
    -- TriggerClientEvent('chatMessage', source, "[StreetRaces]", {255, 0, 0}, msg)
    -- This works! My first time doing client to server events.
    TriggerClientEvent("ch_car:notifyClient", source, msg)
end

RegisterCommand("spawnpv", function(source, args, rawCommand)
    local playerID = GetPlayerIdentifierByType(source, "license")

    local sqlQuery = "SELECT * FROM vehicles WHERE id=@id"

    -- This shows up the vehicles but, it always errors out if the value is null, I will need to figure out how to fix that.
    if args ~=nil then
    MySQL.Query(1, "SELECT * FROM vehicles WHERE playerID=@id AND vehicleID=@vehID", {
        ["@id"] = playerID,
        ["@vehID"] = args or 1
    },

    function(result)
        tprint(result, 1)
    end)
end

    -- MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, colorR, colorG, colorB)")

end)


-- tprint which prints a table.
function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
        formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            tprint(v, indent+1)
        elseif type(v) == 'boolean' then
            print(formatting .. tostring(v))
        else
            print(formatting .. v)
        end
    end
end

-- This is working now, the vehicle id in the database gets auto incremented.
RegisterServerEvent('ch_car:savepv')
AddEventHandler('ch_car:savepv', function(model, x, y, z, heading, color1, color2)
        insertValues(model, x, y, z, heading, color1, color2)
end)

function insertValues (model, x, y, z, heading, color1, color2)
    local playerID = GetPlayerIdentifierByType(source, "license")

    MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, color1, color2) VALUES (@playerID, @model, @xPos, @yPos, @zPos, @heading, @color1, @color2)",
    {
        ["@playerID"] = playerID,
        ["@model"] = model,
        ["@xPos"] = x,
        ["@yPos"] = y,
        ["@zPos"] = z,
        ["@heading"] = heading,
        ["@color1"] = color1,
        ["@color2"] = color2,
    })
end

RegisterCommand("getveh", function(source)
    TriggerClientEvent("ch_car:getVehicle", source)
end)

-- Spawning might work something like this?
-- TriggerClientEvent("ch_car:spawnVehicle", source, function()

-- end)
