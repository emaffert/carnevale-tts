-- The Guild: Brewer  (Hero / End of Days) · 15 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- NOTE Flambé: Flaming Bottles may only be used within 3" of a Pulcinella Firebreather.

local PROFILE = {
    name        = "Brewer",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "End of Days" },
    size        = 40,
    cost        = 15,

    move       = 4,
    dexterity  = 3,
    attack     = 3,
    protection = 2,
    mind       = 2,

    ap_max = 2,
    lp_max = 13,
    wp_max = 2,
    cp_max = 2,

    weapons = {
        { name = "Bottles",         range = 6, evasion = nil, damage = nil, penetration = nil, abilities = {} },
        { name = "Flaming Bottles", range = 6, evasion = nil, damage = nil, penetration = -5,  abilities = { "Black Powder" } },
    },

    abilities = { "Companion (End of Days)", "Mindless" },

    -- AURA: Fancy a Tipple?
    --   Until end of round, friendly characters within 3" gain Brave and First Strike (1).
    -- PASSIVE: Keep it Flowing
    --   Enemy characters in base contact can be targeted by Drown regardless of water.
    -- PASSIVE: Flambé (see NOTE above)
}
