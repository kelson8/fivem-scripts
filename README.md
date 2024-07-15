# Resources info
These are going to be for the custom FiveM server that I am working on.

I'm mostly just doing this to learn lua a bit more and scripting with FiveM.

The ch_gamemode and ch_map resources aren't needed to be loaded in, I fixed ch_spawn so it will respawn the players.

To enable these resources add the following to the server.cfg.

* ensure kc_car
* ensure kc_spawn
* ensure kc_map
* ensure kc_weapon
* ensure help
* ensure kc_test
* ensure kc_vehiclecontrol


* New:
* ensure kc_player
* ensure StreetRaces
* ensure kc_warps
* ensure kc_test


Custom menu that I am working on in lua with ScaleformUI
* ensure ScaleformUI_Assets
* ensure ScaleformUI_Lua
* ensure ScaleformUI_Test

# Resource list
* kc_car - Basic car spawning and removal
* kc_map - Basic map
* kc_spawn - Basic player spawning and gamemode
* kc_weapon - Gives player weapon on spawn.
* chat_stuff - I haven't added anything to this.
* help - Help messages for my server.
* kc_test - Testing scripts, tons of test commands and features.
* kc_vehiclecontrol - Adds hood and trunk control with page up and page down buttons.

New:
* Your client will most likely crash when rejoining due to the ScaleformUI: https://github.com/manups4e/ScaleformUI/issues/213
* Assets and files needed for ScaleformUI_Test
------
* ScaleformUI_Assets -- Download from https://github.com/manups4e/ScaleformUI for latest version.
* ScaleformUI_Lua -- Download from https://github.com/manups4e/ScaleformUI for latest version.
* ScaleformUI_Test -- Custom resouce that I am working on using a gui that can give the players god mode, eventually spawn in cars and stuff like that.


# Features
* kc_vehiclecontrol
* Adds hood and trunk control with page up and page down buttons. 
* Adds Window controls with delete and insert.

---
* kc_warps - Add support for the custom teleport markers on the map that can be defined in [locations_c.lua](https://github.com/kelson8/fivem-scripts/blob/main/kc_warps/locations_c.lua)

*  kc_teleporter - Basic teleport system for players located in [kc_teleporter](https://github.com/kelson8/fivem-scripts/tree/main/kc_teleporter)

* kc_car - Add save personal vehicles, spawn vehicles with command, spawn random car from list.
 This can add a vehicle with a custom blip, I don't think I figured out how to make the blip disappear if the vehicle explodes though. Located here [kc_car](https://github.com/kelson8/fivem-scripts/tree/main/kc_car)


* kc_gamemode - Basic onClientMapStart resource
* kc_map - Basic map with locations, this needs to be setup to work with a config.
---
* kc_menu - Basic menu using nativeui, I would rather use the ScaleformUi one
* kc_messages - Currently just death messages.

* kc_player - Get players interior, current position, teleport to spawn, suicide option, check max wanted level.

* kc_weapon - Give players a weapon with a command, attatchment option not working yet. This needs to be setup to get the weapon to spawn in with from the config.



#### Testing Features
* kc_database - Testing database functions, currently prints vehicles out of the database.
* kc_typescript - Testing typescript fivem functions.
* kc_nui - Testing nui functions with javascript.
* kc_test - 
* Population functions - taken the idea for a config and for enabling/disabling police into my own resource so I know where it is at.
* Helicopter testing - check if vehicle has searchlight, toggle searchlight.
* Ped Test - spawn peds to fight. 
* Spawn a ped to drive you to a marker. If you get out of the car they'll keep going. I need to figure out how to make them stop. Possibly lock the player inside and make make a /stopvehicle command for it or something.
Spawn ped and return its Entity ID
* Player test - So far I just have alerts, advanced notifcations, busy spinners and subtitles in this, I need to move these somewhere else.
* test.lua - Misc testing and random stuff in here.


---
* [Original link](https://github.com/bepo13/FiveM-StreetRaces) for below resource, I did not create this, I have modified it to have a gui, credit goes to [bepo13](https://github.com/bepo13) on github.
* Street races - I am working on making a custom gui for the StreetRaces resource, this mostly works but a few bugs need fixed before I will make a release for it, I haven't figured out how to make it to where markers aren't placed when a race is loaded.

# Commands
#### Car
* /car <name> -- Gives you a car with the specified name.
* /rndcar -- Give you a random car from the list
* /dv -- Remove your current vehicle
* /savepv -- Save your current vehicle as a personal vehicle into the database. I don't think this makes a persistant blip for it.

#### Not implemented
* /pv -- Spawn in your vehicle with the id from the database.
* /deletepv -- Delete your vehicle with the id from the database.

#### Weapon
* /weaponall -- Gives you all weapons.
* /clear -- Removes all weapons from your inventory.

# Todo
Add features:
* Custom menus for car spawning, weapon spawning, player skins, god mode toggles and stuff like that.
