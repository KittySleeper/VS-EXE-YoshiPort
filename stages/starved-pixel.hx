//had to copy most of this from the exe code cuz fucking flxbackdrop farted

import flixel.addons.display.FlxTiledSprite;

var bg;
var floor;

function create() {
	gf.kill();
	defaultCamZoom = 0.6;

	bg = new FlxTiledSprite(Paths.image('stages/starved/pixel/stardustBg'), 4608, 2832, true, true);
	bg.scrollFactor.set(0.4, 0.4);
    bg.screenCenter();
	add(bg);
}

function createPost() {
    floor = new FlxTiledSprite(Paths.image('stages/starved/pixel/stardustFloor'), 4608, 2832, true, true);
    floor.screenCenter();
    floor.y -= 410;
	add(floor);
}

function update(elapsed) {
	bg.scrollX -= (15 * bg.scrollFactor.x) * (elapsed / (1 / 120));
    floor.scrollX -= 15 * (elapsed / (1 / 120));
}