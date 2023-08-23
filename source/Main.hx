package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		testScriptClass();
		modding.Mods.loadMods();
		addChild(new FlxGame(1280, 720, game.IntroState));
	}

	function testScriptClass()
	{
		if (sys.FileSystem.exists(game.AssetsPaths.getPath("data/MyClass.hx")))
		{
			var scriptClass:modding.ScriptClass = new modding.ScriptClass("MyClass", "MyClass");
			scriptClass.createFunction();
		}
	}
}
