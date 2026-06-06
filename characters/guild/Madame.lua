-- The Guild: Madame  (Leader) · 20 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Madame",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader", "House of Virtue" },
    size        = 30,
    cost        = 20,

    move       = 4,
    dexterity  = 5,
    attack     = 3,
    protection = 3,
    mind       = 6,

    ap_max = 3,
    lp_max = 12,
    wp_max = 4,
    cp_max = 4,

    weapons = {
        { name = "Garter Pistol", range = 6, evasion = nil, damage = nil, penetration = -2, abilities = { "Black Powder", "Reload (2)" } },
        { name = "Stiletto",      range = 0, evasion = nil, damage = 1,   penetration = 1,  abilities = {} },
    },

    abilities = { "Concealment (+1)", "Parry (2)", "Slippery" },

    -- PULSE: Don't Let Them Take You!
    --   One other friendly character in LoS within 3" gains Parry (2) until end of game.
    -- PASSIVE: My Girls & Boys
    --   While on board, all House of Virtue characters gain Companion (House of Virtue).
    -- AURA: Strike When They're Vulnerable
    --   Until end of round, other friendly House of Virtue characters in LoS gain Penetration -2.
}
