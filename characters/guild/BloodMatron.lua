-- The Guild: Blood Matron  (Hero / House of Virtue) · 15 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- SETUP: Nominate one enemy character as this character's Prey at game start.

local PROFILE = {
    name        = "Blood Matron",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue" },
    size        = 30,
    cost        = 15,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 2,

    ap_max = 2,
    lp_max = 12,
    wp_max = 2,
    cp_max = 1,

    weapons = {
        { name = "Pithing Needle", range = 0, evasion = 1, damage = nil, penetration = -1, abilities = { "Stun" } },
    },

    abilities = { "Mindless", "Vampiric Attack (2)" },

    -- PASSIVE: Go For The Eyes
    --   When Pithing Needle scores a Critical in Combat, the Stunned counter cannot be
    --   removed for the rest of the game and is unaffected by spells/abilities.
    -- PASSIVE: Prey Upon (nominate at game start)
    --   Combat actions against Prey are Critical if Destiny Dice = 9 or 10 AND at least
    --   1 other Ace.
}
