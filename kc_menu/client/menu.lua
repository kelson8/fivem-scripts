-----------
--- Menus
-----------
---
local menu = MenuV:CreateMenu("KCNet-Menu", "Welcome to KCNet", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "mainMenuNamespace", "native")
local vehicleMenu = MenuV:CreateMenu("Vehicle", "Vehicle menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "vehicleMenuNamespace", "native")
local playerMenu = MenuV:CreateMenu("Player", "Player menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "playerMenuNamespace", "native")
local warpMenu = MenuV:CreateMenu("Warp", "Warp menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "warpMenuNamespace", "native")

-- local testMenu = menu:InheritMenu({title = 'MenuV 2.0', subtitle = 'Inherit menu of `menu`', theme = 'default'})
-- local testMenu = MenuV:InheritMenu(menu, _, "testMenuNamespace")
local testMenu = MenuV:CreateMenu("Test", "Test menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
    "testMenuNamespace", "native")

-----------
---
-----------



-----------
--- Sub menu buttons
-----------

-- local menu_button = menu:AddButton({ icon = '😃', label = 'Spawn vehicle', value = menu2, description = 'YEA :D from first menu' })
-- local spawnVehicleButton = menu:AddButton({ label = 'Spawn vehicle', value = menu2, description = 'Test' })

local vehicleMenuButton = menu:AddButton({ label = "Vehicle Menu", description = "Open Vehicle menu" })
local playerMenuButton = menu:AddButton({ label = "Player Menu", value = menu2, description = 'Open Player Menu' })
local warpMenuButton = menu:AddButton({ label = "Warp Menu", description = 'Open Warp Menu' })
local testMenuButton = menu:AddButton({ label = "Test Menu", description = 'Open Test Menu' })


-----------
---
-----------


-- TODO Add controller support for this menu

-- spawnVehicleButton:





-- Test

--[[
    if args[1] == "casino_vault" then
        FadeScreenForTeleport()
        SetEntityCoords(player, casinoVaultX, casinoVaultY, casinoVaultZ, true, false, false, false)
        SetEntityHeading(player, 270.79)
        notify("Teleported to casino vault")
    -- Ipl checks are needed for below two
    elseif args[1] == "aircarrier1" then

    elseif args[1] == "bountyoffice" then

]]

local function advancedNotification()
    showAdvancedNotification(
        rawCommand,
        'This is sender',
        'This is subject',
        'CHAR_AMMUNATION',
        8,
        true,
        130
    )
end


-- Toggles
-- Drunk camera toggle
local isDrunk = false
local deathCamToggle = false

-- https://nativedb.dotindustries.dev/gta5/natives/0x95D2D383D5396B8A?search=drunk
-- This works like this
local function toggleDrunkAnim()
    local player = GetPlayerPed(-1)
    local drunkAnim = "move_m@drunk@verydrunk"
    if not HasAnimSetLoaded(drunkAnim) then
        -- Request anim set
        RequestAnimSet(drunkAnim)
        -- Set ped to drunk anim clipset
        SetPedMovementClipset(player, drunkAnim, 2222)
        isDrunk = true
    elseif isDrunk then
        -- Remove the AnimSet so the above will run again.
        RemoveAnimSet(drunkAnim)
        ResetPedMovementClipset(player, 0.0)
        isDrunk = false
    end
end

local function toggleDeathCam()
    if not deathCamToggle then
        DeathCam()
        deathCamToggle = true
    else
        StopDeathCam()
        deathCamToggle = false
    end
end

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
            notify("Incomplete")
            -- SetEntityHealth(player, 250)
        end)

        driftTiresButton:On("select", function()
            toggleDriftTires()
        end)

        doorLockStatusButton:On("select", function()
            notify(getVehicleDoorLockStatusValue())
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
--- Player buttons
-----------

local healPlayerButton = playerMenu:AddButton({
    label = "Heal yourself",
    description =
    'Heal yourself'
})

local randomOutfitButton = playerMenu:AddButton({
    label = "Random Outfit",
    description =
    'Change your multiplayer skin to a random outfit.'
})

-- TODO Figure out how to toggle ragdoll
-- local ragDollToggleButton = playerMenu:AddCheckbox({
local ragDollToggleButton = playerMenu:AddButton({
    label = "Toggle ragdoll",
    description =
    'Toggle ragdoll on/off'
})

-- This didn't do anything
-- local envEffButton = playerMenu:AddButton({
--     label = "Test Env Eff",
--     description =
--     'Debug test'
-- })

-- local ragDollToggleCheckbox = playerMenu:AddCheckbox({
--     label = "Toggle ragdoll",
--     description =
--     'Toggle ragdoll on/off'
-- })

local mpSuicideButton = playerMenu:AddButton({
    label = "MP Suicide",
    description =
    'Kill yourself with the online animation'
})

local invincibilityCheckbox = playerMenu:AddCheckbox({
    label = "Toggle infinte health",
    description =
    'Invincible player'
})

-----------
---
-----------

-----------
--- Player menu button
-----------
-- Well this is how to make sub menus, at least it works like this.
playerMenuButton:On("select", function()
    MenuV:OpenMenu(playerMenu, function()
        healPlayerButton:On("select", function()
            local player = GetPlayerPed(-1)
            SetEntityHealth(player, 250)
        end)

        randomOutfitButton:On("select", function()
            SetRandomOutfit()
        end)

        ragDollToggleButton:On("select", function()
            -- SetRandomOutfit()
        end)

        -- This didn't do anything
        -- envEffButton:On("select", function ()
        --     ToggleEnvEffScale()
        -- end)


        -- ragDollToggleCheckbox:On("Press")

        mpSuicideButton:On("select", function ()
            MpSuicide()
        end)

        -- https://menuv.netlify.app/#CheckboxItem
        invincibilityCheckbox:On('change', function(item, newValue, oldValue)

            -- Set invincibility here.
            if newValue then
                EnableInvincibility()
            else
                DisableInvincibility()
            end
        end)



    end)

end)
-----------
---
-----------



-----------
--- Warp buttons
-----------

-- I had to move these out of the button so it didn't get duplicated, oops.
local bountyOfficeWarpButton = warpMenu:AddButton({
    label = "Bounty office",
    value = menu2,
    description =
    "Warp to bounty office"
})
local aircraftCarrierWarpButton = warpMenu:AddButton({
    label = "Aircraft carrier",
    value = menu2,
    description =
    "Warp to new aircraft carrier"
})
local spawnWarpButton = warpMenu:AddButton({
    label = "Spawn",
    description =
    "Warp to spawn"
})



local cayoPercioWarpButton = warpMenu:AddButton({ label = "Cayo Percio", description = "Warp to Cayo Perico island" })

warpToSkyButton = warpMenu:AddButton({
    label = "Warp to Sky",
    description =
    "Warp to the sky, add +50 to z. Warning this will kill you."
})

-----------
---
-----------

-----------
--- Warp menu button
-----------

warpMenuButton:On("select", function()
    MenuV:OpenMenu(warpMenu, function()
        bountyOfficeWarpButton:On("select", function()
            teleportToNewAreas("bountyoffice")
        end)

        aircraftCarrierWarpButton:On("select", function()
            teleportToNewAreas("aircarrier1")
        end)

        cayoPercioWarpButton:On("select", function()
            teleportToWarps("cayoPerico")
        end)

        spawnWarpButton:On("select", function()
            teleportToWarps("spawn")
        end)

        warpToSkyButton:On("select", function()
            warpToSky()
        end)
    end)
end)

-----------
--- Test buttons
-----------
spawnHeliPedsButton = testMenu:AddButton({
    label = "Spawn heli peds",
    description =
    "Spawn two peds to go to the set coords in a chopper."
})
blowUpHeliPedsButton = testMenu:AddButton({
    label = "Blow up heli peds",
    description =
    "Get rid of the current chopper peds."
})
drunkModeButton = testMenu:AddButton({ label = "Drunk mode", description = "Activate/Deactivate drunk camera" })

deathCamTestButton = testMenu:AddButton({ label = "Death cam", description = "Death camera test" })


advancedNotificationButton = testMenu:AddButton({
    label = "Advanced notification",
    description =
    "Test with the advanced notification."
})
busySpinnerButton = testMenu:AddButton({ label = "Busy Spinner", description = "Busy spinner test." })
blowUpPlayerButton = testMenu:AddButton({
    label = "Blow yourself up",
    description =
    "This will blow you up or stop your vehicle and make it explode."
})

trainSpawnButton = testMenu:AddButton({
    label = "Spawn train",
    description =
    "Spawn a train, test."
})

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
    local player = GetPlayerPed(-1)

    MenuV:OpenMenu(testMenu, function()

        -- TODO Check if player has permission for this and blowUpHeliPedsButton
        spawnHeliPedsButton:On("select", function()
            -- Test this
            -- TriggerServerEvent("kc_menu:canSpawnHeliPeds")
            spawnPedHeliPilots("a_m_y_clubcust_03", "a_m_y_beachvesp_01")
        end)

        blowUpHeliPedsButton:On("select", function()
            explodeHeliPeds()
        end)

        drunkModeButton:On("select", function()
            toggleDrunkAnim()
        end)

        deathCamTestButton:On("select", function()
            toggleDeathCam()
        end)

        -- warpToSkyButton:On("select", function()
        --     warpToSky()
        -- end)

        advancedNotificationButton:On("select", function()
            advancedNotification()
        end)

        busySpinnerButton:On("select", function()
            showBusySpinner("Test")
        end)

        blowUpPlayerButton:On("select", function()
            blowupPlayer()
        end)

        -- testStatButton:On("select", function()
        --     copsKilledCheck()
        -- end)

        trainSpawnButton:On("select", function()
            spawnTrain()
        end)

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
            -- notify(newValue)
        end)

        mapZoomEnableTestButton:On("select", function()
            -- SetRadarZoom(100)
            SetRadarZoomPrecise(0.0)
        end)

        mapZoomDisableTestButton:On("select", function()
            -- SetRadarZoom(0)
            SetRadarZoomPrecise(90.0)
        end)
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
--     -- notify(("Menu open: %s"):format(menuOpen))
--     -- else
--     --     -- MenuV:CloseMenu(menu, function()
--     --     menuOpen = false
--     --     notify(("Menu open: %s"):format(menuOpen))
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
