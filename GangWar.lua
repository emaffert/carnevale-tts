-- Carnevale TTS Module - Gang War Scenario Controller
-- Place this token on the table alongside the Game Manager.
-- Gang War: 2-4 players, 150 Ducats, 3x3 board, 5 rounds.

local VP = {}   -- { [playerColor] = total }

function onLoad()
    self.setName("Gang War — Scenario")
    self.setDescription(
        "5 Rounds  |  150 Ducats  |  3×3 board\n" ..
        "Primary: 1 VP per surviving character at game end.\n" ..
        "Agendas: 3 agendas × 1 VP each (Double rule).\n" ..
        "Special: each player sets up 1 Gondola in water."
    )
    createButtons()
end

function createButtons()
    self.clearButtons()

    local defs = {
        { label = "Setup Scenario",   fn = "btn_setup",      x = 0, z = -2.7 },
        { label = "Print Rules",      fn = "btn_rules",      x = 0, z = -1.8 },
        { label = "+1 VP (Green)",    fn = "btn_vpGreen",    x = 0, z = -0.9 },
        { label = "+1 VP (Red)",      fn = "btn_vpRed",      x = 0, z =  0   },
        { label = "+1 VP (Blue)",     fn = "btn_vpBlue",     x = 0, z =  0.9 },
        { label = "+1 VP (Yellow)",   fn = "btn_vpYellow",   x = 0, z =  1.8 },
        { label = "End Game / Tally", fn = "btn_endGame",    x = 0, z =  2.7 },
    }

    for _, def in ipairs(defs) do
        self.createButton({
            click_function = def.fn,
            function_owner = self,
            label          = def.label,
            position       = { def.x, 0.15, def.z },
            rotation       = { 0, 0, 0 },
            width          = 800,
            height         = 200,
            font_size      = 75,
            color          = { 0.1, 0.1, 0.1 },
            font_color     = { 1, 0.9, 0.6 },
        })
    end
end

function btn_setup(obj, playerColor, alt)
    Global.call("g_setupScenario", {
        name       = "Gang War",
        roundLimit = 5,
    })

    -- Configure the Agenda Deck for Gang War rules
    local deck = findAgendaDeck()
    if deck then
        deck.call("setRules", {
            agendaCount = 3,
            doubleRule  = true,
            secretRule  = false,
            cycleRule   = false,
        })
    else
        printToAll("Agenda Deck token not found on table — configure it manually.", {1, 0.5, 0.5})
    end

    printSetupInstructions()
end

function findAgendaDeck()
    for _, obj in ipairs(getAllObjects()) do
        if obj.getName() == "Carnevale — Agenda Deck" then return obj end
    end
    return nil
end

function btn_rules(obj, playerColor, alt)
    printSetupInstructions()
end

function btn_vpGreen(obj, playerColor, alt)
    awardAgendaVP("Green")
end

function btn_vpRed(obj, playerColor, alt)
    awardAgendaVP("Red")
end

function btn_vpBlue(obj, playerColor, alt)
    awardAgendaVP("Blue")
end

function btn_vpYellow(obj, playerColor, alt)
    awardAgendaVP("Yellow")
end

function btn_endGame(obj, playerColor, alt)
    Global.call("g_endGame", {})
end

-- ============================================================
-- AGENDA TRACKING (Double rule)
-- Each agenda scores 1 VP; with Double rule, scoring it a second
-- time scores 2 VP. Players manually press VP buttons when achieved.
-- ============================================================

local agendaCount = {}  -- { [playerColor] = times scored }

function awardAgendaVP(color)
    agendaCount[color] = (agendaCount[color] or 0) + 1
    local times = agendaCount[color]

    -- Double rule: second scoring of the same agenda scores 2 VP
    -- (this button represents scoring one agenda; full Double logic
    --  requires players to track which specific agenda was scored)
    local vp = 1
    -- Note: Double means if you achieve the same agenda again it scores 2 VP.
    -- Here we award 1 VP per press; players use two presses for a doubled agenda.

    Global.call("g_addVP", {
        playerColor = color,
        amount      = vp,
        reason      = "Agenda",
    })

    printToAll(
        color .. " achieves an Agenda! (" .. times .. " total agenda score(s) this game)",
        {1, 0.84, 0}
    )
end

-- ============================================================
-- SETUP INSTRUCTIONS
-- ============================================================

function printSetupInstructions()
    local lines = {
        "══════════════ GANG WAR ══════════════",
        "Players : 2-4  |  Ducats : 150 each  |  Board : 3×3 (36\"×36\")",
        "Duration: 5 Rounds",
        "",
        "SETUP ORDER:",
        "1. Choose gangs (150 Ducats, same Faction keyword, 1 Leader required).",
        "2. Place terrain alternately — aim for 1/3 water, 1/3 ground, 1/3 buildings.",
        "   Special Rule: each player sets up 1 Gondola anywhere on the board in water.",
        "3. Place Objectives (none in Gang War — survival is the objective).",
        "4. Draw Agendas — 3 per player (Double rule applies).",
        "5. Roll for Deployment Zones (d6, highest picks first).",
        "   Deployment Zone: within 8\" of your board edge, no higher or lower than 3\" above/below ground.",
        "   Characters may not deploy in water unless specified.",
        "6. Roll for Initiative — press New Round on the Game Manager.",
        "",
        "PRIMARY OBJECTIVE:",
        "Each friendly character alive on the board at game end → 1 Victory Point.",
        "",
        "AGENDAS (Double rule):",
        "3 agendas, each worth 1 VP. If you achieve the same agenda a second time → 2 VP.",
        "Use the +1 VP buttons on this token when you achieve an agenda.",
        "",
        "VICTORY: most total VP after Round 5 wins.",
        "══════════════════════════════════════",
    }
    printToAll(table.concat(lines, "\n"), {1, 0.95, 0.7})
end
