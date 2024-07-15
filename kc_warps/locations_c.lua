-- Pos is the position to set the marker at.

-- Tpto is the position to teleport the player to.

-- Submarker - Not exactly sure what this one is, I think it's a secondary marker.

-- Marker - Is the id of the marker for the waypoint.
-- Using this one below
-- Vertical Cylinder:
-- https://docs.fivem.net/docs/game-references/markers/


-- Scale - The size of the marker.
-- Rgba - Colors of the marker.
-- Todo Add location names to these markers later.

locations = {
    {
        pos = {x = -676.2, y = 94.2, z = 54.5},
        tpto = {x = -663.1, y = 77.81, z = 50.25},
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
        submarker = {
            marker = 29,
            poz = 15.25,
        },
        marker = 1,
        scale = 2.0,
        rgba = {120, 255, 120, 155}
    },
}