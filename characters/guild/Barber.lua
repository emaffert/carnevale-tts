-- The Guild: Barber  (Hero / Trade) · 12 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Barber",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Trade" },
    size        = 30,
    cost        = 12,

    move       = 4,
    dexterity  = 5,
    attack     = 4,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 3,
    cp_max = 0,

    weapons = {
        { name = "Straight Razor", range = 0, evasion = nil, damage = nil, penetration = -3, abilities = {} },
    },

    abilities = { "Expert Offence (1)", "Engage" },
}
