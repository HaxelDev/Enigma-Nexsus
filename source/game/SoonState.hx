package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class SoonState extends FlxState
{
	var titleText:FlxText;
	var backButton:FlxText;

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Coming Soon!");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		backButton = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Press Enter to Back to Menu");
		backButton.setFormat(null, 32, 0xFFFFFF, "center");
		add(backButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}
