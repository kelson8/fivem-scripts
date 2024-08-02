-- Player {}
-- Player.Functions {}

-- I couldn't get it working like this.
-- function Player.Functions.HealPlayer()

local handCuffsEnabled = false
function ToggleHandcuffs()
    local player = GetPlayerPed(-1)
    if not handCuffsEnabled then
        SetEnableHandcuffs(player, true)
        handCuffsEnabled = true
    else
        SetEnableHandcuffs(player, false)
        handCuffsEnabled = false
    end
end

-- Run the test function

-- TODO See if this works properly
Citizen.CreateThread(function()
    while handCuffsEnabled do
        DisableControlAction(0, 12, false)
        DisableControlAction(0, 13, false)
        DisableControlAction(0, 14, false)
        DisableControlAction(0, 37, false)
    end
end)

local fakeWantedLevelToggle = false
function ToggleFakeWantedLevel()
    local player = GetPlayerPed(-1)
    if not fakeWantedLevelToggle then
        SetFakeWantedLevel(6)
        fakeWantedLevelToggle = true
    else
        SetFakeWantedLevel(0)
        fakeWantedLevelToggle = false
        -- SetEnableHandcuffs(player, true)
    end
end

function ToggleAnimTest()
    -- https://nativedb.dotindustries.dev/gta5/natives/0xEA47FE3719165B94?search=taskpl
    local player = GetPlayerPed(-1)
    -- local animDict = "missheist_agency3ashield_face"
    local animDict = "anim@heists@keypad@"
    -- local animName = "Shield_Face_Player1"
    local animName = "enter"

    -- Request the animation and wait on it
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(10)
    end
    -- If the animation has loaded

    if HasAnimDictLoaded(animDict) then
        moveSpeed = GetPedDesiredMoveBlendRatio(player)
        if IsMoveBlendRatioStill(moveSpeed) or IsMoveBlendRatioWalking(moveSpeed) then
            if not IsEntityPlayingAnim(player, animDict, animName, 3) then
                -- TaskPlayAnim(player, animDict, animName, 2, 2, -1, 48, 0, 0, 0, 0)
                TaskPlayAnim(player, animDict, animName, 8.0, 8.0, -1, 50, 0, false, false, false)
            -- Stop animation
            elseif IsEntityPlayingAnim(player, animDict, animName, 3) then
                -- StopAnimTask(player, animDict, animName, -4)
                StopAnimTask(player, animDict, animName, 1.1)
            end
        end
    end
end

-- https://forum.cfx.re/t/supplying-player-with-a-parachute/39065
function SpawnPedIntoAir()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)

    local x,y,z = table.unpack(playerPos)
    FadeScreenForTeleport()

    -- Give the player a parachute and force them to use it
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("gadget_parachute"), 1, false, false)
    TaskParachute(player, true, true)

    -- This didn't work.
    ForcePedToOpenParachute(player)
    -- Set the parachute on their back
    SetPedComponentVariation(player, 5, drawableId, textureId, 0)
    -- Set their coords
    SetEntityCoords(player, x, y, z + 100, false, false, false, false)
end

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

