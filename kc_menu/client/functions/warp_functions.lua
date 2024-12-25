-- TODO Setup config for the warps

function teleportToNewAreas(areaName)
    local player = GetPlayerPed(-1)
    local carrier1 = "m24_1_carrier"
    local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"
    local aircarrierX, airCarrierY, airCarrierZ = -3259.89, 3909.33, 26.78
    local bountyOfficeX, bountyOfficeY, bountyOfficeZ = 565.887, -2688.762, -50.2


    if VersionCheck() then
        if areaName == "aircarrier1" then
            if IsIplActive(carrier1) then
                FadeScreenForTeleport()
                SetEntityCoords(player, aircarrierX, airCarrierY, airCarrierZ, true, false, false, false)
                notify("Warped to the aircraft carrier.")
            end
        elseif areaName == "bountyoffice" then
            if IsIplActive(bountyOffice2) then
                FadeScreenForTeleport()
                SetEntityCoords(player, bountyOfficeX, bountyOfficeY, bountyOfficeZ, true, false, false, false)
                notify("Warped to the bounty office.")
            end
        else
            notify("Area name not valid.")
        end
    else
        notify("You cannot use the new ipls! You need to be on version 3258")
    end
end

function teleportToWarps(warpName)
    local player = GetPlayerPed(-1)
    local spawnX, spawnY, spawnZ = 222.2027, -864.0162, 29.2922
    local cayoX, cayoY, cayoZ = 4840.571, -5174.425, 2.0

    -- I made my own set coords function, moved the booleans into it
    if warpName == "spawn" then
        FadeScreenForTeleport()
        setPlayerCoords(player, spawnX, spawnY, spawnZ)
        notify("Warped to spawn.")
        -- SetEntityCoords(player, spawnX, spawnY, spawnZ, true, false, false, false)
    elseif warpName == "cayoPerico" and CayoPericoVersionCheck() then
        FadeScreenForTeleport()
        setPlayerCoords(player, cayoX, cayoY, cayoZ)
        notify("Warped to Cayo perico.")
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
        notify("Be prepared to die in 2 seconds.")
        Wait(2000)
        -- TaskParachute(player, true, true)
    else
        notify("You are going to die")
    end

    setPlayerCoords(player, x, y, z + 100)
    -- GiveWeaponToPed(player)
end
