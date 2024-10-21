function createPost() {
    for (text in [levelInfo, levelDifficulty, blueballAmount])
        text.kill();

    openSubState(new ModSubState("EXEPause"));
}