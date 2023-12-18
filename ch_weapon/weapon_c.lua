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

RegisterCommand("weapon", function(source, args)

    --local ped = GetPlayerPed(PlayerId())
    -- This almost works.
    local ped = PlayerPedId()
    local weaponName = "weapon_" .. tostring(args[1])
    --local weaponName = GetHashKey(args[1])


    -- Create a list of hash names.

    -- Need to check if given weapon hash is valid
    if not IsWeaponValid(weaponName) then
        TriggerEvent('chat:addMessage', {
            args = { 'Weapon not recognized \'' .. weaponName .. '\'' }
        })
        return
    end
    GiveWeaponToPed(ped, weaponName, 1000, false, false)

    
    --GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL"), 1000, false, false)
end, false)



RegisterCommand("weaponall", function(args, string)
    local ped = GetPlayerPed(PlayerId())

    -- Gets list of hash names from weapon_list.lua
    for i=0, #allweapons do
        GiveWeaponToPed(ped, GetHashKey(allweapons[i]), 999, false, false)
    end

    --for i, weapons in
    
end, false)

RegisterCommand("clear", function()
    RemoveAllPedWeapons(ped, true)
    
    TriggerEvent('chat:addMessage', {
        args = { "You have removed all weapons!" }
    })

end, false)