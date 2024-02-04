-- DEFINITIONS AND CONSTANTS
local RACE_STATE_NONE = 0
local RACE_STATE_JOINED = 1
local RACE_STATE_RACING = 2
local RACE_STATE_RECORDING = 3
local RACE_CHECKPOINT_TYPE = 45
local RACE_CHECKPOINT_FINISH_TYPE = 9


function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- https://docs.fivem.net/docs/scripting-manual/working-with-events/listening-for-events/
-- https://docs.fivem.net/docs/scripting-manual/working-with-events/triggering-events/

RegisterNetEvent("notifyClient")
AddEventHandler("notifyClient",
    function (msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(true, false)
end)

-- Races and race status
local races = {}
local raceStatus = {
    state = RACE_STATE_NONE,
    index = 0,
    checkpoint = 0,
	currentLap = 0,
	totalLaps = 0,
	totalCheckpoints = 0,
	myPosition = 0,
	totalPlayers = 0,
	distanceTraveled = 0
}

-- Recorded checkpoints
local recordedCheckpoints = {}

-- Todo:
-- Add option for unloading the races.

function CreateMenu()
    local txd = CreateRuntimeTxd("scaleformui")
    local duiPanel = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
    CreateRuntimeTextureFromDuiHandle(txd, "sidepanel", GetDuiHandle(duiPanel))
	local duiBanner = CreateDui("https://i.imgur.com/3yrFYbF.gif", 288, 160)
	CreateRuntimeTextureFromDuiHandle(txd, "menuBanner", GetDuiHandle(duiBanner))

    -- Initalize the menu
    local mainMenu = UIMenu.New("Main Menu", "Street races GUI", 50, 50, true, "scaleformui", "menubanner", true)
    mainMenu:MaxItemsOnScreen(7)
    mainMenu:AnimationEnabled(false)
    mainMenu:BuildingAnimation(MenuBuildingAnimation.NONE)
    mainMenu:ScrollingType(MenuScrollingType.CLASSIC)
    mainMenu:CounterColor(SColor.HUD_YELLOW)
    -- MouseSettings(enableMouseControls, enableEdge, isWheelEnabled, resetCursorOnOpen, leftClickSelect)
    mainMenu:MouseSettings(false, false, true, false, true)

    -- Basic race gui, most functions are currently working.
    -- Some of these functions require parameters, I will
    -- need to figure out how to pass a list of the parameters
    -- stored in the json and output it to a listbox on here.
    local vehicleMenuItem = UIMenuItem.New("Race Menu", "Street races")
    mainMenu:AddItem(vehicleMenuItem)
    local vehicleMenu = UIMenu.New("Race Menu", "Street races", 50, 50, true, nil, nil, true)

    -- Not implemented yet. {Doesn't work}
    local startRaceItem = UIMenuItem.New("Start race", "Start a loaded race.")
    vehicleMenu:AddItem(startRaceItem)

    local cancelRaceItem = UIMenuItem.New("Cancel race", "Cacnel the current race.")
    vehicleMenu:AddItem(cancelRaceItem)

    local createRaceItem = UIMenuItem.New("Create race", "Create a new race.")
    vehicleMenu:AddItem(createRaceItem)

    local deleteRaceItem = UIMenuItem.New("Delete race", "Leaves the current race.")
    vehicleMenu:AddItem(deleteRaceItem)

    local saveRaceItem = UIMenuItem.New("Save race", "Save a race.")
    vehicleMenu:AddItem(saveRaceItem)

    local loadRaceItem = UIMenuItem.New("Load race", "Load the selected race.")
    vehicleMenu:AddItem(loadRaceItem)

    -- Not implemented yet.
    local unloadRaceItem = UIMenuItem.New("Unload race", "Stop the current race from showing up.")
    vehicleMenu:AddItem(unloadRaceItem)

    local listRaceItem = UIMenuItem.New("List races", "Lists races stored in the file.")
    vehicleMenu:AddItem(listRaceItem)

    local leaveRaceItem = UIMenuItem.New("Leave race", "Leave the current race.")
    vehicleMenu:AddItem(leaveRaceItem)

    -- local totalLaps = UIMenuIte

    -- Will this work?
    -- listRaceItem.OnItemSelect = function(sender, item, index)
    --     if item == listRaceItem then
    --         TriggerServerEvent('StreetRaces:listRaces_sv')
    --         notify("Race list..")
    --     end
    -- end

    
    -- For some reason the IsWaypointActive check seems to work for the count down but the checkpoints don't load up.
    -- The recordedCheckpoints check is doing nothing
    startRaceItem.Activated = function(sender, item, index)
        if item == startRaceItem then
            -- Incomplete
            -- local amount = 0
            -- if amount then
            --     -- Get optional start delay argument and starting coordinates
            --     local startDelay = tonumber(args[3])
            --     startDelay = startDelay and startDelay*1000 or config_cl.joinDuration
            --     
            --     local TotalLaps = tonumber(args[2])
            -- end

                -- Todo Set this to get user input from a list.
                -- local TotalLaps = ""
                

                -- Uncomment below when I want to work on this again.

                -- User input (Keyboard)
                -- local startDelay = KeyboardInput("Race start delay", "", 10) or config_cl.joinDuration
                -- local TotalLaps = KeyboardInput("Total laps", "", 10) or config_cl.totalLaps
                -- local amount = KeyboardInput("Money to set for winner", "", 10) or 200
                -- Disable KeyboardInput as a test.


                -- local amount = 200

                local amount = 0
                -- if TotalLaps ~= nil then
                -- if amount then   // GetPlayerPed(-1)
                    local startCoords = GetEntityCoords(PlayerPedId())
                    local startDelay = 5000 --config_cl.joinDuration
                    local TotalLaps = 2 --config_cl.totalLaps
                    

                    if #recordedCheckpoints > 0 then
                        -- Ok this is the problem, nothing below this is printing or doing anything
                        -- It's something to do with recordedCheckpoints missing or something.
                        -- notify("Debug line") -- Doesn't print with a race loaded in.
                        
                        -- Create race using custom checkpoints
                        
                        TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, TotalLaps, recordedCheckpoints)
                    
                        -- For some reason the IsWaypointActive check seems to work fine.
                    elseif IsWaypointActive() then
                        -- Create race using waypoint as the only checkpoint

                        --notify("Debug line")

                        local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))

                        local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
                        table.insert(recordedCheckpoints, {blip = nil, coords = nodeCoords})
                        TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoints, 10)
                -- end

                -- Set state to none to cleanup recording blips while waiting to join
                raceStatus.state = RACE_STATE_NONE
            end
        end
    end

    cancelRaceItem.Activated = function(sender, item, index)
        if item == cancelRaceItem then
            TriggerServerEvent('StreetRaces:cancelRace_sv')
        end
    end

    -- I fixed this by removing the example text/making it blank
    -- Todo make this get the data from the json file and list it off, instead of needing keyboard input
    deleteRaceItem.Activated = function(sender, item, index)
        if item == deleteRaceItem then

            -- This one needs to get user input.
            local result = KeyboardInput("Delete Race", "", 20)

            if result ~= nil then
                TriggerServerEvent('StreetRaces:deleteRace_sv', result)
            end
        end
    end

    saveRaceItem.Activated = function(sender, item, index)
        if item == saveRaceItem then
            local result = KeyboardInput("Save Race", "", 20)
            if result ~= nil and #recordedCheckpoints > 0 then
                TriggerServerEvent('StreetRaces:saveRace_sv', result, recordedCheckpoints)
            end
        end
    end

    -- Todo make this get the data from the json file and list it off, instead of needing keyboard input
    loadRaceItem.Activated = function(sender, item, index)
        if item == loadRaceItem then
            local raceName = KeyboardInput("Race to load", "", 10)
            TriggerServerEvent('StreetRaces:loadRace_sv', raceName)
        end
    end

    leaveRaceItem.Activated = function(sender, item, index)
        if item == leaveRaceItem then
        -- If player is part of a race, clean up map and send leave event to server
            if raceStatus.state == RACE_STATE_JOINED or raceStatus.state == RACE_STATE_RACING then
                cleanupRace()
                TriggerServerEvent('StreetRaces:leaveRace_sv', raceStatus.index)
            end
        end
    end

    -- Wow this actually worked
    listRaceItem.Activated = function(sender, item, index)
        if item == listRaceItem then
            TriggerServerEvent('StreetRaces:listRaces_sv')
            -- notify("Race list..")
        end
    end

    -- This one seems to be working now.
    -- A marker can be set with this using "E", instead of clicking on the map
    createRaceItem.Activated = function(sender, item, index)
        if item == createRaceItem then
            SetWaypointOff()
            cleanupRecording()
            raceStatus.state = RACE_STATE_RECORDING
            notify("Record active: Set markers on the map for waypoints. Or press E to place them at your position.")
        end
    end

    unloadRaceItem.Activated = function(sender, item, index)
        if item == unloadRaceItem then
            -- I had to change it to trigger event.
            -- TriggerEvent('StreetRaces:unloadRace_cl')
        end
    end

    vehicleMenuItem.Activated = function(menu, item)
        menu:SwitchTo(vehicleMenu, 1, true)
    end

    -- Making the menu visible.
    mainMenu:Visible(true)
end

-- Draw the menu
Citizen.CreateThread(function()
    while true do
        Wait(0)
        -- F5 key, draw the main menu
        if IsControlJustPressed(0, 166) and not MenuHandler:IsAnyMenuOpen() and GetLastInputMethod(0) then
            CreateMenu()
        end
    end

end)

-- https://forum.cfx.re/t/use-displayonscreenkeyboard-properly/51143/2
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLenght	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end


-- Test unloadRace function in this file

-- Copied below code from races_cl, most of these have been disabled in that file.

-----
-- function Draw3DText(x, y, z, text)
--     -- Check if coords are visible and get 2D screen coords
--     local onScreen, _x, _y = World3dToScreen2d(x, y, z)
--     if onScreen then
--         -- Calculate text scale to use
--         local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
--         local scale = 1.8*(1/dist)*(1/GetGameplayCamFov())*100

--         -- Draw text on screen
--         SetTextScale(scale, scale)
--         SetTextFont(4)
--         SetTextProportional(1)
--         SetTextColour(255, 255, 255, 255)
--         SetTextDropShadow(0, 0, 0, 0,255)
--         SetTextDropShadow()
--         SetTextEdge(4, 0, 0, 0, 255)
--         SetTextOutline()
--         SetTextEntry("STRING")
--         SetTextCentre(1)
--         AddTextComponentString(text)
--         DrawText(_x, _y)
--     end
-- end

-- -- Draw 2D text on screen
-- function Draw2DText(x, y, text, scale)
--     -- Draw text on screen
--     SetTextFont(4)
--     SetTextProportional(7)
--     SetTextScale(scale, scale)
--     SetTextColour(255, 255, 255, 255)
--     SetTextDropShadow(0, 0, 0, 0,255)
--     SetTextDropShadow()
--     SetTextEdge(4, 0, 0, 0, 255)
--     SetTextOutline()
--     SetTextEntry("STRING")
--     AddTextComponentString(text)
--     DrawText(x, y)
-- end
-----

-- Helper function to clean up recording blips
function cleanupRecording()
    -- Remove map blips and clear recorded checkpoints
    for _, checkpoint in pairs(recordedCheckpoints) do
        RemoveBlip(checkpoint.blip)
        checkpoint.blip = nil
    end
    recordedCheckpoints = {}
end

-- Position update thread
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        -- When recording flag is set, save checkpoints
        if raceStatus.state == RACE_STATE_RACING then
			newpos = GetEntityCoords(PlayerPedId())
			dist = GetDistanceBetweenCoords(oldpos.x, oldpos.y, oldpos.z, newpos.x, newpos.y, newpos.z, true)
			oldpos = newpos
			raceStatus.distanceTraveled = raceStatus.distanceTraveled + dist		
			local value = raceStatus.totalCheckpoints + math.floor(raceStatus.distanceTraveled*1.33)/1000
			TriggerServerEvent('StreetRaces:updatecheckpoitcount_sv', raceStatus.index, value)
		end
	end
end)

-- Checkpoint recording thread
Citizen.CreateThread(function()
    -- Loop forever and record checkpoints every 100ms
    while true do
        Citizen.Wait(0)
        
        -- When recording flag is set, save checkpoints
        if raceStatus.state == RACE_STATE_RECORDING then
            -- Create new checkpoint when waypoint is set
            if IsWaypointActive() then
                -- Get closest vehicle node to waypoint coordinates and remove waypoint
                local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
                local retval, coords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
				
                SetWaypointOff()

                -- Check if coordinates match any existing checkpoints
                for index, checkpoint in pairs(recordedCheckpoints) do
                    if GetDistanceBetweenCoords(coords.x, coords.y, coords.z, checkpoint.coords.x, checkpoint.coords.y, checkpoint.coords.z, false) < 1.0 then
                        -- Matches existing checkpoint, remove blip and checkpoint from table
                        RemoveBlip(checkpoint.blip)
                        table.remove(recordedCheckpoints, index)
                        coords = nil

                        -- Update existing checkpoint blips
                        for i = index, #recordedCheckpoints do
                            ShowNumberOnBlip(recordedCheckpoints[i].blip, i)
                        end
                        break
                    end
                end

                -- Add new checkpoint
                if (coords ~= nil) then
                    -- Add numbered checkpoint blip
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipColour(blip, config_cl.checkpointBlipColor)
                    SetBlipAsShortRange(blip, true)
                    ShowNumberOnBlip(blip, #recordedCheckpoints+1)

                    -- Add checkpoint to array
                    table.insert(recordedCheckpoints, {blip = blip, coords = coords})
                end
            end
			if IsControlJustReleased(0, config_cl.markerKeybind) then
				local player = GetPlayerPed(-1)
				local coords = GetEntityCoords(player)

                -- Add new checkpoint
                if (coords ~= nil) then
                    -- Add numbered checkpoint blip
                    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
                    SetBlipColour(blip, config_cl.checkpointBlipColor)
                    SetBlipAsShortRange(blip, true)
                    ShowNumberOnBlip(blip, #recordedCheckpoints+1)

                    -- Add checkpoint to array
                    table.insert(recordedCheckpoints, {blip = blip, coords = coords})
                end
				PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
			end
        else
            -- Not recording, do cleanup
            cleanupRecording()
        end
    end
end)

-- Main thread
Citizen.CreateThread(function()
    -- Loop forever and update every frame
    while true do
        Citizen.Wait(0)
		local checkpointType = RACE_CHECKPOINT_TYPE
		local nextCheckpoint

        -- Get player and check if they're in a vehicle
        -- local player = GetPlayerPed(-1)
        local player = PlayerPedId()
        if IsPedInAnyVehicle(player, false) then
            -- Get player position and vehicle
            local position = GetEntityCoords(player)
            local vehicle = GetVehiclePedIsIn(player, false)

            -- Player is racing
            if raceStatus.state == RACE_STATE_RACING then
                -- Initialize first checkpoint if not set
                local race = races[raceStatus.index]
                if raceStatus.checkpoint == 0 then
                    -- Increment to first checkpoint
                    raceStatus.checkpoint = 1
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]

                    -- Create checkpoint when enabled
                    if config_cl.checkpointRadius > 0 then
                        checkpointType = RACE_CHECKPOINT_TYPE
                        checkpoint.checkpoint = CreateCheckpoint(checkpointType, checkpoint.coords.x,  checkpoint.coords.y, checkpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                        SetCheckpointCylinderHeight(checkpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                    end

                    -- Set blip route for navigation
                    SetBlipRoute(checkpoint.blip, true)
                    SetBlipRouteColour(checkpoint.blip, config_cl.checkpointBlipColor)
                else
                    -- Check player distance from current checkpoint
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    if GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false) < config_cl.checkpointProximity then
                        -- Passed the checkpoint, delete map blip and checkpoint (only on last lap)
						if raceStatus.currentLap == race.laps then
							RemoveBlip(checkpoint.blip)
						end
						-- Delete the checkpoint marker in world
                        if config_cl.checkpointRadius > 0 then
                            DeleteCheckpoint(checkpoint.checkpoint)
                        end
						-- update total checkpoints count and notify server
						raceStatus.totalCheckpoints = raceStatus.totalCheckpoints + 1
						                        
                        -- Check if at finish line
                        if raceStatus.checkpoint == #(race.checkpoints) then
							if raceStatus.currentLap == (race.laps) then					
								-- Play finish line sound
								PlaySoundFrontend(-1, "ScreenFlash", "WastedSounds")

								-- Send finish event to server
								local currentTime = (GetGameTimer() - race.startTime)
								TriggerServerEvent('StreetRaces:finishedRace_sv', raceStatus.index, currentTime)
								
								-- Reset state
								raceStatus.index = 0
								raceStatus.state = RACE_STATE_NONE
							else
								-- add another lap
								PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")
								raceStatus.currentLap = raceStatus.currentLap + 1
								raceStatus.checkpoint = 1
								local checkpoint = race.checkpoints[raceStatus.checkpoint]

								-- Create checkpoint when enabled
								if config_cl.checkpointRadius > 0 then
									checkpointType = RACE_CHECKPOINT_TYPE
									checkpoint.checkpoint = CreateCheckpoint(checkpointType, checkpoint.coords.x,  checkpoint.coords.y, checkpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
									SetCheckpointCylinderHeight(checkpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
								end

								-- Set blip route for navigation
								SetBlipRoute(checkpoint.blip, true)
								SetBlipRouteColour(checkpoint.blip, config_cl.checkpointBlipColor)							
							end
                        else
                            -- Play checkpoint sound
                            PlaySoundFrontend(-1, "RACE_PLACED", "HUD_AWARDS")

                            -- Increment checkpoint counter and get next checkpoint
                            raceStatus.checkpoint = raceStatus.checkpoint + 1
                            nextCheckpoint = race.checkpoints[raceStatus.checkpoint]

                            -- Create checkpoint when enabled
                            if config_cl.checkpointRadius > 0 then
								if raceStatus.currentLap == race.laps then
									if raceStatus.checkpoint == #race.checkpoints then
										checkpointType = RACE_CHECKPOINT_FINISH_TYPE
									else
										checkpointType = RACE_CHECKPOINT_TYPE
									end
								else
									checkpointType = RACE_CHECKPOINT_TYPE
								end
                                nextCheckpoint.checkpoint = CreateCheckpoint(checkpointType, nextCheckpoint.coords.x,  nextCheckpoint.coords.y, nextCheckpoint.coords.z, 0, 0, 0, config_cl.checkpointRadius, 255, 255, 0, 127, 0)
                                SetCheckpointCylinderHeight(nextCheckpoint.checkpoint, config_cl.checkpointHeight, config_cl.checkpointHeight, config_cl.checkpointRadius)
                            end

                            -- Set blip route for navigation
                            SetBlipRoute(nextCheckpoint.blip, true)
                            SetBlipRouteColour(nextCheckpoint.blip, config_cl.checkpointBlipColor)
                        end
                    end
                end

                -- Draw HUD when it's enabled
                if config_cl.hudEnabled then
                    -- Draw time and checkpoint HUD above minimap
                    local timeSeconds = (GetGameTimer() - race.startTime)/1000.0
                    local timeMinutes = math.floor(timeSeconds/60.0)
                    timeSeconds = timeSeconds - 60.0*timeMinutes
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y, ("~y~%02d:%06.3f"):format(timeMinutes, timeSeconds), 0.7)
                    local checkpoint = race.checkpoints[raceStatus.checkpoint]
                    local checkpointDist = math.floor(GetDistanceBetweenCoords(position.x, position.y, position.z, checkpoint.coords.x, checkpoint.coords.y, 0, false))
                    Draw2DText(config_cl.hudPosition.x, config_cl.hudPosition.y + 0.04, ("~y~CHECKPOINT %d/%d (%dm) | LAP %d/%d | POS %d/%d"):format(raceStatus.checkpoint, #race.checkpoints, checkpointDist, raceStatus.currentLap, race.laps, raceStatus.myPosition, raceStatus.totalPlayers), 0.5)
                end
            -- Player has joined a race
            elseif raceStatus.state == RACE_STATE_JOINED then
                -- Check countdown to race start
                local race = races[raceStatus.index]
                local currentTime = GetGameTimer()
                local count = race.startTime - currentTime
                if count <= 0 then
                    -- Race started, set racing state and unfreeze vehicle position
					oldpos = GetEntityCoords(PlayerPedId())
					newpos = GetEntityCoords(PlayerPedId())
					raceStatus.distanceTraveled = 0
                    raceStatus.state = RACE_STATE_RACING
                    raceStatus.checkpoint = 0
					raceStatus.currentLap = 1
                    FreezeEntityPosition(vehicle, false)
                elseif count <= config_cl.freezeDuration then
                    -- Display countdown text and freeze vehicle position
                    Draw2DText(0.5, 0.4, ("~y~%d"):format(math.ceil(count/1000.0)), 3.0)
                    FreezeEntityPosition(vehicle, true)
                else
                    -- Draw 3D start time and join text
                    local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 1)
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Race for ~g~$%d~w~ starting in ~y~%d~w~s"):format(race.amount, math.ceil(count/1000.0)))
                    Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Joined")
                end
            -- Player is not in a race
            else
                -- Loop through all races
                for index, race in pairs(races) do
                    -- Get current time and player proximity to start
                    local currentTime = GetGameTimer()
                    local proximity = GetDistanceBetweenCoords(position.x, position.y, position.z, race.startCoords.x, race.startCoords.y, race.startCoords.z, true)

                    -- When in proximity and race hasn't started draw 3D text and prompt to join
                    if proximity < config_cl.joinProximity and currentTime < race.startTime then
                        -- Draw 3D text
                        local count = math.ceil((race.startTime - currentTime)/1000.0)
                        local temp, zCoord = GetGroundZFor_3dCoord(race.startCoords.x, race.startCoords.y, 9999.9, 0)
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+1.0, ("Race for ~g~$%d~w~ starting in ~y~%d~w~s"):format(race.amount, count))
                        Draw3DText(race.startCoords.x, race.startCoords.y, zCoord+0.80, "Press [~g~E~w~] to join")

                        -- Check if player enters the race and send join event to server
                        if IsControlJustReleased(1, config_cl.joinKeybind) then
                            TriggerServerEvent('StreetRaces:joinRace_sv', index)
                            break
                        end
                    end
                end
            end  
        end
    end
end)