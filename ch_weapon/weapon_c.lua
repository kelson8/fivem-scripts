function alert(msg)
    SetTextComponentFormat("STRING")
    AddTextComponentString(msg)
    DisplayHelpTextFromStringLabel(0,0,0, -1)
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- Move this into function, to be used later.
function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 999, false, false)
end

-- This is working for spawning in with a pistol
AddEventHandler('playerSpawned', function()
    local player = GetPlayerPed(PlayerId())
    local weapon = GetHashKey("WEAPON_PISTOL")

    GiveWeaponToPed(player, weapon, 1000, false, false)
end)

RegisterCommand("weapon", function(source, args)

    --local ped = GetPlayerPed(PlayerId())
    -- This almost works.
    local ped = PlayerPedId()
    local weaponName = "weapon_" .. tostring(args[1])
    --local weaponName = GetHashKey(args[1])

    -- Need to check if given weapon hash is valid
    if not IsWeaponValid(weaponName) then
        notify("Invalid weapon \'" .. weaponName .. '\'')
        return
    end
    giveWeapon(weaponName)
    alert("~b~Enjoy your new " .. args[1])
end, false)


-- Create a list of hash names with weapon hashes in weapon_list.lua
RegisterCommand("weaponall", function(args, string)
    local ped = GetPlayerPed(PlayerId())

    -- Gets list of hash names from weapon_list.lua
    for i=0, #allweapons do
        GiveWeaponToPed(ped, GetHashKey(allweapons[i]), 999, false, false)
    end

    --for i, weapons in
    
end, false)

-- Remove weapons
RegisterCommand("clear", function()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    notify("You have removed all weapons!")
end, false)