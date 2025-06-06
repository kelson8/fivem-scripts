-- Toggle on/off emergency services

-- I don't think this works right, at least for the fire trucks.

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if Config.DisableEms then
            for i = 1, 12 do
                EnableDispatchService(i, false)
            end
        end
    end
end)
