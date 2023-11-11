--[[RegisterCommand('weapon', function(source, args)
    local weaponName = args[1] or ''

    if not IsModelInCdimage(weaponName) or IsWeaponValid then
        TriggerEvent('chat:addMessage', {
            args = { 'The weapon' ..weaponName.. ' doesn\'t exist!' }
        })

        return
    end
    



end)]]

-- This is working for spawning in with a pistol, but I don't have any ammo
AddEventHandler('playerSpawned', function()
    local player = GetPlayerPed(PlayerId())
    local weapon = GetHashKey("WEAPON_PISTOL")

    GiveWeaponToPed(player, weapon)
end)

RegisterCommand("weapon", function(args, string)
    local ped = GetPlayerPed(PlayerId())
    GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 1000, false, false)
end, false)

RegisterCommand("weaponall", function(args, string)
    local ped = GetPlayerPed(PlayerId())

end, false)