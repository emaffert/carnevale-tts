-- The Guild: Ostrich King?!  (Leader) · 19 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Ostrich King?!",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader", "End of Days" },
    size        = 40,
    cost        = 19,

    move       = 7,
    dexterity  = 4,
    attack     = 4,
    protection = 2,
    mind       = 2,

    ap_max = 2,
    lp_max = 15,
    wp_max = 2,
    cp_max = 2,

    weapons = {
        { name = "Staff of Credit", range = 0, evasion = nil, damage = nil, penetration = -3, abilities = {} },
    },

    abilities = { "Bulky", "Companion (End of Days)", "First Strike (2)", "Limited Movement", "Mindless", "Slippery" },

    -- AURA: Full Tilt!
    --   Until end of round, friendly End of Days characters in LoS gain +1 MOVEMENT.
    -- PASSIVE: Do As I Say, Not As I Do
    --   All other friendly End of Days characters lose Mindless for the entire game, even if this
    --   character is killed. This character keeps Mindless.
}
