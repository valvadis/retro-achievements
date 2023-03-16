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

GrayFrogPosition = byte(0x002a)
RedFrogPosition = byte(0x002c)

GrayFrogFellIntoThePond = bit1(0x0043)
RedFrogFellIntoThePond = bit1(0x0044)

TimeOfDayPeriod = byte(0x0037)
TimeOfDayTimer = byte(0x0038)

EasyMode = 1
HardMode = 0

// -----------------------------------------------------------------------------
// FUNCTIONS

function resetGameWhenStarts() {
    return never(
        GrayFrogPoints == 0
        && RedFrogPoints == 0
        && TimeOfDayPeriod == 0x07
        && TimeOfDayTimer == 0x1a
    )
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

function addHitPointsAchievement(difficult, title, points, reward) {
    achievement(
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

addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher I", 30, 1)
addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher II", 60, 2)
addHitPointsAchievement(EasyMode, "[Easy] Flies Catcher III", 99, 4)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher I", 30, 2)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher II", 60, 3)
addHitPointsAchievement(HardMode, "[Hard] Flies Catcher III", 99, 5)

function isGameEnded() {
    return TimeOfDayPeriod == 0x01
        && TimeOfDayTimer == 0x01
}

function addWinTheGameAchievement(difficult, reward) {
    label = "Easy"
    if (difficult == HardMode) {
        label = "Hard"
    }

    achievement(
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

addWinTheGameAchievement(EasyMode, 2)
addWinTheGameAchievement(HardMode, 3)

achievement(
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

function addEatTwoFliesInSingleJumpAchievement(difficult, reward) {
    label = "Easy"
    if (difficult == HardMode) {
        label = "Hard"
    }

    achievement(
        title = format("[{0}] Fly devourer", label),
        description = "Eat two flies in a single jump",
        points = reward,
        trigger = repeated(2, GrayFrogPoints > prev(GrayFrogPoints))
            && never(GrayFrogPosition == 0xa9)
            && checkFrogIsControlledByAI(GrayFrogControlledByAI)
            && checkFrogDifficultLevelChanged(GrayFrogDifficultLevel, difficult)
            || repeated(2, RedFrogPoints > prev(RedFrogPoints))
            && never(RedFrogPosition == 0xa9)
            && checkFrogIsControlledByAI(RedFrogControlledByAI)
            && checkFrogDifficultLevelChanged(RedFrogDifficultLevel, difficult)
    )
}

addEatTwoFliesInSingleJumpAchievement(EasyMode, 3)
addEatTwoFliesInSingleJumpAchievement(HardMode, 5)
