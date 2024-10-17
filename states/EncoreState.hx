import LoadingState;
import flixel.math.FlxMath;

var songs = [
    "too-slow-encore" => "too-slow",
    "you-cant-run-encore" => "you-cant-run"
];
var fuckyous = ["too-slow-encore", "you-cant-run-encore"];
var songsLength = 0;

var stupidBoxs = [];
var characterPortraits = [];

var songText;

var curSelected = 0;

function create() {
    var bg = new FlxSprite().loadGraphic(Paths.image("menus/freeplay/backgroundlool"));
    bg.setGraphicSize(1280, 720);
    bg.scrollFactor.set();
    bg.screenCenter();
    add(bg);

    var songIndex = -1;

    for (char in fuckyous) {
        songIndex++;

        var box = new FlxSprite(songIndex * 800).loadGraphic(Paths.image("menus/freeplay/FreeBox"));
        stupidBoxs.push(box);
        add(box);

        var portrait = new FlxSprite(songIndex * 800).loadGraphic(Paths.image("menus/freeplay/fpstuff/" + char));
        characterPortraits.push(portrait);
        add(portrait);
    }

    songText = new FlxText(0, 635, FlxG.width, "too-stupid", 35);
    songText.alignment = "center";
    songText.scrollFactor.set();
    add(songText);

    changeItem(0);

    songsLength = songIndex;
}

function update(elapsed) {
    if (controls.LEFT_P)
        changeItem(-1);
    if (controls.RIGHT_P)
        changeItem(1);
    if (controls.ACCEPT) {
        FlxTransitionableState.skipNextTransOut = true;

        FlxG.camera.fade(0xFFffffff, 0.8);

        new FlxTimer().start(1, function(tmr) {
            CoolUtil.loadSong(mod, songs.get(fuckyous[curSelected]), "encore");
            LoadingState.loadAndSwitchState(new PlayState());    
        });
    }
    if (controls.BACK)
        FlxG.switchState(new MainMenuState());

    FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, characterPortraits[curSelected].x, elapsed * 60 * 0.3);
}

function changeItem(amt) {
    curSelected += amt;

    if (curSelected < 0)
        curSelected = 0;
    if (curSelected >= songsLength)
        curSelected = songsLength;

    songText.text = songs.get(fuckyous[curSelected]);
}