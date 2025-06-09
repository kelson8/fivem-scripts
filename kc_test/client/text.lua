-- Basic drawing text to screen
-- https://www.youtube.com/watch?v=nBSCN4Pprak&list=PLIpzpS7fwntTQOAh2bS8Tz-g8NP4WFhG2&index=3


-- Setup text for string
local function SetupText()
    SetTextFont(0) -- 0 -> 4
    SetTextScale(0.3, 0.3)
    SetTextColour(TextConfig.ColorR, TextConfig.ColorG, TextConfig.ColorB, TextConfig.ColorA)
    BeginTextCommandDisplayText("STRING")
end

-- This gets the name of the hash from the gxt, should be useful for later.
-- GetFilenameForAudioConversation("CLO_APF_U_1_0")

CreateThread(function()
    while true do
        Wait(1)
        if TextConfig.ServerTextEnabled then
            SetupText()

            AddTextComponentSubstringPlayerName(TextConfig.ServerTextMessage)
            -- Makes the text show up
            EndTextCommandDisplayText(0.0001, 0.0001)

            -- The rectangle
            -- DrawRect(100, 100, 3.2, 0.05, 66, 134, 244, 245)
            -- DrawRect(100, 100, 5.2, 0.05, 66, 134, 244, 245)
        end

        -- Well some of these GXT names display
        if TextConfig.GxtTestTextEnabled then
            SetupText()

            -- AddTextComponentSubstringPlayerName(TextConfig.ServerTextMessage)
            -- Well this shows up
            -- AddTextComponentSubstringTextLabel("ES_HELP")

            -- https://github.com/root-cause/v-clothingnames/blob/master/female_tops.json
            -- Hmm, these strings from the clothes actually show up! I could use them for a menu possibly
            AddTextComponentSubstringTextLabel("CLO_APF_U_1_0")


            -- These don't seem to work
            -- AddTextComponentSubstringTextLabel("CMOD_BUY")
            -- AddTextComponentSubstringTextLabelHashKey(GetHashKey("CMOD_BUY"))

            -- AddTextComponentSubstringTextLabel("CMM_MAINTAIN")

            -- Makes the text show up
            EndTextCommandDisplayText(0.0001, 0.0200)
        end
    end
end)

-- https://forum.cfx.re/t/use-displayonscreenkeyboard-properly/51143/2
function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
    -- TextEntry		-->	The Text above the typing field in the black square
    -- ExampleText		-->	An Example Text, what it should say in the typing field
    -- MaxStringLenght	-->	Maximum String Lenght

    AddTextEntry('FMMC_KEY_TIP1', TextEntry)                                                  --Sets the Text above the typing field in the black square
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
    blockinput = true                                                                         --Blocks new input while typing if **blockinput** is used

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do                  --While typing is not aborted and not finished, this loop waits
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(500)                          --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false                         --This unblocks new Input when typing is done
        return result                              --Returns the result
    else
        Citizen.Wait(500)                          --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false                         --This unblocks new Input when typing is done
        return nil                                 --Returns nil if the typing got aborted
    end
end
