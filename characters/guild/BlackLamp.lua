-- The Guild: Black Lamp  (Hero / Unique / Trade) · 17 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Black Lamp",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "Unique", "Trade" },
    size        = 30,
    cost        = 17,

    move       = 4,
    dexterity  = 4,
    attack     = 4,
    protection = 4,
    mind       = 5,

    ap_max = 2,
    lp_max = 14,
    wp_max = 5,
    cp_max = 2,

    weapons = {
        { name = "Sharpened Dagger", range = 0, evasion = nil, damage = nil, penetration = -1, abilities = {} },
    },

    abilities = { "Brave", "Universal Shielding (4)" },

    -- AURA: Rally to the Light!
    --   Until end of round, friendly characters in LoS gain Companion (Black Lamp) and Brave.
    -- PASSIVE: The Lamp
    --   May Dispel as if Mage (3) and Expert Sorcerer (3).
    --   Enemy characters may not use Will Points within 3" of this character.
}
