RegisterNetEvent("db_test:notifyClient")
AddEventHandler("db_test:notifyClient",
    function (msg)
        SetNotificationTextEntry("STRING")
        AddTextComponentString(msg)
        DrawNotification(true, false)
end)