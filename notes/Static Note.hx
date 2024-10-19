enableRating = true;
colored = false;

function create() {
    note.frames = Paths.getSparrowAtlas("notes/STATICNOTE_assets");
    var stupidColors = ["purple", "blue", "green", "red"];
    note.animation.addByPrefix("scroll", stupidColors[note.noteData % 4]);
    note.setGraphicSize(Std.int(note.width * 0.7));
    note.offset.x += 30;
    note.splashColor = 0xFFFF0101;
}

function onMiss(dir) {
    PlayState.noteMiss(dir);

    var shit = new FlxSprite();
    shit.frames = Paths.getSparrowAtlas("hitStatic");
    shit.animation.addByPrefix("static", "staticANIMATION", 24, false);
    shit.animation.play("static");
    shit.cameras = [camHUD];
    shit.scale.set(1.2, 1.2);
    shit.screenCenter();
    add(shit);

    new FlxTimer().start(1, function(timer) {
        shit.destroy();
    });

    FlxG.sound.play(Paths.sound("game/hitStatic1"));
}