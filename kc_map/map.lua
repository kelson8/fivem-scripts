-- Todo, setup this to where it grabs values from a list of spawn points defined in a file.

-- TODO Setup this to where it spawns me in as a certain skin as a test.
-- player_one is franklin
-- Los Santos
-- Set the spawns to be the middle of Los santos
spawnpoint 'player_one' { x = 222.2027, y = -864.0162, z = 30.2922 } -- Middle of Los Santos
spawnpoint 'a_m_m_bevhills_01' {x = 226.27, y = -807.3, z = 30.58}  -- Middle of Los Santos parking lot
spawnpoint 'a_m_m_bevhills_02' {x = 226.27, y = -807.3, z = 30.58}  -- Middle of Los Santos parking lot

-- Casino spawns
spawnpoint 'a_m_m_bevhills_01' {x = 925.329, y = 46.152, z = 80.908 } -- Casino Skin #1
spawnpoint 'a_m_m_bevhills_02' {x = 925.329, y = 46.152, z = 80.908 } -- Casino Skin #2




-- spawnpoint 'player_one' {x = 925.329, y = 46.152, z = 80.908 } -- Casino
-- spawnpoint 'player_one' {x = -695.025, y = 82.955, z = 55.855 } -- Epsilon Building

-- spawnpoint 'player_one' {x = -1330.911, y = 340.871, z = 64.078} -- Richman Hotel

--spawnpoint 'player_one' {x = -1853.68, y = 2815.78, z = 32.81 } -- Army base



-- tmp coords
-- Office garage 1A
-- Testing if this will work for spawn location inside the garage on server startup.
-- X: -1582.97 Y: -566.62 Z: 86.14
-- This instantly crashed lol, I think it's because the interior/IPL wasn't loaded in yet.
-- I wonder how to fix it, this works if I'm currently joined in but not if I spawn into that area after closing the client.
-- spawnpoint 'player_one' {x = -1582.97, y = -566.62, z = 86.14}
