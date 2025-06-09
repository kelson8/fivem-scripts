-- Taken idea from Calm-AI

local DisabledEms = {
    FireDepartment = 3, -- Fire Department
    Ambulance = 5,      -- Ambulance
}

-- Disable cops if the config option is true
Citizen.CreateThread(function()
    -- Temporary
    -- for i = 1, 12 do
    --     EnableDispatchService(i, true)
    -- end

    while true do
        Wait(0)

        if TestConfig.PoliceRadioDisabled then
            -- This seems to work for disabling the police radio.
            -- https://nativedb.dotindustries.dev/gta5/natives/0xB9EFD5C25018725A?search=SetAudioFlag
            SetAudioFlag("PoliceScannerDisabled", true)
        end

        if TestConfig.PoliceDisabled then
            SetPlayerWantedLevel(PlayerId(), 0, false)
            SetPlayerWantedLevelNow(PlayerId(), false)
            SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
        end

        -- This should only disable Ambulances and Firetrucks now
        if TestConfig.EmergencyVehiclesDisabled then
            -- for i = 1, 12 do
            -- EnableDispatchService(i, false)
            EnableDispatchService(DisabledEms.Ambulance, false)
            EnableDispatchService(DisabledEms.FireDepartment, false)
            -- end
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
