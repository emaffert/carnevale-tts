-- The Guild: Ebenezer Chummage  (Hero / Trade / Unique) · 18 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- SPECIAL: Starts with 3 Dried Meats counters (track manually).

local PROFILE = {
    name        = "Ebenezer Chummage",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Trade", "Unique" },
    size        = 40,
    cost        = 18,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 3,

    ap_max = 2,
    lp_max = 14,
    wp_max = 3,
    cp_max = 1,

    weapons = {
        { name = "Fishmonger's Knives", range = 0, evasion = nil, damage = 1, penetration = -1, abilities = {} },
        { name = "Thrown Harpoon",      range = 4, evasion = 1,   damage = 1, penetration = 0,  abilities = { "Reload (1)" } },
    },

    abilities = { "Brawler (2)", "Expert Grappler (2)", "Fast Swimmer (1)", "Hunter" },

    -- PULSE: Hearty Fish Soup
    --   Friendly Trade characters within 6" gain Brave and Expert Protection (1) until
    --   end of this character's next turn.
    -- PASSIVE: A Choice Cut
    --   When this character kills a Monster, replenish 1 CP.
    -- PASSIVE: Gifts of Dried Meats (3 counters at game start)
    --   Spend a counter at end of activation: a friendly character in base contact
    --   replenishes 2 LP.
}
