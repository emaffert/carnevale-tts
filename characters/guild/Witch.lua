-- The Guild: Witch  (Hero / House of Virtue) · 16 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- Disciplines: Blood Rites, Runes of Sovereignty, Wild Magic

local PROFILE = {
    name        = "Witch",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue", "Discipline (Blood Rites, Runes of Sovereignty, Wild Magic)" },
    size        = 30,
    cost        = 16,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 5,

    ap_max = 2,
    lp_max = 11,
    wp_max = 4,
    cp_max = 2,

    weapons = {
        { name = "Unarmed", range = 0, evasion = nil, damage = nil, penetration = 1, abilities = {} },
    },

    abilities = { "Mage (2)", "Slippery" },

    -- ACTION (1AP): Blood Rights
    --   Pick one character within 3" (friendly or enemy). That character loses 1 Life Point
    --   and this character replenishes 1 Will Point.
}
