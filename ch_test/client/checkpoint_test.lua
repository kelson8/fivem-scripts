function checkpointTest()
    CreateCheckpoint(1, 670.6, 3611.57, 32.29, 666.41, 3602.4, 32.6, 10, 255, 0, 0, 255, 0)
end

RegisterCommand("checkpoint", checkpointTest, false)

function markerTest()
    DrawMarker(29, 650.76, 3582.39, 32.87, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 120, 255, 120, 155,
    false, true, 2, true, nil, nil, false)
end

-- Citizen.CreateThread(function()
--     while true do
--         Wait(1)
--         DrawMarker(29, 650.76, 3582.39, 34, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 2.0, 120, 255, 120, 155,
--         false, true, 2, true, nil, nil, false)
--         -- markerTest()
--     end
-- end)

-- RegisterCommand("marker1", markerTest, false)