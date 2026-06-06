-- The Guild: Fisherman  (Hero) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- NOTE: Pole Spear & Net OR Harpoon Gun — choose before game, cannot change.

local PROFILE = {
    name        = "Fisherman",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero" },
    size        = 30,
    cost        = 14,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 3,

    ap_max = 2,
    lp_max = 12,
    wp_max = 3,
    cp_max = 1,

    weapons = {
        { name = "Pole Spear & Net", range = 0,  evasion = -1, damage = 1,   penetration = nil, abilities = { "Aquatic" } },
        { name = "Harpoon Gun",      range = 12, evasion = 1,  damage = 1,   penetration = nil, abilities = { "Reload (1)", "Two-handed" } },
    },

    abilities = { "Expert Offence (1)", "Fast Swimmer (2)", "Hunter" },

    -- PULSE: Bring it Down!
    --   One friendly character within 6" gains Hunter until end of game.
}
