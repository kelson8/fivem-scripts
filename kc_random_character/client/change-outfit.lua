--[[
            vf_base - Venomous Freemode - base resource
              Copyright (C) 2018-2020  FiveM-Scripts
              Copyright (c) 2025 kelson8 - New changes

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program in the file "LICENSE".  If not, see <http://www.gnu.org/licenses/>.
]]

-- GetRandomMultiPlayerModel("mp_m_freemode_01")

local mp_male = "mp_m_freemode_01"
local mp_female = "mp_f_freemode_01"

-- Works as a basic outfit randomizer for the mp_male and mp_female skins

-- Taken from Enums.h in KCTrainerV
local PedVarComp = {
    -- PV_COMP_INVALID = -1,
    PV_COMP_HEAD    = 0,
    PV_COMP_BERD    = 1,
    PV_COMP_HAIR    = 2,
    PV_COMP_UPPR    = 3,
    PV_COMP_LOWR    = 4,
    PV_COMP_HAND    = 5,
    PV_COMP_FEET    = 6,
    PV_COMP_TEEF    = 7,
    PV_COMP_ACCS    = 8,
    PV_COMP_TASK    = 9,
    PV_COMP_DECL    = 10,
    PV_COMP_JBIB    = 11,
    PV_COMP_MAX     = 12
}

-- Taken from spawn.lua in vf_base

RegisterCommand("random_skin", function()
    playerId = PlayerId()
    playerName = GetPlayerName(playerId)
    playerPed = PlayerPedId()
    if IsPlayerPlaying(playerId) then
        -- GetRandomMultiPlayerModel(mp_male)
        SetRandomSkin()
        -- print("Skin changed")
    end
end, false)

function SetRandomSkin()
		if IsPedMale(PlayerPedId()) then
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_HEAD, math.random(0, 5), 0, 2)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_HAIR, math.random(1, 17), 3, 2)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_UPPR, 0, 0, 2)

			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_LOWR, 1, math.random(0, 15), 2)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_FEET, 3, math.random(0, 15), 2)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_ACCS, 0, 240, 0)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_DECL, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), PedVarComp.PV_COMP_JBIB, 0, math.random(0, 5), 0)
		else
            -- TODO Fix this one.
			SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 2, math.random(1, 17), 3, 2)
			SetPedComponentVariation(PlayerPedId(), 3, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 4, 1, math.random(2), 2)
			SetPedComponentVariation(PlayerPedId(), 6, math.random(0, 6), 0, 2)

			SetPedComponentVariation(PlayerPedId(), 8, 2, 2, 2)
			SetPedComponentVariation(PlayerPedId(), 10, 7, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 11, 0, 2, 2)
		end
end


function GetRandomMultiPlayerModel(modelhash)
	local playerPed = PlayerPedId()

	if IsModelValid(modelhash) then
		if not IsPedModel(playerPed, modelHash) then
			RequestModel(modelhash)
			while not HasModelLoaded(modelhash) do
				Wait(500)
			end

			SetPlayerModel(PlayerId(), modelhash)
		end

		SetPedHeadBlendData(PlayerPedId(), 0, math.random(45), 0,math.random(45), math.random(5), math.random(5),1.0,1.0,1.0,true)
		SetPedHairColor(PlayerPedId(), math.random(1, 4), 1)

		if IsPedMale(PlayerPedId()) then
			SetPedComponentVariation(PlayerPedId(), 0, math.random(0, 5), 0, 2)
			SetPedComponentVariation(PlayerPedId(), 2, math.random(1, 17), 3, 2)
			SetPedComponentVariation(PlayerPedId(), 3, 0, 0, 2)

			SetPedComponentVariation(PlayerPedId(), 4, 1, math.random(0, 15), 2)
			SetPedComponentVariation(PlayerPedId(), 6, 3, math.random(0, 15), 2)
			SetPedComponentVariation(PlayerPedId(), 8, 0, 240, 0)
			SetPedComponentVariation(PlayerPedId(), 10, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 11, 0, math.random(0, 5), 0)
		else
			SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 2, math.random(1, 17), 3, 2)
			SetPedComponentVariation(PlayerPedId(), 3, 0, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 4, 1, math.random(2), 2)
			SetPedComponentVariation(PlayerPedId(), 6, math.random(0, 6), 0, 2)

			SetPedComponentVariation(PlayerPedId(), 8, 2, 2, 2)
			SetPedComponentVariation(PlayerPedId(), 10, 7, 0, 2)
			SetPedComponentVariation(PlayerPedId(), 11, 0, 2, 2)
		end

		SetModelAsNoLongerNeeded(modelhash)
	end
end