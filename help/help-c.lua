RegisterCommand("help", function()
    msg("Servers Website: kelsoncraft.net")
end, false)

--
-- function msg(text)
--    TriggerEvent("chatMessage", "[Server]" {255,0,0}, text)
--end

function msg(text)
    TriggerEvent("chat:addMessage",{
        color = {255,0,0},
        multiline = true,
        args = {"[Server]", text}

    })
end

