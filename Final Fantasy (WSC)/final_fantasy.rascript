// Final Fantasy
// #ID = 15580

// -----------------------------------------------------------------------------
// VARIABLES

BattleMode = byte(0x4cf0)
ScreenID = byte(0x0984)

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

Character1 = {
    "JOB": byte(0x075b),
    "DEATH": bit0(0xc613)
}
Character2 = {
    "JOB": byte(0x07b3),
    "DEATH": bit0(0xc6c3)
}
Character3 = {
    "JOB": byte(0x080b),
    "DEATH": bit0(0xc773)
}
Character4 = {
    "JOB": byte(0x0863),
    "DEATH": bit0(0xc823)
}

LeftMiddleEnemyStatus = byte(0xc8d3)

StepsTaken = dword(0x0741)

EnemyFormation = byte(0x099f)
EnemyFormations = {
    "CHAOS": 0x7b,
    "WARMECH": 0x56,
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
// PROGRESSION

function addEventFlagAchievement(id, title, description, points, location, flag) {
    achievement(
        id = id,
        title = title,
        description = description,
        points = points,
        trigger = prev(flag) == 0 && flag == 1 && PartyLocation == location
    )
}

addEventFlagAchievement(0, "Princess Sara", "Rescue Princess Sara and rebuild the bridge.", 2, 0x39, bit3(0x62c))
addEventFlagAchievement(0, "Ship", "Obtain a ship.", 5, 0x62, bit5(0x62c))
addEventFlagAchievement(0, "Mystic Key", "Find the mystic key.", 3, 0x6, bit1(0x62d))
addEventFlagAchievement(0, "Earth Crystal", "Purify the Earth Crystal.", 10, 0x5, bit1(0x62e))
addEventFlagAchievement(0, "Canoe ", "Obtain a canoe.", 5, 0x2f, bit2(0x62e))
addEventFlagAchievement(0, "Fire Crystal ", "Purify the Fire Crystal.", 10, 0xxx, bit2(xxxx))
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
    value = measured(tally(0, prev(LeftMiddleEnemyStatus) != 0x01 && LeftMiddleEnemyStatus == 0x01 && EnemyFormation == EnemyFormations["WARMECH"])),
    format= "VALUE",
    lower_is_better = false
)
