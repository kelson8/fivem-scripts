-- A lot of this base code came from the example.lua in ScaleformUI_Lua
-- https://github.com/manups4e/ScaleformUI

-- local timerBarPool = TimerBarPool.New()

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = {msg, },
    })
end

-- Create the menu
function CreateMenu()
    local txd = CreateRuntimeTxd("scaleformui")
    local duiPanel = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
    CreateRuntimeTextureFromDuiHandle(txd, "sidepanel", GetDuiHandle(duiPanel))
    -- Original
    -- local duiBanner = CreateDui("https://i.imgur.com/3yrFYbF.gif", 288, 160)
    -- Anime gif background
    local duiBanner = CreateDui("https://i.pinimg.com/originals/a3/1d/7f/a31d7f5c20b885859e84ceea2d71d7b6.gif", 288, 160)
    CreateRuntimeTextureFromDuiHandle(txd, "menuBanner", GetDuiHandle(duiBanner))

    -- Initalize the menu
    local testMenu = UIMenu.New("KCNet-UI", "KelsonCraftFiveM Test", 50, 50, true, "scaleformui", "menubanner", true)
    testMenu:MaxItemsOnScreen(7)
    testMenu:AnimationEnabled(false)
    testMenu:BuildingAnimation(MenuBuildingAnimation.NONE)
    testMenu:ScrollingType(MenuScrollingType.CLASSIC)
    testMenu:CounterColor(SColor.HUD_YELLOW)
    -- MouseSettings(enableMouseControls, enableEdge, isWheelEnabled, resetCursorOnOpen, leftClickSelect)
    testMenu:MouseSettings(false, false, true, false, true)

    local currentTransition = "TRANSITION_OUT"
    local bigMessageItem = UIMenuItem.New("Big Message Test", "Testing the big messages")
    -- Add items to menu with this
    testMenu:AddItem(bigMessageItem)
    local bigMessageTestMenu = UIMenu.New("Big Message Test", "Testing the big messages", 50, 50, true, nil, nil, true)

    local uiItemTransitionList = UIMenuListItem.New("Transition",
    { "TRANSITION_OUT", "TRANSITION_UP", "TRANSITION_DOWN" },
    1,
    "Transition type for the big message")
    bigMessageTestMenu:AddItem(uiItemTransitionList)

    local uiItemBigMessageManualDispose = UIMenuCheckboxItem.New("Manual Dispose", false,
    "Manually dispose the big message")
    bigMessageTestMenu:AddItem(uiItemBigMessageManualDispose)

    local uiItemMessageType = UIMenuListItem.New("Message Type",
    { "Mission Passed", "Colored Shard", "Old Message", "Simple Shard", "Rank Up", "MP Message Large",
        "MP Wasted Message" }, 1)
    bigMessageTestMenu:AddItem(uiItemMessageType)

    local uiItemDisposeBigMessage = UIMenuItem.New("Dispose Big Message", "Dispose the big message")
    bigMessageTestMenu:AddItem(uiItemDisposeBigMessage)

    local manuallyDisposeBigMessage = false

    bigMessageTestMenu.OnCheckboxChange = function(sender, item, checked_)
        if item == uiItemBigMessageManualDispose then
            manuallyDisposeBigMessage = checked_
        end
    end

    bigMessageTestMenu.OnItemSelect = function(sender, item, index)
        if item == uiItemDisposeBigMessage then
            ScaleformUI.Scaleforms.BigMessageInstance:Dispose()
        end
    end

    bigMessageTestMenu.OnListSelect = function(sender, item, index)
        if item == uiItemTransitionList then
            currentTransition = item:IndexToItem(index)
            ScaleformUI.Notifications:ShowNotification(string.format("Transition set to %s", currentTransition))
        elseif item == uiItemMessageType then
            if index == 1 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowMissionPassedMessage("Mission Passed", 5000,
                    manuallyDisposeBigMessage)
            elseif index == 2 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowColoredShard("Coloured Shard", "Description",
                    SColor.HUD_White,
                    SColor.HUD_Freemode, 5000, manuallyDisposeBigMessage)
            elseif index == 3 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowOldMessage("Old Message", 5000, manuallyDisposeBigMessage)
            elseif index == 4 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowSimpleShard("Simple Shard", "Simple Shard Subtitle", 5000,
                    manuallyDisposeBigMessage)
            elseif index == 5 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowRankupMessage("Rank Up", "Rank Up Subtitle", 10, 5000,
                    manuallyDisposeBigMessage)
            elseif index == 6 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowMpMessageLarge("MP Message Large", 5000,
                    manuallyDisposeBigMessage)
            elseif index == 7 then
                ScaleformUI.Scaleforms.BigMessageInstance:ShowMpWastedMessage("MP Wasted Message", "Subtitle", 5000,
                    manuallyDisposeBigMessage)
            end
            ScaleformUI.Scaleforms.BigMessageInstance:SetTransition(currentTransition, 0.4, true)
        end
    end

    -- the new "SwitchTo" method will give your menus the ability to fly
    -- parameters are: UIMenu:SwitchTo([UIMenu]newMenu, [number]newMenuInitialIndex, [bool]inheritPrevMenuParams)
    -- if not specified, the last to parameters will always be [1, false] to allow every menu to be rendered separately
    bigMessageItem.Activated = function(menu, item)
        menu:SwitchTo(bigMessageTestMenu, 1, true)
    end

    -- My custom code below

    -- Player Menu
    local playerMenuItem = UIMenuItem.New("Player menu", "All player functions.")
    -- Adds the menu to the testMenu
    testMenu:AddItem(playerMenuItem)
    local playerMenu = UIMenu.New("Player menu", "All player functions.", 50, 50, true, nil, nil, true)

    local healPlayerItem = UIMenuItem.New("Heal player", "Gives the player full health and armor")
    playerMenu:AddItem(healPlayerItem)

    local getVehicleIdItem = UIMenuItem.New("Get vehicle id", "Shows the current vehicle id in a notification.")
    playerMenu:AddItem(getVehicleIdItem)

    -- This didn't seem to work.
    local toggleKersBoostItem = UIMenuItem.New("Toggle Kers boost", "Toggle kers boost if the vehicle has it.")
    playerMenu:AddItem(toggleKersBoostItem)

    local blowupPlayerItem = UIMenuItem.New("Explode", "Blow yourself up")
    playerMenu:AddItem(blowupPlayerItem)

    local spawnDrivingPedItem = UIMenuItem.New("Spawn driving ped", "Spawn a ped to drive you to the marker.")
    playerMenu:AddItem(spawnDrivingPedItem)

    local spawnIntoAirItem = UIMenuItem.New("Spawn into air", "Teleport you into the sky.")
    playerMenu:AddItem(spawnIntoAirItem)

    local handCuffsItem = UIMenuItem.New("Handcuff yourself", "Make it to where you cannot use your weapons.")
    playerMenu:AddItem(handCuffsItem)

    local fakeWantedLevelItem = UIMenuItem.New("Fake Wanted", "Fake wanted level test.")
    playerMenu:AddItem(fakeWantedLevelItem)

    local toggleAnimTestItem = UIMenuItem.New("Animation", "Toggle an animation.")
    playerMenu:AddItem(toggleAnimTestItem)

    -- Heal player on item select
    playerMenu.OnItemSelect = function(sender, item, index)
        if item == healPlayerItem then
            -- Player.Functions.HealPlayer()
            HealPlayer()
        elseif item == getVehicleIdItem then
            GetVehicleId()
        elseif item == toggleKersBoostItem then
            ToggleKersBoost()
        elseif item == blowupPlayerItem then
            BlowupPlayer()
        elseif item == spawnDrivingPedItem then
            SpawnDrivingPed()
        elseif item == spawnIntoAirItem then
            SpawnPedIntoAir()
        elseif item == handCuffsItem then
            ToggleHandcuffs()
        elseif item == fakeWantedLevelItem then
            ToggleFakeWantedLevel()
        elseif item == toggleAnimTestItem then
            ToggleAnimTest()
        end
    end

    -- Todo Add vehicle density and ped density changer with a slider from 0 to 1, 0.1-0.2.. etc
    -- Todo Fix these vehicle density and ped density options to actually work.
    -- World Menu
    local worldMenuItem = UIMenuItem.New("World Menu", "Functions for world management.")
    testMenu:AddItem(worldMenuItem)

    -- Todo Add permissions for some of the world options.
    local worldMenu = UIMenu.New("World Menu", "Functions for world management.", 50, 50, true, nil, nil, true)
    -- I'm not sure how to get this working.
    local vehicleDensity = UIMenuListItem.New("Vehicle density", {
        0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}, 0, "Change amount of cars on the road (Not working.)")
    worldMenu:AddItem(vehicleDensity)

    worldMenu.OnListChange = function(menu, item, index)
        if item == vehicleDensity then
            -- TriggerEvent("menu_test:VehicleDensity", index)
            Citizen.CreateThread(function()
                SetPedDensityMultiplierThisFrame(index)
            end)
            notify("You have changed the vehicle density to " .. index)
        end
    end

    -- Needed for item activation like in LemonUI, otherwise it won't show up.
    playerMenuItem.Activated = function (menu, item)
        menu:SwitchTo(playerMenu, 1, true)
    end

    worldMenuItem.Activated = function(menu, item)
        menu:SwitchTo(worldMenu, 1, true)
    end

    testMenu:Visible(true)
end


-- https://github.com/manups4e/ScaleformUI/wiki/HUD-section#notifications
-- Citizen.CreateThread(function()
--     local playerCoords = GetEntityCoords(PlayerPedId())
--     local duration = 3000 -- Milliseconds

--     local display_notification = true
--     Citizen.SetTimeout(duration, function() display_notification = false end)
--     while display_notification do
--         Citizen.Wait(0)
--         Notifications:ShowFloatingHelpNotification("This message will be removed in 3 seconds", playerCoords)
--     end
-- end)

Citizen.CreateThread(function()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local vector3_pos = vector3(236.19, -872.25, 30.49)

    local fib_teleport = { x = 121.6, y = -759.33, z = 45.75 }

    -- Usage example
    while true do
        Wait(0)

        -- RegisterNetEvent("menu_test:VehicleDensity")
        -- AddEventHandler("menu_test:VehicleDensity", function(index)
        --     SetPedDensityMultiplierThisFrame(index)
        -- end)

        -- I adapted the code from ch_warps to work on here.
        -- I even got the teleporting working by unpacking the vector3.
        -- https://docs.fivem.net/docs/scripting-reference/runtimes/lua/functions/vector3/

        -- I changed this to get the RGBA values from the config, I don't know why I hard coded these values.

        for i = 1, #locations, 1 do
            loc = locations[i]
            marker = Marker.New(loc.marker,
            loc.pos,
            vector3(2,2,2),
            loc.scale,
            {R=loc.rgba[1], G=loc.rgba[2], B=loc.rgba[3], A=loc.rgba[4]},
            -- {R=0, G= 100, B=50, A=255},
            true, false, false, false, true
            )
            marker:Draw()

            -- This puts the text above the markers using the location text position, slightly above the marker
            -- And adds the location text name
            -- ScaleformUI.Notifications:DrawText3D(loc.text_pos, {R=0, G=100, B=50, A=255}, loc.text_name, 7, 10)
            ScaleformUI.Notifications:DrawText3D(loc.text_pos, {R=loc.text_rgba[1],
            G=loc.text_rgba[2],
            B=loc.text_rgba[3],
            A=loc.text_rgba[4]},
            loc.text_name, 7, 10)
            

            local x, y, z = table.unpack(loc.tpto)
            local playerCoord = GetEntityCoords(PlayerPedId(), false)
            if Vdist2(playerCoord, loc.pos) < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                -- Code that runs when we are in the markers radius.
                FadeScreenForTeleport()
                SetEntityCoords(PlayerPedId(), x, y, z, true, true, true, false)
                SetEntityHeading(PlayerPedId(), 0)
                -- notify("You have been teleported to location ~b~" .. i)
                notify("You have been teleported to location ~b~" .. loc.text_name)
            end
        end

        -- This places a marker where the player is when the menu starts.
        -- local player = PlayerPedId()
        --marker:Draw()
        -- I got the text drawing above the marker.
        -- ScaleformUI.Notifications:DrawText3D(pos, {R=0, G=100, B=50, A=255}, "Teleporter", 7, 10)
        -- Shows "Teleporter" above the marker that I placed
        -- ScaleformUI.Notifications:DrawText3D(text_pos, {R=0, G=100, B=50, A=255}, "Teleporter", 7, 10)

        -- Draw the timer bar
        -- timerBarPool:Draw()

        -- Disabled controller support for now since it uses B on the controller.
        -- https://forum.cfx.re/t/how-to-disable-controller-input-for-scripts/182364/5
        -- F3 key, draw the regular menu
        -- Menu for keyboard
        if IsControlJustPressed(0, 170) and not MenuHandler:IsAnyMenuOpen() and GetLastInputMethod(0) then
            CreateMenu()
        end

        -- https://forum.cfx.re/t/help-use-multiple-keys-in-lua/4856396
        -- Controller menu X button and RB, this is working now but for some reason "RT" activates the options?
        -- This is partially working for multiple keypresses, makes the menu delayed though
        if IsControlJustPressed(0, 179) and not GetLastInputMethod(2) and not MenuHandler:IsAnyMenuOpen() then
            if IsControlJustPressed(0, 183) and not GetLastInputMethod(2) and not MenuHandler:IsAnyMenuOpen() then
            CreateMenu()
            end
        end




    end
end)
