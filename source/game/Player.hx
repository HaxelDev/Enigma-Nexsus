package game;

import flixel.FlxG;
import flixel.FlxSprite;

class Player extends FlxSprite
{
	public function new(x:Float, y:Float)
	{
		super(x, y);
		makeGraphic(16, 16, 0xFFFF0000);
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y = 180;
		}
		else if (FlxG.keys.pressed.UP)
		{
			velocity.y = -180;
		}

		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x = 180;
		}
		else if (FlxG.keys.pressed.LEFT)
		{
			velocity.x = -180;
		}

		if (FlxG.keys.anyJustReleased([DOWN, UP, LEFT, RIGHT]))
		{
			velocity.set();
		}

		super.update(elapsed);
	}
}
