-- Carnevale TTS Module - Character Token Script
-- Each character on the board gets this script with their profile filled in.
-- State is persisted across saves via onSave/onLoad.

-- ============================================================
-- CHARACTER PROFILE
-- Edit these values per character before placing on the board.
-- ============================================================

local PROFILE = {
    -- Identity
    name        = "Character Name",
    playerColor = "White",   -- TTS player color who owns this character
    faction     = "Faction",
    keywords = {},           -- e.g. {"Leader", "Trade"}
    size     = 30,           -- base diameter in mm
    cost     = 0,            -- Ducats

    -- Statistics (static, never change during play)
    move       = 6,
    dexterity  = 6,
    attack     = 4,
    protection = 2,
    mind       = 4,

    -- Starting Points (also the max)
    ap_max = 3,
    lp_max = 8,
    wp_max = 2,
    cp_max = 0,

    -- Weapons: {name, range, evasion, damage, penetration, abilities}
    weapons = {
        { name = "Unarmed", range = 0, evasion = nil, damage = nil, penetration = 1, abilities = {} },
    },

    -- Character Abilities (strings for reference; full logic is manual or per-ability)
    abilities = {},
}

-- ============================================================
-- MUTABLE STATE (saved between sessions)
-- ============================================================

local State = {
    ap = PROFILE.ap_max,
    lp = PROFILE.lp_max,
    wp = PROFILE.wp_max,
    cp = PROFILE.cp_max,

    -- Status counters
    stunned    = false,
    hidden     = false,
    guard      = false,
    underwater = 0,    -- number of Underwater Counters (each gives +2 PROT)

    -- Activation tracking
    activated      = false,  -- has had a turn this round
    ap_used        = 0,      -- AP spent this turn
}

-- ============================================================
-- PERSISTENCE
-- ============================================================

function onSave()
    return JSON.encode(State)
end

function onLoad(saved_data)
    if saved_data and saved_data ~= "" then
        local loaded = JSON.decode(saved_data)
        if loaded then
            -- Merge saved state (keeps PROFILE values if not in save)
            for k, v in pairs(loaded) do State[k] = v end
        end
    end
    setupContextMenu()
    updateDisplay()
end

-- ============================================================
-- DISPLAY
-- ============================================================

function updateDisplay()
    local statusParts = {}
    if State.stunned              then table.insert(statusParts, "STUNNED")                            end
    if State.hidden               then table.insert(statusParts, "HIDDEN")                             end
    if State.guard                then table.insert(statusParts, "GUARD")                              end
    if State.underwater > 0       then table.insert(statusParts, "UNDERWATER×" .. State.underwater)    end
    if State.activated            then table.insert(statusParts, "activated")                          end

    local statusLine = #statusParts > 0 and ("\n[" .. table.concat(statusParts, " | ") .. "]") or ""

    local effectiveProt = PROFILE.protection + (State.underwater * 2)
    if State.stunned then
        -- Stunned: -1 to MOVE, ATK, DEX, MIND (min 1)
        effectiveProt = math.max(1, effectiveProt)
    end

    self.setDescription(
        "AP " .. State.ap .. "/" .. PROFILE.ap_max ..
        "  LP " .. State.lp .. "/" .. PROFILE.lp_max ..
        "  WP " .. State.wp .. "/" .. PROFILE.wp_max ..
        (PROFILE.cp_max > 0 and ("  CP " .. State.cp .. "/" .. PROFILE.cp_max) or "") ..
        "\n" ..
        "MOV " .. effectiveMove() ..
        "  DEX " .. effectiveStat(PROFILE.dexterity) ..
        "  ATK " .. effectiveStat(PROFILE.attack) ..
        "  PROT " .. effectiveProt ..
        "  MIND " .. effectiveStat(PROFILE.mind) ..
        statusLine
    )
end

-- Apply Stunned penalty (-1, min 1) to a stat
function effectiveStat(base)
    if State.stunned then return math.max(1, base - 1) end
    return base
end

function effectiveMove()
    local m = State.stunned and math.max(1, PROFILE.move - 1) or PROFILE.move
    -- Swimming penalty (-2") handled at move time, not here
    return m
end

function effectiveProt()
    local p = PROFILE.protection + (State.underwater * 2)
    if State.stunned then p = math.max(1, p - 1) end
    return p
end

-- ============================================================
-- ROUND / TURN HOOKS
-- ============================================================

-- Called by Global at the start of each new round
function onRoundStart()
    State.ap        = PROFILE.ap_max
    State.ap_used   = 0
    State.activated = false
    -- Remove Guard counter (it expires if the character acts)
    -- (Guard persists until the character moves or acts, so we keep it here
    --  and let it be removed when an action is taken)
    updateDisplay()
end

-- Spend AP; returns false if not enough AP available
function spendAP(amount)
    if State.ap < amount then
        printToColor(
            PROFILE.name .. " does not have enough AP (has " .. State.ap .. ", needs " .. amount .. ").",
            self.held_by_color or "White",
            {1, 0.5, 0.5}
        )
        return false
    end
    State.ap      = State.ap - amount
    State.ap_used = State.ap_used + amount

    -- Guard and Hidden counters are lost when the character acts
    if State.guard  then State.guard  = false; printToAll(PROFILE.name .. " loses Guard counter.", {0.8,0.8,0.8}) end
    if State.hidden then State.hidden = false; printToAll(PROFILE.name .. " loses Hidden counter.", {0.8,0.8,0.8}) end

    updateDisplay()
    return true
end

-- ============================================================
-- DAMAGE & HEALING
-- ============================================================

function takeDamage(amount)
    State.lp = math.max(0, State.lp - amount)
    updateDisplay()
    if State.lp == 0 then
        printToAll("☠ " .. PROFILE.name .. " has been eliminated!", {1, 0.2, 0.2})
        self.highlightOn({1, 0, 0}, 5)
    end
end

function healLP(amount)
    State.lp = math.min(PROFILE.lp_max, State.lp + amount)
    updateDisplay()
end

function gainWP(amount)
    State.wp = math.min(PROFILE.wp_max, State.wp + amount)
    updateDisplay()
end

function spendWP(amount)
    amount   = math.min(amount, 2)  -- max 2 per roll
    State.wp = math.max(0, State.wp - amount)
    updateDisplay()
    return amount
end

function spendCP(amount)
    if State.cp < amount then return false end
    State.cp = State.cp - amount
    updateDisplay()
    return true
end

-- ============================================================
-- STATUS COUNTERS
-- ============================================================

function applyStunned()
    if not State.stunned then
        State.stunned = true
        printToAll(PROFILE.name .. " is Stunned! (-1 to MOVE/ATK/DEX/MIND)", {1, 0.6, 0.2})
        updateDisplay()
    end
end

function removeStunned()
    -- Stunned is removed at the END of the character's next turn
    State.stunned = false
    printToAll(PROFILE.name .. " recovers from Stun.", {0.4, 0.9, 0.4})
    updateDisplay()
end

function applyHidden()
    if not spendAP(1) then return end
    State.hidden = true
    printToAll(PROFILE.name .. " Hides. Enemies >6\" away cannot draw LoS.", {0.6, 0.6, 1})
    updateDisplay()
end

function applyGuard()
    if not spendAP(1) then return end
    State.guard = true
    printToAll(PROFILE.name .. " takes Guard. Will interrupt enemy Run/Jump actions in LoS.", {0.6, 1, 0.6})
    updateDisplay()
end

function addUnderwaterCounter()
    State.underwater = State.underwater + 1
    printToAll(
        PROFILE.name .. " gains Underwater Counter (" .. State.underwater .. "x, +" ..
        State.underwater * 2 .. " PROT).",
        {0.4, 0.6, 1}
    )
    updateDisplay()
end

function removeUnderwaterCounters()
    local counters  = State.underwater
    State.underwater = 0
    -- Each counter gives up to 4" of free movement in water
    printToAll(
        PROFILE.name .. " surfaces, removing " .. counters ..
        " Underwater Counter(s). May move up to " .. counters * 4 .. "\" in water.",
        {0.4, 0.6, 1}
    )
    updateDisplay()
end

-- ============================================================
-- ROLL HELPERS (delegate to Global)
-- ============================================================

-- Make a basic DEXTERITY roll (for climbing, jumping, etc.)
function rollDexterity(wpSpent)
    wpSpent = wpSpent or 0
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    Global.call("g_basicRoll", {
        label       = PROFILE.name .. " DEX",
        dice        = effectiveStat(PROFILE.dexterity),
        wp          = wpSpent,
        playerColor = self.held_by_color or "White",
    })
end

-- Make an attack roll. Target DEX must be provided by the player.
-- targetDex defaults to 7 if unknown (caller should supply it)
function rollAttack(targetName, targetDex, weaponModifiers, wpSpent)
    targetDex      = targetDex      or 7
    weaponModifiers = weaponModifiers or 0
    wpSpent        = wpSpent        or 0
    if not spendAP(1)          then return end
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    Global.call("g_attackRoll", {
        attackerName = PROFILE.name,
        targetName   = targetName or "target",
        attackDice   = effectiveStat(PROFILE.attack),
        targetDex    = targetDex,
        modifiers    = weaponModifiers,
        wp           = 0,  -- already consumed above
        playerColor  = self.held_by_color or "White",
    })
end

-- Make a protection roll against incoming damage
function rollProtection(damage, wpSpent)
    wpSpent = wpSpent or 0
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    local result = Global.call("g_protectionRoll", {
        defenderName = PROFILE.name,
        protDice     = effectiveProt(),
        damage       = damage,
        wp           = 0,  -- already consumed above
        playerColor  = self.held_by_color or "White",
    })
    if result then
        takeDamage(result.finalDamage)
    end
end

-- Make a magic roll to cast a spell
function rollMagic(spellName, difficulty, wpSpent)
    wpSpent    = wpSpent    or 0
    difficulty = difficulty or 7
    if not spendAP(1)          then return end
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    Global.call("g_magicRoll", {
        casterName  = PROFILE.name,
        spellName   = spellName or "Spell",
        mindDice    = effectiveStat(PROFILE.mind),
        difficulty  = difficulty,
        wp          = 0,
        playerColor = self.held_by_color or "White",
    })
end

-- Make a DEXTERITY Opposed Roll (e.g. Disengage)
function rollOpposedDex(opponentName, opponentDex, wpSpent)
    wpSpent     = wpSpent     or 0
    opponentDex = opponentDex or 4
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    Global.call("g_opposedRoll", {
        activeName   = PROFILE.name,
        activeDice   = effectiveStat(PROFILE.dexterity) + wpSpent,
        defenderName = opponentName or "opponent",
        defenderDice = opponentDex,
        aceThreshold = 7,
        wp           = 0,
        playerColor  = self.held_by_color or "White",
    })
end

-- Make an ATTACK Opposed Roll (e.g. Grapple)
function rollOpposedAttack(opponentName, opponentAttack, targetDex, wpSpent)
    wpSpent = wpSpent or 0
    if not spendAP(1)          then return end
    if not validateWP(wpSpent) then return end
    spendWP(wpSpent)
    -- Grapple: both roll ATTACK, threshold 7+
    Global.call("g_opposedRoll", {
        activeName   = PROFILE.name,
        activeDice   = effectiveStat(PROFILE.attack),
        defenderName = opponentName or "opponent",
        defenderDice = opponentAttack or 3,
        aceThreshold = 7,
        wp           = 0,
        playerColor  = self.held_by_color or "White",
    })
end

-- ============================================================
-- VALIDATION
-- ============================================================

function validateWP(wpWanted)
    local clamped = math.min(wpWanted, 2)
    if clamped > State.wp then
        printToAll(
            PROFILE.name .. " only has " .. State.wp .. " WP (requested " .. wpWanted .. ").",
            {1, 0.5, 0.5}
        )
        return false
    end
    return true
end

-- ============================================================
-- CONTEXT MENU
-- ============================================================

-- Map TTS player color names to RGB tints for visual ownership indicator.
local PLAYER_TINTS = {
    White  = { 1,    1,    1    },
    Red    = { 0.86, 0.1,  0.1  },
    Blue   = { 0.12, 0.35, 0.86 },
    Green  = { 0.07, 0.6,  0.07 },
    Purple = { 0.5,  0.1,  0.7  },
    Yellow = { 0.9,  0.8,  0.05 },
    Orange = { 0.95, 0.45, 0.0  },
    Pink   = { 0.95, 0.4,  0.7  },
    Teal   = { 0.07, 0.7,  0.6  },
    Brown  = { 0.5,  0.25, 0.1  },
}

function claimToken(playerColor)
    PROFILE.playerColor = playerColor
    local tint = PLAYER_TINTS[playerColor] or { 1, 1, 1 }
    self.setColorTint(tint)
    printToAll(PROFILE.name .. " claimed by " .. playerColor .. ".", tint)
    updateDisplay()
end

function setupContextMenu()
    self.addContextMenuItem("Claim for me",       function(c) claimToken(c) end)
    self.addContextMenuItem("📊 Show Stats",      function(c) showStats(c) end)
    self.addContextMenuItem("End Activation",     function(c) endMyActivation(c) end)
    self.addContextMenuItem("── Points ──",       function() end)
    self.addContextMenuItem("Take 1 Damage",      function(c) takeDamage(1) end)
    self.addContextMenuItem("Heal 1 LP",          function(c) healLP(1) end)
    self.addContextMenuItem("Gain 1 WP",          function(c) gainWP(1) end)
    self.addContextMenuItem("── Actions ──",      function() end)
    self.addContextMenuItem("Action: Hide (1AP)", function(c) applyHidden() end)
    self.addContextMenuItem("Action: Guard (1AP)",function(c) applyGuard() end)
    self.addContextMenuItem("── Status ──",       function() end)
    self.addContextMenuItem("Apply Stunned",      function(c) applyStunned() end)
    self.addContextMenuItem("Remove Stunned",     function(c) removeStunned() end)
    self.addContextMenuItem("Add Underwater ×1",  function(c) addUnderwaterCounter() end)
    self.addContextMenuItem("Remove Underwater",  function(c) removeUnderwaterCounters() end)
    self.addContextMenuItem("── Rolls ──",        function() end)
    self.addContextMenuItem("Roll DEX (0WP)",     function(c) rollDexterity(0) end)
    self.addContextMenuItem("Roll DEX (1WP)",     function(c) rollDexterity(1) end)
    self.addContextMenuItem("Roll DEX (2WP)",     function(c) rollDexterity(2) end)
end

function showStats(playerColor)
    local lines = {
        "═══ " .. PROFILE.name .. " ═══",
        "Faction: " .. PROFILE.faction,
        "Size: " .. PROFILE.size .. "mm  |  Cost: " .. PROFILE.cost .. " Ducats",
        "MOV " .. PROFILE.move ..
        "  DEX " .. PROFILE.dexterity ..
        "  ATK " .. PROFILE.attack ..
        "  PROT " .. PROFILE.protection ..
        "  MIND " .. PROFILE.mind,
        "AP " .. State.ap .. "/" .. PROFILE.ap_max ..
        "  LP " .. State.lp .. "/" .. PROFILE.lp_max ..
        "  WP " .. State.wp .. "/" .. PROFILE.wp_max ..
        "  CP " .. State.cp .. "/" .. PROFILE.cp_max,
    }
    if #PROFILE.keywords > 0 then
        table.insert(lines, "Keywords: " .. table.concat(PROFILE.keywords, ", "))
    end
    if #PROFILE.abilities > 0 then
        table.insert(lines, "Abilities: " .. table.concat(PROFILE.abilities, ", "))
    end
    printToColor(table.concat(lines, "\n"), playerColor or "White", {1, 0.9, 0.6})
end

-- Called by Global to query character state (e.g. for VP counting)
function getInfo()
    return {
        name        = PROFILE.name,
        playerColor = PROFILE.playerColor or "White",
        lp          = State.lp,
        lp_max      = PROFILE.lp_max,
        cp          = State.cp,
        activated   = State.activated,
    }
end

function endMyActivation(playerColor)
    -- Remove Stunned at end of turn if character had one
    if State.stunned and State.ap_used > 0 then
        removeStunned()
    end
    State.activated = true
    State.ap        = 0  -- any unspent AP is lost
    updateDisplay()
    Global.call("g_endActivation", { playerColor = playerColor })
    printToAll(PROFILE.name .. " ends their activation.", {0.7, 0.7, 0.7})
end
