import flixel.util.FlxStringUtil;
import flixel.text.FlxTextBorderStyle;

var pixelSongs = ["you-cant-run", "prey", "fatality", "b4cksl4sh"];
var fontListIdk = [];

if (pixelSongs.contains(PlayState.jsonSongName.toLowerCase())) {
    EngineSettings.showTimer = false;

    var scoreLol;
    var timeLol;
    var missesLol;
    var textLabels = [];

    function create() {
        if (PlayState.jsonSongName.toLowerCase() != "you-cant-run") {
            FlxG.scaleMode.width = 1280;
            FlxG.scaleMode.height = 960;
            FlxG.scaleMode.isWidescreen = false;
        }  
    }
    
    function createPost() {
        if (PlayState.jsonSongName.toLowerCase() != "you-cant-run")
            createPixelUI();
    }

    function createPixelUI() {
        scoreTxt.visible = false;

        for (healthObj in [healthBar, healthBarBG])
            healthObj.x += 200;

        var textIndex = -1;

        for (text in ["SCORE", "TIME", "MISSES"]) {
            textIndex++;

            var label = new FlxText(15, (if (EngineSettings.downscroll) 10 else FlxG.height * 0.82) + (textIndex * 55), FlxG.width, text, 55);
            label.cameras = [camHUD];
            label.setFormat(Paths.font("sonic-1-hud-font.tff"), 55, 0xFFFCFC00, null, FlxTextBorderStyle.SHADOW, 0xff000000);
            label.borderSize = 3;
            textLabels.push(label);
            add(label);
        }

        scoreLol = new FlxText(300, textLabels[0].y, FlxG.width, "0", 55);
        scoreLol.cameras = [camHUD];
        scoreLol.setFormat(Paths.font("sonic-1-hud-font.tff"), 55, 0xFFFCFCFC, null, FlxTextBorderStyle.SHADOW, 0xff000000);
        scoreLol.borderSize = 3;
        add(scoreLol);

        timeLol = new FlxText(150, textLabels[1].y, FlxG.width, "0:00", 55);
        timeLol.cameras = [camHUD];
        timeLol.setFormat(Paths.font("sonic-1-hud-font.tff"), 55, 0xFFFCFCFC, null, FlxTextBorderStyle.SHADOW, 0xff000000);
        timeLol.borderSize = 3;
        add(timeLol);

        missesLol = new FlxText(270, textLabels[2].y, FlxG.width, "0", 55);
        missesLol.cameras = [camHUD];
        missesLol.setFormat(Paths.font("sonic-1-hud-font.tff"), 55, 0xFFFCFCFC, null, FlxTextBorderStyle.SHADOW, 0xff000000);
        missesLol.borderSize = 3;
        add(missesLol);

        for (strum in playerStrums.members) {
            strum.set_notesScale(1.6);
            strum.x += (strum.ID * 45) - 65;
        }
        for (strum in cpuStrums.members) {
            strum.set_notesScale(1.5);
            strum.x += (strum.ID * 40) - 65;
        }
    }

    function destroyPixelUI() {
        scoreTxt.visible = true;

        for (healthObj in [healthBar, healthBarBG])
            healthObj.x -= 200;

        for (fuck in [scoreLol, timeLol, missesLol])
            fuck.kill();
        for (fuck in textLabels)
            fuck.kill();

        FlxG.scaleMode.width = 1280;
        FlxG.scaleMode.height = 720;
        FlxG.scaleMode.isWidescreen = true;
    }

    function update(elapsed) {
        if (scoreLol != null) {
            scoreLol.text = songScore;
            timeLol.text = if (FlxG.sound.music != null) FlxStringUtil.formatTime(FlxG.sound.music.time / 1000) else "0:00";
            missesLol.text = misses;
        }
    }

    function onPsychEvent(event:String, v1:Dynamic, v2:Dynamic) {
        switch(event) {
            case "Genesis":
                if (v1 == "1") {
                    createPixelUI();

                    FlxG.scaleMode.width = 1280;
                    FlxG.scaleMode.height = 960;
                    FlxG.scaleMode.isWidescreen = false; 
                }
                else
                    destroyPixelUI();
        }
    }

    function destroy() {
        FlxG.scaleMode.width = 1280;
        FlxG.scaleMode.height = 720;
        FlxG.scaleMode.isWidescreen = true;    
    }
}