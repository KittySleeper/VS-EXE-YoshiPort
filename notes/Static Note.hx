enableRating = true;

function create() {
    note.frames = Paths.getSparrowAtlas("notes/STATICNOTE_assets");
    note.colored = false;
    var stupidColors = ["purple", "blue", "green", "red"];
    note.animation.addByPrefix("note", stupidColors[note.noteData % 4]);
    note.animation.play("note");
    note.setGraphicSize(Std.int(note.width * 0.7));
    note.offset.x += 30;
}