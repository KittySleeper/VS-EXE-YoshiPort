import flixel.FlxState;
import flixel.FlxObject;

var selectedItem = 0;
var camFollow:FlxObject;
var menuItems:Array<FlxSprite> = [];
var optionShit:Array<String> = ['story_mode', 'encore', 'freeplay', 'sound_test', 'options', 'extras'];
var stateShit:Array<FlxState> = [new StoryMenuState(), new ModState("EncoreState"), new ModState("FreeplayState"), new ModState("SoundTestState"), new options.screens.OptionMain(), new ModState("ExtrasState")];

function create() {
    camFollow = new FlxObject(0, 0, 1, 1);
    add(camFollow);
    
	var bg:FlxSprite = new FlxSprite();
	bg.frames = Paths.getSparrowAtlas('menus/mainmenu/bg');
	bg.animation.addByPrefix('a', 'BG instance 1');
	bg.animation.play('a', true);
	bg.scrollFactor.set();
	bg.updateHitbox();
	bg.screenCenter();
	bg.antialiasing = true;
	add(bg);

    var xval:Int = 585;

	for (i in 0...optionShit.length) {
		var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
		var menuItem:FlxSprite = new FlxSprite(xval, (i * 100) + offset);
		menuItem.frames = Paths.getSparrowAtlas('menus/mainmenu/menu_' + optionShit[i]);
		menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
		menuItem.animation.addByPrefix('lock', optionShit[i] + " locked", 24);
		menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
		menuItem.animation.play('idle');
		menuItem.ID = i;
		menuItems.push(menuItem);
		add(menuItem);

		var scr:Float = (optionShit.length - 4) * 0.135;
		menuItem.scrollFactor.set(0, scr);
		menuItem.updateHitbox();
		xval = xval + 70;
	}

    FlxG.camera.follow(camFollow, null, 0.85);

	changeSelection(0);
}

function update(elapsed) {
    if (controls.UP_P)
        changeSelection(-1);

    if (controls.DOWN_P)
        changeSelection(1);

    if (controls.ACCEPT)
        FlxG.switchState(stateShit[selectedItem]);

    if (FlxG.keys.justPressed.SEVEN)
		FlxG.switchState(new dev_toolbox.ToolboxMain());
}

function changeSelection(amt) {
    FlxG.sound.play(Paths.sound("scrollMenu"));

	menuItems[selectedItem].animation.play('idle');

	selectedItem += amt;
    if (selectedItem < 0)
        selectedItem = optionShit.length - 1;
    if (selectedItem >= optionShit.length)
        selectedItem = 0;

	menuItems[selectedItem].animation.play('selected');
    camFollow.setPosition(menuItems[selectedItem].getGraphicMidpoint().x, menuItems[selectedItem].getGraphicMidpoint().y);
}