-- The Guild: Recruiter  (Hero / Trade) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Recruiter",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Trade" },
    size        = 30,
    cost        = 14,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 5,

    ap_max = 2,
    lp_max = 12,
    wp_max = 3,
    cp_max = 2,

    weapons = {
        { name = "Handbow", range = 15, evasion = nil, damage = nil, penetration = -1, abilities = { "Reload (2)" } },
    },

    abilities = {},

    -- AURA: Extortion
    --   Until end of round, friendly Henchman characters within 6" gain Bodyguard (Hero).
    -- PASSIVE: Instigator
    --   Friendly Companion (Trade) characters gain +1 ATTACK while within 6" of one or more
    --   characters with this special rule. Characters with Instigator are unaffected.
}
