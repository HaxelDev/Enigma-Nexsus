package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import modding.Mods;

class ModState extends FlxState
{
	var modListText:FlxText;
	var modInfoText:FlxText;
	var backButton:FlxText;
	var selectedModIndex:Int = 0;
	var mods:Array<ModJson>;

	override public function create():Void
	{
		modListText = new FlxText(FlxG.width * 0.5 - 200, FlxG.height * 0.2, 400, "Mod List");
		modListText.setFormat(null, 32, 0xFFFFFF, "center");
		add(modListText);

		modInfoText = new FlxText(FlxG.width * 0.5 - 200, FlxG.height * 0.4, 400, "");
		modInfoText.setFormat(null, 24, 0xFFFFFF, "center");
		add(modInfoText);

		backButton = new FlxText(FlxG.width * 0.5 - 100, FlxG.height * 0.7, 200, "Back to Menu");
		backButton.setFormat(null, 24, 0xFFFFFF, "center");
		add(backButton);

		mods = Mods.mods;
		showModInfo();

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedModIndex = (selectedModIndex + 1) % (mods.length + 1);
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedModIndex = (selectedModIndex - 1 + (mods.length + 1)) % (mods.length + 1);
		}
		else if (FlxG.keys.justPressed.LEFT)
		{
			selectedModIndex = (selectedModIndex - 1 + (mods.length + 1)) % (mods.length + 1);
			if (selectedModIndex == mods.length)
			{
				selectedModIndex = mods.length - 1;
			}
			showModInfo();
		}
		else if (FlxG.keys.justPressed.RIGHT)
		{
			selectedModIndex = (selectedModIndex + 1) % (mods.length + 1);
			if (selectedModIndex == mods.length)
			{
				selectedModIndex = 0;
			}
			showModInfo();
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedModIndex < mods.length)
			{
				// showModInfo();
			}
			else
			{
				FlxG.switchState(new game.MenuState());
			}
		}

		if (selectedModIndex < mods.length)
		{
			modInfoText.color = 0xFFFF00;
			backButton.color = 0xFFFFFF;
		}
		else
		{
			modInfoText.color = 0xFFFFFF;
			backButton.color = 0xFFFF00;
		}

		super.update(elapsed);
	}

	function showModInfo():Void
	{
		if (mods.length > 0)
		{
			if (selectedModIndex < mods.length)
			{
				var mod:ModJson = mods[selectedModIndex];
				modInfoText.text = mod.name + "\nVersion: " + mod.version + "\nDescription: " + mod.description;
			}
		}
		else
		{
			modInfoText.text = "No mods found.";
		}
	}
}
