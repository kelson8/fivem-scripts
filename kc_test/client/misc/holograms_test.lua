-- TODO Test this in this file!

---- Hologram test (This seems to work, puts text on the map but I haven't figured out how to get this to display health on a ped.)
-- Todo Setup this to work on the spawnped function to show the health above the ped.
-- I'm not exactly sure how to do that yet.
-- Source link: https://github.com/Vortex-z/Holograms-Floating-Text/blob/master/holograms/holograms.lua

-- TODO move these into another file.
Citizen.CreateThread(function()

    -- holograms()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local x,y,z = table.unpack(playerCoords)
    -- holograms(x,y,z)

    -- TODO Teleport to these coords and make sure this is still working, disable when done.
    holoTest()
end)

-- This seems to only work in the thread above.
function holoTest()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local x,y,z = table.unpack(playerCoords)

    while true do
        Citizen.Wait(0)
        -- if GetDistanceBetweenCoords(570.2, -986.29, 10.53 + 2, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
        if GetDistanceBetweenCoords(570.2, -986.29, 10.53 + 2, x, y, z, false) < 10.0 then
            Draw3DText(570.2, -986.29, 10.53 - 1.8, "If you found this, you win! Nothing!!!!", 4, 0.1, 0.1)
        end
    end
end

-- Todo Try to add this to the thread above with these parameters.
-- This almost works on my current character but doesn't update the location to it.
function holograms(ped_x, ped_y, ped_z)
    -- , text_x, text_y, text_z
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local x,y,z = table.unpack(playerCoords)

    local text = "Hello Player"

    while true do
        Citizen.Wait(0)
        -- if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
        -- Will this still work? I fixed the errors in vscode.
        if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, x, y, z, false) < 10.0 then
        -- if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, x, y, z) < 10.0 then
            Draw3DText(ped_x, ped_y, ped_z , text, 4, 0.1, 0.1)
        end
    end
end

---