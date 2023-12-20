-- TODO Make this get a list of values from spawns.lua 

-- https://forum.cfx.re/t/help-how-to-place-coordinates-in-value-using-lua-scripting/840646/4

player_spawns = {}
-- Add to table test.
-- Adding to tables like below is how i want this to work.
-- TODO Make this grab a random one of these.
player_spawns.ls1 = {x = 222.2027, y= -864.0162, z= 30.2922}
player_spawns.armyb1 = {x = -1853.68, y= 2815.78, z= 32.81}

-- Middle of Los Santos
-- table.insert(player_spawns, {Name = "LS1", Loc = vector3(222.2027, -864.0162, 30.2922)})
-- table.insert(player_spawns, {Name = "LS1", x = 222.2027, y= -864.0162, z= 30.2922})
-- -- -- Army base
-- table.insert(player_spawns, {Name = "ARMY1", x = -1853.68, y= 2815.78, z= 32.81})
-- table.insert(player_spawns, {Name = "ARMY1", Loc = vector3(-1853.68, 2815.78, 32.81)})
--Mount chilliad
-- table.insert(player_spawns, {Name = "MntChld", x = 2, y=2, z=2})

RegisterCommand('spawns', function()
    print('LS X coord: ' .. player_spawns.ls1.x)
    print('Army base X coord: ' .. player_spawns.armyb1.x)
    -- Testing getting random value from x coords, i'm sure there's a better way to do this.
    -- local randomVar = player_spawns[math.random(player_spawns.armyb1.x, player_spawns.ls1.x)]
    -- local randomVar = math.random(player_spawns.ls1.x, player_spawns.armyb1.x)
    -- print("Random X coord: " .. randomVar)


    -- for i, spawns in ipairs(player_spawns) do
    --     -- print(spawns["x"])
    -- end
end, false)
