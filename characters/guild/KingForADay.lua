-- The Guild: King For a Day  (Leader) · 16 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "King For a Day",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader", "End of Days" },
    size        = 30,
    cost        = 16,

    move       = 5,
    dexterity  = 4,
    attack     = 4,
    protection = 2,
    mind       = 3,

    ap_max = 2,
    lp_max = 12,
    wp_max = 2,
    cp_max = 2,

    weapons = {
        { name = "Staff of Credit", range = 0, evasion = nil, damage = nil, penetration = -3, abilities = {} },
    },

    abilities = { "Brave", "Companion (End of Days)", "Mindless" },

    -- AURA: Start the Horrorshow!
    --   Until end of round, friendly characters with End of Days keyword in LoS gain +1 ATTACK.
    -- PASSIVE: Do As I Say, Not As I Do
    --   All other friendly End of Days characters lose Mindless for the entire game, even if this
    --   character is killed. This character keeps Mindless.
}
