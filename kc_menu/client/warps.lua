-- Here is the hospital and police station spawns

-- Hospital #1:
-- X: -449.7836 
-- Y: -341.3995 
-- Z: 33.5024
-- Heading: 83.1352

-- Hospital #2:
-- X: 341.4144 
-- Y: -1396.2910 
-- Z: 31.5098
-- Heading: 47.5300

-- Hospital #3:
-- X: 360.7675 
-- Y: -583.4315
-- Z: 27.8269
-- Heading: 276.9074

-- Hospital #4:
-- X: 1838.4948 
-- Y: 3672.2222
-- Z: 33.2783
-- Heading: 206.5448

-- Hospital #5:
-- X: -242.2981
-- Y: 6325.2334, 
-- Z: 31.4271
-- Heading: 335.2387



-- Police station #1
-- X: -1093.8900 
-- Y: -807.0834 
-- Z: 18.2612
-- Heading: 42.2400

-- Police station #2
-- X: 360.8818 
-- Y: -1581.6075 
-- Z: 28.2931
-- Heading: 23.6148

-- Police station #3
-- X: -560.7550 
-- Y: -133.9789 
-- Z: 37.0586
-- Heading: 210.6082

-- Police station #4
-- X: 1856.3516 
-- Y: 3682.0608 
-- Z: 33.2672
-- Heading: 210.2006

-- Police station #5
-- X: -440.7429 
-- Y: 6019.8892 
-- Z: 30.4903
-- Heading: 314.9315

-- Police station #6
-- X: 639.1819 
-- Y: 1.7650 
-- Z: 81.7865
-- Heading: 238.0365

-- Police station #7
-- X: 479.6391 
-- Y: -976.6794 
-- Z: 26.9839
-- Heading: 331.7253

-- Cayo perico
-- Copied from here:
-- https://forum.cfx.re/t/the-cayo-perico-island-available-for-fivem/1897446
local requestedIpl = { "h4_islandairstrip", "h4_islandairstrip_props", "h4_islandx_mansion", "h4_islandx_mansion_props",
	"h4_islandx_props", "h4_islandxdock", "h4_islandxdock_props", "h4_islandxdock_props_2", "h4_islandxtower",
	"h4_islandx_maindock", "h4_islandx_maindock_props", "h4_islandx_maindock_props_2", "h4_IslandX_Mansion_Vault",
	"h4_islandairstrip_propsb", "h4_beach", "h4_beach_props", "h4_beach_bar_props", "h4_islandx_barrack_props",
	"h4_islandx_checkpoint", "h4_islandx_checkpoint_props", "h4_islandx_Mansion_Office", "h4_islandx_Mansion_LockUp_01",
	"h4_islandx_Mansion_LockUp_02", "h4_islandx_Mansion_LockUp_03", "h4_islandairstrip_hangar_props",
	"h4_IslandX_Mansion_B", "h4_islandairstrip_doorsclosed", "h4_Underwater_Gate_Closed", "h4_mansion_gate_closed",
	"h4_aa_guns", "h4_IslandX_Mansion_GuardFence", "h4_IslandX_Mansion_Entrance_Fence", "h4_IslandX_Mansion_B_Side_Fence",
	"h4_IslandX_Mansion_Lights", "h4_islandxcanal_props", "h4_beach_props_party", "h4_islandX_Terrain_props_06_a",
	"h4_islandX_Terrain_props_06_b", "h4_islandX_Terrain_props_06_c", "h4_islandX_Terrain_props_05_a",
	"h4_islandX_Terrain_props_05_b", "h4_islandX_Terrain_props_05_c", "h4_islandX_Terrain_props_05_d",
	"h4_islandX_Terrain_props_05_e", "h4_islandX_Terrain_props_05_f", "H4_islandx_terrain_01", "H4_islandx_terrain_02",
	"H4_islandx_terrain_03", "H4_islandx_terrain_04", "H4_islandx_terrain_05", "H4_islandx_terrain_06", "h4_ne_ipl_00",
	"h4_ne_ipl_01", "h4_ne_ipl_02", "h4_ne_ipl_03", "h4_ne_ipl_04", "h4_ne_ipl_05", "h4_ne_ipl_06", "h4_ne_ipl_07",
	"h4_ne_ipl_08", "h4_ne_ipl_09", "h4_nw_ipl_00", "h4_nw_ipl_01", "h4_nw_ipl_02", "h4_nw_ipl_03", "h4_nw_ipl_04",
	"h4_nw_ipl_05", "h4_nw_ipl_06", "h4_nw_ipl_07", "h4_nw_ipl_08", "h4_nw_ipl_09", "h4_se_ipl_00", "h4_se_ipl_01",
	"h4_se_ipl_02", "h4_se_ipl_03", "h4_se_ipl_04", "h4_se_ipl_05", "h4_se_ipl_06", "h4_se_ipl_07", "h4_se_ipl_08",
	"h4_se_ipl_09", "h4_sw_ipl_00", "h4_sw_ipl_01", "h4_sw_ipl_02", "h4_sw_ipl_03", "h4_sw_ipl_04", "h4_sw_ipl_05",
	"h4_sw_ipl_06", "h4_sw_ipl_07", "h4_sw_ipl_08", "h4_sw_ipl_09", "h4_islandx_mansion", "h4_islandxtower_veg",
	"h4_islandx_sea_mines", "h4_islandx", "h4_islandx_barrack_hatch", "h4_islandxdock_water_hatch", "h4_beach_party" }


-- TODO Setup toggle for this in the menu
-- local World.cayoPericoEnabled = false

-- TODO Setup removing ipls for cayo perico in menu

-- This works for removing the heist island ipls, I just changed the RequestIpl to RemoveIpl
local function removeIpls()
	CreateThread(function()
		for i = #requestedIpl, 1, -1 do
			RemoveIpl(requestedIpl[i])
			requestedIpl[i] = nil
		end
		requestedIpl = nil
	end)
end

if cayoPericEnabled then
	CreateThread(function()
		for i = #requestedIpl, 1, -1 do
			RequestIpl(requestedIpl[i])
			requestedIpl[i] = nil
		end
		requestedIpl = nil
	end)

	-- TODO Implement this into my system.
	CreateThread(function()
		while true do
			SetRadarAsExteriorThisFrame()
			SetRadarAsInteriorThisFrame("h4_fake_islandx", vec(4700.0, -5145.0), 0, 0)
			Wait(0)
		end
	end)

	CreateThread(function()
		Wait(2500)
		local islandLoaded = false
		local islandCoords = vector3(4840.571, -5174.425, 2.0)
		SetDeepOceanScaler(0.0)
		while true do
			local pCoords = GetEntityCoords(PlayerPedId())
			if (pCoords - islandCoords) < 2000.0 then
				if not islandLoaded then
					islandLoaded = true
					-- This is required for the path nodes at Cayo Perico
					-- SET_ALLOW_STREAM_HEIST_ISLAND_NODES
					Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 1)
				end
			else
				if islandLoaded then
					islandLoaded = false
					-- SET_ALLOW_STREAM_HEIST_ISLAND_NODES
					Citizen.InvokeNative(0xF74B1FFA4A15FBEA, 0)
				end
			end
			Wait(5000)
		end
	end)
end

--#region
