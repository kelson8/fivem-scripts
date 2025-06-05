-- Menus = {}
-- Menus = Menus or {}
Menus = {}

Buttons = {}

local menu = GetMenu()

Menus.Warps = Menus.Warps or {}


--- This populates the warp menu from warp_config.lua.
local function PopulateWarpMenu()
    -- Clear existing buttons in case it's opened multiple times (optional, but good for refresh)
    warpMenu:ClearItems()
    -- Menus.Warp:ClearItems()

    -- This works!!!
    -- Show a list of warps from the config

    -- Iterate over the Warps table.
    -- 'warpName' will be the key (e.g., "AircraftCarrier1")
    -- 'warpData' will be the table associated with that key (e.g., {x=..., y=..., z=..., name="..."})
    for warpName, warpData in pairs(Warps) do
        -- Use warpData.name for the button's display label
        local buttonLabel = warpData.name or warpName -- Fallback to warpName if 'name' field is missing
        local buttonDescription = "Warp to " .. buttonLabel .. "."

        local warpButton = warpMenu:AddButton({ label = buttonLabel, description = buttonDescription })
        -- local warpButton = Menus.Warp:AddButton({ label = buttonLabel, description = buttonDescription })

        warpButton:On("select", function()
            teleportToWarps(warpName)
            MenuV:CloseMenu()
        end)
    end

    -- More buttons can be added to this.
        -- Extra buttons here.
    warpToSkyButton = warpMenu:AddButton({
    -- warpToSkyButton = Menus.Warp:AddButton({
        label = "Warp to Sky",
        description =
        "Warp to the sky, add +50 to z. Warning this will kill you."
    })


    -- Button functions
    warpToSkyButton:On("select", function()
        warpToSky()
    end)

    -- Possible future back button.
    -- local backButton = MenuV.Button("Back", "Go back to the main menu.")
    -- warpMenu:AddButton(backButton)
    -- backButton:On("select", function()
    --     MenuV:CloseMenu()
    --     MenuV:OpenMenu(mainMenu)
    -- end)
end


-- Now you can define functions directly as fields within Menus.Warps
function Menus.Warps.Teleport(warpName)
    -- Your existing teleportToWarps logic goes here
    local warpLocation = Warps[warpName] -- Assuming 'Warps' table is globally accessible

    if warpLocation then
        Teleports.TeleportFade(warpLocation.x, warpLocation.y, warpLocation.z, 10.0)

        if warpName == "Spawn1" then
            World.DisableCayoPericoIsland()
            exports.kc_util:Notify("Warped to spawn.")
        elseif warpName == "CayoPerico" then
            exports.kc_util:Notify("Warped to Cayo Perico.")
        else
            exports.kc_util:Notify("Warped to " .. (warpLocation.name or warpName) .. ".")
        end
    else
        exports.kc_util:Notify("Error: Warp location '" .. warpName .. "' not found.")
    end
end

-- Set the event handler for the main menu button that opens the warp menu.
-- This 'warpMenuButton' must be globally accessible or passed as an argument.
warpMenuButton:On("select", function()
    -- Populate the list of warps from warp_config.lua.
    PopulateWarpMenu()

    MenuV:OpenMenu(warpMenu)
    -- MenuV:OpenMenu(Menus.Warp)
end)

