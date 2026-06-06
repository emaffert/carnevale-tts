-- Carnevale TTS Module - Game Manager Token
-- Place one of these on the table. It hosts the control buttons.
-- Right-click the token or use its buttons to control the game.

-- ============================================================
-- RULEBOOK
-- For local/LAN play use a file:/// path.
-- For online play replace with a direct URL to the hosted PDF.
-- ============================================================
local RULEBOOK_URL = "file:///home/eldrim/Downloads/Carnevale_after_party_rulebook_smaller_size.pdf"

local rulebookGUID = nil  -- tracks the spawned rulebook object so we don't duplicate it

function onLoad()
    self.setName("Carnevale — Game Manager")
    self.setDescription("Round tracker and game controls.")
    createButtons()
end

function createButtons()
    self.clearButtons()

    local btnDefs = {
        { label = "Start Game",    fn = "btn_startGame",    x = 0,    z = -2.25 },
        { label = "New Round",     fn = "btn_newRound",     x = 0,    z = -1.35 },
        { label = "Start Turns",   fn = "btn_startTurns",   x = 0,    z = -0.45 },
        { label = "End Round",     fn = "btn_endRound",     x = 0,    z =  0.45 },
        { label = "Fortune →",     fn = "btn_fortune",      x = 0,    z =  1.35 },
        { label = "📖 Rulebook",   fn = "btn_rulebook",     x = 0,    z =  2.25 },
    }

    for _, def in ipairs(btnDefs) do
        self.createButton({
            click_function = def.fn,
            function_owner = self,
            label          = def.label,
            position       = { def.x, 0.15, def.z },
            rotation       = { 0, 0, 0 },
            width          = 700,
            height         = 200,
            font_size      = 80,
            color          = { 0.15, 0.15, 0.15 },
            font_color     = { 1, 0.9, 0.6 },
        })
    end
end

function btn_startGame(obj, playerColor, alt)
    Global.call("startGame", {})
end

function btn_newRound(obj, playerColor, alt)
    Global.call("newRound", {})
end

function btn_startTurns(obj, playerColor, alt)
    Global.call("startActivations", {})
end

function btn_endRound(obj, playerColor, alt)
    Global.call("endRound", {})
end

function btn_fortune(obj, playerColor, alt)
    Global.call("g_awardFortune", { playerColor = playerColor })
end

function btn_rulebook(obj, playerColor, alt)
    -- If already spawned and still on the table, just highlight it
    if rulebookGUID then
        local existing = getObjectFromGUID(rulebookGUID)
        if existing then
            existing.highlightOn({1, 0.9, 0.4}, 3)
            printToColor("Rulebook is already on the table (highlighted).", playerColor, {1, 0.9, 0.4})
            return
        end
    end

    -- Spawn the PDF object near the Game Manager
    local pos = self.getPosition()
    local book = spawnObject({
        type     = "Custom_PDF",
        position = { pos.x + 4, pos.y + 0.5, pos.z },
        rotation = { 0, 0, 0 },
        scale    = { 1.5, 1, 1.5 },
    })

    book.setName("Carnevale Rulebook")
    book.setCustomObject({ pdf = RULEBOOK_URL })
    rulebookGUID = book.getGUID()

    printToColor(
        "Rulebook spawned. Click it to open. " ..
        "(Online players need the PDF hosted at a URL — see RULEBOOK_URL in GameManager.lua)",
        playerColor,
        {1, 0.9, 0.4}
    )
end
