---@diagnostic disable: undefined-field
-- Menus = {}

-- Buttons = {}
-- -- Buttons.Player = {}

-- Checkboxes = {}

local menu = GetMenu()

-----------
--- Player buttons
-----------

local HealPlayerButton = PlayerMenu:AddButton({
    label = "Heal yourself",
    description =
    'Heal yourself'
})

local RandomOutfitButton = PlayerMenu:AddButton({
    label = "Random Outfit",
    description =
    'Change your multiplayer skin to a random outfit.'
})

-- TODO Figure out how to toggle ragdoll
local RagDollToggleButton = PlayerMenu:AddCheckbox({
    label = "Toggle ragdoll",
    description =
    'Toggle ragdoll on/off'
})

-- This didn't do anything
-- local EnvEffButton = PlayerMenu:AddButton({
--     label = "Test Env Eff",
--     description =
--     'Debug test'
-- })

-- local RagDollToggleCheckbox = PlayerMenu:AddCheckbox({
--     label = "Toggle ragdoll",
--     description =
--     'Toggle ragdoll on/off'
-- })

local MpSuicideButton = PlayerMenu:AddButton({
    label = "MP Suicide",
    description =
    'Kill yourself with the online animation'
})

local InvincibilityCheckbox = PlayerMenu:AddCheckbox({
    label = "Toggle infinte health",
    description =
    'Invincible player'
})

-----------
---
-----------

-----------
--- Player menu button
-----------
-- Well this is how to make sub menus, at least it works like this.
PlayerMenuButton:On("select", function()
    MenuV:OpenMenu(PlayerMenu, function()
        HealPlayerButton:On("select", function()
            local player = GetPlayerPed(-1)
            SetEntityHealth(player, 250)
        end)

        RandomOutfitButton:On("select", function()
            SetRandomOutfit()
        end)

        RagDollToggleButton:On("select", function()
            -- SetRandomOutfit()
        end)

        -- This didn't do anything
        -- EnvEffButton:On("select", function ()
        --     ToggleEnvEffScale()
        -- end)


        -- RagDollToggleCheckbox:On("Press")

        MpSuicideButton:On("select", function ()
            MpSuicide()
        end)

        -- https://menuv.netlify.app/#CheckboxItem
        InvincibilityCheckbox:On('change', function(item, newValue, oldValue)
            -- Set invincibility here.
            if newValue then
                EnableInvincibility()
            else
                DisableInvincibility()
            end
        end)
    end)
end)
-----------
---
-----------
