Config = {}
-- "police_1", "v_ilev_ph_gendoor004", 450.1041, -985.7384, 30.8393, true, true, false

-- Set the locked value to 1 to automatically lock the doors
Config.Doors = {
    ['police_1'] = {
        DoorHash = "police_1",
        ModelHash = "v_ilev_ph_gendoor004",
        Coordinates = vector3(450.1041, -985.7384, 30.8393),
        Locked = 0,
    },

    -- Main police station doors (Front doors)
    ['police_2'] = {
        DoorHash = "police_2",
        ModelHash = "v_ilev_ph_door01",
        Coordinates = vector3(434.7479, -980.6184, 30.83926),
        Locked = 0,
    },

    ['police_3'] = {
        DoorHash = "police_3",
        ModelHash = "v_ilev_ph_door002",
        Coordinates = vector3(434.7479, -983.2151, 30.83926),
        Locked = 0,
    },

    -- Casino vault doors
    ['casino_vault'] = {
        DoorHash = "casino_vault",
        ModelHash = "ch_prop_ch_vaultdoor01x",
        Coordinates = vector3(2504.97, -240.3102, -70.17885),
        Locked = 1,
    },

    ['vault_door1'] = {
        DoorHash = "vault_door1",
        ModelHash = "ch_prop_ch_vault_slide_door_lrg",
        Coordinates = vector3(2519.936, -251.0514, -71.74525),
        Locked = 0,
    },

    --

    -- Casino doors
    -- Elevator door #1 in management office
    -- These don't go anywhere so I locked them.

    ['casino_elevator1'] = {
        DoorHash = "casino_elevator1",
        ModelHash = "v_ilev_garageliftdoor",
        Coordinates = vector3(2497.905, -226.2318, -61.32502),
        Locked = 1,
    },

    -- Elevator door #2 in management office
    ['casino_elevator2'] = {
        DoorHash = "casino_elevator2",
        ModelHash = "v_ilev_garageliftdoor",
        Coordinates = vector3(2499.409, -226.2315, -61.3271),
        Locked = 1,
    },


    ['management_office1'] = {
        DoorHash = "management_office1",
        ModelHash = "vw_prop_vw_casino_door_01a",
        Coordinates = vector3(2501.619, -230.3577, -60.17379),
        Locked = 0,
    },

    ['management_office2'] = {
        DoorHash = "management_office2",
        ModelHash = "vw_prop_vw_casino_door_01a",
        Coordinates = vector3(2501.619, -228.358, -60.17379),
        Locked = 0,
    },

    -- Misc
    -- Gate #1 at /spawn

    ['gate1_spawn'] = {
        DoorHash = "gate1_spawn",
        ModelHash = "prop_sec_barrier_ld_01a",
        Coordinates = vector3(230.9218, -816.153, 30.16897),
        Locked = 0,
    },

    ---------
    --- Penthouse doors
    ----------
    --- Door #1
    ['penthouse_door1'] = {
        DoorHash = "penthouse_door1",
        ModelHash = "vw_prop_vw_door_lounge_01a",
        Coordinates = vector3(973.8256, 54.3764, 116.81),
        Locked = 0,
    },

    -- Penthouse bathroom
    ['penthouse_bahtroomdoor1'] = {
        DoorHash = "penthouse_bahtroomdoor1",
        ModelHash = "vw_prop_vw_door_bath_01a",
        Coordinates = vector3(976.4456, 75.2526, 116.6326),
        Locked = 0,
    },


}
