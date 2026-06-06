-- Carnevale TTS Module - Agenda Deck
-- Implements the two-dice draw system from the Agendas card deck.
-- First die selects the table (1-3 / 4-6 / 7-9 / 10).
-- Second die selects the agenda within that table.
-- Supports Double rule, Secret rule, and Cycle rule (per scenario).

-- ============================================================
-- AGENDA DATA
-- ============================================================

local TABLES = {
    {
        firstRoll = { 1, 3 },
        agendas = {
            [1]  = { name = "Heroic Duel",           desc = "Kill an enemy character with the Leader keyword with a friendly character with the Leader keyword." },
            [2]  = { name = "Hostile Takeover",       desc = "Kill an enemy character with the Leader keyword with a friendly character with the Hero keyword." },
            [3]  = { name = "Ideas Above Your Station", desc = "Kill an enemy character with either the Leader or Hero keywords with a friendly character with the Henchman keyword." },
            [4]  = { name = "Inspiring Leadership",   desc = "Have a friendly character with the Leader keyword in base contact with 2 or more enemy characters at the same time." },
            [5]  = { name = "Decoy",                  desc = "Have a friendly character with either the Hero or Henchman keywords in base contact with 3 or more enemy characters at the same time." },
            [6]  = { name = "Bully",                  desc = "Grapple an enemy character into base contact with a friendly character." },
            [7]  = { name = "One-Person Army",        desc = "Kill 3 enemy characters with a friendly character with the Leader keyword." },
            [8]  = { name = "Cut Them Down",          desc = "Kill 3 enemy characters with any number of friendly characters with the Hero keyword." },
            [9]  = { name = "Blood Frenzy",           desc = "Kill 3 enemy characters with any number of friendly characters with the Henchman keyword." },
            [10] = { name = "The Gods Guide Us",      desc = "Use all of the Will Points of at least 3 friendly characters that start the game with Will Points." },
        },
    },
    {
        firstRoll = { 4, 6 },
        agendas = {
            [1]  = { name = "Will be Done",           desc = "Use 6 Will Points in a single round." },
            [2]  = { name = "Lead From the Front",    desc = "Use all of the Command Points of at least 2 friendly characters that start the game with Command Points." },
            [3]  = { name = "Following Orders",       desc = "Use 2 Command Abilities in a single round." },
            [4]  = { name = "Scouting the Land",      desc = "Have 3 friendly characters at least 6\" above ground level on any point of the board outside of your deployment zone." },
            [5]  = { name = "Approach by Water",      desc = "Have 3 friendly characters without the Water Creature special rule in water outside of your deployment zone." },
            [6]  = { name = "Acrobatic Display",      desc = "Make 3 successful Jump actions that move at least 4\" in a single character's turn." },
            [7]  = { name = "Watery Grave",           desc = "Kill an enemy character with a Drown action." },
            [8]  = { name = "Let the Tide Take Them", desc = "Perform a Drown action on 3 different enemy characters." },
            [9]  = { name = "Death From Above",       desc = "Make 2 charges from above with 1 friendly character." },
            [10] = { name = "Draw Them In",           desc = "Disengage 2 times with 1 friendly character." },
        },
    },
    {
        firstRoll = { 7, 9 },
        agendas = {
            [1]  = { name = "No Mercy",               desc = "Cause at least 8 points of Damage to an enemy character during a single character's turn." },
            [2]  = { name = "Venetian Sniper",        desc = "Kill an enemy character with a Combat action from at least 6\" away." },
            [3]  = { name = "Get Them Wet",           desc = "Grapple 2 enemy characters into a canal." },
            [4]  = { name = "Unholy Power",           desc = "Successfully make 3 Cast Spell actions in a single turn." },
            [5]  = { name = "Hold Ground",            desc = "Make Guard actions with 3 friendly characters in 1 round." },
            [6]  = { name = "Silence the Witch",      desc = "Attempt to Dispel 3 enemy Magic Spells." },
            [7]  = { name = "Follow Your Fate",       desc = "Re-roll 6 dice in 1 round." },
            [8]  = { name = "Over the Rooftops",      desc = "Make 4 successful Jump actions that move at least 4\" with any number of characters in 1 round." },
            [9]  = { name = "Keep the Monsters at Bay", desc = "Kill an enemy character with a larger base size." },
            [10] = { name = "Don't Let Them Hide",    desc = "Kill an enemy character while they are in Cover." },
        },
    },
    {
        firstRoll = { 10, 10 },
        agendas = {
            [1]  = { name = "Get to Ground",          desc = "Perform 3 controlled landings with any number of characters in 1 round." },
            [2]  = { name = "Daredevil",              desc = "Have a friendly character survive a fall of at least 6\"." },
            [3]  = { name = "High Dive",              desc = "Fall into water 3 times. This can be done with any number of characters." },
            [4]  = { name = "Aquatic Attack",         desc = "Perform 3 Dive actions with any number of characters in 1 round." },
            [5]  = { name = "Hold Your Breath",       desc = "Have a friendly character perform 2 Dive actions in 2 subsequent rounds." },
        },
    },
}

-- ============================================================
-- SCENARIO RULES (set via setRules() before drawing)
-- ============================================================

local Rules = {
    agendaCount = 3,      -- how many agendas each player draws (Gang War = 3)
    doubleRule  = false,  -- achieving again scores 2VP instead of 1
    secretRule  = false,  -- agendas are hidden from opponents
    cycleRule   = false,  -- draw a new agenda immediately after scoring
}

-- ============================================================
-- STATE
-- ============================================================

-- { [playerColor] = { {name, desc, timesAchieved, heldForDouble} } }
local Hands = {}

-- ============================================================
-- DRAW LOGIC
-- ============================================================

local function rollD10() return math.random(1, 10) end

local function findTable(firstRoll)
    for _, t in ipairs(TABLES) do
        if firstRoll >= t.firstRoll[1] and firstRoll <= t.firstRoll[2] then
            return t
        end
    end
end

local function tableSize(t)
    local n = 0
    for _ in pairs(t.agendas) do n = n + 1 end
    return n
end

-- Returns a drawn agenda table or nil if we exhausted re-rolls.
local function drawOne(playerColor, attempts)
    attempts = attempts or 0
    if attempts > 20 then return nil end  -- safety valve

    local firstRoll  = rollD10()
    local tbl        = findTable(firstRoll)
    local size       = tableSize(tbl)
    local secondRoll = rollD10()

    -- Re-roll second die if it exceeds the table size (only relevant for table 10 which has 5 entries)
    if secondRoll > size then
        return drawOne(playerColor, attempts + 1)
    end

    local agenda = tbl.agendas[secondRoll]

    -- Check for duplicates in this player's hand
    local hand = Hands[playerColor] or {}
    for _, held in ipairs(hand) do
        if held.name == agenda.name then
            return drawOne(playerColor, attempts + 1)
        end
    end

    return { name = agenda.name, desc = agenda.desc, timesAchieved = 0, heldForDouble = false }
end

-- ============================================================
-- PUBLIC FUNCTIONS
-- ============================================================

function setRules(params)
    Rules.agendaCount = params.agendaCount or Rules.agendaCount
    Rules.doubleRule  = params.doubleRule  ~= nil and params.doubleRule  or Rules.doubleRule
    Rules.secretRule  = params.secretRule  ~= nil and params.secretRule  or Rules.secretRule
    Rules.cycleRule   = params.cycleRule   ~= nil and params.cycleRule   or Rules.cycleRule
    printToAll(
        "Agenda rules set: " .. Rules.agendaCount .. " agendas per player" ..
        (Rules.doubleRule  and " | Double"  or "") ..
        (Rules.secretRule  and " | Secret"  or "") ..
        (Rules.cycleRule   and " | Cycle"   or ""),
        {1, 0.84, 0}
    )
end

function drawAgenda(playerColor)
    if not Hands[playerColor] then Hands[playerColor] = {} end
    local hand = Hands[playerColor]

    if #hand >= Rules.agendaCount then
        printToColor(
            "You already have " .. #hand .. " agenda(s). Use Discard & Redraw if one is impossible.",
            playerColor, {1, 0.5, 0.5}
        )
        return
    end

    local drawn = drawOne(playerColor)
    if not drawn then
        printToColor("Could not draw a unique agenda after many attempts. All agendas may be drawn.", playerColor, {1,0.5,0.5})
        return
    end

    table.insert(hand, drawn)
    local slot = #hand

    -- Show to drawing player always; show to all if not Secret rule
    local msg = "Agenda " .. slot .. ": " .. drawn.name .. "\n  " .. drawn.desc
    printToColor("🎴 " .. msg, playerColor, {1, 0.9, 0.6})
    if not Rules.secretRule then
        printToAll(playerColor .. " draws Agenda " .. slot .. ": " .. drawn.name, {0.8, 0.8, 0.8})
    else
        printToAll(playerColor .. " draws a secret Agenda.", {0.8, 0.8, 0.8})
    end
end

function showHand(playerColor)
    local hand = Hands[playerColor]
    if not hand or #hand == 0 then
        printToColor("You have no agendas. Draw some first.", playerColor, {0.8, 0.8, 0.8})
        return
    end

    local lines = { "══ Your Agendas (" .. playerColor .. ") ══" }
    for i, a in ipairs(hand) do
        local status
        if a.heldForDouble and a.timesAchieved >= 1 then
            status = " [HELD — score again for 2VP]"
        elseif a.timesAchieved >= 1 then
            status = " [SCORED]"
        else
            status = ""
        end
        table.insert(lines, i .. ". " .. a.name .. status)
        table.insert(lines, "   " .. a.desc)
    end
    printToColor(table.concat(lines, "\n"), playerColor, {1, 0.9, 0.6})
end

-- Score agenda at slot (1-based) for a player.
-- If doubleRule and player chose to hold: first achieve = hold, second = 2VP.
function scoreAgenda(playerColor, slot, holdForDouble)
    local hand = Hands[playerColor]
    if not hand or not hand[slot] then
        printToColor("No agenda in slot " .. slot .. ".", playerColor, {1, 0.5, 0.5})
        return
    end

    local a = hand[slot]

    if Rules.doubleRule and holdForDouble and a.timesAchieved == 0 then
        -- Player chooses to hold rather than score now
        a.heldForDouble = true
        a.timesAchieved = 1
        printToAll(playerColor .. " achieves "" .. a.name .. "" and holds it for Double!", {1, 0.84, 0})
        return
    end

    local vp
    if Rules.doubleRule and a.heldForDouble and a.timesAchieved >= 1 then
        vp = 2  -- Double: achieved again after holding
    else
        vp = 1
    end

    a.timesAchieved = a.timesAchieved + 1
    a.heldForDouble = false

    Global.call("g_addVP", { playerColor = playerColor, amount = vp, reason = a.name })

    if Rules.cycleRule then
        -- Immediately draw a replacement agenda
        printToAll(playerColor .. " scores "" .. a.name .. "" — drawing a new agenda (Cycle rule).", {1, 0.84, 0})
        table.remove(hand, slot)
        drawAgenda(playerColor)
    else
        printToAll(playerColor .. " scores "" .. a.name .. "" for " .. vp .. " VP!", {1, 0.84, 0})
    end
end

-- Discard agenda at slot and draw a replacement (for impossible agendas).
function discardAndRedraw(playerColor, slot)
    local hand = Hands[playerColor]
    if not hand or not hand[slot] then
        printToColor("No agenda in slot " .. slot .. ".", playerColor, {1, 0.5, 0.5})
        return
    end
    local discarded = hand[slot].name
    table.remove(hand, slot)
    printToAll(playerColor .. " discards "" .. discarded .. "" (impossible) and redraws.", {0.8, 0.8, 0.8})
    drawAgenda(playerColor)
end

function resetDeck()
    Hands = {}
    printToAll("Agenda deck reset. All hands cleared.", {0.8, 0.8, 0.8})
end

-- ============================================================
-- BUTTONS
-- ============================================================

function onLoad()
    self.setName("Carnevale — Agenda Deck")
    self.setDescription("Two-dice agenda draw system. 35 agendas across 4 tables.")
    createButtons()
end

function createButtons()
    self.clearButtons()

    local defs = {
        { label = "Draw Agenda",      fn = "btn_draw",         z = -3.15 },
        { label = "My Agendas",       fn = "btn_show",         z = -2.25 },
        { label = "Score Agenda 1",   fn = "btn_score1",       z = -1.35 },
        { label = "Score Agenda 2",   fn = "btn_score2",       z = -0.45 },
        { label = "Score Agenda 3",   fn = "btn_score3",       z =  0.45 },
        { label = "Hold for Double 1",fn = "btn_hold1",        z =  1.35 },
        { label = "Hold for Double 2",fn = "btn_hold2",        z =  2.25 },
        { label = "Hold for Double 3",fn = "btn_hold3",        z =  3.15 },
        { label = "Discard & Redraw", fn = "btn_discard",      z =  4.05 },
        { label = "Reset Deck",       fn = "btn_reset",        z =  4.95 },
    }

    for _, d in ipairs(defs) do
        self.createButton({
            click_function = d.fn,
            function_owner = self,
            label          = d.label,
            position       = { 0, 0.15, d.z },
            rotation       = { 0, 0, 0 },
            width          = 900,
            height         = 180,
            font_size      = 70,
            color          = { 0.1, 0.1, 0.1 },
            font_color     = { 1, 0.9, 0.6 },
        })
    end
end

function btn_draw(obj, color, alt)    drawAgenda(color)          end
function btn_show(obj, color, alt)    showHand(color)            end
function btn_score1(obj, color, alt)  scoreAgenda(color, 1, false) end
function btn_score2(obj, color, alt)  scoreAgenda(color, 2, false) end
function btn_score3(obj, color, alt)  scoreAgenda(color, 3, false) end
function btn_hold1(obj, color, alt)   scoreAgenda(color, 1, true)  end
function btn_hold2(obj, color, alt)   scoreAgenda(color, 2, true)  end
function btn_hold3(obj, color, alt)   scoreAgenda(color, 3, true)  end
function btn_reset(obj, color, alt)   resetDeck()                end

-- Discard slot 1 by default; for other slots players use the scripting console or a future UI
function btn_discard(obj, color, alt)
    -- Show current hand first so the player knows which slot to target
    showHand(color)
    printToColor(
        "To discard a specific slot, use the TTS scripting console:\n" ..
        "  AgendaDeck.call('discardAndRedraw', {'" .. color .. "', 1})\n" ..
        "(replace 1 with the slot number shown above)",
        color,
        {0.8, 0.8, 1}
    )
end
