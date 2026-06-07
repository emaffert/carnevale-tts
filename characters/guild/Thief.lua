-- The Guild: Thief  (Hero) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Thief",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero" },
    size        = 30,
    cost        = 14,

    move       = 5,
    dexterity  = 5,
    attack     = 3,
    protection = 2,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 3,
    cp_max = 1,

    weapons = {
        { name = "Stiletto",   range = 0, evasion = nil, damage = 1, penetration = 1, abilities = {} },
        { name = "Smoke Bomb", range = 6, evasion = 1,   damage = 0, penetration = nil, abilities = { "Blast", "Harmless", "Smoke", "Reload (1)" } },
    },

    abilities = { "Aerial Attack", "Infiltration", "Pickpocket" },

    -- PULSE: Get to the Roof!
    --   One friendly character with the Henchman keyword within 6" gains Acrobatic (3)
    --   until the end of the game.
}
