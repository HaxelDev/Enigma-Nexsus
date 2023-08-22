package modding;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import sys.FileSystem;
import sys.io.File;

class Script
{
	public var script:Expr;
	public var interp:Interp;
	public var parser:Parser;

	public function new(scriptName:String)
	{
		interp = new Interp();
		parser = new Parser();

		parser.allowTypes = true;
		parser.allowJSON = true;
		parser.allowMetadata = true;

		var scriptFilePath:String = game.AssetsPaths.getPath("data/" + scriptName + ".hx");
		if (FileSystem.exists(scriptFilePath))
		{
			var scriptCode:String = File.getContent(scriptFilePath);
			script = parser.parseString(scriptCode);

			if (script != null)
			{
				setVariables();
			}
			else
			{
				trace("Script parsing error.");
			}
		}
		else
		{
			trace("Script file not found: " + scriptFilePath);
		}
	}

	public function setVariables():Void
	{
		interp.variables.set("FlxG", flixel.FlxG);
		interp.execute(script);
	}

	public function call(functionName:String, ?args:Array<Dynamic>)
	{
		var ret = null;
		if (interp.variables.exists(functionName))
		{
			var func = interp.variables.get(functionName);
			if (args == null || args.length == 0)
			{
				try
				{
					ret = func();
				}
				catch (e:Dynamic)
				{
					trace("Error calling on HScript (no arguments)");
				}
			}
			else
			{
				try
				{
					ret = Reflect.callMethod(null, func, args);
				}
				catch (e:Dynamic)
				{
					trace("Error calling on HScript (arguments)");
				}
			}
		}
		return ret;
	}
}
