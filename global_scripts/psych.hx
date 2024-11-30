import flixel.math.FlxMath;

if (FlxG.save.data.psychUI) {
	var ratingStuff:Array<Dynamic> = [
		['You Suck!', 0.2], // From 0% to 19%
		['Shit', 0.4], // From 20% to 39%
		['Bad', 0.5], // From 40% to 49%
		['Bruh', 0.6], // From 50% to 59%
		['Meh', 0.69], // From 60% to 68%
		['Nice', 0.7], // 69%
		['Good', 0.8], // From 70% to 79%
		['Great', 0.9], // From 80% to 89%
		['Sick!', 1], // From 90% to 99%
		['Perfect!!', 1] // The value on this one isn't used actually, since Perfect is always "1"
	];
	function createPost() {
		scoreTxt.y = healthBarBG.y + 36;
		scoreTxt.size = 20;
		scoreTxt.borderSize = 1.25;

		timerNow.size = 32;

		timerBar.createFilledBar(0xff000000, 0xffff0000);

		for (obj in [timerBG, timerBar])
			obj.y += 20;

		for (fuckYou in [timerText, timerFinal])
			fuckYou.kill();
	}
	function update(elapsed) {
		timerNow.screenCenter(FlxAxes.X);
		timerNow.y -= 2;

		scoreTxt.text = "Score: " + songScore + " | Misses: " + misses + " | Rating: " + accuracyFormatFuck();
	}
	function accuracyFormatFuck() { // imma be fr idk what half this acc code is dawg
		var sicks:Int = hits["Sick"];
		var goods:Int = hits["Good"];
		var bads:Int = hits["Bad"];
		var shits:Int = hits["Shit"];

		var ratingLol = "";
		if (misses == 0) {
			if (bads > 0 || shits > 0)
				ratingLol = 'FC';
			else if (goods > 0)
				ratingLol = 'GFC';
			else if (sicks > 0)
				ratingLol = 'SFC';
		} else {
			if (misses < 10)
				ratingLol = 'SDCB';
			else
				ratingLol = 'Clear';
		}

		var accuracyFloat:Float = 0;

		for (rat in ratings) {
			accuracyFloat += hits[rat.name] * rat.accuracy;
		}

		return (numberOfNotes == 0 ? "0" : FlxMath.roundDecimal(accuracyFloat / numberOfArrowNotes * 100, 2)) + "% [" + ratingLol + "]";
	}
}