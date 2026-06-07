-- The Guild: Arbalest  (Henchman / Trade) · 10 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Arbalest",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "Trade" },
    size        = 30,
    cost        = 10,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 4,
    mind       = 3,

    ap_max = 2,
    lp_max = 10,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Crossbow", range = 30, evasion = nil, damage = nil, penetration = -1, abilities = { "Reload (1)", "Two-handed" } },
    },

    abilities = { "Companion (Trade)" },
}
