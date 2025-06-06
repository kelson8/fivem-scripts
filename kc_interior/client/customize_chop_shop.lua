-- https://github.com/Bob74/bob74_ipl/wiki/How-to-interact-with-an-interior

-- https://github.com/Bob74/bob74_ipl/wiki/The-Chop-Shop:-Salvage-Yard

-- Well this didn't seem to work.
Citizen.CreateThread(function ()
    ChopShopSalvage = exports['bob74_ipl']:GetChopShopSalvageObject()

        -- Disable the exterior
    -- ChopShopSalvage.Ipl.Exterior.Remove()

        -- ChopShopSalvage.Tint.SetColor(ChopShopSalvage.Tint.gray, false)
        ChopShopSalvage.Tint.SetColor(ChopShopSalvage.Tint.blue, false)
        -- ChopShopSalvage.Style.Set(ChopShopSalvage.Style.upgrade, false)
        ChopShopSalvage.Style.Set(ChopShopSalvage.Style.basic, false)

        ChopShopSalvage.Lift1.Set(ChopShopSalvage.Lift1.up, false)
        ChopShopSalvage.Lift2.Set(ChopShopSalvage.Lift2.up, false)
        RefreshInterior(ChopShopSalvage.interiorId)
end)