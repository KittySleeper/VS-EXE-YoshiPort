import("LoadingState");

var crafterEngineLogo:FlxSprite = null;

function create() {
    if (FlxG.save.data.psychUI == null)
        FlxG.switchState(new ModState("PsychUI"));

    crafterEngineLogo = new FlxSprite();
    crafterEngineLogo.frames = Paths.getSparrowAtlas('titlescreen/logoBumpin');
    crafterEngineLogo.animation.addByPrefix('bump', 'logo bumpin', 24);
    crafterEngineLogo.animation.play('bump');
    crafterEngineLogo.updateHitbox();
    crafterEngineLogo.screenCenter();
    add(crafterEngineLogo);
}