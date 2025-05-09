-- TODO Replicate the car wash from the game scripts

-- Variables
local playerVeh = nil

-- Message functions

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

--

function sendMessage(msg)
    TriggerEvent('chat:addMessage', {
        args = {msg, },
    })
end

-- Check if the ped is in a vehicle
function isPedInAnyVehicle(player)
    return IsPedSittingInAnyVehicle(player)
end

-- Get the players current vehicle, store to playerVeh variable

function getPlayerVehicle(player)
    if isPedInAnyVehicle(player) then
        local vehicle = GetVehiclePedIsIn(ped, false)
        playerVeh = vehicle
    end
end

-- Setup the car wash command, I will also set a warp to one of these.
-- For now this will just clear the dirt off of the current vehicle
RegisterCommand("carwash", function()
    local player = GetPlayerPed(-1)
    -- This is setting the playerVeh variable
    getPlayerVehicle(player)

    -- Check if ped is in a vehicle, and the playerVeh variable is set.
    if isPedInAnyVehicle(player) and playerVeh ~= nil then
        SetVehicleDirtLevel(playerVeh, 0.0)
        notify("Your car has been cleaned.")
    else
        notify("You need a vehicle for this!")

    end
end)