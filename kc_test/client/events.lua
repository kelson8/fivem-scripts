-- Check for option in the config.
-- https://github.com/CritteRo/fivem-scaleform-lib/blob/main/critScaleforms/client/cl_examples.lua

-- TODO Make a test that uses the conceal player native if the player enters an apartment/house.
-- NetworkConcealPlayer() - https://nativedb.dotindustries.dev/gta5/natives/0xBBDF066252829606
-- NetworkIsPlayerConcealed() - https://nativedb.dotindustries.dev/gta5/natives/0x919B3C98ED8292F9
-- NetworkConcealEntity() - https://nativedb.dotindustries.dev/gta5/natives/0x1632BE0AC1E62876
-- NetworkIsEntityConcealed() - https://nativedb.dotindustries.dev/gta5/natives/0x71302EC70689052A

----
-- Interior check functions
----

-- Test disabling player weapons in the facility, do they all use the same coords?
-- This works

-- TODO Try to make this conceal the player as a test and use another client to join.
local function CheckPlayerIsInFacility()
    local player = GetPlayerPed(-1)
    local x1, y1, z1, x2, y2, z2 = 275.000, 4700.000, -72.000, 550.000, 4945.000, -32.000
    if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
        return true
    else
        return false
    end
end

-- This doesn't work right yet
local function CheckPlayerIsInCasino()
    local player = GetPlayerPed(-1)
    local x1, y1, z1, x2, y2, z2 = 1081.171, 189.428, -52.868, 1167.204, 285.143, -41.435
    if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
        return true
    else
        return false
    end
end

local function CheckPlayerIsInMilitaryBase()
    local player = GetPlayerPed(-1)
    local x1, y1, z1, x2, y2, z2 = -1425.48, 3323.03, 570.20, -2906.94, 2733.66, 18.69
    if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
        return true
    else
        return false
    end
end

local function CheckIsPlayerInPrison()
    local player = GetPlayerPed(-1)
    local x1, y1, z1, x2, y2, z2 = 1896.61, 2524.67, 70.99, 1444.28, 2833.46, 30.14
    if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
        return true
    else
        return false
    end
end

-- Houses in order from the blip numbers on FiveM
-- 7

-- This one picks up the player outside also so I have disabled it.
local function CheckPlayerIsInHouse7()
    local player = GetPlayerPed(-1)
    -- Z2 = 180
    -- local x1, y1, z1, x2, y2, z2 = 116.27, 559.95, 186.8, 126.36, 540.05, 180.5
    local x1, y1, z1, x2, y2, z2 = 113.27, 537.95, 186.8, 126.36, 571.50, 160.5
    if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
        return true
    else
        return false
    end
end

----
-- End interior check functions
----

----
-- Conceal functions
----

-- TODO Test this conceal function
local function IsPlayerConcealed()
    local player = GetPlayerPed(-1)
    if NetworkIsPlayerConcealed(player) then
        return true
    else
        return false
    end
end

local function SetPlayerConceal()
    if not IsPlayerConcealed() then
        NetworkConcealPlayer(player, true, true)
    else
        NetworkConcealPlayer(player, false, true)
    end
end

----
-- End conceal functions
----

-- TODO Fix this to work.
local function HolsterWeapon()
    local player = GetPlayerPed(-1)
    local currentWeapon = GetCurrentPedWeapon(player)
    local unarmedHash = GetHashKey("weapon_unarmed")
    local weaponKnuckleHash = GetHashKey("weapon_knuckle")

    if not currentWeapon == unarmedHash or not currentWeapon == weaponKnuckleHash then
        SetCurrentPedWeapon(player, unarmedHash, true)
    end
end

function DisableWeaponsInInterior()
    local player = GetPlayerPed(-1)
end

-- Disable shooting in interiors, this actually works.
-- I could use this to disable weapons in certain areas.
-- 12 = Weapon wheel up, 13 = Weapon wheel left, 14 = Weapon wheel next,
-- 15 = Weapon wheel previous, 16 = Next weapon, 17 = Previous weapon
-- 24 = Attack, 25 = Aim
-- 37 = Select Weapon,
-- 66 = Gun Left, 67 = Gun Right, 68 = Vehicle Aim,
-- 69 = Vehicle Attack, 70 = Vehicle Attack 2, 71 = Accelerate,
-- 72 = Brake, 73 = Duck, 257 = Attack 2, 263 = Melee Attack 1, 264 = Melee attack 2,
local controlActions = { 12, 13, 14, 15, 16, 17, 24, 25, 37, 68, 69, 70, 257, 263, 264 }

Citizen.CreateThread(function()
    local player = GetPlayerPed(-1)
    while true do
        Wait(0)
        -- Check if the config option is enabled, if so disable weapons in most interiors.
        if TestConfig.DisableWeaponsInInterior then
            -- Disable weapons in facility and casino
            if CheckPlayerIsInFacility() or CheckPlayerIsInCasino()
            -- Houses
            -- This one also disables weapons outside and I don't want that.
            -- or CheckPlayerIsInHouse7()
            then
                -- HolsterWeapon()
                -- TODO Test this conceal function
                -- SetPlayerConceal()
                -- Disable weapons, loop through the table above so I don't have a bunch of duplicate code
                for i, v in ipairs(controlActions) do
                    DisableControlAction(0, v, false)
                end
                -- else
            else
                -- TODO Test this conceal function
                -- SetPlayerConceal()
            end
        end

        -- Possibly set this one up?
        -- if TestConfig.DisableWeaponsInApartments then

        -- end

        -- Enable the minimap when close to the military base
        if TestConfig.ShowMilitaryBaseMap then
            if CheckPlayerIsInMilitaryBase() then
                SetMinimapComponent(15, true)
            else
                SetMinimapComponent(15, false)
            end
        end

        -- This didn't seem to work so I disabled it for now.
        if TestConfig.ShowPrisonMap then
            if CheckIsPlayerInPrison() then
                SetMinimapComponent(4, true)
            else
                SetMinimapComponent(4, false)
            end
        end
    end

    -- local x1, y1, z1, x2, y2, z2 = 275.000, 4700.000, -72.000, 550.000, 4945.000, -32.000
    -- if IsEntityInArea(player, x1, y1, z1, x2, y2, z2, false, true, false) then
    --     notify("You are in the facility")
    -- else
    --     notify("You are not in the facility")
    -- end
end)

-- This works.

-- Debug commands, enable with variable below.

local debugMode = false
if debugMode then
    RegisterCommand("facilitycheck", function()
        if CheckPlayerIsInFacility() then
            notify("You are in the facility")
            -- HolsterWeapon()
        else
            notify("You are not in the facility")
        end
    end, false)

    RegisterCommand("milbasecheck", function()
        if CheckPlayerIsInMilitaryBase() then
            notify("You are in the military base")
        else
            notify("You are not in the military base")
        end
    end, false)

    RegisterCommand("prisoncheck", function()
        if CheckIsPlayerInPrison() then
            notify("You are in the prison")
        else
            notify("You are not in the prison")
        end
    end, false)
end

local drawScaleform = false
-- This almost works, it displays when the player dies but won't go away.
if TestConfig.WastedMessage then
    local deathEffect = "DeathFailOut"
    Citizen.CreateThread(function()
        local player = GetPlayerPed(-1)
        while true do
            Wait(0)
            if IsEntityDead(player) then
                drawScaleform = true
                -- This adds the death fade effect.
                StartScreenEffect(deathEffect, 0, 0)
                -- This adds the death sound.
                PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)

                -- Citizen.CreateThread(function()
                -- local scaleformHandle = RequestScaleformMovie("ORBITAL_CANNON_SCALEFORM_BS_COUNTDOWN_0") -- The scaleform you want to use

                -- local drawScaleform = true
                local hideHud = false

                local bigMessageScaleform = "mp_big_message_freemode"

                -- local scaleformHandle = RequestScaleformMovie(overViewScaleform1) -- The scaleform you want to use
                -- local scaleformHandle = RequestScaleformMovie("GTAV_ONLINE") -- The scaleform you want to use
                local scaleformHandle = RequestScaleformMovie(bigMessageScaleform) -- The scaleform you want to use
                while not HasScaleformMovieLoaded(scaleformHandle) do              -- Ensure the scaleform is actually loaded before using
                    Citizen.Wait(0)
                end

                -- BeginScaleformMovieMethod(scaleformHandle, "OVERVIEW_BACKGROUND") -- The function you want to call from the AS file
                -- BeginScaleformMovieMethod(scaleformHandle, "SET_ZOOM_LEVEL") -- The function you want to call from the AS file
                BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file
                -- PushScaleformMovieMethodParameterString("KelsonCraft")                     -- bigTxt
                -- Colors can be used in these also
                PushScaleformMovieMethodParameterString("~r~Wasted") -- bigTxt
                PushScaleformMovieMethodParameterString("")          -- bigTxt
                -- PushScaleformMovieMethodParameterString("")                  -- msgText
                PushScaleformMovieMethodParameterInt(5)              -- colId
                EndScaleformMovieMethod()                            -- Finish off the scaleform, it returns no data, so doesnt need "EndScaleformMovieMethodReturn"
                -- PopScaleformMovieFunctionVoid()

                while IsEntityDead(player) do -- Draw the scaleform every frame
                    -- https://forum.cfx.re/t/how-to-hide-gta-5-default-hud/4239563
                    -- Hide the map and everything if specified.
                    -- if hideHud then
                    --     HideHudAndRadarThisFrame()
                    -- end

                    if drawScaleform then
                        DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255) -- Draw the scaleform fullscreen
                    end
                    -- DrawScaleformMovie(scaleformHandle, 100.2, 100.2, 20, 20, 255, 50, 50, 50, 20)
                    -- DrawScaleformMovie(scaleformHandle, 896.44, 25.45, 20, 20, 255, 50, 50, 50, 20)
                    -- end
                    Citizen.Wait(0)
                end
                Citizen.Wait(500)
            else
                StopScreenEffect(deathEffect)
                drawScaleform = false


                -- end)
                -- else
                --     SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
                --     RemoveScaleformScriptHudMovie(scaleformHandle)
            end
        end
    end)
end


--------------

--     while true do
--         local player = GetPlayerPed(-1)
--         Wait(0)
--         if IsEntityDead(player) then
--             Citizen.CreateThread(function()
--                 -- local scaleformHandle = RequestScaleformMovie("ORBITAL_CANNON_SCALEFORM_BS_COUNTDOWN_0") -- The scaleform you want to use

--                 -- local drawScaleform = true
--                 local hideHud = false

--                 local bigMessageScaleform = "mp_big_message_freemode"

--                 -- local scaleformHandle = RequestScaleformMovie(overViewScaleform1) -- The scaleform you want to use
--                 -- local scaleformHandle = RequestScaleformMovie("GTAV_ONLINE") -- The scaleform you want to use
--                 local scaleformHandle = RequestScaleformMovie(bigMessageScaleform) -- The scaleform you want to use
--                 while not HasScaleformMovieLoaded(scaleformHandle) do                    -- Ensure the scaleform is actually loaded before using
--                     Citizen.Wait(0)
--                 end

--                 -- BeginScaleformMovieMethod(scaleformHandle, "OVERVIEW_BACKGROUND") -- The function you want to call from the AS file
--                 -- BeginScaleformMovieMethod(scaleformHandle, "SET_ZOOM_LEVEL") -- The function you want to call from the AS file
--                 BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file
--                 -- PushScaleformMovieMethodParameterString("KelsonCraft")                     -- bigTxt
--                 PushScaleformMovieMethodParameterString("Wasted")                     -- bigTxt
--                 PushScaleformMovieMethodParameterString("")                  -- msgText
--                 PushScaleformMovieMethodParameterInt(5)                                    -- colId
--                 EndScaleformMovieMethod()                                                  -- Finish off the scaleform, it returns no data, so doesnt need "EndScaleformMovieMethodReturn"


--                 while true do     -- Draw the scaleform every frame
--                     Citizen.Wait(0)

--                     -- https://forum.cfx.re/t/how-to-hide-gta-5-default-hud/4239563
--                     -- Hide the map and everything if specified.
--                     -- if hideHud then
--                     --     HideHudAndRadarThisFrame()
--                     -- end

--                     if drawScaleform then
--                         DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255) -- Draw the scaleform fullscreen
--                         -- DrawScaleformMovie(scaleformHandle, 100.2, 100.2, 20, 20, 255, 50, 50, 50, 20)
--                         -- DrawScaleformMovie(scaleformHandle, 896.44, 25.45, 20, 20, 255, 50, 50, 50, 20)
--                     end
--                 end
--             end)
--         end
--     end
-- end

function PlayerKilledScaleform()

end
