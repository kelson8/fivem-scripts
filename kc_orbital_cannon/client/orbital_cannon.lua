---@diagnostic disable: cast-local-type, param-type-mismatch
local cannon_index = -1

-- TODO Test this, fix it to work.

-- I stil need to make this have a custom camera and setup the scaleforms.

-- Orbital cannon test,
-- Adapted somewhat from here:
-- https://www.gta5-mods.com/scripts/orbital-cannon

-- Scaleform functions

local orbCamscaleformHandle = 0

-- 1 = Orbital cannon computer window? I think from the facility.
-- 2 = 'Firing in' screen without 'charging' text
-- 3 = 'Firing in' screen with 'charging' text
-- 4 = 'Firing in' screen with 'charging' text and a red marker in the middle
local orbCannonState = 2

-- The countdown for the 'firing in' text on the screen.
local orbCannonCountdown = 3
local orbCannonChargeLevel = 1.0

local drawScaleform = false


-- Camera and positions
-- Toggle this to turn the camera off that this uses.
local cameraTest = true

-- If this is true, it shouldn't create the camera anymore.
local cameraActive = false
local cam = 0
-- local newCamera = 0

-- Position
-- TODO Set these up.
-- local camPosX = 0.0
-- local camPosY = 0.0
-- local camPosZ = 0.0

-- Rotation
-- Well these cannot be changed in the command.
-- Now these can be changed once then won't change anymore in the command.
local camRotX = 0.0
local camRotY = 0.0
local camRotZ = 0.0

-- I got this to draw the scaleform!
-- It doesn't function just yet but I think I can figure it out.
-- I now have this setup to draw a camera and make it disappear.
function TestScaleform()
    local player = GetPlayerPed(-1)
    local pos = GetEntityCoords(player)
    local playerHeading = GetEntityHeading(player)
    local playerX = pos.x
    local playerY = pos.y
    local playerZ = pos.z

    -- Camera
    -- newCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)

    -- Taken some of the camera stuff from my skycam test in native_test

    -- Well I can set this camera but I cannot shut it off.
    -- local x, y, z = 793.75, -41.09, 103.32
    -- -- cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", x, y, z + 20.0, 0.0, 0.0, heading, 60.00, false, 0)

    if cameraTest then
        -- Make this only toggle once.
        if not cameraActive then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamCoord(cam, playerX, playerY, playerZ + 20)
            -- SetCamRot(cam, camRotX, camRotY, camRotZ, 0)
            -- SetCamFov(cam, 60.0)

            -- cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", playerX, playerY, playerZ + 20.0, camRotX, camRotY, camRotZ,
            --     60.00,
            --     false, 0)


            -- Fade the screen before enabling the camera.
            -- This works!
            -- Fade out
            exports.kc_util:FadeOut(500)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 1, true, true)
            cameraActive = true

            -- Fade back in
            exports.kc_util:FadeIn(500)
        end

        if cameraActive then
            -- SetCamCoord(cam, playerX, playerY, playerZ + 20)

            SetCamRot(cam, camRotX, camRotY, camRotZ, 0)
        end
    end

    -- Freeze the player, Idk if this is working
    -- SetPlayerControl(player, false, 0)

    -- Scaleform stuff
    orbCannonCamScaleform = "ORBITAL_CANNON_CAM"
    orbCannonZoomScaleformMethod = "SET_ZOOM_LEVEL"


    orbCannonSetStateScaleformMethod = "SET_STATE"
    orbCannonSetCountdownScaleformMethod = "SET_COUNTDOWN"
    orbCannonSetChargeLevelScaleformMethod = "SET_CHARGING_LEVEL"

    -- Setup the orbital cannon camera
    orbCamscaleformHandle = RequestScaleformMovie(orbCannonCamScaleform) -- The scaleform you want to use
    -- while not HasScaleformMovieNamedLoaded(orbCannonCamScaleform) do
    while not HasScaleformMovieLoaded(orbCamscaleformHandle) do
        Wait(0)
    end

    if HasScaleformMovieLoaded(orbCamscaleformHandle) then
        -- BeginScaleformMovieMethod(orbCamscaleformHandle, orbCannonCamScaleform)

        -- Setup the orbital cannon zoom
        -- BeginScaleformMovieMethod(orbCamscaleformHandle, orbCannonZoomScaleformMethod)
        -- ScaleformMovieMethodAddParamFloat(2)

        -- EndScaleformMovieMethod()

        -- SET_STATE
        -- This one don't seem to draw.
        BeginScaleformMovieMethod(orbCamscaleformHandle, orbCannonSetStateScaleformMethod)
        ScaleformMovieMethodAddParamInt(orbCannonState)
        EndScaleformMovieMethod()

        -- SET_COUNTDOWN
        -- This draws
        BeginScaleformMovieMethod(orbCamscaleformHandle, orbCannonSetCountdownScaleformMethod)
        ScaleformMovieMethodAddParamInt(orbCannonCountdown)
        EndScaleformMovieMethod()

        --

        -- SET_CHARGING_LEVEL
        -- Not sure if this one is doing anything.
        BeginScaleformMovieMethod(orbCamscaleformHandle, orbCannonSetChargeLevelScaleformMethod)
        ScaleformMovieMethodAddParamFloat(orbCannonChargeLevel)
        EndScaleformMovieMethod()
        --

        -- Was I forgetting to draw this damn thing?
        SetScriptGfxDrawOrder(0)
        DrawScaleformMovieFullscreen(orbCamscaleformHandle, 255, 255, 255, 255, 1) -- Draw the scaleform fullscreen
    end

    -- Wait(3000)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if drawScaleform then
            TestScaleform()
        end
    end
end)

-- Disable the camera
local function DisableCamera()
    if DoesCamExist(cam) then
        SetCamActive(cam, false)
        -- DestroyCam(cam, false)
        RenderScriptCams(false, false, 1, true, true)
        cameraActive = false
    end
end


-- First this disables the scaleform.
-- Then stops the animations and audio bank if they are running.
-- Lastly, it fades out, disables the camera, and fades back in.
local function CleanupOrbitalCam()

    local orbCannonAnimFx = "MP_OrbitalCannon"

    -- Disable the scaleform
    drawScaleform = false

    if AnimpostfxIsRunning(orbCannonAnimFx) then
        AnimpostfxStop(orbCannonAnimFx)
    end

    ReleaseNamedScriptAudioBank("DLC_XM_Explosions_Orbital_Cannon")

    -- Disable the camera
    -- Fade the screen before disabling the camera.
    -- Fade out
    if not IsScreenFadedOut() then
        exports.kc_util:FadeOut(500)
    end

    DisableCamera()
    -- Fade back in
    if not IsScreenFadedIn() then
        exports.kc_util:FadeIn(500)
    end
end


--

-- Some of these below are from here:
-- https://github.com/scripthookvdotnet/scripthookvdotnet/blob/main/source/scripting_v3/GTA/Scaleform.cs

-- local function CallFunctionHead(scaleform, scaleformFunction)
--     BeginScaleformMovieMethod(scaleform, scaleformFunction)


-- end
--

local orbCannonFxAsset = "scr_xm_orbital"
local orbCannonBlast = "scr_xm_orbital_blast"

local function FireCannon()
    -- local function FireCannon(camX, camY, camZ)
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    -- Originally this function runs with these two natives at the top, for the camera Z positions:
    -- GET_GROUND_Z_FOR_3D_COORD
    -- GET_GROUND_Z_AND_NORMAL_FOR_3D_COORD

    -- 60 = ExplosionType.BombStandardWide
    AddExplosion(playerPos.x, playerPos.y, playerPos.z, 60, 100.0, true, false, 1.0)


    -- These seem to draw the explosion effect.
    UseParticleFxAsset(orbCannonFxAsset)
    RequestNamedPtfxAsset(orbCannonFxAsset)
    UseParticleFxAsset(orbCannonFxAsset)
    StartParticleFxNonLoopedAtCoord(orbCannonBlast, playerPos.x, playerPos.y, playerPos.z,
        0.0, 0.0, 0.0, 2.3, false, false, false)
    -- This plays the sound effect for it.
    PlaySoundFromCoord(-1, "DLC_XM_Explosions_Orbital_Cannon", playerPos.x, playerPos.y, playerPos.z, "", true, 3, false)
end

RegisterCommand("orbcan_sctoggle", function(source, args, rawCommand)
    drawScaleform = not drawScaleform
    if drawScaleform then
        Text.Notify("Orbital Cannon scaleform ~b~enabled~w~.")
    else
        Text.Notify("Orbital Cannon scaleform ~b~disabled~w~.")

        -- Cleanup the orbital camera and shut it off.
        CleanupOrbitalCam()
    end
end, false)


-- Setting the orbital cannon scaleform states.
-- This can change the count down timer.
RegisterCommand("orbcan_countdown", function(source, args, rawCommand)
    orbCannonCountdown = tonumber(args[1])
end, false)

RegisterCommand("orbcan_charge", function(source, args, rawCommand)
    orbCannonChargeLevel = tonumber(args[1])
end, false)

RegisterCommand("orbcan_state", function(source, args, rawCommand)
    orbCannonState = tonumber(args[1])
end, false)

-- Setting the orbital_cannon camera position

-- Position
-- TODO Set this one up.
-- RegisterCommand("orbcan_campos", function(source, args, rawCommand)
--     if cameraTest then
--         camPosX = tonumber(args[1])
--         camPosY = tonumber(args[2])
--         camPosZ = tonumber(args[3])

--         SetCamCoord(cam, camPosX, camPosY, camPosZ)

--         Text.Notify(string.format("Set rotation to X: %f Y: %f Z: %f", camPosX, camPosY, camPosZ))
--     end
-- end, false)

-- Rotation
-- Well these don't seem to change it.
-- Now this changes it once but it wont change it anymore.
RegisterCommand("orbcan_camrot", function(source, args, rawCommand)
    if cameraTest then
        camRotX = tonumber(args[1])
        camRotY = tonumber(args[2])
        camRotZ = tonumber(args[3])

        if camRotX and camRotY and camRotZ ~= nil then
            -- SetCamCoord(cam, )
            SetCamRot(cam, camRotX, camRotY, camRotZ, 0)

            Text.Notify(string.format("Set rotation to X: %f Y: %f Z: %f", camRotX, camRotY, camRotZ))
        end
    end
end, false)

--

RegisterCommand("orbcan_phase1", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    -- case 0 (stage 1)
    -- Setup the animation.
    AnimpostfxPlay("MP_OrbitalCannon", 0, true)

    -- Request the audio bank
    -- RequestScriptAudioBank("DLC_CHRISTMAS2017/XM_ION_CANNON", false)

    -- case 10 (stage 2)



    -- case 20 (stage 3)

    --

    -- Fire Cannon function
    FireCannon()
end, false)


-- Shut down the orbital cannon scaleform, camera and anything else for the script.
RegisterCommand("orbcan_stop", function(source, args, rawCommand)
    -- Cleanup the orbital camera and shut it off.
    CleanupOrbitalCam()

end, false)
