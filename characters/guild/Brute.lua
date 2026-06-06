-- The Guild: Brute  (Hero / End of Days) · 13 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Brute",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "End of Days" },
    size        = 40,
    cost        = 13,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 2,
    mind       = 1,

    ap_max = 2,
    lp_max = 14,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Big Club", range = 1, evasion = nil, damage = 1, penetration = nil, abilities = { "Knockback" } },
    },

    abilities = { "Companion (End of Days)", "Mindless" },

    -- PASSIVE: Thick Skull — cannot receive Stunned counters.
}
