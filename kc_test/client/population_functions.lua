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

-- -- Disable the vehicles and peds
-- Citizen.CreateThread(function()
--         while true do
--             if not peds then
--                 SetVehicleDensityMultiplierThisFrame(0.0)
--                 SetPedDensityMultiplierThisFrame(0.0)
--                 Wait(0)
--                 -- Revert back to normal
--             else
--                 -- Taken values from calm-ai config.lua, this will probably override it.
--                 -- I wonder if I can get the values from its config.
--                 SetVehicleDensityMultiplierThisFrame(0.85)
--                 SetPedDensityMultiplierThisFrame(0.75)
--                 Wait(0)
--         end
--     end
-- end)
