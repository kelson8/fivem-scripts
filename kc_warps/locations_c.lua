-- Pos is the position to set the marker at.

-- Tpto is the position to teleport the player to.

-- Submarker - Not exactly sure what this one is, I think it's a secondary marker.

-- Marker - Is the id of the marker for the waypoint.
-- Using this one below
-- Vertical Cylinder:
-- https://docs.fivem.net/docs/game-references/markers/

local spawn = vector3(222.2027, -864.0162, 29.2922)
local casino_entry = vector3(924.05, 48.21, 81.11)

-- Scale - The size of the marker.
-- Rgba - Colors of the marker.
-- Todo Add location names to these markers later.

locations = {
    {
        pos = {x = -676.2, y = 94.2, z = 54.5},
        tpto = {x = -663.1, y = 77.81, z = 50.25},
        text_name = "Test1",
        submarker = {
            marker = 29,
            posz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155}
    },
    {
        pos = {x = -657.97, y = 84.14, z = 52.06},
        tpto = {x = -640.92, y = 82.23, z = 51.44},
        text_name = "Test2",
        submarker = {
            marker = 29,
            posz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155}
    },

    {
        pos = {x = -666.15, y = 46.65, z = 40.40},
        tpto = {x = -618.3, y = 34.47, z = 43.53},
        text_name = "Test3",
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155}
    },

    -- FIB Building Los Santos
    -- X = 121.6, Y = -759.33, Z = 45.75
    {
        -- Middle of Los Santos marker #1 teleport to FIB Building
        pos = {x = 236.2, y = -874.9, z = 29.49},
        tpto = {x = 121.6, y = -759.33, z = 45.75},
        text_name = "FIB Building",
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155}
    },


    -- TODO Adapt these! They seem to break teleporting if I enable them.
    -- TODO Make my warp function draw text on top of these like in the scale form tests.
    -- {
    --     -- Middle of Los Santos marker #2 teleport to CEO Office
    --     pos = {x = 234.11, y= -881.61, z = 29.49},
    --     -- text_pos = { x = 234.11, y = -881.61, z = 31.49},
    --     tpto = {x = -1378,  y = -504.27, z = 33.16},
    --     text_name = "CEO Office",
        
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     rgba = {120, 255, 120, 155},
    --     -- text_rgba = {0, 100, 50, 255}
    -- },
    -- {
    --     -- Middle of Los Santos marker #3 teleport to Race #1
    --     pos = vector3(232.11, -881.61, 29.49),
    --     text_pos = vector3(232.11, -881.61, 31.49),
    --     text_name = "Race #1",
    --     tpto = vector3(2663.59, 5008.06, 44.25),
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     rgba = {120, 255, 120, 155},
    --     text_rgba = {0, 100, 50, 255}
    -- },

    -- {
    --     -- Middle of Los Santos marker #3 teleport to Race #2
    --     pos = vector3(230.11, -881.61, 29.49),
    --     text_pos = vector3(230.11, -881.61, 31.49),
    --     text_name = "Race #2",
    --     tpto = vector3(2663.59, 5008.06, 44.25),
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     rgba = {120, 255, 120, 155},
    --     text_rgba = {0, 100, 50, 255}
    -- },

    -- {
    -- --     -- FIB building teleport to spawn
    --     pos = {x = 95.27, y = -740.65, z = 44.76},
    --     text_pos = {x = 95.27, y = -740.65, z = 46.76},
    --     text_name = "Spawn",
    --     -- I set this as a vector that I defined.
    --     -- tpto = vector3(924.05, 48.21, 81.11),
    --     tpto = spawn,
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     rgba = {120, 255, 120, 255},
    --     text_rgba = {0, 100, 50, 255}
    -- },
    --

}