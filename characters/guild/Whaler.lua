-- The Guild: Whaler  (Hero) · 17 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Whaler",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero" },
    size        = 40,
    cost        = 17,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 2,
    mind       = 3,

    ap_max = 2,
    lp_max = 15,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Whaling Lance", range = 6, evasion = 1, damage = 3, penetration = nil, abilities = { "Knockback", "Two-handed" } },
    },

    abilities = { "Boat Crew", "Hunter", "Fast Swimmer (2)" },

    -- PASSIVE: Get Over Here
    --   A Whaling Lance's Knockback can move the target in any direction.
}
