function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Todo Make this set the heading too.

-- TODO Make this only show the marker if the player is near.
-- I should be able to adapt the Vdist2 I am using for this in the thread.

local Warps = {}


-- From ScaleformUI
---Put floating text in the world
---@return nil
-- function Warps.DrawText3D(x, y, z, text, font, size, colorR, colorG, colorB, colorA)
function Warps.DrawText3D(x, y, z, text, scale, font, colorR, colorG, colorB, colorA)
    local cam = GetGameplayCamCoord()
    -- local dist = #(coords - cam)
    -- local scaleInternal = (1 / dist) * size
    local scale = 1.0
    local fov = (1 / GetGameplayCamFov()) * 100
    -- local _scale = scaleInternal * fov
    local _scale = scale * fov

    -- SetTextScale(0.1 * _scale, 0.15 * _scale)
    SetTextScale(scale, scale)
    SetTextFont(font)
    SetTextProportional(true)

    -- SetTextColour(color.R, color.G, color.B, color.A)
    SetTextColour(colorR, colorG, colorB, colorA)
    SetTextDropshadow(5, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)

    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    -- SetDrawOrigin(coords.x, coords.y, coords.z, 0)
    SetDrawOrigin(x, y, z, 0)
    BeginTextCommandDisplayText("STRING")

    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0, 0)

    ClearDrawOrigin()
end

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
---@diagnostic disable-next-line: param-type-mismatch
        nil,
        -- textureName
---@diagnostic disable-next-line: param-type-mismatch
        nil,
        -- drawOnEnts
        false
    )
end

-- Draw the warp markers
function Warps.Draw()

    local playerCoord = GetEntityCoords(PlayerPedId(), false)

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

            -- This works! Shows the text over the marker if the player is close.
            if Vdist2(playerCoord.x, playerCoord.y, playerCoord.z, loc.pos.x, loc.pos.y, loc.pos.z)
            -- < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
            -- < loc.scale * 1.50 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
            < loc.scale * 5.0 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then

            Warps.DrawText3D(
            loc.text_pos.x, loc.text_pos.y, loc.text_pos.z,
            loc.text_name, loc.scale, 1,
            loc.text_rgba[1],
            loc.text_rgba[2],
            loc.text_rgba[3],
            loc.text_rgba[4]
            -- loc.text_name, 7, 10)
            )

        end
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
