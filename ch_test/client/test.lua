-- This looks like it could be fun, set player invincible with ragdoll enabled.
-- SetPlayerInvincibleKeepRagdollEnabled(player)

-- I wonder how this one works.
-- https://pastebin.com/GBnsQ5hr
-- PlayPoliceReport()

-- IsPlayerDrivingDangerously()

--[[
    SetPlayerMayNotEnterAnyVehicle()
    SetPlayerMayOnlyEnterThisVehicle()
]]


--[[
Try and see how these work
https://docs.fivem.net/natives/?_0x332169F5
GetAllVehicles()

https://docs.fivem.net/natives/?_0xD7531645
GetAllVehicleModels()

https://docs.fivem.net/natives/?_0x1647F1CB
GetEntityCoords()

https://docs.fivem.net/natives/?_0xE41CA53051197A27
IsBlipOnMinimap(blip)

https://docs.fivem.net/natives/?_0xA4E8E696C532FBC7
CreateMobilePhone(0-4)
]]

-- Try and play around with routing buckets, those might be fun to screw around with
--[[
SetEntityRoutingBucket(entity, bucket)
SetPlayerRoutingBucket(player, bucket)

GetPlayerRoutingBucket(player)
GetEntityRoutingBucket(entity)
]]

-----
-- 3-27-2024 @ 3:15PM
-- Todo Setup some other test functions later
-- Fix skipping radio to work.
-- Add toggle mobile radio to my gui.
-- Add option for enabling and disabling radio in vehicles.
-- Add option to blow up all vehicles nearby.

-- Other testing functions
-- DrawTvChannel() -- https://docs.fivem.net/natives/?_0xFDDC2B4ED3C69DF0

-- OnEnterMp (Enable multiplayer maps in singleplayer) -- https://docs.fivem.net/natives/?_0x0888C3502DBBEEF5
-- OnEnterSp (Disable multiplayer maps in singleplayer) -- https://docs.fivem.net/natives/?_0xD7C10C4A637992C9
----

----
--
-- 3-28-2024 @ 2:38AM

-- All IPLs and interior locations: https://wiki.rage.mp/index.php?title=Interiors_and_Locations

-- Get entity and interior offsets
-- Looks like this one takes an offset, is that to the player?
-- Entity, X, Y, Z -- possibly offset from the current player.
-- GetOffsetFromEntityInWorldCoords() -- https://docs.fivem.net/natives/?_0x1899F328B0E12848

-- Regular coords
-- Entity, X, Y, Z
-- GetOffsetFromEntityGivenWorldCoords() -- https://docs.fivem.net/natives/?_0x2274BC1C4885E333

-- Interior coords? Not sure what this one is for.
-- Interior, X, Y, Z
-- GetOffsetFromInteriorInWorldCoords() -- https://docs.fivem.net/natives/?_0x9E3B3E6D66F6E22F

-- Possibly try to add garages and make the doors open
-- https://gtahash.ru/?s=garage
-- Use this garage id: hei_prop_ss1_mpint_garage2

-- Trains
--CreateMissionTrain() -- https://docs.fivem.net/natives/?_0x63C6CCA8E68AE8C8
-- SetRandomTrains(true) -- https://docs.fivem.net/natives/?_0x80D9F74197EA47D9

-- Train resource: https://github.com/LexTheGreat/TrainSportation
----

---- 
--
-- 3-28-2024 @ 4:15AM
-- Possibly add respawn points:
-- AddHospitalRestart(x,y,z) -- https://docs.fivem.net/natives/?_0x1F464EF988465A81
-- AddPoliceRestart(x,y,z) -- https://docs.fivem.net/natives/?_0x452736765B31FC4B

-- Disable hospital and police respawns (Place the player back where they died if all are disabled)
-- DisableHospitalRestart() -- https://docs.fivem.net/natives/?_0xC8535819C450EBA8
-- DisablePoliceRestart() -- https://docs.fivem.net/natives/?_0x23285DED6EBD7EA3

-- Patrol routes? Possibly like a security guard patrolling an area.
-- This looks like it would be set multiple times and the "PatrolRouteLink" links them together.
-- AddPatrolRouteNode() -- https://docs.fivem.net/natives/?_0x8EDF950167586B7C

-- AddPatrolRouteLink() -- https://docs.fivem.net/natives/?_0x23083260DEC3A551

----

----
--
-- 3-28-2024 @ 3:04PM
-- Vehicles
-- Handling
-- SetVehicleHandlingInt() -- https://docs.fivem.net/natives/?_0xC37F4CF9
-- SetVehicleHandlingField() -- https://docs.fivem.net/natives/?_0x2BA40795
-- SetVehicleHandlingHashForAi() --
-- SetVehicleHandlingInt() -- https://docs.fivem.net/natives/?_0xC37F4CF9
-- SetVehicleHandlingVector() -- https://docs.fivem.net/natives/?_0x12497890
-- SetVehicleHandlingFloat() -- https://docs.fivem.net/natives/?_0x488C86D2

-- Search light for helicopters:
-- DoesVehicleHaveSearchlight() -- https://docs.fivem.net/natives/?_0x99015ED7DBEA5113
-- SetVehicleSearchlight(heli, true, true) -- https://docs.fivem.net/natives/?_0x14E85C5EE7A4D542
-- IsVehicleSearchlightOn() -- https://docs.fivem.net/natives/?_0xC0F97FCE55094987

-- Music functions
-- GetMusicPlaytime()

----

----
--
-- 3-29-2024 @ 8:52AM
-- Other misc test

-- Plane functions
-- TaskPlaneChase()
-- TaskPlaneLand()

-- Possibly a way to make a ped auto pilot a plane?
-- TaskPlaneMission() -- https://docs.fivem.net/natives/?_0x23703CD154E83B88

-- Vehicle
-- TaskEveryoneLeaveVehicle() -- https://docs.fivem.net/natives/?_0xC1971F30
-- TaskLeaveAnyVehicle() -- https://docs.fivem.net/natives/?_0xDBDD79FA
-- TaskLeaveVehicle() -- https://docs.fivem.net/natives/?_0x7B1141C6

-- Ped
-- TaskGoStraightToCoord() -- https://docs.fivem.net/natives/?_0x80A9E7A7
-- TaskGoToCoordAnyMeans() -- https://docs.fivem.net/natives/?_0xF91DF93B
-- TaskGoToEntity() -- https://docs.fivem.net/natives/?_0x374827C2

-- TaskHandsUp() -- https://docs.fivem.net/natives/?_0x8DCC19C5

-- TaskPatrol() -- https://docs.fivem.net/natives/?_0xBDA5DF49D080FE4E
-- Possibly something to do with the patrol routes I have above somewhere.
-- OpenPatrolRoute() -- https://docs.fivem.net/natives/?_0xBDA5DF49D080FE4E
----

-- Patrol route test
-- Todo Figure out how this works sometime.
-- function SecurityRoute1()
    -- This is in the military base.
    -- AddPatrolRouteNode(1, "", -2207.33, 3282.05, 33.5, -2201.06, 3263.41, 32.81)
    -- AddPatrolRouteLink()
-- end

-- 7-3-2024
-- GetLastRammedVehicle(): 
-- GetLastDrivenVehicle(): https://nativedb.dotindustries.dev/gta5/natives/0xB2D06FAEDE65B577 
-- GetLastPedInVehicleSeat(): https://nativedb.dotindustries.dev/gta5/natives/0x83F969AA1EE2A664
-- This could be useful: https://docs.fivem.net/docs/scripting-manual/networking/ids/

-- 7-4-2024
-- IsPedShootingInArea(): https://nativedb.dotindustries.dev/gta5/natives/0x7E9DFE24AC1E58EF
-- IsAnyPedShootingInArea(): https://nativedb.dotindustries.dev/gta5/natives/0xA0D3D71EA1086C55
-- IsPedShooting(): https://nativedb.dotindustries.dev/gta5/natives/0x34616828CD07F1A1


-- 7-6-2024
-- TODO Setup some kind of job invite system like in GTA Online 
--  whenever I learn more and how to create missions and stuff.

-- SetVehicleGravityAmount():  https://nativedb.dotindustries.dev/gta5/natives/0x89F149B6131E57DA
-- SetVehicleKersAllowed(): https://nativedb.dotindustries.dev/gta5/natives/0x99C82F8A139F3E4E

-- These could be fun
-- Plane and helicopter
-- TaskPlaneChase(): https://nativedb.dotindustries.dev/gta5/natives/0x2D2386F273FF7A25
-- TaskPlaneLand(): https://nativedb.dotindustries.dev/gta5/natives/0xBF19721FA34D32C0
-- TaskPlaneTaxi()
-- TaskHeliChase(): https://nativedb.dotindustries.dev/gta5/natives/0xAC83B1DB38D0ADA0

-- Other
-- TaskHandsUp()


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

-- Will this work?
-- This didn't seem to work :\
RegisterCommand("addblip", function()
    local player = getPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerx = playerCoords.x
    local playery = playerCoords.y
    local playerz = playerCoords.z

    local destination1 = AddBlipForCoord(117.38, -811.85, 30.43)
    -- AddBlipForCoord(playerx, playery + 10, playerz)
    
end, false)

----

---- Hologram test (This seems to work, puts text on the map but I haven't figured out how to get this to display health on a ped.)
-- Todo Setup this to work on the spawnped function to show the health above the ped.
-- I'm not exactly sure how to do that yet.
-- Source link: https://github.com/Vortex-z/Holograms-Floating-Text/blob/master/holograms/holograms.lua
Citizen.CreateThread(function()

    -- holograms()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    local x,y,z = table.unpack(playerCoords)
    -- holograms(x,y,z)


    -- holoTest()
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

    while true do
        Citizen.Wait(0)
        -- if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then
        -- Will this still work? I fixed the errors in vscode.
        if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, x, y, z, false) < 10.0 then
        -- if GetDistanceBetweenCoords(ped_x, ped_y, ped_z, x, y, z) < 10.0 then
            Draw3DText(ped_x, ped_y, ped_z , "Mother fucker", 4, 0.1, 0.1)
        end
    end
end


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(true)
    -- SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)		-- You can change the text color here
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
   end

----

-- MP Gamer tag functions
-- Not sure how this below one works.
RegisterCommand("test111", function()
    local playerId = GetPlayerPed(-1)
    if IsMpGamerTagActive(playerId) then
        RemoveMpGamerTag(playerId)
        repeat Wait(0) until IsMpGamerTagFree(playerId)
    end

    CreateMpGamerTagWithCrewColor(GetPlayerPed(-1), "Mother_Fucker", false, true, "Bastards", 0, 50, 20, 0)

    -- set the name, crew and typing indicator components as visible
    SetMpGamerTagVisibility(playerId, 0, true)
    SetMpGamerTagVisibility(playerId, 1, true)
    SetMpGamerTagVisibility(playerId, 16, true)
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
        GetRadioStationName(GetPlayerRadioStationIndex()) ) / 1000 )
end, false)

-- Adds a portable radio to the game.
-- 3-27-2024 @ 3:07PM
-- Source to below code:
-- https://github.com/FAXES/MobileRadio/blob/master/client.lua
RegisterCommand("radio", function(source, args, rawCommand)
    TriggerEvent("ch_test:ToggleMobileRadio")
end, false)

RegisterNetEvent("ch_test:ToggleMobileRadio")
AddEventHandler("ch_test:ToggleMobileRadio", function ()
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


-- Disable the vehicles and peds
-- 
-- Citizen.CreateThread(function()
--     while true do
--         SetVehicleDensityMultiplierThisFrame(0.0)
--         SetPedDensityMultiplierThisFrame(0.0)
--         Wait(0)
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