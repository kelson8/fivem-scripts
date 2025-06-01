function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Todo Make this set the heading too.

-- TODO Make this only show the marker if the player is near.
-- I should be able to adapt the Vdist2 I am using for this in the thread.

local Warps = {}

-- This will shorten the draw marker function, so I don't have to write out all of the variables.
function Warps.Marker(markerType, locX, locY, locZ, scaleX, scaleY, scaleZ, colorR, colorG, colorB, colorA)
    DrawMarker(markerType,
        locX, locY, locZ,
        -- Direction
        0.0, 0.0, 0.0,
        -- Rotation
        0.0, 0.0, 0.0,
        -- Scale
        scaleX, scaleY, scaleZ,
        -- Colors
        colorR, colorG, colorB, colorA,
        -- bobUpAndDown
        false,
        -- faceCamera
        true,
        -- p19
        2,
        -- Rotate
        false,
        -- textureDict
        "",
        -- textureName
        "",
        -- drawOnEnts
        false
    )
end

-- Draw the warp markers
function Warps.Draw()
    for i = 1, #locations, 1 do
        loc = locations[i]
        Warps.Marker(loc.marker,
            -- Position
            loc.pos.x, loc.pos.y, loc.pos.z,
            -- Scale
            loc.scale, loc.scale, loc.scale,
            -- Colors
            loc.rgba[1],
            loc.rgba[2],
            loc.rgba[3],
            loc.rgba[4]
        )
    end


    if loc.submarker ~= nil then
        Warps.Marker(loc.submarker.marker,
            loc.pos.x,
            loc.pos.y,
            -- Marker position, not teleport position.
            loc.submarker.posz,
            -- Scale
            loc.scale / 2, loc.scale / 2, loc.scale / 2,
            -- Colors
            loc.rgba[1],
            loc.rgba[2],
            loc.rgba[3],
            loc.rgba[4]
        )
    end
    --
end

Citizen.CreateThread(function()
    while true do
        Wait(1)
        Warps.Draw()

        local playerCoord = GetEntityCoords(PlayerPedId(), false)
        local locVector = vector3(loc.pos.x, loc.pos.y, loc.pos.z)

        -- if Vdist2(playerCoord, locVector) < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
        
        -- Check if the marker is within radius, if so teleport the player.
        if Vdist2(playerCoord.x, playerCoord.y, playerCoord.z, locVector.x, locVector.y, locVector.z)
        < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
            -- Code that runs when we are in the markers radius.
            SetEntityCoords(PlayerPedId(), loc.tpto.x, loc.tpto.y, loc.tpto.z, true, true, true, false)
            SetEntityHeading(PlayerPedId(), 0)
            notify("You have been teleported to location ~b~" .. loc.text_name)
        end
        -- end
    end
end)

-- RegisterCommand("ott", function()
--     for i = 1, #locations, 1 do
--         loc = locations[i]
--     end
--     notify(loc.pos.z)
-- end)
