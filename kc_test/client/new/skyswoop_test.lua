-- This works! I never knew how to do this.
-- It is the SwitchToMultiFirstpart and SwitchToMultiSecondpart natives.
-- 
-- SWITCH_TO_MULTI_FIRSTPART
-- SWITCH_TO_MULTI_SECONDPART

-- Taken from screens.lua in vf_base
function showLoadingPrompt(label, time)
    Citizen.CreateThread(function()
        BeginTextCommandBusyString(tostring(label))
        EndTextCommandBusyString(3)
        Citizen.Wait(time)
        RemoveLoadingPrompt()
    end)
end

-- Taken from spawn.lua in vf_base from venomus-freemode.

RegisterCommand("skyswoop", function()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(PlayerPedId())

    if not IsPlayerSwitchInProgress() then
        SetEntityVisible(PlayerPedId(), false, 0)
        -- SwitchToMultiFirstpart(PlayerPedId(), 32, 1)
        SwitchToMultiFirstpart(PlayerPedId(), 32, 2)
        Wait(3000)
        -- Wait(500)

        -- showLoadingPrompt("PCARD_JOIN_GAME", 8000)
        showLoadingPrompt("PCARD_JOIN_GAME", 1000)
        Wait(1000)
    end

    Wait(5000)

    SwitchToMultiSecondpart(PlayerPedId())
    SetEntityVisible(PlayerPedId(), true, 0)
	Wait(5000)
end)
