-- A lot of this base code came from the example.lua in ScaleformUI_Lua
-- https://github.com/manups4e/ScaleformUI

-- local timerBarPool = TimerBarPool.New()

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Create the menu
function CreateMenu()
    local txd = CreateRuntimeTxd("scaleformui")
    local duiPanel = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
    CreateRuntimeTextureFromDuiHandle(txd, "sidepanel", GetDuiHandle(duiPanel))
	local duiBanner = CreateDui("https://i.imgur.com/3yrFYbF.gif", 288, 160)
	CreateRuntimeTextureFromDuiHandle(txd, "menuBanner", GetDuiHandle(duiBanner))

    -- Initalize the menu
    local testMenu = UIMenu.New("ScaleformUI", "KelsonCraftFiveM Test", 50, 50, true, "scaleformui", "menubanner", true)
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

    -- Heal player on item select
    playerMenu.OnItemSelect = function(sender, item, index)
        if item == healPlayerItem then
            SetEntityHealth(PlayerPedId(), 200)
            -- SetEntityMaxHealth(PlayerPedId())
            SetPedArmour(PlayerPedId(), 100)
            ScaleformUI.Notifications:ShowNotification("You have been healed", false, false)
            -- notify("You have been healed!")
        end
    end

    -- Needed for item activation like in LemonUI, otherwise it won't show up.
    playerMenuItem.Activated = function (menu, item)
        menu:SwitchTo(playerMenu, 1, true)
    end

    testMenu:Visible(true)
end

-- Copied from example.lua for a test
function CreateLobbyMenu()
	local lobbyMenu = MainView.New("Lobby Menu", "ScaleformUI for you by Manups4e!", "Detail 1", "Detail 2", "Detail 3")
	local columns = {
		SettingsListColumn.New("COLUMN SETTINGS", SColor.HUD_Red),
		PlayerListColumn.New("COLUMN PLAYERS", SColor.HUD_Orange),
		MissionDetailsPanel.New("COLUMN INFO PANEL", SColor.HUD_Green),
	}
	lobbyMenu:SetupColumns(columns)

	local handle = RegisterPedheadshot(PlayerPedId())
	while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do Citizen.Wait(0) end
	local txd = GetPedheadshotTxdString(handle)
	lobbyMenu:HeaderPicture(txd, txd) 	-- lobbyMenu:CrewPicture used to add a picture on the left of the HeaderPicture

	UnregisterPedheadshot(handle) -- call it right after adding the menu.. this way the txd will be loaded correctly by the scaleform.. 

	lobbyMenu:CanPlayerCloseMenu(true)
	-- this is just an example..CanPlayerCloseMenu is always defaulted to true.. if you set this to false.. be sure to give the players a way out of your menu!!! 
	
	local item = UIMenuItem.New("UIMenuItem", "UIMenuItem description")
	local item1 = UIMenuListItem.New("UIMenuListItem", { "This", "is", "a", "Test"}, 0, "UIMenuListItem description")
	local item2 = UIMenuCheckboxItem.New("UIMenuCheckboxItem", true, 1, "UIMenuCheckboxItem description")
	local item3 = UIMenuSliderItem.New("UIMenuSliderItem", 100, 5, 50, false, "UIMenuSliderItem description")
	local item4 = UIMenuProgressItem.New("UIMenuProgressItem", 10, 5, "UIMenuProgressItem description")
    -- Set the description icon to blink
    item:BlinkDescription(true)
	lobbyMenu.SettingsColumn:AddSettings(item)
	lobbyMenu.SettingsColumn:AddSettings(item1)
	lobbyMenu.SettingsColumn:AddSettings(item2)
	lobbyMenu.SettingsColumn:AddSettings(item3)
	lobbyMenu.SettingsColumn:AddSettings(item4)


    -- Sets the crew names
	local crew1 = CrewTag.New("hello", true, false, CrewHierarchy.Leader, SColor.HUD_Green)
	local crew2 = CrewTag.New("evry1", true, false, CrewHierarchy.Commissioner, SColor.HUD_Pink)
	local crew3 = CrewTag.New("look", true, false, CrewHierarchy.Liutenant, SColor.HUD_Blue)
	local crew4 = CrewTag.New("at", true, false, CrewHierarchy.Representative, SColor.HUD_Orange)
	local crew5 = CrewTag.New("this", true, false, CrewHierarchy.Muscle, SColor.HUD_Red)

    -- These values were set to randomize, that's why they didn't show up what they were set as below.
	-- local friend = FriendItem.New(GetPlayerName(PlayerId()), SColor.HUD_Green, true, GetRandomIntInRange(15, 55), "Status", crew1)
	-- local friend2 = FriendItem.New(GetPlayerName(PlayerId()), SColor.HUD_Pink, true, GetRandomIntInRange(15, 55), "Status", crew2)
    local friend = FriendItem.New(GetPlayerName(PlayerId()), SColor.HUD_Green, true, 150, "Status", crew1)
	local friend2 = FriendItem.New(GetPlayerName(PlayerId()), SColor.HUD_Pink, true, 15, "Status", crew2)
	friend:SetLeftIcon(LobbyBadgeIcon.IS_CONSOLE_PLAYER, false)
	friend2:SetLeftIcon(LobbyBadgeIcon.SPECTATOR, false)

	friend.ClonePed = PlayerPedId() -- defaulted to 0 if you set it to nil / 0 the ped will be removed from the pause menu
	friend2.ClonePed = PlayerPedId() -- defaulted to 0 if you set it to nil / 0 the ped will be removed from the pause menu

	-- local panel = PlayerStatsPanel.New("Player 1", SColor.HUD_Green)
    local panel = PlayerStatsPanel.New(GetPlayerName(PlayerId()), SColor.HUD_Green)
	panel:Description("This is the description for Player 1!!")
	panel:HasPlane(true)
	panel:HasHeli(true)
	panel.RankInfo:RankLevel(150)
	panel.RankInfo:LowLabel("This is the low label")
	panel.RankInfo:MidLabel("This is the middle label")
	panel.RankInfo:UpLabel("This is the upper label")
	panel:AddStat(PlayerStatsPanelStatItem.New("Statistic 1", "Description 1", GetRandomIntInRange(30, 150)))
	panel:AddStat(PlayerStatsPanelStatItem.New("Statistic 2", "Description 2", GetRandomIntInRange(30, 150)))
	panel:AddStat(PlayerStatsPanelStatItem.New("Statistic 3", "Description 3", GetRandomIntInRange(30, 150)))
	panel:AddStat(PlayerStatsPanelStatItem.New("Statistic 4", "Description 4", GetRandomIntInRange(30, 150)))
	panel:AddStat(PlayerStatsPanelStatItem.New("Statistic 5", "Description 5", GetRandomIntInRange(30, 150)))
	friend:AddPanel(panel)

	local panel2 = PlayerStatsPanel.New("Player 2", SColor.HUD_Pink)
	panel2:Description("This is the description for Player 2!!")
	panel2:HasPlane(true)
	panel2:HasHeli(true)
	panel2:HasVehicle(true)
	panel2.RankInfo:RankLevel(15)
	panel2.RankInfo:LowLabel("This is the low label")
	panel2.RankInfo:MidLabel("This is the middle label")
	panel2.RankInfo:UpLabel("This is the upper label")
	panel2:AddStat(PlayerStatsPanelStatItem.New("Statistic 1", "Description 1", GetRandomIntInRange(30, 150)))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Statistic 2", "Description 2", GetRandomIntInRange(30, 150)))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Statistic 3", "Description 3", GetRandomIntInRange(30, 150)))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Statistic 4", "Description 4", GetRandomIntInRange(30, 150)))
	panel2:AddStat(PlayerStatsPanelStatItem.New("Statistic 5", "Description 5", GetRandomIntInRange(30, 150)))
	friend2:AddPanel(panel2)

	lobbyMenu.PlayersColumn:AddPlayer(friend)
	lobbyMenu.PlayersColumn:AddPlayer(friend2)

	
	local txd = CreateRuntimeTxd("scaleformui")
	local _paneldui = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
	CreateRuntimeTextureFromDuiHandle(txd, "lobby_panelbackground", GetDuiHandle(_paneldui))

	lobbyMenu.MissionPanel:UpdatePanelPicture("scaleformui", "lobby_panelbackground")
	lobbyMenu.MissionPanel:Title("ScaleformUI - Title")
	local detailItem1 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false, BadgeStyle.BRIEFCASE, SColor.HUD_Freemode)
	local detailItem2 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false, BadgeStyle.STAR, SColor.HUD_Gold)
	local detailItem3 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false, BadgeStyle.ARMOR, SColor.HUD_Purple)
	local detailItem4 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false, BadgeStyle.BRAND_DILETTANTE, SColor.HUD_Green)
	local detailItem5 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false, BadgeStyle.COUNTRY_ITALY, SColor.HUD_White, true)
	local detailItem6 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", true)
	local detailItem7 = UIMenuFreemodeDetailsItem.New("Left Label", "Right Label", false)
	--local missionItem4 = new("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat", "", false)
	lobbyMenu.MissionPanel:AddItem(detailItem1)
	lobbyMenu.MissionPanel:AddItem(detailItem2)
	lobbyMenu.MissionPanel:AddItem(detailItem3)
	lobbyMenu.MissionPanel:AddItem(detailItem4)
	lobbyMenu.MissionPanel:AddItem(detailItem5)
	lobbyMenu.MissionPanel:AddItem(detailItem6)
	lobbyMenu.MissionPanel:AddItem(detailItem7)

	lobbyMenu.SettingsColumn.OnIndexChanged = function(idx)
		ScaleformUI.Notifications:ShowSubtitle("SettingsColumn index =>~b~ ".. idx .. "~w~.")
	end

	lobbyMenu.PlayersColumn.OnIndexChanged = function(idx)
		ScaleformUI.Notifications:ShowSubtitle("PlayersColumn index =>~b~ ".. idx .. "~w~.")
	end

	lobbyMenu:Visible(true)
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
        -- I adapted the code from ch_warps to work on here.
        -- I even got the teleporting working by unpacking the vector3.
        -- https://docs.fivem.net/docs/scripting-reference/runtimes/lua/functions/vector3/

        for i = 1, #locations, 1 do
            loc = locations[i]
            marker = Marker.New(loc.marker,
            loc.pos,
            vector3(2,2,2),
            loc.scale,
            {R=0, G= 100, B=50, A=255},
            true, false, false, false, true
            )
            marker:Draw()

            -- This puts the text above the markers using the location text position, slightly above the marker
            -- And adds the location text name
            ScaleformUI.Notifications:DrawText3D(loc.text_pos, {R=0, G=100, B=50, A=255}, loc.text_name, 7, 10)

            local x, y, z = table.unpack(loc.tpto)
            local playerCoord = GetEntityCoords(PlayerPedId(), false)
            if Vdist2(playerCoord, loc.pos) < loc.scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
                -- Code that runs when we are in the markers radius.
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

        -- F6 key, draw the lobby menu
        if IsControlJustPressed(0, 167) and not MenuHandler:IsAnyMenuOpen() and GetLastInputMethod(0) then
            CreateLobbyMenu()
        end
    end
end)
