package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		modding.Mods.loadMods();
		addChild(new FlxGame(1280, 720, game.IntroState));
	}
}
