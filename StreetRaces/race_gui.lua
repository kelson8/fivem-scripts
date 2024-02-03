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

    local listRaceItem = UIMenuItem.New("List races", "Lists races stored in the file.")
    vehicleMenu:AddItem(listRaceItem)

    local leaveRaceItem = UIMenuItem.New("Leave race", "Leave the current race.")
    vehicleMenu:AddItem(leaveRaceItem)

    -- Will this work?
    -- listRaceItem.OnItemSelect = function(sender, item, index)
    --     if item == listRaceItem then
    --         TriggerServerEvent('StreetRaces:listRaces_sv')
    --         notify("Race list..")
    --     end
    -- end

    -- Anything below that isn't list race and has 'StreetRaces:listRaces_sv' in it are just placeholders for now.

    startRaceItem.Activated = function(sender, item, index)
        if item == startRaceItem then
            TriggerServerEvent('StreetRaces:listRaces_sv')
        end
    end

    cancelRaceItem.Activated = function(sender, item, index)
        if item == cancelRaceItem then
            TriggerServerEvent('StreetRaces:listRaces_sv')
        end
    end

    -- I fixed this by removing the example text/making it blank
    -- Todo make this get the data from the json file and list it off, instead of needing keyboard input
    deleteRaceItem.Activated = function(sender, item, index)
        if item == deleteRaceItem then

            -- This one needs to get user input.
            local result = KeyboardInput("Delete Race", "", 20)
            TriggerServerEvent('StreetRaces:deleteRace_sv', result)
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

    -- Once this is ready:
    -- Todo make this get the data from the json file and list it off, instead of needing keyboard input
    loadRaceItem.Activated = function(sender, item, index)
        if item == loadRaceItem then
            TriggerServerEvent('StreetRaces:listRaces_sv')
        end
    end

    leaveRaceItem.Activated = function(sender, item, index)
        if item == leaveRaceItem then
            TriggerServerEvent('StreetRaces:listRaces_sv')
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


-- function TestFunc(source, args)
--     if args[1] == "clear" or args[1] == "leave" then
--         -- If player is part of a race, clean up map and send leave event to server
--         if raceStatus.state == RACE_STATE_JOINED or raceStatus.state == RACE_STATE_RACING then
--             cleanupRace()
--             TriggerServerEvent('StreetRaces:leaveRace_sv', raceStatus.index)
--             notify("Left the race.")
--         end

--         -- Reset state
--         raceStatus.index = 0
--         raceStatus.checkpoint = 0
--         raceStatus.state = RACE_STATE_NONE
--     elseif args[1] == "record" then
--         -- Clear waypoint, cleanup recording and set flag to start recording
--         SetWaypointOff()
--         cleanupRecording()
--         raceStatus.state = RACE_STATE_RECORDING
--         notify("Record race state active: Set markers on the map for waypoints.")
--     elseif args[1] == "save" then
--         -- Check name was provided and checkpoints are recorded
--         local name = args[2]
--         if name ~= nil and #recordedCheckpoints > 0 then
--             -- Send event to server to save checkpoints
--             TriggerServerEvent('StreetRaces:saveRace_sv', name, recordedCheckpoints)
--             notify("Race " .. name .. " saved")
--         end
--     elseif args[1] == "delete" then
--         -- Check name was provided and send event to server to delete saved race
--         local name = args[2]
--         if name ~= nil then
--             TriggerServerEvent('StreetRaces:deleteRace_sv', name)
--             -- Set this to not notify if the race doesn't exist.
--             notify("Race " .. name .. " deleted")
--         end
--     elseif args[1] == "list" then
--         -- Send event to server to list saved races
--         TriggerServerEvent('StreetRaces:listRaces_sv')
--     elseif args[1] == "load" then
--         -- Check name was provided and send event to server to load saved race
--         local name = args[2]
--         if name ~= nil then
--             TriggerServerEvent('StreetRaces:loadRace_sv', name)
--             notify("Race " .. name .. " loaded.")
--         end
--     elseif args[1] == "start" then
--         -- Parse arguments and create race
--         local amount = 0
--         if amount then
--             -- Get optional start delay argument and starting coordinates
--             local startDelay = tonumber(args[3])
--             startDelay = startDelay and startDelay*1000 or config_cl.joinDuration
--             local startCoords = GetEntityCoords(GetPlayerPed(-1))
-- 			local TotalLaps = tonumber(args[2])

--             -- Create a race using checkpoints or waypoint if none set
--             if #recordedCheckpoints > 0 then
--                 -- Create race using custom checkpoints
--                 TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, TotalLaps, recordedCheckpoints)
--             elseif IsWaypointActive() then
--                 -- Create race using waypoint as the only checkpoint
--                 local waypointCoords = GetBlipInfoIdCoord(GetFirstBlipInfoId(8))
--                 local retval, nodeCoords = GetClosestVehicleNode(waypointCoords.x, waypointCoords.y, waypointCoords.z, 1)
--                 table.insert(recordedCheckpoints, {blip = nil, coords = nodeCoords})
--                 TriggerServerEvent('StreetRaces:createRace_sv', amount, startDelay, startCoords, recordedCheckpoints, 10)
--             end

--             -- Set state to none to cleanup recording blips while waiting to join
--             raceStatus.state = RACE_STATE_NONE
--         end
--     elseif args[1] == "cancel" then
--         -- Send cancel event to server
--         TriggerServerEvent('StreetRaces:cancelRace_sv')
--         notify("Race cancelled")
--     else
--         return
--     end
-- end

-- Copied below code from races_cl
-- Helper function to clean up recording blips
function cleanupRecording()
    -- Remove map blips and clear recorded checkpoints
    for _, checkpoint in pairs(recordedCheckpoints) do
        RemoveBlip(checkpoint.blip)
        checkpoint.blip = nil
    end
    recordedCheckpoints = {}
end

-- position update thread
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
