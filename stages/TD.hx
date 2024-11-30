var stage:Stage = null;

function create() {
	stage = loadStage('TD');

	var vcr = new CustomShader(Paths.shader("vcr"));
	camHUD.addShader(vcr);
	camGame.addShader(vcr);
}

function createPost() {
	var Static = new FlxSprite();
	Static.frames = Paths.getSparrowAtlas("stages/TD/daSTAT");
	Static.animation.addByPrefix("staitc", "staticFLASH");
	Static.animation.play("staitc");
	Static.cameras = [camHUD];
	Static.setGraphicSize(FlxG.width, FlxG.height);
	Static.screenCenter();
	Static.alpha = 0.05;
	add(Static);
}

function update(elapsed) {
	stage.update(elapsed);
}

function beatHit(curBeat) {
	stage.onBeat();
}