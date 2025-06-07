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


-- Well this works.
RegisterCommand("setshirt", function()
    local player = PlayerPedId()
    local playerModel = GetEntityModel(player)
    -- SetPedComponentVariation(player, PV_COMP_ACCS, 111, lingerieSet1[1], 0)
    -- SetPedComponentVariation(player, PedVarComp.PV_COMP_UPPR, 111, 1, 0)

    -- Here is how to randomize outfits
    local randomTanktop1 = tankTops1[math.random(1, #tankTops1)]
    local randomTanktop2 = tankTops2[math.random(1, #tankTops2)]


    if not IsPedMale(playerModel) then
        -- SetPedComponentVariation(player, PedVarComp.PV_COMP_JBIB, 32, randomTanktop1, 0)
        SetPedComponentVariation(player, PedVarComp.PV_COMP_JBIB, 36, randomTanktop2, 0)
        -- SetPedComponentVariation(player, PedVarComp.PV_COMP_ACCS, 111, 1, 0)
    end
end, false)


-- TODO Figure out how to convert the gxt strings to text here
RegisterCommand("printclothes", function ()
    local topsHash = GetHashKey("CSHOP_TRY_T")

    -- Hmm, this one might work for on screen
    -- AddTextComponentSubstringTextLabel()

end, false)