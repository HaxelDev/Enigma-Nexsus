package modding;

import hscript.InterpEx;

class ScriptClass
{
	public var interp:InterpEx;
	public var instance:Dynamic;

	public function new(name:String, contents:String)
	{
		interp = new InterpEx();
		instance = interp.createScriptClassInstance(name);
		interp.addModule(game.AssetsPaths.getPath("data/" + contents + ".hx"));
		setVariables();
		instance.create();
	}

	public function setVariables():Void
	{
		interp.variables.set("FlxG", flixel.FlxG);
		interp.variables.set("Mods", modding.Mods);
		interp.variables.set("Player", game.Player);
		interp.variables.set("FlxState", flixel.FlxState);
		interp.variables.set("FlxSprite", flixel.FlxSprite);
		interp.variables.set("AssetsPaths", game.AssetsPaths);
		interp.variables.set("DialogueBox", storymode.DialogueBox);
		interp.variables.set("FlxText", flixel.text.FlxText);
		interp.variables.set("FlxTilemap", flixel.tile.FlxTilemap);
		interp.variables.set("FlxEmitter", flixel.effects.particles.FlxEmitter);
		interp.variables.set("FlxSound", flixel.system.FlxSound);
	}
}
