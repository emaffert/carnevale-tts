-- The Guild: Rialto Assassin  (Hero / Unique) · 16 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Rialto Assassin",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Unique" },
    size        = 30,
    cost        = 16,

    move       = 5,
    dexterity  = 5,
    attack     = 5,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 13,
    wp_max = 3,
    cp_max = 0,

    weapons = {
        { name = "Balanced Throwing Knife", range = 6, evasion = nil, damage = -1, penetration = -4, abilities = {} },
        { name = "Smoke Bomb",              range = 6, evasion = 1,   damage = nil, penetration = nil, abilities = { "Blast", "Harmless", "Smoke", "Reload (1)" } },
    },

    abilities = { "Expert Marksman (3)", "Infiltration", "Slippery" },
}
