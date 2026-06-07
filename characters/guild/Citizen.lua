-- The Guild: Citizen  (Henchman / Trade) · 9 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Citizen",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "Trade" },
    size        = 30,
    cost        = 9,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Improvised Weapon", range = 0, evasion = nil, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "Companion (Trade)" },
}
