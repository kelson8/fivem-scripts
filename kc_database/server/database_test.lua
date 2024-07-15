-- https://github.com/IceClusters/icmysql/blob/main/docs/features/SupportLuaJS.mkd

-- https://iceclusters.github.io/docs/icMySQL/Functions/MySQL/Query

-- https://www.youtube.com/watch?v=oV1JG4UCbek

function sendMessage(source, msg)
    TriggerClientEvent('chat:addMessage', source, {
        args = {msg, },
    })
end

function notifyPlayer(source, msg)
    -- Add custom notification here (use chat by default)
    -- TriggerClientEvent('chatMessage', source, "[StreetRaces]", {255, 0, 0}, msg)
    -- This works! My first time doing client to server events.
    TriggerClientEvent("db_test:notifyClient", source, msg)
end

-- local sqlQuery = MySQL.Select("SELECT * FROM vehicles")
local sqlQuery = MySQL.AwaitQuery(1, "SELECT * FROM vehicles")

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

-- https://stackoverflow.com/questions/48078128/how-to-get-value-from-the-table-in-lua

-- This worked!!! its pulling the values from the table
-- https://forum.cfx.re/t/does-fivem-have-a-function-to-print-a-table-lua/5070534/4
RegisterCommand("test2", function()
    tprint(sqlQuery, 0)
end)



