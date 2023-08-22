package modding;

import haxe.Resource;
import hscript.InterpEx;

class ScriptClass
{
	public var interp:InterpEx;

	public function new(name:String, contents:String)
	{
		interp = new InterpEx();
		var instance = interp.createScriptClassInstance(name);
		interp.addModule(Resource.getString(game.AssetsPaths.getPath("data/" + contents + ".hx")));
		instance.create();
	}
}
