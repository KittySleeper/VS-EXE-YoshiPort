function onPsychEvent(event:String, v1:Dynamic, v2:Dynamic) {
    switch(event) {
        case "Play Animation":
            if (v2 == "dad" || v2 == 0 || v2 == "0")
                dad.playAnim(v1, true);
    }
}