-- TODO Setup this to log stats to mysql or json
-- Grab the values from stat_functions.lua




-- How would I do this?
local function checkforUpdatedStats()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)

    if statsUpdated then
        
    end

end

-- Possibly setup an event that watches each stat that I have setup, and logs whenever one changes every second or 500ms
-- RegisterNetEvent("kc_menu:log_stats")
-- AddEventHandler("kc_menu:log_stats", function()
--     while true do
--         Wait(500)
--             checkForUpdatedStats()
--             logUpdatedStats()
--     end
-- end)
