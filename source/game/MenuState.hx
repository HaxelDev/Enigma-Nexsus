package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var titleText:FlxText;
	var storyOption:FlxText;
	var modsOption:FlxText;
	var optionsOption:FlxText;
	var selectedOption:Int = 0;

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Main Menu");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		storyOption = new FlxText(0, FlxG.height * 0.4, FlxG.width, "Story");
		storyOption.setFormat(null, 32, 0xFFFFFF, "center");
		add(storyOption);

		modsOption = new FlxText(0, FlxG.height * 0.5, FlxG.width, "Mods");
		modsOption.setFormat(null, 32, 0xFFFFFF, "center");
		add(modsOption);

		optionsOption = new FlxText(0, FlxG.height * 0.6, FlxG.width, "Options");
		optionsOption.setFormat(null, 32, 0xFFFFFF, "center");
		add(optionsOption);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedOption = (selectedOption + 1) % 3;
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedOption = (selectedOption - 1 + 3) % 3;
		}

		storyOption.color = (selectedOption == 0) ? 0xFFFF00 : 0xFFFFFF;
		modsOption.color = (selectedOption == 1) ? 0xFFFF00 : 0xFFFFFF;
		optionsOption.color = (selectedOption == 2) ? 0xFFFF00 : 0xFFFFFF;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedOption == 0)
			{
				FlxG.switchState(new storymode.NamingState());
			}
			else if (selectedOption == 1)
			{
				// For now, I'm not adding mod support. After the beta, I will provide it.
				FlxG.switchState(new game.SoonState());
			}
			else if (selectedOption == 2)
			{
				FlxG.switchState(new game.OptionState());
			}
		}

		super.update(elapsed);
	}
}
