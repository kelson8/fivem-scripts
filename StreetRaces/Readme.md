This code came from a forked repo, I cannot remember which one it was.

So far I have the following items working in the gui:
* Markers for creating races
* Saving races
* Listing races
* Deleting races
* Cancel race
* Load race
* Start race

Still needs done: 
* Leave race
* Unload race - Unload the race if it's not started

I disabled the races_cl.lua in the fxmanifest and moved all the functions over to my gui, it started working once I did that.

Try to make this read the list of races from the json so the user can just select it from a list for loading, and deleting.

Keybind to bring up menu (F5) {I will try to add a config for this later on.}

All credit goes to the below author, I did not create this only expanded onto it. This will be released on github once I have it completed.

Original creator: bepo13

Original repo is here: https://github.com/bepo13/FiveM-StreetRaces