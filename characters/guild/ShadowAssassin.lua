-- The Guild: Shadow Assassin  (Hero / House of Virtue) · 14 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Shadow Assassin",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Hero", "House of Virtue" },
    size        = 30,
    cost        = 14,

    move       = 5,
    dexterity  = 5,
    attack     = 4,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 11,
    wp_max = 3,
    cp_max = 1,

    weapons = {
        { name = "Dual Stilettos", range = 0, evasion = -1, damage = 1, penetration = 1, abilities = {} },
    },

    abilities = { "Slippery" },

    -- ACTION (2AP): Fade to the Shadow
    --   If within 1" of impassable terrain, remove from board and place within 1" of another
    --   piece of impassable terrain at ground level, at least 6" from enemy characters.
}
