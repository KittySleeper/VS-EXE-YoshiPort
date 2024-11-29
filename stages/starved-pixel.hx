//had to copy most of this from the exe code cuz fucking flxbackdrop farted

import flixel.addons.display.FlxTiledSprite;

var bg;
var floor;

function create() {
	gf.kill();

	bg = new FlxTiledSprite(Paths.image('stages/starved/pixel/stardustBg'), 4608, 2832, true, true);
	bg.scrollFactor.set(0.4, 0.4);
    bg.screenCenter();
	add(bg);
}

function createPost() {
    floor = new FlxTiledSprite(Paths.image('stages/starved/pixel/stardustFloor'), 4608, 2832, true, true);
    floor.screenCenter();
    floor.y -= 530;
	add(floor);

	for (obj in [bg, floor])
		obj.visible = false;
	camHUD.alpha = 0.001;
	dad.x -= 500;

	FlxG.camera.follow(boyfriend);
}

function update(elapsed) {
	bg.scrollX -= (15 * bg.scrollFactor.x) * (elapsed / (1 / 120));
    floor.scrollX -= 15 * (elapsed / (1 / 120));
}

function prestartPrey() {
	FlxTween.tween(FlxG.camera, {zoom: 1.5}, 1.5);
}

function startPreyShit() {
	FlxG.camera.flash();

	defaultCamZoom = 0.6;

	for (obj in [bg, floor])
		obj.visible = true;
}

function okayFrFrStart() {
	FlxTween.tween(camHUD, {alpha: 1}, 0.75);
	FlxTween.tween(dad, {x: dad.x + 500}, 0.85);

	FlxG.camera.follow(camFollow);
}