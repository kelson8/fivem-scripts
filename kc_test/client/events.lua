-- Check for option in the config.
-- https://github.com/CritteRo/fivem-scaleform-lib/blob/main/critScaleforms/client/cl_examples.lua

-- TODO Make a test that uses the conceal player native if the player enters an apartment/house.
-- NetworkConcealPlayer() - https://nativedb.dotindustries.dev/gta5/natives/0xBBDF066252829606
-- NetworkIsPlayerConcealed() - https://nativedb.dotindustries.dev/gta5/natives/0x919B3C98ED8292F9
-- NetworkConcealEntity() - https://nativedb.dotindustries.dev/gta5/natives/0x1632BE0AC1E62876
-- NetworkIsEntityConcealed() - https://nativedb.dotindustries.dev/gta5/natives/0x71302EC70689052A

-- This almost works, it displays when the player dies but won't go away.
-- if TestConfig.WastedMessage then
--     Citizen.CreateThread(function()
--         while true do
--             local player = GetPlayerPed(-1)
--             Wait(0)
--             if IsEntityDead(player) then
--                 -- This adds the death fade effect.
--                 StartScreenEffect("DeathFailOut", 0, 0)
--                 -- This adds the death sound.
--                 PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)

--                 -- Citizen.CreateThread(function()
--                 -- local scaleformHandle = RequestScaleformMovie("ORBITAL_CANNON_SCALEFORM_BS_COUNTDOWN_0") -- The scaleform you want to use

--                 -- local drawScaleform = true
--                 local hideHud = false

--                 local bigMessageScaleform = "mp_big_message_freemode"

--                 -- local scaleformHandle = RequestScaleformMovie(overViewScaleform1) -- The scaleform you want to use
--                 -- local scaleformHandle = RequestScaleformMovie("GTAV_ONLINE") -- The scaleform you want to use
--                 local scaleformHandle = RequestScaleformMovie(bigMessageScaleform)         -- The scaleform you want to use
--                 while not HasScaleformMovieLoaded(scaleformHandle) do                      -- Ensure the scaleform is actually loaded before using
--                     Citizen.Wait(0)
--                 end

--                 -- BeginScaleformMovieMethod(scaleformHandle, "OVERVIEW_BACKGROUND") -- The function you want to call from the AS file
--                 -- BeginScaleformMovieMethod(scaleformHandle, "SET_ZOOM_LEVEL") -- The function you want to call from the AS file
--                 BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE")         -- The function you want to call from the AS file
--                 -- PushScaleformMovieMethodParameterString("KelsonCraft")                     -- bigTxt
--                 -- Colors can be used in these also
--                 PushScaleformMovieMethodParameterString("~r~Wasted")         -- bigTxt
--                 PushScaleformMovieMethodParameterString("")                  -- bigTxt
--                 -- PushScaleformMovieMethodParameterString("")                  -- msgText
--                 PushScaleformMovieMethodParameterInt(5)                      -- colId
--                 EndScaleformMovieMethod()       -- Finish off the scaleform, it returns no data, so doesnt need "EndScaleformMovieMethodReturn"
--                 -- PopScaleformMovieFunctionVoid()

--                 Citizen.Wait(500)

--                 while IsEntityDead(player) do         -- Draw the scaleform every frame
--                     -- https://forum.cfx.re/t/how-to-hide-gta-5-default-hud/4239563
--                     -- Hide the map and everything if specified.
--                     -- if hideHud then
--                     --     HideHudAndRadarThisFrame()
--                     -- end

--                     -- if drawScaleform then
--                     DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255)             -- Draw the scaleform fullscreen
--                     -- DrawScaleformMovie(scaleformHandle, 100.2, 100.2, 20, 20, 255, 50, 50, 50, 20)
--                     -- DrawScaleformMovie(scaleformHandle, 896.44, 25.45, 20, 20, 255, 50, 50, 50, 20)
--                     -- end
--                     Citizen.Wait(0)
--                 end

--             else
--                 StopScreenEffect("DeathFailOut")
--                 -- end)
--             -- else
--             --     SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
--             --     RemoveScaleformScriptHudMovie(scaleformHandle)
--             end
--         end
--     end)
-- end


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
