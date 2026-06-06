-- The Guild: Smuggler  (Hero) · 13 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Smuggler",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero" },
    size        = 30,
    cost        = 13,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 5,

    ap_max = 2,
    lp_max = 12,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Blunderbuss", range = 0, evasion = -1, damage = 2, penetration = 1, abilities = { "Black Powder", "Reload (1)", "Template" } },
    },

    abilities = { "Boat Crew", "Concealment (+1)" },

    -- PASSIVE: Smuggling
    --   When you achieve an Agenda, one character within 6" and LoS replenishes 1 CP.
}
