RegisterCommand("playsfx", function()
    local squelchStartSound = "Start_Squelch"
    local squelchEndSound = "End_Squelch"
    local cbRadioFxSound = "CB_RADIO_SFX"
    local backgroundLoopSound = "Background_Loop"


    local errorSound = "ERROR"
    local hudDefaultSound = "HUD_FRONTEND_DEFAULT_SOUNDSET"

    local testSound = "cannon_charge_fire_loop"
    local testSfx = "dlc_xm_orbital_cannon_sounds"

    -- Search for princess robot bubblegum

    local cbSoundEffectEnabled = false
    local errorSoundEnabled = false



    if cbSoundEffectEnabled then
        notify("Test SFX playing.")
        PlaySoundFrontend(-1, squelchStartSound, cbRadioFxSound)
        Wait(1000)
        PlaySoundFrontend(-1, squelchEndSound, cbRadioFxSound)
    -- elseif c then
    -- Play the test sound
    elseif errorSoundEnabled then
        PlaySoundFrontend(-1, errorSound, hudDefaultSound)
    else
        local soundId = -1
        if soundId == -1 then
            soundId = GetSoundId()
        end
        PlaySoundFrontend(soundId, testSound, testSfx)
    end
end, false)