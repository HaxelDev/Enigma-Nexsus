package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class IntroState extends FlxState
{
	var titleText:FlxText;
	var pressEnterText:FlxText;
	var hasTransitioned:Bool = false;

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.4, FlxG.width, "Enigma Nexsus");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		pressEnterText = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Press Enter to Continue");
		pressEnterText.setFormat(null, 24, 0xFFFFFF, "center");
		add(pressEnterText);

		FlxG.camera.flash(0xFF000000, 1, null, false);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (!hasTransitioned && FlxG.keys.justPressed.ENTER)
		{
			hasTransitioned = true;
			FlxG.camera.flash(0xFFFFFFFF, 1.5, onFadeComplete, false);
			FlxTween.tween(titleText, {alpha: 0}, 1.5, {ease: FlxEase.expoInOut});
			FlxTween.tween(pressEnterText, {alpha: 0}, 1.5, {ease: FlxEase.expoInOut});
		}

		super.update(elapsed);
	}

	public function onFadeComplete():Void
	{
		FlxG.switchState(new game.MenuState());
	}
}
