-- There was too much in the other file

local drawScaleform = false

-- Add debug messages for testing
local debugMode = true

-- Print events to the console
-- https://docs.fivem.net/docs/scripting-reference/events/list/gameEventTriggered/
local logEvents = false

-- Define ped net ids as nil, they get assigned on the spawn commands
sharkPedNetId = nil
local plane1 = nil

-- Driving styles: https://gtaforums.com/topic/822314-guide-driving-styles/
local drivingStyleNormal = 786603
local drivingStyleRushed = 1074528293
local drivingStyleIgnoreLights = 2883621
-- Random driving style
local drivingStyleTest1 = 8388614

-- Ped relationship hashes:
-- https://gist.github.com/ghermans/30b7e578fca2494b20616f8d4725d05c

-- Todo Look into this
-- 8-8-2024 @ 4:22AM
--
-- SetRadioStationMusicOnly()
-- SetRadioStationAsFavourite()


-- Todo Spawn a shark as a test



-- while IsPedJacking(GetPlayerPed(-1)) do
-- TODO Fix this to work.
-- if chaosMode then
--
-- while IsPedGettingIntoAVehicle(GetPlayerPed(-1)) do
--     notify("You are going to die.")
-- Blow the player up.
--     Wait(1000)
-- end

-- end

--[[
enum DispatchType
{
    -- List of these services on this link
    -- https://alloc8or.re/gta5/doc/enums/DispatchType.txt
	DT_Invalid,
	DT_PoliceAutomobile,
	DT_PoliceHelicopter,
	DT_FireDepartment,
	DT_SwatAutomobile,
	DT_AmbulanceDepartment,
	DT_PoliceRiders,
	DT_PoliceVehicleRequest,
	DT_PoliceRoadBlock,
	DT_PoliceAutomobileWaitPulledOver,
	DT_PoliceAutomobileWaitCruising,
	DT_Gangs,
	DT_SwatHelicopter,
	DT_PoliceBoat,
	DT_ArmyVehicle,
	DT_BikerBackup
};
]]

--------
-- Functions
--------
---

-- Spawn vehicle without blip at a set coords and with a custom color
-- local function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading, r1, g1, b1)
function spawnVehicleWithoutBlip(vehicleName, x, y, z, heading)
	local car = GetHashKey(vehicleName)

	-- Check if the vehicle actually exists
	if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then return end

	-- Load the model
	RequestModel(vehicleName)

	-- If model hasn't loaded, wait on it.
	while not HasModelLoaded(vehicleName) do
		Wait(500)
	end

	-- local vehicleNew = CreateVehicle(vehicleName, x, y, z, heading, true, false)
	plane1 = CreateVehicle(vehicleName, x, y + 5, z, heading, true, false)
	-- SetVehicleCustomPrimaryColour(vehicleNew, r1, g1, b1)
	-- SetVehicleCustomSecondaryColour(vehicleNew, r1, g1, b1)

	SetModelAsNoLongerNeeded(plane1)

	-- Todo Re-enable this if needed
	-- return vehicleNew

	-- 6-24-2024 @ 3:28PM
	-- Possibly add this at the bottom
	-- SetModelAsNoLongerNeeded(car)
end

-- Is this needed under a thread? Might help keep things organized
Citizen.CreateThread(function()
	if logEvents then
		AddEventHandler('gameEventTriggered', function(name, args)
			print(('Game event: %s (%s)'):format(name, json.encode(args)))
		end)
	end
end)

-- Todo Play around with this
local function DisableEmergencyServies()
	EnableDispatchService(1, false)
	EnableDispatchService(2, false)
	EnableDispatchService(3, false)
	EnableDispatchService(5, false)
end

function CreateCelebrationScreenFn()
	backGroundColor = "HUD_COLOR_BLACK"
	-- https://www.vespura.com/fivem/scaleform/#MP_CELEBRATION
	local scaleform = "MP_CELEBRATION"
	local scaleformHandle = RequestScaleformMovie(scaleform) -- The scaleform you want to use

	while not HasScaleformMovieLoaded(scaleformHandle) do
		Wait(0)
	end

	if HasScaleformMovieLoaded(scaleformHandle) then
		-- if debugMode then
		-- notify("Loaded")
		-- end
	end

	-- Draw the scaleform
	BeginScaleformMovieMethod(scaleformHandle, "CREATE_STAT_WALL")
	-- Add the text
	-- ScaleformMovieMethodAddParamLiteralString("SUMMARY")
	-- ScaleformMovieMethodAddParamLiteralString("HUD_COLOR_BLACK")
	BeginTextCommandScaleformString("STRING")
	AddTextComponentSubstringPlayerName("Test")
	EndTextCommandScaleformString()

	-- End the scaleform
	EndScaleformMovieMethod()
end

Citizen.CreateThread(function()
	-- if drawScaleform then
	CreateCelebrationScreenFn()

	while true do
		Wait(0)
		if drawScaleform then
			DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255) -- Draw the scaleform fullscreen
		end
	end
	-- end
end
)


-- Make the first line using custom text.
AddTextEntry("warning_message_first_line", "This is the first line.")

-- Make the second line using custom text.
AddTextEntry("warning_message_second_line", "This is the second line!")

-- Add an event handler for when the screen is dismissed.
AddEventHandler("optionSelected", function(selected)
	print(selected) -- do whatever you want with the selected choice.
	-- players can either press the physicial buttons, or they can click
	-- the instructional buttons with their mouse and it will trigger
	-- the event as well.
end)


-- Quick test from here:
-- https://docs.fivem.net/natives/?_0x7B1776B3B53F8D74
-- Create a thread to loop this warning message.

-- Hmm, I could use this for missions or something.
-- This draws a text with buttons on the screen like in the original game, asks a user to confirm, cancel or retry
-- CreateThread(function()
--     while true do
--         Wait(0)
--         -- Display the warning message every tick.
--         SetWarningMessage("warning_message_first_line", 82, "warning_message_second_line", 0, -1, true, 0, 0, 0)

--         -- Check for key presses or instructional button clicks.
--         -- Input group of 2 is required for this to work while the warning is being displayed.

--         if (IsControlJustReleased(2, 201) or IsControlJustReleased(2, 217)) then -- any select/confirm key was pressed.
--             -- TriggerEvent("optionSelected", "select")
-- 			notify("Confirmed")
--             break
--         elseif (IsControlJustReleased(2, 203)) then -- spacebar/x on controller (alt option) was pressed.
--             -- TriggerEvent("optionSelected", "alt")
-- 			notify("Retrying")
--             break
--         elseif (IsControlJustReleased(2, 202)) then -- any of the cancel/back buttons was pressed
--             -- TriggerEvent("optionSelected", "cancel")
-- 			notify("Cancelled")
--             break
--         end
--     end
-- end)

-- Not sure how to make this one go away
-- https://docs.fivem.net/natives/?_0x15803FEC3B9A872B


-- TODO Test this later.
local function DoesVehicleHaveLivery(vehicle)
	-- Check if the vehicle has liverys and if it's driveable
	if GetVehicleLiveryCount(vehicle) > 1 and IsVehicleDriveable(vehicle, false) then
		return true
	end
	return false
end

--------
-- Commands
--------

-- Todo Add this
-- RegisterCommand("parachute")

-- This seems to work.
-- https://nativedb.internal.kelsoncraft.net/gta5/natives/0xABA17D7CE615ADBF?search=busyspinner
RegisterCommand("togglebusyspinner", function()
	if not BusyspinnerIsOn() then
		BeginTextCommandBusyspinnerOn("FMMC_PLYLOAD")
		EndTextCommandBusyspinnerOn(5)
		DisplayRadar(false)
	else
		BusyspinnerOff()
		DisplayRadar(true)
	end
end, false)

-- Radio test, disable commercials on Channel X as a test
-- Radio station list: https://github.com/DurtyFree/gta-v-data-dumps/blob/master/radioStations.json
RegisterCommand("radioads", function(source, args, rawCommand)
	if args[1] ~= nil then
		if args[1] == "on" then
			SetRadioStationMusicOnly("RADIO_04_PUNK", false)
			notify("Radio ads enabled")
		elseif args[1] == "off" then
			SetRadioStationMusicOnly("RADIO_04_PUNK", true)
			notify("Radio ads disabled")
		end
	end
end, false)


-- This works to turn on/off the radio stations.
RegisterCommand("toggleradio", function(source, args, rawCommand)
	if args[1] ~= nil then
		if args[1] == "on" then
			SetRadioStationIsVisible("RADIO_04_PUNK", true)
			notify("Radio station shown")
		elseif args[1] == "off" then
			SetRadioStationIsVisible("RADIO_04_PUNK", false)
			notify("Radio station hidden")
		end
	end
end, false)


RegisterCommand("togglecelebsc", function()
	if not drawScaleform then
		drawScaleform = true
		if debugMode then
			-- notify("Enabled")
		end
	else
		drawScaleform = false
		if debugMode then
			notify("Disabled")
		end
	end
end, false)

-- Show a scaleform alert like used in online.
-- Message can be customized under the 'AddTextEntry' fields below
local alertTest = false
local drawBackground = true
RegisterCommand("alerttest", function()
	-- if not alertTest then
	-- if not alertTest then
	-- 	alertTest = true
	-- 	notify("Enabled")
	-- else
	-- 	alertTest = false
	-- 	notify("Disabled")
	-- end

	-- Basically like != in C#, inverting the value of alertTest
	alertTest = not alertTest

	-- Citizen.CreateThread(function()
	-- Header
	AddTextEntry("FACES_WARNH2", "Welcome")
	-- Subtitle 1
	AddTextEntry("QM_NO_0", "To the KelsonCraft Test Server")
	-- Subtitle 2
	AddTextEntry("QM_NO_3", "Enjoy your stay!")

	-- Run the alert Test in a loop when this is toggled
	while alertTest do
		Citizen.Wait(0)
		-- https://docs.fivem.net/natives/?_0x15803FEC3B9A872B
		--[[
		    Error code, shown at the bottom left if set to value other than 0.
		]]
		-- labelTitle, labelMsg, p2, p3, labelMsg2, p5, p6, p7, p8, p9, background, errorCode
		-- I'm not sure if some of these values are correct
		-- labelTitle, labelMsg, iButtonFlagBitfieldLower, iButtonFlagBitfieldUpper, labelMsg2, bInsertNumber, NumberToInsert, p7, pFirstSubStringTextLabel, pSecondSubStringTextLabel, background, errorCode
		if drawBackground then
			-- DrawFrontendAlert("FACES_WARNH2", "QM_NO_0", 3, 3, "QM_NO_3", 2, -1, false, "FM_NXT_RAC", "QM_NO_1", true, 10)
			DrawFrontendAlert("FACES_WARNH2", "QM_NO_0", 3, 3, "QM_NO_3", 2, -1, false, "FM_NXT_RAC", "QM_NO_1", true, 10)
		else
			DrawFrontendAlert("FACES_WARNH2", "QM_NO_0", 3, 3, "QM_NO_3", 2, -1, false, "FM_NXT_RAC", "QM_NO_1", false,
				10)
		end

		-- Make the scaleform go away if the buttons are pressed.
		-- These can be made to run certain functions also if needed.
		if (IsControlJustReleased(2, 201) or IsControlJustReleased(2, 217)) then -- any select/confirm key was pressed.
			-- notify("Confirmed")
			alertTest = false
			break
		elseif (IsControlJustReleased(2, 203)) then -- spacebar/x on controller (alt option) was pressed.
			-- notify("Retrying")
			alertTest = false
			break
		elseif (IsControlJustReleased(2, 202)) then -- any of the cancel/back buttons was pressed
			-- notify("Cancelled")
			alertTest = false
		end
	end
	-- end)
	-- end
end, false)


-- This doesn't seem to work yet, I cannot get the shark to attack the player
RegisterCommand("sharkattack", function()
	local player = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(player)
	local x, y, z = table.unpack(playerCoords)

	local sharkModel = GetHashKey("a_c_sharkhammer")
	local sharkPed = CreatePed(1, sharkModel, z, y + 1, z, playerHeading, true, true)
	RequestModel(sharkModel)

	while not DoesEntityExist(sharkPed) or NetworkGetNetworkIdFromEntity(sharkPed) == 0 do
		Citizen.Wait(100)
	end

	-- SetEntityCoords(lesterPed, x_1, y_1, z_1, true, false, false, false)
	SetEntityCoords(sharkPed, x, y + 1, z, true, false, false, false)
	SetEntityHealth(sharkPed, 1000)

	-- Set the shark to have the shark releationship group
	-- SetPedRelationshipGroupHash(sharkPed, GetHashKey('SHARK'))
	SetPedRelationshipGroupHash(sharkPed, "_ENEMY_SHARK")
	-- https://docs.fivem.net/natives/?_0xBF25EB89375A37AD
	-- SetRelationshipBetweenGroups(5, GetHashKey("SHARK"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(5, enemyShark, GetHashKey("MP0"))

	SetModelAsNoLongerNeeded(sharkModel)
	-- SetEntityAsNoLongerNeeded(sharkPed)

	-- Store the network id if needed for messing around with the shark
	-- sharkPedNetId = NetworkGetNetworkIdFromEntity(sharkPed)
end, false)

-- Todo Test these
RegisterCommand("randomped", function()
	local player = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(player)
	local x, y, z = table.unpack(playerCoords)

	local randomPed = CreateRandomPed(x + 3, y + 3, z)
end, false)

-- This works
RegisterCommand("togglehelmet", function()
	local player = GetPlayerPed(-1)

	if not IsPedWearingHelmet(player) then
		GivePedHelmet(player, false, 1, -1)
	else
		RemovePedHelmet(player, false)
	end
end, false)

-- https://nativedb.dotindustries.dev/gta5/natives/0x23703CD154E83B88?search=bomb

-- This didn't seem to work.
RegisterCommand("bombrun", function()
	local player = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(player)
	local x, y, z = table.unpack(playerCoords)

	-- Spawn a plane, military jet
	spawnVehicleWithoutBlip("lazer", x + 3, y + 3, z, 0)
	-- Spawn a ped inside it
	local pedModel = GetHashKey("a_m_y_clubcust_03")
	local ped = CreatePed(1, pedModel, z, y + 1, z, playerHeading, true, true)
	RequestModel(pedModel)

	while not DoesEntityExist(ped) or NetworkGetNetworkIdFromEntity(ped) == 0 do
		Citizen.Wait(100)
	end

	SetEntityCoords(ped, x + 1, y + 3, z, true, false, false, false)
	SetEntityHealth(ped, 100)

	TaskWarpPedIntoVehicle(ped, plane1, -1)
	-- TaskEnterVehicle(ped, plane1, -1, 1, 1, 1, 0)
	Wait(1000)

	-- Make the plane go into the air a bit
	TaskVehicleDriveToCoord(ped, plane1, x + 20, y + 20, z + 200, 20.0, 0, "lazer", drivingStyleNormal, 10.0, 1)
	-- 10 seconds should be some time to get in the air
	Wait(10000)
	-- Have the plane crash into the player
	TaskPlaneMission(ped, plane1, 0, 0, x, y, z, 4, 100, 0, 90, 0, -500)

	SetModelAsNoLongerNeeded(pedModel)
end, false)

local radioEnabled = false
RegisterCommand("toggleradioctrl", function()
	if not radioEnabled then
		notify("Radio control disabled")
		SetUserRadioControlEnabled(false)
		radioEnabled = true
	else
		notify("Radio control enabled")
		SetUserRadioControlEnabled(true)
		radioEnabled = false
	end
end, false)

-- Stop the firefighters, medics and cops from spawning in, restrict to admins only
local disableEms = false
RegisterCommand("toggleems", function()
	if not disableEms then
		EnableDispatchService(1, false) -- Cop cars
		EnableDispatchService(2, false) -- Cop helicopters
		EnableDispatchService(3, false) -- Fire deperatment
		EnableDispatchService(4, false) -- Swat cars
		EnableDispatchService(5, false) -- Ambulance

		notify("Emergency services disabled.")
		disableEms = true
	else
		EnableDispatchService(1, true) -- Cop cars
		EnableDispatchService(2, true) -- Cop helicopters
		EnableDispatchService(3, true) -- Fire deperatment
		EnableDispatchService(4, true) -- Swat cars
		EnableDispatchService(5, true) -- Ambulance

		notify("Emergency services enabled.")
		disableEms = false
	end
end, true)
--

-- TODO Implement skyswoop animation for a teleport as a test, like when the player goes from singleplayer to online
-- RegisterCommand("skyswtp", function()

-- end)

-- New test #1

function test1()
	-- https://nativedb.dotindustries.dev/gta5/natives/0xEE47635F352DA367
	dlcWeaponCount = GetNumDlcWeapons()
	-- dlcWeaponComponentCount = GetNumDlcWeaponComponents()
	dlcVehicleCount = GetNumDlcVehicles()
end

function clothesTestCheck1()
	-- GetNumTattooShopDlcItems()
	-- GetTattooShopDlcItemData()
	-- GetTattooShopDlcItemIndex()

	-- What are these for?
	-- InitShopPedComponent()
	-- InitShopPedProp()
end

function fireTest()
	-- StartScriptFire()
	-- RemoveScriptFire()
	-- StartEntityFire()
	-- StopEntityFire()
	-- IsEntityOnFire()
	-- GetNumberOfFiresInRange()
	-- SetFlammabilityMultiplier()
	-- StopFireInRange()
	-- GetClosestFirePos()
end

function explosionTest()
	-- AddExplosion()
	-- AddOwnedExplosion()
	-- AddExplosionWithUserVfx()
	-- IsExplosionInArea()
	-- IsExplosionActiveInArea()
	-- IsExplosionInSphere()
	-- GetOwnerOfExplosionInSphere()
	-- IsExplosionInAngledArea()
	-- GetOwnerOfExplosionInAngledArea()
end

function getClosestVehicleTest()
	local player = GetPlayerPed(-1)
	local playerCoords = GetEntityCoords(player)
	local x, y, z = table.unpack(playerCoords)

	-- GetClosestVehicle(x, y, z, )
end

function entityTest2()
	-- IsEntityOnScreen()
	-- IsEntityInZone()
end

function miscTest()
	-- https://nativedb.dotindustries.dev/gta5/natives/0x5BCA583A583194DB
	-- DrawShadowedSpotLight()
	-- SetBinkMovie()
	-- PlayBinkMovie()
	-- StopBinkMovie()
	-- DrawBinkMovie()
	-- ReleaseBinkMovie()
end

--

RegisterCommand("bomb", function ()
	local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

	World.AddExplosion(playerPos.x, playerPos.y, playerPos.z, gaspumpExplosion, damageScale)
end, true)