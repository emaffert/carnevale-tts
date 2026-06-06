-- The Guild: Seamstress  (Hero / House of Virtue) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- Disciplines: Divinity, Fateweaving

local PROFILE = {
    name        = "Seamstress",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue", "Discipline (Divinity, Fateweaving)" },
    size        = 30,
    cost        = 14,

    move       = 4,
    dexterity  = 4,
    attack     = 2,
    protection = 3,
    mind       = 4,

    ap_max = 2,
    lp_max = 12,
    wp_max = 4,
    cp_max = 0,

    weapons = {
        { name = "Unarmed", range = 0, evasion = nil, damage = nil, penetration = 1, abilities = {} },
    },

    abilities = { "Mage (1)", "Expert Sorcerer (1)" },

    -- PASSIVE: Entwined Magics
    --   Additional spells granted by Expert Sorcerer may be from any accessible discipline
    --   (does not gain an extra cantrip if from a different discipline).
}
