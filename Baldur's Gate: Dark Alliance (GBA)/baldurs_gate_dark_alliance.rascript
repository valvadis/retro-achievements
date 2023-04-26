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
    1: "Baldur's Gate - Inside",
    2: "Tavern's Cellar",
    3: "Baldur's Gate - Outside",
    4: "Sewers - North Part",
    5: "Sewers - South Part",
    6: "Thieves' Guild 1",
    7: "Thieves' Guild 2",
    9: "Dwarves' Mining Camp",
    11: "Dark Forest",
    12: "Mount Burning Eye 1",
    13: "Mount Burning Eye 2",
    14: "Mines 1",
    15: "Mines 2",
    17: "Adderspine Camp",
    18: "Dungeon of Chelimber 1",
    19: "Dungeon of Chelimber 2",
    20: "Adderspine Road",
    21: "Onyx Tower 1",
    22: "Onyx Tower 2",
    23: "Black Forge",
    25: "Eldirth's Watch",
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

QuestSlots = []
for questSlot in range(0x8b0, 0x988) {
    array_push(QuestSlots, dword(questSlot))
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function isGameEnded() => CurrentLocation == 127

function isTitleScreen() => CharacterPositionX == 0 && CharacterPositionY == 0

function isGameMode() => CharacterPositionX != 0 && CharacterPositionY != 0

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function addCollectGoldAchievement(points, gold, title, id) {
    achievement(
        id = id,
        title = format("[Gold] {0}", title),
        description = format("Collect {0} 000 gold", gold / 1000),
        points = points,
        trigger = isGameMode() && measured(AmountOfGold >= gold)
    )
}

addCollectGoldAchievement(5, 50000, "Peasant", 0)
addCollectGoldAchievement(10, 100000, "Townsman", 0)
addCollectGoldAchievement(15, 200000, "Craftsman", 0)
addCollectGoldAchievement(25, 400000, "Nobleman", 0)

function addReachLevelAchievement(points, level, title, id) {
    achievement(
        id = id,
        title = format("[Experience] {0}", title),
        description = "Reach {0} level",
        points = points,
        trigger = isGameMode() && measured(CurrentLevel >= level)
    )
}

addReachLevelAchievement(5, 5, "Beginner", 0)
addReachLevelAchievement(10, 10, "Apprentice", 0)
addReachLevelAchievement(15, 20, "Advanced", 0)
addReachLevelAchievement(20, 30, "Expert", 0)
addReachLevelAchievement(25, 40, "Hero", 0)

function addSpecificLocationAchievement(points, locationId, title, description, id) {
    achievement(
        id = id,
        title = format("[Story] {0}", title),
        description = description,
        points = points,
        trigger = isGameMode() && CurrentLocation == locationId
    )
}

addSpecificLocationAchievement(1, 2, "Cellar", "Enter the Tavern's Cellar", 0)
addSpecificLocationAchievement(5, 4, "Sewers", "Go down to the Sewers", 0)
addSpecificLocationAchievement(10, 6, "Guild", "Make it to the guild", 0)
addSpecificLocationAchievement(10, 9, "The Sunset Mountain", "Complete Act I", 0)
addSpecificLocationAchievement(10, 12, "Burning Eye", "Visit the Mount Burning Eye", 0)
addSpecificLocationAchievement(10, 14, "Mines", "Go down to the mines", 0)
addSpecificLocationAchievement(15, 17, "Marsh Of Chelimber", "Complete Act II", 0)
addSpecificLocationAchievement(15, 21, "Tower", "Reach Onyx Tower", 0)

function addCompleteGameAchievement(points, class, id) {
    achievement(
        id = id,
        title = format("[Class] {0}", Classes[class]),
        description = format("Complete the game as {0}", Classes[class]),
        points = points,
        trigger = isGameEnded() && CharacterClass == class
    )
}

addCompleteGameAchievement(25, 0, 0)
addCompleteGameAchievement(25, 1, 0)
addCompleteGameAchievement(25, 2, 0)
addCompleteGameAchievement(25, 3, 0)

function addCompleteQuestAchievement(points, questHash, locationId, title, description, id) {
    achievement(
        id = id,
        title = format("[Quest] {0}", title),
        description = description,
        points = points,
        trigger = isGameEnded() && CurrentLocation == locationId && any_of(QuestSlots, questSlot => questSlot == questHash)
    )
}

addCompleteQuestAchievement(3, 65545, 3, "Old Woman", "Help an old woman chase away spiders", 0)
addCompleteQuestAchievement(3, 65565, 3, "Rat Cleaner", "Kill all the rats at the request of the rat cleaner", 0)
addCompleteQuestAchievement(3, 65569, 3, "One Ring", "Get a ring of intellect as a reward", 0)
addCompleteQuestAchievement(3, 65554, 3, "City Key", "Find the key to the Southern Door", 0)
addCompleteQuestAchievement(3, 65558, 1, "Widow Charm", "Give the lucky charm to the widow", 0)

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
