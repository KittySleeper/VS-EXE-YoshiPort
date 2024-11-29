import LoadingState;

var songs = ["too-slow", "you-cant-run", "triple-trouble"];
var songPortrait;
var staticLmao;

var staticTween;

var curSelected = 0;

function create() {
    if (FlxG.save.data.storyProgress == null)
        FlxG.save.data.storyProgress = 0;

    var bg = new FlxSprite();
    bg.frames = Paths.getSparrowAtlas("menus/story/SMMStatic");
    bg.animation.addByPrefix("idle", "d");
    bg.animation.play("idle");
    add(bg);

    var greybox = new FlxSprite().loadGraphic(Paths.image("menus/story/greybox"));
    greybox.scale.set(0.65, 0.65);
    greybox.screenCenter();
    add(greybox);

    var redbox = new FlxSprite().loadGraphic(Paths.image("menus/story/redbox"));
    redbox.scale.set(0.65, 0.65);
    redbox.screenCenter();
    add(redbox);

    var boyfriend = new Boyfriend(425, -100);
    boyfriend.animation.curAnim.looped = true;
    boyfriend.scale.set(0.45, 0.45);
    add(boyfriend);

    songPortrait = new FlxSprite(-5, -136);
    add(songPortrait);

    staticLmao = new FlxSprite(-5, -135);
    staticLmao.frames = Paths.getSparrowAtlas("static");
    staticLmao.animation.addByPrefix("idle", "screen", 24);
    staticLmao.animation.play("idle");
    staticLmao.alpha = 0.35;
    staticLmao.scale.set(0.27, 0.27);
    add(staticLmao);

    var yellowbox = new FlxSprite().loadGraphic(Paths.image("menus/story/yellowbox"));
    yellowbox.scale.set(0.65, 0.65);
    yellowbox.screenCenter();
    yellowbox.x -= 5;
    yellowbox.y -= 5;
    add(yellowbox);

    changeSelection(0);
}

function update(elapsed) {
    if (controls.LEFT_P)
        changeSelection(-1);
    if (controls.RIGHT_P)
        changeSelection(1);
    if (controls.ACCEPT) {
        FlxG.sound.play(Paths.sound("confirmMenu"));

        new FlxTimer().start(1, function(tmr) {
            CoolUtil.loadSong(mod, songs[curSelected], "hard");
            LoadingState.loadAndSwitchState(new PlayState());    
        });
    }
    if (controls.BACK)
        FlxG.switchState(new MainMenuState());
}

function changeSelection(amt) {
    if (amt != 0)
        FlxG.sound.play(Paths.sound("scrollMenu"));

    curSelected += amt;

    // if (curSelected > FlxG.save.data.storyProgress)
    //     curSelected = 0;
    // if (curSelected < 0)
    //     curSelected = FlxG.save.data.storyProgress;

    songPortrait.loadGraphic(Paths.image("menus/freeplay/fpstuff/" + songs[curSelected]));
    songPortrait.setGraphicSize(songPortrait.width * 0.27);

    if (staticTween != null)
        staticTween.cancel();

    staticLmao.alpha = 1;

    // if (FlxG.save.data.storyProgress != 0)
    staticTween = FlxTween.tween(staticLmao, {alpha: 0.35}, 0.75);
}