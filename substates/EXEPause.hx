import flixel.FlxCamera;
import flixel.ui.FlxBar;

var pauseCam;
var shaderLmao = new CustomShader(Paths.shader("greyscale"));
var curSelected = 0;
var menuItems = ["resume", "RestartSong", "Exittomenu"];
var menuSprites = [];
var mhhxenoharder;

function create() {
	trace("ttsgyatt");

	pauseCam = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
	pauseCam.bgColor = new FlxColor(0x00000000);
	FlxG.cameras.add(pauseCam, true);

	FlxG.state.camHUD.addShader(shaderLmao);
	FlxG.state.camGame.addShader(shaderLmao);

	var pauseTop = new FlxSprite(-500).loadGraphic(Paths.image("pauseStuff/pauseTop"));
	pauseTop.cameras = [pauseCam];
	FlxTween.tween(pauseTop, {x: 0}, 0.2, {ease: FlxEase.quadOut});
	add(pauseTop);

	var pauseBottom = new FlxSprite(900, FlxG.height * 0.05 + if (FlxG.scaleMode.isWidescreen) 0 else 220).loadGraphic(Paths.image("pauseStuff/bottomPanel"));
	pauseBottom.cameras = [pauseCam];
	FlxTween.tween(pauseBottom, {x: 600}, 0.2, {ease: FlxEase.quadOut});
	add(pauseBottom);

	var timeBarBG = new FlxSprite(200, 200).loadGraphic(Paths.image("timeBar"));
	timeBarBG.cameras = [pauseCam];
	add(timeBarBG);

	timeBar = new FlxBar(timeBarBG.x + 2, timeBarBG.y + 2, "LEFT_TO_RIGHT", timeBarBG.width - 4, timeBarBG.height - 4, Conductor, "songPosition", 0,
		FlxG.sound.music.length);
	timeBar.createFilledBar(0xff000000, 0xffff0000);
	timeBar.cameras = [pauseCam];
	insert(2, timeBar);

	var icon = FlxG.state.iconP2.clone();
	icon.x -= 500;
	icon.y = 130;
	FlxTween.tween(icon, {x: 90}, 0.2, {ease: FlxEase.quadOut});
	icon.cameras = [pauseCam];
	add(icon);

	var icon2 = FlxG.state.iconP1.clone();
	icon2.x += 1000;
	icon2.y = 130;
	FlxTween.tween(icon2, {x: 500}, 0.2, {ease: FlxEase.quadOut});
	icon2.cameras = [pauseCam];
	add(icon2);

    mhhxenoharder = new FlxSprite(905, 465 + if (FlxG.scaleMode.isWidescreen) 0 else 220).loadGraphic(Paths.image("pauseStuff/graybut"));
    mhhxenoharder.cameras = [pauseCam];
    add(mhhxenoharder);

	var itemIndex = -1;

	for (item in menuItems) {
		itemIndex++;

		var sprBG = new FlxSprite(2100, 450 + (90 * itemIndex) + if (FlxG.scaleMode.isWidescreen) 0 else 220).loadGraphic(Paths.image("pauseStuff/blackbut"));
		sprBG.cameras = [pauseCam];
        menuSprites.push(sprBG);
		add(sprBG);

		var spr = new FlxSprite(2000, 450 + (90 * itemIndex) + if (FlxG.scaleMode.isWidescreen) 0 else 220).loadGraphic(Paths.image("pauseStuff/" + item));
		spr.cameras = [pauseCam];
		add(spr);

        FlxTween.tween(spr, {x: 900 - (65 * itemIndex)}, 0.2, {ease: FlxEase.quadOut});
        FlxTween.tween(sprBG, {x: 890 - (65 * itemIndex)}, 0.2, {ease: FlxEase.quadOut});
	}
}

function update(elapsed) {
    if (controls.UP_P)
        switchItem(-1);
    if (controls.DOWN_P)
        switchItem(1);
    if (controls.ACCEPT) {
        switch (menuItems[curSelected]) {
            case "resume":
                FlxG.state.camHUD.removeShader(shaderLmao);
                FlxG.state.camGame.removeShader(shaderLmao);
                FlxG.state.closeSubState();
            case "RestartSong":
                FlxG.resetState();
            case "Exittomenu":
                FlxG.switchState(new MainMenuState());
        }
    }
}

function switchItem(amt) {
    curSelected += amt;

    if (curSelected >= menuItems.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = menuItems.length - 1;

    mhhxenoharder.setPosition(menuSprites[curSelected].x + 15, menuSprites[curSelected].y + 15);
}