function create() {
	character.loadGraphic(Paths.image("aseprite/xeno"), true, 35, 50);
	character.animation.add("idle", [0, 1, 2, 3, 4], 15, false);
	character.animation.add("singLEFT", [5, 6], 15, false);
	character.animation.add("singUP", [7, 8], 15, false);
	character.animation.add("singDOWN", [9, 10], 15, false);
	character.animation.add("singRIGHT", [11, 12], 15, false);
	character.setGraphicSize(character.width * 7.5);

	character.charGlobalOffset.y = 205;
	character.charGlobalOffset.x = 105;
}