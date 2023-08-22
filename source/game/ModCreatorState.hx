package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.ui.FlxUIInputText;
import flixel.text.FlxText;
import haxe.Json;
import modding.Mods;
import sys.FileSystem;
import sys.io.File;

class ModCreatorState extends FlxState
{
	var modNameInput:FlxUIInputText;
	var modVersionInput:FlxUIInputText;
	var modDescriptionInput:FlxUIInputText;
	var createModButton:FlxText;
	var backButton:FlxText;
	var selectedButton:Int = 0;

	override public function create():Void
	{
		var ModCreatorText:FlxText = new FlxText(FlxG.width * 0.5 - 200, FlxG.height * 0.2, 400, "Mod Creator");
		ModCreatorText.setFormat(null, 32, 0xFFFFFF, "center");
		add(ModCreatorText);

		modNameInput = new FlxUIInputText(FlxG.width * 0.42, FlxG.height * 0.33, 200, "Mod Name");
		add(modNameInput);

		modVersionInput = new FlxUIInputText(FlxG.width * 0.42, FlxG.height * 0.43, 200, "Version");
		add(modVersionInput);

		modDescriptionInput = new FlxUIInputText(FlxG.width * 0.42, FlxG.height * 0.53, 200, "Description");
		add(modDescriptionInput);

		createModButton = new FlxText(FlxG.width * 0.45, FlxG.height * 0.6, 120, "Create Mod");
		createModButton.setFormat(null, 24, (selectedButton == 0) ? 0xFFFF00 : 0xFFFFFF, "center");
		add(createModButton);

		backButton = new FlxText(FlxG.width * 0.443, FlxG.height * 0.7, 140, "Back to Mod List");
		backButton.setFormat(null, 24, (selectedButton == 1) ? 0xFFFF00 : 0xFFFFFF, "center");
		add(backButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedButton = (selectedButton + 1) % 2;
			updateButtonColors();
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedButton = (selectedButton - 1 + 2) % 2;
			updateButtonColors();
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedButton == 0)
			{
				createMod();
			}
			else if (selectedButton == 1)
			{
				FlxG.switchState(new game.ModState());
			}
		}

		super.update(elapsed);
	}

	function updateButtonColors():Void
	{
		createModButton.color = (selectedButton == 0) ? 0xFFFF00 : 0xFFFFFF;
		backButton.color = (selectedButton == 1) ? 0xFFFF00 : 0xFFFFFF;
	}

	function createMod():Void
	{
		var modName:String = modNameInput.text;
		var modVersion:String = modVersionInput.text;
		var modDescription:String = modDescriptionInput.text;

		var modJson:ModJson = {
			name: modName,
			version: modVersion,
			description: modDescription
		};

		var modPath:String = Mods.modDirectory + modName;
		FileSystem.createDirectory(modPath);
		var jsonContent:String = Json.stringify(modJson, null);
		File.saveContent(modPath + "/mod.json", jsonContent);

		FlxG.switchState(new game.MenuState());
	}
}
