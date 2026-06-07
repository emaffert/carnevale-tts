-- The Guild: Gondolier  (Henchman / Trade) · 11 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Gondolier",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "Trade" },
    size        = 30,
    cost        = 11,

    move       = 4,
    dexterity  = 4,
    attack     = 3,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Bladed Oar", range = 2, evasion = nil, damage = 1, penetration = -1, abilities = { "Two-handed" } },
    },

    abilities = { "Brave", "Fast Swimmer (1)" },

    -- PASSIVE: Sculler
    --   For each character with this ability, you may purchase 1 extra Gondola from the
    --   Equipment list. This character may be deployed in water or on a Gondola and may
    --   also re-roll failed dice rolls when making Row actions.
}
