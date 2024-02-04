-- This looks like it could be fun, set player invincible with ragdoll enabled.
-- SetPlayerInvincibleKeepRagdollEnabled(player)

-- I wonder how this one works.
-- https://pastebin.com/GBnsQ5hr
-- PlayPoliceReport()

-- IsPlayerDrivingDangerously()

--[[
    SetPlayerMayNotEnterAnyVehicle()
    SetPlayerMayOnlyEnterThisVehicle()
]]


--[[
Try and see how these work
https://docs.fivem.net/natives/?_0x332169F5
GetAllVehicles()

https://docs.fivem.net/natives/?_0xD7531645
GetAllVehicleModels()

https://docs.fivem.net/natives/?_0x1647F1CB
GetEntityCoords()

https://docs.fivem.net/natives/?_0xE41CA53051197A27
IsBlipOnMinimap(blip)

https://docs.fivem.net/natives/?_0xA4E8E696C532FBC7
CreateMobilePhone(0-4)
]]

-- Try and play around with routing buckets, those might be fun to screw around with
--[[
SetEntityRoutingBucket(entity, bucket)
SetPlayerRoutingBucket(player, bucket)

GetPlayerRoutingBucket(player)
GetEntityRoutingBucket(entity)
]]

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

-- This did nothing

-- Start gps multi route: https://docs.fivem.net/natives/?_0x3D3D15AF7BCAAF83
-- Add point to gps multi route: https://docs.fivem.net/natives/?_0xA905192A6781C41B
-- RegisterCommand("setmarker", function()
--     StartGpsMultiRoute(1, true, false)
--     SetGpsMultiRouteRender(true, 16, 16)

--     notify("Marker set!")
-- end)

-- RegisterCommand("addtomarker", function()
--     -- Add option for custom coords such as clicking an area on the map,
--     -- Or on the player position
--     posX, posY, posZ = GetEntityCoords(PlayerId())
--     AddPointToGpsMultiRoute(posX, posY, posZ)

--     notify("You added your coords to the current marker!")
-- end)