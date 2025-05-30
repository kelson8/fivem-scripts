-- TODO Test this.
-- TODO Rename all file names from ch_ to kc_, so rename ch_test to kc_test

-- To switch to routing bucket with disabled peds:
-- Use /gettargetid to get your id, then run /lobby <id> 2
-- This'll put you in the 2nd routing bucket which I have peds and vehicles disabled in.
-- Which is useful for testing.
-- To go back to the main one: /lobby <id> 0


RegisterCommand("stoptask", function()
    ClearPedTasks(GetPlayerPed(-1))
    notify("Your tasks have been cleared!")
end, false)

-- TODO Test this, I pretty much made an enum in lua
local clothes = {}
clothes["Head"] = 0
clothes["Beard"] = 1
clothes["Hair"] = 2
clothes["Torso"] = 3
clothes["Legs"] = 4
clothes["Hands"] = 5
clothes["Shoes"] = 6
-- 7 Is nothing
-- Parachute, scuba tank
clothes["accessories1"] = 8
-- Bags, mask, scuba mask
clothes["accessories2"] = 9
clothes["DecalsAndMask"] = 10
clothes ["AuxPartsForTorso"] = 11


function clothesTest()
    -- Possibly implement this for other players also, with a permission.
    local player = GetPlayerPed(-1) -- or args[1]

    -- Not sure how exactly this works.

    -- TODO Test this.
    -- https://gtaxscripting.blogspot.com/2016/04/gta-v-peds-component-and-props.html
    -- SetPedComponentVariation(player, clothes["Torso"], 10, 0, 2, 2)

    -- Set the hair color to something other then that green color.
    -- https://forum.cfx.re/t/only-green-hair/43336/4
    SetPedComponentVariation(PlayerPedId(), clothes["Hair"], 1, 2, 0)
    -- SetPedPropIndex(player, clothes["Torso"], 4, )
end

RegisterCommand("clothes", function()
    clothesTest()
end, false)

-- https://docs.fivem.net/docs/game-references/text-formatting/
local testText = "The driving ped will go to your ~p~Marker~s~"
-- Will this show a subtitle in the bottom middle?
RegisterCommand("testsubtitle", function(_, _, rawCommand)
    showSubtitle(
        testText,
        -- This can get the arguments from the player
        -- rawCommand,
        10000
    )
end, false)

--
-- RegisterCommand("flashlightstatus", function()
--         local flashlightStatus = IsFlashLightOn(ped)
--         notify("Your flash light is " .. flashlightStatus)
-- end, false)

RegisterCommand("kersboost", function()
    local player = GetPlayerPed(-1)

    local isInVehicle = IsPedInAnyVehicle(player, false)
    local vehicle = GetVehiclePedIsIn(player, false)
    local getKers = GetVehicleHasKers(vehicle)


    if isInVehicle then
        -- If vehicle doesn't have kers boost, enable it
        if getKers then
            SetVehicleKersAllowed(vehicle, true)
            notify("Enabled kers boost for vehicle.")
        else
            SetVehicleKersAllowed(vehicle, false)
            notify("Disabled kers boost for vehicle.")
        end
    else
        notify("You need a vehicle for this!")
    end
end)


--------------
-- Fun/Admin functions
--------------

function blowupPlayer()
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x,y,z = playerPos.x, playerPos.y, playerPos.z

    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    if IsPedInAnyVehicle(player) then
        local vehicle = GetVehiclePedIsIn(player, false)
        -- sendMessage("Your car is going to ~r~explode~s~ in 2 seconds.")
        Wait(2000)
        ExplodeVehicle(vehicle, true, false)

        -- Well the gas pump kills me even if I try to run away.
        AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    else
    
    
    -- sendMessage("You are going to ~r~explode~s~ in 2 seconds.")
    Wait(2000)

    -- Well the gas pump kills me even if I try to run away.
    AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    end
end

-- This should be fun
-- I got this working right now
-- Copied into kc_menu
RegisterCommand("dropbomb", function(source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local x,y,z = playerPos.x, playerPos.y, playerPos.z


    local gaspumpExplosion = 9
    local railgunExplosion = 36
    local damageScale = 100.0

    if IsPedInAnyVehicle(player) then
        local vehicle = GetVehiclePedIsIn(player, false)
        local vehX, vehY, vehZ = GetEntityCoords(vehicle)

        sendMessage("Your car is going to ~r~explode~s~ in 2 seconds.")
        -- Stop the vehicle instantly.
        BringVehicleToHalt(vehicle, 0.1, 1, 1)

        -- This didn't seem to work
        ExplodeVehicle(vehicle, true, false)
        -- Just for good measure, you can't escape anymore
        SetVehicleBodyHealth(vehicle, 0)
        SetVehicleWheelHealth(vehicle, 0)
        SetVehicleEngineHealth(vehicle, 0)
        SetVehiclePetrolTankHealth(vehicle, 0)

        -- Disable the vehicle engine
        SetVehicleEngineOn(vehicle, false, true, true)

        Wait(2000)
        -- This kills the player but the car won't blow up
        -- SetVehicleOutOfControl(vehicle, false, true)

        -- Well the gas pump kills me even if I try to run away.
        AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
    else


        -- I never did get this part of this command working
        -- if args[1] ~= nil then
        --     TODO Figure out how to send a message to the other clients.
        --     sendMessage("You are going to ~r~explode~s~ in 2 seconds.")
            -- Wait(2000)
            
            -- AddOwnedExplosion(args[1], x,y,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
        -- else
        --     sendMessage("You are going to ~r~explode~s~ in 2 seconds.")
        --     Wait(2000)
        --     AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)
        -- end


        sendMessage("You are going to ~r~explode~s~ in 2 seconds.")
        Wait(2000)

        -- Well the gas pump kills me even if I try to run away.
        AddOwnedExplosion(player, x,y,z, gaspumpExplosion, damageScale, 1, 0, 1065353216, 0)


        -- I didn't get this loop to work.
        -- local explosionCount = 5
        -- for i=explosionCount, 1, -1
        -- do
        --     AddExplosion(x,y,z, 9, 100.0, 1, 0, 1065353216, 0)
        -- end

        -- AddOwnedExplosion(player, x,y,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)

        -- AddExplosion(player, x+2,y,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
        -- AddOwnedExplosion(player, x+1,y+1,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
        -- AddOwnedExplosion(player, x+2,y+2,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
        -- AddOwnedExplosion(player, x+4,y+4,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
        -- AddOwnedExplosion(player, x+6,y+6,z, railgunExplosion, damageScale, 1, 0, 1065353216, 0)
    end

end, false)


-- Todo Fix this toggle to work.
-- RegisterCommand("endlessbombs", function()
--     endlessBombs = false
--     if not endlessBombs then
--         endlessBombs = true
--         sendMessage("Enabled endless bombs.")
--     else
--         endlessBombs = false
--         sendMessage("Disabled endless bombs.")
--     end
-- end, false)


-- Chaos mode? This will be insane
-- CreateThread(function()
    -- I never did get this toggle working
    -- if endlessBombs then
        -- This loop works fine.
        -- while true do
        --     Wait(0)
        --     blowupPlayer()
        -- end
    -- end
-- end)

--------------
--
--------------

-- This shows the military base on the map like in online, I didn't know this was how to toggle these.
RegisterCommand("showarmybase", function()
    SetMinimapComponent(15, true)
end, false)

RegisterCommand("hidearmybase", function()
    SetMinimapComponent(15, false)
end, false)

RegisterCommand("minimaptest", function()
    SetMinimapComponent(4, true)
end)
