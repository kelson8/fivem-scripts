-- TODO Make a full upgrade function to be integrated into my menu.

-- https://forum.cfx.re/t/spawn-car-with-mods/977981/6

-- GetNumVehicleMods(vehicle, modType) - 1

-- TODO Mess with these ones too.
-- GetNumVehicleWindowTints()
-- GetNumberOfVehicleColours()
-- GetNumberOfVehicleDoors()
-- GetNumberOfVehicleNumberPlates()
-- GetVehicleNumberOfWheels()
-- GetVehicleNumberPlateText()
-- GetVehicleNumberPlateTextIndex()

-- GetVehicleNumberOfBrokenOffBones()
-- GetVehicleNumberOfBrokenBones()

-- https://docs.fivem.net/natives/?_0x6AF0636DDEDCB6DD
local eVehicleModType = {
    VMT_SPOILER = 0,
    VMT_BUMPER_F = 1,
    VMT_BUMPER_R = 2,
    VMT_SKIRT = 3,
    VMT_EXHAUST = 4,
    VMT_CHASSIS = 5,
    VMT_GRILL = 6,
    VMT_BONNET = 7,
    VMT_WING_L = 8,
    VMT_WING_R = 9,
    VMT_ROOF = 10,
    VMT_ENGINE = 11,
    VMT_BRAKES = 12,
    VMT_GEARBOX = 13,
    VMT_HORN = 14,
    VMT_SUSPENSION = 15,
    VMT_ARMOUR = 16,
    VMT_NITROUS = 17,
    VMT_TURBO = 18,
    VMT_SUBWOOFER = 19,
    VMT_TYRE_SMOKE = 20,
    VMT_HYDRAULICS = 21,
    VMT_XENON_LIGHTS = 22,
    VMT_WHEELS = 23,
    VMT_WHEELS_REAR_OR_HYDRAULICS = 24,
    VMT_PLTHOLDER = 25,
    VMT_PLTVANITY = 26,
    VMT_INTERIOR1 = 27,
    VMT_INTERIOR2 = 28,
    VMT_INTERIOR3 = 29,
    VMT_INTERIOR4 = 30,
    VMT_INTERIOR5 = 31,
    VMT_SEATS = 32,
    VMT_STEERING = 33,
    VMT_KNOB = 34,
    VMT_PLAQUE = 35,
    VMT_ICE = 36,
    VMT_TRUNK = 37,
    VMT_HYDRO = 38,
    VMT_ENGINEBAY1 = 39,
    VMT_ENGINEBAY2 = 40,
    VMT_ENGINEBAY3 = 41,
    VMT_CHASSIS2 = 42,
    VMT_CHASSIS3 = 43,
    VMT_CHASSIS4 = 44,
    VMT_CHASSIS5 = 45,
    VMT_DOOR_L = 46,
    VMT_DOOR_R = 47,
    VMT_LIVERY_MOD = 48,
    VMT_LIGHTBAR = 49,
}

-- This works fine now, I had to modify it a bit and also make it repair the vehicle.
-- Add most upgrades to the current vehicle.
RegisterCommand("upgrade_veh", function()
    local player = PlayerPedId()
    local currentVeh = GetVehiclePedIsIn(player, false)

    -- Should the vehicle be repaired?
    local repairVehicle = true

    -- If the spoiler and a bunch of other mods will be applied
    local extraVehicleMods = true

    -- If the livery will be upgraded
    local upgradeLivery = false


    if currentVeh ~= 0 or currentVeh ~= nil then

        -- First, repair the vehicle
        if repairVehicle then

        SetVehicleFixed(currentVeh)
        SetVehicleBodyHealth(currentVeh, 1000.0)
        SetVehicleEngineHealth(currentVeh, 1000.0)
        SetVehiclePetrolTankHealth(currentVeh, 1000.0)
        end

        -- Not sure if this is needed now.
        -- if IsThisModelACar(currentVeh) then
        --     for i = 1, 3 do
        --         SetVehicleWheelHealth(currentVeh, i, 1000)
        --     end
        -- end

        -- Max vehicle upgrades, at least the essential ones.
        -- local maxEngine = GetNumVehicleMods(vehicle, 11) - 1
        local maxArmor = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ARMOUR) - 1
        local maxEngine = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ENGINE) - 1
        local maxBrakes = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BRAKES) - 1
        local maxTransmission = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_GEARBOX) - 1

        -- Here are some extra vehicle mods
        local maxSpoiler = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_SPOILER) - 1
        local maxFrontBumper = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BUMPER_F) - 1
        local maxRearBumper = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_BUMPER_R) - 1


        local maxExhaust = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_EXHAUST) - 1
        local maxGrill = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_GRILL) - 1
        local maxRoof = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_ROOF) - 1
        local maxSkirt = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_SKIRT) - 1

        -- local maxLivery = GetVehicleLiveryCount(currentVeh)
        -- https://forum.cfx.re/t/setvehiclelivery-not-working-even-when-setting-setvehiclemodkit-to-0/1584813/2
        local maxLivery = GetNumVehicleMods(currentVeh, eVehicleModType.VMT_LIVERY_MOD) - 1
        -- print("Max livery: " .. maxLivery)

        -- Vehicle mods
        SetVehicleMod(currentVeh, eVehicleModType.VMT_ENGINE, maxArmor, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_ENGINE, maxEngine, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_BRAKES, maxBrakes, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_GEARBOX, maxTransmission, false)

        -- Extra mods
        if extraVehicleMods then
            
        
        SetVehicleMod(currentVeh, eVehicleModType.VMT_SPOILER, maxSpoiler, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_BUMPER_F, maxFrontBumper, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_BUMPER_R, maxRearBumper, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_EXHAUST, maxExhaust, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_GRILL, maxGrill, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_ROOF, maxRoof, false)
        SetVehicleMod(currentVeh, eVehicleModType.VMT_SKIRT, maxSkirt, false)
        end


        -- This works! Now requires to be active above.
        if upgradeLivery then
            SetVehicleMod(currentVeh, eVehicleModType.VMT_LIVERY_MOD, maxLivery, false)
        end
        

        -- if maxLivery ~= 0 then
        --     SetVehicleLivery(currentVeh, maxLivery)
        -- end
        --

        -- Turbo and bullet proof tires
        ToggleVehicleMod(currentVeh, eVehicleModType.VMT_TURBO, true)
        SetVehicleTyresCanBurst(currentVeh, false)

        exports.kc_util:Notify("Current vehicle ~b~upgraded~w~!")
    end
end, false)
