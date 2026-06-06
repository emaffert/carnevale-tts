-- The Guild: Prince of Thieves  (Leader / Hero / Unique) · 23 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.
-- NOTE: A Hero Among Thieves — if only Leader in gang, loses Hero keyword; if another
--       Leader is present, loses Leader keyword. Adjudicate manually at game start.

local PROFILE = {
    name        = "Prince of Thieves",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Leader", "Hero", "Unique" },
    size        = 30,
    cost        = 23,

    move       = 5,
    dexterity  = 5,
    attack     = 5,
    protection = 4,
    mind       = 5,

    ap_max = 3,
    lp_max = 13,
    wp_max = 2,
    cp_max = 5,

    weapons = {
        { name = "Concealed Pistol", range = 4, evasion = nil, damage = 1, penetration = nil, abilities = { "Black Powder", "Reload (1)", "Knockback" } },
        { name = "Gilded Sword",     range = 0, evasion = nil, damage = 1, penetration = -1,  abilities = {} },
    },

    abilities = { "Acrobatic (2)", "Expert Marksman (2)", "Pickpocket", "Slippery" },

    -- PULSE: Thieves Guild Training
    --   One friendly character within 6" gains Pickpocket until end of game.
    -- PASSIVE: Take it for the Guild!
    --   Friendly characters in LoS replenish 2 WP instead of 1 when Pickpocketing.
    -- PASSIVE: A Hero Among Thieves (see NOTE above)
}
