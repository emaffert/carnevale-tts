-- The Guild: Very Loud Ostrich  (Hero / End of Days) · 16 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Very Loud Ostrich",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "End of Days" },
    size        = 40,
    cost        = 16,

    move       = 7,
    dexterity  = 4,
    attack     = 3,
    protection = 2,
    mind       = 1,

    ap_max = 2,
    lp_max = 14,
    wp_max = 3,
    cp_max = 2,

    weapons = {
        { name = "Trumpet", range = 0, evasion = nil, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "Bulky", "Companion (End of Days)", "First Strike (2)", "Limited Movement", "Mindless", "Slippery" },

    -- PULSE: Toot Toot Toot... Charge!
    --   Up to 2 friendly characters within 3" may make an immediate Run/Climb action, but this
    --   movement must be used to charge an enemy (doesn't have to be the same enemy!).
    -- PASSIVE: Doot
    --   Whenever this character makes a Combat action with its Trumpet weapon, all friendly
    --   characters within 3" cheer and replenish 1 Will Point.
}
