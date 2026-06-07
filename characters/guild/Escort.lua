-- The Guild: Escort  (Henchman / House of Virtue) · 12 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Escort",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "House of Virtue" },
    size        = 40,
    cost        = 12,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 13,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Sword", range = 0, evasion = nil, damage = 1, penetration = nil, abilities = {} },
    },

    abilities = { "Bodyguard (Hero, Henchman)", "Expert Grappler (1)" },
}
