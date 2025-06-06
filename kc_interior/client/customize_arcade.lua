-- https://github.com/Bob74/bob74_ipl/wiki/How-to-interact-with-an-interior

-- Well this didn't seem to work.
Citizen.CreateThread(function ()
    Arcade1 = exports['bob74_ipl']:GetDiamondArcadeObject()

        -- Arcade1.Style.Set(Arcade1.Style.normal, false)
        Arcade1.Style.Set(Arcade1.Style.derelict, false)

        Arcade1.Ceiling.Set(Arcade1.Ceiling.flat, false)

        -- Arcade1.Mural.Set(Arcade1.Mural.forever, false)

        -- Arcade1.Floor.Set(Arcade1.Floor.proper, false)
        Arcade1.Floor.Set(Arcade1.Floor.rainbow, false)
        RefreshInterior(Arcade1.interiorId)
end)