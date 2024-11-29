import Highscore;
import LoadingState;
import flixel.math.FlxMath;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;

var inSongSelection = false;

var curSelected = 0;
var songSelected = 0;
var songsLength = 0;
var songSelectedStr = "Too-Slow";

var characters = ["curse", "fatalerror", "b4cksl4sh", "starved", "coldsteel", "leaker"];
var charactersUnlocked = ["curse", "fatalerror", "b4cksl4sh", "starved", "leaker"];
var songsUnlocked = ["malediction", "fatality", "b4cksl4sh", "prey", "fight-or-flight", "traitor"];
var songs = [
    "curse" => ["Malediction", "Test"],
    "fatalerror" => ["Fatality"],
    "b4cksl4sh" => ["B4cksl4sh"],
    "starved" => ["Prey", "Fight-Or-Flight"],
    "coldsteel" => ["Personel"],
    "leaker" => ["Traitor"]
];

var charText;
var scoreText;
var songsTexts = [];

var stupidBoxs = [];
var characterPortraits = [];

var stupidTween;

function create() {
    if (FlxG.save.data.charsUnlocked == null) 
        FlxG.save.data.charsUnlocked = [];

    for (char in FlxG.save.data.charsUnlocked)
        if (!charactersUnlocked.contains(char))
            charactersUnlocked.push(char);

    for (char in songs.keys()) {
        for (song in songs.get(char)) {
            if (Highscore.getModScore(mod, song, "hard") > 0 && charactersUnlocked.contains(char.toLowerCase()) && !songsUnlocked.contains(song.toLowerCase()))
                songsUnlocked.push(song.toLowerCase());
        }
    }

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
        charIndex++;

        if (charactersUnlocked.contains(char)) {
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
        } else {
            var portrait = new FlxSprite(-330, (450 * charIndex) + 650).loadGraphic(Paths.image("menus/freeplay/fpstuff/locked"));
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
    songSelectedStr = songs.get(characters[curSelected])[songSelected];

    scoreText.visible = inSongSelection;
    scoreText.text = "Score " + Highscore.getModScore(mod, songSelectedStr, "hard");

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
            if (songsUnlocked.contains(songSelectedStr.toLowerCase()) && charactersUnlocked.contains(characters[curSelected].toLowerCase())) {
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;

                FlxG.camera.fade(0xFFffffff, 0.8);
                FlxG.sound.play(Paths.sound("confirmMenu"));

                new FlxTimer().start(1, function(tmr) {
                    CoolUtil.loadSong(mod, songSelectedStr, "hard");
                    LoadingState.loadAndSwitchState(new PlayState());    
                });
            } else {
                FlxG.sound.play(Paths.sound("deniedMOMENT"));
            }
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
    if (amt != 0)
        FlxG.sound.play(Paths.sound("scrollMenu"));

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

    charText.text = if (charactersUnlocked.contains(characters[curSelected].toLowerCase())) characters[curSelected].toUpperCase() else "???";

    for (i in 0...songs.get(characters[curSelected]).length + 1) {
        for (song in songsTexts) {
            songsTexts.remove(song);
            song.destroy();
        }
    }

    var songIndex = -1;

    for (song in songs.get(characters[curSelected])) {
        songIndex++;

        var text = new FlxText(350, (songIndex * 65) + 330, FlxG.width, if (songsUnlocked.contains(song.toLowerCase())) StringTools.replace(song, "-", " ") else "???", 45);
        text.scrollFactor.set();
        text.alignment = "center";
        songsTexts.push(text);
        add(text);    
    }
}

function changeSongSelection(amt) {
    destroyTween();

    if (amt != 0)
        FlxG.sound.play(Paths.sound("scrollMenu"));

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