-- https://nativedb.dotindustries.dev/gta5/natives/0x93C8B64DEB84728C?search=killed

-- Todo Setup a function that uses this to check how many peds the player has killed, I could possibly look into stats
function GetSourceOfDeath(ped)
    if IsEntityDead(ped, false) then
        notify(GetPedSourceOfDeath(ped))
    end
end