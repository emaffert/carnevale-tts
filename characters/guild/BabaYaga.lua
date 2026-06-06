-- The Guild: Baba-Yaga  (Hero / Unique) · 19 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- Disciplines: Blood Rites, Wild Magic

local PROFILE = {
    name        = "Baba-Yaga",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Unique", "Discipline (Blood Rites, Wild Magic)" },
    size        = 40,
    cost        = 19,

    move       = 4,
    dexterity  = 3,
    attack     = 2,
    protection = 3,
    mind       = 6,

    ap_max = 2,
    lp_max = 13,
    wp_max = 7,
    cp_max = 0,

    weapons = {
        { name = "Pestle", range = 1, evasion = nil, damage = 2, penetration = nil, abilities = { "Knockback", "Two-handed" } },
    },

    abilities = { "Bulky", "Mage (3)", "Vampiric Attack (2)" },

    -- ACTION (1AP): Blood Rights
    --   Pick one character within 3" (friendly or enemy). That character loses 1 LP,
    --   and this character replenishes 1 WP.
}
