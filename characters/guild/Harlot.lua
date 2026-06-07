-- The Guild: Harlot  (Henchman / House of Virtue) · 10 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Harlot",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "House of Virtue" },
    size        = 30,
    cost        = 10,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 2,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Stiletto", range = 0, evasion = nil, damage = 1, penetration = 1, abilities = {} },
    },

    abilities = { "Concealment (+1)", "Slippery" },
}
