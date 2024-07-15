RegisterNetEvent('showNotification')
AddEventHandler('showNotification', function(text)
	ShowNotification(text)
end)
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(0,1)
end
Citizen.CreateThread(function()
    -- main loop thing
	alreadyDead = false
    while true do
        Citizen.Wait(50)
		local playerPed = GetPlayerPed(-1)
		if IsEntityDead(playerPed) and not alreadyDead then
			killer = GetPedKiller(playerPed)
			killername = false
			for id = 0, 64 do
				if killer == GetPlayerPed(id) then
					killername = GetPlayerName(id)
				end				
			end
			if killer == playerPed then
				TriggerServerEvent('playerDied',0,0)
			elseif killername then
				TriggerServerEvent('playerDied',killername,1)
			else
				TriggerServerEvent('playerDied',0,2)
			end
			alreadyDead = true
		end
		if not IsEntityDead(playerPed) then
			alreadyDead = false
		end
	end
end)


-- TODO Test this
-- Will this work?
-- exports(
-- 	"Draw3DText", function(x,y,z,textInput,fontId,scaleX,scaleY)
-- 		local px,py,pz=table.unpack(GetGameplayCamCoords())
-- 		local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
-- 		local scale = (1/dist)*20
-- 		local fov = (1/GetGameplayCamFov())*100
-- 		local scale = scale*fov
-- 		SetTextScale(scaleX*scale, scaleY*scale)
-- 		SetTextFont(fontId)
-- 		SetTextProportional(true)
-- 		SetTextColour(250, 250, 250, 255)		-- You can change the text color here
-- 		SetTextDropshadow(1, 1, 1, 1, 255)
-- 		SetTextEdge(2, 0, 0, 0, 150)
-- 		SetTextDropShadow()
-- 		SetTextOutline()
-- 		SetTextEntry("STRING")
-- 		SetTextCentre(true)
-- 		AddTextComponentString(textInput)
-- 		SetDrawOrigin(x,y,z+2, 0)
-- 		DrawText(0.0, 0.0)
-- 		ClearDrawOrigin()
-- 	   end
-- )

-- function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
--     local px,py,pz=table.unpack(GetGameplayCamCoords())
--     local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, true)
--     local scale = (1/dist)*20
--     local fov = (1/GetGameplayCamFov())*100
--     local scale = scale*fov
--     SetTextScale(scaleX*scale, scaleY*scale)
--     SetTextFont(fontId)
--     SetTextProportional(true)
--     -- SetTextProportional(1)
--     SetTextColour(250, 250, 250, 255)		-- You can change the text color here
--     SetTextDropshadow(1, 1, 1, 1, 255)
--     SetTextEdge(2, 0, 0, 0, 150)
--     SetTextDropShadow()
--     SetTextOutline()
--     SetTextEntry("STRING")
--     SetTextCentre(true)
--     AddTextComponentString(textInput)
--     SetDrawOrigin(x,y,z+2, 0)
--     DrawText(0.0, 0.0)
--     ClearDrawOrigin()
--    end