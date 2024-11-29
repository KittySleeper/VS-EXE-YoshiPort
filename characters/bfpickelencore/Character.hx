function create() {
	character.loadGraphic(Paths.image("aseprite/bf"), true, 44, 44);
	character.animation.add("idle", [0, 1, 2, 3, 4, 5], 15, false);
    character.animation.add("singLEFT", [6, 7, 8], 15, false);
    character.animation.add("singDOWN", [9, 10], 15, false);
    character.animation.add("singUP", [13, 14], 15, false);
    character.animation.add("singRIGHT", [11, 12], 15, false);
	character.setGraphicSize(character.width * 7.5);

    character.charGlobalOffset.y = 335;
    character.flipX = true;
}