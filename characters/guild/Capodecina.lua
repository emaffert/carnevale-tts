-- The Guild: Capodecina  (Leader) · 20 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- Faction ability: Mob Mentality (PULSE) — see faction sheet.

local PROFILE = {
    name        = "Capodecina",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader", "Trade" },
    size        = 30,
    cost        = 20,

    move       = 5,
    dexterity  = 6,
    attack     = 4,
    protection = 2,
    mind       = 4,

    ap_max = 3,
    lp_max = 13,
    wp_max = 4,
    cp_max = 4,

    weapons = {
        { name = "Twin Blades", range = 0, evasion = nil, damage = 1, penetration = nil, abilities = {} },
    },

    abilities = { "Aerial Attack", "Expert Offence (2)", "Infiltration" },

    -- PULSE: Fight For the Guild!
    --   One friendly character in LoS with Trade keyword replenishes 2 WP instead of 1
    --   from Companion until end of game.
    -- AURA: Rise Up
    --   All friendly characters with Trade keyword gain Companion (Trade) while this
    --   character is on the board.
}
