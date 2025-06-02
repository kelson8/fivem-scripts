local ragDollEnabled = false

local envEffScaleEnabled = false

local invincibilityEnabled = false

-- TODO Figure this one out.

-- function ToggleRagdoll()
--     ragDollEnabled = not ragDollEnabled
--     if ragDollEnabled then
        
--     else
--     end

-- end

function getInvincibilityEnabled()
    return invincibilityEnabled
end

function DisableInvincibility()
    local player = GetPlayerPed(-1)
    playerPed = PlayerPedId() -- PlayerId

    invincibilityEnabled = false
    SetEntityProofs(playerPed, false, false, false, false, false, false, false, false)
    exports.kc_util:Notify("Invincibility Disabled")
end

function EnableInvincibility()
    local player = GetPlayerPed(-1)
    playerPed = PlayerPedId() -- PlayerId

    invincibilityEnabled = true
    SetEntityProofs(playerPed, true, true, true, true, true, true, true, true)
    exports.kc_util:Notify("Invincibility Enabled")
end

-- Mostly adapted from the Chaos Mod:
-- https://github.com/gta-chaos-mod/ChaosModV/blob/master/ChaosMod/Effects/db/Player/PlayerSuicide.cpp
-- Run the mp suicide animation just like in online.
function MpSuicide()
    local animDict = "mp_suicide"
    local animName = "pistol"

    local player = GetPlayerPed(-1)
    playerPed = PlayerPedId() -- PlayerId


    if not IsPedInAnyVehicle(player, false) and IsPedOnFoot(player)
    and GetPedParachuteState(playerPed) == -1 then
        RequestAnimDict(animDict)
        exports.kc_util:Notify("Running")

        -- Wait on this to load
        while not HasAnimDictLoaded(animDict) do
            Wait(0)
        end

        local pistol = GetHashKey("weapon_pistol")

        GiveWeaponToPed(playerPed, pistol, 9999, true, true)

        -- Play the MP Suicide animation
        TaskPlayAnim(playerPed, animDict, animName, 8.0, -1.0, 800, 1, 0.0, false, false, false)
        Wait(750)

        SetPedShootsAtCoord(playerPed, 0.0, 0.0, 0.0, true)
        RemoveAnimDict(animDict)

        SetEntityHealth(playerPed, 0, 0, 0)

    end

end

-- function ToggleInvincibility()

-- end

-- TODO Figure out what exactly this does
-- This didn't seem to toggle anything.
-- https://nativedb.dotindustries.dev/gta5/natives/0xD2C5AA0C0E8D0F1E?search=SET_ENABLE_PED_ENVEFF_SCALE
-- SET_ENABLE_PED_ENVEFF_SCALE
function ToggleEnvEffScale()
    playerId = PlayerId()
    playerName = GetPlayerName(playerId)
    playerPed = PlayerPedId()

    envEffScaleEnabled = not envEffScaleEnabled

    if envEffScaleEnabled then
        SetEnablePedEnveffScale(playerId, true)
        exports.kc_util:Notify("Enabled")
    else
        SetEnablePedEnveffScale(playerId, false)
        exports.kc_util:Notify("Disabled")
    end
end