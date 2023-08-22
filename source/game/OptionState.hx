package game;

import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.text.FlxText;
import flixel.util.FlxSave;

class OptionState extends FlxState
{
	var titleText:FlxText;
	var backButton:FlxText;
	var optionTexts:Array<FlxText>;
	var selectedOption:Int = 0;
	var options:Array<String> = ["Sound", "Graphics", "Controls", "Back to Menu"];

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Options");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		optionTexts = new Array<FlxText>();

		for (i in 0...options.length)
		{
			var optionText = new FlxText(FlxG.width * 0.5 - 100, FlxG.height * 0.4 + i * 40, 200, options[i]);
			optionText.setFormat(null, 24, 0xFFFFFF, "center");
			optionTexts.push(optionText);
			add(optionText);
		}

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedOption = (selectedOption + 1) % options.length;
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedOption = (selectedOption - 1 + options.length) % options.length;
		}

		for (i in 0...optionTexts.length)
		{
			optionTexts[i].color = (selectedOption == i) ? 0xFFFF00 : 0xFFFFFF;
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedOption == 0)
			{
				FlxG.switchState(new SoundState());
			}
			if (selectedOption == 1)
			{
				FlxG.switchState(new GraphicState());
			}
			if (selectedOption == 2)
			{
				FlxG.switchState(new ControlState());
			}
			if (selectedOption == 3)
			{
				FlxG.switchState(new game.MenuState());
			}
		}

		super.update(elapsed);
	}
}

class SoundState extends FlxState
{
	var titleText:FlxText;
	var volumeOption:FlxText;
	var backButton:FlxText;
	var selectedOption:Int = 0;

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Sound");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		volumeOption = new FlxText(FlxG.width * 0.5 - 100, FlxG.height * 0.4, 200, "Volume: " + Math.round(FlxG.sound.volume * 10) + "%");
		volumeOption.setFormat(null, 32, 0xFFFFFF, "center");
		add(volumeOption);

		backButton = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Back to Options");
		backButton.setFormat(null, 32, 0xFFFFFF, "center");
		add(backButton);

		saveVolume();

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedOption = (selectedOption + 1) % 2;
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedOption = (selectedOption - 1 + 2) % 2;
		}

		if (selectedOption == 0)
		{
			volumeOption.color = 0xFFFF00;
		}
		else
		{
			volumeOption.color = 0xFFFFFF;
		}

		backButton.color = (selectedOption == 1) ? 0xFFFF00 : 0xFFFFFF;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedOption == 1)
			{
				saveVolume();
				FlxG.switchState(new OptionState());
			}
		}

		if (selectedOption == 0)
		{
			if (FlxG.keys.justPressed.RIGHT)
			{
				if (FlxG.sound.volume + 0.1 <= 1.0)
				{
					FlxG.sound.volume += 0.1;
					updateVolumeText();
				}
			}
			else if (FlxG.keys.justPressed.LEFT)
			{
				if (FlxG.sound.volume - 0.1 >= 0.0)
				{
					FlxG.sound.volume -= 0.1;
					updateVolumeText();
				}
			}
		}

		super.update(elapsed);
	}

	function saveVolume():Void
	{
		FlxG.save.data.mute = FlxG.sound.muted;
		FlxG.save.data.volume = FlxG.sound.volume;
		FlxG.save.flush();
	}

	function updateVolumeText():Void
	{
		volumeOption.text = "Volume: " + Math.round(FlxG.sound.volume * 10) + "%";
	}
}

class GraphicState extends FlxState
{
	var titleText:FlxText;
	var graphicOption:FlxText;
	var backButton:FlxText;
	var selectedOption:Int = 0;
	var save:FlxSave;

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Graphics");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		graphicOption = new FlxText(FlxG.width * 0.5 - 100, FlxG.height * 0.4, 200, "Graphic Quality: High");
		graphicOption.setFormat(null, 32, 0xFFFFFF, "center");
		add(graphicOption);

		backButton = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Back to Options");
		backButton.setFormat(null, 32, 0xFFFFFF, "center");
		add(backButton);

		save = new FlxSave();
		save.bind("graphic_save");

		var savedQuality:String = save.data.quality;
		if (savedQuality == "low")
		{
			FlxG.stage.quality = flash.display.StageQuality.LOW;
			graphicOption.text = "Graphic Quality: Low";
		}
		else
		{
			FlxG.stage.quality = flash.display.StageQuality.HIGH;
			graphicOption.text = "Graphic Quality: High";
		}

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedOption = (selectedOption + 1) % 2;
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedOption = (selectedOption - 1 + 2) % 2;
		}

		if (selectedOption == 0)
		{
			graphicOption.color = 0xFFFF00;
		}
		else
		{
			graphicOption.color = 0xFFFFFF;
		}

		backButton.color = (selectedOption == 1) ? 0xFFFF00 : 0xFFFFFF;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedOption == 1)
			{
				saveGraphicQuality();
				FlxG.switchState(new OptionState());
			}
		}

		if (selectedOption == 0)
		{
			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.LEFT)
			{
				toggleGraphicQuality();
			}
		}

		super.update(elapsed);
	}

	function toggleGraphicQuality():Void
	{
		if (FlxG.stage.quality == flash.display.StageQuality.HIGH)
		{
			FlxG.stage.quality = flash.display.StageQuality.LOW;
			graphicOption.text = "Graphic Quality: Low";
		}
		else
		{
			FlxG.stage.quality = flash.display.StageQuality.HIGH;
			graphicOption.text = "Graphic Quality: High";
		}
	}

	function saveGraphicQuality():Void
	{
		if (FlxG.stage.quality == flash.display.StageQuality.LOW)
		{
			save.data.quality = "low";
		}
		else
		{
			save.data.quality = "high";
		}
		save.flush();
	}
}

class ControlState extends FlxState
{
	var titleText:FlxText;
	var controlOptions:Array<FlxText> = new Array<FlxText>();
	var backButton:FlxText;
	var selectedOption:Int = 0;
	var options:Array<String> = ["Up", "Left", "Down", "Right"];
	var defaultKeys:Array<String> = ["Up", "Left", "Down", "Right"];
	var keys:Array<String> = [
		FlxG.save.data.up,
		FlxG.save.data.left,
		FlxG.save.data.down,
		FlxG.save.data.right
	];
	var keyLabels:Array<FlxText> = new Array<FlxText>();

	override public function create():Void
	{
		for (i in 0...keys.length)
		{
			var k = keys[i];
			if (k == null)
				keys[i] = defaultKeys[i];
		}

		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Controls");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		for (i in 0...options.length)
		{
			var optionText:FlxText = new FlxText(FlxG.width * 0.25, FlxG.height * 0.4 + i * 40, FlxG.width * 0.4, options[i]);
			optionText.setFormat(null, 24, (i == selectedOption) ? 0xFFFF00 : 0xFFFFFF, "center");
			controlOptions.push(optionText);
			add(optionText);

			var keyLabel:FlxText = new FlxText(FlxG.width * 0.35, FlxG.height * 0.4 + i * 40, FlxG.width * 0.4, keys[i]);
			keyLabel.setFormat(null, 24, 0xFFFFFF, "center");
			keyLabels.push(keyLabel);
			add(keyLabel);
		}

		backButton = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Back to Options");
		backButton.setFormat(null, 32, 0xFFFFFF, "center");
		add(backButton);

		saveControlKeys();

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		{
			selectedOption = (selectedOption + 1) % (options.length + 1);
		}
		else if (FlxG.keys.justPressed.UP)
		{
			selectedOption = (selectedOption - 1 + (options.length + 1)) % (options.length + 1);
		}

		for (i in 0...controlOptions.length)
		{
			controlOptions[i].color = (i == selectedOption) ? 0xFFFF00 : 0xFFFFFF;
		}

		backButton.color = (selectedOption == options.length) ? 0xFFFF00 : 0xFFFFFF;

		if (FlxG.keys.justPressed.ENTER)
		{
			if (selectedOption == options.length)
			{
				saveControlKeys();
				FlxG.switchState(new OptionState());
			}
			else
			{
				keyLabels[selectedOption].text = "Press Key...";
				FlxG.stage.addEventListener(openfl.events.KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}

		super.update(elapsed);
	}

	public function onKeyDown(event:openfl.events.KeyboardEvent):Void
	{
		if (selectedOption < options.length)
		{
			var key:String = getKeyName(event.keyCode);
			keys[selectedOption] = key;
			keyLabels[selectedOption].text = key;
			FlxG.stage.removeEventListener(openfl.events.KeyboardEvent.KEY_DOWN, onKeyDown);
			saveControlKeys();
		}
	}

	public static function getKeyName(keyCode:Int):String
	{
		switch (keyCode)
		{
			case 38:
				return "Up";
			case 37:
				return "Left";
			case 40:
				return "Down";
			case 39:
				return "Right";
			default:
				return String.fromCharCode(keyCode);
		}
	}

	public function saveControlKeys():Void
	{
		FlxG.save.data.up = keys[0];
		FlxG.save.data.left = keys[1];
		FlxG.save.data.down = keys[2];
		FlxG.save.data.right = keys[3];
		FlxG.save.flush();
	}
}
