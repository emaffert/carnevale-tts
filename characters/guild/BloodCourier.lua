-- The Guild: Blood Courier  (Henchman / House of Virtue) · 13 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Blood Courier",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman", "House of Virtue" },
    size        = 30,
    cost        = 13,

    move       = 5,
    dexterity  = 3,
    attack     = 2,
    protection = 3,
    mind       = 3,

    ap_max = 2,
    lp_max = 10,
    wp_max = 2,
    cp_max = 0,

    weapons = {
        { name = "Dagger", range = 0, evasion = nil, damage = nil, penetration = nil, abilities = {} },
    },

    abilities = { "Concealment (2)", "Slippery" },

    -- ACTION (1WP): Transfusion
    --   One friendly character in base contact replenishes 1 Life Point OR one enemy character
    --   loses 1 Life Point. If an enemy character is killed by this life loss, this character
    --   replenishes 2 Will Points. Once per turn.
    -- PASSIVE: Bucket of Blood
    --   At the start of the game, when selecting spells, you may select a Blood Rites spell
    --   not known by any other friendly Mage for this character to store. While this character
    --   is within line of sight to a friendly Mage, that character can cast the stored spell
    --   as if it were their own.
}
