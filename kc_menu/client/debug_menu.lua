

-- Test
-- TODO Try to get this debug menu to work in this file.


-- Disabled for now
-- if DebugConfig.debugMode then
--     local debugMenu = MenuV:CreateMenu("Debug", "Debug menu", "topleft", 255, 0, 0, "size-110", "default", "menuv",
--         "debugMenuNamespace", "native")
-- end

-- if DebugConfig.debugMode then
--     local debugMenuButton = menu:AddButton({ label = "Debug Menu", description = 'Open Debug Menu' })
-- end



-----------
--- Debug mode buttons and sliders
-----------

-- if DebugConfig.debugMode then
-- -- These don't work right
-- debugTestEnableButton = debugMenu:AddButton({ label = "Enable Debug mode" })
-- debugTestDisableButton = debugMenu:AddButton({ label = "Disable Debug mode" })


-- debugTestSlider = debugMenu:AddSlider({
--     label = "Test slider",
--     value = "pedsKilled",
--     values = {
--         { label = 'Peds Killed Stat', value = 'pedsKilled', description = 'Toggle peds killed' },
--         { label = 'Is Aiming Stat',   value = 'isAiming',   description = 'Toggle is aiming stat' },
--         { label = 'Demo Item 3',      value = 'demo3',      description = 'Demo Item 3' },
--         { label = 'Demo Item 4',      value = 'demo4',      description = 'Demo Item 4' }
--     }
-- })
-- end

-----------
---
-----------

local function cleanUpDebug()
    aimCamTest = false
end

-----------
--- Debug mode menu button
-----------

-- Disabled for now
-- if DebugConfig.debugMode then
-- debugMenuButton:On("select", function()

--     MenuV:OpenMenu(debugMenu, function()
--         -- These don't work right
--         debugTestEnableButton:On("select", function()
--             enableDebugMode()
--         end)

--         debugTestDisableButton:On("select", function()
--             disableDebugMode()
--         end)

--         -- TODO Make this to where it only activates once instead of however many times its selected
--         debugTestSlider:On("select", function(item, value)
--             -- aimCamTest = true
--             if debugMode then
--                 -- if value == "pedsKilled" then
--                 --     return
--                 if value == "isAiming" then
--                     aimCamTest = true
--                     enableDebugMode()
--                 else
--                     cleanUpDebug()
--                 end
--             end
--             -- end
--         end)

--         -- Add these sometime, enable/disable the KCNet test text
--         -- enableKcNetTextButton:

--         -- TODO Fix this to work
--         toggleDebugModeButton:On("select", function()
--             -- if not getDebugMode() then
--             if not debugMode then
--                 enableDebugMode()
--             else
--                 disableDebugMode()
--             end
--         end)
--     end)
-- end)

-- end

-----------
---
-----------