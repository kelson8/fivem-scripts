-- TODO Make this get a list of values from spawns.lua 

--for k,v in pairs(player_spawns) do
--    print(v,[3])
--end

--x = player_spawns.x

-- function loadSpawns()
--     local data = json.decode(player_spawns)

--     for i, spawns in ipairs(data.spawns) do
--         print(spawns)
--     end
-- end

player_spawns = {}
--Add to table test.

-- Middle of Los Santos
-- table.insert(player_spawns, {Name = "LS1", Loc = vector3(222.2027, -864.0162, 30.2922)})
-- -- Army base
-- table.insert(player_spawns, {Name = "ARMY1", Loc = vector3(-1853.68, 2815.78, 32.81)})
--Mount chilliad
table.insert(player_spawns, {Name = "MntChld", x = 2, y=2, z=2})

RegisterCommand('spawns', function()
    -- posX, posY, posZ = table.unpack(player_spawns[1])
    -- print(posX)
    for i, spawns in ipairs(player_spawns) do
        print(spawns)
        -- posX, posY, posZ = table.unpack(player_spawns.Loc)
        -- posX, posY, posZ = table.unpack(spawns.Loc)
        -- print(posX, posY, posZ)
    end
end, false)

-- RegisterCommand('spawns', function()
--     --loadSpawns(player_spawns)

--     -- This grabs the x coord on both of the spawn locations, try to narrow it down to one.
    -- for i, spawns in ipairs(player_spawns) do
    --     print (spawns.x)
--     end

-- end, false)