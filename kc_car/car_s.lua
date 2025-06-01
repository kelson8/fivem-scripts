local debugLogs = true

-- Auto increment MySQL: https://www.heidisql.com/forum.php?t=34221

-- I used a piece of this code as a reference: 
-- https://github.com/sesipod/FiveM/blob/master/resources/%5BStart-4%5D/esx_vehicleshop/server/main.lua

function notifyPlayer(source, msg)
    -- Add custom notification here (use chat by default)
    -- TriggerClientEvent('chatMessage', source, "[StreetRaces]", {255, 0, 0}, msg)
    -- This works! My first time doing client to server events.
    TriggerClientEvent("ch_car:notifyClient", source, msg)
end

-- RegisterServerEvent("ch_car:spawn")
-- AddEventHandler("ch_car:spawn", function(model, x, y, z, heading)

-- end)

-- TODO Re enable later

-- RegisterCommand("spawnpv", function(source, args, rawCommand)
--     local playerID = GetPlayerIdentifierByType(source, "license")

--     local sqlQuery = "SELECT * FROM vehicles WHERE playerID=@id AND vehicleID=@vehID"

--     -- This shows up the vehicles but, it always errors out if the value is null, I will need to figure out how to fix that.
--     if args[1] ~=nil then
--         MySQL.Query(1, sqlQuery, {
--             ["@id"] = playerID,
--             ["@vehID"] = args[1]
--         }, function(result)

--             -- With this loop the values are printing properly
--             -- Todo Figure out how to spawn the vehicles, I'm not sure how to trigger the client event for it.
--             for i=1, #result, 1 do

--                 -- local model = GetDisplayNameFromVehicleModel(result[i].model)

--                 -- local vehicle = CreateVehicle(result[i].model, result[i].xPos, result[i].yPos, result[i].zPos, result[i].heading, true, false)

--                 -- while not DoesEntityExist(vehicle) do
--                 --     Wait(0)
--                 -- end
--                 -- TriggerClientEvent("ch_car:spawn", result[i].model, result[i].xPos, result[i].yPos, result[i].zPos, result[i].heading)
--                 TriggerClientEvent("ch_car:spawnpv", source, result[i].model, result[i].xPos, result[i].yPos, result[i].zPos, result[i].heading)

--                 -- Move this into here, so it can be toggled if needed.
--                 if debugLogs then
--                 print(("X: %s Y: %s Z: %s"):format(result[i].xPos, result[i].yPos, result[i].zPos))
--                 print(("Heading: %s color1: %s color2: %s Car Model: %s"):format(result[i].heading, result[i].color1, result[i].color2, result[i].model))
--             end
--                 -- tprint(vehicles, 1)
--             end
--         end
--     )
--     -- -- Working code below
--     -- MySQL.Query(1, "SELECT xPos, yPos, zPos FROM vehicles WHERE playerID=@id AND vehicleID=@vehID", {
--     --     ["@id"] = playerID,
--     --     ["@vehID"] = args or 1
--     -- },

--     -- function(result)
--     --     tprint(result, 1)
--     -- end)
-- end
--     -- MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, colorR, colorG, colorB)")

-- end, false)

-- This command isn't implemented yet, make this to where it it'll despawn the car and come up with a different name for it.
-- RegisterCommand("unspawnpv", function(source, args, rawCommand)

-- end)


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

-- TODO Re enable later
-- This is working now, the vehicle id in the database gets auto incremented.
-- RegisterServerEvent('ch_car:savepv')
-- AddEventHandler('ch_car:savepv', function(model, x, y, z, heading, color1, color2)
--         insertValues(model, x, y, z, heading, color1, color2)
-- end)

-- function insertValues (model, x, y, z, heading, color1, color2)
--     local playerID = GetPlayerIdentifierByType(source, "license")

--     MySQL.AwaitInsert(1, "INSERT INTO `vehicles` (`playerID`, `model`, xPos, yPos, zPos, heading, color1, color2) VALUES (@playerID, @model, @xPos, @yPos, @zPos, @heading, @color1, @color2)",
--     {
--         ["@playerID"] = playerID,
--         ["@model"] = model,
--         ["@xPos"] = x,
--         ["@yPos"] = y,
--         ["@zPos"] = z,
--         ["@heading"] = heading,
--         ["@color1"] = color1,
--         ["@color2"] = color2,
--         -- Add this later, so the name also gets stored (Not neccessary, just to know which vehicles are which in the tables.)
--         -- ["@vehName"] = vehName,
--     })
-- end



-- RegisterCommand("getveh", function(source)
--     TriggerClientEvent("ch_car:getVehicle", source)
-- end, false)

-- Spawning might work something like this?
-- TriggerClientEvent("ch_car:spawnVehicle", source, function()

-- end)