function create() {
    gf.kill();
    defaultCamZoom = 0.9;

    dad.y += 150;

    var void = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2);
    void.screenCenter();
    void.scrollFactor.set();
    add(void);
}