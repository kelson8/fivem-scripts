

local SetNopopulationLobbyButton = LobbyMenu:AddButton({
    label = "No population lobby",
    description = "Set you to the no population lobby, no vehicles or peds."
})

local SetHubLobbyButton = LobbyMenu:AddButton({
    label = "Hub lobby",
    description = "Set you to the main hub lobby."
})

-- local GetVehLobbyButton = testMenu:AddButton({
--     label = "Current veh lobby",
--     description = "Get the vehicles current routing bucket."
-- })

-- This works!!
-- RegisterCommand("getveh_lobby", function()
--     local player = PlayerPedId()
--     local currentVeh = GetVehiclePedIsIn(player, false)

--     if currentVeh ~= nil or currentVeh ~= 0 then
--         -- This works like this on the client now! Shows routing bucket 10 for no population lobby instead of 0
--         local vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)

--         TriggerServerEvent('kc_menu:getCurrentVehicleLobby', vehNetId)

--         -- exports.kc_util:Notify(("Vehicle: %s"):format(currentVeh))
--         -- else
--         -- Text.Notify("You are not in a vehicle!")
--     end
-- end, false)

-----------
--- Lobby menu button
-----------
-- Well this is how to make sub menus, at least it works like this.
LobbyMenuButton:On("select", function()
    MenuV:OpenMenu(LobbyMenu, function()
        local player = PlayerPedId()
        local currentVeh = GetVehiclePedIsIn(player, false)

        local vehNetId = 0

        if currentVeh ~= 0 or currentVeh ~= nil then
            vehNetId = NetworkGetNetworkIdFromEntity(currentVeh)
        end

        -- Routing bucket tests

        -- These work! Created in kc_lobby.
        -- TODO Restrict these if in a race lobby or in a race.
        -- I may setup races using the StreetRaces resource and MySql.
        -- I figured out how to make these work for the players current vehicle also.
        SetNopopulationLobbyButton:On("select", function()
            TriggerServerEvent('kc_menu:setNoPopulation')
            -- TriggerServerEvent('kc_menu:setNoPopulation', currentVeh)
            -- TriggerServerEvent('kc_menu:setNoPopulation', vehNetId)
            TriggerServerEvent('kc_menu:setVehicleNoPopulation', vehNetId)
        end)

        -- setHubLobbyButton
        SetHubLobbyButton:On("select", function()
            TriggerServerEvent('kc_menu:setHub')

            TriggerServerEvent('kc_menu:setVehicleLobby', vehNetId)
        end)


                -- Well this doesn't seem to work
        -- getVehLobbyButton:On("select", function ()
        --     local player = PlayerPedId()
        --     local currentVeh = GetVehiclePedIsIn(player, false)
        --     -- if currentVeh ~= nil or currentVeh ~= 0 then
        --     -- Well this didn't work client side.
        --     -- local currentVehNetId = NetworkGetNetworkIdFromEntity(currentVeh)

        --         -- Shows routing bucket 0 in vehicles.
        --         TriggerServerEvent('kc_menu:getCurrentVehicleLobby', currentVeh)

        --         -- TriggerServerEvent('kc_menu:getCurrentVehicleLobby', currentVehNetId)
        --         -- TriggerServerEvent('kc_menu:getCurrentVehicleLobby')

        --         -- print(("Current Vehicle: %s"):format(currentVeh))

        --         -- exports.kc_util:Notify(("Vehicle: %s"):format(currentVeh))
        --     -- else
        --         -- Text.Notify("You are not in a vehicle!")
        --     -- end
        -- end)

    end)
end)