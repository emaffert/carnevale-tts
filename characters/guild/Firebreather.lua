-- The Guild: Firebreather  (Henchman / End of Days) · 10 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Firebreather",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "End of Days" },
    size        = 30,
    cost        = 10,

    move       = 5,
    dexterity  = 4,
    attack     = 3,
    protection = 2,
    mind       = 1,

    ap_max = 2,
    lp_max = 9,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Fire Breath", range = 0, evasion = nil, damage = nil, penetration = -3, abilities = { "Black Powder", "Template", "Two-handed", "Reload (1)" } },
    },

    abilities = { "Companion (End of Days)", "Mindless" },
}
