function onPsychEvent(event:String, v1:Dynamic, v2:Dynamic) {
    switch(event) {
        case "Play Animation":
            switch (v2) {
                case "bf", "boyfriend":
                    boyfriends[0].playAnim(v1, true);
                case "gf", "girlfriend":
                    gf.playAnim(v1, true);
                default:
                    dads[0].playAnim(v1, true);
            }
        case "Change Character":
            if (v1 == "dad")
                changeDad(mod + ":" + v2);
    }
}