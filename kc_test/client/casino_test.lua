-- -- https://forum.cfx.re/t/casino-audio/4849334

-- -- local inCasino = false

-- -- Well this basic test works, adds audio if the player enters the casino.

-- -- Interior IDs can be obtained from bob74_ipl or online-interiors
-- -- bob74_ipl: https://forum.cfx.re/t/release-v2-fix-holes-and-customize-the-map/25240
-- -- online-interiors: https://forum.cfx.re/t/release-online-interiors-70-interiors-with-teleports-blips/836300

-- local casinoInterior = 278017

-- -- Taken from kc_restrictions.
-- -- Check if the player is in the casino interior
-- local function IsInCasino()
--     local player = GetPlayerPed(-1)
--     if GetInteriorFromEntity(player) == casinoInterior then
--         return true
--     end

--     return false
-- end

-- -- Optional command to run manually, was for debugging
-- -- RegisterCommand("toggle_csaudio", function ()
-- --     inCasino = not inCasino
-- -- end, false)

-- function PlayCasinoAudio()

-- 	local inCasino = IsInCasino()

-- 	CreateThread(function()
-- 	  local function audioBanks()
-- 		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_GENERAL", false) do
-- 		  Wait(0)
-- 		end
-- 		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_01", false) do
-- 		  Wait(0)
-- 		end
-- 		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_02", false) do
-- 		  Wait(0)
-- 		end
-- 		while not RequestScriptAudioBank("DLC_VINEWOOD/CASINO_SLOT_MACHINES_03", false) do
-- 		  Wait(0)
-- 		end
-- 	  end
-- 	  audioBanks()
-- 	  while inCasino do
-- 		if not IsStreamPlaying() and LoadStream("casino_walla", "DLC_VW_Casino_Interior_Sounds") then
-- 		  PlayStreamFromPosition(945.85, 41.58, 75.82)
-- 		  -- Well this was constantly playing when I went outside.
--     --   PlaySound(-1, "Event_Start_Text", "GTAO_FM_Events_Soundset", false, 0, true)
-- 		end
-- 		if IsStreamPlaying() and not IsAudioSceneActive("DLC_VW_Casino_General") then
-- 		  StartAudioScene("DLC_VW_Casino_General")
-- 		end
-- 		Wait(1000)
-- 	  end
-- 	  if IsStreamPlaying() then
-- 		StopStream()
-- 	  end
-- 	  if IsAudioSceneActive("DLC_VW_Casino_General") then
-- 		StopAudioScene("DLC_VW_Casino_General")
-- 	  end
-- 	end)
-- end

-- Citizen.CreateThread(function ()
-- 	while true do
-- 		-- Add a bit of wait to this, it shouldn't need to always run.
-- 		Wait(100)
-- 		PlayCasinoAudio()
-- 	end
-- end)