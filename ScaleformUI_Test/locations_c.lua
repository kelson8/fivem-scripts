-- Added text position to be above the markers a bit
-- Added text name to the markers.
-- Todo Simplify this like they do in online-interiors/teleports.lua

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
        rgba = {120, 255, 120, 155}
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
        rgba = {120, 255, 120, 155}
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
        rgba = {120, 255, 120, 155}
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
        rgba = {120, 255, 120, 155}
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
        rgba = {120, 255, 120, 155}
    },
}
