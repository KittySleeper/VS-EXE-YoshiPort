import Highscore;
import LoadingState;
import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;

var inSongSelection = false;

var curSelected = 0;
var songSelected = 0;
var songsLength = 0;

var characters = ["sonic.exe", "curse", "coldsteel"];
var charactersUnlocked = ["sonic.exe", "curse", "coldsteel"];
var songs = [
    "sonic.exe" => ["Too-Slow", "You-Cant-Run", "Triple-Trouble"],
    "curse" => ["Malediction", "Test"],
    "coldsteel" => ["Personel"]
];

var charText;
var scoreText;
var songsTexts = [];

var stupidBoxs = [];
var characterPortraits = [];

var stupidTween;

function create() {
    var bg = new FlxSprite().loadGraphic(Paths.image('menus/freeplay/backgroundlool'));
    bg.screenCenter();
    bg.setGraphicSize(1280, 720);
    bg.scrollFactor.set();
    add(bg);

    var scrollFuck = new FlxBackdrop(Paths.image("menus/freeplay/sidebar"), 0x10, -0.3, 0);
    scrollFuck.velocity.y = -55;
    scrollFuck.scrollFactor.set();
    add(scrollFuck);

    var stupidFuckingLine = new FlxSprite(300).makeGraphic(10, FlxG.height, 0xff000000); //this line is dumb
    stupidFuckingLine.scrollFactor.set();
	add(stupidFuckingLine);

    var charIndex = -1;

    for (char in characters) {
        if (charactersUnlocked.contains(char)) {
            charIndex++;

            var portrait = new FlxSprite(-330, (450 * charIndex) + 650).loadGraphic(Paths.image("menus/freeplay/fpstuff/" + char));
            portrait.setGraphicSize(Std.int(portrait.width / 1.7));
            portrait.ID = charIndex;
            characterPortraits.push(portrait);
            add(portrait);

            var box = new FlxSprite(-330, (450 * charIndex) + 650).loadGraphic(Paths.image("menus/freeplay/FreeBox"));
            box.setGraphicSize(Std.int(box.width / 1.7));
            box.ID = charIndex;
            stupidBoxs.push(box);
            add(box);
        }
    }

    songsLength = charIndex;

    charText = new FlxText(0, 25, FlxG.width, "MEOW", 45);
    charText.scrollFactor.set();
    charText.alignment = "center";
    add(charText);

    scoreText = new FlxText(0, 75, FlxG.width, "Score 0", 30);
    scoreText.scrollFactor.set();
    scoreText.alignment = "center";
    add(scoreText);

    changeSelection(0);
}

function update(elapsed) {
    scoreText.visible = inSongSelection;
    scoreText.text = "Score " + Highscore.getModScore(mod, songsTexts[songSelected].text, "hard");

    if (controls.UP_P) {
        if (inSongSelection)
            changeSongSelection(-1);
        else
            changeSelection(-1);
    }

    if (controls.DOWN_P) {
        if (inSongSelection)
            changeSongSelection(1);
        else
            changeSelection(1);
    }

    if (controls.ACCEPT) {
        if (inSongSelection) {
            FlxG.camera.fade(0xFFffffff, 0.4);

            CoolUtil.loadSong(mod, songsTexts[songSelected].text, "hard");
            LoadingState.loadAndSwitchState(new PlayState());
        } else {
            changeSongSelection(0);
            inSongSelection = true;
        }
    }

    if (controls.BACK) {
        if (inSongSelection) {
            inSongSelection = false;
            destroyTween();
        } else
            FlxG.switchState(new MainMenuState());
    }

    FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, characterPortraits[curSelected].y, elapsed * 60 * 0.2);
}

function changeSelection(amt) {
    curSelected += amt;

    if (curSelected > songsLength)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = songsLength;

    for (box in stupidBoxs) {
        if (box.ID != curSelected)
            box.alpha = 0.5;
        else 
            box.alpha = 1;
    }

    for (char in characterPortraits) {
        if (char.ID != curSelected)
            char.alpha = 0.5;
        else
            char.alpha = 1;
    }

    charText.text = characters[curSelected].toUpperCase();

    for (i in 0...songs.get(characters[curSelected]).length + 1) {
        for (song in songsTexts) {
            songsTexts.remove(song);
            song.destroy();
        }
    }

    var songIndex = -1;

    for (song in songs.get(characters[curSelected])) {
        songIndex++;

        var text = new FlxText(350, (songIndex * 65) + 330, FlxG.width, song, 45);
        text.scrollFactor.set();
        text.alignment = "center";
        songsTexts.push(text);
        add(text);    
    }
}

function changeSongSelection(amt) {
    destroyTween();

    songSelected += amt;

    if (songSelected >= songs.get(characters[curSelected]).length)
        songSelected = 0;
    if (songSelected < 0)
        songSelected = songs.get(characters[curSelected]).length - 1;

    stupidTween = FlxTween.tween(songsTexts[songSelected], {alpha: 0.35}, 0.3, {type: 4});
}

function destroyTween() {
    if (stupidTween != null) 
        stupidTween.cancel();

    songsTexts[songSelected].alpha = 1;
}