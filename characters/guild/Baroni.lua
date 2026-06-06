-- The Guild: Baroni  (Hero) · 15 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- NOTE Twin Pistols: weapons share Reload — 2 actions with Duelling Pistol OR 1 with Twin
--   Duelling Pistols per round. Twin Duelling Pistols must be used as first action of turn.

local PROFILE = {
    name        = "Baroni",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero" },
    size        = 30,
    cost        = 15,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 4,

    ap_max = 2,
    lp_max = 13,
    wp_max = 3,
    cp_max = 2,

    weapons = {
        { name = "Duelling Pistol",      range = 8, evasion = nil, damage = nil, penetration = -1, abilities = { "Black Powder", "Reload (2)" } },
        { name = "Twin Duelling Pistols",range = 8, evasion = nil, damage = 3,   penetration = -1, abilities = { "Black Powder", "Reload (1)" } },
    },

    abilities = { "Expert Marksman (2)", "Pickpocket" },

    -- AURA: Intimidation
    --   Until end of round, friendly characters within 3" gain First Strike (1).
    -- PASSIVE: Twin Pistols / Unwieldy (see NOTE above)
}
