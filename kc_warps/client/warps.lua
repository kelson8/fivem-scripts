-- Moved markers into markers.lua

-- This might work for interiors, make sure the interior is loaded
-- https://forum.cfx.re/t/help-teleport-player-to-streamed-location/811867/4

-- List of warps are in warp_locations.lua

-- TODO Set this up
-- TODO Possibly make this into an ox_lib menu.
RegisterCommand("warplist", function ()

end, false)

RegisterCommand("warp", function (source, args, rawCommand)
    local warpName = args[1]

    -- if warpName == nil then
    if not warpName then
        exports.kc_util:Notify("~r~Error~w~: No warp specified")
     end

    if warpName == "arcade_int" then
        exports.kc_util:TeleportFade(warpList.ArcadeInterior.x, warpList.ArcadeInterior.y, warpList.ArcadeInterior.z, 30.0)
    else
        exports.kc_util:Notify("~r~Error~w~: Warp doesn't exist.")
    end

end, false)