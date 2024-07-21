

-- Will this work?
-- This didn't seem to work :\
RegisterCommand("addblip", function()
    local player = getPlayerPed(-1)
    local playerCoords = GetEntityCoords(player)
    local playerx = playerCoords.x
    local playery = playerCoords.y
    local playerz = playerCoords.z

    local destination1 = AddBlipForCoord(117.38, -811.85, 30.43)
    -- AddBlipForCoord(playerx, playery + 10, playerz)
    
end, false)

----