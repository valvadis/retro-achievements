// Final Fantasy Chronicles: Final Fantasy IV
// #ID = 17526

// -----------------------------------------------------------------------------
// VARIABLES

PositionX = byte(0xd1706)
PositionY = byte(0xd1707)
MainLocation = byte(0xd1700)
SubLocation = word_be(0xd1701)
MenuIndicator = byte(0xd0650)
BattleMode = bit0(0xd16be)
BattleSpeed = byte(0xd16ac)
BattleCommand = byte(0xd4ad1)
BattleAttack = byte(0xd4ad2)

CHARACTER_POINTER_1 = 0xd4483
CHARACTER_POINTER_2 = 0xd4583
CHARACTER_POINTER_3 = 0xd4403
CHARACTER_POINTER_4 = 0xd4603
CHARACTER_POINTER_5 = 0xd4503

EnemyFormation = word(0xd1800)

MIST_DRAGON = "Dragon Mist"
OCTOMAMM = "Octomamm"
ANTLION = "Antlion"
MOM_BOMB = "Mom Bomb"
MILON = "Milon"
MILON_Z = "Milon Zombie"
BAIGAN = "Captain Baigan"
CAGNAZZO = "Cagnazzo"
DARK_ELF = "Dark Elf"
SISTERS = "the Magus Sisters"
VALVALIS = "Valvalis"
CALBRINA = "Calbrina"
LUGABORG = "Lugaborg"
RUBICANT = "Rubicant"
EVIL_WALL = "the Evil Wall"
FOUR_FIENDS = "the Four Fiends"
CPU = "CPU"
ZEROMUS = "Zeromus"

EnemyFormations = {
    MIST_DRAGON: 0xde,
    OCTOMAMM: 0xdf,
    ANTLION: 0xe0,
    MOM_BOMB: 0xe1,
    MILON: 0xe2,
    MILON_Z: 0xe3,
    BAIGAN: 0xe4,
    CAGNAZZO: 0xe5,
    DARK_ELF: 0xe7,
    SISTERS: 0xe8,
    VALVALIS: 0xea,
    CALBRINA: 0x1a7,
    LUGABORG: 0x1b5,
    RUBICANT: 0xff,
    EVIL_WALL: 0x1af,
    FOUR_FIENDS: 0xdc,
    CPU: 0xdd,
    ZEROMUS: 0x1b7
}

FIRST_SUMMON_ID = 0xd15c0
LAST_SUMMON_ID = 0xd15d7

SummonSlots = array_map(range(FIRST_SUMMON_ID, LAST_SUMMON_ID), summonSlot => byte(summonSlot))

SYLPH = "Sylph"
ODIN = "Odin"
LEVIATHAN = "Leviathan"
ASURA = "Asura"
BAHAMUT = "Bahamut"

Summons = {
    SYLPH: 0x3b,
    ODIN: 0x3c,
    LEVIATHAN: 0x3d,
    ASURA: 0x3e,
    BAHAMUT: 0x3f,
}

FIRST_ITEM_ID = 0xd1440
LAST_ITEM_ID = 0xd149e

ItemSlots = array_map(range(FIRST_ITEM_ID, LAST_ITEM_ID, 2), itemSlot => byte(itemSlot))

FIRST_BATTLE_ITEM_ID = 0xd561b
LAST_BATTLE_ITEM_ID = 0xd56d6

BattleItemSlots = array_map(range(FIRST_BATTLE_ITEM_ID, LAST_BATTLE_ITEM_ID, 4), itemSlot => byte(itemSlot))

// -----------------------------------------------------------------------------
// FUNCTIONS

function isActiveGame() => MenuIndicator == 0 && PositionX + PositionY > 0

function isInDialog() => bit0(0xd06b1) == 1

function isInBattle() => bit0(0xd0140) == 1

function isBattleStarted() => prev(bit0(0xd0140)) == 0 && bit0(0xd0140) == 1

function isBattleChallengeOn() => BattleMode == 1 && BattleSpeed == 0

function isBattleWon() => prev(bit5(0xd00a8)) == 0 && bit5(0xd00a8) == 1

function pauseWhenItemIsUsed() => disable_when(BattleCommand == 1, isBattleStarted())

function pauseWhenMagicIsUsed() => disable_when(BattleCommand == 2, isBattleStarted())

function pauseWhenCharacterIsFainted(pointer) {
    disable_when(
        byte(pointer + 0x11) > 0 && (bit6(pointer) == 1 || bit7(pointer) == 1),
        isBattleStarted()
    )
}

// -----------------------------------------------------------------------------
// PROGRESSION

function addEventFlagAchievement(id, title, description, flag) {
    achievement(
        id = id,
        title = title,
        description = description,
        points = 10,
        trigger = isInDialog() && prev(flag) == 0 && flag == 1
    )
}

addEventFlagAchievement(370684, "Unwanted Parcel", "Bring a parcel to the village of Mist", bit6(0xd1281))
addEventFlagAchievement(370685, "Kingdom in Ruins", "Reach the Damcyan Castle to rescue Anna", bit4(0xd1282))
addEventFlagAchievement(370686, "Panacea", "Find the Sand Ruby, the cure for your beloved", bit2(0xd1282))
addEventFlagAchievement(370687, "A Monk Not from Shaolin", "Save the captain of Fabul from monsters", bit6(0xd1282))
addEventFlagAchievement(370688, "The Dark Knight Departs", "Overcome your fear and become a Paladin", bit3(0xd1281))
addEventFlagAchievement(370689, "The False King", "Expose the false king of Baron and escape from Baron", bit6(0xd1280))
addEventFlagAchievement(370690, "Swan Song", "Reclaim the Earth Crystal with a little help", bit3(0xd1284))
addEventFlagAchievement(370691, "Where Am I?", "Save Rosa in the Tower of Zot", bit4(0xd1281))
addEventFlagAchievement(370692, "Thing T. Thing", "Defeat Golbez in Dwarven Castle", bit7(0xd1280))
addEventFlagAchievement(370693, "The Sacrifice", "Escape from the Tower of Babil", bit2(0xd1281))
addEventFlagAchievement(370694, "It Is a Trap", "Defeat Rubicant and try to take Crystals", bit7(0xd1286))
addEventFlagAchievement(370695, "Betrayal", "Exit the Sealed Cave with the Crystal", bit2(0xd1288))
addEventFlagAchievement(370696, "Fatal Error", "Return to the Moon after destroying the Giant of Babil", bit0(0xd1289))

achievement(
    id = 370697,
    title = "Eternal Dream",
    description = "Defeat the final boss and beat the game",
    points = 25,
    trigger = isInBattle() && SubLocation == 0x172 
    && EnemyFormation == EnemyFormations[ZEROMUS] && isBattleWon()
)

// -----------------------------------------------------------------------------
// CHALLENGES

achievement(
    id = 370698,
    title = "Mist's Last Stand [m]",
    description = "Defeat Dragon Mist (without triggering Cold Mist)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x06c && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[MIST_DRAGON]
        && disable_when(BattleAttack == 0x74, isBattleStarted()) // COLD MIST
)

achievement(
    id = 370699,
    title = "Eight Times as Dangerous [m]",
    description = "Defeat Octomamm (no items)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x076 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[OCTOMAMM]
        && pauseWhenItemIsUsed()
)

achievement(
    id = 370700,
    title = "Antidote Secured [m]",
    description = "Defeat Antlion (no counter attacks)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x079 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[ANTLION]
        && disable_when(BattleAttack == 0xa8, isBattleStarted()) // COUNTER
)

achievement(
    id = 370701,
    title = "The Mother of All Bombs [m]",
    description = "Defeat Mom Bomb (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x07f && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[MOM_BOMB]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370702,
    title = "Blighted Despot [m]",
    description = "Defeat Milon (no magic)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x087 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[MILON]
        && pauseWhenMagicIsUsed()
)

achievement(
    id = 370703,
    title = "And Now Stay Dead! [m]",
    description = "Defeat Milon Zombie (no items)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x087 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[MILON_Z]
        && pauseWhenItemIsUsed()
)

achievement(
    id = 370704,
    title = "Double Agent [m]",
    description = "Defeat Captain Baigan (Active Mode, Speed 1)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x02a && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[BAIGAN]
        && isBattleChallengeOn()
)

achievement(
    id = 370705,
    title = "The Drowned King [m]",
    description = "Defeat Cagnazzo (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x02c && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[CAGNAZZO]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370706,
    title = "Thank You Spoony Bard! [m]",
    description = "Defeat Dark Elf (Active Mode, Speed 1)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x094 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[DARK_ELF]
        && isBattleChallengeOn()
)


achievement(
    id = 370707,
    title = "Delta Attack [m]",
    description = "Defeat the Magus Sisters (no magic)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x09d && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[SISTERS]
        && pauseWhenMagicIsUsed()
)

achievement(
    id = 370708,
    title = "Empress of the Winds [m]",
    description = "Defeat Valvalis (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x09f && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[VALVALIS]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370709,
    title = "Dangerous Doll [m]",
    description = "Defeat Calbrina (no items)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x10d && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[CALBRINA]
        && pauseWhenItemIsUsed()
)

achievement(
    id = 370710,
    title = "Mad Scientist [m]",
    description = "Defeat Lugaborg (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0x128 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[LUGABORG]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370711,
    title = "Autarch of Flame [m]",
    description = "Defeat Rubicant (no items)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0xac && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[RUBICANT]
        && pauseWhenItemIsUsed()
)

achievement(
    id = 370712,
    title = "Wait... Walls Shouldn't Move! [m]",
    description = "Defeat the Evil Wall (no death, Active Mode, Speed 1)",
    points = 25,
    trigger = isInBattle() && SubLocation == 0x157 && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[EVIL_WALL]
        && isBattleChallengeOn()
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370713,
    title = "Four Fiends of the Elements [m]",
    description = "Defeat the Four Fiends (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0xbc && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[FOUR_FIENDS]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370714,
    title = "Giant's Weak Point [m]",
    description = "Defeat CPU (no death)",
    points = 10,
    trigger = isInBattle() && SubLocation == 0xbd && trigger_when(isBattleWon())
        && EnemyFormation == EnemyFormations[CPU]
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_1)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_2)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_3)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_4)
        && pauseWhenCharacterIsFainted(CHARACTER_POINTER_5)
)

achievement(
    id = 370715,
    title = "Zemus' Unbridled Hate",
    description = "Defeat Zeromus (all party members must be alive at the end)",
    points = 10,
    trigger = isInBattle() && trigger_when(isBattleWon())
            && SubLocation == 0x172 && EnemyFormation == EnemyFormations[ZEROMUS]
            && unless(
                bit7(CHARACTER_POINTER_1) == 1
                || bit7(CHARACTER_POINTER_2) == 1
                || bit7(CHARACTER_POINTER_3) == 1
                || bit7(CHARACTER_POINTER_4) == 1
                || bit7(CHARACTER_POINTER_5) == 1
            )
)

// -----------------------------------------------------------------------------
// COLLECTION

function addCollectChestsAchievement(id, location, points, chests, missable = false) {
    title = format("Treasures of {0}", location)
    
    if (missable == true) {
        title = title + " [m]"
    }
    
    achievement(
        id = id,
        title = title,
        description = format("Open every chest in {0}", location),
        points = points,
        trigger = isActiveGame() && sum_of(chests, chest => prev(chest)) != length(chests) 
            && measured(sum_of(chests, chest => chest) == length(chests))
    )
}

MistCaveChests = [
    bit0(0xd12b1),
    bit1(0xd12b1),
    bit2(0xd12b1),
    bit3(0xd12b1),
]

addCollectChestsAchievement(370716, "the Mist Cave", 2, MistCaveChests)

WaterCavernChests = [
    bit2(0xd12a1), // KAIPO
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

addCollectChestsAchievement(370718, "Kaipo and the Water Cavern", 10, WaterCavernChests)

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

addCollectChestsAchievement(370719, "Damcyan", 5, DamcyanChests)

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

addCollectChestsAchievement(370720, "Antlion's Cave", 3, AntlionsCaveChests)

MountHobsChests = [
    bit5(0xd12b5),
    bit6(0xd12b5),
    bit7(0xd12b5),
    bit0(0xd12b6),
    bit1(0xd12b6),
]

addCollectChestsAchievement(370721, "Mt. Hobs", 2, MountHobsChests)

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

addCollectChestsAchievement(370722, "Fabul", 5, FabulChests)

MountOrdealsChests = [
    bit5(0xd12b6),
    bit6(0xd12b6),
    bit7(0xd12b6),
    bit0(0xd12b7),
]

addCollectChestsAchievement(370723, "Mt. Ordeals", 2, MountOrdealsChests)

WaterwayChests = [
    bit7(0xd12a6),
    bit0(0xd12a7),
    bit1(0xd12a7),
    bit2(0xd12a7),
    bit3(0xd12a7),
    bit4(0xd12a7),
    bit5(0xd12a7),
    bit6(0xd12a7),
]

addCollectChestsAchievement(370724, "the Waterway", 5, WaterwayChests)

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
    bit2(0xd12a6),
    bit3(0xd12a6),
    bit4(0xd12a6),
    bit5(0xd12a6),
    bit6(0xd12a6),
]

addCollectChestsAchievement(370725, "Baron Castle", 10, BaronCastleChests)

BaronChests = [
    bit0(0xd12a0),
    bit1(0xd12a0),
    bit2(0xd12a0),
    bit3(0xd12a0),
    bit4(0xd12a0),
    bit5(0xd12a0),
    bit6(0xd12a0),
    bit3(0xd12a2),
    bit4(0xd12a2),
    bit5(0xd12a2),
    bit6(0xd12a2),
    bit7(0xd12a2),
    bit0(0xd12a3),
    bit1(0xd12a3),
    bit2(0xd12a3),
    bit4(0xd12a9),
]

addCollectChestsAchievement(370726, "Baron", 10, BaronChests)

MistVillageChests = [
    bit7(0xd12a0),
    bit0(0xd12a1),
    bit1(0xd12a1),
    bit3(0xd12a3),
    bit4(0xd12a3),
    bit5(0xd12a3),
    bit6(0xd12a3),
]

addCollectChestsAchievement(370727, "Mist Village", 10, MistVillageChests)

AgartAndMythrilChests = [
    bit2(0xd12a2), // AGART
    bit3(0xd12a1),
    bit4(0xd12a1),
    bit5(0xd12a1),
]

addCollectChestsAchievement(370729, "Agart and Mythril", 4, AgartAndMythrilChests)

TroiaChests = [
    bit6(0xd12a1),
    bit7(0xd12a1),
    bit0(0xd12a2),
    bit1(0xd12a2),
]

addCollectChestsAchievement(370730, "Troia", 2, TroiaChests)

ChocoboForestsChests = [
    bit7(0xd12a3),
    bit0(0xd12a4),
    bit1(0xd12a4),
    bit4(0xd12be),
    bit5(0xd12be),
    bit6(0xd12be),
    bit7(0xd12be),
    bit0(0xd12bf),
]

addCollectChestsAchievement(370731, "the Chocobo Forests", 10, ChocoboForestsChests)

MagneticCavernChests = [
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

addCollectChestsAchievement(370732, "the Magnetic Cavern", 5, MagneticCavernChests)

EblanCastleChests = [
    bit2(0xd12ae),
    bit3(0xd12ae),
    bit4(0xd12ae),
    bit5(0xd12ae),
    bit6(0xd12ae),
    bit7(0xd12ae),
    bit0(0xd12af),
    bit1(0xd12af),
    bit2(0xd12af),
    bit3(0xd12af),
    bit4(0xd12af),
    bit5(0xd12af),
    bit6(0xd12af),
    bit7(0xd12af),
    bit0(0xd12b0),
    bit1(0xd12b0),
    bit2(0xd12b0),
    bit3(0xd12b0),
    bit4(0xd12b0),
    bit5(0xd12b0),
    bit6(0xd12b0),
    bit7(0xd12b0),
]

addCollectChestsAchievement(370733, "Eblan Castle", 10, EblanCastleChests)

TroiaCastleChests = [
    bit7(0xd12aa),
    bit0(0xd12ab),
    bit1(0xd12ab),
    bit2(0xd12ab),
    bit3(0xd12ab),
    bit4(0xd12ab),
    bit5(0xd12ab),
    bit6(0xd12ab),
    bit7(0xd12ab),
    bit0(0xd12ac),
    bit1(0xd12ac),
    bit2(0xd12ac),
    bit3(0xd12ac),
    bit4(0xd12ac),
    bit5(0xd12ac),
    bit6(0xd12ac),
    bit7(0xd12ac),
    bit0(0xd12ad),
    bit1(0xd12ad),
    bit2(0xd12ad),
    bit3(0xd12ad),
    bit4(0xd12ad),
    bit5(0xd12ad),
    bit6(0xd12ad),
    bit7(0xd12ad),
    bit0(0xd12ae),
    bit1(0xd12ae),
]

addCollectChestsAchievement(370734, "Troia Castle", 5, TroiaCastleChests)

TowerOfZotChests = [
    bit3(0xd12b8),
    bit4(0xd12b8),
    bit5(0xd12b8),
    bit6(0xd12b8),
    bit7(0xd12b8),
    bit0(0xd12b9),
]

addCollectChestsAchievement(370735, "the Tower of Zot", 5, TowerOfZotChests, true)

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

addCollectChestsAchievement(370736, "Dwarven Castle", 5, DwarvenCastleChests)

TowerOfBabilOneChests = [
    bit2(0xd12c2),
    bit3(0xd12c2),
    bit4(0xd12c2),  
    bit5(0xd12c2),
    bit3(0xd12c4),
    bit4(0xd12c4),
    bit5(0xd12c4),
    bit6(0xd12c4),
    bit7(0xd12c4),
    bit0(0xd12c5),
    bit1(0xd12c5),
    bit2(0xd12c5),
    bit3(0xd12c5),
    bit4(0xd12c5),
    bit5(0xd12c5),
    bit7(0xd12c5),
]

addCollectChestsAchievement(370737, "the Tower of Babil I", 5, TowerOfBabilOneChests, true)

EblanCaveChests = [
    bit6(0xd12bb),
    bit7(0xd12bb),
    bit0(0xd12bc),
    bit1(0xd12bc),
    bit2(0xd12bc),
    bit3(0xd12bc),
    bit4(0xd12bc),
    bit5(0xd12bc),
    bit6(0xd12bc),
    bit7(0xd12bc),
    bit0(0xd12bd),
    bit1(0xd12bd),
    bit2(0xd12bd),
    bit3(0xd12bd),
    bit4(0xd12bd),
    bit5(0xd12bd),
    bit6(0xd12bd),
    bit7(0xd12bd),
    bit0(0xd12be),
    bit1(0xd12be),
    bit2(0xd12be),
    bit3(0xd12be),
]

addCollectChestsAchievement(370738, "Eblan Cave", 5, EblanCaveChests)

TowerOfBabilTwoChests = [
    bit3(0xd12b9),
    bit4(0xd12b9),
    bit5(0xd12b9),
    bit6(0xd12b9),
    bit7(0xd12b9),
    bit0(0xd12ba),
    bit0(0xd12c4),
    bit2(0xd12c4),
]

addCollectChestsAchievement(370739, "the Tower of Babil II", 5, TowerOfBabilTwoChests, true)

TomraChests = [
    bit4(0xd12c0),
    bit5(0xd12c0),
    bit6(0xd12c0),
    bit7(0xd12c0),
    bit0(0xd12c1),
    bit1(0xd12c1),
]

addCollectChestsAchievement(370740, "Tomra", 3, TomraChests)

KokkolsForgeChests = [
    bit0(0xd12c0),
    bit1(0xd12c0),
    bit2(0xd12c0),
    bit3(0xd12c0),
]

addCollectChestsAchievement(370741, "Kokkol's Forge", 2, KokkolsForgeChests)

SealedCaveChests = [
    bit0(0xd12cd),
    bit1(0xd12cd),
    bit2(0xd12cd),
    bit3(0xd12cd),
    bit4(0xd12cd),
    bit5(0xd12cd),
    bit6(0xd12cd),
    bit7(0xd12cd),
    bit0(0xd12ce),
    bit1(0xd12ce),
    bit2(0xd12ce),
    bit3(0xd12ce),
    bit4(0xd12ce),
    bit5(0xd12ce),
    bit6(0xd12ce),
    bit7(0xd12ce),
    bit0(0xd12cf),
    bit1(0xd12cf),
    bit2(0xd12cf),
]

addCollectChestsAchievement(370742, "the Sealed Cave", 5, SealedCaveChests)

CaveOfSummonsChests = [
    bit1(0xd12c6),
    bit2(0xd12c6),
    bit3(0xd12c6),
    bit4(0xd12c6),
    bit5(0xd12c6),
    bit6(0xd12c6),
    bit7(0xd12c6),
    bit0(0xd12c7),
    bit1(0xd12c7),
    bit2(0xd12c7),
    bit3(0xd12c7),
]

addCollectChestsAchievement(370743, "the Cave of Summons", 5, CaveOfSummonsChests)

LandOfSummonsChests = [ 
    bit5(0xd12c7),   
    bit6(0xd12c7),       
    bit7(0xd12c7),
    bit0(0xd12c8),
    bit1(0xd12c8),
    bit2(0xd12c8),
    bit3(0xd12c8),
    bit4(0xd12c8),
    bit5(0xd12c8),
    bit6(0xd12c8),
    bit7(0xd12c8),
]

addCollectChestsAchievement(370744, "the Land of Summons", 5, LandOfSummonsChests)

SylvanCaveChests = [
    bit0(0xd12c9),
    bit1(0xd12c9),
    bit2(0xd12c9),
    bit3(0xd12c9),
    bit4(0xd12c9),
    bit5(0xd12c9),
    bit6(0xd12c9),
    bit7(0xd12c9),
    bit0(0xd12ca),
    bit1(0xd12ca),
    bit2(0xd12ca),
    bit3(0xd12ca),
    bit4(0xd12ca),
    bit5(0xd12ca),
    bit6(0xd12ca),
    bit7(0xd12ca),
    bit0(0xd12cb),
    bit1(0xd12cb),
    bit2(0xd12cb),
    bit3(0xd12cb),
    bit4(0xd12cb),
    bit5(0xd12cb),
    bit6(0xd12cb),
    bit7(0xd12cb),
    bit0(0xd12cc),
    bit1(0xd12cc),
    bit2(0xd12cc),
    bit3(0xd12cc),
    bit4(0xd12cc),
    bit5(0xd12cc),
    bit6(0xd12cc),
    bit7(0xd12cc),
]

addCollectChestsAchievement(370745, "Sylvan Cave", 10, SylvanCaveChests)

LunarPathChests = [
    bit3(0xd12d0),
    bit4(0xd12d0),
    bit5(0xd12d0),
]

addCollectChestsAchievement(370746, "the Lunar Path", 1, LunarPathChests)

CaveBahamutChests = [
    bit5(0xd12cf),
    bit6(0xd12cf),
    bit7(0xd12cf),
    bit0(0xd12d0),
]

addCollectChestsAchievement(370747, "Cave Bahamut", 2, CaveBahamutChests)

GiantOfBabilChests = [
    bit6(0xd12ba),
    bit7(0xd12ba),
    bit0(0xd12bb),
    bit1(0xd12bb),
    bit2(0xd12bb),
    bit3(0xd12bb),
    bit4(0xd12bb),
    bit5(0xd12bb),
]

addCollectChestsAchievement(370748, "the Giant of Babil", 3, GiantOfBabilChests, true)

LunarSubterraneChests = [
    bit6(0xd12d0),
    bit7(0xd12d0),
    bit0(0xd12d1),
    bit1(0xd12d1),
    bit2(0xd12d1),
    bit3(0xd12d1),
    bit4(0xd12d1),
    bit6(0xd12d1),
    bit7(0xd12d1),
    bit0(0xd12d2),
    bit1(0xd12d2),
    bit2(0xd12d2),
    bit3(0xd12d2),
    bit4(0xd12d2),
    bit6(0xd12d2),
    bit7(0xd12d2),
    bit0(0xd12d3),
    bit1(0xd12d3),
    bit2(0xd12d3),
    bit4(0xd12d3),
    bit5(0xd12d3),
    bit6(0xd12d3),
    bit7(0xd12d3),
    bit0(0xd12d4),
    bit1(0xd12d4),
    bit2(0xd12d4),
    bit3(0xd12d4),
    bit4(0xd12d4),
    bit5(0xd12d4),
    bit6(0xd12d4),
    bit0(0xd12d5),
    bit1(0xd12d5),
]

addCollectChestsAchievement(370749, "Lunar Subterrane", 10, LunarSubterraneChests)

addEventFlagAchievement(370750, "Sword of Promised Victory", "Obtain Excalibur", bit4(0xd1289))
addEventFlagAchievement(370751, "The Power of Love [m]", "Obtain the Knife from Yang's wife", bit7(0xd1289))

function addCollectSpecialItemAchievement(id, title, name, flag, location) {
    achievement(
        id = id,
        title = title,
        description = format("Obtain {0}", name),
        points = 10,
        trigger = isInDialog() && prev(flag) == 1 && flag == 0 && SubLocation == location
    )
}

addCollectSpecialItemAchievement(370752, "Twilight of the Gods", "Ragnarok", bit3(0xd131b), 0x16b)
addCollectSpecialItemAchievement(370753, "Edge's Best Friend", "Masamune", bit4(0xd131b), 0x16e)
addCollectSpecialItemAchievement(370754, "Edge's Other Best Friend", "Murasame", bit5(0xd131b), 0x169)
addCollectSpecialItemAchievement(370755, "Spear of Destiny", "the Holy Lance", bit6(0xd131b), 0x17a)

// -----------------------------------------------------------------------------
// SIDEQUESTS

function addFindSummonAchievement(id, title, summon) {
    achievement(
        id = id,
        title = title,
        description = format("Learn the {0} summon spell", summon),
        points = 10,
        trigger = isInDialog()
            && any_of(SummonSlots, summonSlot => summonSlot == Summons[summon] && prev(summonSlot) != Summons[summon])
    )
}

addFindSummonAchievement(370756, "Air Elemental Sylph", SYLPH)
addFindSummonAchievement(370757, "Mighty Odin", ODIN)
addFindSummonAchievement(370758, "Queen Asura", ASURA)
addFindSummonAchievement(370759, "King Leviathan", LEVIATHAN)
addFindSummonAchievement(370760, "Dragon God Bahamut", BAHAMUT)

// -----------------------------------------------------------------------------
// FUN

achievement(
    id = 370761,
    title = "Master of Thieves",
    description = "Steal Dark Matter while fighting Zeromus",
    points = 10,
    trigger = isInBattle() && any_of(BattleItemSlots, itemSlot => itemSlot == 0xfb && prev(itemSlot) != 0xfb)
)

achievement(
    id = 370762,
    title = "Master of Perversion",
    description = "Obtain the (adult) magazine from secret Developer's Room",
    points = 5,
    trigger = isActiveGame() && any_of(ItemSlots, itemSlot => prev(itemSlot) != 0xe4 && itemSlot == 0xe4)
)

achievement(
    id = 370763,
    title = "Master of Exploration",
    description = "Find the Three Step Peninsula and encounter a battle there",
    points = 3,
    trigger = isInBattle() && MainLocation == 0x01
        && PositionX == 0x0d && __ornext(PositionY == 0x3c || PositionY == 0x3d || PositionY == 0x3e)
)

achievement(
    id = 370764,
    title = "Master of Luxury",
    description = "Buy a pass to the Court of Kings",
    points = 3,
    trigger = isActiveGame() && any_of(ItemSlots, itemSlot => prev(itemSlot) != 0xec && itemSlot == 0xec)
)

achievement(
    id = 370765,
    title = "Master of Science",
    description = "Look at the Moon through a telescope",
    points = 1,
    trigger = prev(SubLocation)  == 0x1f && SubLocation == 0x7c
)

// -----------------------------------------------------------------------------
// RICH PRESENCE

function convertFiveBitsToDecimal(address) {
    return bit0(address) * 1
        + bit1(address) * 2
        + bit2(address) * 4
        + bit3(address) * 8
        + bit4(address) * 16
        + bit5(address) * 32
}

Character1ID = convertFiveBitsToDecimal(0xd1040)
Character2ID = convertFiveBitsToDecimal(0xd10c0)
Character3ID = convertFiveBitsToDecimal(0xd1000)
Character4ID = convertFiveBitsToDecimal(0xd1100)
Character5ID = convertFiveBitsToDecimal(0xd1080)

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
    0x015: "Mt. Ordeals",
    0x016: "Mysidia",
    0x017: "Mysidia",
    0x018: "Troia",
    0x019: "Troia",
    0x01a: "Troia",
    0x01c: "Black Chocobo Ranch",
    0x01d: "Black Chocobo Ranch",
    0x01e: "Agart",
    0x01f: "Agart",
    0x020: "Agart",
    0x021: "Chocobo Village",
    0x024: "Baron Castle",
    0x025: "Damcyan Castle",
    0x026: "Fabul",
    0x027: "Troia Castle",
    0x028: "Eblan Castle",
    0x029: "",
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
    0x039: "Baron Castle",
    0x03a: "Waterway",
    0x03b: "Waterway",
    0x03c: "Waterway",
    0x03d: "Waterway",
    0x03e: "Waterway",
    0x03f: "Damcyan Castle",
    0x040: "Damcyan Castle",
    0x041: "Damcyan Castle",
    0x042: "Damcyan Castle",
    0x043: "Damcyan Castle",
    0x044: "Waterway",
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
    0x055: "Troia Castle",
    0x056: "Troia Castle",
    0x057: "Troia Castle",
    0x058: "Troia Castle",
    0x059: "Troia Castle",
    0x05a: "Troia Castle",
    0x05b: "Troia Castle",
    0x05c: "Troia Castle",
    0x05d: "Troia Castle",
    0x05e: "Eblan Castle",
    0x05f: "Eblan Castle",
    0x060: "Eblan Castle",
    0x061: "Eblan Castle",
    0x062: "Eblan Castle",
    0x063: "Eblan Castle",
    0x064: "Eblan Castle",
    0x065: "Eblan Castle",
    0x066: "Baron Castle",
    0x067: "Baron Castle",
    0x068: "Mysidia",
    0x069: "Baron",
    0x06a: "Water Cavern",
    0x06b: "",
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
    0x07c: "Airship",
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
    0x089: "Mysidia",
    0x08a: "Baron Castle",
    0x08b: "Agart",
    0x08c: "Magnetic Cave",
    0x08d: "Magnetic Cave",
    0x08e: "Magnetic Cave",
    0x08f: "Magnetic Cave",
    0x090: "Magnetic Cave",
    0x091: "Magnetic Cave",
    0x092: "Magnetic Cave",
    0x093: "Magnetic Cave",
    0x094: "Magnetic Cave",
    0x097: "Baron",
    0x098: "Tower of Zot",
    0x099: "Tower of Zot",
    0x09a: "Tower of Zot",
    0x09b: "Giant of Babil",
    0x09c: "Tower of Zot",
    0x09d: "Tower of Zot",
    0x09e: "Tower od Zot",
    0x09f: "Tower of Zot",
    0x0a0: "Adamant Grotto",
    0x0a1: "Magnetic Cave",
    0x0a2: "Tower of Zot",
    0x0a3: "Airship",
    0x0a4: "Airship",
    0x0a5: "Airship",
    0x0a6: "Tower of Babil",
    0x0a7: "Tower of Babil",
    0x0a8: "Tower of Babil",
    0x0a9: "Tower of Babil",
    0x0aa: "Tower of Babil",
    0x0ab: "Tower of Babil",
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
    0x0c2: "Airship",
    0x0c3: "Airship",
    0x0c4: "Airship",
    0x0c5: "Airship",
    0x0c6: "Airship",
    0x0c7: "Eblan Cave",
    0x0c8: "Eblan Cave",
    0x0c9: "Eblan Cave",
    0x0ca: "Eblan Cave",
    0x0cb: "Eblan Cae",
    0x0cc: "Eblan Cave",
    0x0cd: "Eblan Cave",
    0x0ce: "Eblan Cave",
    0x0cf: "Fabul",
    0x0d0: "Airship",
    0x0d1: "Chocobo Forest",
    0x0d2: "Chocobo Forest",
    0x0d3: "Chocobo Forest",
    0x0d4: "Chocobo Forest",
    0x0d5: "Baron",
    0x0d7: "Airship",
    0x0d9: "Airship",
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
    0x12c: "Lunar Whale",
    0x12d: "Tower of Babil",
    0x12e: "Dwarven Tank",
    0x12f: "Lunar Whale",
    0x132: "Tomra",
    0x136: "Cave of Summons",
    0x137: "Cave of Summons",
    0x138: "Cave of Summons",
    0x13a: "Cave of Summons",
    0x13b: "Land of Summons",
    0x13c: "Land of Summons",
    0x13d: "Land of Summons",
    0x13e: "Land of Summons",
    0x13f: "Land of Summons",
    0x140: "Land of Summons",
    0x141: "Land of Summons",
    0x142: "Land of Summons",
    0x143: "Land of Summons",
    0x144: "Sealed Cave",
    0x145: "Sylvan Cave",
    0x146: "Sylvan Cave",
    0x147: "Sylvan Cave",
    0x148: "Sylvan Cave",
    0x149: "Sylvan Cave",
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
    0x178: "Lunar Subterrane",
    0x179: "Lunar Subterrane",
    0x17a: "Lunar Subterrane",
    0x17b: "Lunar Subterrane",
    0x17c: "Lunar Subterrane",
}

Characters = {
    0: "",
    1: "• Cecil ",
    2: "• Kain ",
    3: "• Rydia ",
    4: "• Tellah ",
    5: "• Edward ",
    6: "• Rosa ",
    7: "• Yang ",
    8: "• Palom ",
    9: "• Porom ",
    10: "• Tellah ",
    11: "• Cecil ",
    12: "• Tellah ",
    13: "• Yang ",
    14: "• Cid ",
    15: "• Kain ",
    16: "• Rosa ",
    17: "• Rydia ",
    18: "• Edge ",
    19: "• FuSoYa ",
    20: "• Kain ",
    21: "• Golbez ",
}

// -----------------------------------------------------------------------------
// RICH PRESENCE

TimeInSeconds = dword(0xd16a4)

rich_presence_conditional_display(SubLocation == 0x7c, "Party observes the moon through a telescope")

rich_presence_conditional_display(MenuIndicator == 0x70 || PositionX + PositionY == 0, "Player is on title screen")

rich_presence_conditional_display(MainLocation == 0x03,
    "Party of {0}{1}{2}{3}{4}• is exploring {5} | {6}",
    rich_presence_lookup("Character1 ID", Character1ID, Characters),
    rich_presence_lookup("Character2 ID", Character2ID, Characters),
    rich_presence_lookup("Character3 ID", Character3ID, Characters),
    rich_presence_lookup("Character4 ID", Character4ID, Characters),
    rich_presence_lookup("Character5 ID", Character5ID, Characters),
    rich_presence_lookup("SubLocation", SubLocation, SubLocations),
    rich_presence_value("Time", TimeInSeconds, "SECS_AS_MINS")
)

rich_presence_display(
    "Party of {0}{1}{2}{3}{4}• is exploring {5} | {6}",
    rich_presence_lookup("Character1 ID", Character1ID, Characters),
    rich_presence_lookup("Character2 ID", Character2ID, Characters),
    rich_presence_lookup("Character3 ID", Character3ID, Characters),
    rich_presence_lookup("Character4 ID", Character4ID, Characters),
    rich_presence_lookup("Character5 ID", Character5ID, Characters),
    rich_presence_lookup("MainLocation", MainLocation, MainLocations),
    rich_presence_value("Time", TimeInSeconds, "SECS_AS_MINS")
)

// -----------------------------------------------------------------------------
// LEADERBOARDS

leaderboard(
    title = "Speed Run",
    description = "Finish the game as quickly as possible",
    start = isInBattle() && SubLocation == 0x172 && EnemyFormation == EnemyFormations[ZEROMUS],
    cancel = bit7(0xd00a8) == 1,
    submit = isBattleWon(),
    value = TimeInSeconds,
    format= "SECS_AS_MINS",
    lower_is_better = true
)

CHARACTER_LEVEL_1 = byte(0xd1042)
CHARACTER_LEVEL_2 = byte(0xd10c2)
CHARACTER_LEVEL_3 = byte(0xd1002)
CHARACTER_LEVEL_4 = byte(0xd1102)
CHARACTER_LEVEL_5 = byte(0xd1082)

leaderboard(
    title = "Level Run",
    description = "Finish the game with the lowest level",
    start = isInBattle() && SubLocation == 0x172 && EnemyFormation == EnemyFormations[ZEROMUS],
    cancel = bit7(0xd00a8) == 1,
    submit = isBattleWon(),
    value = CHARACTER_LEVEL_1  + CHARACTER_LEVEL_2 + CHARACTER_LEVEL_3 
                + CHARACTER_LEVEL_4 + CHARACTER_LEVEL_5,
    format= "VALUE",
    lower_is_better = true
)
