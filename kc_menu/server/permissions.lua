-- https://forum.cfx.re/t/ace-permissions/107706/7

-- TODO Figure out how ace permissions work, could be useful for stuff like this that crashes.
RegisterServerEvent("kc_menu:canSpawnHeliPeds")
AddEventHandler("kc_menu:canSpawnHeliPeds", function (source)
    if IsPlayerAceAllowed(source, "kc_menu.can.spawn.heli.peds") then
        TriggerClientEvent("kc_menu:spawnHeliPeds")
    end
end)