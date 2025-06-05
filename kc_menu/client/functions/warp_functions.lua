-- TODO Setup config for the warps

-- local cayoPericoIpls = {

-- }

-- Begin Cayo Perico toggles

World.cayoPericoEnabled = false

-- Taken some code from here:
-- https://github.com/bdebruyn02/HeistIsland/blob/main/island/load.lua
function World.ToggleCayoPericoIsland()
    World.cayoPericoEnabled = not World.cayoPericoEnabled
    if not World.cayoPericoEnabled then
        -- return true
        SetIslandEnabled("HeistIsland", true)
        -- https://nativedb.dotindustries.dev/gta5/natives/0xF74B1FFA4A15FBEA?search=SET_ALLOW_STREAM_HEIST_ISLAND_NODES
        Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 1) -- island path nodes (from Disquse)
        SetScenarioGroupEnabled('Heist_Island_Peds', true)
        -- SetAudioFlag('PlayerOnDLCHeist4Island', 1)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', true, true)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', false, true)
    else
        SetIslandEnabled("HeistIsland", false)
        -- https://nativedb.dotindustries.dev/gta5/natives/0xF74B1FFA4A15FBEA?search=SET_ALLOW_STREAM_HEIST_ISLAND_NODES
        Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 0) -- island path nodes (from Disquse)
        -- SetAudioFlag('PlayerOnDLCHeist4Island', 0)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Zones', false, false)
        SetAmbientZoneListStatePersistent('AZL_DLC_Hei4_Island_Disabled_Zones', true, false)
    end

    return false
end

-- TODO Test this, should load the Cayo Perico map on the radar
-- Well this didn't seem to do anything.
-- Citizen.CreateThread(function()
--     -- Only run this while the Cayo Perico island is enabled.
--     while true do
--         Wait(0)

--         if World.cayoPericoEnabled then
--             SetRadarAsExteriorThisFrame()
--             SetRadarAsInteriorThisFrame("h4_fake_islandx", 4700.0, -5145.0, 0, 0)
--             Wait(0)
--         end
--     end
-- end)

-- Turn on the cayo perico island if it is not enabled.
function World.EnableCayoPericoIsland()
    if not World.cayoPericoEnabled then
        SetIslandEnabled("HeistIsland", true)
        World.cayoPericoEnabled = true
    end
end

-- Turn off the cayo perico island if it is enabled.
function World.DisableCayoPericoIsland()
    if World.cayoPericoEnabled then
        SetIslandEnabled("HeistIsland", false)
        World.cayoPericoEnabled = false
    end
end

-- End Cayo Perico toggles

function teleportToNewAreas(areaName)
    local player = GetPlayerPed(-1)
    local carrier1 = "m24_1_carrier"
    local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"


    -- Failsafe to auto disable cayo perico island, TODO Make a server event to trigger possibly?
    World.DisableCayoPericoIsland()

    if Version.BountyOfficeVersionCheck() then
        if areaName == "aircarrier1" then
            if IsIplActive(Warps.AircraftCarrier1.carrierIpl) then
                Teleports.TeleportFade(Warps.AircraftCarrier1.x, Warps.AircraftCarrier1.y, Warps.AircraftCarrier1.z, 10.0)
                exports.kc_util:Notify("Warped to the aircraft carrier.")
            end
        elseif areaName == "bountyoffice" then
            if IsIplActive(Warps.BountyOffice.bountyOfficeIpl) then
                Teleports.TeleportFade(Warps.BountyOffice.x, Warps.BountyOffice.y, Warps.BountyOffice.z, 10.0)
                exports.kc_util:Notify("Warped to the bounty office.")
            end
        else
            exports.kc_util:Notify("Area name not valid.")
        end
    else
        exports.kc_util:Notify("You cannot use the new ipls! You need to be on version 3258")
    end
end

-- TODO Make this auto unload Cayo Perico.
function teleportToWarps(warpName)
    local player = GetPlayerPed(-1)

    -- Check if the warp location exists in the table
    local warpLocation = Warps[warpName]

    -- TODO Test this new format
    if warpLocation then
        Teleports.TeleportFade(warpLocation.x, warpLocation.y, warpLocation.z, 10.0)

        if warpName == "Spawn1" then
            -- Teleports.TeleportFade(Warps.Spawn1.x, Warps.Spawn1.y, Warps.Spawn1.z, 10.0)
            World.DisableCayoPericoIsland()
            exports.kc_util:Notify("Warped to spawn.")
        -- elseif warpName == "arcade" then

        elseif warpName == "CayoPerico" and Version.CayoPericoVersionCheck() then
            World.EnableCayoPericoIsland()

            -- Teleports.TeleportFade(Warps.CayoPerico.x, Warps.CayoPerico.y, Warps.CayoPerico.z, 10.0)
            exports.kc_util:Notify("Warped to Cayo perico.")

            -- Failsafe to kill cayo perico island if another warp is set.
        else
            -- Generic notification for other warps
            exports.kc_util:Notify("Warped to " .. warpName .. ".")
            -- Always disable Cayo Perico when warping away from it.
            World.DisableCayoPericoIsland()
        end
    else
        exports.kc_util:Notify("Error: Warp location '" .. warpName .. "' not found.")
    end
end

function warpToSky()
    local player = GetPlayerPed(-1)
    local coords = GetEntityCoords(player)
    local x, y, z = coords.x, coords.y, coords.z
    local killDelay = true
    -- Test
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("gadget_parachute"), 1, false, false)

    --

    -- I could re-add this if needed
    -- FadeScreenForTeleport()
    if killDelay then
        exports.kc_util:Notify("Be prepared to die in 2 seconds.")
        Wait(2000)
        -- TaskParachute(player, true, true)
    else
        exports.kc_util:Notify("You are going to die.")
    end

    Teleports.TeleportFade(x, y, z + 100, 10.0)
    -- GiveWeaponToPed(player)
end
