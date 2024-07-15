-- This needs to be implemented on the server side, it doesn't work on the client.
-- https://forum.cfx.re/t/data-from-client-to-server/1916033
-- function textWrite(text)
--     log = io.open("resources/"..GetCurrentResourceName.."/log.txt", "a")
--     if log then
--         log:write(text)
--     else
--         print("Log file doesn't exist")
--     end
--     log:close()
-- end

-- RegisterNetEvent("interiorLog")
-- RegisterServerEvent("interiorLog")
-- AddEventHandler("interiorLog", function(text)
--     -- textWrite(text)
--     print(text)

--     TriggerClientEvent("")
-- end)