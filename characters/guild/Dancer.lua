-- The Guild: Dancer  (Hero / House of Virtue) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Dancer",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue" },
    size        = 30,
    cost        = 14,

    move       = 4,
    dexterity  = 6,
    attack     = 3,
    protection = 2,
    mind       = 4,

    ap_max = 2,
    lp_max = 11,
    wp_max = 2,
    cp_max = 3,

    weapons = {
        { name = "Poisoned Needle", range = 0, evasion = -1, damage = nil, penetration = 1, abilities = { "Poisoned" } },
    },

    abilities = { "Slippery" },

    -- PULSE: Communicative Dance
    --   Pick one friendly character within 3" and one different friendly House of Virtue
    --   character in LoS. Both make an immediate Run/Climb action (cannot charge, can disengage).
}
