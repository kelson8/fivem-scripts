Menus = {}

Buttons = {}
-- Buttons.Player = {}

Checkboxes = {}

local menu = GetMenu()

-- TODO Figure out why this doesn't work, the music menu does work in a new file.
-- I may revert it in the main menu.lua in a bit.

-- playerMenu = MenuV:CreateMenu("Player", "Player menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
Menus.PlayerMenu = MenuV:CreateMenu("Player", "Player Menu", "topleft", 255, 0, 0, "size-110", "default",
    "menuv", "playerMenuNamespace", "native")

-- local playerMenuButton = menu:AddButton({ label = "Player Menu", value = menu2, description = 'Open Player Menu' })
Buttons.PlayerMenuButton = menu:AddButton({ label = "Player Menu", description = 'Open Player Menu' })
-- Buttons.Player.PlayerMenuButton = menu:AddButton({ label = "Player Menu", value = menu2, description = 'Open Player Menu' })

-----------
--- Player buttons
-----------

-- local healPlayerButton = playerMenu:AddButton({
Buttons.HealPlayerButton = Menus.PlayerMenu:AddButton({
    label = "Heal yourself",
    description =
    'Heal yourself'
})

Buttons.RandomOutfitButton = Menus.PlayerMenu:AddButton({
    label = "Random Outfit",
    description =
    'Change your multiplayer skin to a random outfit.'
})

-- TODO Figure out how to toggle ragdoll
-- local ragDollToggleButton = playerMenu:AddCheckbox({
Buttons.RagDollToggleButton = Menus.PlayerMenu:AddButton({
    label = "Toggle ragdoll",
    description =
    'Toggle ragdoll on/off'
})

-- This didn't do anything
-- Buttons.EnvEffButton = Menus.PlayerMenu:AddButton({
--     label = "Test Env Eff",
--     description =
--     'Debug test'
-- })

-- Checkboxes.RagDollToggleCheckbox = Menus.PlayerMenu:AddCheckbox({
--     label = "Toggle ragdoll",
--     description =
--     'Toggle ragdoll on/off'
-- })

Buttons.MpSuicideButton = Menus.PlayerMenu:AddButton({
    label = "MP Suicide",
    description =
    'Kill yourself with the online animation'
})

Checkboxes.InvincibilityCheckbox = Menus.PlayerMenu:AddCheckbox({
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
-- playerMenuButton:On("select", function()
Buttons.PlayerMenuButton:On("select", function()
    -- Buttons.Player.PlayerMenuButton:On("select", function()
    -- MenuV:OpenMenu(playerMenu, function()
    MenuV:OpenMenu(Menus.PlayerMenu, function()
        -- healPlayerButton:On("select", function()
        Buttons.HealPlayerButton:On("select", function()
            local player = GetPlayerPed(-1)
            SetEntityHealth(player, 250)
        end)

        -- randomOutfitButton:On("select", function()
        Buttons.RandomOutfitButton:On("select", function()
            SetRandomOutfit()
        end)

        -- ragDollToggleButton:On("select", function()
        Buttons.RagDollToggleButton:On("select", function()
            -- SetRandomOutfit()
        end)

        -- This didn't do anything
        -- envEffButton:On("select", function ()
        -- Buttons.EnvEffButton:On("select", function ()
        --     ToggleEnvEffScale()
        -- end)


        -- ragDollToggleCheckbox:On("Press")
        -- Checkboxes.RagDollToggleCheckbox:On("Press")

        -- mpSuicideButton:On("select", function ()
        Buttons.MpSuicideButton:On("select", function()
            MpSuicide()
        end)

        -- https://menuv.netlify.app/#CheckboxItem
        -- invincibilityCheckbox:On('change', function(item, newValue, oldValue)
        Checkboxes.InvincibilityCheckbox:On('change', function(item, newValue, oldValue)
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
