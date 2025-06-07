-- https://github.com/Bob74/bob74_ipl/wiki/How-to-interact-with-an-interior

-- TODO Add options for this to my kc_menu using menuv or the ox_lib menu.

-----
-- This one seems to work.
-- Franklin's aunts house
-----
Citizen.CreateThread(function()
    FranklinAunt = exports['bob74_ipl']:GetFranklinAuntObject()

    -- FranklinAunt.Style.Set(FranklinAunt.Style.empty)
    FranklinAunt.Style.Set(FranklinAunt.Style.franklinStuff)
    FranklinAunt.Details.Enable(FranklinAunt.Details.bandana, false)
    FranklinAunt.Details.Enable(FranklinAunt.Details.bag, false)

    RefreshInterior(FranklinAunt.interiorId)
end)

-----
-- Facility
-- https://github.com/Bob74/bob74_ipl/wiki/The-Doomsday-Heist:-Facility
-----
Citizen.CreateThread(function()
    -- Getting the object to interact with
    DoomsdayFacility = exports['bob74_ipl']:GetDoomsdayFacilityObject()

    -- Setting the color of the walls to "Expertise"
    DoomsdayFacility.Walls.SetColor(DoomsdayFacility.Colors.expertise)
    DoomsdayFacility.Decals.Set(DoomsdayFacility.Decals.style03)

    -- Prestige lounge
    DoomsdayFacility.Lounge.Set(DoomsdayFacility.Lounge.prestige, DoomsdayFacility.Colors.expertise)

    -- Prestige bedroom
    DoomsdayFacility.Sleeping.Set(DoomsdayFacility.Sleeping.prestige, DoomsdayFacility.Colors.expertise)

    -- No security room
    DoomsdayFacility.Security.Set(DoomsdayFacility.Security.off, DoomsdayFacility.Colors.expertise)

    -- No orbital cannon
    DoomsdayFacility.Cannon.Set(DoomsdayFacility.Cannon.off, DoomsdayFacility.Colors.expertise)

    -- Privacy glass remote
    DoomsdayFacility.PrivacyGlass.Bedroom.Control.Enable(true)
    DoomsdayFacility.PrivacyGlass.Lounge.Control.Enable(true)

    -- No crew emblem circle
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.crewEmblem, false)

    -- Parts of all vehicles enabled
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.KhanjaliParts, true)
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.RiotParts, true)
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.ChenoParts, true)
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.ThrusterParts, true)
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.AvengerParts, true)

    -- All outfits enabled
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Outfits, true)

    -- All trophies enabled
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Trophies, true)
    -- Sets the color of the submarine trophy to "Expertise"
    DoomsdayFacility.Details.Trophies.SetColor(DoomsdayFacility.Colors.expertise)

    -- All clutters enabled
    DoomsdayFacility.Details.Enable(DoomsdayFacility.Details.Clutter, true)

    RefreshInterior(DoomsdayFacility.interiorId)
end)

-----
-- Agents of Sabotage office
-- This one works
-----
Citizen.CreateThread(function()
    -- Getting the object to interact with
    AgentsOffice = exports['bob74_ipl']:GetAgentsOffice()

    --
    AgentsOffice.Style.Set(AgentsOffice.Style.bed, false)
    -- AgentsOffice.Style.Set(AgentsOffice.Style.mess, false)

    AgentsOffice.Details.Enable(AgentsOffice.Details.ammo, false, false)
    AgentsOffice.Details.Enable(AgentsOffice.Details.intel, false, false)
    AgentsOffice.Details.Enable(AgentsOffice.Details.weapons, true, false)
    AgentsOffice.Details.Enable(AgentsOffice.Details.tools, true, false)
    AgentsOffice.Details.Enable(AgentsOffice.Details.booze, false, false)

    RefreshInterior(AgentsOffice.interiorId)
end)

-----
-- Agents of Sabotage Airstrip
-- Oh this is a new airstrip, I never knew it was in the game.
-----
---
-- Citizen.CreateThread(function()
--     -- Getting the object to interact with
--     AgentsAirstrip = exports['bob74_ipl']:GetAgentsAirstrip()

--     -- AgentsAirstrip.Ipl.Remove()
--     AgentsAirstrip.Ipl.Load()
-- end)

-----
-- Vinewood car club
--
-----
---
Citizen.CreateThread(function()
    -- Getting the object to interact with
    MercenariesClub = exports['bob74_ipl']:GetMercenariesClubObject()

    MercenariesClub.Style.Set(MercenariesClub.Style.club, false)
    -- MercenariesClub.Style.Set(MercenariesClub.Style.empty, false)
    MercenariesClub.Stairs.Enable(false, false)

    RefreshInterior(MercenariesClub.interiorId)
end)

-----
-- Secret Facility in military base
-----
Citizen.CreateThread(function()
    -- Getting the object to interact with
    MercenariesLab = exports['bob74_ipl']:GetMercenariesLabObject()

    MercenariesLab.Details.Enable(MercenariesLab.Details.levers, true, false)
    MercenariesLab.Details.Enable(MercenariesLab.Details.crates, true, false)
    MercenariesLab.Details.Enable(MercenariesLab.Details.weapons, true, false)
    MercenariesLab.Details.Enable(MercenariesLab.Details.lights, true, false)

    RefreshInterior(MercenariesLab.interiorId)
end)

-----
-- Hangar
-- TODO Add the commands to either kc_menu, or ox_lib test in a new menu format.
-- Make this be triggered from the server to set permissions on it.
-----
--- Well now, this actually works for a basic test with commands.
--- I could easily add this to a menu and a refresh button at the bottom.
RegisterCommand("hangar_color", function(source, args, rawCommand)
    local colors = tonumber(args[1])


    local colorMap = {
        [1] = SmugglerHangar.Colors.colorSet1,
        [2] = SmugglerHangar.Colors.colorSet2,
        [3] = SmugglerHangar.Colors.colorSet3,
        [4] = SmugglerHangar.Colors.colorSet4,
        [5] = SmugglerHangar.Colors.colorSet5,
        [6] = SmugglerHangar.Colors.colorSet6,
        [7] = SmugglerHangar.Colors.colorSet7,
        [8] = SmugglerHangar.Colors.colorSet8,
        [9] = SmugglerHangar.Colors.colorSet9,
    }

    if colors and colorMap[colors] then
        SmugglerHangar.Walls.SetColor(colorMap[colors], true)
    else
        Text.Notify("Colors can only be between 1-9.")
    end
end, false)

RegisterCommand("hangar_decals", function(source, args, rawCommand)
    local decals = tonumber(args[1])

    local decalMap = {
        [1] = SmugglerHangar.Floor.Decals.decal1,
        [2] = SmugglerHangar.Floor.Decals.decal2,
        [3] = SmugglerHangar.Floor.Decals.decal3,
        [4] = SmugglerHangar.Floor.Decals.decal4,
        [5] = SmugglerHangar.Floor.Decals.decal5,
        [6] = SmugglerHangar.Floor.Decals.decal6,
        [7] = SmugglerHangar.Floor.Decals.decal7,
        [8] = SmugglerHangar.Floor.Decals.decal8,
        [9] = SmugglerHangar.Floor.Decals.decal9,
    }

    -- Check if the 'decals' number is valid and exists in the map
    if decals and decalMap[decals] then
        SmugglerHangar.Floor.Decals.Set(decalMap[decals], SmugglerHangar.Colors.colorSet1, true)
    else
        Text.Notify("Decals can only be between 1-9.")
    end
end, false)

-- There is a lot to change for the hangar.
Citizen.CreateThread(function()
    -- Getting the object to interact with
    SmugglerHangar = exports['bob74_ipl']:GetSmugglerHangarObject()

    -- Made selector command for this.
    -- SmugglerHangar.Walls.SetColor(SmugglerHangar.Colors.colorSet1)
    -- SmugglerHangar.Walls.SetColor(SmugglerHangar.Colors.colorSet4)

    SmugglerHangar.Cranes.Set(SmugglerHangar.Cranes.on, SmugglerHangar.Colors.colorSet1)
    SmugglerHangar.Floor.Style.Set(SmugglerHangar.Floor.Style.plain)
    -- SmugglerHangar.Floor.Style.Set(SmugglerHangar.Floor.Style.raw)

    -- Made selector command for this.
    SmugglerHangar.Floor.Decals.Set(SmugglerHangar.Floor.Decals.decal3, SmugglerHangar.Colors.colorSet1)


    SmugglerHangar.Lighting.Ceiling.Set(SmugglerHangar.Lighting.Ceiling.yellow)
    SmugglerHangar.Lighting.Walls.Set(SmugglerHangar.Lighting.Walls.neutral)
    SmugglerHangar.Lighting.FakeLights.Set(SmugglerHangar.Lighting.FakeLights.yellow)

    SmugglerHangar.ModArea.Set(SmugglerHangar.ModArea.on, SmugglerHangar.Colors.colorSet1)

    -- SmugglerHangar.Office.Set(SmugglerHangar.Office.basic)
    -- SmugglerHangar.Office.Set(SmugglerHangar.Office.modern)
    SmugglerHangar.Office.Set(SmugglerHangar.Office.traditional)

    -- SmugglerHangar.Bedroom.Style.Set(SmugglerHangar.Bedroom.Style.modern, SmugglerHangar.Colors.colorSet1)
    SmugglerHangar.Bedroom.Style.Set(SmugglerHangar.Bedroom.Style.traditional, SmugglerHangar.Colors.colorSet1)

    -- SmugglerHangar.Bedroom.Blinds.Set(SmugglerHangar.Bedroom.Blinds.none)
    SmugglerHangar.Bedroom.Blinds.Set(SmugglerHangar.Bedroom.Blinds.opened)
    -- SmugglerHangar.Bedroom.Blinds.Set(SmugglerHangar.Bedroom.Blinds.closed)

    SmugglerHangar.Details.Enable(SmugglerHangar.Details.bedroomClutter, false)
    -- SmugglerHangar.Details.Enable(SmugglerHangar.Details.bedroomClutter, true)

    RefreshInterior(SmugglerHangar.interiorId)
end)


-----
-- Ufos
-----

-- Hippie 	X: 2490.47729 	Y: 3774.84351 	Z: 2414.035
-- Chiliad 	X: 501.5288 	Y: 5593.865 	Z: 796.2325
-- Zancudo 	X: -2051.99463 	 Y: 3237.05835 	Z: 1456.97021

-- https://github.com/Bob74/bob74_ipl/wiki/GTA-V:-UFO
Citizen.CreateThread(function()
    -- Getting the object to interact with
    UFO = exports['bob74_ipl']:GetUFOObject()

    -- Enable hippies UFO
    UFO.Hippie.Enable(false)

    -- Disable Chiliad UFO
    UFO.Chiliad.Enable(false)

    -- Enable Zancudo UFO
    UFO.Zancudo.Enable(false)
end)

-----
-- Fort Zancudo gates (Military base)
-- https://github.com/Bob74/bob74_ipl/wiki/GTA-V:-Zancudo-Gates
-----

-- X: -1600.301 	Y: 2806.731 	Z: 18.796

-- Citizen.CreateThread(function()
--     -- Getting the object to interact with
--     ZancudoGates = exports['bob74_ipl']:GetZancudoGatesObject()

--     -- Closes the gates (GTA Online like)
--     -- ZancudoGates.Gates.Close()
--     ZancudoGates.Gates.Open()
-- end)

-----
-- Penthouse (In apartment, not casino penthouse)
-- https://github.com/Bob74/bob74_ipl/wiki/Executives-&-Other-Criminals:-Penthouses
-----

-- Penthouse 1 (EclipseTowers, Penthouse Suite 1) 	X: -787.7805 	Y: 334.9232 	Z: 215.8384
-- Penthouse 2 (EclipseTowers, Penthouse Suite 2) 	X: -773.2258 	y: 322.8252 	Z: 194.8862
-- Penthouse 3 (EclipseTowers, Penthouse Suite 3) 	X: -787.7805 	Y: 334.9232 	Z: 186.1134

Citizen.CreateThread(function()
    -- Getting the object to interact with
    ExecApartment1 = exports['bob74_ipl']:GetExecApartment1Object()
    ExecApartment2 = exports['bob74_ipl']:GetExecApartment2Object()

    -- Well it seems like only modern works on this one.
    -- Not sure why these aren't working.
    -- ExecApartment1.Style.Set(ExecApartment1.Style.Theme.modern, false)

    -- These ones do not work.
    -- ExecApartment2.Style.Set(ExecApartment2.Style.Theme.moody, false)
    -- ExecApartment2.Style.Set(ExecApartment2.Style.Theme.vibrant, false)
    -- ExecApartment2.Style.Set(ExecApartment2.Style.Theme.vibrant, false)
    -- ExecApartment1.Style.Set(ExecApartment1.Style.Theme.sharp, false)
    -- ExecApartment2.Style.Set(ExecApartment2.Style.Theme.monochrome, false)
    -- ExecApartment1.Style.Set(ExecApartment1.Style.Theme.seductive, false)
    -- ExecApartment1.Style.Set(ExecApartment1.Style.Theme.regal, false)

    -- Enable all strip-tease clothes
    -- ExecApartment1.Strip.Enable({ExecApartment1.Strip.A, ExecApartment1.Strip.B, ExecApartment1.Strip.C}, false)

    -- Enable a bit of booze bottles
    -- ExecApartment1.Booze.Enable(ExecApartment1.Booze.A, false)

    -- Maximum amount of cigarettes + Refresh
    -- ExecApartment1.Smoke.Set(ExecApartment1.Smoke.stage3, false)
    -- RefreshInterior(ExecApartment1.interiorId)

    -- RefreshInterior(ExecApartment2.interiorId)
end)


-----
-- North Yankton
-- https://github.com/Bob74/bob74_ipl/wiki/GTA-V:-North-Yankton
-----

-- X: 3217.697 	Y: -4834.826 	Z: 111.8152

Citizen.CreateThread(function()
    -- Getting the object to interact with
    NorthYankton = exports['bob74_ipl']:GetNorthYanktonObject()

    -- Toggling North Yankton
    NorthYankton.Enable(false)
end)

-----
-- Nightclub
-- This works for the nightclub
-- https://github.com/Bob74/bob74_ipl/wiki/After-Hours:-Nightclubs
-----

Citizen.CreateThread(function()
    -- Getting the object to interact with
    AfterHoursNightclubs = exports['bob74_ipl']:GetAfterHoursNightclubsObject()

    -------------------------------------------
    -- Interior part


    -- Interior setup
    AfterHoursNightclubs.Ipl.Interior.Load()

    -- Setting the name of the club to The Palace
    AfterHoursNightclubs.Interior.Name.Set(AfterHoursNightclubs.Interior.Name.palace)

    -- Glamorous style
    -- AfterHoursNightclubs.Interior.Style.Set(AfterHoursNightclubs.Interior.Style.glam)
    -- AfterHoursNightclubs.Interior.Style.Set(AfterHoursNightclubs.Interior.Style.trad)
    AfterHoursNightclubs.Interior.Style.Set(AfterHoursNightclubs.Interior.Style.edgy)

    -- No podiums
    AfterHoursNightclubs.Interior.Podium.Set(AfterHoursNightclubs.Interior.Podium.none)

    -- Basic speakers
    AfterHoursNightclubs.Interior.Speakers.Set(AfterHoursNightclubs.Interior.Speakers.basic)

    -- No security
    AfterHoursNightclubs.Interior.Security.Set(AfterHoursNightclubs.Interior.Security.off)

    -- Setting turntables
    AfterHoursNightclubs.Interior.Turntables.Set(AfterHoursNightclubs.Interior.Turntables.style03)

    -- Lights
    AfterHoursNightclubs.Interior.Lights.Bands.Set(AfterHoursNightclubs.Interior.Lights.Lasers.cyan)
    AfterHoursNightclubs.Interior.Lights.Lasers.Set(AfterHoursNightclubs.Interior.Lights.Lasers.yellow)

    -- Enabling bottles behind the bar
    AfterHoursNightclubs.Interior.Bar.Enable(true)

    -- Enabling all booze bottles
    AfterHoursNightclubs.Interior.Booze.Enable(AfterHoursNightclubs.Interior.Booze, true)

    -- Adding trophies on the desk
    AfterHoursNightclubs.Interior.Trophy.Enable(AfterHoursNightclubs.Interior.Trophy.number1, true,
        AfterHoursNightclubs.Interior.Trophy.Color.bronze)
    AfterHoursNightclubs.Interior.Trophy.Enable(AfterHoursNightclubs.Interior.Trophy.battler, true,
        AfterHoursNightclubs.Interior.Trophy.Color.silver)
    AfterHoursNightclubs.Interior.Trophy.Enable(AfterHoursNightclubs.Interior.Trophy.dancer, true,
        AfterHoursNightclubs.Interior.Trophy.Color.gold)


    -- Details testing
    -- AfterHoursNightclubs.Interior.Details.Enable(AfterHoursNightclubs.vaultWeed, false)

    -- Refreshing interior to apply changes
    RefreshInterior(AfterHoursNightclubs.interiorId)


    -------------------------------------------
    -- Exterior part


    -- La Mesa - Exterior
    -- No barriers
    AfterHoursNightclubs.Mesa.Barrier.Enable(false)

    -- Only "For sale" poster
    AfterHoursNightclubs.Mesa.Posters.Enable(AfterHoursNightclubs.Posters.forSale, true)


    -- Mission Row - Exterior
    -- Barriers
    AfterHoursNightclubs.Mesa.Barrier.Enable(true)

    -- Posters for Dixon and Madonna only
    AfterHoursNightclubs.Mesa.Posters.Enable({ AfterHoursNightclubs.Posters.dixon, AfterHoursNightclubs.Posters.madonna },
        true)
end)
