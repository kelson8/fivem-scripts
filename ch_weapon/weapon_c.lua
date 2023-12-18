--[[RegisterCommand('weapon', function(source, args)
    local weaponName = args[1] or ''

    if not IsModelInCdimage(weaponName) or IsWeaponValid then
        TriggerEvent('chat:addMessage', {
            args = { 'The weapon' ..weaponName.. ' doesn\'t exist!' }
        })

        return
    end
    



end)]]

-- This is working for spawning in with a pistol
AddEventHandler('playerSpawned', function()
    local player = GetPlayerPed(PlayerId())
    local weapon = GetHashKey("WEAPON_PISTOL")

    GiveWeaponToPed(player, weapon, 1000, false, false)
end)

local ped = GetPlayerPed(PlayerId())
RegisterCommand("weapon", function(args, hash)

    GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 1000, false, false)
    --GiveWeaponToPed(ped, "weapon_" .. hash, 1000, false, false)
end, false)

RegisterCommand("weaponall", function(args, string)
    local ped = GetPlayerPed(PlayerId())
    
end, false)

RegisterCommand("clear", function()
    RemoveAllPedWeapons(ped, true)
    
    TriggerEvent('chat:addMessage', {
        args = { "You have removed all weapons!" }
    })

end, false)