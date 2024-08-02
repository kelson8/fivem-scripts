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

-- Citizen.CreateThread(function()
    -- while true do
        -- F6 key, draw the lobby menu
        -- if IsControlJustPressed(0, 167) and not MenuHandler:IsAnyMenuOpen() and GetLastInputMethod(0) then
        --     CreateLobbyMenu()
        -- end

    -- end
-- end)