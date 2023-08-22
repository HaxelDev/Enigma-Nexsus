package storymode;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class NamingState extends FlxState
{
	var titleText:FlxText;
	var nameLabel:FlxText;
	var nameInput:FlxText;
	var confirmButton:FlxText;

	public static var heroName:String = "";

	override public function create():Void
	{
		titleText = new FlxText(0, FlxG.height * 0.2, FlxG.width, "Your Name");
		titleText.setFormat(null, 48, 0xFFFFFF, "center");
		add(titleText);

		nameLabel = new FlxText(0, FlxG.height * 0.4, FlxG.width, "Enter a name:");
		nameLabel.setFormat(null, 32, 0xFFFFFF, "center");
		add(nameLabel);

		nameInput = new FlxText(FlxG.width * 0.4, FlxG.height * 0.5, FlxG.width, "");
		nameInput.setFormat(null, 32, 0xFFFFFF, "left");
		add(nameInput);

		confirmButton = new FlxText(0, FlxG.height * 0.7, FlxG.width, "Press Enter to Continue");
		confirmButton.setFormat(null, 32, 0xFFFFFF, "center");
		add(confirmButton);

		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			FlxG.switchState(new storymode.StoryState());
		}

		if (FlxG.keys.justPressed.A)
		{
			heroName += "A";
		}
		if (FlxG.keys.justPressed.B)
		{
			heroName += "B";
		}
		if (FlxG.keys.justPressed.C)
		{
			heroName += "C";
		}
		if (FlxG.keys.justPressed.D)
		{
			heroName += "D";
		}
		if (FlxG.keys.justPressed.E)
		{
			heroName += "E";
		}
		if (FlxG.keys.justPressed.F)
		{
			heroName += "F";
		}
		if (FlxG.keys.justPressed.G)
		{
			heroName += "G";
		}
		if (FlxG.keys.justPressed.H)
		{
			heroName += "H";
		}
		if (FlxG.keys.justPressed.I)
		{
			heroName += "I";
		}
		if (FlxG.keys.justPressed.J)
		{
			heroName += "J";
		}
		if (FlxG.keys.justPressed.K)
		{
			heroName += "K";
		}
		if (FlxG.keys.justPressed.L)
		{
			heroName += "L";
		}
		if (FlxG.keys.justPressed.M)
		{
			heroName += "M";
		}
		if (FlxG.keys.justPressed.N)
		{
			heroName += "N";
		}
		if (FlxG.keys.justPressed.O)
		{
			heroName += "O";
		}
		if (FlxG.keys.justPressed.P)
		{
			heroName += "P";
		}
		if (FlxG.keys.justPressed.Q)
		{
			heroName += "Q";
		}
		if (FlxG.keys.justPressed.R)
		{
			heroName += "R";
		}
		if (FlxG.keys.justPressed.S)
		{
			heroName += "S";
		}
		if (FlxG.keys.justPressed.T)
		{
			heroName += "T";
		}
		if (FlxG.keys.justPressed.U)
		{
			heroName += "U";
		}
		if (FlxG.keys.justPressed.V)
		{
			heroName += "V";
		}
		if (FlxG.keys.justPressed.W)
		{
			heroName += "W";
		}
		if (FlxG.keys.justPressed.X)
		{
			heroName += "X";
		}
		if (FlxG.keys.justPressed.Y)
		{
			heroName += "Y";
		}
		if (FlxG.keys.justPressed.Z)
		{
			heroName += "Z";
		}
		if (FlxG.keys.justPressed.SPACE)
		{
			heroName += " ";
		}

		if (FlxG.keys.justPressed.BACKSPACE && heroName.length > 0)
		{
			heroName = heroName.substr(0, heroName.length - 1);
		}

		updateNameText();

		super.update(elapsed);
	}

	function updateNameText():Void
	{
		nameInput.text = heroName;
	}
}
