-- X: 450.1041 Y: -985.7384 Z: 30.8393
-- Hash: v_ilev_ph_gendoor004



Citizen.CreateThread(function()
    local doors = GlobalState.doors

    if not doors then
        return
    end

    for k,v in pairs(doors) do
        AddDoorToSystem(v.DoorHash, v.ModelHash, v.Coordinates.x, v.Coordinates.y, v.Coordinates.z, true, true, false)
        DoorSystemSetDoorState(v.DoorHash, v.Locked, false, false)
    end

    AddDoorToSystem("police_1", "v_ilev_ph_gendoor004", doorX, doorY, doorZ, true, true, false)
end)


RegisterNetEvent("kc_doors:update", function(doorName, lockState)
    DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, lockState, false, false)
end)
