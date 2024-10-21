var greenhill;
var sonic:Character = null;
var bfp;

var scanline = new CustomShader(Paths.shader("scanline"));

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

			popupArrows = false;

			for (strum in cpuStrums)
				strum.kill();
			for (strum in playerStrums)
				strum.kill();

			cpuStrums.clear();
			playerStrums.clear();

			FlxG.state.generateStaticArrows(0);
			FlxG.state.generateStaticArrows(1);

			if (v1 == "1")
				camHUD.addShader(scanline);
			else
				camHUD.removeShader(scanline);
    }
}

function onGenerateStaticArrow(babyArrow, i, player) {
	if (greenhill.visible) {
		babyArrow.colored = false;
		
		babyArrow.loadGraphic(Paths.image('notes/pixel'), true, 17, 17);
		babyArrow.animation.add('green', [6]);
		babyArrow.animation.add('red', [7]);
		babyArrow.animation.add('blue', [5]);
		babyArrow.animation.add('purplel', [4]);
	
		babyArrow.setGraphicSize(Std.int(babyArrow.width * PlayState_.daPixelZoom));
		babyArrow.updateHitbox();
		babyArrow.antialiasing = false;
			
		var noteNumberScheme:Array<NoteDirection> = Note.noteNumberSchemes[PlayState.song.keyNumber];
		if (noteNumberScheme == null) noteNumberScheme = Note.noteNumberSchemes[4];
		switch (noteNumberScheme[i % noteNumberScheme.length])
		{
			case 0:
				babyArrow.animation.add('static', [0]);
				babyArrow.animation.add('pressed', [4, 8], 12, false);
				babyArrow.animation.add('confirm', [12, 16], 24, false);
			case 1:
				babyArrow.animation.add('static', [1]);
				babyArrow.animation.add('pressed', [5, 9], 12, false);
				babyArrow.animation.add('confirm', [13, 17], 24, false);
			case 2:
				babyArrow.animation.add('static', [2]);
				babyArrow.animation.add('pressed', [6, 10], 12, false);
				babyArrow.animation.add('confirm', [14, 18], 12, false);
			case 3:
				babyArrow.animation.add('static', [3]);
				babyArrow.animation.add('pressed', [7, 11], 12, false);
				babyArrow.animation.add('confirm', [15, 19], 24, false);
		}
	}
}