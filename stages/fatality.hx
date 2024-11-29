function create() {
    gf.kill();
    defaultCamZoom = 0.75;

    var launchBase = new FlxSprite(-200, 100);
    launchBase.frames = Paths.getSparrowAtlas("stages/fatal/launchbase");
    launchBase.animation.addByIndices('idle', 'idle', [0, 1, 2, 3, 4, 5, 6, 8, 9], "", 12);
    launchBase.animation.play("idle");
    launchBase.setGraphicSize(launchBase.width * 5);
    add(launchBase);
}