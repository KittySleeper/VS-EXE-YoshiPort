import LoadingState;

var storySongs = ["too-slow", "you-cant-run", "triple-trouble"];

function onPreEndSong() {
    if (storySongs.contains(curSong)) {
        FlxG.save.data.storyProgress++;

        CoolUtil.loadSong(mod, songs[FlxG.save.data.storyProgress], "hard");
        LoadingState.loadAndSwitchState(new PlayState());
    }
}