-- Player {}
-- Player.Functions {}

-- I couldn't get it working like this.
-- function Player.Functions.HealPlayer()

-- I'm working on moving functions outside of menu_test.lua into here, also I'll add functions 
-- from my kc_test resource
function HealPlayer()
    SetEntityHealth(PlayerPedId(), 200)
    -- SetEntityMaxHealth(PlayerPedId())
    SetPedArmour(PlayerPedId(), 100)
    ScaleformUI.Notifications:ShowNotification("You have been healed", false, false)
end

function GetVehicleId()
    local player = GetPlayerPed(-1)
    if IsPedInAnyVehicle(player, false) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        sendMessage(("Your vehicle entity id is: %s"):format(vehicle, netId))
        -- notify(netId)
    end
end

-- TODO Fix this to work, I think it used to work.
function ToggleKersBoost()
    local player = GetPlayerPed(-1)

    local isInVehicle = IsPedInAnyVehicle(player, false)
    local vehicle = GetVehiclePedIsIn(player, false)
    local getKers = GetVehicleHasKers(vehicle)

    if isInVehicle then
        -- If vehicle doesn't have kers boost, enable it
        if getKers then
            SetVehicleKersAllowed(vehicle, true)
            notify("Enabled kers boost for vehicle.")
        else
            SetVehicleKersAllowed(vehicle, false)
            notify("Disabled kers boost for vehicle.")
        end
    else
        notify("You need a vehicle for this!")
    end
end

function BlowupPlayer()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x,y,z = playerPos.x, playerPos.y, playerPos.z

    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    if IsPedInAnyVehicle(player) then
        local vehicle = GetVehiclePedIsIn(player, false)
        notify("Your car is going to ~r~explode~s~ in 2 seconds.")
        -- sendMessage("Your car is going to ~r~explode~s~ in 2 seconds.")
        Wait(2000)
        ExplodeVehicle(vehicle, true, false)

        -- Well the gas pump kills me even if I try to run away.
        AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    else
        notify("You are going to ~r~explode~s~ in 2 seconds.")
    -- sendMessage("You are going to ~r~explode~s~ in 2 seconds.")
    Wait(2000)

    -- Well the gas pump kills me even if I try to run away.
    AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    end
end

