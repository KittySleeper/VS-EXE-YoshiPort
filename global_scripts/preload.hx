var preloadingShit = [
    "default" => {spritesheets: ["hitStatic"], characters: []},
    "you-cant-run" => {spritesheets: [], characters: ["ycr-mad"]}
];

function createPost() {
    var songPreload = preloadingShit.get(PlayState.jsonSongName.toLowerCase());
    var defaultPreload = preloadingShit.get("default");

    if (songPreload == null)
        songPreload = {spritesheets: [], characters: []};

    var preloadChars = [];

    for (char in songPreload.characters)
        preloadChars.push(char);
    for (char in defaultPreload.characters)
        preloadChars.push(char);

    for (char in preloadChars) {
        var idkwhattocallthis = new Character(0, 0, char);
        idkwhattocallthis.alpha = 0.001;
        add(idkwhattocallthis);
    }

    var preloadSpritesheets = [];

    for (spr in songPreload.spritesheets)
        preloadSpritesheets.push(spr);
    for (spr in defaultPreload.spritesheets)
        preloadSpritesheets.push(spr);

    for (spr in preloadSpritesheets) {
        var idkwhattocallthis = new FlxSprite();
        idkwhattocallthis.frames = Paths.getSparrowAtlas(spr);
        idkwhattocallthis.alpha = 0.001;
        add(idkwhattocallthis);
    }
}