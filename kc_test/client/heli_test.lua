-- Search light for helicopters:
-- DoesVehicleHaveSearchlight() -- https://docs.fivem.net/natives/?_0x99015ED7DBEA5113
-- SetVehicleSearchlight(heli, true, true) -- https://docs.fivem.net/natives/?_0x14E85C5EE7A4D542
-- IsVehicleSearchlightOn() -- https://docs.fivem.net/natives/?_0xC0F97FCE55094987

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- This seems to work fine.
function checkVehicleSearchLight()
    local ped = GetPlayerPed(-1)

    if IsPedInAnyVehicle(ped, false) then
        local currentVehicle = GetVehiclePedIsIn(ped, false)
        if DoesVehicleHaveSearchlight(currentVehicle) then
            notify("The vehicle has a searchlight.")
        else
            notfiy("The vehicle does not have a searchlight.")
        end
    else
        notify("You are not in a vehicle!")
    end
end
RegisterCommand("searchlight", checkVehicleSearchLight, false)

function toggleVehicleSearchLight()
    local ped = GetPlayerPed(-1)
    if IsPedInAnyVehicle(ped, false) then
        local currentVehicle = GetVehiclePedIsIn(ped, false)

        if DoesVehicleHaveSearchlight(currentVehicle) then
            if not IsVehicleSearchlightOn(currentVehicle) then
                notify("On.")
                SetVehicleSearchlight(currentVehicle, true, false)
            else
                notify("Off.")
                SetVehicleSearchlight(currentVehicle, false, false)
                
            end
        end
    end
end

RegisterCommand("togglelight", toggleVehicleSearchLight, false)
