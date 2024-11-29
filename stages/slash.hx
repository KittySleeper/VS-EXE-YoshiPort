var bgShit = [];

function create() {
    gf.kill();
    defaultCamZoom = 0.6;

    var slashBg = new FlxSprite(560, 500).loadGraphic(Paths.image("stages/slash/slashBackground"));
    slashBg.antialiasing = false;
    slashBg.scale.set(8.5, 8.5);
    slashBg.scrollFactor.set(1, 0.9);
    bgShit.push(slashBg);
    add(slashBg);

    var slashAssCracks = new FlxSprite(260, 500);
    slashAssCracks.frames = Paths.getSparrowAtlas('stages/slash/slashCracks');
    slashAssCracks.animation.addByPrefix('ass', 'sl4sh background crack eyes', 12);
    slashAssCracks.animation.play('ass');
    slashAssCracks.antialiasing = false;
    slashAssCracks.scale.set(6.7, 6.7);
    slashAssCracks.scrollFactor.set(1, 0.9);
    bgShit.push(slashAssCracks);
    add(slashAssCracks);

    var slashFloor = new FlxSprite(560, 500).loadGraphic(Paths.image("stages/slash/slashFloor"));
    slashFloor.antialiasing = false;
    slashFloor.scale.set(8.5, 8.5);
    slashFloor.scrollFactor.set(1, 0.9);
    bgShit.push(slashFloor);
    add(slashFloor);

    var slashLava = new FlxSprite(500, slashFloor.y - 50);
    slashLava.frames = Paths.getSparrowAtlas('stages/slash/slashLava');
    slashLava.animation.addByPrefix('piss', 'sl4sh background lava', 12);
    slashLava.animation.play('piss');
    slashLava.antialiasing = false;
    slashLava.scale.set(8.6, 8.6);
    slashLava.scrollFactor.set(1, 0.9);
    bgShit.push(slashLava);
    add(slashLava);
}