cpuIgnore = true;
hitOnBotplay = false;
enableRating = false;

function create() {
    note.frames = Paths.getSparrowAtlas("notes/PHANTOMNOTE_assets");
    note.colored = false;
    var stupidColors = ["purple", "blue", "green", "red"];
    note.animation.addByPrefix("note", stupidColors[note.noteData % 4]);
    note.animation.play("note");
    note.setGraphicSize(Std.int(note.width * 0.7));
    note.offset.x += 30;
    note.splashColor = 0xFF000000;
}

function onMiss() {
}

function onPlayerHit(noteData) {
    PlayState.health -= 0.25;
    PlayState.misses++;
    PlayState.songScore -= 500;
}