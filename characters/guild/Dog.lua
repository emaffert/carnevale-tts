-- The Guild: Dog  (Henchman) · 5 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Dog",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman" },
    size        = 30,
    cost        = 5,

    move       = 6,
    dexterity  = 5,
    attack     = 2,
    protection = 1,
    mind       = 1,

    ap_max = 2,
    lp_max = 6,
    wp_max = 0,
    cp_max = 0,

    weapons = {
        { name = "Teeth", range = 0, evasion = nil, damage = 1, penetration = -1, abilities = {} },
    },

    abilities = { "Engage", "Limited Movement", "Mindless" },
}
