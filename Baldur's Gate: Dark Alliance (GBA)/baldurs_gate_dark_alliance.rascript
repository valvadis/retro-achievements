// Baldur's Gate: Dark Alliance
// #ID = 5441

// -----------------------------------------------------------------------------
// VARIABLES

CharacterLevel = byte(0x0b5d)
CharacterExperience = dword(0x0b50)
CharacterGold = dword(0x0994)
CharacterLocation = byte(0x01f0)
CharacterPositionX = word(0x1521)
CharacterPositionY = word(0x1525)
CharacterClass = low4(0x157c)

ARCHER = 0
FIGHTER = 1
WIZARD = 2
ELVEN_FIGHTER = 3

Classes = {
    ARCHER: "Archer",
    FIGHTER: "Fighter",
    WIZARD: "Wizard",
    ELVEN_FIGHTER: "Elven Fighter",
}

KARNE = 65570
XANTHAM = 65572
ILIVARRA = 65554
SESS = 65553

Bosses = {
    KARNE: "Karne",
    XANTHAM: "Xantham",
    ILIVARRA: "Ilivarra",
    SESS: "Sess'sth",
}

Locations = {
    1: "Baldur's Gate",
    2: "Tavern's Cellar",
    3: "Baldur's Gate",
    4: "Sewers - North Part",
    5: "Sewers - South Part",
    6: "Thieves' Guild",
    7: "Thieves' Guild",
    9: "Dwarves' Mining Camp",
    11: "Dark Forest",
    12: "Mount Burning Eye",
    13: "Mount Burning Eye",
    14: "Mines",
    15: "Mines",
    17: "Adderspine Camp",
    18: "Dungeon",
    19: "Dungeon",
    20: "Adderspine Road",
    21: "Onyx Tower",
    22: "Onyx Tower",
    23: "Black Forge",
    25: "Eldirth's Watch",
    27: "Mount Burning Eye Summit",
    124: "Store",
    125: "Quite Game",
    126: "Game Over 💀",
    127: "End Game 🚩",
    255: "Store",              
}

// [bit0] 0 - DIALOG MODE OFF, 1 - DIALOG MODE ON
DialogMode = bit0(0x09b0)

// [bit7] 1 - ELEVEN FIGHTER ENABLED, 0 - ELVEN FIGHTER DISABLED
ScreenMode = bitcount(0x01f1) - bit7(0x01f1)

// [8 bit] Skills are stored in logs between 0x0b71 and 0x0b78
SkillSlots = [byte(0x0b71), byte(0x0b72), byte(0x0b73), byte(0x0b74), byte(0x0b75), byte(0x0b76), byte(0x0b77), byte(0x0b78)]

// [32 bit] Quests are stored in logs between 0x8b0 and 0x988 
QuestSlots = []
for questSlot in range(0x8b0, 0x988) {
    array_push(QuestSlots, dword(questSlot))
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function isGameMode() => CharacterLocation == 124 || ScreenMode != 0

function isGameRestarted() => CharacterLocation == 0 || CharacterLocation == 125 || CharacterLocation == 126

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function defeatBossAchievement(points, class, boss, location, id) {
    achievement(
        id = id,
        title = format("[{0}] {1}", Classes[class], Bosses[boss]),
        description = format("Defeat {0}", boss),
        points = points,
        trigger = isGameMode() && CharacterLocation == location && any_of(QuestSlots, questSlot => questSlot == boss)
    )
}

function defeatFinalBossAchievement(class, id) {
    achievement(
        id = id,
        title = format("[{0}] Eldrith", Classes[class]),
        description = "Defeat Eldrith and complete the game",
        points = 25,
        trigger = prev(CharacterLocation) == 25 && CharacterLocation == 127 && CharacterClass == class
    )
}

defeatBossAchievement(5, ARCHER, KARNE, 7, 0)
defeatBossAchievement(10, ARCHER, XANTHAM, 18, 0)
defeatBossAchievement(10, ARCHER, ILIVARRA, 15, 0)
defeatBossAchievement(5, ARCHER, SESS, 19, 0)
defeatFinalBossAchievement(ARCHER, 0)

achievement(
    id = 0,
    title = "[Archer] Archery Master",
    description = "Master all active Archer skills",
    points = 10,
    trigger = isGameMode() && CharacterClass == ARCHER && SkillSlots[0] == 5 && SkillSlots[1] == 13 && SkillSlots[2] == 21 
        && SkillSlots[3] == 26 && SkillSlots[4] == 37
)

defeatBossAchievement(5, FIGHTER, KARNE, 7, 0)
defeatBossAchievement(10, FIGHTER, XANTHAM, 18, 0)
defeatBossAchievement(10, FIGHTER, ILIVARRA, 15, 0)
defeatBossAchievement(5, FIGHTER, SESS, 19, 0)
defeatFinalBossAchievement(FIGHTER, 0)

achievement(
    id = 0,
    title = "[Fighter] Combat Master",
    description = "Master all active Fighter skills",
    points = 10,
    trigger = isGameMode() && CharacterClass == FIGHTER && SkillSlots[0] == 101 && SkillSlots[1] == 109
)

defeatBossAchievement(5, WIZARD, KARNE, 7, 0)
defeatBossAchievement(10, WIZARD, XANTHAM, 18, 0)
defeatBossAchievement(10, WIZARD, ILIVARRA, 15, 0)
defeatBossAchievement(5, WIZARD, SESS, 19, 0)
defeatFinalBossAchievement(WIZARD, 0)

achievement(
    id = 0,
    title = "[Wizard] Spell Master",
    description = "Master all Wizard spells",
    points = 10,
    trigger = isGameMode() && CharacterClass == WIZARD && SkillSlots[0] == 43 && SkillSlots[1] == 53 && SkillSlots[2] == 61 
        && SkillSlots[3] == 69 && SkillSlots[4] == 77 && SkillSlots[5] == 82 && SkillSlots[6] == 93
)

defeatBossAchievement(5, ELVEN_FIGHTER, KARNE, 7, 0)
defeatBossAchievement(10, ELVEN_FIGHTER, XANTHAM, 18, 0)
defeatBossAchievement(10, ELVEN_FIGHTER, ILIVARRA, 15, 0)
defeatBossAchievement(5, ELVEN_FIGHTER, SESS, 19, 0)
defeatFinalBossAchievement(ELVEN_FIGHTER, 0)

achievement(
    id = 0,
    title = "[Elven Fighter] Elven Master",
    description = "Master all Elven Fighter skills and spells",
    points = 10,
    trigger = isGameMode() && CharacterClass == ELVEN_FIGHTER && SkillSlots[0] == 13 && SkillSlots[1] == 21 
        && SkillSlots[2] == 26 && SkillSlots[3] == 43 && SkillSlots[4] == 53 && SkillSlots[5] == 69 && SkillSlots[6] == 101
        && SkillSlots[7] == 109
)

achievement(
    id = 0,
    title = "[Quest] Defender Of Baldur's Gate [m]",
    description = "Complete all side quests in Baldur's Gate",
    points = 10,
    trigger = isGameMode()
        && (CharacterLocation == 1 || CharacterLocation == 3)
        && any_of(QuestSlots, questSlot => questSlot == 65545) // Old Woman & Spiders
        && any_of(QuestSlots, questSlot => questSlot == 65565) // Rat Cleaner
        && any_of(QuestSlots, questSlot => questSlot == 65569) // Ring of Intellect
        && any_of(QuestSlots, questSlot => questSlot == 65554) // Key to the South Door
        && any_of(QuestSlots, questSlot => questSlot == 65558) // Widow Charm
)

achievement(
    id = 0,
    title = "[Quest] Liberator Of The Marsh Chelimber [m]",
    description = "Complete all side quests in The Marsh Of Chelimber",
    points = 10,
    trigger = isGameMode() 
        && any_of(QuestSlots, questSlot => questSlot == 65542) // Kill lizardmen in house
        && any_of(QuestSlots, questSlot => questSlot == 65546) // Free inprisoned people
        && any_of(QuestSlots, questSlot => questSlot == 65549) // Wipe out lizardmen from village
)

achievement(
    id = 0,
    title = "[Quest] King Midas' doom",
    description = "Find room with golden equipment",
    points = 10,
    trigger = isGameMode() && CharacterLocation == 23 && CharacterPositionX == 392 && CharacterPositionY == 1983
)

function addReachLevelAchievement(points, level, title, id) {
    achievement(
        id = id,
        title = format("[Experience] {0}", title),
        description = format("Reach {0} level", level),
        points = points,
        trigger = isGameMode() && measured(CharacterLevel == level)
    )
}

addReachLevelAchievement(3, 5, "Beginner", 0)
addReachLevelAchievement(5, 10, "Apprentice", 0)
addReachLevelAchievement(10, 20, "Advanced", 0)
addReachLevelAchievement(25, 40, "Expert", 0)

function addCollectGoldAchievement(points, gold, title, id) {
    achievement(
        id = id,
        title = format("[Gold] {0}", title),
        description = format("Collect {0} 000 gold", gold / 1000),
        points = points,
        trigger = isGameMode() && measured(CharacterGold >= gold)
    )
}

addCollectGoldAchievement(3, 50000, "Tiny Fortune", 0)
addCollectGoldAchievement(5, 100000, "Small Fortune", 0)
addCollectGoldAchievement(10, 200000, "Big Fortune", 0)
addCollectGoldAchievement(25, 400000, "Huge Fortune", 0)

function addKillEnemiesAchievement(points, enemies, title, id) {
    achievement(
        id = id,
        title = format("[Kill] {0}", title),
        description = format("Kill {0} enemies", enemies),
        points = points,
        trigger = never(isGameRestarted()) && unless(!isGameMode()) && unless(DialogMode == 1) 
            && measured(repeated(enemies, CharacterExperience > prev(CharacterExperience)))
    )
}

addKillEnemiesAchievement(3, 50, "Hunter", 0)
addKillEnemiesAchievement(5, 100, "Killer", 0)
addKillEnemiesAchievement(10, 200, "Butcher", 0)
addKillEnemiesAchievement(25, 400, "Slayer", 0)

// -----------------------------------------------------------------------------
// RICH PRESENCE
 
rich_presence_conditional_display(!isGameMode(), "Starting the Game")
rich_presence_display(
    "{0} Lvl {1} 💰 {2} | {3}",
    rich_presence_lookup("Class", CharacterClass, Classes),
    rich_presence_value("Level", CharacterLevel, "VALUE"),
    rich_presence_value("Gold", CharacterGold, "VALUE"),
    rich_presence_lookup("Location", CharacterLocation, Locations)
)
