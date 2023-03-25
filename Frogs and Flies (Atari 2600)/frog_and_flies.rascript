// Frogs and Flies
// #ID = 20375

// -----------------------------------------------------------------------------
// VARIABLES

// Frog points in BCD
GrayFrogPoints = high4(0x003b) * 10 + low4(0x003b)
RedFrogPoints = high4(0x003c) * 10 + low4(0x003c)

// 1 - FIXED ARC (Easy), 0 - DIRECTIONS + TONGUE (Hard)
GrayFrogDifficultLevel = bit7(0x0043)
RedFrogDifficultLevel = bit7(0x0044)

// After 10 second of inactive AI will take control frog
GrayFrogControlledByAI = bit6(0x0043)
RedFrogControlledByAI = bit6(0x0044)

GrayFrogJumping = byte(0x005b)
RedFrogJumping = byte(0x005c)

GrayFrogFellIntoThePond = bit1(0x0043)
RedFrogFellIntoThePond = bit1(0x0044)

TimeOfDayCurrentPeriod = byte(0x0037)
TimeOfDayTimer = byte(0x0038)

TimeOfDayPeriods = {
    7: "Dawn",
    6: "Morning",
    5: "Midday",
    4: "Afternoon",
    3: "Twilight",
    2: "Evening",
    1: "Night"
}

EasyMode = 1
HardMode = 0

// -----------------------------------------------------------------------------
// FUNCTIONS

function isGameEnded() => bit0(0x0034) == 1 || bit7(0x0034) == 1

function isGameStarted() => TimeOfDayCurrentPeriod == 0x07 && TimeOfDayTimer == 0x1a

function resetGameWhenStarts() {
    return never(isGameStarted())
}

function checkFrogIsControlledByAI(frogControlledFlag) {
    return disable_when(
        unless(once(frogControlledFlag == 1)),
        resetGameWhenStarts()
    )
}

function checkFrogIsControlledByPlayer(frogControlledFlag) {
    return disable_when(
        unless(repeated(600, frogControlledFlag != 1)),
        resetGameWhenStarts()
    )
}

function checkFrogDifficultLevelChanged(frogDifficultLevel, difficultLevel) {
    return disable_when(
        unless(once(frogDifficultLevel != difficultLevel)),
        resetGameWhenStarts()
    )
}

function checkFrogFellIntoThePond(frogFellIntoThePond) {
    return disable_when(
        unless(once(frogFellIntoThePond == 1)),
        resetGameWhenStarts()
    )
}

// -----------------------------------------------------------------------------
// ACHIEVEMENTS

function addHitPointsAchievement(difficult, title, points, reward, id) {
    achievement(
        id = id,
        title = title,
        description = format("Hit at least {0} points", points),
        points = reward,
        trigger = GrayFrogPoints >= points
            && checkFrogIsControlledByAI(GrayFrogControlledByAI)
            && checkFrogDifficultLevelChanged(GrayFrogDifficultLevel, difficult)
            || RedFrogPoints >= points
            && checkFrogIsControlledByAI(RedFrogControlledByAI)
            && checkFrogDifficultLevelChanged(RedFrogDifficultLevel, difficult)
    )
}

addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher I", 30, 1, 302713)
addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher II", 60, 2, 302714)
addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher III", 99, 4, 302715)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher I", 30, 2, 302716)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher II", 60, 3, 302717)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher III", 99, 5, 302718)

function addWinTheGameAchievement(difficult, reward, id) {
    label = "Easy"
    if (difficult == HardMode) {
        label = "Hard"
    }

    achievement(
        id = id,
        title = format("[{0}] The Frog King", label),
        description = "Win the game",
        points = reward,
        trigger = resetGameWhenStarts() 
            && isGameEnded() 
            && (
                GrayFrogPoints > RedFrogPoints 
                && checkFrogIsControlledByAI(GrayFrogControlledByAI)
                && checkFrogIsControlledByPlayer(RedFrogControlledByAI)
                && checkFrogDifficultLevelChanged(GrayFrogDifficultLevel, difficult)
                || RedFrogPoints > GrayFrogPoints
                && checkFrogIsControlledByAI(RedFrogControlledByAI)
                && checkFrogIsControlledByPlayer(GrayFrogControlledByAI)
                && checkFrogDifficultLevelChanged(RedFrogDifficultLevel, difficult)
            )
    )
}

addWinTheGameAchievement(EasyMode, 2, 302719)
addWinTheGameAchievement(HardMode, 3, 302720)

achievement(
    id = 302721,
    title = "[Hard] Sugar Frog",
    description = "Win the game without touching the right lily pad",
    points = 10,
    trigger = resetGameWhenStarts() 
        && isGameEnded() 
        && (
            GrayFrogPoints > RedFrogPoints 
            && checkFrogIsControlledByAI(GrayFrogControlledByAI)
            && checkFrogDifficultLevelChanged(GrayFrogDifficultLevel, HardMode)
            && checkFrogIsControlledByPlayer(RedFrogControlledByAI)
            && checkFrogFellIntoThePond(GrayFrogFellIntoThePond)
            || RedFrogPoints > GrayFrogPoints
            && checkFrogIsControlledByAI(RedFrogControlledByAI)
            && checkFrogIsControlledByPlayer(GrayFrogControlledByAI)
            && checkFrogDifficultLevelChanged(RedFrogDifficultLevel, HardMode)
            && checkFrogFellIntoThePond(RedFrogFellIntoThePond)
        )
)

function addEatTwoFliesInSingleJumpAchievement(difficult, reward, id) {
    label = "Easy"
    if (difficult == HardMode) {
        label = "Hard"
    }

    achievement(
        id = id,
        title = format("[{0}] Fly devourer", label),
        description = "As a Gray Frog Eat two flies in a single jump",
        points = reward,
        trigger = measured(repeated(2, GrayFrogPoints > prev(GrayFrogPoints)))
            && never(GrayFrogJumping == 0xb7)
            && checkFrogIsControlledByAI(GrayFrogControlledByAI)
            && checkFrogDifficultLevelChanged(GrayFrogDifficultLevel, difficult)
    )
}

addEatTwoFliesInSingleJumpAchievement(EasyMode, 3, 302722)
addEatTwoFliesInSingleJumpAchievement(HardMode, 5, 302712)

// -----------------------------------------------------------------------------
// RICH PRESENCE

rich_presence_conditional_display(isGameEnded() && GrayFrogPoints == 0 && RedFrogPoints == 0, "The End | There is no winner here")
rich_presence_conditional_display(isGameEnded() && GrayFrogPoints == RedFrogPoints, "The End | The game ended in a tie")
rich_presence_conditional_display(isGameEnded() && GrayFrogPoints > RedFrogPoints, "The End | Gray Frog wins")
rich_presence_conditional_display(isGameEnded() && RedFrogPoints > GrayFrogPoints, "The End | Red Frog wins")
rich_presence_display(
    "Gray Frog {0} - Red Frog {1} | {2}",
    rich_presence_value("Gray Frog", GrayFrogPoints, "VALUE"),
    rich_presence_value("Red Frog", RedFrogPoints, "VALUE"),
    rich_presence_lookup("Period", TimeOfDayCurrentPeriod, TimeOfDayPeriods)
)

leaderboard(
    id = 61706,
    title = "Perfect Team Play",
    description = "Play with a friend and collect as many points as possible",
    start = isGameStarted(),
    cancel = GrayFrogControlledByAI == 1 || RedFrogControlledByAI == 1,
    submit = isGameEnded(),
    value = GrayFrogPoints + RedFrogPoints,
    format= "VALUE",
    lower_is_better = false
)
