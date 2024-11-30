function createPost() {
    camHUD.alpha = 0.15;
    defaultCamZoom = 2;
    dad.playAnim("intro");
}

function intro2() {
    dad.playAnim("intro2");
    dad.animation.finishCallback = function(animName) {
        defaultCamZoom = 1.15;
        dad.animation.finishCallback = function(animName){};    
    };
    FlxTween.tween(camHUD, {alpha: 1}, 1.5);
}