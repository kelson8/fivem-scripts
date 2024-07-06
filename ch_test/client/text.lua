-- Basic drawing text to screen
-- https://www.youtube.com/watch?v=nBSCN4Pprak&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=3

local color = {
    r = 247,
    b = 223,
    g = 88,
    a = 255
}

CreateThread(function()
    while true do
        Wait(5)

        -- The Text
        SetTextFont(0) -- 0 -> 4
        SetTextScale(0.3, 0.3)
        SetTextColour(color.r, color.g, color.b, color.a)
        SetTextEntry("STRING")


        -- AddTextComponentString("KelsonCraft fivem test")
        AddTextComponentString("KCNet FiveM Test")
        -- Makes the text show up
        DrawText(0.0001, 0.0001)

        -- The rectangle
        -- DrawRect(100, 100, 3.2, 0.05, 66, 134, 244, 245)
        -- DrawRect(100, 100, 5.2, 0.05, 66, 134, 244, 245)
    end

end)