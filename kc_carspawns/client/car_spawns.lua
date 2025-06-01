-- Vehicle spawn locations and names.
-- Todo Fix colors to work for this, I tried a couple of things and couldn't figure it out.

-- TODO Add secondary colors to these values and in the spawn code.
-- colorsSecondary = {r = 22, g = 0, b = 22}

vehicle_spawns = {

    --------
    -- Ceo office garage floor 1
    --------
    {
        -- Ceo office garage, vehicle #1
        pos = vector3(-1370.4, -474.18, 49.1),
        heading = 93.89,
        -- Motorcycle
        vehiclename = "nemesis",
        -- Red
        colors = {r = 255, g = 0, b = 0},
    },
    {
        -- Ceo office garage, vehicle #2
        pos = vector3(-1374.39, -472.18, 49.1),
        heading = 168.88,
        -- Turismo Classic
        vehiclename = "turismo2",
        -- Yellow?
        colors = {r = 200, g = 200, b = 0},
    },

    {
        -- Ceo office garage, vehicle #3
        pos = vector3(-1379.39, -471.18, 49.1),
        heading = 168.88,
        -- Super car
        vehiclename = "tigon",
        -- Pink
        colors = {r = 210, g = 0, b = 150},
    },

    {
        -- Ceo office garage, vehicle #4
        pos = vector3(-1385.66, -472.38, 49.1),
        heading = 184.88,
        -- Massacro Racecar
        vehiclename = "massacro2",
        -- Blue
        colors = {r = 22, g = 0, b = 150},
        -- TODO Add secondary colors to these values
        -- colorsSecondary = {r = 22, g = 0, b = 22}
    },

    {
        -- Ceo office garage, vehicle #5
        pos = vector3(-1390.71, -472.54, 49.1),
        heading = 180.91,
        -- New car #1 (Bottom dollar bounties)
        vehiclename = "pipistrello",
        -- Blue
        colors = {r = 22, g = 0, b = 150},
        -- TODO Add secondary colors to these values
        -- colorsSecondary = {r = 22, g = 0, b = 22}
    },

    --------
    --
    --------


    --------
    -- Casino garage
    --------

    -- Casino garage spot #1
    {
        pos = vector3(1380.35, 211.69, -48.99),
        heading = 91.19,
        -- vehicleName = "jackal",
        -- Super car
        vehiclename = "tigon",
        -- Red
        colors = {r = 255, g = 0, b = 0},

    },

    -- Casino garage spot #2
    {
        pos = vector3(1380.35, 207.55, -48.99),
        heading = 91.19,
        -- vehicleName = "jackal",
        -- Tow truck
        vehiclename = "towtruck2",
        -- Red
        colors = {r = 255, g = 0, b = 0},
    },

    -- Casino garage spot #3
    {
        pos = vector3(1380.35, 217.31, -48.99),
        heading = 91.19,
        vehiclename = "gauntlet4",
        -- Red
        colors = {r = 255, g = 0, b = 0},
    },
    -- Casino garage spot #4
    {
        pos = vector3(1380.35, 221.27, -48.99),
        heading = 91.19,
        vehiclename = "dominator",
        -- Red
        colors = {r = 255, g = 0, b = 0},
    },
    --------
    --
    --------

    --------
    -- Military base hangars
    --------
    
    -- Right hanger
    {
        pos = vector3(-1823.57, 2972.06, 32.81),
        heading = 54.14,
        -- Plane
        vehiclename = "strikeforce",
        -- Red
        colors = {r = 255, g = 0, b = 0},
    },

    --------
    -- Misc
    --------

    -- Train tracks, To the right of the casino beside the Lake

    -- These are fun for screwing around with the train.
    -- {
    --     pos = vector3(2420.64, -342.27, 94.19),
    --     heading = 57.25,
    --     vehiclename = "dominator",
    --     -- Red
    --     colors = {r = 255, g = 0, b = 0},
    -- },

    -- -- Train tracks, Slightly to the right of the bunker
    -- {
    --     pos = vector3(2973.67, 3800.85, 55.1),
    --     heading = 77.68,
    --     -- Tank, lets cause some mayham on the tracks
    --     vehiclename = "khanjali",
    --     -- Red
    --     colors = {r = 255, g = 0, b = 0},
    -- },

    -- {
    --     pos = vector3(-657.97, 84.14, 52.06),
    -- },

    -- {
    --     pos = vector3(-666.15, 46.65, 40.40),
    -- },


    -- {
    --     pos = vector3(236.2, -874.9, 29.49),
    -- },

    -- {
    --     pos = vector3(234.11, -881.61, 29.49),
    -- },
}
