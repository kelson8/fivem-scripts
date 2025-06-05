

local controlActions = { 12, 13, 14, 15, 16, 17, 24, 25, 37, 68, 69, 70, 257, 263, 264 }

-- This works!
-- I disabled weapons in the casino, although you keep your weapon in hand.
-- Mostly adapted from events.lua in kc_test.

-- So far all this does is disable weapons and using them in the casino.

local casinoInterior = 278017

RegisterCommand("interiorid", function (source, args, rawCommand)
    local player = GetPlayerPed(-1)
    local interiorid = GetInteriorFromEntity(player)

    -- Text.Notify(string.format("You are in interior ID: %f", interiorid))

    if GetInteriorFromEntity(player) == casinoInterior then
        Text.Notify(string.format("You are in casino interior ID%f", casinoInterior))
    else
        Text.Notify("Not in interior")
    end

    
end, false)

-- TODO Fix this to work. Not sure why it doesn't put away the players weapon.
local function HolsterWeapon()
    local player = GetPlayerPed(-1)
    local currentWeapon = GetCurrentPedWeapon(player)
    local unarmedHash = GetHashKey("weapon_unarmed")
    local weaponKnuckleHash = GetHashKey("weapon_knuckle")

    if not currentWeapon == unarmedHash or not currentWeapon == weaponKnuckleHash then
        SetCurrentPedWeapon(player, unarmedHash, true)
    end
end


Citizen.CreateThread(function ()
    local player = GetPlayerPed(-1)
    while true do
        Wait(0)
        if GetInteriorFromEntity(player) == casinoInterior then
            for i, v in ipairs(controlActions) do
                DisableControlAction(0, v, false)
                HolsterWeapon()
            end
        end
    end
end)