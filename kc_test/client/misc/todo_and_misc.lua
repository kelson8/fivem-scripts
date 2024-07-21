-- This file will not be included in the fxmanifest, it will only contain comments
-- and stuff that I want to play around with.

--[[

-- This looks like it could be fun, set player invincible with ragdoll enabled.
-- SetPlayerInvincibleKeepRagdollEnabled(player)

-- I wonder how this one works.
-- https://pastebin.com/GBnsQ5hr
-- PlayPoliceReport()

-- IsPlayerDrivingDangerously()


    SetPlayerMayNotEnterAnyVehicle()
    SetPlayerMayOnlyEnterThisVehicle()




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


-- Try and play around with routing buckets, those might be fun to screw around with

SetEntityRoutingBucket(entity, bucket)
SetPlayerRoutingBucket(player, bucket)

GetPlayerRoutingBucket(player)
GetEntityRoutingBucket(entity)


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


-- 7-20-2024
-- I wonder how these work?
-- NetworkGetVcBankBalance()
-- NetworkGetVcBalance()

]]
