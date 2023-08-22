// Mountain King
// #ID = 24996

// -----------------------------------------------------------------------------
// VARIABLES

CurrentLevel = byte(0x00d2)
GoldenCrowns = byte(0x0157)
FlameSpirits = byte(0x0156)
CharacterPosition = {
    "x": byte(0x015e),
    "y": byte(0x015f)
}
RomanNumeralsConverter = {
    1: "I",
    2: "II",
    3: "III",
    4: "IV",
    5: "V",
    6: "VI",
    7: "VII",
    8: "VIII"
}

// -----------------------------------------------------------------------------
// FUNCTIONS

function getScore() {
    return low4(0x0153) +
        high4(0x0153)  * 10 +
        low4(0x0154) * 100 +
        high4(0x0154)  * 1000 +
        low4(0x0155) * 10000 +
        high4(0x0155)  * 100000
}

function isTreasureChestTaken() => prev(getScore()) - getScore() == 260

function isPlayerKilled() => bit0(0x03b8) == 1 && bit1(0x03b8) == 1

function isPlayerAlive() => bit0(0x03b8) == 0 && bit1(0x03b8) == 0

function isGameStarted() => tbyte(0x0153) == 0

function isGameActive() => CharacterPosition["y"] > 0

function isFlashlightUsed() => bit5(0x017a) == 1

function isFlameSpiritIsActive() => bit6(0x017a) == 1

function hasGoldenCrown() => bit6(0x00e3) == 1 && bit2(0x00e3) == 1 && bit0(0x00e3) == 1

function releaseFromGiantSpider() => bit6(0x017b) < prev(bit6(0x017b))

function reachMountainTop() => CharacterPosition["y"] == 3 && CharacterPosition["x"] >= 75 && CharacterPosition["x"] <= 84

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function addCompleteLevelAchievement(points, level, id) {
    achievement(
        id = id,
        title = format("King Of The Mountain {0}", RomanNumeralsConverter[level]),
        description = format("Complete level {0}", level),
        points = points,
        trigger = isGameActive() && isPlayerAlive() && bit2(0x03b8) != 1 && CurrentLevel + 1 == level 
                    && hasGoldenCrown() && trigger_when(reachMountainTop())
    )
}

addCompleteLevelAchievement(5, 1, 335596)
addCompleteLevelAchievement(5, 2, 335597)
addCompleteLevelAchievement(5, 3, 335598)
addCompleteLevelAchievement(10, 4, 335599)
addCompleteLevelAchievement(10, 5, 335600)
addCompleteLevelAchievement(10, 6, 335601)
addCompleteLevelAchievement(10, 7, 335602)
addCompleteLevelAchievement(25, 8, 335603)

function addCollectDiamondsAchievement(points, title, diamonds, id) {
    achievement(
        id = id,
        title = title,
        description = format("Collect {0} 000 diamonds", diamonds / 1000),
        points = points,
        trigger = isGameActive() && isPlayerAlive() && measured(getScore() >= diamonds)
    )
}

addCollectDiamondsAchievement(3, "Beginner Explorer", 10000, 335604)
addCollectDiamondsAchievement(5, "Amateur Explorer", 20000, 335605)
addCollectDiamondsAchievement(10, "Advanced Explorer", 40000, 335606)
addCollectDiamondsAchievement(25, "Veteran Explorer", 80000, 335607)

achievement(
    id = 335588,
    title = "Giant Spider",
    description = "Release from the Giant Spider's web 5 times",
    points = 10,
    trigger = isGameActive() && measured(repeated(5, releaseFromGiantSpider())) && never(isPlayerKilled())
)

achievement(
    id = 335609,
    title = "Golden Crown",
    description = "Collect 5 Golden Crowns in one level",
    points = 10,
    trigger = isGameActive() && measured(repeated(5, GoldenCrowns > prev(GoldenCrowns))) && never(isPlayerKilled())
)

achievement(
    id = 335608,
    title = "Small Treasure Chest",
    description = "Collect 10 Treasure Chests (only scored ones count)",
    points = 10,
    trigger = isGameActive() && measured(repeated(10, isTreasureChestTaken())) && never(isPlayerKilled())
)

achievement(
    id = 335610,
    title = "Large Treasure Chest",
    description = "Collect 20 Treasure Chests (only scored ones count)",
    points = 25,
    trigger = isGameActive() && measured(repeated(20, isTreasureChestTaken())) && never(isPlayerKilled())
)

achievement(
    id = 335611,
    title = "Cave Bat",
    description = "Complete any level without losing the crown",
    points = 10,
    trigger = isGameActive() && isPlayerAlive() && hasGoldenCrown() && GoldenCrowns == 1 && trigger_when(reachMountainTop())
)

achievement(
    id = 335612,
    title = "Flashlight",
    description = "Complete any level without using a flashlight",
    points = 10,
    trigger = isGameActive() && never(isPlayerKilled()) && disable_when(once(isFlashlightUsed()), isGameStarted()) 
                && hasGoldenCrown() && trigger_when(reachMountainTop())
)

achievement(
    id = 346814,
    title = "[Tutorial] Diamond Fever",
    description = "Get 1000 points (now you can find the Flame Spirit)",
    points = 1,
    trigger = isGameActive() && isPlayerAlive() && measured(getScore() >= 1000)
)
    
achievement(
    id = 346815,
    title = "[Tutorial] I Am On Fire",
    description = "Get Flame Spirit (now you can go to the temple and put flame between columns)",
    points = 1,
    trigger = isGameActive() && isPlayerAlive() && once(isFlameSpiritIsActive())
)

achievement(
    id = 346816,
    title = "[Tutorial] Open Sesame",
    description = "Give Flame Spirit to Skull Spirit (now you can take your first crown)",
    points = 1,
    trigger = isGameActive() && isPlayerAlive() && once(FlameSpirits > 0)
)

achievement(
    id = 346817,
    title = "[Tutorial] Great Escape",
    description = "Get the Crown (now you can go to the top of the mountain, be aware of bats)",
    points = 1,
    trigger = isGameActive() && isPlayerAlive() && once(GoldenCrowns > 0)
)

// -----------------------------------------------------------------------------
// RICH PRESENCE

rich_presence_conditional_display(getScore() == 0, "Starting the exploration...")
rich_presence_display(
    "⛰️ {0} • 🔥 {1} • 👑 {2} • 🎁 {3} • 💎{4}",
    rich_presence_value("Level", CurrentLevel + 1, "VALUE"),
    rich_presence_value("Golden Crowns", GoldenCrowns, "VALUE"),
    rich_presence_value("Flame Spirits", FlameSpirits, "VALUE"),
    rich_presence_value("Treasure Chests", isTreasureChestTaken() && never(isGameStarted()), "VALUE"),
    rich_presence_value("Diamonds", getScore(), "VALUE")

)

// -----------------------------------------------------------------------------
// LEADERBOARDS

leaderboard(
    id = 70542,
    title = "Diamond Rush",
    description = "Get as many diamonds as you can before you die",
    start = getScore() > 0,
    cancel = isGameStarted(),
    submit = isPlayerKilled(),
    value = getScore(),
    format= "VALUE",
    lower_is_better = false
)

leaderboard(
    id = 70541,
    title = "Treasure Hunter",
    description = "Get as many treasure chests as you can before you die",
    start = isTreasureChestTaken(),
    cancel = isGameStarted(),
    submit = isPlayerKilled(),
    value = isTreasureChestTaken(),
    format= "VALUE",
    lower_is_better = false
)
