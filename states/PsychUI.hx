var yes;
var no;

var selected = 0;

function create() {
    var lmao = new FlxText(0, 5, FlxG.width, "DO YOU WANT TO USE THE PSYCH ENGINE\nUI", 85);
    lmao.alignment = "center";
    add(lmao);

    yes = new FlxText(200, FlxG.height * 0.75, FlxG.width, "YES", 85);
    add(yes);

    no = new FlxText(900, FlxG.height * 0.75, FlxG.width, "NO", 85);
    add(no);

    changeSelection(0);
}

function update(elapsed) {
    if (controls.LEFT_P)
        changeSelection(-1);
    if (controls.RIGHT_P)
        changeSelection(1);
    if (controls.ACCEPT) {
        FlxG.save.data.psychUI = selected == 0;
        FlxG.switchState(new TitleState());
    }
}

function changeSelection(amt) {
    selected += amt;

    if (selected > 1)
        selected = 0;
    if (selected < 0)
        selected = 1;

    if (selected == 0) {
        yes.alpha = 1;
        no.alpha = 0.25;
    }

    if (selected == 1) {
        yes.alpha = 0.25;
        no.alpha = 1;
    }
}