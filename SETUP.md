# Carnevale TTS Module — Setup Guide

## Project Files

```
Global.lua            Core engine: dice, turn management, VP tracking
GameManager.lua       Table token with game control buttons
GangWar.lua           Gang War scenario token
AgendaDeck.lua        35-agenda deck with two-dice draw system
CharacterToken.lua    Template for character tokens (copy per character)
characters/
  Capodecina.lua      Example of a fully configured character token
SETUP.md              This file
```

---

## 1. Creating Objects in TTS

Each Lua file corresponds to one TTS object. For each file:

1. In TTS, go to **Objects → Components → Custom → Custom Token** (or any object type you prefer for the physical appearance).
2. Right-click the object → **Scripting** → paste the contents of the corresponding `.lua` file.
3. Press **Save & Play**.

### Object types recommended
| File | TTS object type |
|---|---|
| `GameManager.lua` | Custom Token (square, neutral color) |
| `GangWar.lua` | Custom Token (scenario card art if available) |
| `CharacterToken.lua` | Custom Token (character art) or Custom Figure |

---

## 2. Tagging Character Tokens

Every character token **must** have the TTS tag `carnevale_character` so the Global script can find them (for round resets, VP counting, etc.).

To add a tag: right-click the token → **Tags** → **Add Tag** → type `carnevale_character`.

---

## 3. Configuring the Rulebook URL

Open `GameManager.lua` and find the line near the top:

```lua
local RULEBOOK_URL = "file:///home/eldrim/Downloads/Carnevale_after_party_rulebook_smaller_size.pdf"
```

- **Local / LAN play**: the `file:///` path works as-is for the host. Other players on the same machine will see it; remote players will not.
- **Online play**: upload the PDF somewhere publicly accessible and replace the URL.

### Hosting on Google Drive
1. Upload the PDF to Google Drive.
2. Right-click → **Share** → set to "Anyone with the link".
3. Copy the share link. It looks like:
   `https://drive.google.com/file/d/FILE_ID/view`
4. Change it to the direct download format:
   `https://drive.google.com/uc?id=FILE_ID`
5. Paste that URL into `RULEBOOK_URL`.

---

## 4. Creating Character Tokens

1. Copy `CharacterToken.lua`.
2. At the top, fill in the `PROFILE` block with the character's stats from their card:

```lua
local PROFILE = {
    name        = "Capodecina",
    playerColor = "White",   -- will be overwritten in-game via "Claim for me"
    faction     = "The Guild",
    keywords    = { "The Guild", "Leader", "Trade" },
    size        = 30,        -- base diameter in mm
    cost        = 30,        -- Ducats

    move       = 6,
    dexterity  = 6,
    attack     = 4,
    protection = 2,
    mind       = 4,

    ap_max = 3,
    lp_max = 13,
    wp_max = 4,
    cp_max = 4,

    weapons = {
        { name = "Futa Blade", range = 0, evasion = nil, damage = nil, penetration = 2, abilities = {} },
    },

    abilities = { "Aerial Attack", "Expert Offence (2)", "Infiltration" },
}
```

3. Paste the modified script into a TTS Custom Token object.
4. Add the tag `carnevale_character` to the object.
5. Save the object into a **Bag** named after its faction (e.g. "The Guild").

See `characters/Capodecina.lua` for a complete filled-in example.

---

## 5. Faction Bags

- Create **one Bag per faction** (Objects → Components → Bag).
- Place all character tokens for that faction inside.
- Any player can take tokens from any bag — ownership is assigned in-game.

### Claiming a token in-game
When a player pulls a token from a bag and places it in their deployment zone:
1. Right-click the token → **Claim for me**.
2. The token tints to the player's color and registers them as the owner for VP counting.

---

## 6. Playing Gang War

### Setup
1. Place the **Game Manager**, **Gang War**, and **Agenda Deck** tokens on the table.
2. Place terrain (aim for 1/3 water, 1/3 ground, 1/3 buildings).
   - Each player places 1 Gondola in water during terrain setup.
3. Press **Setup Scenario** on the Gang War token — this prints full setup instructions to chat.
4. Each player presses **Draw Agenda** on the Agenda Deck token 3 times.
5. Roll for deployment zones (highest roll picks first). Deploy within 8" of your board edge.
6. Each player pulls their characters from their faction bag, places them, and **Claim for me** on each one.

### Each Round
1. Press **New Round** on the Game Manager — resets all AP, prints initiative prompt.
2. Players roll initiative manually (CP dice, 7+ = Ace, most Aces goes first).
3. Press **Start Turns** — the first character is announced and highlighted.
4. The active player takes their character's turn (up to 3 AP). Use right-click menus for rolls and status changes.
5. When done, right-click the character → **End Activation** — the next character is highlighted.
6. Repeat until all characters have activated, then press **New Round** again.

### Agendas
Use the **Agenda Deck** token for all agenda interactions:

| Button | When to press |
|---|---|
| **Draw Agenda** | During setup — press 3 times per player |
| **My Agendas** | Any time — shows your agendas privately in chat |
| **Score Agenda 1/2/3** | When you achieve agenda 1, 2, or 3 — awards 1 VP |
| **Hold for Double 1/2/3** | Gang War Double rule — hold instead of scoring now; achieving it again awards 2 VP |
| **Discard & Redraw** | If an agenda is impossible for your gang (e.g. Unholy Power with no Mage) |
| **Reset Deck** | Between games — clears all hands |

Gang War uses the **Double** rule: when you achieve an agenda you may hold it (use **Hold for Double**) and try to achieve it again for 2 VP instead of 1.

### End of Game (after Round 5)
Press **End Game / Tally** on the Gang War token.
- The script automatically counts 1 VP per surviving character per player.
- Agenda VP (tracked by button presses) is added.
- Final standings are printed to chat.

---

## 7. Dice Rolls — Quick Reference

All rolls are made via right-click context menu on a character token, or by calling Global functions directly from the TTS scripting console.

| Roll type | Ace threshold | Used for |
|---|---|---|
| Basic (DEX, MIND…) | 7+ | Climbing, jumping, falling, hiding |
| Attack | ≥ target's DEXTERITY | Combat actions |
| Protection | 7+ | Saving against damage |
| Magic | ≥ spell's Difficulty | Cast Spell actions |
| Opposed | 7+ | Grapple, Disengage |

**Will Points**: each WP spent adds 1 die to the roll (max 2 WP per roll, max 10 dice total). Declare before rolling — you cannot change your mind after.

**Destiny Die**: one die in every roll is marked with `[ ]` in chat. A `10` on the Destiny Die + at least one other Ace = **Critical**. A `1` on the Destiny Die + no Aces = **Fumble**.

---

## 8. Adding New Factions / Characters

1. Duplicate `CharacterToken.lua`.
2. Fill in the `PROFILE` block from the character's card (available at ttcombat.com/pages/carnevale-resources).
3. Create a TTS token, paste the script, tag it `carnevale_character`.
4. Put it in the appropriate faction Bag.

No changes to `Global.lua` or `GameManager.lua` are needed for new characters.
