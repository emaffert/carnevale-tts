-- The Guild: Death Duellist  (Hero / House of Virtue) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Death Duellist",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue" },
    size        = 30,
    cost        = 14,

    move       = 5,
    dexterity  = 4,
    attack     = 4,
    protection = 2,
    mind       = 2,

    ap_max = 2,
    lp_max = 10,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Rapier", range = 0, evasion = nil, damage = nil, penetration = -1, abilities = {} },
    },

    abilities = { "Engage", "Expert Offence (2)", "Parry (2)" },

    -- PASSIVE: Victory Rush
    --   When this character kills an enemy with a Combat action, gain one of:
    --   +1 AP, replenish 4 LP, or replenish 2 WP.
}
