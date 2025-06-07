-- Taken from kc_clothes

-- Not sure if this will work with sub menus or if I am doing it right.

-- TODO Add more to this and label these other ones with actual names later.

-- Texture ids

-- Female


-- https://github.com/root-cause/v-clothingnames/blob/master/female_legs.json
-- Pants


-- https://github.com/root-cause/v-clothingnames/blob/master/female_tops.json
-- Tops

-- Drawable 32 in vMenu
local tankTops1 = {
    0, 1, 2
}

-- Drawable 36 in vMenu
local tankTops2 = {
    0, 1, 2, 3, 4
}

-- TODO Test this.
ClothesDrawables = {
    TankTops1 = 32,
    TankTops2 = 36,
}


Menus = {}

Menus.Clothes = {}

Buttons = {}

local menu = GetMenu()


-----
-- Basic function to set the players clothes.
-- Palette Id goes from 0-3
-- Component Ids can be found in my enums.lua looking through 'PedVarComp'
-----
local function SetClothes(ped, componentId, drawableId, textureId, paletteId)
    SetPedComponentVariation(ped, componentId, drawableId, textureId, paletteId)
end


-- musicMenu = MenuV:CreateMenu("Music", "Music Menu", "topleft", 255, 0, 0, "size-110", "default",

-- Menus.ClothesMenu = MenuV:CreateMenu("Clothes", "Clothes Menu", "topleft", 255, 0, 0, "size-110", "default",
--         "menuv", "clothesMenuNamespace", "native")

-- Buttons.ClothesMenuButton = menu:AddButton({ label = "Clothes Menu", description = 'Open the clothes menu' })

-- TODO Test this
-- Menus.Clothes.Lingere = MenuV:CreateMenu("Lingere", "Lingere Menu", "topleft", 255, 0, 0, "size-110", "default",
        -- "menuv", "lingereClothesMenuNamespace", "native")

-- Buttons.SetLingereStyle1 = Menus.ClothesMenu:AddButton({ label = "Set outfit", description = 'Test' })
-- Buttons.SetLingereStyle1 = ClothesMenu:AddButton({ label = "Set outfit", description = 'Test' })
-- Buttons.SetTankTopStyle1 = ClothesMenu:AddButton({ label = "Set outfit", description = 'Test' })
local SetTankTopStyle1 = ClothesMenu:AddButton({ label = "Random tank top", description = 'Random tank top' })
local SetTorsoStyle = ClothesMenu:AddButton( {label = "Set Torso", description = "Set torso style"} )

-----------
-- Clothes menu button
-- TODO Make sub menus for these.
-----------
---
-- Buttons.ClothesMenuButton:On("select", function ()
ClothesMenuButton:On("select", function ()
    -- MenuV:OpenMenu(Menus.ClothesMenu, function ()
    MenuV:OpenMenu(ClothesMenu, function ()

        -- This seems to work.
        local player = PlayerPedId()
        -- Buttons.SetTankTopStyle1:On("select", function ()
        SetTankTopStyle1:On("select", function ()
            -- SetClothes(player, 32, )

            -- Here is how to randomize outfits
            local randomTanktop1 = tankTops1[math.random(1, #tankTops1)]

            -- SetClothes(player, PedVarComp.PV_COMP_JBIB, ClothesDrawables.TankTops1, tankTops1[1], 0)
            SetClothes(player, PedVarComp.PV_COMP_JBIB, ClothesDrawables.TankTops1, randomTanktop1, 0)
        end)

        SetTorsoStyle:On("select", function ()
            local torsoStyle = 15
            SetClothes(player, PedVarComp.PV_COMP_UPPR, torsoStyle, 0, 0)
        end)

    end)
end)

-----------
-- Clothes menu test commands
-----------

-- Well this works.
-- RegisterCommand("setshirt", function()
--     local player = PlayerPedId()
--     local playerModel = GetEntityModel(player)
--     -- SetPedComponentVariation(player, PV_COMP_ACCS, 111, lingerieSet1[1], 0)
--     -- SetPedComponentVariation(player, PedVarComp.PV_COMP_UPPR, 111, 1, 0)

--     -- Here is how to randomize outfits
--     local randomlingerieSet1 = lingerieSet1[math.random(1, #lingerieSet1)]
--     local randomTanktop1 = tankTops1[math.random(1, #tankTops1)]
--     local randomTanktop2 = tankTops2[math.random(1, #tankTops2)]


--     if not IsPedMale(playerModel) then
--         -- SetPedComponentVariation(player, PedVarComp.PV_COMP_JBIB, 111, randomlingerieSet1, 0)
--         -- SetPedComponentVariation(player, PedVarComp.PV_COMP_JBIB, 32, randomTanktop1, 0)
--         SetPedComponentVariation(player, PedVarComp.PV_COMP_JBIB, 36, randomTanktop2, 0)
--         -- SetPedComponentVariation(player, PedVarComp.PV_COMP_ACCS, 111, 1, 0)
--     end
-- end, false)


-- -- TODO Figure out how to convert the gxt strings to text here
-- RegisterCommand("printclothes", function ()
--     local topsHash = GetHashKey("CSHOP_TRY_T")

--     -- Hmm, this one might work for on screen
--     -- AddTextComponentSubstringTextLabel()

-- end, false)