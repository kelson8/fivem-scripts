-- Drawing a debug menu to the screen if enabled
-- https://www.youtube.com/watch?v=nBSCN4Pprak&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=3

-- I pretty much created a debug menu that will update whatever I put in here.

local color = {
    r = 200,
    b = 100,
    g = 88,
    a = 255
}

-- TODO Setup this to where it can be controlled from the menu itself.
-- debugMode = true

-- pedsKilledStat = false
-- local inAirTest = false
-- local aimCamTest = false
-- local statTest = false
-- local statTestNew = false


-- local debugMode = false

-- These don't work yet
function getDebugMode()
    return debugMode
end

-- This almost works, sometimes won't show up or go away
function enableDebugMode()
    -- Make this only run when debug mode is on, this could be useful.

    DebugConfig.debugMode = true
    -- TODO Make this to where it only shows up for certain players or admins/devs
end

function disableDebugMode()
    DebugConfig.debugMode = false
end

local function setTextEntry()
    SetTextFont(0) -- 0 -> 4
    SetTextScale(0.3, 0.3)
    SetTextColour(color.r, color.g, color.b, color.a)
    BeginTextCommandDisplayText("STRING")
end

-- Set the text position with a fixed x value of 0.0001
local function textPosition(y)
    EndTextCommandDisplayText(0.0001, y)
end

-- Set text under KCNet test text, I normally leave the Z value alone
local function textPositionOne()
    textPosition(0.0200)
    -- EndTextCommandDisplayText(0.0001, 0.0200, 0)
end

-- First this runs setTextEntry on each of these if they are enabled
-- Then it sets the text position
-- Lastly it adds whatever text is defined to the screen
CreateThread(function()
    local player = GetPlayerPed(-1)

    -- while debugMode do
    while DebugConfig.debugMode do
        -- while true do
        Wait(1)

        -- The Text
        -- Also runs under the if statements if I have multiple values to print off.
        -- setTextEntry()


        -- if aimCamTest then
        if DebugConfig.aimCamTest then
            setTextEntry()
            BeginTextCommandDisplayText("STRING")
            -- textPositionOne()
            -- EndTextCommandDisplayText(0.0001, 0.0200, 0)
            if IsAimCamActive() then
                AddTextComponentSubstringPlayerName("Is Aiming: True")
                -- AddTextComponentSubstringPlayerName(("Is Aiming: %s"):format(IsAimCamActive()))
                textPositionOne()
            else
                AddTextComponentSubstringPlayerName("Is Aiming: False")
                textPositionOne()
            end

        -- elseif inAirTest then
        elseif DebugConfig.inAirTest then
            setTextEntry()
            BeginTextCommandDisplayText("STRING")

            if IsEntityInAir(player) then
                AddTextComponentSubstringPlayerName("Is in air: True")
                -- AddTextComponentSubstringPlayerName(("Is Aiming: %s"):format(IsAimCamActive()))
                textPositionOne()
            else
                AddTextComponentSubstringPlayerName("Is in air: False")
                textPositionOne()
            end

            -- TODO Figure out how to add multiple of these
            -- This works but kills the KCNet test text whenever I enable/disable other options
        -- elseif statTest then
        elseif DebugConfig.statTest then
            -- New
            setTextEntry()
            -- BeginTextCommandDisplayText("STRING")

            AddTextComponentSubstringPlayerName(("Cops killed: %s"):format(copsKilledCheck()))
            textPosition(0.0200)
            -- EndTextCommandDisplayText(0.0001, 0.0200, 0)

            -- BeginTextCommandDisplayText("STRING")
            setTextEntry()

            AddTextComponentSubstringPlayerName(("Cop cars blown up: %s"):format(getCopVehiclesBlownUp()))
            textPosition(0.0380)

            -- BeginTextCommandDisplayText("STRING")
            setTextEntry()

            AddTextComponentSubstringPlayerName(("Vehicles blown up: %s"):format(getVehiclesBlownUp()))
            textPosition(0.0580)

            -- This works like this
            -- Only print out below if player is in a vehicle.
            -- if IsPedInAnyVehicle(player, false) then
            --     setTextEntry()

            --     -- AddTextComponentSubstringPlayerName(("Vehicle currently in: %s"):format(getVehiclesBlownUp()))
            --     AddTextComponentSubstringPlayerName(("Vehicle currently in: %s"):format(getVehicleNamePlayerIsIn()))
            --     textPosition(0.0780)
            -- end

            -- EndTextCommandDisplayText(0.0001, 0.0380, 0)
            -- AddTextComponentSubstringPlayerName(("Tires popped: %s"):format(getTiresPoppedByGunshot()))
            -- AddTextComponentSubstringPlayerName(("Total time driving: %s seconds"):format(getTimeAsDriver()))
            -- AddTextComponentSubstringPlayerName(("Total time flying heli: %s seconds"):format(getTimeAsHeliPilot()))
            -- AddTextComponentSubstringPlayerName(("Play time: %s"):format(getTotalPlayTime()))

        -- elseif statTestNew then
        elseif DebugConfig.statTestNew then
            -- Run the updated stats check, doesn't work right
            -- checkForUpdatedStats()

            setTextEntry()
            BeginTextCommandDisplayText("STRING")

            -- AddTextComponentSubstringPlayerName(("Stat table: %s"):format(checkForUpdatedStats()))
            AddTextComponentSubstringPlayerName(("Stat table: %s"):format(table.unpack(stats)))
            textPosition(0.0200)

        -- This one doesn't seem to work right
        -- elseif isInWaterTest then
        elseif DebugConfig.isInWaterTest then
            setTextEntry()
            BeginTextCommandDisplayText("STRING")

            if IsEntityInWater(player) then
                AddTextComponentSubstringPlayerName("Are you in water: True")
                textPosition(0.0200)
            else
                AddTextComponentSubstringPlayerName("Are you in water: False")
                textPosition(0.0200)
            end

            -- This works!
            -- Show the current parachute status
            -- https://nativedb.dotindustries.dev/gta5/natives/0x79CFD9827CC979B6?search=parachute
        -- elseif parachuteStatusTest then
        elseif DebugConfig.parachuteStatusTest then
            setTextEntry()
            BeginTextCommandDisplayText("STRING")

            if GetPedParachuteState(player) == -1 then
                AddTextComponentSubstringPlayerName("Parachute status: Normal")
                textPosition(0.0200)
            elseif GetPedParachuteState(player) == 0 then
                AddTextComponentSubstringPlayerName("Parachute status: Wearing parachute")
                textPosition(0.0200)
            elseif GetPedParachuteState(player) == 1 then
                AddTextComponentSubstringPlayerName("Parachute status: Opening parachute")
                textPosition(0.0200)
            elseif GetPedParachuteState(player) == 2 then
                AddTextComponentSubstringPlayerName("Parachute status: Parachute open")
                textPosition(0.0200)
            elseif GetPedParachuteState(player) == 3 then
                AddTextComponentSubstringPlayerName("Parachute status: Falling to death")
                textPosition(0.0200)
            end
        else

            -- EndTextCommandDisplayText(0.0001, 0.0200, 0)
        end



        -----------
        -- Old code
        --------------------

        -- if aimCamTest then
        --     if IsAimCamActive() then
        --         AddTextComponentSubstringPlayerName("Is Aiming: True")
        --         -- AddTextComponentSubstringPlayerName(("Is Aiming: %s"):format(IsAimCamActive()))
        --     else
        --         AddTextComponentSubstringPlayerName("Is Aiming: False")
        --     end
        -- end

        -- if inAirTest then
        --     if IsEntityInAir(player) then
        --         AddTextComponentSubstringPlayerName("Is in air: True")
        --         -- AddTextComponentSubstringPlayerName(("Is Aiming: %s"):format(IsAimCamActive()))
        --     else
        --         AddTextComponentSubstringPlayerName("Is in air: False")
        --     end
        -- end

        -- -- TODO Figure out how to add multiple of these
        -- -- This works but kills the KCNet test text whenever I enable/disable other options
        -- if statTest then
        --     -- New
        --     BeginTextCommandDisplayText("STRING")

        --     AddTextComponentSubstringPlayerName(("Cops killed: %s"):format(copsKilledCheck()))
        --     EndTextCommandDisplayText(0.0001, 0.0200, 0)

        --     BeginTextCommandDisplayText("STRING")
        --     setTextEntry()

        --     AddTextComponentSubstringPlayerName(("Cop cars blown up: %s"):format(getCopVehiclesBlownUp()))
        --     EndTextCommandDisplayText(0.0001, 0.0380, 0)
        --     -- AddTextComponentSubstringPlayerName(("Tires popped: %s"):format(getTiresPoppedByGunshot()))
        --     -- AddTextComponentSubstringPlayerName(("Total time driving: %s seconds"):format(getTimeAsDriver()))
        --     -- AddTextComponentSubstringPlayerName(("Total time flying heli: %s seconds"):format(getTimeAsHeliPilot()))
        --     -- AddTextComponentSubstringPlayerName(("Play time: %s"):format(getTotalPlayTime()))
        -- end

        -- if statTestNew then
        --     AddTextComponentSubstringPlayerName(("Stat table: %s"):format(checkForUpdatedStats()))
        -- end

        -- -- This one doesn't seem to work right
        -- if isInWaterTest then
        --     if IsEntityInWater(player) then
        --         AddTextComponentSubstringPlayerName("Are you in water: True")
        --     else
        --         AddTextComponentSubstringPlayerName("Are you in water: False")
        --     end
        -- end

        -- -- This works!
        -- -- Show the current parachute status
        -- -- https://nativedb.dotindustries.dev/gta5/natives/0x79CFD9827CC979B6?search=parachute
        -- if parachuteStatusTest then
        --     if GetPedParachuteState(player) == -1 then
        --         AddTextComponentSubstringPlayerName("Parachute status: Normal")
        --     elseif GetPedParachuteState(player) == 0 then
        --         AddTextComponentSubstringPlayerName("Parachute status: Wearing parachute")
        --     elseif GetPedParachuteState(player) == 1 then
        --         AddTextComponentSubstringPlayerName("Parachute status: Opening parachute")
        --     elseif GetPedParachuteState(player) == 2 then
        --         AddTextComponentSubstringPlayerName("Parachute status: Parachute open")
        --     elseif GetPedParachuteState(player) == 3 then
        --         AddTextComponentSubstringPlayerName("Parachute status: Falling to death")
        --     end
        -- end


        -- AddTextComponentSubstringPlayerName("S")
        -- AddTextComponentString("KCNet FiveM Test")
        -- Makes the text show up
        -- EndTextCommandDisplayText(0.0001, 0.0200, 0)

        -- EndTextCommandDisplayText(0.0001, 0.2, 0)
        -- DrawText(0.0001, 0.0001)
        -- DrawText3D(0, 0, 0, "TT")

        -- The rectangle
        -- DrawRect(100, 100, 3.2, 0.05, 66, 134, 244, 245)
        -- DrawRect(100, 100, 5.2, 0.05, 66, 134, 244, 245)
    end
end)


