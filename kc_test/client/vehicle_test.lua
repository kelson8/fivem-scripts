-- TODO Setup functions for submarine in the game
-- IsPedInAnySub() - https://nativedb.dotindustries.dev/gta5/natives/0xFBFC01CCFB35D99E


-- I wonder what I can do with the submarine on here.
function pedSubTest()
    local player = GetPlayerPed(-1)
    if IsPedInAnySub(player) then
        local sub = GetVehiclePedIsIn(player, false)
        -- https://nativedb.dotindustries.dev/gta5/natives/0x33506883545AC0DF
        ForceSubmarineSurfaceMode(sub, true)
        -- https://nativedb.dotindustries.dev/gta5/natives/0xC67DB108A9ADE3BE
        ForceSubmarineNeurtalBuoyancy(sub, 10000)
    end
end

-- TODO Test this
function planeTest()
    local player = GetPlayerPed(-1)
    if IsPedInAnyPlane(player) then
        local plane = GetVehiclePedIsIn(player, false)
        -- Turn off the stall warning sounds
        EnableStallWarningSounds(plane, false)
        -- This could be a good toggle if it works on FiveM
        -- SetAutoGiveParachuteWhenEnterPlane(player, true)
    end
end




-- TODO Test this
function cargoBobTest()
    local player = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local x,y,z = table.unpack(playerCoords)
    local heading = GetEntityHeading(player) + 90

    local heli = GetVehiclePedIsIn(player, false)
    local heliModel = IsVehicleModel(vehicle, "cargobob")

    local vehicleName = "cargobob"
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    -- Spawn a vehicle and make it not able to be picked up by the cargobob, not sure what the best
    -- way to store this is, should I make another function?
    -- local testVehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
    -- SetPickUpByCargobobDisabled(vehicle, true)

    -- Check if the vehicle is a cargobob
    if IsPedInAnyHeli(player) and heliModel then
        -- CanCargobobPickUpEntity()

    end
end

-- What will this do? This didn't do anything
-- RegisterCommand("emptest", function()
--     local player = GetPlayerPed(-1)
--     local vehicle = GetVehiclePedIsIn(player, false)
--     if vehicle ~= nil then
--         ApplyEmpEffect(vehicle)
--     end
-- end, false)

-- Disable the Deluxo and Opressor MK2 flying
-- https://docs.fivem.net/natives/?_0x2D55FE374D5FDB91
RegisterCommand("disablehover", function()
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)
    -- Check if vehicle is a Deluxo or Opperessor MK2
    local vehModel = IsVehicleModel(vehicle, "deluxo") or IsVehicleModel(vehicle, "oppressor2")
    if vehicle ~= nil and vehModel then
        SetDisableHoverModeFlight(vehicle, true)
        notify("Hovering disabled")
    end
end, false)

RegisterCommand("enablehover", function()
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)
    -- Check if vehicle is a deluxo or opressor
    local vehModel = IsVehicleModel(vehicle, "deluxo") or IsVehicleModel(vehicle, "oppressor2")
    if vehicle ~=nil and vehModel then
        SetDisableHoverModeFlight(vehicle, false)
        notify("Hovering enabled")
    end
end, false)

-- Quick test to get the vehicle model, this works.
RegisterCommand("vehmodel", function()
    local player = GetPlayerPed(-1)
    local vehicle = GetVehiclePedIsIn(player, false)

    local vehModel = IsVehicleModel(vehicle, "deluxo") or IsVehicleModel(vehicle, "oppressor2")

    if vehModel then
        notify("You are in a deluxo or oppressor mk2")
    else
        notify("You are not in the right vehicle!")
    end

end, false)