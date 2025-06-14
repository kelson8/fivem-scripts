-- Info for this came from here: https://forum.cfx.re/t/new-dlc-bottom-dollar-bounties-mp2024-01-info/5244751

-- I have disabled this file, combining these two resources work well for my needs:
-- Bob74_ipl: https://github.com/Bob74/bob74_ipl
-- online_interiors (Shows the blips): https://github.com/cloudy-develop/online-interiors

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
