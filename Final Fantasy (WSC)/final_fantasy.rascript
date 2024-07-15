// Final Fantasy
// #ID = 15580

// -----------------------------------------------------------------------------
// VARIABLES

ScreenID = byte(0x0984)
PartyLocation = byte(0x0602)

Locations = {
    0x00: "Overworld",
    0x01: "Earth Cave",
    0x02: "Earth Cave",
    0x03: "Earth Cave",
    0x04: "Earth Cave",
    0x05: "Earth Cave",
    0x06: "Elfland Castle",
    0x07: "Elfland Village",
    0x08: "Elfland Village",
    0x09: "Elfland Village",
    0x0a: "Elfland Village",
    0x0b: "Elfland Village",
    0x0c: "Elfland Village",
    0x0d: "Elfland Village",
    0x0e: "Elfland Village",
    0x0f: "Elfland Village",
    0x10: "Elfland Village",
    0x11: "Onrac",
    0x12: "Onrac",
    0x13: "Onrac",
    0x14: "Onrac",
    0x15: "Onrac",
    0x16: "Onrac",
    0x17: "Sea Shrine",
    0x18: "Sea Shrine",
    0x19: "Sea Shrine",
    0x1a: "Sea Shrine",
    0x1b: "Sea Shrine",
    0x1c: "Sea Shrine",
    0x1d: "Sea Shrine",
    0x1e: "Sea Shrine",
    0x1f: "Temple of Fiend",
    0x20: "Temple of Fiend",
    0x21: "Temple of Fiend",
    0x22: "Temple of Fiend",
    0x23: "Temple of Fiend",
    0x24: "Temple of Fiend",
    0x25: "Temple of Fiend",
    0x26: "Temple of Fiend",
    0x27: "Temple of Fiend",
    0x28: "Titan Cave",
    0x29: "Vulcano",
    0x2a: "Vulcano",
    0x2b: "Vulcano",
    0x2c: "Vulcano",
    0x2d: "Vulcano",
    0x2e: "Vulcano",
    0x2f: "Crescent Lake",
    0x30: "Crescent Lake",
    0x31: "Crescent Lake",
    0x32: "Crescent Lake",
    0x33: "Crescent Lake",
    0x34: "Crescent Lake",
    0x35: "Crescent Lake",
    0x36: "Crescent Lake",
    0x37: "Sarda Cave",
    0x38: "Corneria Castle",
    0x39: "Corneria Castle",
    0x3a: "Corneria Town",
    0x3b: "Corneria Town",
    0x3c: "Corneria Town",
    0x3d: "Corneria Town",
    0x3e: "Corneria Town",
    0x3f: "Corneria Town",
    0x40: "Corneria Town",
    0x41: "Corneria Town",
    0x42: "Ice Cave",
    0x43: "Ice Cave",
    0x44: "Ice Cave",
    0x45: "Ice Cave",
    0x46: "Ice Cave",
    0x47: "Gaia",
    0x48: "Gaia",
    0x49: "Gaia",
    0x4a: "Gaia",
    0x4b: "Gaia",
    0x4c: "Gaia",
    0x4d: "Ordeal",
    0x4e: "Ordeal",
    0x4f: "Ordeal",
    0x50: "Mirage Tower",
    0x51: "Mirage Tower",
    0x52: "Mirage Tower",
    0x53: "Waterfalf",
    0x54: "Cardia Island",
    0x55: "Cardia Island",
    0x56: "Cardia Island",
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
    0x61: "Matoya Cave",
    0x62: "Pravoka",
    0x63: "Pravoka",
    0x64: "Pravoka",
    0x65: "Pravoka",
    0x66: "Pravoka",
    0x67: "Pravoka",
    0x68: "Pravoka",
    0x69: "Pravoka",
    0x6a: "Melmond",
    0x6b: "Melmond",
    0x6c: "Melmond",
    0x6d: "Melmond",
    0x6e: "Melmond",
    0x6f: "Melmond",
    0x70: "Lefein",
    0x71: "Lefein",
    0x72: "Oasis",
    0x73: "Oasis",
    0x74: "Gaia",
    0x75: "Gaia",
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
    "JOB": byte(0x075b)
}
Character2 = {
    "JOB": byte(0x07b3)
}
Character3 = {
    "JOB": byte(0x080b)
}
Character4 = {
    "JOB": byte(0x0863)
}

StepsTaken = dword(0x0741)

// -----------------------------------------------------------------------------
// FUNCTIONS

function isMainMenu() => ScreenID == 0x03 || ScreenID == 0x04

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
