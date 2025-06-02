

-- Log to a file
-- https://forum.cfx.re/t/trying-to-write-to-a-file-but-errors-happen/206980
-- https://forum.cfx.re/t/data-from-client-to-server/1916033

RegisterServerEvent("kc_player:log")
AddEventHandler("kc_player:log", function(text)
    log = io.open("resources/".. "[kc-net]/" .. GetCurrentResourceName() .. "/log.txt", "a")

    if log then
        log:write(text)
    else
        print("Log file doesnt exist")
    end
    log:close()
end)

-- RegisterNetEvent("interiorLog")
-- RegisterServerEvent("interiorLog")
-- AddEventHandler("interiorLog", function(text)
--     -- textWrite(text)
--     print(text)

--     TriggerClientEvent("")
-- end)

