-- TODO Test this.
RegisterCommand("stoptask", function()
    ClearPedTasks(GetPlayerPed(-1))
    notify("Your tasks have been cleared!")
end, false)