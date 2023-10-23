// Final Fantasy Chronicles: Final Fantasy IV
// #ID = 17526

// -----------------------------------------------------------------------------
// VARIABLES

TimeInSeconds = dword(0xd16a4)
PositionX = byte(0xd1706)
PositionY = byte(0xd1707)
MainLocation = byte(0xd1700)
SubLocation = word_be(0xd1701)
MenuIndicator = byte(0xd0650)

Character1 = {
    "ID": low4(0xd1040),
    "LV": byte(0xd1042),
}
Character2 = {
    "ID": low4(0xd10c0),
    "LV": byte(0xd10c2),
}
Character3 = {
    "ID": low4(0xd1000),
    "LV": byte(0xd1002),
}
Character4 = {
    "ID": low4(0xd1100),
    "LV": byte(0xd1102),
}
Character5 = {
    "ID": low4(0xd1080),
    "LV": byte(0xd1082),
}

ItemSlots = array_map(range(0xd1440, 0xd149e, 2), itemSlot => byte(itemSlot))

// -----------------------------------------------------------------------------
// FUNCTIONS

function isActiveGame() => PositionX != 0 && PositionY != 0 && MenuIndicator != 0x70

function isDialogMode() => bit0(0xd06b1) == 1

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

achievement(
    id = 0,
    title = "Unwanted Parcel",
    description = "Bring a Bomb Ring to the Village of Mist",
    points = 10,
    trigger = isActiveGame() && SubLocation == 0x001 && all_of(ItemSlots, itemSlot => itemSlot != 0xee)
)

function addEventFlagAchievement(id, title, description, flag) {
    achievement(
        id = id,
        title = title,
        description = description,
        points = 10,
        trigger = isActiveGame() && isDialogMode() && prev(flag) == 0 && flag == 1
    )
}

addEventFlagAchievement(0, "Kingdom In Ruins", "Reach the Damcyan Castle to rescue Anna", bit4(0xd1282))
addEventFlagAchievement(0, "Panacea", "Find the Sand Ruby, the cure for your beloved", bit2(0xd1282))
addEventFlagAchievement(0, "A Monk Not From Shaolin", "Save the Captain of Fabul", bit6(0xd1282))
addEventFlagAchievement(0, "The Dark Knight Departs", "Overcome your fear and become a paladin", bit3(0xd1281))

function addCollectChestsAchievement(id, title, points, chests) {
    achievement(
        id = id,
        title = title,
        description = format("Open every chests in {0}", title),
        points = points,
        trigger = isActiveGame() && sum_of(chests, chest => prev(chest)) != length(chests) 
            && sum_of(chests, chest => chest) == length(chests)
    )
}

MistCaveChests = [
    bit0(0xd12b1),
    bit1(0xd12b1),
    bit2(0xd12b1),
    bit3(0xd12b1),
]

addCollectChestsAchievement(0, "Mist Cave", 2, MistCaveChests)

KaipoChests = [
    bit2(0xd12a1),
]

addCollectChestsAchievement(0, "Kaipo", 1, KaipoChests)

WaterCavernChests = [
    bit4(0xd12b1),
    bit5(0xd12b1),
    bit6(0xd12b1),
    bit7(0xd12b1),
    bit0(0xd12b2),
    bit1(0xd12b2),
    bit2(0xd12b2),
    bit3(0xd12b2),
    bit4(0xd12b2),
    bit5(0xd12b2),
    bit6(0xd12b2),
    bit7(0xd12b2),
    bit0(0xd12b3),
    bit1(0xd12b3),
    bit2(0xd12b3),
    bit3(0xd12b3),
    bit4(0xd12b3),
    bit5(0xd12b3),
    bit6(0xd12b3),
    bit7(0xd12b3),
    bit2(0xd12b6),
    bit3(0xd12b6),
    bit4(0xd12b6),
]

addCollectChestsAchievement(0, "Water Cavern", 10, WaterCavernChests)

DamcyanChests = [
    bit7(0xd12a7),
    bit0(0xd12a8),
    bit1(0xd12a8),
    bit2(0xd12a8),
    bit3(0xd12a8),
    bit4(0xd12a8),
    bit5(0xd12a8),
    bit6(0xd12a8),
    bit7(0xd12a8),
    bit0(0xd12a9),
    bit1(0xd12a9),
    bit2(0xd12a9),
    bit3(0xd12a9),
]

addCollectChestsAchievement(0, "Damcyan", 5, DamcyanChests)

AntlionsCaveChests = [
    bit0(0xd12b4),
    bit1(0xd12b4),
    bit2(0xd12b4),
    bit3(0xd12b4),
    bit4(0xd12b4),
    bit5(0xd12b4),
    bit6(0xd12b4),
    bit7(0xd12b4),
    bit0(0xd12b5),
    bit1(0xd12b5),
    bit2(0xd12b5),
    bit3(0xd12b5),
    bit4(0xd12b5),
]

addCollectChestsAchievement(0, "Antlion's Cave", 3, AntlionsCaveChests)

MountHobsChests = [
    bit5(0xd12b5),
    bit6(0xd12b5),
    bit7(0xd12b5),
    bit0(0xd12b6),
    bit1(0xd12b6),
]

addCollectChestsAchievement(0, "Mt Hobs", 2, MountHobsChests)

FabulChests = [
    bit5(0xd12a9),
    bit6(0xd12a9),
    bit7(0xd12a9),
    bit0(0xd12aa),
    bit1(0xd12aa),
    bit2(0xd12aa),
    bit3(0xd12aa),
    bit4(0xd12aa),
    bit5(0xd12aa),
    bit6(0xd12aa),
]

addCollectChestsAchievement(0, "Fabul", 5, FabulChests)

MountOrdealsChests = [
    bit5(0xd12b6),
    bit6(0xd12b6),
    bit7(0xd12b6),
    bit0(0xd12b7),
]

addCollectChestsAchievement(0, "Mt. Ordeals", 2, MountOrdealsChests)

// TODO - MUST BE TESTED

BaronCastleChests = [
    bit2(0xd12a4),
    bit3(0xd12a4),
    bit4(0xd12a4),
    bit5(0xd12a4),
    bit6(0xd12a4),
    bit7(0xd12a4),
    bit0(0xd12a5),
    bit1(0xd12a5),
    bit2(0xd12a5),
    bit3(0xd12a5),
    bit4(0xd12a5),
    bit5(0xd12a5),
    bit6(0xd12a5),
    bit7(0xd12a5),
    bit0(0xd12a6),
    bit1(0xd12a6),
    bit2(0xd12a6),
    bit3(0xd12a6),
    bit4(0xd12a6),
    bit5(0xd12a6),
    bit6(0xd12a6),
]

addCollectChestsAchievement(0, "Baron Castle", 10, BaronCastleChests)

BaronChests = [
    bit3(0xd12a2),
    bit4(0xd12a2),
    bit5(0xd12a2),
    bit6(0xd12a2),
    bit7(0xd12a2),
    bit0(0xd12a3),
    bit1(0xd12a3),
    bit2(0xd12a3),
    // TODO (14)
]

addCollectChestsAchievement(0, "Baron", 10, BaronChests)

AncientWaterwayChests = [
    bit7(0xd12a6),
    bit0(0xd12a7),
    bit1(0xd12a7),
    bit2(0xd12a7),
    bit3(0xd12a7),
    bit4(0xd12a7),
    bit5(0xd12a7),
    bit6(0xd12a7),
    bit4(0xd12a9),
]

addCollectChestsAchievement(0, "Ancient Waterway", 5, AncientWaterwayChests)

MistVillageChests = [
    bit0(0xd12a1),
    bit1(0xd12a1),
    // TODO
]

addCollectChestsAchievement(0, "Mist Village", 10, MistVillageChests)

MythrilChests = [
    bit3(0xd12a1),
    bit4(0xd12a1),
    bit5(0xd12a1),
]

addCollectChestsAchievement(0, "Mythril", 3, MythrilChests)

TroiaChests = [
    bit6(0xd12a1),
    bit7(0xd12a1),
    bit0(0xd12a2),
    bit1(0xd12a2),
]

addCollectChestsAchievement(0, "Troia", 2, TroiaChests)

TroiaCastleChests = [
    bit7(0xd12aa),
    // TODO
]

addCollectChestsAchievement(0, "Troia Castle", 5, TroiaCastleChests)

MagneticCaveChests = [
    bit1(0xd12b7),
    bit2(0xd12b7),
    bit3(0xd12b7),
    bit4(0xd12b7),
    bit5(0xd12b7),
    bit6(0xd12b7),
    bit7(0xd12b7),
    bit0(0xd12b8),
    bit1(0xd12b8),
    bit2(0xd12b8),
]

addCollectChestsAchievement(0, "Magnetic Cave", 5, MagneticCaveChests)

TowerOfZotChests = [
    bit3(0xd12b8),
    bit4(0xd12b8),
    bit5(0xd12b8),
    bit6(0xd12b8),
    bit7(0xd12b8),
    bit0(0xd12b9),
]

addCollectChestsAchievement(0, "Tower Of Zot [m]", 5, TowerOfZotChests)

EblanCastleChests = [
    // TODO
]

addCollectChestsAchievement(0, "Eblan Castle", 10, EblanCastleChests)

AgartChests = [
    bit2(0xd12a2),
]

addCollectChestsAchievement(0, "Agart", 1, AgartChests)

DwarvenCastleChests = [
    bit2(0xd12c1),
    bit3(0xd12c1),
    bit4(0xd12c1),
    bit5(0xd12c1),
    bit6(0xd12c1),
    bit7(0xd12c1),
    bit0(0xd12c2),
    bit1(0xd12c2),
    bit6(0xd12c2),
    bit7(0xd12c2),
    bit0(0xd12c3),
    bit1(0xd12c3),
    bit2(0xd12c3),
    bit3(0xd12c3),
    bit4(0xd12c3),
    bit5(0xd12c3),
    bit6(0xd12c3),
    bit7(0xd12c3),
]

addCollectChestsAchievement(0, "Dwarven Castle", 5, DwarvenCastleChests)

TowerOfBabilChests = [
    bit1(0xd12b9),
    bit2(0xd12b9),
    bit3(0xd12b9),
    bit4(0xd12b9),
    bit5(0xd12b9),
    bit6(0xd12b9),
    // TODO
]

addCollectChestsAchievement(0, "Tower Of Babil [m]", 10, TowerOfBabilChests)

CaveEblanChests = [
    // TODO
]

addCollectChestsAchievement(0, "Cave Eblan [m]", 5, CaveEblanChests)

KokkolsForgeChests = [
    // TODO
]

addCollectChestsAchievement(0, "Kokkol's Forge", 2, KokkolsForgeChests)

TomraChests = [
    bit0(0xd12c1),
    bit1(0xd12c1),
    // TODO
]

addCollectChestsAchievement(0, "Tomra", 3, TomraChests)

EidolonsCaveChests = [
    // TODO
]

addCollectChestsAchievement(0, "Eidolon's Cave", 5, EidolonsCaveChests)

SylphCaveChests = [
    // TODO
]

addCollectChestsAchievement(0, "Sylph Cave", 10, SylphCaveChests)

SealedCaveChests = [
    // TODO
]

addCollectChestsAchievement(0, "Sealed Cave", 5, SealedCaveChests)

LunarPathChests = [
    // TODO
]

addCollectChestsAchievement(0, "Lunar Path", 1, LunarPathChests)

GiantOfBabilChests = [
    // TODO
]

addCollectChestsAchievement(0, "Giant of Babil [m]", 3, GiantOfBabilChests)

CaveOfBahamutChests = [
    // TODO
]

addCollectChestsAchievement(0, "Cave of Bahamut", 2, CaveOfBahamutChests)

LunarSubterraneChests = [
    // TODO
]

addCollectChestsAchievement(0, "Lunar Subterrane", 10, LunarSubterraneChests)

ChocoboForestsChests = [
    // TODO
]

addCollectChestsAchievement(0, "Chocobo Forests", 10, ChocoboForestsChests)

// -----------------------------------------------------------------------------
// RICH PRESENCE

MainLocations = {
    0x00: "Overworld",
    0x01: "Underworld",
    0x02: "Moon",
    0x03: "Submap",
}

SubLocations = {
    0x000: "Baron",
    0x001: "Mist",
    0x002: "Kaipo",
    0x003: "Mysidia",
    0x004: "Mythril",
    0x005: "Troia",
    0x006: "Agart",
    0x007: "Troia",
    0x008: "Troia",
    0x009: "Troia",
    0x00a: "Troia",
    0x00b: "Baron",
    0x00c: "Baron",
    0x00d: "Baron",
    0x00e: "Baron",
    0x00f: "Mist",
    0x010: "Kaipo",
    0x011: "Kaipo",
    0x012: "Kaipo",
    0x013: "Mysidia",
    0x014: "Mysidia",
    0x015: "Paladin's Room",
    0x016: "Mysidia",
    0x017: "Mysidia",
    0x018: "Troia",
    0x019: "Troia",
    0x01a: "Court of Kings",
    0x01c: "Black Chocobo Ranch",
    0x01d: "Black Chocobo Ranch",
    0x01e: "Astro Tower",
    0x01f: "Agart",
    0x020: "Agart",
    0x021: "Chocobo Village",
    0x024: "Baron Castle",
    0x025: "Damcyan Castle",
    0x026: "Fabul",
    0x027: "Troia Castle",
    0x028: "Eblan Castle",
    0x02a: "Baron Castle",
    0x02b: "Baron Castle",
    0x02c: "Baron Castle",
    0x02d: "Baron Castle",
    0x02e: "Baron Castle",
    0x02f: "Baron Castle",
    0x030: "Baron Castle",
    0x031: "Baron Castle",
    0x032: "Baron Castle",
    0x033: "Baron Castle",
    0x034: "Baron Castle",
    0x035: "Baron Castle",
    0x036: "Baron Castle",
    0x037: "Baron Castle",
    0x038: "Baron Castle",
    0x03a: "Water Cavern",
    0x03b: "Water Cavern",
    0x03c: "Water Cavern",
    0x03d: "Water Cavern",
    0x03e: "Water Cavern",
    0x03f: "Damcyan Castle",
    0x040: "Damcyan Castle",
    0x041: "Damcyan Castle",
    0x042: "Damcyan Castle",
    0x043: "Damcyan Castle",
    0x044: "Ancient Waterway",
    0x045: "Agart",
    0x046: "Agart",
    0x047: "Fabul",
    0x048: "Fabul",
    0x049: "Fabul",
    0x04a: "Fabul",
    0x04b: "Fabul",
    0x04c: "Fabul",
    0x04d: "Fabul",
    0x04e: "Fabul",
    0x04f: "Fabul",
    0x050: "Fabul",
    0x051: "Fabul",
    0x052: "Fabul",
    0x053: "Mist",
    0x054: "Water Cavern",
    0x055: "Troia",
    0x059: "Troia",
    0x05a: "Troia",
    0x05b: "Troia",
    0x05c: "Troia",
    0x05d: "Troia",
    0x05e: "Eblan",
    0x05f: "Eblan",
    0x060: "Eblan",
    0x061: "Eblan",
    0x062: "Eblan",
    0x063: "Eblan",
    0x064: "Eblan",
    0x065: "Eblan",
    0x066: "Baron Castle",
    0x067: "Baron Castle",
    0x068: "Mysidia",
    0x069: "Devil's Road",
    0x06a: "Water Cavern",
    0x06c: "Mist Cave",
    0x06f: "Water Cavern",
    0x070: "Water Cavern",
    0x071: "Water Cavern",
    0x072: "Water Cavern",
    0x073: "Water Cavern",
    0x074: "Water Cavern",
    0x075: "Water Cavern",
    0x076: "Water Cavern",
    0x077: "Antlion's Cave",
    0x078: "Antlion's Cave",
    0x079: "Antlion's Cave",
    0x07a: "Antlion's Cave",
    0x07b: "Antlion's Cave",
    0x07c: "Moon observation",
    0x07e: "Mt. Hobs",
    0x07f: "Mt. Hobs",
    0x080: "Mt. Hobs",
    0x081: "Mt. Hobs",
    0x083: "Water Cavern",
    0x084: "Mt. Ordeals",
    0x085: "Mt. Ordeals",
    0x086: "Mt. Ordeals",
    0x087: "Mt. Ordeals",
    0x088: "Mysidia",
    0x089: "Baron Castle",
    0x08a: "Baron Castle",
    0x08c: "Magnetic Cave",
    0x08d: "Magnetic Cave",
    0x08e: "Magnetic Cave",
    0x08f: "Magnetic Cave",
    0x090: "Magnetic Cave",
    0x091: "Magnetic Cave",
    0x092: "Magnetic Cave",
    0x093: "Magnetic Cave",
    0x097: "Devil's Road",
    0x098: "Tower of Zot",
    0x099: "Tower of Zot",
    0x09a: "Tower of Zot",
    0x09c: "Tower of Zot",
    0x09d: "Tower of Zot",
    0x09e: "Tower od Zot",
    0x09f: "Tower of Zot",
    0x0a0: "Adamant Grotto",
    0x0a1: "Magnetic Cave",
    0x0a2: "Tower of Zot",
    0x0a6: "Tower of Babil",
    0x0a7: "Tower of Babil",
    0x0a8: "Tower of Babil",
    0x0a9: "Tower of Babil",
    0x0aa: "Tower of Babil",
    0x0ac: "Tower of Babil",
    0x0b5: "Giant of Babil",
    0x0b6: "Giant of Babil",
    0x0b7: "Giant of Babil",
    0x0b9: "Giant of Babil",
    0x0ba: "Giant of Babil",
    0x0bc: "Giant of Babil",
    0x0bd: "Giant of Babil",
    0x0c0: "Red Wings Airship",
    0x0c1: "Fabul",
    0x0c2: "Overworld",
    0x0c3: "Enterprise",
    0x0c7: "Cave Eblan",
    0x0c8: "Cave Eblan",
    0x0c9: "Babil Passage",
    0x0ca: "Babil Passage",
    0x0cb: "Eblan Cae",
    0x0cc: "Eblan Cave",
    0x0cd: "Eblan Cave",
    0x0ce: "Eblan Cave",
    0x0cf: "Fabul",
    0x0d1: "Chocobo Forest",
    0x0d2: "Chocobo Forest",
    0x0d3: "Chocobo Forest",
    0x0d4: "Chocobo Forest",
    0x0d5: "Baron",
    0x0e0: "Mist",
    0x0e1: "Mist",
    0x0e2: "Mist",
    0x0e3: "Kaipo",
    0x0e4: "Kaipo",
    0x0e5: "Mysidia",
    0x0e6: "Mysidia",
    0x0e7: "Mysidia",
    0x0e8: "Mythril",
    0x0e9: "Mythril",
    0x0ea: "Mythril",
    0x0eb: "Mythril",
    0x0ec: "Baron",
    0x100: "Kokkol's Forge",
    0x101: "Tomra Village",
    0x102: "Kokkol's Forge",
    0x103: "Kokkol's Forge",
    0x104: "Tomra Village",
    0x105: "Tomra Village",
    0x106: "Tomra Village",
    0x107: "Dwarven Castle",
    0x108: "Dwarven Castle",
    0x109: "Dwarven Castle",
    0x10a: "Dwarven Castle",
    0x10b: "Dwarven Castle",
    0x10d: "Dwarven Castle",
    0x10e: "Dwarven Castle",
    0x10f: "Dwarven Castle",
    0x110: "Dwarven Castle",
    0x111: "Dwarven Castle",
    0x112: "Dwarven Castle",
    0x113: "Dwarven Castle",
    0x114: "Tower of Babil",
    0x115: "Tower of Babil",
    0x116: "Tower of Babil",
    0x117: "Tower of Babil",
    0x118: "Tower of Babil",
    0x119: "Dwarven Castle",
    0x11a: "Dwarven Castle",
    0x11b: "Dwarven Castle",
    0x11d: "Tower of Babil",
    0x11e: "Tower of Babil",
    0x11f: "Tower of Babil",
    0x120: "Dwarven Castle",
    0x121: "Tower of Babil",
    0x122: "Tower of Babil",
    0x123: "Tower of Babil",
    0x124: "Tower of Babil",
    0x125: "Tower of Babil",
    0x126: "Tower of Babil",
    0x127: "Tower of Babil",
    0x128: "Tower of Babil",
    0x129: "Developer's Room",
    0x12b: "Developer's Room",
    0x12d: "Super Cannon Room",
    0x12f: "Lunar Whale",
    0x132: "Tomra",
    0x136: "Eidolon Cave",
    0x137: "Eidolon Cave",
    0x138: "Eidolon Cave",
    0x13a: "Eidolon Cave",
    0x13b: "Eidolon Cave",
    0x13c: "Feymarch",
    0x13d: "Feymarch",
    0x13e: "Feymarch",
    0x13f: "Feymarch",
    0x140: "Feymarch",
    0x141: "Feymarch",
    0x142: "Feymarch",
    0x143: "Feymarch",
    0x144: "Sealed Cave",
    0x145: "Sylph Cave",
    0x146: "Sylph Cave",
    0x147: "Sylph Cave",
    0x148: "Sylph Cave",
    0x149: "Sylph House",
    0x14a: "Sealed Cave",
    0x14b: "Sealed Cave",
    0x14c: "Sealed Cave",
    0x14d: "Sealed Cave",
    0x14e: "Sealed Cave",
    0x14f: "Sealed Cave",
    0x150: "Sealed Cave",
    0x151: "Sealed Cave",
    0x152: "Sealed Cave",
    0x153: "Sealed Cave",
    0x154: "Sealed Cave",
    0x155: "Sealed Cave",
    0x156: "Sealed Cave",
    0x157: "Sealed Cave",
    0x158: "Sealed Cave",
    0x159: "Sealed Cave",
    0x15a: "Cave of Bahamut",
    0x15b: "Cave of Bahamut",
    0x15c: "Cave of Bahamut",
    0x160: "Crystal Palace",
    0x161: "Crystal Palace",
    0x163: "Lunar Path",
    0x164: "Lunar Path",
    0x165: "Hummingway Home",
    0x167: "Lunar Subterrane",
    0x168: "Lunar Subterrane",
    0x169: "Lunar Subterrane",
    0x16a: "Lunar Subterrane",
    0x16b: "Lunar Subterrane",
    0x16c: "Lunar Subterrane",
    0x16d: "Lunar Subterrane",
    0x16e: "Lunar Subterrane",
    0x16f: "Lunar Subterrane",
    0x170: "Lunar Subterrane",
    0x171: "Lunar Subterrane",
    0x172: "Lunar Subterrane",
    0x173: "Lunar Subterrane",
    0x174: "Lunar Subterrane",
    0x175: "Lunar Subterrane",
    0x176: "Lunar Subterrane",
    0x177: "Lunar Subterrane",
    0x179: "Lunar Subterrane",
    0x17a: "Lunar Subterrane",
    0x17b: "Lunar Subterrane",
    0x17c: "Lunar Subterrane",
}

Characters = {
    0x00: "_ _ _",
    0x01: "Cecil",
    0x02: "Kain",
    0x03: "Rydia",
    0x04: "Tellah",
    0x05: "Edward",
    0x06: "Rosa",
    0x07: "Yang",
    0x08: "Palom",
    0x09: "Porom",
    0x0a: "Tellah",
    0x0b: "Cecil",
    0x0c: "Tellah",
    0x0d: "Yang",
    0x0e: "Cid",
    0x0f: "Kain",
}

rich_presence_conditional_display(!isActiveGame(), "Player is on title screen")

rich_presence_conditional_display(MainLocation == 0x03,
    "Party of {0} LV: {1} • {2} LV: {3} • {4} LV: {5} • {6} LV: {7} • {8} LV: {9} is exploring {10} | {11}",
    rich_presence_lookup("Character1 ID", Character1["ID"], Characters),
    rich_presence_value("Character1 LVL", Character1["LV"]),
    rich_presence_lookup("Character2 ID", Character2["ID"], Characters),
    rich_presence_value("Character2 LVL", Character2["LV"]),
    rich_presence_lookup("Character3 ID", Character3["ID"], Characters),
    rich_presence_value("Character3 LVL", Character3["LV"]),
    rich_presence_lookup("Character4 ID", Character4["ID"], Characters),
    rich_presence_value("Character4 LVL", Character4["LV"]),
    rich_presence_lookup("Character5 ID", Character5["ID"], Characters),
    rich_presence_value("Character5 LVL", Character5["LV"]),
    rich_presence_lookup("SubLocation", SubLocation, SubLocations, "???????????????????????????????????????????????????????????????????"),
    rich_presence_value("Time", TimeInSeconds, "SECS_AS_MINS")
)

rich_presence_display(
    "Party of {0} LV: {1} • {2} LV: {3} • {4} LV: {5} • {6} LV: {7} • {8} LV: {9} is exploring the {10} | {11}",
    rich_presence_lookup("Character1 ID", Character1["ID"], Characters),
    rich_presence_value("Character1 LVL", Character1["LV"]),
    rich_presence_lookup("Character2 ID", Character2["ID"], Characters),
    rich_presence_value("Character2 LVL", Character2["LV"]),
    rich_presence_lookup("Character3 ID", Character3["ID"], Characters),
    rich_presence_value("Character3 LVL", Character3["LV"]),
    rich_presence_lookup("Character4 ID", Character4["ID"], Characters),
    rich_presence_value("Character4 LVL", Character4["LV"]),
    rich_presence_lookup("Character5 ID", Character5["ID"], Characters),
    rich_presence_value("Character5 LVL", Character5["LV"]),
    rich_presence_lookup("MainLocation", MainLocation, MainLocations),
    rich_presence_value("Time", TimeInSeconds, "SECS_AS_MINS")
)
