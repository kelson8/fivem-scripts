# Resources info
These are going to be for the custom FiveM server that I am working on.

I'm mostly just doing this to learn lua a bit more and scripting with FiveM.

The ch_gamemode and ch_map resources aren't needed to be loaded in, I fixed ch_spawn so it will respawn the players.

To enable these resources add the following to the server.cfg.

* ensure ch_car
* ensure ch_spawn
* ensure ch_map
* ensure ch_weapon
* ensure help
* ensure ch_test
* ensure ch_vehiclecontrol

# Resource list
* ch_car - Basic car spawning and removal
* ch_map - Basic map
* ch_spawn - Basic player spawning and gamemode
* ch_weapon - Gives player weapon on spawn.
* chat_stuff - I haven't added anything to this.
* help - Help messages for my server.
* ch_test - Testing scripts
* ch_vehiclecontrol - Adds hood and trunk control with page up and page down buttons. Window


# Features
* ch_vehiclecontrol
* Adds hood and trunk control with page up and page down buttons. 
* Adds Window controls with delete and insert.

# Commands
* /car <name> -- Gives you a car with the specified name.
* /weaponall -- Gives you all weapons.

# Todo
Add features:
* Give all weapons command.
* Custom menus for car spawning, weapon spawning, player skins, god mode toggles and stuff like that.
