// Final Fantasy
// #ID = 15580

// -----------------------------------------------------------------------------
// VARIABLES

BattleMode = byte(0x4cf0)
ScreenID = byte(0x0984)
StepsTaken = dword(0x0741)
LeftMiddleEnemyStatus = byte(0xc8d3)

PartyLocation = byte(0x0602)
Locations = {
    0x00: "Overworld",
    0x01: "Earth Cave",
    0x02: "Earth Cave",
    0x03: "Earth Cave",
    0x04: "Earth Cave",
    0x05: "Earth Cave",
    0x06: "Castle of Elf",
    0x07: "Elfland Town",
    0x08: "Elfland Town",
    0x09: "Elfland Town",
    0x0a: "Elfland Town",
    0x0b: "Elfland Town",
    0x0c: "Elfland Town",
    0x0d: "Elfland Town",
    0x0e: "Elfland Town",
    0x0f: "Elfland Town",
    0x10: "Elfland Town",
    0x11: "Onrac Town",
    0x12: "Onrac Town",
    0x13: "Onrac Town",
    0x14: "Onrac Town",
    0x15: "Onrac Town",
    0x16: "Onrac Town",
    0x17: "Sea Shrine",
    0x18: "Sea Shrine",
    0x19: "Sea Shrine",
    0x1a: "Sea Shrine",
    0x1b: "Sea Shrine",
    0x1c: "Sea Shrine",
    0x1d: "Sea Shrine",
    0x1e: "Sea Shrine",
    0x1f: "Temple of Fiends",
    0x20: "Temple of Fiends",
    0x21: "Temple of Fiends",
    0x22: "Temple of Fiends",
    0x23: "Temple of Fiends",
    0x24: "Temple of Fiends",
    0x25: "Temple of Fiends",
    0x26: "Temple of Fiends",
    0x27: "Temple of Fiends",
    0x28: "Titan's Cave",
    0x29: "Gurgu Vulcano",
    0x2a: "Gurgu Vulcano",
    0x2b: "Gurgu Vulcano",
    0x2c: "Gurgu Vulcano",
    0x2d: "Gurgu Vulcano",
    0x2e: "Gurgu Vulcano",
    0x2f: "Crescent Lake Town",
    0x30: "Crescent Lake Town",
    0x31: "Crescent Lake Town",
    0x32: "Crescent Lake Town",
    0x33: "Crescent Lake Town",
    0x34: "Crescent Lake Town",
    0x35: "Crescent Lake Town",
    0x36: "Crescent Lake Town",
    0x37: "Sarda's Cave",
    0x38: "Coneria Castle",
    0x39: "Coneria Castle",
    0x3a: "Coneria Town",
    0x3b: "Coneria Town",
    0x3c: "Coneria Town",
    0x3d: "Coneria Town",
    0x3e: "Coneria Town",
    0x3f: "Coneria Town",
    0x40: "Coneria Town",
    0x41: "Coneria Town",
    0x42: "Ice Cave",
    0x43: "Ice Cave",
    0x44: "Ice Cave",
    0x45: "Ice Cave",
    0x46: "Ice Cave",
    0x47: "Gaia Town",
    0x48: "Gaia Town",
    0x49: "Gaia Town",
    0x4a: "Gaia Town",
    0x4b: "Gaia Town",
    0x4c: "Gaia Town",
    0x4d: "Castle of Ordeals",
    0x4e: "Castle of Ordeals",
    0x4f: "Castle of Ordeals",
    0x50: "Mirage Tower",
    0x51: "Mirage Tower",
    0x52: "Mirage Tower",
    0x53: "Waterfalf",
    0x54: "Cardia Islands",
    0x55: "Cardia Islands",
    0x56: "Cardia Islands",
    0x57: "Dwarf Cave",
    0x58: "Ancient Castle",
    0x59: "Marsh Cave",
    0x5a: "Marsh Cave",
    0x5b: "Marsh Cave",
    0x5c: "Sky Palace",
    0x5d: "Sky Palace",
    0x5e: "Sky Palace",
    0x5f: "Sky Palace",
    0x60: "Sky Palace",
    0x61: "Matoya's Cave",
    0x62: "Pravoka Town",
    0x63: "Pravoka Town",
    0x64: "Pravoka Town",
    0x65: "Pravoka Town",
    0x66: "Pravoka Town",
    0x67: "Pravoka Town",
    0x68: "Pravoka Town",
    0x69: "Pravoka Town",
    0x6a: "Melmond Town",
    0x6b: "Melmond Town",
    0x6c: "Melmond Town",
    0x6d: "Melmond Town",
    0x6e: "Melmond Town",
    0x6f: "Melmond Town",
    0x70: "Lefein Town",
    0x71: "Lefein Town",
    0x72: "Oasis",
    0x73: "Oasis",
    0x74: "Gaia Town",
    0x75: "Gaia Town",
    0x76: "Coneria Bridge",
    0x79: "Ryukahn Desert"
}

Jobs = {
    0x00: "Fighter",
    0x01: "Thief",
    0x02: "Monk",
    0x03: "Red Mage",
    0x04: "White Mage",
    0x05: "Black Mage",
    0x08: "Knight",
    0x09: "Ninja",
    0x0a: "Master",
    0x0b: "Red Wizard",
    0x0c: "White Wizard",
    0x0d: "Black Wizard"
}

EnemyFormation = byte(0x099f)
EnemyFormations = {
    "CHAOS": 0x7b,
    "WARMECH": 0x56,
    "TYRO": 0xbd,
}

Character1 = {
    "JOB": byte(0x075b),
    "DEATH": bit0(0xc613),
    "SPELLS": array_map(range(0x078b, 0x7a2), slot => byte(slot))
}
Character2 = {
    "JOB": byte(0x07b3),
    "DEATH": bit0(0xc6c3),
    "SPELLS": array_map(range(0x07e3, 0x7fa), slot => byte(slot))
}
Character3 = {
    "JOB": byte(0x080b),
    "DEATH": bit0(0xc773),
    "SPELLS": array_map(range(0x083b, 0x852), slot => byte(slot))
}
Character4 = {
    "JOB": byte(0x0863),
    "DEATH": bit0(0xc823),
    "SPELLS": array_map(range(0x0893, 0x8aa), slot => byte(slot))
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function isMainMenu() => ScreenID == 0x03 || ScreenID == 0x04

function isGameActive() => !isMainMenu() && StepsTaken > 0

function isInBattle() => BattleMode == 0 && isGameActive()

function partyIsDefeated() => Character1["DEATH"] == 1
                                && Character2["DEATH"] == 1
                                && Character3["DEATH"] == 1
                                && Character4["DEATH"] == 1

// -----------------------------------------------------------------------------
// PROGRESSION

function addEventFlagAchievement(id, title, description, points, progress, location, flag) {
    type = ""
    if (progress == true) {
        type = "progression"
    }

    achievement(
        id = id,
        title = title,
        description = description,
        points = points,
        trigger = prev(flag) == 0 && flag == 1 && PartyLocation == location,
        type = type
    )
}

addEventFlagAchievement(0, "The Princess Sara", "Rescue Princess Sara and rebuild the bridge", 2, true, 0x39, bit3(0x62c))
addEventFlagAchievement(0, "A Ship", "Obtain a ship", 5, true, 0x62, bit5(0x62c))
addEventFlagAchievement(0, "The Mystic Key", "Find the mystic key", 3, true, 0x6, bit1(0x62d))
addEventFlagAchievement(0, "The Earth Crystal", "Purify the Earth Crystal", 10, true, 0x5, bit1(0x62e))
addEventFlagAchievement(0, "A Canoe", "Obtain a canoe", 5, true, 0x2f, bit2(0x62e))
addEventFlagAchievement(0, "The Fire Crystal", "Purify the Fire Crystal", 10, true, 0x2e, bit3(0x62e))
addEventFlagAchievement(0, "An Airship", "Find an airship", 5, true, 0x79, bit5(0x62e))
addEventFlagAchievement(0, "The Water Crystal", "Purify the Water Crystal", 5, true, 0x17, bit5(0x62f))
addEventFlagAchievement(0, "The Lefeinians Language", "Learn the language of the Lefeinians", 5, true, 0x6a, bit6(0x62f))
addEventFlagAchievement(0, "The Wind Crystal", "Purify the Wind Crystal", 5, true, 0x60, bit2(0x63))
addEventFlagAchievement(0, "The Chaos Temple", "Find the Chaos Temple", 5, true, 0x1f, bit4(0x63))
// Add Defeat Chaos cheevo (25)

// -----------------------------------------------------------------------------
// COLLECTION

function addCollectChestsAchievement(id, location, chests) {   
    achievement(
        id = id,
        title = format("Treasures of the {0} Area", location),
        description = format("Open every chest in the {0} Area", location),
        points = 10,
        trigger = isGameActive() 
            && sum_of(chests, chest => prev(chest)) + 1 == length(chests)
            && measured(sum_of(chests, chest => chest) == length(chests))
    )
}

ConeriaAreaChests = [
    // Coneria Castle
    bit6(0x060c), bit7(0x060c), bit0(0x060d), bit1(0x060d),
    bit2(0x060d), bit3(0x060d),
    // Matoya's Cave
    bit1(0x062a), bit2(0x062a), bit3(0x062a),
    // Dwarf Cave
    bit5(0x061a), bit6(0x061a), bit7(0x061a), bit0(0x061b),
    bit1(0x061b), bit2(0x061b), bit3(0x061b), bit4(0x061b),
    bit5(0x061b), bit6(0x061b),
]

addCollectChestsAchievement(0, "Coneria", ConeriaAreaChests)

ElflandAreaChests = [
    // Elf Castle
    bit4(0x060d), bit5(0x060d), bit6(0x060d), bit7(0x060d),
    // Ancient Castle
    bit0(0x060e), bit1(0x060e), bit2(0x060e),
    // Marsh Cave
    bit7(0x061b), bit0(0x061c), bit1(0x061c), bit2(0x061c),
    bit6(0x061c), bit7(0x061c), bit0(0x061d), bit1(0x061d),
    bit3(0x061d), bit4(0x061d), bit6(0x061d), bit7(0x061d),
    bit0(0x061e),
]

addCollectChestsAchievement(0, "Elfland", ElflandAreaChests)

MelmondAreaChests = [
    // Titan Cave
    bit7(0x061e), bit0(0x061f), bit1(0x061f), bit2(0x061f),
    // Earth Cave
    bit5(0x060f), bit6(0x060f), bit7(0x060f), bit0(0x0610),
    bit1(0x0610), bit2(0x0610), bit3(0x0610), bit4(0x0610),
    bit5(0x0610), bit6(0x0610), bit7(0x0610), bit0(0x0611),
    bit1(0x0611), bit2(0x0611), bit3(0x0611), bit4(0x0611),
    bit5(0x0611), bit6(0x0611), bit7(0x0611), bit0(0x0612),
    bit1(0x0612), bit3(0x0612), bit4(0x0612), bit5(0x0612),
]

addCollectChestsAchievement(0, "Melmond", MelmondAreaChests)

CrescentLakeAreaChests = [
    // Gurgu Volcano
    bit3(0x061f), bit4(0x061f), bit5(0x061f), bit6(0x061f),
    bit7(0x061f), bit0(0x0620), bit1(0x0620), bit2(0x0620),
    bit3(0x0620), bit4(0x0620), bit5(0x0620), bit6(0x0620),
    bit7(0x0620), bit0(0x0621), bit1(0x0621), bit2(0x0621),
    bit3(0x0620), bit4(0x0621), bit5(0x0621), bit6(0x0621),
    bit7(0x0621), bit0(0x0622), bit1(0x0622), bit2(0x0622),
    bit3(0x0622), bit4(0x0622), bit5(0x0622), bit6(0x0622),
    bit7(0x0622), bit0(0x0623), bit2(0x0623), bit3(0x0623),
    bit6(0x0623),
    // Ice Cavern
    bit0(0x0624), bit1(0x0624), bit2(0x0624), bit3(0x0624),
    bit4(0x0624), bit5(0x0624), bit7(0x0624), bit0(0x0625),
    bit1(0x0625), bit2(0x0625), bit3(0x0625), bit4(0x0625),
    bit5(0x0625), bit6(0x0625), bit7(0x0625),
    
]

addCollectChestsAchievement(0, "Crescent Lake", CrescentLakeAreaChests)

CardiaIslandAreaChests = [
    // Cardia Island
    bit0(0x0619), bit1(0x0619), bit2(0x0619), bit3(0x0619),
    bit4(0x0619), bit5(0x0619), bit6(0x0619), bit7(0x0619),
    bit0(0x061a), bit1(0x061a), bit2(0x061a), bit3(0x061a),
    bit4(0x061a),
    // Ordeal Castle
    bit3(0x060e), bit4(0x060e), bit5(0x060e), bit6(0x060e),
    bit7(0x060e), bit1(0x060f), bit2(0x060f), bit3(0x060f),
]

addCollectChestsAchievement(0, "Cardia Island", CardiaIslandAreaChests)

LufeniaAreaChests = [
    // Mirage Tower
    bit6(0x0616), bit7(0x0616), bit0(0x0617), bit1(0x0617),
    bit2(0x0617), bit3(0x0617), bit4(0x0617), bit5(0x0617),
    bit6(0x0617), bit7(0x0617), bit0(0x0618), bit1(0x0618),
    bit2(0x0618), bit3(0x0618), bit4(0x0618), bit5(0x0618),
    bit6(0x0618), bit7(0x0618),
    // Sky Palace
    bit0(0x0626), bit1(0x0626), bit2(0x0626), bit3(0x0626),
    bit4(0x0626), bit5(0x0626), bit6(0x0626), bit7(0x0626),
    bit0(0x0627), bit1(0x0627), bit2(0x0627), bit3(0x0627),
    bit4(0x0627), bit5(0x0627), bit6(0x0627), bit7(0x0627),
    bit0(0x0628), bit1(0x0628), bit2(0x0628), bit3(0x0628),
    bit4(0x0628), bit5(0x0628), bit6(0x0628), bit7(0x0628),
    bit0(0x0629), bit1(0x0629), bit2(0x0629), bit3(0x0629),
    bit4(0x0629), bit5(0x0629), bit6(0x0629), bit7(0x0629),
    bit0(0x062a),
]

addCollectChestsAchievement(0, "Lufenia", LufeniaAreaChests)

OnracAreaChests = [
    // The Waterfall
    bit1(0x061e), bit2(0x061e), bit3(0x061e), bit4(0x061e),
    bit5(0x061e), bit6(0x061e),
    // The Sunken Temple
    bit0(0x0613), bit1(0x0613), bit2(0x0613), bit3(0x0613),
    bit4(0x0613), bit5(0x0613), bit6(0x0613), bit7(0x0613),
    bit0(0x0614), bit1(0x0614), bit2(0x0614), bit3(0x0614),
    bit4(0x0614), bit5(0x0614), bit6(0x0614), bit7(0x0614),
    bit7(0x0612), bit0(0x0615), bit1(0x0615), bit2(0x0615),
    bit3(0x0615), bit4(0x0615), bit5(0x0615), bit0(0x0616),
    bit1(0x0616), bit2(0x0616), bit3(0x0616), bit4(0x0616),
    bit5(0x0616), bit4(0x062a),
]

addCollectChestsAchievement(0, "Onrac", OnracAreaChests)

TempleOfFiendsAreaChests = [
    // The Temple of Fiends
    bit5(0x062a), bit6(0x062a), bit7(0x062a), bit0(0x062b),
    bit1(0x062b), bit2(0x062b), bit3(0x062b),
]

addCollectChestsAchievement(0, "Temple of Fiends", TempleOfFiendsAreaChests)

// -----------------------------------------------------------------------------
// SIDEQUESTS

addEventFlagAchievement(0, "Class Promotion", "Obtain the class upgrade from King Bahamut", 10, false, 0x54, bit0(0x62f))

addEventFlagAchievement(0, "Excalibur", "Obtain the Excalibur", 10, false, 0x57, bit3(0x630))

achievement(
    id = 0,
    title = "Ultimate Spells",
    description = "Find secret shop with ultimate spells",
    points = 5,
    trigger = isGameActive() && PartyLocation == 0x71
)

achievement(
    id = 0,
    title = "The Sage",
    description = "Fill all spell slots for at least one character",
    points = 10,
    trigger = isGameActive() && (
        none_of(Character1["SPELLS"], spell => spell == 0) ||
        none_of(Character2["SPELLS"], spell => spell == 0) ||
        none_of(Character3["SPELLS"], spell => spell == 0) ||
        none_of(Character4["SPELLS"], spell => spell == 0)
    )
)


achievement(
    id = 0,
    title = "Warmech",
    description = "Defeat Warmech",
    points = 10,
    trigger = prev(bit0(LeftMiddleEnemyStatus)) == 0 && bit0(LeftMiddleEnemyStatus) == 1 
        && EnemyFormation == EnemyFormations["WARMECH"]
)

achievement(
    id = 0,
    title = "Tyrannosaur",
    description = "Defeat Tyrannosaur",
    points = 10,
    trigger = prev(bit0(LeftMiddleEnemyStatus)) == 0 && bit0(LeftMiddleEnemyStatus) == 1 
        && EnemyFormation == EnemyFormations["TYRO"]
)


// -----------------------------------------------------------------------------
// RICH PRESENCE

rich_presence_conditional_display(isMainMenu(), "Player is on title screen")

rich_presence_display(
    "Party of {0} • {1} • {2} • {3} is exploring {4} | 🦶 {5}",
    rich_presence_lookup("Character1 Job", Character1["JOB"], Jobs),
    rich_presence_lookup("Character2 Job", Character2["JOB"], Jobs),
    rich_presence_lookup("Character3 Job", Character3["JOB"], Jobs),
    rich_presence_lookup("Character4 Job", Character4["JOB"], Jobs),
    rich_presence_lookup("Location", PartyLocation, Locations),
    rich_presence_value("Steps", StepsTaken, "VALUE")
)

// -----------------------------------------------------------------------------
// LEADERBOARDS

leaderboard(
    title = "Step Up",
    description = "Finish the game by taking as few steps as possible",
    start = isInBattle() && PartyLocation == 0x27 && EnemyFormation == EnemyFormations["CHAOS"],
    cancel = partyIsDefeated(),
    submit = LeftMiddleEnemyStatus == 0x01,
    value = StepsTaken,
    format= "VALUE",
    lower_is_better = true
)

leaderboard(
    title = "Warmech Killer",
    description = "Defeat as many warmechs as possible without leaving the top floor of the Sky Palace, the party cannot be defeated either.",
    start = StepsTaken > 0 && PartyLocation == 0x60,
    cancel = partyIsDefeated(),
    submit = PartyLocation != 0x60,
    value = measured(tally(0, prev(bit0(LeftMiddleEnemyStatus)) == 0 && bit0(LeftMiddleEnemyStatus) == 1 && EnemyFormation == EnemyFormations["WARMECH"])),
    format= "VALUE",
    lower_is_better = false
)
