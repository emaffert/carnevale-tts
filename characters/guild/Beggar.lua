-- The Guild: Beggar  (Henchman) · 5 Ducats
-- Paste this PROFILE into CharacterToken.lua to create the token script.

local PROFILE = {
    name        = "Beggar",
    playerColor = "White",
    faction     = "The Guild",
    keywords    = { "Faction (The Guild)", "Henchman" },
    size        = 30,
    cost        = 5,

    move       = 4,
    dexterity  = 3,
    attack     = 2,
    protection = 3,
    mind       = 2,

    ap_max = 2,
    lp_max = 10,
    wp_max = 0,
    cp_max = 0,

    weapons = {
        { name = "Unarmed", range = 0, evasion = nil, damage = nil, penetration = 1, abilities = {} },
    },

    abilities = { "Concealment (+2)" },

    -- PASSIVE: Whispers on the Street
    --   For every friendly character with this ability in your gang at the start of the round,
    --   add a re-roll to your Mob Mentality Pool. Until the end of the round, any friendly
    --   character may use these re-rolls on any roll – one re-roll per dice.
    -- PASSIVE: Hidden in Plain Sight
    --   This character can be deployed anywhere on the board at ground level, at least 6"
    --   away from any enemy characters or objectives.
}
