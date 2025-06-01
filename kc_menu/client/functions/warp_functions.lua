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
                Text.Notify("Warped to the aircraft carrier.")
            end
        elseif areaName == "bountyoffice" then
            if IsIplActive(Warps.BountyOffice.bountyOfficeIpl) then
                Teleports.TeleportFade(Warps.BountyOffice.x, Warps.BountyOffice.y, Warps.BountyOffice.z, 10.0)
                Text.Notify("Warped to the bounty office.")
            end
        else
            Text.Notify("Area name not valid.")
        end
    else
        Text.Notify("You cannot use the new ipls! You need to be on version 3258")
    end
end

-- TODO Make this auto unload Cayo Perico.
function teleportToWarps(warpName)
    local player = GetPlayerPed(-1)
    -- local spawnX, spawnY, spawnZ = 222.2027, -864.0162, 29.2922
    -- local cayoX, cayoY, cayoZ = 4840.571, -5174.425, 2.0

    -- I made my own set coords function, moved the booleans into it
    if warpName == "spawn" then
        -- Teleports.TeleportFade(spawnX, spawnY, spawnZ, 10.0)
        Teleports.TeleportFade(Warps.Spawn1.x, Warps.Spawn1.y, Warps.Spawn1.z, 10.0)
        -- disableCayoPericoIsland()
        World.DisableCayoPericoIsland()
        Text.Notify("Warped to spawn.")
        -- World.ToggleCayoPericoIsland()
    elseif warpName == "cayoPerico" and Version.CayoPericoVersionCheck() then
        -- enableCayoPericoIsland()
        World.EnableCayoPericoIsland()

        -- World.ToggleCayoPericoIsland()
        -- Teleports.TeleportFade(cayoX, cayoY, cayoZ, 10.0)
        Teleports.TeleportFade(Warps.CayoPerico.x, Warps.CayoPerico.y, Warps.CayoPerico.z, 10.0)
        Text.Notify("Warped to Cayo perico.")

        -- Failsafe to kill cayo perico island if another warp is set.
    else
        World.DisableCayoPericoIsland()
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
        Text.Notify("Be prepared to die in 2 seconds.")
        Wait(2000)
        -- TaskParachute(player, true, true)
    else
        Text.Notify("You are going to die")
    end

    Teleports.TeleportFade(x, y, z + 100, 10.0)
    -- GiveWeaponToPed(player)
end
