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
CharacterSkillPoints = byte(0x0ba9)

// Class ID
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

// Quest ID
KARNE = 65570
XANTHAM = 65572
ILIVARRA = 65554
SESS = 65553
ELDRITH = 0

Bosses = {
    KARNE: "Karne",
    XANTHAM: "Xantham",
    ILIVARRA: "Ilivarra",
    SESS: "Sess'sth",
    ELDRITH: "Eldrith",
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

ScreenMode = bitcount(0x01f1)

// [8 bit] Skills are stored in logs between 0x0b71 and 0x0b78
SkillSlots = [byte(0x0b71), byte(0x0b72), byte(0x0b73), byte(0x0b74), byte(0x0b75), byte(0x0b76), byte(0x0b77), byte(0x0b78)]

// [32 bit] Quests are stored in logs between 0x8b0 and 0x988 
QuestSlots = []
for questSlot in range(0x8b0, 0x988) {
    array_push(QuestSlots, dword(questSlot))
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function isGameMode() => CharacterExperience > 0 || ScreenMode >= 2

function isGameRestarted() => CharacterLocation == 0 || CharacterLocation == 125 || CharacterLocation == 126 || CharacterLocation == 127

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function defeatBossAchievement(points, class, boss, location, id) {
    achievement(
        id = id,
        title = format("[{0}] {1}", Classes[class], Bosses[boss]),
        description = format("Defeat {0}", Bosses[boss]),
        points = points,
        trigger = isGameMode() && CharacterClass == class && CharacterLocation == location 
            && any_of(QuestSlots, questSlot => questSlot == boss)
    )
}

defeatBossAchievement(5, ARCHER, KARNE, 7, 315620)
defeatBossAchievement(10, ARCHER, XANTHAM, 18, 315621)
defeatBossAchievement(10, ARCHER, ILIVARRA, 15, 315622)
defeatBossAchievement(5, ARCHER, SESS, 19, 315623)
defeatBossAchievement(25, ARCHER, ELDRITH, 127, 315624)

achievement(
    id = 315625,
    title = "[Archer] Archery Master",
    description = "Master all active Archer skills",
    points = 10,
    trigger = __ornext(isGameMode()) && CharacterSkillPoints < prev(CharacterSkillPoints) && CharacterClass == ARCHER
        && SkillSlots[0] == 5 && SkillSlots[1] == 13 && SkillSlots[2] == 21 && SkillSlots[3] == 26 && SkillSlots[4] == 37
)

defeatBossAchievement(5, FIGHTER, KARNE, 7, 315626)
defeatBossAchievement(10, FIGHTER, XANTHAM, 18, 315627)
defeatBossAchievement(10, FIGHTER, ILIVARRA, 15, 315628)
defeatBossAchievement(5, FIGHTER, SESS, 19, 315629)
defeatBossAchievement(25, FIGHTER, ELDRITH, 127, 315630)

achievement(
    id = 315631,
    title = "[Fighter] Combat Master",
    description = "Master all active Fighter skills",
    points = 10,
    trigger = __ornext(isGameMode()) && CharacterSkillPoints < prev(CharacterSkillPoints) && CharacterClass == FIGHTER
        && SkillSlots[0] == 101 && SkillSlots[1] == 109
)

defeatBossAchievement(5, WIZARD, KARNE, 7, 315632)
defeatBossAchievement(10, WIZARD, XANTHAM, 18, 315633)
defeatBossAchievement(10, WIZARD, ILIVARRA, 15, 315634)
defeatBossAchievement(5, WIZARD, SESS, 19, 315635)
defeatBossAchievement(25, WIZARD, ELDRITH, 127, 315636)

achievement(
    id = 315637,
    title = "[Wizard] Spell Master",
    description = "Master all Wizard spells",
    points = 10,
    trigger = __ornext(isGameMode()) && CharacterSkillPoints < prev(CharacterSkillPoints) && CharacterClass == WIZARD
        && SkillSlots[0] == 43 && SkillSlots[1] == 53 && SkillSlots[2] == 61 && SkillSlots[3] == 69 && SkillSlots[4] == 77 
        && SkillSlots[5] == 82 && SkillSlots[6] == 93
)

defeatBossAchievement(5, ELVEN_FIGHTER, KARNE, 7, 315638)
defeatBossAchievement(10, ELVEN_FIGHTER, XANTHAM, 18, 315639)
defeatBossAchievement(10, ELVEN_FIGHTER, ILIVARRA, 15, 315640)
defeatBossAchievement(5, ELVEN_FIGHTER, SESS, 19, 315641)
defeatBossAchievement(25, ELVEN_FIGHTER, ELDRITH, 127, 315642)

achievement(
    id = 315643,
    title = "[Elven Fighter] Elven Master",
    description = "Master all Elven Fighter active skills and spells",
    points = 10,
    trigger = __ornext(isGameMode()) && CharacterSkillPoints < prev(CharacterSkillPoints) && CharacterClass == ELVEN_FIGHTER
        && SkillSlots[0] == 13 && SkillSlots[1] == 21 && SkillSlots[2] == 26 && SkillSlots[3] == 43 && SkillSlots[4] == 53
        && SkillSlots[5] == 69 && SkillSlots[6] == 101 && SkillSlots[7] == 109
)

achievement(
    id = 315644,
    title = "[Quest] Baldur's Gate [m]",
    description = "Complete all side quests in Baldur's Gate",
    points = 10,
    trigger = isGameMode()
        && (CharacterLocation == 1 || CharacterLocation == 3)
        && any_of(QuestSlots, questSlot => questSlot == 65545) // Spiders
        && any_of(QuestSlots, questSlot => questSlot == 65565) // Rat Cleaner
        && any_of(QuestSlots, questSlot => questSlot == 65569) // Stolen Purse
        && any_of(QuestSlots, questSlot => questSlot == 65554) // South Gate Key
        && any_of(QuestSlots, questSlot => questSlot == 65558) // Widow Charm
)

achievement(
    id = 315645,
    title = "[Quest] The Marsh Of Chelimber [m]",
    description = "Complete all side quests in The Marsh Of Chelimber",
    points = 10,
    trigger = isGameMode()
        && CharacterLocation == 17
        && any_of(QuestSlots, questSlot => questSlot == 65542) // House Cleaning
        && any_of(QuestSlots, questSlot => questSlot == 65546) // Rescue the Camp People
        && any_of(QuestSlots, questSlot => questSlot == 65549) // Revenge
)

achievement(
    id = 315646,
    title = "[Quest] King Midas' Heritage",
    description = "Find room with golden equipment",
    points = 10,
    trigger = __ornext(isGameMode()) && CharacterLocation == 23 && CharacterPositionX == 392 && CharacterPositionY == 1983
)

function addReachLevelAchievement(points, level, title, id) {
    achievement(
        id = id,
        title = format("[Experience] {0}", title),
        description = format("Reach {0} level", level),
        points = points,
        trigger = unless(!isGameMode()) && (CharacterLevel - 1) == prev(CharacterLevel) && measured(CharacterLevel == level)
    )
}

addReachLevelAchievement(3, 5, "Beginner", 315647)
addReachLevelAchievement(5, 10, "Apprentice", 315648)
addReachLevelAchievement(10, 20, "Advanced", 315649)
addReachLevelAchievement(25, 30, "Expert", 315650)

function addCollectGoldAchievement(points, gold, title, id) {
    achievement(
        id = id,
        title = format("[Gold] {0}", title),
        description = format("Collect {0} 000 gold", gold / 1000),
        points = points,
        trigger = __ornext(isGameMode()) && measured(CharacterGold >= gold) && prior(CharacterGold) != 0 && prev(CharacterGold) < gold
    )
}

addCollectGoldAchievement(3, 50000, "Tiny Fortune", 315651)
addCollectGoldAchievement(5, 100000, "Small Fortune", 315652)
addCollectGoldAchievement(10, 200000, "Big Fortune", 315653)
addCollectGoldAchievement(25, 300000, "Huge Fortune", 315654)

function addKillEnemiesAchievement(points, enemies, title, id) {
    achievement(
        id = id,
        title = format("[Kill] {0}", title),
        description = format("Kill {0} enemies in one session without dying", enemies),
        points = points,
        trigger = never(isGameRestarted()) && __ornext(isGameMode()) && unless(DialogMode == 1) 
            && measured(
                repeated(enemies, CharacterExperience > prev(CharacterExperience) 
                    && (prev(CharacterExperience) > 0 || CharacterExperience < 120)
                )
            )
    )
}

addKillEnemiesAchievement(3, 50, "Hunter", 315655)
addKillEnemiesAchievement(5, 100, "Killer", 315656)
addKillEnemiesAchievement(10, 200, "Butcher", 315657)
addKillEnemiesAchievement(25, 300, "Slayer", 315658)

// -----------------------------------------------------------------------------
// RICH PRESENCE
 
rich_presence_conditional_display(!isGameMode(), "Title screen")
rich_presence_display(
    "{0} Lvl {1} 💰 {2} | {3}",
    rich_presence_lookup("Class", CharacterClass, Classes),
    rich_presence_value("Level", CharacterLevel, "VALUE"),
    rich_presence_value("Gold", CharacterGold, "VALUE"),
    rich_presence_lookup("Location", CharacterLocation, Locations)
)
