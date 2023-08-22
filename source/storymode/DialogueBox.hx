package storymode;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import haxe.Json;
import sys.FileSystem;
import sys.io.File;

typedef CharacterData =
{
	var name:String;
	var image:String;
	var position:Array<Int>;
	var scale:Float;
}

class DialogueCharacter extends FlxSprite
{
	public var jsonScale:Float = 1;

	public function new(characterData:CharacterData)
	{
		loadGraphic(game.AssetsPaths.getPath('images/' + characterData.image));

		x = characterData.position[0];
		y = characterData.position[1];

		if (characterData.scale != 1)
		{
			jsonScale = characterData.scale;
			setGraphicSize(Std.int(width * jsonScale));
			updateHitbox();
		}

		super();
	}
}

class DialogueBox extends FlxGroup
{
	var dialogueText:FlxText;
	var continueText:FlxText;
	var dialogueContent:Array<String>;
	var currentDialogueIndex:Int = 0;
	var characterSprite:DialogueCharacter;

	public function new()
	{
		var box:FlxSprite = new FlxSprite(FlxG.width / 2, FlxG.height / 2).loadGraphic(game.AssetsPaths.getPath('images/dial-box.png'));
		add(box);

		dialogueText = new FlxText(50, 50, 700, "");
		dialogueText.setFormat(null, 24, 0xFFFFFF, "left");
		add(dialogueText);

		continueText = new FlxText(50, 300, 700, "Press Enter to Continue");
		continueText.setFormat(null, 18, 0xFFFFFF, "center");
		add(continueText);

		super();
	}

	override public function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			showNextDialogue();
		}

		super.update(elapsed);
	}

	public function loadDialogueFromTxt(filePath:String):Void
	{
		if (FileSystem.exists(filePath))
		{
			var txtContent:String = File.getContent(filePath);
			txtContent = txtContent.split("[heroName]").join(storymode.NamingState.heroName);
			dialogueContent = txtContent.split("\n");
		}
		else
		{
			trace("Dialogue file not found: " + filePath);
		}
	}

	public function showNextDialogue():Void
	{
		if (currentDialogueIndex < dialogueContent.length)
		{
			var line:String = dialogueContent[currentDialogueIndex];
			parseDialogueLine(line);
			currentDialogueIndex++;
		}
		else
		{
			hide();
		}
	}

	public function parseDialogueLine(line:String):Void
	{
		if (line.indexOf(":char:") == 0)
		{
			var characterName:String = line.split(":")[1];
			var characterData:CharacterData = loadCharacterData(characterName);
			if (characterData != null)
			{
				dialogueText.text = characterData.name + ": " + line.split(":")[2];
				if (characterSprite != null)
				{
					remove(characterSprite);
				}
				characterSprite = new DialogueCharacter(characterData);
				add(characterSprite);
			}
		}
		else
		{
			dialogueText.text = line;
		}
	}

	public function loadCharacterData(characterName:String):CharacterData
	{
		var characterDataPath:String = game.AssetsPaths.getPath("data/dialogues/characters/" + characterName + ".json");
		if (FileSystem.exists(characterDataPath))
		{
			var jsonContent:String = File.getContent(characterDataPath);
			return Json.parse(jsonContent);
		}
		else
		{
			trace("Character data not found: " + characterDataPath);
			return null;
		}
	}

	public function hide():Void
	{
		visible = false;
	}

	public function show():Void
	{
		visible = true;
	}
}
