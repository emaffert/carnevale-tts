-- The Guild: Bloodletter  (Hero / House of Virtue) · 16 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- Discipline: Blood Rites

local PROFILE = {
    name        = "Bloodletter",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue", "Discipline (Blood Rites)" },
    size        = 30,
    cost        = 16,

    move       = 4,
    dexterity  = 4,
    attack     = 2,
    protection = 2,
    mind       = 5,

    ap_max = 2,
    lp_max = 11,
    wp_max = 3,
    cp_max = 0,

    weapons = {
        { name = "Dagger", range = 0, evasion = nil, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "Expert Sorcerer (1)", "Mage (2)" },

    -- PASSIVE: Magic for Blood
    --   On a successful Cast Spell action, gains 2 LP (can exceed starting LP).
    -- PASSIVE: Blood for Magic
    --   At start of turn, may replenish up to 3 WP, costing 1 LP per WP replenished.
}
