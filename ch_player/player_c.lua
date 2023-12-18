-- Make the player invincible
--[[
local isInvincible = false

function toggleInvincibility()
    local isInvincible = not isInvincible
    SetEntityInvincible(PlayerPedId(), isInvincible)
end
]]



RegisterCommand('god', function(source, args)
    god = not god
    local ped = GetPlayerPed(PlayerId())
    if god then
        --SetEntityInvincible(GetPlayerPed(ped), true)
        SetEntityInvincible(ped, true)
        TriggerEvent('chat:addMessage', {
            args = { 'You have enabled god mode! ' }
        })
        --notify("~g~God Mode On")
    else
        --SetEntityInvincible(GetPlayerPed(ped), false)
        SetEntityInvincible(ped, false)
        TriggerEvent('chat:addMessage', {
            args = { 'You have disabled god mode! ' }
        })
        --notify("~r~God Mode Off")
    end
  end, false)

RegisterCommand('kms', function()
    local ped = GetPlayerPed(PlayerId())
    SetEntityHealth(ped, 0)
end)


--[[
RegisterCommand("god", function()
    godmode = not godmode
    SetEntityInvincible(GetPlayerPed(-1), godmode)
    if (godmode) then
        TriggerEvent('chat:addMessage', {
            args = { 'You have enabled god mode! ' }
        })
    else
        TriggerEvent('chat:addMessage', {
            args = { 'You have disabled god mode! ' }
        })
    end
end, false)

--]]

--[[
RegisterCommand("god", function()
    local ped = GetPlayerPed(PlayerId())
    toggleInvincibility()
    TriggerEvent('chat:addMessage', {
        args = { 'You have toggled god mode! ' }
    })

    --SetEntityInvincible(ped, true)
    --[[
    if args[1] == true then
        SetEntityInvincible(ped, true)
        TriggerEvent('chat:addMessage', {
            args = { 'You have enabled god mode! ' }
        })
    elseif args[1] == false then
        SetEntityInvincible(ped, false)
        TriggerEvent('chat:addMessage', {
            args = { 'You have disabled god mode! ' }
        })
    end]]

--end, false)