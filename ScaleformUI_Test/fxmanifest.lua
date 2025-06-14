---
--- @authors Manups4e, PhilippRendell, Lacol9
---

-- This requires ScaleformUI.
dependencies {
    'ScaleformUI_Lua',
    -- 'kc_util'
}

fx_version 'cerulean'
game 'gta5'
lua54 'yes'

client_scripts {
	'@ScaleformUI_Lua/ScaleformUI.lua',
	'functions/teleport_functions.lua',
	'functions/player_functions.lua',
	'functions/ped_functions.lua',
    -- Menus
	'client/menu_test.lua',
	'client/lobby_menu_test.lua',
	'client/ls_customs_menu_test.lua',

	'client/locations.lua',
	
	-- 'example.lua',
}

files {
	'data/image1.jpeg',
	'data/chuunibyo1.gif',
}