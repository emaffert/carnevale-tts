-- Carnevale TTS Module - Global Script
-- Handles: dice engine, game state, turn management, roll dispatch

-- ============================================================
-- GAME STATE
-- ============================================================

local State = {
    round          = 0,
    phase          = "setup",  -- setup | initiative | activation | end_round
    turnOrder      = {},       -- [{playerColor, guid, name}]
    activeIndex    = 0,
    fortuneHolder  = nil,      -- playerColor
}

-- ============================================================
-- DICE ENGINE
-- ============================================================

-- Roll a pool of D10s with one Destiny Die.
-- aceThreshold: minimum value to score an Ace (default 7).
-- Returns a result table; does NOT broadcast.
function rollPool(numDice, aceThreshold)
    aceThreshold = aceThreshold or 7
    numDice      = math.max(0, math.min(numDice, 10))

    if numDice == 0 then
        return {
            rolls        = {},
            aces         = 0,
            destinyValue = 0,
            outcome      = "Fail",
            summary      = "(no dice)",
        }
    end

    local rolls        = {}
    local destinyIndex = math.random(1, numDice)

    for i = 1, numDice do
        local v    = math.random(1, 10)
        -- 10 always Ace, 1 never Ace, others >= aceThreshold
        local isAce = (v == 10) or (v ~= 1 and v >= aceThreshold)
        rolls[i] = { value = v, isDestiny = (i == destinyIndex), isAce = isAce }
    end

    local aces         = 0
    local destinyValue = 0

    for _, d in ipairs(rolls) do
        if d.isAce    then aces         = aces + 1    end
        if d.isDestiny then destinyValue = d.value     end
    end

    -- Outcome priority: Critical > Fumble > Success > Fail
    local outcome
    if   destinyValue == 10 and aces >= 2 then outcome = "Critical"
    elseif destinyValue == 1  and aces == 0 then outcome = "Fumble"
    elseif aces >= 1                        then outcome = "Success"
    else                                         outcome = "Fail"
    end

    -- Build readable summary
    local parts = {}
    for _, d in ipairs(rolls) do
        local s = tostring(d.value)
        if d.isDestiny then s = "[" .. s .. "]" end  -- brackets = Destiny Die
        if d.isAce     then s = s .. "✓"        end  -- check = Ace
        table.insert(parts, s)
    end

    local summary =
        table.concat(parts, "  ") ..
        "\n  Aces: " .. aces ..
        "  |  Destiny: " .. destinyValue ..
        "  →  " .. outcome

    return {
        rolls        = rolls,
        aces         = aces,
        destinyValue = destinyValue,
        outcome      = outcome,
        summary      = summary,
    }
end

-- Roll and broadcast to table chat. Returns result table.
local OUTCOME_COLOR = {
    Critical = { 1,   0.84, 0   },  -- gold
    Success  = { 0.4, 0.9,  0.4 },  -- green
    Fail     = { 0.8, 0.8,  0.8 },  -- grey
    Fumble   = { 1,   0.2,  0.2 },  -- red
}

function broadcastRoll(label, numDice, aceThreshold, playerColor)
    local result = rollPool(numDice, aceThreshold)
    local color  = OUTCOME_COLOR[result.outcome] or {1,1,1}
    printToAll("[" .. label .. "]\n" .. result.summary, color)
    return result
end

-- ============================================================
-- SPECIFIC ROLL TYPES
-- ============================================================

-- Basic roll (DEX, MIND, etc.) - threshold 7+
-- params: {label, dice, wp, playerColor}
function basicRoll(params)
    local dice  = math.min((params.dice or 0) + (params.wp or 0), 10)
    return broadcastRoll(params.label, dice, 7, params.playerColor)
end

-- Attack roll - threshold = target's DEXTERITY value
-- params: {attackerName, targetName, attackDice, targetDex, modifiers, wp, playerColor}
function attackRoll(params)
    local dice  = math.min(
        (params.attackDice or 0) + (params.modifiers or 0) + (params.wp or 0),
        10
    )
    local label = (params.attackerName or "?") .. " → " .. (params.targetName or "?")
    return broadcastRoll(label .. " [ATK]", dice, params.targetDex or 7, params.playerColor)
end

-- Protection roll - threshold always 7+
-- params: {defenderName, protDice, damage, wp, playerColor}
-- Broadcasts damage result after saves.
function protectionRoll(params)
    local protDice = math.min((params.protDice or 0) + (params.wp or 0), 10)
    local damage   = params.damage or 0
    local label    = (params.defenderName or "?") .. " [PROT] vs " .. damage .. " damage"
    local result   = broadcastRoll(label, protDice, 7, params.playerColor)

    local saved = 0
    if result.outcome == "Critical" then
        -- Critical on protection: +1 extra Ace already in count; each Ace reduces damage by 1
        saved  = result.aces
        damage = math.max(0, damage - saved)
    elseif result.outcome == "Success" then
        saved  = result.aces
        damage = math.max(0, damage - saved)
    elseif result.outcome == "Fumble" then
        damage = damage + 1  -- Fumble increases damage by 1
    end
    -- Fail: no effect on damage

    local color = damage == 0 and {0.4,0.9,0.4} or {1,0.5,0.2}
    printToAll(
        (params.defenderName or "?") ..
        " saves " .. saved .. " → takes " .. damage .. " Life Point(s).",
        color
    )
    return { result = result, finalDamage = damage }
end

-- Magic roll - threshold = spell's Difficulty value
-- params: {casterName, spellName, mindDice, difficulty, wp, playerColor}
function magicRoll(params)
    local dice  = math.min((params.mindDice or 0) + (params.wp or 0), 10)
    local label = (params.casterName or "?") .. " casts " .. (params.spellName or "?")
    return broadcastRoll(label .. " [MAGIC]", dice, params.difficulty or 7, params.playerColor)
end

-- Opposed roll helper (e.g. Grapple, Disengage)
-- Step 1: defender rolls (no Critical/Fumble for defender)
-- Step 2: defender's aces remove dice from attacker's pool
-- Step 3: attacker rolls reduced pool as a Basic roll
-- params: {activeName, activeGuid, activeDice, defenderName, defenderDice, aceThreshold, wp, playerColor}
function opposedRoll(params)
    local threshold = params.aceThreshold or 7

    -- Defender rolls first (no Criticals/Fumbles)
    local defDice   = math.max(0, params.defenderDice or 0)
    local defResult = rollPool(defDice, threshold)

    -- Strip Criticals/Fumbles from defender (defender cannot score those)
    local defOutcome = defResult.outcome
    if defOutcome == "Critical" then defOutcome = "Success" end
    if defOutcome == "Fumble"   then defOutcome = "Fail"    end

    printToAll(
        "[Opposed] " .. (params.defenderName or "?") .. " defends: " .. defResult.summary ..
        "\n  Defender Aces: " .. defResult.aces,
        {0.8, 0.8, 1}
    )

    -- Attacker's pool reduced by defender's aces
    local activeDice = math.max(0, (params.activeDice or 0) + (params.wp or 0) - defResult.aces)
    local label      = (params.activeName or "?") .. " [Opposed, " .. activeDice .. " dice]"
    local actResult  = broadcastRoll(label, activeDice, threshold, params.playerColor)

    return { defenderResult = defResult, activeResult = actResult }
end

-- ============================================================
-- TURN MANAGEMENT
-- ============================================================

function startGame()
    State.round       = 0
    State.phase       = "setup"
    State.turnOrder   = {}
    State.activeIndex = 0
    State.fortuneHolder = nil
    printToAll("=== Carnevale - Game Start ===", {1, 0.84, 0})
    printToAll("Place characters, set terrain, then call New Round.", {1,1,1})
end

function newRound()
    State.round       = State.round + 1
    State.phase       = "initiative"
    State.activeIndex = 0
    printToAll("══════════════════════════════", {0.5, 0.5, 0.5})
    printToAll("  Round " .. State.round .. " begins  —  Roll for Initiative", {1, 0.84, 0})
    printToAll("══════════════════════════════", {0.5, 0.5, 0.5})
    printToAll("Each player: pick a character, spend CP, roll dice. 7+ = Ace. Most Aces goes first.", {1,1,1})

    -- Reset all character tokens for the new round
    for _, obj in ipairs(getAllObjects()) do
        if obj.hasTag("carnevale_character") then
            obj.call("onRoundStart", {})
        end
    end
end

-- Register a character in the turn order.
-- Called by each character token after initiative is determined.
-- params: {guid, name, playerColor, initiative}
function registerInitiative(params)
    table.insert(State.turnOrder, {
        guid        = params.guid,
        name        = params.name,
        playerColor = params.playerColor,
        initiative  = params.initiative or 0,
    })
    -- Sort descending by initiative aces
    table.sort(State.turnOrder, function(a, b) return a.initiative > b.initiative end)
end

function startActivations()
    State.phase       = "activation"
    State.activeIndex = 1

    if #State.turnOrder == 0 then
        printToAll("No characters registered. Add characters and roll initiative first.", {1,0.3,0.3})
        return
    end

    printToAll("--- Activations begin ---", {1, 0.84, 0})
    announceActive()
end

function announceActive()
    if State.activeIndex > #State.turnOrder then
        endRound()
        return
    end
    local entry = State.turnOrder[State.activeIndex]
    printToAll(
        "  ▶ " .. entry.name .. " (" .. entry.playerColor .. ") — your turn!",
        {0.6, 0.9, 1}
    )
    -- Highlight the active token
    local obj = getObjectFromGUID(entry.guid)
    if obj then
        obj.highlightOn({0.2, 0.8, 1}, 30)
    end
end

function endActivation(playerColor)
    -- Turn off highlight on current
    if State.activeIndex <= #State.turnOrder then
        local entry = State.turnOrder[State.activeIndex]
        local obj   = getObjectFromGUID(entry.guid)
        if obj then obj.highlightOff() end
    end

    State.activeIndex = State.activeIndex + 1
    if State.activeIndex > #State.turnOrder then
        endRound()
    else
        announceActive()
    end
end

function endRound()
    State.phase = "end_round"
    printToAll("--- End of Round " .. State.round .. " — check victory conditions ---", {0.7, 0.7, 0.7})
    State.turnOrder = {}  -- clear for next round
end

-- ============================================================
-- FORTUNE'S FAVOUR
-- ============================================================

function awardFortune(playerColor)
    State.fortuneHolder = playerColor
    printToAll("Fortune's Favour → " .. playerColor, {1, 0.84, 0})
    printToAll("The character that earns it replenishes 1 WP (or 2 WP if you tell its story).", {1,1,1})
end

-- ============================================================
-- WILL POINT SPEND VALIDATION
-- ============================================================

-- Returns valid WP spend (0-2) and clamps to available WP.
-- wpWanted: how many WP the player wants to spend
-- wpAvailable: character's current WP
function clampWP(wpWanted, wpAvailable)
    return math.max(0, math.min(wpWanted, math.min(2, wpAvailable)))
end

-- ============================================================
-- GLOBAL CALLABLE INTERFACE (called from token scripts)
-- ============================================================

-- Tokens call Global.call("g_attackRoll", params) etc.
function g_attackRoll(params)    return attackRoll(params)    end
function g_protectionRoll(params) return protectionRoll(params) end
function g_basicRoll(params)     return basicRoll(params)     end
function g_magicRoll(params)     return magicRoll(params)     end
function g_opposedRoll(params)   return opposedRoll(params)   end
function g_endActivation(params) endActivation(params and params.playerColor) end
function g_registerInitiative(params) registerInitiative(params) end
function g_awardFortune(params)  awardFortune(params.playerColor) end

-- ============================================================
-- SCENARIO
-- ============================================================

local Scenario = {
    name        = nil,
    roundLimit  = 0,
    vp          = {},   -- { [playerColor] = vpTotal }
    agendaVP    = {},   -- { [playerColor] = vpFromAgendas }
    active      = false,
}

function setupScenario(params)
    Scenario.name       = params.name
    Scenario.roundLimit = params.roundLimit or 0
    Scenario.vp         = {}
    Scenario.agendaVP   = {}
    Scenario.active     = true
    for _, color in ipairs(Player.getColors()) do
        local p = Player[color]
        if p and p.seated then
            Scenario.vp[color]       = 0
            Scenario.agendaVP[color] = 0
        end
    end
    State.round = 0
    printToAll("Scenario: " .. Scenario.name, {1, 0.84, 0})
    printToAll("Round limit: " .. Scenario.roundLimit, {1, 1, 1})
end

-- Add Victory Points for agendas or other manual sources.
function addVP(playerColor, amount, reason)
    Scenario.vp[playerColor]      = (Scenario.vp[playerColor]      or 0) + amount
    Scenario.agendaVP[playerColor] = (Scenario.agendaVP[playerColor] or 0) + amount
    printToAll(
        playerColor .. " gains " .. amount .. " VP" ..
        (reason and (" [" .. reason .. "]") or "") ..
        " → total " .. Scenario.vp[playerColor],
        {1, 0.84, 0}
    )
end

-- Called at end of game: count surviving characters (1 VP each) and tally.
function endGame()
    if not Scenario.active then
        printToAll("No active scenario.", {1, 0.5, 0.5})
        return
    end

    printToAll("══ End of Game — Counting Victory Points ══", {1, 0.84, 0})

    -- Count surviving characters per player
    local survivors = {}
    for _, obj in ipairs(getAllObjects()) do
        if obj.hasTag("carnevale_character") then
            local info = obj.call("getInfo", {})
            if info and info.lp > 0 then
                local color = info.playerColor or "White"
                survivors[color] = (survivors[color] or 0) + 1
            end
        end
    end

    -- Primary Objective VP
    for color, count in pairs(survivors) do
        Scenario.vp[color] = (Scenario.vp[color] or 0) + count
        printToAll(
            color .. ": " .. count .. " surviving character(s) → +" .. count .. " VP",
            {0.4, 0.9, 0.4}
        )
    end

    -- Final totals
    printToAll("── Final Totals ──", {1, 1, 1})
    local results = {}
    for color, total in pairs(Scenario.vp) do
        table.insert(results, { color = color, vp = total })
    end
    table.sort(results, function(a, b) return a.vp > b.vp end)

    for rank, entry in ipairs(results) do
        local line = rank .. ". " .. entry.color .. ": " .. entry.vp .. " VP"
        if rank == 1 then line = "🏆 " .. line end
        printToAll(line, {1, 0.9, 0.6})
    end

    Scenario.active = false
end

-- Override newRound to enforce round limit
local _newRound = newRound
newRound = function()
    _newRound()
    if Scenario.active and Scenario.roundLimit > 0 and State.round >= Scenario.roundLimit then
        printToAll(
            "Round " .. State.round .. " is the final round of " .. (Scenario.name or "the scenario") .. "!",
            {1, 0.5, 0.2}
        )
    end
end

-- Global callable wrappers
function g_addVP(params)      addVP(params.playerColor, params.amount, params.reason) end
function g_endGame(params)    endGame() end
function g_setupScenario(p)   setupScenario(p) end

-- ============================================================
-- LOAD
-- ============================================================

function onLoad()
    printToAll("Carnevale module loaded. Use the Game Manager token to start.", {1, 0.84, 0})
end
