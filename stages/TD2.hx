var stage:Stage = null;

function create() {
	stage = loadStage('TD2');
	stage.getSprite("shadow").blend = "darken";
}

function update(elapsed) {
	stage.update(elapsed);

	camFollow.x = 995;
	camFollow.y = 750;
}

function beatHit(curBeat) {
	stage.onBeat();
}

function holyFuckingShitImScared() {
	FlxG.camera.flash(0xffff0000);
	stage.getSprite("blod").alpha = 1;
}