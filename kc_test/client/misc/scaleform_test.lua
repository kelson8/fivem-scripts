-- Test
-- https://docs.fivem.net/docs/scripting-manual/using-scaleform/

-- RegisterCommand("testscaleform", function()
--     -- Test this
--     RequestScaleformMovie("ORBITAL_CANNON_SCALEFORM_BS_COUNTDOWN_0")

--     DrawScaleformMovie("")
-- end)

-- This works for toggling the scaleform on/off
-- local drawScaleform = false
-- TODO Make this to where it hides the hud also.
RegisterCommand("togglesc", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    if not drawScaleform then
        notify("You have enabled the scaleform.")
        drawScaleform = true
        -- hidehud = true
    else
        notify("You have disabled the scaleform.")
        drawScaleform = false
        -- hidehud = false
    end
end, true)


-- local scaleformTable = {
--     orbitalCannonScaleform1 = "ORBITAL_CANNON_CAM"
-- }


-- local function scaleformList()
    -- openingCreditsScaleform = "OPENING_CREDITS"
-- end



-- Scaleforms
local function socialClub2ScaleformFn(scaleformHandle)
    -- I couldn't get these to work
    BeginScaleformMovieMethod(scaleformHandle, "SET_ONLINE_POLICY_TEXT")
    PushScaleformMovieFunctionParameterString("Hello Player") -- policy
    EndScaleformMovieMethod()


    BeginScaleformMovieMethod(scaleformHandle, "SET_ONLINE_POLICY_TITLE")
    PushScaleformMovieFunctionParameterString("Test") -- Title
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleformHandle, "SET_ONLINE_POLICY_TEXT")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleformHandle, "SET_ONLINE_POLICY_TEXT")
    EndScaleformMovieMethod()

    BeginScaleformMovieMethod(scaleformHandle, "SET_ONLINE_POLICY_TEXT")

    EndScaleformMovieMethod()

    PushScaleformMovieFunction("DISPLAY_ONLINE_POLICY")
end

local function rockstarVerifiedScaleformFn(scaleformHandle)
     -- This one didn't work.
    BeginScaleformMovieMethod(scaleformHandle, "ROCKSTAR_VERIFIED")
    EndScaleformMovieMethod()
end

local function popupWarningScaleformFn(scaleformHandle)
    BeginScaleformMovieMethod(scaleformHandle, "SHOW_POPUP_WARNING")
    PushScaleformMovieFunctionParameterInt(2000) -- miliseconds
    PushScaleformMovieFunctionParameterString("Hello Player") -- titleMsg
    PushScaleformMovieFunctionParameterString("You are going to die.") -- warningMsg
    PushScaleformMovieFunctionParameterString("... Don't test me.") -- promptMsg
    PushScaleformMovieFunctionParameterBool(false) -- showBackground
    PushScaleformMovieFunctionParameterString("?") -- alertType
    PushScaleformMovieFunctionParameterString("....") -- errorMsg

    EndScaleformMovieMethod()
end

local function loadingScreenScaleform(scaleformHandle)
    -- Shows the gta 5 loading screen with the girl on it
        BeginScaleformMovieMethod(scaleformHandle, "INSTALL") -- The function you want to call from the AS file
        EndScaleformMovieMethod()

        -- Shows a blank install message in bottom right.
        BeginScaleformMovieMethod(scaleformHandle, "TEST_INSTALL") -- The function you want to call from the AS file
        EndScaleformMovieMethod()
end

local function onlinePoliciesScaleformFn(scaleformHandle)
        -- Terms of service page: DISPLAY_TOS
        -- Eula page: DISPLAY_EULA
        -- Privacy policy page: DISPLAY_PP
        BeginScaleformMovieMethod(scaleformHandle, "DISPLAY_EULA")

        -- PushScaleformMovieFunctionParameterString("Test")
        -- ScaleformMovieMethodAddParamLiteralString("Test")
        EndScaleformMovieMethod()

        BeginScaleformMovieMethod(scaleformHandle, "SET_POLICY_TEXT")
        PushScaleformMovieFunctionParameterString("No messing with people that don't want to be messed with.")

        EndScaleformMovieMethod()
end

local function loadingBarScaleform(scaleformHandle)
    BeginScaleformMovieMethod(scaleformHandle, "SET_PROGRESS_BAR") -- The function you want to call from the AS file
    PushScaleformMovieMethodParameterInt(50)
    EndScaleformMovieMethod()
end

local function wastedMessageScaleformFn(scaleformHandle)
        BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file
        PushScaleformMovieMethodParameterString("Wasted")                     -- bigTxt
        -- PushScaleformMovieMethodParameterInt()                                    -- colId
        EndScaleformMovieMethod()                                               -- Finish off the scaleform, it returns no data, so doesnt need "EndScaleformMovieMethodReturn"
end

local function secureServeScaleformFn(scaleformHandle)
    -- Possibly make the securoservScaleform show a login.
    CallScaleformMovieMethod(scaleformHandle, "SET_PLAYER_DATA")
    -- PushScaleformmoviemethod

    BeginScaleformMovieMethod(scaleformHandle, "OVERVIEW_BACKGROUND") -- The function you want to call from the AS file
    BeginScaleformMovieMethod(scaleformHandle, "SET_ZOOM_LEVEL") -- The function you want to call from the AS file
    BeginScaleformMovieMethod(scaleformHandle, "SHOW_SHARD_WASTED_MP_MESSAGE") -- The function you want to call from the AS file

end

-- https://vespura.com/fivem/scaleform/#ORBITAL_CANNON_CAM

Citizen.CreateThread(function()
    -- local scaleformHandle = RequestScaleformMovie("ORBITAL_CANNON_SCALEFORM_BS_COUNTDOWN_0") -- The scaleform you want to use

    -- local drawScaleform = true
    -- The ones that have custom parameters will have a toggle for now.

    -- All of these can be found on this site: https://vespura.com/fivem/scaleform/
    -- local hideHud = false
    local orbitalCannonScaleform1 = "ORBITAL_CANNON_CAM"

    -- This seems to show the orbital cannon map.
    local orbitalCannonScaleform2 = "ORBITAL_CANNON_MAP"

    local overViewScaleform1 = "OVERVIEW_BACKGROUND"
    local partyBusScaleform = "PARTY_BUS"
    local pauseMenuAwardsScaleform = "PAUSE_MENU_AWARDS"
    local gtaOnlineLogoScaleform = "GTAV_ONLINE"
    local slotMachineScaleform = "SLOT_MACHINE"

    -- Seems to be what they use for the security cameras in online.
    local securityCamScaleform = "SECURITY_CAM"
    local securityCameraScaleform = "SECURITY_CAMERA"

    local rankupScaleform = "FEED_CREW_RANKUP"
    -- This can show the back and escape buttons on screen, I could use this for something else.
    local instructionalButtonsScaleform = "INSTRUCTIONAL_BUTTONS"

    -- Shows a Posonboys clothes shop icon https://vespura.com/fivem/scaleform/#SHOP_MENU
    local shopMenuScaleform = "SHOP_MENU"
    local shopMenuDlcScaleform = "SHOP_MENU_DLC"

    ------------------
    -- Loading screens and landing pages
    ------------------

    -- Didn't work.
    local landingpageScaleform = "LANDING_PAGE"

    -------------
    -- Custom menu options with toggles.
    -------------

    -- Make sure not to have multiple of the toggles enabled or it might crash.

    -- Shows the GTA 5 Logo in the bottom left
    local loadingScreenNewGameScaleform = "LOADINGSCREEN_NEWGAME"
    local loadingBarEnabled = true
    -- Doesn't seem to do anything
    local loadingScreenStartupScaleform = "LOADINGSCREEN_STARTUP"
    local loadingScreenStartupEnabled = false -- loadingScreenStartupScaleform

    local onlinePoliciesScaleform = "ONLINE_POLICIES"
    local onlinePoliciesEnabled = false

    -- These below didn't work
    local popupWarningScaleform = "POPUP_WARNING"
    local popupWarningEnabled = false

    local rockstarVerifiedScaleform = "ROCKSTAR_VERIFIED"
    local rockstarVerifiedEnabled = false

    -- Shows the securo serv login.
    local securoservScaleform = "SECUROSERV"
    local securoservScaleformEnabled = false

    local wastedMessageScaleform = "mp_big_message_freemode"
    local wastedMessageEnabled = false

    ----

    --
    -- I couldn't get this one working
    local openingCreditsScaleform = "OPENING_CREDITS"


    -- Test these
    local rpIconScaleform = "RP_ICON"

    local bikerMissionWallScaleform = "BIKER_MISSION_WALL"
    local cellphoneBadgerScaleform = "CELLPHONE_BADGER"
    --

    -- This seems to work.
    local socialClub2Scaleform = "SOCIAL_CLUB2"
    local socialClub2Enabled = false

    ------------------
    --
    ------------------

    -- scaleformTable[1]
    -- I wonder how to set this one up, I could use the decompiled scripts as a reference.
    -- if scaleformTable.orbitalCannonScaleform1 then

    -- end

    -- local scaleformHandle = RequestScaleformMovie(overViewScaleform1) -- The scaleform you want to use
    -- local scaleformHandle = RequestScaleformMovie("GTAV_ONLINE") -- The scaleform you want to use
    -- local scaleformHandle = RequestScaleformMovie(bigMessageScaleform) -- The scaleform you want to use

    -- local scaleformHandle = RequestScaleformMovie(loadingScreenNewGameScaleform) -- The scaleform you want to use
    -- local scaleformHandle = RequestScaleformMovie(onlinePoliciesScaleform) -- The scaleform you want to use


    local scaleformHandle = RequestScaleformMovie(loadingScreenNewGameScaleform) -- The scaleform you want to use
    -- Make it to where it waits on the Scaleform to load up.
    while not HasScaleformMovieLoaded(scaleformHandle) do                    -- Ensure the scaleform is actually loaded before using
        Citizen.Wait(0)
    end


    ------------------
    -- Toggles
    ------------------
    if socialClub2Enabled then
        socialClub2ScaleformFn(scaleformHandle)
    end

    -- This one didn't work.
    if rockstarVerifiedEnabled then
        rockstarVerifiedScaleformFn(scaleformHandle)
    end

    if popupWarningEnabled then
        popupWarningScaleformFn(scaleformHandle)
    end

    if loadingScreenStartupEnabled then
        loadingScreenScaleform()
    end

    if onlinePoliciesEnabled then
        onlinePoliciesScaleformFn(scaleformHandle)
    end

    -- Sets a loading screen progress bar for the loadingScreenNewGameScaleform.
    if loadingBarEnabled then -- loadingScreenNewGameScaleform
        loadingBarScaleform(scaleformHandle)
    end

    -- Wasted message
    if wastedMessageEnabled then
        wastedMessageScaleformFn(scaleformHandle)
    end

    -- Show the SecureoServ login.
    if securoservScaleformEnabled then
        secureServeScaleformFn(scaleformHandle)
    end

    ------------------
    --
    ------------------

    while true do     -- Draw the scaleform every frame
        Citizen.Wait(0)

        -- https://forum.cfx.re/t/how-to-hide-gta-5-default-hud/4239563
        -- Hide the map and everything if specified.
        if hideHud then
            HideHudAndRadarThisFrame()
        end

        if drawScaleform then
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255) -- Draw the scaleform fullscreen
            -- DrawScaleformMovie(scaleformHandle, 100.2, 100.2, 20, 20, 255, 50, 50, 50, 20)
            -- DrawScaleformMovie(scaleformHandle, 896.44, 25.45, 20, 20, 255, 50, 50, 50, 20)
        end
    end
end)

