package storymode;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class StoryState extends FlxState
{
	var storyText:FlxText;
	var continueText:FlxText;
	var storyContent:Array<String>;
	var currentStoryIndex:Int = 0;

	override public function create():Void
	{
		storyText = new FlxText(50, FlxG.height * 0.2, FlxG.width - 100, "");
		storyText.setFormat(null, 24, 0xFFFFFF, "center");
		add(storyText);

		continueText = new FlxText(0, FlxG.height * 0.8, FlxG.width, "Press Enter to Continue");
		continueText.setFormat(null, 18, 0xFFFFFF, "center");
		add(continueText);

		storyContent = [
			"Hello, " + storymode.NamingState.heroName + "! Welcome to the world of Nexsus.",
			"You are about to embark on a grand adventure filled with mystery and danger.",
			"Your journey will test your courage, wit, and determination.",
			"May your name be forever remembered in the annals of history!",
		];

		showNextStory();

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			showNextStory();
		}

		super.update(elapsed);
	}

	function showNextStory():Void
	{
		if (currentStoryIndex < storyContent.length)
		{
			storyText.text = storyContent[currentStoryIndex];
			currentStoryIndex++;
		}
		else
		{
			FlxG.camera.flash(0xFFFFFFFF, 1.5, onFadeComplete, false);
			FlxTween.tween(storyText, {alpha: 0}, 1.5, {ease: FlxEase.expoInOut});
			FlxTween.tween(continueText, {alpha: 0}, 1.5, {ease: FlxEase.expoInOut});
		}
	}

	function onFadeComplete():Void
	{
		FlxG.switchState(new game.MenuState());
	}
}
