package modding;

import hscript.InterpEx;
import hscript.ParserEx;

class ScriptClass
{
	public var interp:InterpEx;
	public var parser:ParserEx;
	public var instance:Dynamic;

	public function new(name:String, contents:String)
	{
		interp = new InterpEx();
		parser = new ParserEx();

		instance = interp.createScriptClassInstance(name);
		interp.registerModule(parser.parseModule(game.AssetsPaths.getPath("data/" + contents + ".hx")));

		instance.create();
	}
}
