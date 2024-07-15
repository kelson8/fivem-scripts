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
    }
    
    --

}
