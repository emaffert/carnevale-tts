-- The Guild: Ostrich Chariot?!  (Hero / End of Days / Unique) · 34 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Ostrich Chariot?!",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "End of Days", "Unique" },
    size        = 75,
    cost        = 34,

    move       = 7,
    dexterity  = 3,
    attack     = 4,
    protection = 2,
    mind       = 1,

    ap_max = 2,
    lp_max = 30,
    wp_max = 3,
    cp_max = 0,

    weapons = {
        { name = "Club",          range = 0, evasion = nil, damage = nil, penetration = nil, abilities = { "Stun" } },
        { name = "Bottle Burner", range = 5, evasion = 2,   damage = 1,   penetration = -1,  abilities = { "Black Powder", "Blast" } },
        { name = "Bird Kick",     range = 0, evasion = nil, damage = 2,   penetration = nil, abilities = {} },
    },

    abilities = { "Bulky", "Companion (End of Days)", "First Strike (2)", "Limited Movement", "Mindless" },

    -- PASSIVE: Uncoordinated Assault
    --   After a Combat action, may make a free 0AP Attack of Opportunity with a different weapon.
    --   These AoO cannot cause further AoO and don't count as charging AoO.
    -- PASSIVE: Levatevi di Mezzo, Imbecilli!
    --   May freely move over other characters during Run/Climb. Ignores disengaging rules while
    --   moving. At end of each Run/Climb: Basic DEX roll — each Ace deals 1 LP to every character
    --   moved over (friend and foe). Fumble = Stunned counter.
}
