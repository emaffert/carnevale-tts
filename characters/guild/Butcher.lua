-- The Guild: Butcher  (Hero / Trade) · 13 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Butcher",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Trade" },
    size        = 30,
    cost        = 13,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 3,

    ap_max = 2,
    lp_max = 13,
    wp_max = 3,
    cp_max = 0,

    weapons = {
        { name = "Butcher's Knives", range = 0, evasion = nil, damage = 1, penetration = nil, abilities = {} },
    },

    abilities = { "Brawler (1)", "Expert Grappler (2)" },
}
