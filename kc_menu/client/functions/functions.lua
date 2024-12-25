-- Fade the screen in and out for a teleport, so it's not instant.
function FadeScreenForTeleport()
    local player = GetPlayerPed(-1)
    -- Test moving this into the thread.
    DoScreenFadeOut(500)
    FreezeEntityPosition(player, true)

    while not IsScreenFadedOut() do
        Wait(0)
    end

    Wait(500)
    DoScreenFadeIn(500)
    FreezeEntityPosition(player, false)
end

-- Check if game build is 3258 or higher, needed for the bounty office
function VersionCheck()
    local version = GetGameBuildNumber()
    if version >= 3258 then
        return true
    end
    return false
end

function CayoPericoVersionCheck()
    local verison = GetGameBuildNumber()
    local cayoPercio = 2189
    if verison >= cayoPercio then
        return true
    end
    return false
end

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = { msg, },
    })
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Set the player coords, without needing to specify all of the boolean values
function setPlayerCoords(player, x, y, z)
    SetEntityCoords(player, x, y, z, true, false, false, false)
end

-- Notifications

function showAdvancedNotification(message, sender, subject, textureDict, iconType, saveToBrief, color)
    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(message)
    ThefeedNextPostBackgroundColor(color)
    EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
    EndTextCommandThefeedPostTicker(false, saveToBrief)
end

-- Other
-- Busy spinners

local busySpinner = false
function showBusySpinner(message)
    if not busySpinner then
        BeginTextCommandBusyspinnerOn("STRING")
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandBusyspinnerOn(5)
        busySpinner = true
    else
        BusyspinnerOff()
        busySpinner = false
    end
end

function hideBusySpinner()
    if busySpinner then
        BusyspinnerOff()
    end
end

-- RegisterCommand('testspinner', function(_, _, rawCommand)
--     if rawCommand == 'testspinner' then
--         hideBusySpinner()
--     else
--         showBusySpinner(rawCommand)
--     end
-- end, false)

--

-- Subtitles
function showSubtitle(message, duration)
    BeginTextCommandPrint("STRING")
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
    -- BeginTextCommandBusyspinnerOn()
end

--

function blowupPlayer()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x, y, z = playerPos.x, playerPos.y, playerPos.z

    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    if IsPedInAnyVehicle(player) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehX, vehY, vehZ = GetEntityCoords(vehicle)

        notify("Your car is going to ~r~explode~s~ in 2 seconds.")
        -- Stop the vehicle instantly.
        BringVehicleToHalt(vehicle, 0.1, 1, 1)

        -- This didn't seem to work
        ExplodeVehicle(vehicle, true, false)
        -- Just for good measure, you can't escape anymore
        SetVehicleBodyHealth(vehicle, 0)
        SetVehicleWheelHealth(vehicle, 0)
        SetVehicleEngineHealth(vehicle, 0)
        SetVehiclePetrolTankHealth(vehicle, 0)

        -- Disable the vehicle engine
        SetVehicleEngineOn(vehicle, false, true, true)

        Wait(2000)
        -- This kills the player but the car won't blow up
        -- SetVehicleOutOfControl(vehicle, false, true)

        AddOwnedExplosion(player, x, y, z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    else
        notify("You are going to ~r~explode~s~ in 2 seconds.")
        Wait(2000)

        AddOwnedExplosion(player, x, y, z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    end
end


-- Blip test, not sure how to make this work
blip = nil

blipEnabled = false

function getBlipEnabled()
    return blipEnabled
end

function setBlipEnabled()
    blipEnabled = true
end

function setBlipDisabled()
    blipEnabled = false
end

function createBlipTest()
    local player = GetPlayerPed(-1)
    -- local player = GetPlayerPed(-1)
    -- Set the blip to random area
    -- Sets it to the bridge beside the casino
    -- if blipEnabled then
        blip = AddBlipForArea(782.17, -37.28, 82.2, 5, 5)
        SetBlipSprite(blip, 598)
        SetBlipRotation(blip, Ceil(GetEntityHeading(player)))

        -- SetBlipRoute(blip, true)
        -- blipEnabled = true
    -- end
    -- if DoesBlipExist(blip) then
    --     SetBlipRotation(blip, )
    -- end
end

function removeBlipTest()
    -- if blipEnabled then
        RemoveBlip(blip)
        -- blipEnabled = false
    -- end

end
