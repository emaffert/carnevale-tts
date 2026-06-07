-- The Guild: Dog Keeper  (Henchman) · 12 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Dog Keeper",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman" },
    size        = 30,
    cost        = 12,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 2,

    ap_max = 2,
    lp_max = 11,
    wp_max = 1,
    cp_max = 2,

    weapons = {
        { name = "Training Whip", range = 3, evasion = -1, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "Companion (Dog)", "Engage" },

    -- PASSIVE: "Encouragement"
    --   This character may only use the ORDER or COUNTER Commands on characters with the
    --   Henchman keyword.
}
