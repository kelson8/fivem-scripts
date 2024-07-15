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

-- Tasks
-- TaskHandsUp():

-- Radio
-- SetRadioStationMusicOnly() -- https://nativedb.dotindustries.dev/gta5/natives/0x774BD811F656A122
-- LockRadioStation() -- https://nativedb.dotindustries.dev/gta5/natives/0x477D9DB48F889591
-- SetRadioStationIsVisible()
-- IsRadioStationFavourited()
-- GetPlayerRadioStationGenre() -- https://nativedb.dotindustries.dev/gta5/natives/0xA571991A7FE6CCEB
-- GetPlayerRadioStationIndex() -- https://nativedb.dotindustries.dev/gta5/natives/0xE8AF77C4C06ADC93
-- GetPlayerRadioStationName() -- https://nativedb.dotindustries.dev/gta5/natives/0xF6D733C32076AD03

-- Cops
-- SetCreateRandomCopsOnScenarios(true) -- https://nativedb.dotindustries.dev/gta5/natives/0x444CB7D7DBE6973D
-- SetCreateRandomCopsNotOnScenarios(true) -- https://nativedb.dotindustries.dev/gta5/natives/0x8A4986851C4EF6E7
-- SetCreateRandomCops(true) -- https://nativedb.dotindustries.dev/gta5/natives/0x102E68B2024D536D


-- Clearing area, these could possibly be useful for cleanup of old peds that I play around with or vehicles.
-- ClearAreaOfCops() -- https://nativedb.dotindustries.dev/gta5/natives/0x04F8FC8FCF58F88D
-- ClearAreaOfObjects() -- https://nativedb.dotindustries.dev/gta5/natives/0xDD9B9B385AAC7F5B
-- ClearAreaOfProjectiles() -- https://nativedb.dotindustries.dev/gta5/natives/0x0A1CB9094635D1A6
-- ClearAreaOfVehicles() -- https://nativedb.dotindustries.dev/gta5/natives/0x01C7B9B38428AEB6
-- ClearAngledAreaOfVehicles() --  https://nativedb.dotindustries.dev/gta5/natives/0x11DB3500F042A8AA
-- ClearArea() -- https://nativedb.dotindustries.dev/gta5/natives/0xA56F01F3765B93A0


-- 7-7-2024
-- GetRandomVehicleInSphere()


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

-- exports.ch_messages:Draw3DText()

-- MP Gamer tag functions
-- Not sure how this below one works.
RegisterCommand("test111", function()
    local playerId = GetPlayerPed(-1)
    if IsMpGamerTagActive(playerId) then
        RemoveMpGamerTag(playerId)
        repeat Wait(0) until IsMpGamerTagFree(playerId)
    end

    CreateMpGamerTagWithCrewColor(GetPlayerPed(-1), "", false, true, "", 0, 50, 20, 0)

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

-- Set the player to not be able to enter any vehicle
-- TODO Test this.
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
--     local x_1, y_1, z_1 = 173.63, -819.3, 33.17
--     -- Middle of Los Santos road corner #2
--     local x_2, y_2, z_2 = 225.01, -1059.49, 29.16

--     SetRoadsInArea(x_1, y_1, z_1, x_2, y_2, z_2, false, false)
--     SetAllVehicleGeneratorsActiveInArea(x_1, y_1, z_1, x_2, y_2, z_2, false, true)
--     notify("You have disabled roads the area.")

--     -- Should re-enable it
--     -- SetRoadsInArea(x_1, y_1, z_1, x_2, y_2, z_2, true, false)
-- end)

-- I have moved this to routing bucket 2.
-- This works! I created a basic command that can toggle peds and vehicles on/off using a boolean.
-- local peds = true
-- RegisterCommand("togglepeds", function()
--     if peds then
--         notify("Peds disabled!")
--         peds = false
--     else
--         notify("Peds enabled!")
--         peds = true
--     end
-- end, true)

-- -- Disable the vehicles and peds
-- Citizen.CreateThread(function()
--         while true do
--             if not peds then
--                 SetVehicleDensityMultiplierThisFrame(0.0)
--                 SetPedDensityMultiplierThisFrame(0.0)
--                 Wait(0)
--                 -- Revert back to normal
--             else
--                 -- Taken values from calm-ai config.lua, this will probably override it.
--                 -- I wonder if I can get the values from its config.
--                 SetVehicleDensityMultiplierThisFrame(0.85)
--                 SetPedDensityMultiplierThisFrame(0.75)
--                 Wait(0)
--         end
--     end
-- end)

RegisterCommand("handsup", function()
    local player = GetPlayerPed(-1)
        TaskHandsUp(player, 2000, -1, -1, false)
end)

-- This works
-- TODO Add this to one of my menus, possibly the scaleformUI one
RegisterCommand("getvehicleid", function()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        sendMessage(("Your vehicle entity id is: %s"):format(vehicle, netId))
        -- notify(netId)
    end
end, false)

-- TODO Test this later.
-- RegisterCommand("settargetr", function(_, args)
--     local targetId = tonumber(args[1])
--     -- local targetId = tonumber(args[1])
--     -- local vehicleId = tonumber(args[2])
--     local routingBucket = tonumber(args[2])

--     if IsPedInAnyVehicle(targetId, false) then
--         local vehicle = GetVehiclePedIsIn(targetId, false)
--     end
-- end, true)

-- TODO Figure out how to get vehicle id of other player.
RegisterCommand("setentityr", function(_, args)
    local player = GetPlayerPed(-1)
    -- local entityId = NetworkGetEntityFromNetworkId(tonumber(args[1]))
    local entityId = tonumber(args[1])
    local routingBucket = tonumber(args[2])

    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        if args[1] ~= nil then
            TriggerServerEvent("ch_test:setEntityRtr", entityId, routingBucket)
            sendMessage(("You have set the entity id of entity %s to %s"):format(entityId, routingBucket))
        else
            TriggerServerEvent("ch_test:setEntityRtr", netId, routingBucket)
            sendMessage(("You have set the entity id of your vehicle to %s"):format(netId, routingBucket))
        end
    end
end, true)

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
--         -- SetExplosiveMeleeThisFrame(player)
--         SetExplosiveMeleeThisFrame(PlayerId())
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
