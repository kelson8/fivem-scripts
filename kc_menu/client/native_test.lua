-- Set ped dies in water
function setPedDiesInWaterTest(ped, toggle)
    SetPedDiesInWater(ped, toggle)
    SetPedDiesInstantlyInWater(ped, toggle)
end

-- GetPedDiesInWater

--[[
-- https://nativedb.dotindustries.dev/gta5/natives/0xB51194800B257161?search=createca
]]

-- Create a camera
-- https://forum.cfx.re/t/creating-camera/4852294

local frozen = false

-----------
--- Death cam in the sky test
--- This is neat, I can make a camera in the sky like in online.
-----------

function DeathCam()
    local player = GetPlayerPed(-1)
    local pos = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)

    local x, y, z = 793.75, -41.09, 103.32
    local heading = 140.2
    -- Stop this from being instant
    FadeScreenForTeleport()
    -- cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y + 0.5, pos.z + 0.5, 0.0, 0.0, heading, 60.00, false, 0)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z + 20.0, 0.0, 0.0, heading, 60.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true, false)
    -- Freeze the player, Idk if this is working
    SetPlayerControl(player, false, 0)

    -- Got the idea for the loop from easyadmin, this works now
    frozen = true
    Citizen.CreateThread(function()
        while frozen do
            Wait(0)
            FreezeEntityPosition(player, true)
        end
    end)

    -- print("Testing camera")
end

-----------
---
-----------

-----------
--- Stop death cam in the sky test
-----------

function StopDeathCam()
    local player = GetPlayerPed(-1)
    -- Stop this from being instant
    FadeScreenForTeleport()
    SetCamActive(cam, false)
    -- Needed to prevent this from glitching out.
    RenderScriptCams(false, false, 1, true, true, false)

    SetPlayerControl(player, true, 0)
    FreezeEntityPosition(player, false)

    frozen = false
    -- print("Disabling camera")
end

-----------
---
-----------
