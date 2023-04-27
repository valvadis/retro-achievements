// Baldur's Gate: Dark Alliance
// #ID = 5441

// -----------------------------------------------------------------------------
// VARIABLES

AmountOfGold = dword(0x0994)
CurrentLevel = byte(0x0b5d)

// During the game, the character's position is always greater than (1,1)
CharacterPositionX = word(0x1521)
CharacterPositionY = word(0x1525)

CurrentLocation = byte(0x01f0)
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
    126: "Game Over 💀",
    127: "End Game 🚩",
    255: "Store",              
}

CharacterClass = low4(0x157c)
Classes = {
    0: "Archer",
    1: "Fighter",
    2: "Wizard",
    3: "Elven Fighter",
}

// Quests are stored in logs between 0x8b0 and 0x988
QuestSlots = []
for questSlot in range(0x8b0, 0x988) {
    array_push(QuestSlots, dword(questSlot))
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function isTitleScreen() => CharacterPositionX == 0 && CharacterPositionY == 0

function isGameMode() => CharacterPositionX != 0 && CharacterPositionY != 0

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function addSpecificLocationAchievement(points, locationFrom, locationTo, title, description, id) {
    achievement(
        id = id,
        title = format("[Story] {0}", title),
        description = description,
        points = points,
        trigger = isGameMode() && prev(CurrentLocation) == locationFrom && CurrentLocation == locationTo
    )
}

addSpecificLocationAchievement(1, 1, 2, "Cellar", "Go down to the Tavern's Cellar", 0)
addSpecificLocationAchievement(10, 3, 4, "Sewers", "Find the entrance to the Sewers", 0)
addSpecificLocationAchievement(10, 5, 6, "Guild", "Make it to the Thieves' Guild", 0)
addSpecificLocationAchievement(10, 18, 9, "Baldur's Gate", "Complete Act I", 0)
addSpecificLocationAchievement(5, 9, 11, "Dark Forest", "Enter the Dark Forest", 0)
addSpecificLocationAchievement(10, 9, 12, "Mountain", "Get to the Mount Burning Eye", 0)
addSpecificLocationAchievement(10, 9, 14, "Mines", "Go down to the Dwarven Mines", 0)
//addSpecificLocationAchievement(10, 0, 17, "The Sunset Mountain", "Complete Act II", 0)
//addSpecificLocationAchievement(10, 0, 21, "Dungeon", "Enter the Dungeon", 0)
//addSpecificLocationAchievement(10, 0, 21, "Tower", "Get into the Onyx Tower", 0)
addSpecificLocationAchievement(10, 25, 127, "The Marsh of Chelimber", "Complete Act III", 0)

achievement(
    id = 0,
    title = "[Quest] Hero Of Baldur's Gate",
    description = "Complete all side quests in Baldur's Gate",
    points = 25,
    trigger = isGameMode()
        && (CurrentLocation == 1 || CurrentLocation == 3)
        && any_of(QuestSlots, questSlot => questSlot == 65545) // Old Woman & Spiders
        && any_of(QuestSlots, questSlot => questSlot == 65565) // Rat Cleaner
        && any_of(QuestSlots, questSlot => questSlot == 65569) // Ring of Intellect
        && any_of(QuestSlots, questSlot => questSlot == 65554) // Key to the South Door
        && any_of(QuestSlots, questSlot => questSlot == 65558) // Widow Charm
)

// ====================== TODO ======================
achievement(
    id = 0,
    title = "[Quest] Hero Of The Marsh Chelimber",
    description = "Complete all side quests in The Marsh Of Chelimber",
    points = 25,
    trigger = isGameMode() 
        && any_of(QuestSlots, questSlot => questSlot == 0)
)
// ====================== TODO ======================

function addCompleteGameAchievement(points, class, id) {
    achievement(
        id = id,
        title = format("[Class] {0}", Classes[class]),
        description = format("Complete the game as {0}", Classes[class]),
        points = points,
        trigger = prev(CurrentLocation) == 25 && CurrentLocation == 127 && CharacterClass == class
    )
}

addCompleteGameAchievement(25, 0, 0)
addCompleteGameAchievement(25, 1, 0)
addCompleteGameAchievement(25, 2, 0)
addCompleteGameAchievement(25, 3, 0)

achievement(
    id = 0,
    title = "[Class] Combat Champion",
    description = "Master all active Fighter skills",
    points = 10,
    trigger = isGameMode() && byte(0x0b71) == 101 && byte(0x0b72) == 109
)

achievement(
    id = 0,
    title = "[Class] Spell Master",
    description = "Master all Wizard's spells",
    points = 10,
    trigger = isGameMode() && byte(0x0b71) == 43 && byte(0x0b72) == 53 && byte(0x0b73) == 61 
        && byte(0x0b74) == 69 && byte(0x0b75) == 77 && byte(0x0b76) == 82 && byte(0x0b77) == 93
)

achievement(
    id = 0,
    title = "[Class] Archery Champion",
    description = "Master all active Archer skills",
    points = 10,
    trigger = isGameMode() && byte(0x0b71) == 5 && byte(0x0b72) == 13 && byte(0x0b73) == 21 
        && byte(0x0b74) == 26 && byte(0x0b75) == 37
)

achievement(
    id = 0,
    title = "[Class] Elven Master",
    description = "Master all Elven Fighter's skills and spells",
    points = 10,
    trigger = isGameMode() && byte(0x0b71) == 13 && byte(0x0b72) == 21 && byte(0x0b73) == 26 && byte(0x0b74) == 43 
        && byte(0x0b75) == 53 && byte(0x0b76) == 69 && byte(0x0b77) == 101 && byte(0x0b78) == 109
)

// Class skills

function addReachLevelAchievement(points, level, title, id) {
    achievement(
        id = id,
        title = format("[Experience] {0}", title),
        description = format("Reach {0} level", level),
        points = points,
        trigger = isGameMode() && measured(CurrentLevel == level)
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
        trigger = isGameMode() && measured(AmountOfGold >= gold)
    )
}

addCollectGoldAchievement(3, 50000, "Peasant", 0)
addCollectGoldAchievement(5, 100000, "Townsman", 0)
addCollectGoldAchievement(10, 200000, "Craftsman", 0)
addCollectGoldAchievement(25, 400000, "Nobleman", 0)

// -----------------------------------------------------------------------------
// RICH PRESENCE
 
rich_presence_conditional_display(isTitleScreen(), "Starting the Game")
rich_presence_display(
    "{0} Lvl {1} 💰 {2} | {3}",
    rich_presence_lookup("Class", CharacterClass, Classes),
    rich_presence_value("Level", CurrentLevel, "VALUE"),
    rich_presence_value("Gold", AmountOfGold, "VALUE"),
    rich_presence_lookup("Location", CurrentLocation, Locations)
)
