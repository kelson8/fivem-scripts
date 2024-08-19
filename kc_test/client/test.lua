-- Copyright 2024 kelson8 - FiveM-Scripts GPLV3

-- TODO Rename all events from ch_ to kc_

-- TODO Test exports using this format
local test = {}

function test.HelloPlayer()
    local playerName = GetPlayerName(GetPlayerPed(-1))
    notify(("Hello %s"):format(playerName))
end

function test.IsPlayerConcealed()
    return NetworkIsPlayerConcealed(GetPlayerPed(-1))
end

-- player, toggle, p2 is allowDamagingWhileConcealed
function test.ConcealPlayer()
    if not test.IsPlayerConcealed() then
        NetworkConcealPlayer(GetPlayerPed(-1), true, false)
    end
end

function test.UnconcealPlayer()
    local player = GetPlayerPed(-1)
    if test.IsPlayerConcealed then
        NetworkConcealPlayer(player, false, false)
    end
end

-- Conceal/hide the players when they enter an interior, allow other players to invite them into that area.
function test.SetPlayerInteriorConceal()
    local player = GetPlayerPed(-1)
    if playerId then
        test.ConcealPlayer()
    end
end

function test.UnsetPlayerInteriorConceal()
    local player = GetPlayerPed(-1)
    if player then
        test.UnconcealPlayer()
    end
end

--

-- These conceal commands didn't seem to want to work.
RegisterCommand("conceal", function()
    local player = GetPlayerPed(-1)
    -- test.SetPlayerInteriorConceal()
    if not NetworkIsPlayerConcealed(player) then
        NetworkConcealPlayer(player, true, false)
        sendMessage("You have been concealed.")
    end
end, false)

RegisterCommand("unconceal", function ()
    -- test.UnsetPlayerInteriorConceal()
    if NetworkIsPlayerConcealed(player) then
        NetworkConcealPlayer(player, false, false)
        sendMessage("You have been unconcealed.")
    end

end, false)



-- Phone test (Testing creating and removing a phone like in SP)
-- TODO Fix this to have apps or something on it, like a basic calcuator as a test.
RegisterCommand("cphone", function()
    CreateMobilePhone(0)
    SetMobilePhoneScale(60.0)
    SetMobilePhonePosition(-11.0, 0.0, -11.0)
    -- SetMobilePhonePosition(231.12, -860.9, 33)
end, false)

RegisterCommand("dphone", function()
    DestroyMobilePhone()
end, false)

-- TODO Move this into another file.
function Draw3DText(x, y, z, textInput, fontId, scaleX, scaleY)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1 / dist) * 20
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    SetTextScale(scaleX * scale, scaleY * scale)
    SetTextFont(fontId)
    SetTextProportional(true)
    -- SetTextProportional(1)
    SetTextColour(250, 250, 250, 255) -- You can change the text color here
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(textInput)
    SetDrawOrigin(x, y, z + 2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

----

-- Test

-- Vehicle test

-- Get the seat number the player is in.
-- TODO Figure out how to do this, what i'm doing isn't right.
if TestConfig.TestCommands then
    RegisterCommand("getvehseat", function()
        local player = GetPlayerPed(-1)
        -- if IsPedInAnyVehicle(player, false) then
        --     local vehicle = GetVehiclePedIsIn(player, false)
        --     local vehicleSeat = GetPedInVehicleSeat(player)
        --     notify(("Your current seat: %s"):format(vehicleSeat))
        -- end
        notify(NotImplementedMsg)
    end, false)


    -- RegisterCommand("")
end



-- Fade the screen in and out for a teleport, so it's not instant.
local function FadeScreenForTeleport()
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

-- Some inspiration for this teleport command came from the script here:
-- https://github.com/Re1ease/r1-teleport/blob/final/client/main.lua

-- This command works
RegisterCommand("tppos", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local x, y, z = args[1], args[2], args[3]

    if x ~= nil and y ~= nil and z ~= nil then
        -- Set the player and vehicle coords if in a vehicle
        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            -- Fade the screen before teleport
            FadeScreenForTeleport()
            -- Set the vehicle and player coords, this seems to set it for both.
            SetEntityCoords(vehicle, tonumber(x), tonumber(y), tonumber(z), true, false, false, false)
            -- Notify the player
            notify(("Teleported to X: %s Y: %s Z: %s"):format(x, y, z))
        else
            -- Fade the screen before teleport
            FadeScreenForTeleport()
            -- Set just the player coords if not in a vehicle
            SetEntityCoords(player, tonumber(x), tonumber(y), tonumber(z), true, false, false, false)
            notify(("Teleported to X: %s Y: %s Z: %s"):format(x, y, z))
        end


        -- SetEntityCoords(player, tonumber(x), tonumber(y), tonumber(z), true, false, false, false)
    end
end, false)


RegisterCommand("moneytest", function()
    -- local networkBalance = NetworkGetVcBalance(GetPlayerPed(-1))
    -- local hasMoney = NetworkCanSpendFromBank(2000)
    -- local hasMoney = NetworkGetCanSpendFromWallet(2000, GetPlayerPed(-1))
    -- if hasMoney then
    --     notify("You have $2000!")
    -- end

    -- TODO Figure out how to add money into the Money_Script resource.
    -- Also hook into the money script with MySql and attempt to give players money for certain tasks.

    -- notify(networkBalance)
end, false)

-- Copied blip values from ped_test.lua

-- TODO Fix this to get the z coord.
-- This works but doesn't always seem to get the z coord
RegisterCommand("tpmarker", function()
    local player = GetPlayerPed(-1)
    local blip = GetFirstBlipInfoId(8)
    local blipX = 0.0
    local blipY = 0.0

    local zGround = nil

    -- Test
    local blipZ = 0.0

    if (blip ~= 0) then
        local coord = GetBlipCoords(blip)
        blipX = coord.x
        blipY = coord.y
        blipZ = coord.z

        -- This should be able to get the Z Coord once I have it setup.
        -- This just says invalid native, I'm not running it on the server so idk why.
        -- if not zGround then
        -- blipZ = GetGroundZFor3dCoord(coord.x, coord.y, coord.z, 9999, false, false)
        -- end

        if IsPedInAnyVehicle(player, false) then
            local vehicle = GetVehiclePedIsIn(player, false)
            FadeScreenForTeleport()
            SetEntityCoords(vehicle, blipX, blipY, blipZ, true, false, false, false)
        else
            FadeScreenForTeleport()
            SetEntityCoords(player, blipX, blipY, blipZ, true, false, false, false)
        end
    end
end, false)

-- These are tests, remove them later.
RegisterCommand("fadeinscreen", function()
    local player = GetPlayerPed(-1)
    DoScreenFadeIn(500)
end, false)

-- Setup killing the player for not being in a certain area
-- Citizen.CreateThread(function()
--     while true do
--         Wait(5)
--         if IsPedInArea
--     end
-- end)



-- This almost works! It sometimes doesn't fade back in.. Hmm
-- Citizen.CreateThread(function()
-- while true do
-- Wait(5)
-- if activateTeleport then
-- Wait(1500)
-- -- Fade the screen for one second.
-- DoScreenFadeOut(1000)

-- while not isScreenFadedOut() do
--     Wait(0)
-- end

-- -- Set this to teleport the player after a fade out
-- DoScreenFadeIn(1000)
-- end

-- end
-- end)

-- exports.ch_messages:Draw3DText()

-- MP Gamer tag functions
-- Not sure how this below one works.

function test.SetGamerTag()
    local playerId = GetPlayerPed(-1)
    if IsMpGamerTagActive(playerId) then
        RemoveMpGamerTag(playerId)
        repeat Wait(0) until IsMpGamerTagFree(playerId)
    end

    local gamerTagId = CreateMpGamerTagWithCrewColor(GetPlayerPed(-1), "", false, true, "", 0, 50, 20, 0)

    -- set the name, crew and typing indicator components as visible
    -- https://docs.fivem.net/docs/game-references/gamer-tags/
    SetMpGamerTagVisibility(gamerTagId, 0, true)
    SetMpGamerTagVisibility(gamerTagId, 1, true)
    SetMpGamerTagVisibility(gamerTagId, 16, true)
    -- SetMpGamerTagVisibility(playerId, 0, true)
    -- SetMpGamerTagVisibility(playerId, 1, true)
    -- SetMpGamerTagVisibility(playerId, 16, true)
end

RegisterCommand("crewtagtest", function()

    -- Run the above function, I don't know if it'll work like this.
    test.SetGamerTag()
end, false)

-- Ped functions

-- Get the current health of the ped
-- GetEntityHealth()

-- Radio Functions

RegisterCommand("getradio", function(source, args, rawCommand)
    -- Yes this works for getting the current playing radio station.
    notify(GetRadioStationName(GetPlayerRadioStationIndex()))

    -- This didn't seem to work, kept showing the same radio station name.
    -- notify(GetRadioStationName())

    -- Test if radio is active.
    -- This shows the radio number but doesn't reset if it is turned off.
    -- notify(GetPlayerRadioStationIndex())

    -- Playing around with getting the police radio to show up on here.
    -- PlayPoliceReport("LAMAR_1_POLICE_LOST", 0)
end, false)

-- This is supposed to show the radio track playtime but I don't think it tracks properly.
RegisterCommand("radiotime", function()
    -- This should convert the time into seconds
    notify(GetCurrentRadioTrackPlaybackTime(
        GetRadioStationName(GetPlayerRadioStationIndex())) / 1000)
end, false)

-- Adds a portable radio to the game.
-- 3-27-2024 @ 3:07PM
-- Source to below code:
-- https://github.com/FAXES/MobileRadio/blob/master/client.lua
RegisterCommand("radio", function(source, args, rawCommand)
    TriggerEvent("ch_test:ToggleMobileRadio")
end, false)

RegisterNetEvent("ch_test:ToggleMobileRadio")
AddEventHandler("ch_test:ToggleMobileRadio", function()
    if IsMobilePhoneRadioActive() then
        SetMobilePhoneRadioState(false)
        SetMobileRadioEnabledDuringGameplay(false)
        notify("Radio disabled")
        -- I don't think these are needed.
        -- SetAudioFlag("MobileRadioInGame", 0)
        -- SetAudioFlag("AllowRadioDuringSwitch", 0)
    else
        SetMobilePhoneRadioState(true)
        SetMobileRadioEnabledDuringGameplay(true)
        notify("Radio enabled")
        -- I don't think these are needed.
        -- SetAudioFlag("MobileRadioInGame", 1)
        -- SetAudioFlag("AllowRadioDuringSwitch", 1)
    end
end)

-- Skip radio forward
-- 3-27-2024 @ 3:07PM
-- This doesn't seem to work like this.
RegisterCommand("skipradio", function()
    if GetPlayerPed(-1) then
        -- if not IsPedInVehicle then
        --     SkipRadioForward()
        -- else
        -- notify("Not implemented in vehicles!")
        -- end
        SkipRadioForward()
    end
end, false)

RegisterCommand("toggletraffic", function()
    -- Not sure how to set this up yet.
    -- if GetVehicleDensityMultiplier() == 0.0 then

    -- end
end, true)

-- Set the player to not be able to enter any vehicle
-- This didn't seem to do anything.
RegisterCommand("novehicleenter", function()
    local player = GetPlayerPed(-1)
    SetPlayerMayNotEnterAnyVehicle(player)
    -- This one might be fun to screw with,
    -- SetPlayerMayOnlyEnterThisVehicle()
end)

-- Spawn a car on the tracks
-- This didn't work
-- TODO Setup this to spawn a car on the tracks so a train can hit it.
-- function spawnCarOnTracks()
--     local car = GetHashKey("dominator")

--     -- Check if the vehicle actually exists
--     if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

--     -- Load the model
--     RequestModel(vehicleName)

--     -- If model hasn't loaded, wait on it.
--     while not HasModelLoaded(vehicleName) do
--         Wait(500)
--     end
--     SetModelAsNoLongerNeeded(car)

--     CreateVehicle(car, 2663.38, 291.77, 96.62, 85.31, true, false)
--     -- CreateVehicle("zentorno", 2663.38, 291.77, 94.62, 85.31, true, false)
-- end
-- spawnCarOnTracks()

-- /mstoseconds 2000 [1]

-- This didn't work like this
-- RegisterCommand("mstoseconds", function(_, args, rawCommand)
--     if args[1] ~= nil then
--         if type(args[1]) == "number" then
--             notify(convertMsToSeconds(args[1]))
--         else
--             notify("You need a number for this!")
--         end
--     else
--         notify("You didn't enter any arguments!")
--     end
-- end, false)

-- https://forum.cfx.re/t/disable-traffic-in-certain-area/1380615
-- This doesn't seem to work.

-- TODO Mess around with this and try to get it working.
-- RegisterCommand("toggleroads1", function()
--     local player = GetPlayerPed(-1)
--     local playerCoords = GetEntityCoords(player)
--     -- local x_1, y_1, z_1 = table.unpack(playerCoords)

--     -- Middle of Los Santos road corner #1
--     local x_1, y_1, z_1 = -314.98, -836.38, 29.10
--     -- Middle of Los Santos road corner #2
--     -- local x_2, y_2, z_2 = 83.66, -1013.66, 33.10
--     local x_2, y_2, z_2 = 263.53, -874.63, 33.10

--     SetRoadsInArea(x_1, y_1, z_1, x_2, y_2, z_2, false, false)
--     SetAllVehicleGeneratorsActiveInArea(x_1, y_1, z_1, x_2, y_2, z_2, false, true)
--     notify("You have disabled roads the area.")

--     -- Should re-enable it
--     -- SetRoadsInArea(x_1, y_1, z_1, x_2, y_2, z_2, true, false)
-- end)

-- I added this handsup command and the get vehicle id command to my ScaleformUI Test menu.

RegisterCommand("handsup", function()
    local player = GetPlayerPed(-1)
    TaskHandsUp(player, 2000, -1, -1, false)
end)

-- This works
RegisterCommand("getvehicleid", function()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        sendMessage(("Your vehicle entity id is: %s"):format(vehicle, netId))
        -- notify(netId)
    end
end, false)

-- Ping
-- https://www.youtube.com/watch?v=_R6dK32bE8M&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=12

-- This didn't work.
-- RegisterNetEvent("ch_test:returnPing")
-- AddEventHandler("ch_test:returnPing", function(ping)
--     pingNumber = ping
-- end)


-- RegisterCommand("ping", function()
--     TriggerServerEvent("ch_test:ping")
--     notify("Current ping: " .. pingNumber)
-- end, false)

-- Enable explosive melee and weapons
-- This didn't work.
-- Citizen.CreateThread(function()
--     local player = GetPlayerPed(-1)
--     while true do
--         Wait(1)
--         SetExplosiveAmmoThisFrame(player)
--         SetExplosiveMeleeThisFrame(player)
--     end
-- end)

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- This did nothing

-- Start gps multi route: https://docs.fivem.net/natives/?_0x3D3D15AF7BCAAF83
-- Add point to gps multi route: https://docs.fivem.net/natives/?_0xA905192A6781C41B
-- RegisterCommand("setmarker", function()
--     StartGpsMultiRoute(1, true, false)
--     SetGpsMultiRouteRender(true, 16, 16)

--     notify("Marker set!")
-- end)

-- RegisterCommand("addtomarker", function()
--     -- Add option for custom coords such as clicking an area on the map,
--     -- Or on the player position
--     posX, posY, posZ = GetEntityCoords(PlayerId())
--     AddPointToGpsMultiRoute(posX, posY, posZ)

--     notify("You added your coords to the current marker!")
-- end)


-- TODO Test these.
RegisterCommand("onlineversion", function()
    sendMessage("Your GTA Online version: " .. GetOnlineVersion())
end, false)

RegisterCommand("clearmarker", function()
    local player = GetPlayerPed(-1)
end, false)

RegisterCommand("snow", function(source, args, rawCommand)
    if args[1] ~=nil then
        SetSnow(args[1])
    end
end, false)

RegisterCommand("strongwinds", function()
    SetWind(1.0)
    SetWindSpeed(11.99)
    SetWindDirection(2.92)
end, false)

RegisterCommand("lightning", function()
    ForceLightningFlash()
end, false)
