-- Taken idea from Calm-AI

-- TODO Test this.
-- Disable cops if the config option is false.
Citizen.CreateThread(function()
    if not TestConfig.PoliceEnabled then
        while true do
            Wait(0)
            for i = 1,12 do
                EnableDispatchService(i, false)
            end
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
			SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end
    end
end)