function onPsychEvent(event:String, v1:Dynamic, v2:Dynamic) {
    switch(event) {
        case "Play Animation":
            switch (v2) {
                case "bf", "boyfriend", "1":
                    boyfriends[0].playAnim(v1, true);
                case "gf", "girlfriend":
                    gf.playAnim(v1, true);
                default:
                    dads[0].playAnim(v1, true);
            }
        case "Change Character":
            if (v1 == "dad" || v1 == "1")
                changeDad(mod + ":" + v2);
    }
}