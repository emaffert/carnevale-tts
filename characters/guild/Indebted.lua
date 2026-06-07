-- The Guild: Indebted  (Henchman) · 11 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Indebted",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman" },
    size        = 30,
    cost        = 11,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 1,

    ap_max = 2,
    lp_max = 11,
    wp_max = 1,
    cp_max = 0,

    weapons = {
        { name = "Short Sword", range = 0, evasion = nil, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "First Strike (2)" },

    -- PASSIVE: Paying Off My Debts
    --   When this character kills an enemy character with a Combat action, add 1 re-roll to
    --   your Mob Mentality pool.
}
