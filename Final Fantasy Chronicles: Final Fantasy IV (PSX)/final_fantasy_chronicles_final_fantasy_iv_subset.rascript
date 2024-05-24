// Final Fantasy Chronicles: Final Fantasy IV [Rare Drops]
// #ID = 29038

FIRST_DROP_ITEM_ID = 0xe2328
LAST_DROP_ITEM_ID = 0xe2336

DropItems = array_map(range(FIRST_DROP_ITEM_ID, LAST_DROP_ITEM_ID, 2), dropItem => byte(dropItem))

function isBattleWon() => bit5(0xd00a8) == 1

function addRareDropAchievement(id, points, item, name, title) {
    achievement(
        id = id,
        title = title,
        description = format("Obtain the {0}", name),
        points = points,
        trigger = isBattleWon() && any_of(DropItems, dropItem => dropItem == item && prev(dropItem) != item)
    )
}

addRareDropAchievement(415631, 25, 0xe7, "Imp Summon", "Imp Summon")
addRareDropAchievement(415632, 25, 0xe8, "Bomb Summon", "Bomb Summon")
addRareDropAchievement(415633, 25, 0xea, "Mage Summon", "Mage Summon")
addRareDropAchievement(415634, 25, 0xe9, "Cocatris Summon", "Cocatris Summon")
addRareDropAchievement(415635, 25, 0xca, "Grimoire", "Grimoire")
addRareDropAchievement(415636, 25, 0x80, "Glass Helmet", "Glass Helmet")
addRareDropAchievement(415637, 50, 0x53, "Artemis Bow", "Artemis Bow")
addRareDropAchievement(415638, 25, 0x0e, "Lilith Rod", "Lilith Rod")
addRareDropAchievement(415639, 25, 0x22, "Gorgon Sword", "Gorgon Sword")
addRareDropAchievement(415640, 25, 0x48, "Rune Axe", "Rune Axe")
addRareDropAchievement(415641, 25, 0xaf, "Cursed Ring", "Cursed Ring")
addRareDropAchievement(415642, 25, 0xac, "Crystal Ring", "Crystal Ring")
addRareDropAchievement(415643, 10, 0x94, "Power Vest", "Power Vest")
addRareDropAchievement(415645, 10, 0x37, "Serpent Whip", "Serpent Whip")
addRareDropAchievement(415647, 25, 0xf9, "Pink Tail", "Pink Tail")
