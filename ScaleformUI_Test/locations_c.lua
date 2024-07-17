-- Added text position to be above the markers a bit
-- Added text name to the markers.
-- Todo Simplify this like they do in online-interiors/teleports.lua

local spawn = vector3(222.2027, -864.0162, 29.2922)
local casino_entry = vector3(924.05, 48.21, 81.11)

-- Todo Move the teleports into their own variables, make this file a bit neater.
-- local casino_exit = vector3()

locations = {
    {
        pos = vector3(-676.2, 94.2, 54.5),
        text_pos = vector3(-676.2, 94.2, 55.5),
        text_name = "Test1",
        tpto = vector3(-663.1, 77.81, 50.25),
        submarker = {
            marker = 29,
            posz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },
    {
        pos = vector3(-657.97, 84.14, 52.06),
        text_pos = vector3(-657.97, 84.14, 53.06),
        text_name = "Test2",
        tpto = vector3(-640.92, 82.23, 51.44),
        submarker = {
            marker = 29,
            posz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },

    {
        pos = vector3(-666.15, 46.65, 40.40),
        text_pos = vector3(-666.15, 46.65, 41.40),
        text_name = "Test3",
        tpto = vector3(-618.3, 34.47, 43.53),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },

    -- FIB Building Los Santos
    -- X = 121.6, Y = -759.33, Z = 45.75
    {
        -- Middle of Los Santos marker #1 teleport to FIB Building
        pos = vector3(236.2, -874.9, 29.49),
        text_pos = vector3(236.2, -874.9, 31.49),
        text_name = "FIB Building",
        tpto = vector3(121.6, -759.33, 45.75),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },

    {
        -- Middle of Los Santos marker #2 teleport to CEO Office
        pos = vector3(234.11, -881.61, 29.49),
        text_pos = vector3(234.11, -881.61, 31.49),
        text_name = "CEO Office",
        tpto = vector3(-1378, -504.27, 33.16),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },
    {
        -- Middle of Los Santos marker #3 teleport to Race #1
        pos = vector3(232.11, -881.61, 29.49),
        text_pos = vector3(232.11, -881.61, 31.49),
        text_name = "Race #1",
        tpto = vector3(2663.59, 5008.06, 44.25),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },

    {
        -- Middle of Los Santos marker #3 teleport to Race #2
        pos = vector3(230.11, -881.61, 29.49),
        text_pos = vector3(230.11, -881.61, 31.49),
        text_name = "Race #2",
        tpto = vector3(2663.59, 5008.06, 44.25),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155},
        text_rgba = {0, 100, 50, 255}
    },

    {
        -- FIB building teleport to spawn
        pos = vector3(95.27, -740.65, 44.76),
        text_pos = vector3(95.27, -740.65, 46.76),
        text_name = "Spawn",
        -- I set this as a vector that I defined.
        tpto = vector3(924.05, 48.21, 81.11),
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 255},
        text_rgba = {0, 100, 50, 255}
    },

    -- {
    --     -- Casino Exit
    --     pos = vector3(2468.93, -286.9, -59.28),
    --     text_pos = vector3(2468.93, -286.9, -58.70),
    --     text_name = "Exit Casino",
    --     -- I set this as a vector that I defined.
    --     -- tpto = vector3(2474.37, -282.61, -58.28),
    --     tpto = vector3(920.79, 55.44, 80.9),
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     -- rgba = {120, 255, 120, 155}
    --     rgba = {50, 130, 255, 155},
    --     -- text_rgba = {0, 100, 50, 255}
    --     text_rgba = {130, 0, 200, 255}
    -- },

    -- {
    --     -- Casino Entry
    --     pos = vector3(922.63, 48.36, 80.11),
    --     text_pos = vector3(922.63, 48.36, 80.11),
    --     text_name = "Enter Casino",
    --     -- I set this as a vector that I defined.
    --     tpto = vector3(2473.14, -281.72, -58.28),
    --     submarker = {
    --         marker = 29,
    --         poz = 15.25,
    --     },
    --     marker = 1,
    --     scale = 2.0,
    --     -- rgba = {120, 255, 120, 155}
    --     rgba = {50, 130, 255, 155},
    --     -- text_rgba = {0, 100, 50, 255}
    --     text_rgba = {130, 0, 200, 255}
    --     },
}
