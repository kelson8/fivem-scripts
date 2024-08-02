-- Ls Customs menu test
function CreateLsCustomsMenu()
    local txd = CreateRuntimeTxd("scaleformui")
    local duiPanel = CreateDui("https://i.imgur.com/mH0Y65C.gif", 288, 160)
    CreateRuntimeTextureFromDuiHandle(txd, "sidepanel", GetDuiHandle(duiPanel))
	local duiBanner = CreateDui("https://i.imgur.com/3yrFYbF.gif", 288, 160)
	CreateRuntimeTextureFromDuiHandle(txd, "menuBanner", GetDuiHandle(duiBanner))

    -- Initalize the menu
    local LsCustomsMenu = UIMenu.New("ScaleformUI", "Los Santos Customs", 50, 50, true, "scaleformui", "menubanner", true)
    LsCustomsMenu:MaxItemsOnScreen(7)
    LsCustomsMenu:AnimationEnabled(false)
    LsCustomsMenu:BuildingAnimation(MenuBuildingAnimation.NONE)
    LsCustomsMenu:ScrollingType(MenuScrollingType.CLASSIC)
    LsCustomsMenu:CounterColor(SColor.HUD_YELLOW)
    LsCustomsMenu:MouseSettings(false, false, true, false, true)

    -- local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1))

    -- Spoiler Menu
    local spoilerMenuItem = UIMenuItem.New("Spoilers", "")
    LsCustomsMenu:AddItem(spoilerMenuItem)

    -- local spoilerUpgradeMenu = UIMenuListItem.New("Spoilers", "", 50, 50, true, nil, nil, true)
    local spoilerUpgradeMenu = UIMenu.New("Spoilers", "", 50, 50, true, nil, nil, true)
    
    local spoilerTest = UIMenuListItem.New("List", {
        0, 1, 2, 3 , 4 ,5, "Change spoiler (Not implemented yet)"
    })
    spoilerUpgradeMenu:AddItem(spoilerTest)

    spoilerMenuItem.Activated = function(menu, item)
        menu:SwitchTo(spoilerUpgradeMenu, 1, true)
    end

    LsCustomsMenu:Visible(true)

    -- local spoilerItem = GetNumVehicleMods(playerVeh, 1)
    -- worldMenuItem.Activated = function(menu, item)
    --     menu:SwitchTo(worldMenu, 1, true)
    -- end
    

    -- local spoilerUpgrade = UIMenuListItem.New("Spoilers")
    -- LsCustomsMenu:AddItem(spoilerUpgrade)
    -- if IsPedInAnyVehicle(GetPlayerPed(-1)) then
    --     local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1))
    --     local spoilerItem = GetNumVehicleMods(playerVeh, 1)
    -- end


end

--

-- TODO Setup this to work, and make the loop only run when the player is near.

-- Citizen.CreateThread(function()
--     while true do
--         Wait(0)


--         -- Los Santos Customs menu (This is incomplete, so far I just have the marker setup.)

--         local losSantosMarker1_vec3 = vector3(-341.56, -136.8, 37.82)
--         local losSantosMarker1_textpos = vector3(-341.56, -136.8, 40.82)
--         local losSantosMarker1_scale = 4.0

--         marker_lsc = Marker.New(1, -- Marker id
--         losSantosMarker1_vec3, -- Position for marker
--         vector3(3, 3, 3), -- Position away from marker?
--         losSantosMarker1_scale, -- Scale
--         {R=0, G= 100, B=50, A=255}, -- Color
--         true, false, false, false, true)
--         marker_lsc:Draw()

--         ScaleformUI.Notifications:DrawText3D(losSantosMarker1_textpos, {R=0, G=100, B=50, A=255}, "Los Santos Customs", 7, 10)

--         local x, y, z = table.unpack(loc.tpto)
--         local ped = GetPlayerPed(-1)
--         local playerCoord = GetEntityCoords(PlayerPedId(), false)
--         if Vdist2(playerCoord, losSantosMarker1_vec3) < losSantosMarker1_scale * 1.12 and GetVehiclePedIsIn(PlayerPedId(), false) then
--             if IsPedInAnyVehicle(ped) then
--                 -- Code that runs when we are in the markers radius and in a vehicle.
--                 -- local vehName = GetVehiclePedIsIn(GetPlayerPed(-1))

--                 -- "E" key
--                 if IsControlJustPressed(0, 54) and not MenuHandler:IsAnyMenuOpen() then
--                     CreateLsCustomsMenu()
--                 end

--                 -- notify("You entered the marker with a " .. vehName)
--             end
--         end
--     end
-- end)