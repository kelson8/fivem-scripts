---@diagnostic disable: duplicate-set-field


-- Positions = {}

Blip = {}
Fade = {}
Music = {}
Vehicle = {}
Player = {}
Scaleform = {}
Text = {}
World = {}

Teleports = {}

Version = {}
------------
-- Blip functions
------------
-- Blip test, not sure how to make this work
Blip.blip = nil

Blip.blipEnabled = false

function Blip.GetBlipEnabled()
    return Blip.blipEnabled
end

function Blip.SetBlipEnabled()
    Blip.blipEnabled = true
end

function Blip.SetBlipDisabled()
    Blip.blipEnabled = false
end

function Blip.CreateBlipTest()
    local player = GetPlayerPed(-1)
    -- local player = GetPlayerPed(-1)
    -- Set the blip to random area
    -- Sets it to the bridge beside the casino
    -- if blipEnabled then
        Blip.blip = AddBlipForArea(782.17, -37.28, 82.2, 5, 5)
        SetBlipSprite(Blip.blip, 598)
        SetBlipRotation(Blip.blip, Ceil(GetEntityHeading(player)))

        -- SetBlipRoute(blip, true)
        -- blipEnabled = true
    -- end
    -- if DoesBlipExist(blip) then
    --     SetBlipRotation(blip, )
    -- end
end

function Blip.RemoveBlipTest()
    -- if blipEnabled then
        RemoveBlip(Blip.blip)
        -- blipEnabled = false
    -- end

end


------------ 
--- Teleport functions
------------

-- Taken from functions.lua in kc_menu
--- Teleport with a fade
---@param x any
---@param y any
---@param z any
---@param heading any
function TeleportFade(x, y, z, heading)
    local player = GetPlayerPed(-1)
    local fadeInTime = 500
    local fadeOutTime = 500

    DoScreenFadeOut(fadeOutTime)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    SetEntityCoords(player, x, y, z, false, false, false, false)
    SetEntityHeading(player, heading)

    Wait(fadeInTime)
    DoScreenFadeIn(fadeInTime)
end

------------ 
--- Music functions
------------

-- function PlayMusicEvent(musicEvent)
function Music.Play(musicEvent)
    TriggerMusicEvent(musicEvent)
end

function Music.PlayArenaWarTheme()
    TriggerMusicEvent("AW_LOBBY_MUSIC_START")
end

-- This seems to stop the music.
function Music.Stop()
    TriggerMusicEvent("MP_MC_CMH_IAA_FINALE_START")
end

------------ 
--- Vehicle functions
------------

-- Copied from vehicle_functions.lua in kc_menu.

-- Spawn vehicle at a set coords with a heading, and optionally, clear the area around it.
-- function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
function Vehicle.Create(vehicleName, x, y, z, heading, clearArea)

    -- First, clear the area if toggled on.
    if clearArea then
        -- World.ClearVehiclesInArea(playerX, playerY, playerZ, 25.0)
        -- World.ClearVehiclesInArea(x, y, z, 25.0)
        World.ClearArea(x, y, z, 25.0)
    end

    local vehicleHash = GetHashKey(vehicleName)

    -- Disable tire burst here
    local tiresBurstDisabled = true

    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        return

    end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    -- SetEntityAsNoLongerNeeded(car)



    -- These color options don't seem to work.

    -- Car color test
    -- local carColorPrimary = colors.classic["Carbon Black"]
    -- local carColorSecondary = colors.classic["Lava Red"]
    -- SetVehicleColours(vehicle, carColorPrimary, carColorSecondary)

    local vehicleNew  = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    -- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
    -- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

    -- Make it to where the tires cannot be popped.
    if tiresBurstDisabled then
        SetVehicleTyresCanBurst(vehicleNew, false)
    end

    -- https://forum.cfx.re/t/setvehiclemod-is-not-working/1129056
    -- SetVehicleMod: https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
    -- This seems to be needed to set the vehicle mods.
    -- SetVehicleModKit(vehicleNew, 0)

    -- Test function, give vehicle all upgrades
    -- setVehicleMaxUpgrades(vehicleNew)

    SetModelAsNoLongerNeeded(vehicleHash)
end


-- TODO Set these up
-- function Vehicle.SetColor()

-- end

--

------------
-- Fade functions
------------

-- Fade the screen in and out for a teleport, so it's not instant.
-- This was an old function in the previous functions.lua.
function Fade.FadeScreen()
    local player = GetPlayerPed(-1)
    -- Test moving this into the thread.
    DoScreenFadeOut(500)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    Wait(500)
    DoScreenFadeIn(500)
    FreezeEntityPosition(player, false)
end

------------
-- Scaleform functions
------------
---
--- Some of these were taken from screens.lua in vf_base.
function Scaleform.SetButton(ControlButton)
    -- N_0xe83a3e3557a56640(ControlButton)
    ScaleformMovieMethodAddParamPlayerNameString(ControlButton)
end

function Scaleform.RequestDeathScaleform()
    local deathform = RequestScaleformMovie("MP_BIG_MESSAGE_FREEMODE")
    Instructional = RequestScaleformMovie("instructional_buttons")
    while not HasScaleformMovieLoaded(deathform) do
    	Wait(500)
    end

    return deathform
end


-- Show the wasted screen
function Scaleform.RequestDeathScreen()
	HideHudAndRadarThisFrame()

	if not locksound then
		ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 2.0)
		StartScreenEffect("DeathFailOut", 0, true)

		-- PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		PlaySoundFrontend(-1, "Bed", "WastedSounds", true)
		deathscale = RequestDeathScaleform()
		locksound = true
	end


    -- TODO Look into making these into functions to be used in a command or in my menu
    -- Death scaleform
	BeginScaleformMovieMethod(deathscale, "SHOW_WASTED_MP_MESSAGE")
    BeginTextCommandScaleformString("STRING")
    AddTextComponentSubstringTextLabel("RESPAWN_W")
    EndTextCommandScaleformString()

    -- Unsure what this one is
    BeginTextCommandScaleformString("AMHB_BYOUDIED")
    EndTextCommandScaleformString()

	PushScaleformMovieFunctionParameterFloat(105.0)
	PushScaleformMovieFunctionParameterBool(true)
	EndScaleformMovieMethod()
    --

	SetScreenDrawPosition(0.00, 0.00)
	DrawScaleformMovieFullscreen(deathscale, 255, 255, 255, 255, 0)
    --

    -- Instructional Buttons

    -- Clear
    BeginScaleformMovieMethod(Instructional, "CLEAR_ALL")
    EndScaleformMovieMethod()
    --

    --
    BeginScaleformMovieMethod(Instructional, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    EndScaleformMovieMethod()
    --

    -- Set the HUD_INPUT27 button
    BeginScaleformMovieMethod(Instructional, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    SetButton(GetControlInstructionalButton(2, 329, true))
    SetButtonMessage(GetLabelText("HUD_INPUT27"))
    EndScaleformMovieMethod()
    --

    -- Draw the instruction buttons
    BeginScaleformMovieMethod(Instructional, "DRAW_INSTRUCTIONAL_BUTTONS")
    EndScaleformMovieMethod()
    --

    -- Set the color
    BeginScaleformMovieMethod(Instructional, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(0)
    PushScaleformMovieFunctionParameterInt(80)
    EndScaleformMovieMethod()
    --

    -- Draw the other scaleform.
    DrawScaleformMovieFullscreen(Instructional, 255, 255, 255, 255, 0)

	return deathscale
end



------------
-- Player functions
------------


-- Fade the screen in and out for a teleport, so it's not instant.
-- This was an old function in the previous functions.lua.
-- function FadeScreenForTeleport()
--     local player = GetPlayerPed(-1)
--     -- Test moving this into the thread.
--     DoScreenFadeOut(500)
--     FreezeEntityPosition(player, true)

--     while not IsScreenFadedOut() do
--         Wait(0)
--     end

--     Wait(500)
--     DoScreenFadeIn(500)
--     FreezeEntityPosition(player, false)
-- end

-- TODO Test these.

---comment Get the player position
---@return vector3 A vector3 of the players position
function Player.Coords()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    return playerPos
end

function Player.Heading()
    local player = GetPlayerPed(-1)
    local playerHeading = GetEntityHeading(player)

    return playerHeading
end

function blowupPlayer()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x, y, z = playerPos.x, playerPos.y, playerPos.z

    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehX, vehY, vehZ = GetEntityCoords(vehicle)

        notify("Your car is going to ~r~explode~s~ in 2 seconds.")
        -- Stop the vehicle instantly.
        BringVehicleToHalt(vehicle, 0.1, 1, true)

        -- This didn't seem to work
        ExplodeVehicle(vehicle, true, false)
        -- Just for good measure, you can't escape anymore
        SetVehicleBodyHealth(vehicle, 0)
        SetVehicleWheelHealth(vehicle, 0, 0)
        SetVehicleEngineHealth(vehicle, 0)
        SetVehiclePetrolTankHealth(vehicle, 0)

        -- Disable the vehicle engine
        SetVehicleEngineOn(vehicle, false, true, true)

        Wait(2000)
        -- This kills the player but the car won't blow up
        -- SetVehicleOutOfControl(vehicle, false, true)

        AddOwnedExplosion(player, x, y, z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    else
        notify("You are going to ~r~explode~s~ in 2 seconds.")
        Wait(2000)

        AddOwnedExplosion(player, x, y, z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    end
end

--

------------
-- Message/Notifcation functions
------------

-- function sendMessage(msg)
function Text.SendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

-- function notify(msg)
function Text.Notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

Text.busySpinner = false
function Text.ShowBusySpinner(message)
    if not Text.busySpinner then
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandBusyspinnerOn(5)
        Text.busySpinner = true
    else
        Text.BusyspinnerOff()
        Text.busySpinner = false
    end
end

function Text.HideBusySpinner()
    if Text.busySpinner then
        Text.BusyspinnerOff()
    end
end


------------
-- Math functions
------------



-- https://www.reddit.com/r/Stormworks/comments/srlkyq/lua_decimal_point/
-- This works for stripping the extra digits from the coords
function Truncate(number, decdigits)
    number = number * (10 ^ decdigits)
    number = math.floor(number)
    number = number / (10 ^ decdigits)

    return number
end

------------ 
--- World functions
------------

function World.ClearArea(x, y, z, radius)
    ClearArea(x, y, z, radius, true, false, false, false)
end

---
---
function World.ClearVehiclesInArea(x, y, z, radius)
    ClearAreaOfVehicles(x, y, z, radius, false, false, false, false, false)
end


-- This works
function World.AddExplosion(x, y, z, explosionType, damageScale)
    local player = GetPlayerPed(-1)
    AddOwnedExplosion(player, x, y, z, explosionType, damageScale, true, false, 1.0)
end

------------ 
--- Version functions
------------

-- Check if game build is 3258 or higher, needed for the bounty office
function Version.BountyOfficeVersionCheck()
    local version = GetGameBuildNumber()
    if version >= 3258 then
        return true
    end
    return false
end

function Version.CayoPericoVersionCheck()
    local verison = GetGameBuildNumber()
    local cayoPercio = 2189
    if verison >= cayoPercio then
        return true
    end
    return false
end