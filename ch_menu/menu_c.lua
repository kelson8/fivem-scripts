_menuPool = NativeUI.CreatePool()
-- mainMenu = NativeUI.CreateMenu("Native UI", "~b~NATIVEUI SHOWCASE", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
mainMenu = NativeUI.CreateMenu("Native UI", "~b~NATIVEUI SHOWCASE", 0, 0, "", "", 20, 200, 22, 22, 1)
_menuPool:Add(mainMenu)

sparta = false

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function AddSpartaMenu(menu)
    -- This Is Sparta!!
    --local newItem = NativeUI.CreateCheckboxItem("Is this sparta?", sparta, "")
    local checkbox = NativeUI.CreateCheckboxItem("Is this sparta?", sparta, "")
    menu:AddItem(checkbox)
    menu.OnCheckboxChange = function (sender, item, checked_)
        if item == checkbox then
            sparta = checked_
            notify("Sparta: "..tostring(sparta))
        end
    end
end

seats = {-1,0,1,2}
function createCarMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "~b~Car menu")
    local carItem = NativeUI.CreateItem("Spawn car", "Spawn the selected car")
    carItem.Activated = function(sender, item)
        if item == carItem then
            spawnVehicle("t20")
            notify("Spawned in a t20")
        end
    end
    local colors1 = {255, 20, 20}
    local colors2 = {0, 140, 160}
    local seat = NativeUI.CreateSliderItem("Change seat", 1, seats, "Change your seat in the car.", false, colors1, colors2)
    submenu.OnSliderChange = function(sender, item, index)
        if item == seat then
            vehSeat = item:IndexToItem(index)
            local pedsCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            SetPedIntoVehicle(PlayerPedId(), pedsCar, vehSeat)
        end
    end
    --This isn't working as a submenu for some reason.
    -- submenu:AddItem(carItem)
    -- submenu:AddItem(seat)
    menu:AddItem(carItem)
    menu:AddItem(seat)
end

AddSpartaMenu(mainMenu)
createCarMenu(mainMenu)
_menuPool:RefreshIndex()


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        -- F6 Key
        if IsControlJustPressed(1, 167) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)

function spawnVehicle(vehicleName)
    -- Check if the vehicle actually exists
    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
    notify("~r~Error~w~: The model " .. vehicleName .. " doesn't exist!")
    end

    -- Load the model
    RequestModel(vehicleName)

    -- If model hasn't loaded, wait on it.
    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    --local ped = GetPlayerPed(-1)
    local ped = PlayerPedId()
    local x,y,z = table.unpack(GetEntityCoords(ped))
    local heading = GetEntityHeading(ped)
    -- Set this to true to spawn player into vehicle.
    local spawnInVehicle = true


    -- TODO Setup spawn in vehicle check.
    -- TODO Fix this to where it doesn't despawn when you walk a bit from it.
    -- Setup persistant vehicle check, if enabled the current vehicle won't despawn.
    if (spawnInVehicle) then
        -- Remove vehicle if player is in one.
        if(IsPedSittingInAnyVehicle) then
            deleteCurrentVehicle(GetVehiclePedIsIn(ped, false))
            -- notify("Car deleted!")
        end

        -- Set the player into the drivers seat
        local vehicle = CreateVehicle(vehicleName, x, y, z, heading, true, false)
        SetPedIntoVehicle(ped, vehicle, -1)

        -- Not sure if these are needed twice.
        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicle)
    -- Adding the else fixed the vehicle spawning in multiple times.
    else
        local vehicle = CreateVehicle(vehicleName, x + 3, y + 3, z + 1, heading, true, false)

        SetEntityAsNoLongerNeeded(vehicle)
        SetModelAsNoLongerNeeded(vehicle)
    end
    
    -- local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))

    -- I commented these out since they are under the spawnInVehicle check.
    -- give the vehicle back to the game (This'll make the game decide when to despawn the vehicle)
    --SetEntityAsNoLongerNeeded(vehicle)

    -- Release the model
    --SetModelAsNoLongerNeeded(vehicle)
end

function deleteCurrentVehicle(vehicleName)
    local ped = GetPlayerPed(-1)
    if DoesEntityExist(vehicleName) then
        if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped, false)
            SetEntityAsMissionEntity(vehicle)
            DeleteVehicle(vehicle)
        end
    end
end

-- Will this work?
-- https://github.com/FrazzIe/NativeUILua
-- function createCarMenu()
    
--     --UIMenu:AddWindow()

--     local mainMenu = UIMenu.New("Car Spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     local vehicleMenu = UIMenuItem.New("Car Spawner", "Spawns cars for you.")

--     --UIMenu.New("Car Spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     UIMenu:AddWindow(mainMenu)
--     UIMenu:AddItem(vehicleMenu)

--     --NativeUI.CreateMenu("Car spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     --NativeUI.CreateItem("Car spawner", "")
--     --notify("Test")
-- end

-- RegisterCommand('menutest', function()
--     AddMainMenu()
-- end)

-- Will this work?
-- https://github.com/FrazzIe/NativeUILua
-- function createCarMenu()
--     NativeUI.CreatePool()
    
--     --UIMenu:AddWindow()

--     local mainMenu = UIMenu.New("Car Spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     local vehicleMenu = UIMenuItem.New("Car Spawner", "Spawns cars for you.")

--     --UIMenu.New("Car Spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     UIMenu:AddWindow(mainMenu)
--     UIMenu:AddItem(vehicleMenu)

--     --NativeUI.CreateMenu("Car spawner", "Spawns cars for you.", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
--     --NativeUI.CreateItem("Car spawner", "")
--     --notify("Test")
-- end

-- RegisterCommand('carsp', function (source, args)
--     createCarMenu()
--     -- TODO figure out how to make a menu with a couple of cars in it.
-- end)