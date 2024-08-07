-- TODO Play around with this later
-- TODO Move this into LemonUI in C#

-- Create the menu pool
_menuPool = NativeUI.CreatePool()

-- local mainMenu = UIMenu.New("ScaleformUI", "Test menu", 0, 0, "", "", 20, 200, 22, 22, 1)
-- MenuPool:Add(mainMenu)

-- mainMenu = NativeUI.CreateMenu("Native UI", "~b~NATIVEUI SHOWCASE", 0, 0, "commonmenu", "interaction_bgd", 20, 200, 22, 22, 1)
-- Create the menu and add it.
mainMenu = NativeUI.CreateMenu("Native UI", "~b~NATIVEUI SHOWCASE", 0, 0, "", "", 20, 200, 22, 22, 1)
_menuPool:Add(mainMenu)

-- Sparta test, this is just for playing around with.
sparta = false

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

--/////////
-- Creating menus
--/////////

-- function CreateMenu()
--     local txd = CreateRunTimeTxd("scaleformui")
--     local duiPanel = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
--     CreateRuntimeTextureFromDuiHandle(txd, "sidepanel", GetDuiHandle(duiPanel))
--     local duiBanner = CreateDui("https://i.imgur.com/3yrFYbF.gif", 288, 160)
-- 	CreateRuntimeTextureFromDuiHandle(txd, "menuBanner", GetDuiHandle(duiBanner))

--     local exampleMenu = UIMenu.New("ScaleformUI", "ScaleformUI Showcase", 50, 50, true, "scaleformui", "menubanner", true)
--     exampleMenu:MaxItemsOnScreen(7)
--     exampleMenu:AnimationEnabled(false)
--     exampleMenu:BuildingAnimation(MenuBuildingAnimation.NONE)
--     exampleMenu:ScrollingType(MenuScrollingType.CLASSIC)
--     exampleMenu:CounterColor(SColor.Hud_Yellow)
--     exampleMenu:MouseSettings(false, false, true, false, true)
-- end

function AddSpartaMenu(menu)
    --UiMenu.New("Sparta Menu", "Is this sparta?", )
    local checkbox = NativeUI.CreateCheckboxItem("Is this sparta?", sparta, "")
    menu:AddItem(checkbox)
    menu.OnCheckboxChange = function (sender, item, checked_)
        if item == checkbox then
            sparta = checked_
            notify("Sparta: "..tostring(sparta))
        end
    end
end


-- Add custom cars to list, this will be spawned in the random list below
local customCars = {"720s", "polbuffwb"}
local carRandom = (customCars[math.random(#customCars)])

seats = {-1,0,1,2}
function createCarMenu(menu)
    local submenu = _menuPool:AddSubMenu(menu, "~b~Car menu")
    -- local carItem = NativeUI.CreateItem("Spawn car", "Spawn the selected car")
    local carItem = NativeUI.CreateItem("Spawn random vehicle", "Spawn a custom vehicle")


    carItem.Activated = function(sender, item)
        if item == carItem then
            spawnVehicle(carRandom)
            -- spawnVehicle("720s")
            notify("Spawned in a " .. carRandom)
            -- notify("Spawned in a 720s")
        end
    end
    -- local colors1 = {255, 20, 20}
    local colors1 = {255, 0, 0}
    -- local colors2 = {0, 140, 160}
    local colors2 = {0, 140, 0}
    local seat = NativeUI.CreateSliderItem("Change seat", 3, seats, "Change your seat in the car.", false, colors1, colors2)
    submenu.OnSliderChange = function(sender, item, index)
        -- if IsPedInAnyVehicle(sender, false) then
        if item == seat then
            vehSeat = item:IndexToItem(index)
            local pedsCar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
            SetPedIntoVehicle(GetPlayerPed(-1), pedsCar, vehSeat)
            -- SetPedIntoVehicle(PlayerPedId(), pedsCar, vehSeat)
        end
    -- end
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
-- Fix rotating camera issue
-- https://forum.cfx.re/t/camera-keeps-rotating-after-opening-a-menu-with-nativeui/779257
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)



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

--/////////
-- End Creating Menus
--/////////

--/////////
-- Menu Functions
--/////////
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

--/////////
--End Menu Functions
--/////////