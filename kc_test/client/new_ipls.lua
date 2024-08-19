-- Info for this came from here: https://forum.cfx.re/t/new-dlc-bottom-dollar-bounties-mp2024-01-info/5244751

-- Check if game build is 3258 or higher, needed for the bounty office
function VersionCheck()
	local version = GetGameBuildNumber()
		if version >= 3258 then
			return true
		end
		return false
end

-- https://forum.cfx.re/t/list-of-all-current-supported-game-build/3578214/2
-- https://gta.fandom.com/wiki/Grand_Theft_Auto_V/Title_Update_Notes
RegisterCommand("gameversion", function()
	local version = GetGameBuildNumber()
	-- if version == 3258 then

	-- List of updates below.
	-- TODO Rename the ones once I find out which version they are
	local ArenaWar = 1604
	-- local CasinoAndResort = ?
	-- local CasinoHeist = ?
	local LSSummerSpecial = 2060
	local CayoPercio = 2189
	local LSTuners = 2372
	local TheContract = 2545
	local mpg9ec = 2612 -- Unknown name
	local CriminalEnterprises = 2699
	local LosSantosDrugWars = 2802
	-- local ? = 2824
	-- local ? = 2845
	local SanAndreasMercenaries = 2944
	local chopShop = 3095
	local build10 = 3179 -- Which one is this?
	local bottomDollarBounties = 3258

	if version == 3258 then
		sendMessage("Your GTA version is correct, running bottom dollar bounties update.")
	else
		sendMessage("You do not have the correct GTA version for this command! You need v3258 on the server and client.")
	end
end, false)

-- This works
RegisterCommand("loadnewipls", function()
	-- local player = GetPlayerPed(-1)
	-- local x,y,z = 565.887, -2688.762, -50.2

	local bountyOffice1 = "m24_1_dlc_int_bounty"
	local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"
    local carrier1 = "m24_1_carrier"

	if VersionCheck() then
		RequestIpl(bountyOffice1)
		RequestIpl(bountyOffice2)
        RequestIpl(carrier1)
		-- SetEntityCoords(player, x, y, z, true, false, false, false)
		-- sendMessage("Warped to the bounty office.")
	else
		sendMessage("You need game build 3258 or higher for this.")
	end
end, false)

-- Bounty office
RegisterCommand("warpipl1", function()
	local player = GetPlayerPed(-1)
	local x,y,z = 565.887, -2688.762, -50.2

	local bountyOffice1 = "m24_1_dlc_int_bounty"
	local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"

	-- if IsIplActive(bountyOffice1) and IsIplActive(bountyOffice2) then
	if IsIplActive(bountyOffice2) then
		SetEntityCoords(player, x, y, z, true, false, false, false)
		sendMessage("Warped to the bounty office.")
	end
end)

-- Aircraft carrier
RegisterCommand("warpipl2", function()
    local player = GetPlayerPed(-1)
    local carrier1 = "m24_1_carrier"
    local x, y, z = -3259.89, 3909.33, 26.78

    if IsIplActive(carrier1) then
        SetEntityCoords(player, x, y, z, true, false, false, false)
		sendMessage("Warped to the aircraft carrier.")
    end
end)

-- This works, moved into misc_test
-- RegisterCommand("warptest", function(source, args, rawCommand)
--     local player = GetPlayerPed(-1)
--     local carrier1 = "m24_1_carrier"
--     local bountyOffice2 = "m24_1_int_placement_m24_1_interior_dlc_int_bounty_milo_"
--     local aircarrierX, airCarrierY, airCarrierZ = -3259.89, 3909.33, 26.78
--     local bountyOfficeX, bountyOfficeY, bountyOfficeZ = 565.887, -2688.762, -50.2

--     if args[1] == "aircarrier1" then
--         if IsIplActive(carrier1) then
--             SetEntityCoords(player, aircarrierX, airCarrierY, airCarrierZ, true, false, false, false)
--             sendMessage("Warped to the aircraft carrier.")
--         end
--     elseif args[1] == "bountyoffice" then
--         if IsIplActive(bountyOffice2) then
--             SetEntityCoords(player, bountyOfficeX, bountyOfficeY, bountyOfficeZ, true, false, false, false)
--             sendMessage("Warped to the bounty office.")
--         end
--     end
-- end, false)