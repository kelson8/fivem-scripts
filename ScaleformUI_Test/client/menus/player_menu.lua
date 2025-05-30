-- TODO Test moving most of the menu code into here and call it in menu_test.lua
function PlayerMenu()
        -- Player Menu
        local playerMenuItem = UIMenuItem.New("Player menu", "All player functions.")
        -- Adds the menu to the testMenu
        testMenu:AddItem(playerMenuItem)
        local playerMenu = UIMenu.New("Player menu", "All player functions.", 50, 50, true, nil, nil, true)

        local healPlayerItem = UIMenuItem.New("Heal player", "Gives the player full health and armor")
        playerMenu:AddItem(healPlayerItem)

        local getVehicleIdItem = UIMenuItem.New("Get vehicle id", "Shows the current vehicle id in a notification.")
        playerMenu:AddItem(getVehicleIdItem)

        -- This didn't seem to work.
        local toggleKersBoostItem = UIMenuItem.New("Toggle Kers boost", "Toggle kers boost if the vehicle has it.")
        playerMenu:AddItem(toggleKersBoostItem)

        local blowupPlayerItem = UIMenuItem.New("Explode", "Blow yourself up")
        playerMenu:AddItem(blowupPlayerItem)

        local spawnDrivingPedItem = UIMenuItem.New("Spawn driving ped", "Spawn a ped to drive you to the marker.")
        playerMenu:AddItem(spawnDrivingPedItem)

        local handCuffsItem = UIMenuItem.New("Handcuff yourself", "Make it to wher you cannot use your weapons.")
        playerMenu:AddItem(handCuffsItem)

        -- Heal player on item select
        playerMenu.OnItemSelect = function(sender, item, index)
            if item == healPlayerItem then
                -- Player.Functions.HealPlayer()
                HealPlayer()
            elseif item == getVehicleIdItem then
                GetVehicleId()
            elseif item == toggleKersBoostItem then
                ToggleKersBoost()
            elseif item == blowupPlayerItem then
                BlowupPlayer()
            elseif item == spawnDrivingPedItem then
                SpawnDrivingPed()
            elseif item == handCuffsItem then
                ToggleHandcuffs()

            end
        end
end