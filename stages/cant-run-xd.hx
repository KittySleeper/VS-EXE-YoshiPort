var greenhill;
var sonic:Character = null;
var bfp;

var stage:Stage = null;

function create() {
	stage = loadStage('cant-run-xd');

	greenhill = new FlxSprite(321.5, 122.65).loadGraphic(Paths.image("stages/cant-run-xd/GreenHill"));
    greenhill.scale.set(8, 8);
    greenhill.visible = false;
    add(greenhill);

	sonic = new Character(-45, 120, mod + ":pixelrunsonic");
	sonic.visible = false;
	dads.push(sonic);
	add(sonic);

	bfp = new Character(685, 50, mod + ":bfpickel");
	bfp.visible = false;
	bfp.flipX = false;
	boyfriends.push(bfp);
	add(bfp);
}

function update(elapsed) {
	stage.update(elapsed);

	if (greenhill.visible)
		camFollow.setPosition(430, 285);
}

function beatHit(curBeat) {
	stage.onBeat();
}

function onPsychEvent(event:String, v1:Dynamic, v2:Dynamic) {
    switch(event) {
        case "Genesis":
			for (spr in [greenhill, sonic, bfp])
				spr.visible = v1 == "1";
    }
}