-- The Guild: Blooded  (Henchman) · 5 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Blooded",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman" },
    size        = 30,
    cost        = 5,

    move       = 4,
    dexterity  = 3,
    attack     = 2,
    protection = 1,
    mind       = 1,

    ap_max = 2,
    lp_max = 10,
    wp_max = 0,
    cp_max = 0,

    weapons = {
        { name = "Unarmed", range = 0, evasion = nil, damage = nil, penetration = 1, abilities = {} },
    },

    abilities = { "Mindless", "Limited Movement" },

    -- PASSIVE: Living Sacrifice
    --   Any character with the House of Virtue keyword within 6" and line of sight may use
    --   this character's Life Points as if they were their own Will Points, costing 2 Life
    --   Points per Will Point. This ability can be used even if it would kill this character.
    --   If a Will Point granted by this ability would kill this character and be used on a
    --   Cast Spell action, the destiny dice is counted as automatically rolling a 10.
}
