-----------
--- Menus
-----------
---
--- TODO Attempt to reorganize this menu into multiple files
--- Such as warp_menu.lua, vehicle_menu.lua, player_menu.lua... And so on.
--- I got the new format working for the music menu.
--- client/menus/music_menu.lua
---
---
---

Menus = {}

Menus.Warps = {}

Buttons = {}

local menu = MenuV:CreateMenu("KCNet-Menu", "Welcome to KCNet", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "mainMenuNamespace", "native")

-- Getters for menus, this works in other files.
-- Made this public for other files.
function GetMenu()
    return menu
end

-- Player Menu
PlayerMenu = MenuV:CreateMenu("Player", "Player menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "menuv", "playerMenuNamespace", "native")

-- Vehicle menu
local vehicleMenu = MenuV:CreateMenu("Vehicle", "Vehicle menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "vehicleMenuNamespace", "native")

-- local playerMenu = MenuV:CreateMenu("Player", "Player menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
--     "playerMenuNamespace", "native")

-- Warp menu
-- Removed local to get this in another file.
warpMenu = MenuV:CreateMenu("Warp", "Warp menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    -- Menus.Warp = MenuV:CreateMenu("Warp", "Warp menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "warpMenuNamespace", "native")



-- Test Menu
-- local testMenu = menu:InheritMenu({title = 'MenuV 2.0', subtitle = 'Inherit menu of `menu`', theme = 'default'})
-- local testMenu = MenuV:InheritMenu(menu, _, "testMenuNamespace")
local testMenu = MenuV:CreateMenu("Test", "Test menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "testMenuNamespace", "native")


-- Clothes menu
ClothesMenu = MenuV:CreateMenu("Clothes", "Clothes Menu", "topleft", 255, 0, 0, "size-110", "default",
    "menuv", "clothesMenuNamespace", "native")


-- Music menu
MusicMenu = MenuV:CreateMenu("Music", "Music Menu", "topleft", 255, 0, 0, "size-110", "default",
    "menuv", "musicMenuNamespace", "native")


-----------
---
-----------


-----------
--- Sub menu buttons
-----------
---

-- Clothes
-- Buttons.ClothesMenuButton = menu:AddButton({ label = "Clothes Menu", description = 'Open the clothes menu' })
ClothesMenuButton = menu:AddButton({ label = "Clothes Menu", description = 'Open the clothes menu' })

-- local menu_button = menu:AddButton({ icon = '😃', label = 'Spawn vehicle', value = menu2, description = 'YEA :D from first menu' })
-- local spawnVehicleButton = menu:AddButton({ label = 'Spawn vehicle', value = menu2, description = 'Test' })

local vehicleMenuButton = menu:AddButton({ label = "Vehicle Menu", description = "Open Vehicle menu" })
-- local playerMenuButton = menu:AddButton({ label = "Player Menu", value = menu2, description = 'Open Player Menu' })

warpMenuButton = menu:AddButton({ label = "Warp Menu", description = 'Open Warp Menu' })

local testMenuButton = menu:AddButton({ label = "Test Menu", description = 'Open Test Menu' })

-- Music
MusicMenuButton = menu:AddButton({ label = "Music Menu", description = 'Open Music Menu' })

-- Player
-- PlayerMenuButton = menu:AddButton({ label = "Player Menu", value = menu2, description = 'Open Player Menu' })
PlayerMenuButton = menu:AddButton({ label = "Player Menu", description = 'Open Player Menu' })


-----------
---
-----------


-- TODO Add controller support for this menu

-- spawnVehicleButton:







-- TODO Fix this to work
missionTrain = nil
local function spawnTrain()
    local trainModel = GetHashKey("freight")
    RequestModel(trainModel)
    missionTrain = CreateMissionTrain("freight", 519.2, -1127.4, 29.6, true)
    SetModelAsNoLongerNeeded(trainModel)
end

--#endregion


-----------
--- Vehicle buttons
-----------

local spawnVehicleButton = vehicleMenu:AddButton({
    label = "Spawn vehicle",
    description = "Give you a random vehicle",
})

local driftTiresButton = vehicleMenu:AddButton({
    label = "Drift Tires",
    description = "Toggle drift tires on/off.",
})

local doorLockStatusButton = vehicleMenu:AddButton({
    label = "Door lock status",
    description = "Print which number the door lock status is.",
})

local toggleDoorLockButton = vehicleMenu:AddButton({
    label = "Toggle door lock",
    description = "Toggle the doors locked/unlocked.",
})

-----------
---
-----------

-----------
--- Vehicle menu button
-----------
vehicleMenuButton:On("select", function()
    MenuV:OpenMenu(vehicleMenu, function()
        spawnVehicleButton:On("select", function()
            local player = GetPlayerPed(-1)
            exports.kc_util:Notify("Incomplete")
            -- SetEntityHealth(player, 250)
        end)

        driftTiresButton:On("select", function()
            toggleDriftTires()
        end)

        doorLockStatusButton:On("select", function()
            exports.kc_util:Notify(getVehicleDoorLockStatusValue())
        end)

        toggleDoorLockButton:On("select", function()
            toggleVehicleDoorLock()
        end)
    end)
    --[[
    spawnVehicleButton:On("select", function()
    -- print("Test... Is it working?")
    end)]]
end)

-----------
---
-----------

-----------
---
-----------

-----------
--- Test buttons
-----------
---
-- Heli peds tests
-- Disabled for now.
-- spawnHeliPedsButton = testMenu:AddButton({
--     label = "Spawn heli peds",
--     description =
--     "Spawn two peds to go to the set coords in a chopper."
-- })

-- blowUpHeliPedsButton = testMenu:AddButton({
--     label = "Blow up heli peds",
--     description =
--     "Get rid of the current chopper peds."
-- })

drunkModeButton = testMenu:AddButton({ label = "Drunk mode", description = "Activate/Deactivate drunk camera" })

deathCamTestButton = testMenu:AddButton({ label = "Death cam", description = "Death camera test" })


-- Advanced Notification
advancedNotificationButton = testMenu:AddButton({
    label = "Advanced notification",
    description =
    "Test with the advanced notification."
})

-- Busy spinner
busySpinnerButton = testMenu:AddButton({ label = "Busy Spinner", description = "Busy spinner test." })



-- Blow yourself up
blowUpPlayerButton = testMenu:AddButton({
    label = "Blow yourself up",
    description =
    "This will blow you up or stop your vehicle and make it explode."
})

-- Train

trainSpawnButton = testMenu:AddButton({
    label = "Spawn train",
    description =
    "Spawn a train, test."
})

-- Blip

blipTestButton = testMenu:AddButton({
    label = "Blip test",
    description =
    "Put a random blip on the map."
})

removeBlipTestButton = testMenu:AddButton({
    label = "Delete blip",
    description =
    "Remove a blip from the map."
})

-- Map

mapZoomEnableTestButton = testMenu:AddButton({
    label = "Map zoom in",
    description =
    "Zoom the map in."
})

mapZoomDisableTestButton = testMenu:AddButton({
    label = "Map zoom out",
    description =
    "Zoom the map out."
})

-- Routing bucket test

setNopopulationLobbyButton = testMenu:AddButton({
    label = "No population lobby",
    description = "Set you to the no population lobby, no vehicles or peds."
})


setHubLobbyButton = testMenu:AddButton({
    label = "Hub lobby",
    description = "Set you to the main hub lobby."
})

-- getVehLobbyButton = testMenu:AddButton({
--     label = "Current veh lobby",
--     description = "Get the vehicles current routing bucket."
-- })


-- This works!!
-- RegisterCommand("getveh_lobby", function()
--     local player = PlayerPedId()
--     local currentVeh = GetVehiclePedIsIn(player, false)

--     if currentVeh ~= nil or currentVeh ~= 0 then
--         -- This works like this on the client now! Shows routing bucket 10 for no population lobby instead of 0
--         local vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)

--         TriggerServerEvent('kc_menu:getCurrentVehicleLobby', vehNetId)

--         -- exports.kc_util:Notify(("Vehicle: %s"):format(currentVeh))
--         -- else
--         -- Text.Notify("You are not in a vehicle!")
--     end
-- end, false)

-----------
---
-----------

-- Not sure how to use this one
blipSliderRange = testMenu:AddRange({ label = "Blip", min = 0, max = 883, value = 0, saveOnUpdate = true })

-- blipCoords = testMenu:AddSlider({})


-----------
--- Test menu button
-----------
testMenuButton:On("select", function()
    MenuV:OpenMenu(testMenu, function()
        local player = PlayerPedId()
        local currentVeh = GetVehiclePedIsIn(player, false)

        local vehNetId = 0

        if currentVeh ~= 0 or currentVeh ~= nil then
            vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)
        end
        -- TODO Check if player has permission for this and blowUpHeliPedsButton
        -- Heli peds
        -- spawnHeliPedsButton:On("select", function()
        --     -- Test this
        --     -- TriggerServerEvent("kc_menu:canSpawnHeliPeds")
        --     spawnPedHeliPilots("a_m_y_clubcust_03", "a_m_y_beachvesp_01")
        -- end)

        -- blowUpHeliPedsButton:On("select", function()
        --     explodeHeliPeds()
        -- end)

        drunkModeButton:On("select", function()
            toggleDrunkAnim()
        end)

        deathCamTestButton:On("select", function()
            toggleDeathCam()
        end)

        -- warpToSkyButton:On("select", function()
        --     warpToSky()
        -- end)

        -- Advanced Notification

        advancedNotificationButton:On("select", function()
            advancedNotification()
        end)

        -- Busy spinner
        busySpinnerButton:On("select", function()
            -- showBusySpinner("Test")
            Text.ShowBusySpinner("Test")
        end)

        blowUpPlayerButton:On("select", function()
            blowupPlayer()
        end)

        -- testStatButton:On("select", function()
        --     copsKilledCheck()
        -- end)

        -- Train

        trainSpawnButton:On("select", function()
            spawnTrain()
        end)

        -- Blip
        blipTestButton:On("select", function()
            if not getBlipEnabled() then
                createBlipTest()
                -- This doesn't seem to run, I moved it to another button
                -- else
                -- removeBlipTest()
            end
        end)

        removeBlipTestButton:On("select", function()
            removeBlipTest()
        end)

        -- Not sure how to use this one, cannot figure out how to change the slider value
        blipSliderRange:On("change", function(item, newValue, oldValue)
            -- blipSliderRange:
            -- exports.kc_util:Notify(newValue)
        end)


        -- Map
        -- Zoom in
        mapZoomEnableTestButton:On("select", function()
            -- SetRadarZoom(100)
            SetRadarZoomPrecise(0.0)
        end)

        -- Zoom out
        mapZoomDisableTestButton:On("select", function()
            -- SetRadarZoom(0)
            -- SetRadarZoomPrecise(90.0)
            SetRadarZoomPrecise(90.0)
        end)

        -- Routing bucket tests

        -- These work! Created in kc_lobby.
        -- TODO Restrict these if in a race lobby or in a race.
        -- I may setup races using the StreetRaces resource and MySql.
        -- I figured out how to make these work for the players current vehicle also.
        setNopopulationLobbyButton:On("select", function()
            TriggerServerEvent('kc_menu:setNoPopulation')
            -- TriggerServerEvent('kc_menu:setNoPopulation', currentVeh)
            -- TriggerServerEvent('kc_menu:setNoPopulation', vehNetId)
            TriggerServerEvent('kc_menu:setVehicleNoPopulation', vehNetId)
        end)

        -- setHubLobbyButton
        setHubLobbyButton:On("select", function()
            TriggerServerEvent('kc_menu:setHub')

            TriggerServerEvent('kc_menu:setVehicleLobby', vehNetId)
        end)

        -- Well this doesn't seem to work
        -- getVehLobbyButton:On("select", function ()
        --     local player = PlayerPedId()
        --     local currentVeh = GetVehiclePedIsIn(player, false)
        --     -- if currentVeh ~= nil or currentVeh ~= 0 then
        --     -- Well this didn't work client side.
        --     -- local currentVehNetId = NetworkGetNetworkIdFromEntity(currentVeh)

        --         -- Shows routing bucket 0 in vehicles.
        --         TriggerServerEvent('kc_menu:getCurrentVehicleLobby', currentVeh)

        --         -- TriggerServerEvent('kc_menu:getCurrentVehicleLobby', currentVehNetId)
        --         -- TriggerServerEvent('kc_menu:getCurrentVehicleLobby')

        --         -- print(("Current Vehicle: %s"):format(currentVeh))

        --         -- exports.kc_util:Notify(("Vehicle: %s"):format(currentVeh))
        --     -- else
        --         -- Text.Notify("You are not in a vehicle!")
        --     -- end
        -- end)
    end)
end)

-----------
---
-----------


-----------
--- Open/Close menu
-----------

local menuOpen = false

if menu:OpenWith('KEYBOARD', 'F1') then
    -- menuOpen = not menuOpen
    menuOpen = true
end

-- if not menuOpen then
--     menu:OpenWith('KEYBOARD', 'F1') -- Press F1 to open Menu
--     menuOpen = true
--     -- TODO Fix this to work.
--     -- Why doesn't this work?
--     -- exports.kc_util:Notify(("Menu open: %s"):format(menuOpen))
--     -- else
--     --     -- MenuV:CloseMenu(menu, function()
--     --     menuOpen = false
--     --     exports.kc_util:Notify(("Menu open: %s"):format(menuOpen))
--     -- end)
--     -- menu:Close(menu)
-- end

-- Taken this from one of my KC ScriptHookV Examples
-- TODO Fix this
-- Citizen.CreateThread(function()
--     Wait(0)
--     while menuOpen do
--         Wait(0)
--         DisableAllControlActions(2)
--         DisableAllControlActions(0)

--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_UP, true)
--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_DOWN, true)
--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_LEFT, true)
--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_RIGHT, true)
--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_ACCEPT, true)
--         EnableControlAction(2, ControllerInput.INPUT_FRONTEND_CANCEL, true)

--         HideHudComponentThisFrame(10) -- Ammo
--         HideHudComponentThisFrame(6) -- Weapon Wheel
--         HideHudComponentThisFrame(7) -- Weapon Icon
--         HideHudComponentThisFrame(8) -- Health/Armor/Stamina
--         HideHudComponentThisFrame(9) -- Cash
--         HideHelpTextThisFrame()
--     end
-- end)

-----------
---
-----------

-- Not sure about controller support for this menu
-- menu:OpenWith('Controller', 'A') -- Press RB + A to open Menu
