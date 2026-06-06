-- The Guild: Harbourmaster  (Leader) · 21 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Harbourmaster",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader" },
    size        = 30,
    cost        = 21,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 4,

    ap_max = 3,
    lp_max = 14,
    wp_max = 3,
    cp_max = 4,

    weapons = {
        { name = "Clockwork Pistol", range = 6,  evasion = 1,   damage = 1,   penetration = -1, abilities = { "Black Powder", "Reload (2)" } },
        { name = "Sailor's Knife",   range = 0,  evasion = nil, damage = nil, penetration = -1, abilities = { "Aquatic" } },
    },

    abilities = { "Fast Swimmer (2)", "Parry (2)" },

    -- AURA: Toughen Up
    --   Until end of round, friendly characters within 6" gain Expert Protection (3).
    -- PASSIVE: Born to Swim
    --   Other friendly characters add +2 to their Fast Swimmer number while this character
    --   is on the board. Characters without Fast Swimmer instead gain Fast Swimmer (2).
}
